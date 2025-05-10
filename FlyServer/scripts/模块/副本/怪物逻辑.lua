module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 地图表 = require("配置.地图表").Config
local 刷新表 = require("配置.刷新表").Config
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local 技能逻辑 = require("技能.技能逻辑")
local 名字表 = require("配置.名字表").Config
local 聊天逻辑 = require("聊天.聊天逻辑")
local 副本逻辑 = require("副本.副本逻辑")

function LevelUpSceneObj(sceneid, obj)
end

function KillSceneObj(scene_id, obj, atker)
	local ownerid = atker.id
	if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
		ownerid = atker.ownerid
	end
	local human = 对象类:GetObj(ownerid)
	--if human and (obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or obj.isrobot) then
	--	human.killcnt = (human.killcnt or 0) + 1
	--	if human.killcnt%10 == 0 then
	--		聊天逻辑.SendSystemChat("#cff00ff,"..human:GetName().."#C连续击杀了#cffff00,"..human.killcnt.."个怪物#C,所向披靡",human.m_nSceneID)
	--	end
	--end
	if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and (obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and (obj:GetType() == 1 or obj:GetType() == 2)) then
		local mapid = 场景管理.GetMapId(obj.m_nSceneID)
		local mapconf = 地图表[mapid]
		if mapconf.maptype == 3 then
			human.m_db.bosscopy[mapid] = obj.lastdeadtime or _CurrentOSTime()
			副本逻辑.SendBossCopyInfo(human)
		elseif mapconf.maptype == 4 then
			human.m_db.bosssinglecopy[mapid] = obj.lastdeadtime or _CurrentOSTime()
			副本逻辑.SendSingleCopyInfo(human)
		end
	end
end

function SendFinishInfo(sceneid, teamid)
	local oMsg = 派发器.ProtoContainer[协议ID.GC_COPYSCENE_FINISH]
	oMsg.type = 1
	oMsg.winteam = teamid
	oMsg.score1 = 0
	oMsg.score2 = 0
	oMsg.infoLen = 0
	local teamobjs = 副本管理.SceneTeamObj[sceneid][teamid]
	local teamlist = {}
	for _, human in ipairs(teamobjs) do
		oMsg.infoLen = oMsg.infoLen + 1
		oMsg.info[oMsg.infoLen].objid = human.id
		oMsg.info[oMsg.infoLen].name = human:GetName()
		oMsg.info[oMsg.infoLen].level = human:GetLevel()
		oMsg.info[oMsg.infoLen].head = human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and tonumber(human.m_db.job..human.m_db.sex) or human:GetBodyID()
		oMsg.info[oMsg.infoLen].killcnt = (human.killcnt or 0)
		oMsg.info[oMsg.infoLen].deadcnt = 0
		oMsg.info[oMsg.infoLen].score = 0
		oMsg.info[oMsg.infoLen].teamid = teamid
		oMsg.info[oMsg.infoLen].mvp = 0
		if human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and human.m_nSceneID == sceneid then
			teamlist[#teamlist+1] = human.id
		end
	end
	if #teamlist > 0 then
		消息类.UserBroadCast(oMsg, teamlist)
	end
end

function ReliveSceneObj(scene_id, obj)
end

function OnCopySceneManager(sceneid, scenehumans)
end

function CheckFinish(sceneid,scenehumans)
	local mapid = 场景管理.SceneId2ConfigMapId[sceneid]
	local mapconf = 地图表[mapid]
	if mapconf.maptype ~= 1 and 副本管理.GetMonsterCount(sceneid,true) == 0 and 副本管理.GetBossCount(sceneid,true) == 0 then
		--SendFinishInfo(sceneid, 1)
		for human,_ in pairs(scenehumans) do
			if human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and human.m_nSceneID == sceneid and human.hp > 0 and human.m_db.singlecopyfinish[mapid] ~= 1 then
				human.m_db.singlecopyfinish[mapid] = 1
				副本逻辑.SendSingleCopyInfo(human)
				for taskid,task in pairs(human.m_db.task) do
					if task.state == 1 and task.mapid == mapid then
						Npc对话逻辑.CheckHumanTaskFinish(human, taskid)
					end
				end
			end
		end
		if 副本管理.GetItemCount(sceneid) == 0 then
			return true
		end
	end
	local lefthuman = {}
	local leftrobot = {}
	for human,_ in pairs(scenehumans) do
		if human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and human.m_nSceneID == sceneid and human.hp > 0 then
			lefthuman[#lefthuman+1] = human
		elseif human:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and human.isrobot and human.hp > 0 then
			leftrobot[#leftrobot+1] = human
		end
	end
	if #lefthuman == 0 then
		return true
	end
	return false
end

function OnCopySceneAI(sceneid, runtime)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_TIPS_MSG]
	oReturnMsg.postype = 3
	oReturnMsg.msg = ""
	if 副本管理.SceneLastTime[sceneid] and 副本管理.SceneLastTime[sceneid] > 0 then
		local min = math.floor(副本管理.SceneLastTime[sceneid] / 60)
		local sec = 副本管理.SceneLastTime[sceneid] % 60
		oReturnMsg.msg = "挑战剩余时间: #c00ff00,"..string.format("%02d: %02d", min, sec).."秒#C "
	end
	oReturnMsg.msg = oReturnMsg.msg.."剩余怪物: #c00ff00,"
		..(副本管理.GetMonsterCount(sceneid,true) + 副本管理.GetBossCount(sceneid,true)).." / "
		..(副本管理.GetMonsterCount(sceneid) + 副本管理.GetBossCount(sceneid))
	消息类.SceneBroadCast(oReturnMsg, sceneid)
end

function StartFight(sceneid, teamobj)
	副本管理.SceneTeamObj[sceneid] = {}
	local mapid = 场景管理.SceneId2ConfigMapId[sceneid]
	local mapconf = 地图表[mapid]
	local Is2DScene = 场景管理.GetIs2DScene(mapid)
	local MoveGrid = 场景管理.GetMoveGrid(mapid)
	local MoveGridRate = MoveGrid and MoveGrid[1]/MoveGrid[2] or 2
	for i,human in ipairs(teamobj) do
		--human:ChangeTeam(1)
		if not 副本管理.SceneTeamObj[sceneid][human.teamid] then
			副本管理.SceneTeamObj[sceneid][human.teamid] = {human}
		else
			副本管理.SceneTeamObj[sceneid][human.teamid][#副本管理.SceneTeamObj[sceneid][human.teamid]+1] = human
		end
		local nX, nY
		if #mapconf.bornpos == 0 then
			nX, nY = 场景管理.GetPosCanRun(sceneid)
		else
			nX = mapconf.bornpos[1] + math.random(-mapconf.bornpos[3],mapconf.bornpos[3])
			nY = mapconf.bornpos[2] + math.random(-mapconf.bornpos[3],mapconf.bornpos[3]) * (Is2DScene and 1/MoveGridRate or 1)
		end
		if MoveGrid then
			nX = math.floor(nX / MoveGrid[1]) * MoveGrid[1] + MoveGrid[1]/2
			nY = math.floor(nY / MoveGrid[2]) * MoveGrid[2] + MoveGrid[2]/2
		end
		if human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
			human.m_db.prevMapid = human.m_db.mapid
			human.m_db.prevX, human.m_db.prevY = human:GetPosition()
			human:JumpScene(sceneid, nX, nY)
			if mapconf.maptype == 1 or mapconf.maptype == 2 then
				human.m_db.singlecopy[mapid] = (human.m_db.singlecopy[mapid] or 0) + 1
			end
			副本逻辑.SendSingleCopyInfo(human)
		else
			human.bornx = nX
			human.borny = nY
			human:JumpScene(sceneid, human.bornx, human.borny)
		end
	end
	local teamleader = #teamobj > 0 and teamobj[1]
	if not teamleader or teamleader:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN then
		return
	end
	local 刷新怪物 = {}
	local 刷新BOSS = {}
	for _, conf in ipairs(刷新表) do
		if conf.mapid == mapid then
			if mapconf.maptype == 1 or conf.type ~= 1 or not 副本逻辑.BossInfo[conf.monid] then
				刷新怪物[#刷新怪物+1] = conf
			elseif mapconf.maptype ~= 4 or not teamleader.m_db.bosssinglecopy[mapid] or _CurrentOSTime() - teamleader.m_db.bosssinglecopy[mapid] > 副本逻辑.BossInfo[conf.monid].relive then
				刷新BOSS[#刷新BOSS+1]  = conf
			end
		end
	end
	if mapconf.maptype == 1 or (mapconf.maptype == 4 and teamleader.m_db.singlecopyfinish[mapid] == 1) then
		if #刷新怪物 > 0 then
			local 刷怪数量 = teamleader.m_db.副本刷怪数量 or 10
			for i=1,刷怪数量 do
				local id = i%(#刷新怪物)
				local conf = 刷新怪物[id == 0 and #刷新怪物 or id]
				local cnt = 0
				while cnt < 1 do
					local x = conf.bornpos[1] + math.random(-conf.bornpos[3], conf.bornpos[3])
					local y = conf.bornpos[2] + math.random(-conf.bornpos[3], conf.bornpos[3]) * (Is2DScene and 1/MoveGridRate or 1)
					if MoveGrid then
						x = math.floor(x / MoveGrid[1]) * MoveGrid[1] + MoveGrid[1]/2
						y = math.floor(y / MoveGrid[2]) * MoveGrid[2] + MoveGrid[2]/2
					end
					if _IsPosCanRun(sceneid, x, y) then
						CreateLuaObj(sceneid, conf.monid, x, y, conf.type == 1 and 公共定义.OBJ_TYPE_MONSTER or 公共定义.OBJ_TYPE_NPC, conf.expire)
						cnt = cnt + 1
					end
				end
			end
		end
	else
		for _, conf in ipairs(刷新怪物) do
			if conf.mapid == mapid then
				local cnt = 0
				while cnt < conf.cnt do
					local x = conf.bornpos[1] + math.random(-conf.bornpos[3], conf.bornpos[3])
					local y = conf.bornpos[2] + math.random(-conf.bornpos[3], conf.bornpos[3]) * (Is2DScene and 1/MoveGridRate or 1)
					if MoveGrid then
						x = math.floor(x / MoveGrid[1]) * MoveGrid[1] + MoveGrid[1]/2
						y = math.floor(y / MoveGrid[2]) * MoveGrid[2] + MoveGrid[2]/2
					end
					if _IsPosCanRun(sceneid, x, y) then
						CreateLuaObj(sceneid, conf.monid, x, y, conf.type == 1 and 公共定义.OBJ_TYPE_MONSTER or 公共定义.OBJ_TYPE_NPC, conf.expire)
						cnt = cnt + 1
					end
				end
			end
		end
	end
	if #刷新BOSS > 0 then
		for _, conf in ipairs(刷新BOSS) do
			if conf.mapid == mapid then
				local cnt = 0
				while cnt < conf.cnt do
					local x = conf.bornpos[1] + math.random(-conf.bornpos[3], conf.bornpos[3])
					local y = conf.bornpos[2] + math.random(-conf.bornpos[3], conf.bornpos[3]) * (Is2DScene and 1/MoveGridRate or 1)
					if MoveGrid then
						x = math.floor(x / MoveGrid[1]) * MoveGrid[1] + MoveGrid[1]/2
						y = math.floor(y / MoveGrid[2]) * MoveGrid[2] + MoveGrid[2]/2
					end
					if _IsPosCanRun(sceneid, x, y) then
						CreateLuaObj(sceneid, conf.monid, x, y, conf.type == 1 and 公共定义.OBJ_TYPE_MONSTER or 公共定义.OBJ_TYPE_NPC, conf.expire)
						cnt = cnt + 1
					end
				end
			end
		end
	end
end
