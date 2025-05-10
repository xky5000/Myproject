module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 地图表 = require("配置.地图表").Config
local 刷新表 = require("配置.刷新表").Config
local 名字表 = require("配置.名字表").Config
local 副本逻辑 = require("副本.副本逻辑")
local 队伍管理 = require("队伍.队伍管理")

g_nCopySceneManagerID = g_nCopySceneManagerID or nil
g_nCopySceneAIID = g_nCopySceneAIID or nil

robotid = {2002,2003}

function CG_VIEWER(human, msg)
	if human.hp == 0 and msg.objid ~= -1 then
		local viewer = 对象类:GetObj(msg.objid)
		if viewer and viewer.hp > 0 and viewer.m_nSceneID ~= -1 and viewer.m_nSceneID == human.m_nSceneID then
			human.viewid = msg.objid
			human:ChangeStatus(公共定义.STATUS_DISAPPEAR)
			human:JumpScene(viewer.m_nSceneID, viewer:GetPosition())
			local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_VIEWER]
			oReturnMsg.objid = human.viewid
			消息类.SendMsg(oReturnMsg, human.id)
		end
	end
end

function CG_CREATE_ROOM(human, msg)
  human.matchcopyid = msg.copyid
  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CREATE_ROOM]
  oReturnMsg.result = 0
  消息类.SendMsg(oReturnMsg, human.id)
end

function CG_SINGLECOPY_QUERY(human, msg)
	副本逻辑.SendSingleCopyInfo(human)
end

function CG_BOSSCOPY_QUERY(human, msg)
	副本逻辑.SendBossCopyInfo(human)
end

function GetBossRelive(mapid)
	local bossinfo = 副本逻辑.BossInfo[副本逻辑.BossMonsterID[mapid]]
	return bossinfo and bossinfo.relive or 0
end

function CG_ENTER_COPYSCENE(human, msg)
	local conf = 地图表[msg.mapid]
	if not conf then
		return
	end
	if conf.maptype == 0 then
		return
	end
	if human.m_nSceneID == -1 then
		return
	end
	if human.m_db.level < conf.level then
		human:SendTipsMsg(1,"等级不足")
		return
	end
	if human.m_db.转生等级 < conf.转生等级 then
		human:SendTipsMsg(1,"转生等级不足")
		return
	end
	if human.m_db.vip等级 < conf.viplevel then
		human:SendTipsMsg(1,"VIP等级不足")
		return
	end
	if conf.humancount > 1 then
		if human.teamid == 0 or not TeamList[human.teamid] or #TeamList[human.teamid] < conf.humancount then
			human:SendTipsMsg(1,"你没有组队或队伍人数不足")
			return
		end
		if TeamList[human.teamid][1] ~= human then
			human:SendTipsMsg(1,"你不是队长,无法开启副本")
			return
		end
	end
	if #conf.costtp > 0 and human.m_db.tp < conf.costtp[1] then
		human:SendTipsMsg(1,"体力不足")
		return
	end
	if conf.maptype == 5 and human.m_db.singlecopyfinish[msg.mapid] == 1 then
		human:SendTipsMsg(1,"该主线副本已完成")
		return
	end
	if (conf.maptype == 1 or conf.maptype == 2) and conf.daycnt > 0 and (human.m_db.singlecopy[msg.mapid] or 0) >= conf.daycnt then
		human:SendTipsMsg(1,"次数不足")
		return
	end
	if conf.maptype == 3 and _CurrentOSTime() - (human.m_db.bosscopy[msg.mapid] or 0) <= GetBossRelive(msg.mapid) then
		human:SendTipsMsg(1,"BOSS已死亡")
		return
	end
	if conf.maptype == 4 and msg.mapid >= 1001 then
		for i=msg.mapid-1,1001,-1 do
			if human.m_db.singlecopyfinish[i] ~= 1 then
				human:SendTipsMsg(1,"关卡副本只能按顺序进行挑战")
				return
			end
		end
	end
	local 武神殿地图1 = Config.IS3G and 5001 or 9048
	local 武神殿地图2 = Config.IS3G and 5099 or 9085
	if conf.maptype == 3 and msg.mapid >= 武神殿地图1 and msg.mapid <= 武神殿地图2 then
		for i=msg.mapid-1,武神殿地图1,-1 do
			if not human.m_db.bosscopy[i] or _CurrentOSTime() - human.m_db.bosscopy[i] > GetBossRelive(i) then
				human:SendTipsMsg(1,"武神殿只能按顺序进行挑战")
				return
			end
		end
	end
	if human.m_nSceneID ~= -1 and 场景管理.IsCopyscene(human.m_nSceneID) then
		human:SendTipsMsg(1,"你已在副本中,请先退出")
		return
	end
	human.m_db.副本刷怪数量 = math.max(1, math.min(30, msg.刷怪数量))
	副本管理.SceneMatchList[human] = {msg.mapid, 0}
	human:SendTipsMsg(3, "正在匹配中...(0)")
  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_ENTER_COPYSCENE]
  oReturnMsg.result = 0
  消息类.SendMsg(oReturnMsg, human.id)
end

function CG_QUIT_COPYSCENE(human, msg)
	if human.m_nSceneID == -1 then
		return
	end
	if not 场景管理.IsCopyscene(human.m_nSceneID) then
		human:SendTipsMsg(1,"你不在副本中,无法退出")
		return
	end
	human.killcnt = nil
	--human:ChangeTeam(0)
	local sceneid = 场景管理.GetSceneId(human.m_db.prevMapid)
	if sceneid ~= -1 then
		human:JumpScene(sceneid, human.m_db.prevX, human.m_db.prevY)
	end
	human.autoquitscene = nil
  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_QUIT_COPYSCENE]
  oReturnMsg.result = 0
  消息类.SendMsg(oReturnMsg, human.id)
end

function CG_REFLESH_BOSS(human, msg)
	if human.hp <= 0 then
		return
	end
	if human.m_db.刷新BOSS次数 >= human.m_db.vip等级 then
		human:SendTipsMsg(1,"刷新BOSS次数已达上限")
		return
	end
	human.m_db.刷新BOSS次数 = human.m_db.刷新BOSS次数 + 1
	human.m_db.bosscopy = {}
	副本逻辑.SendBossCopyInfo(human)
end

function OnCopySceneManager(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	for sceneid,scenehumans in pairs(副本管理.SceneHumanObj) do
		local mapid = 场景管理.SceneId2ConfigMapId[sceneid]
		local mapConfig = 地图表[mapid]
		if mapConfig and mapConfig._logicfile then
			mapConfig._logicfile.OnCopySceneManager(sceneid, scenehumans)
		end
	end
end

function OnCopySceneAI(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	for sceneid,scenehumans in pairs(副本管理.SceneHumanObj) do
		local mapid = 场景管理.SceneId2ConfigMapId[sceneid]
		local mapConfig = 地图表[mapid]
		副本管理.SceneRunTime[sceneid] = (副本管理.SceneRunTime[sceneid] or 0) + 1
		local runtime = 副本管理.SceneRunTime[sceneid]
		local isfinish = false
		if mapConfig and mapConfig._logicfile then
			mapConfig._logicfile.OnCopySceneAI(sceneid, runtime)
			isfinish = mapConfig._logicfile.CheckFinish(sceneid,scenehumans)
		end
		if 副本管理.SceneLastTime[sceneid] and 副本管理.SceneLastTime[sceneid] > 0 then
			副本管理.SceneLastTime[sceneid] = 副本管理.SceneLastTime[sceneid] - 1
			if 副本管理.SceneLastTime[sceneid] == 0 then
				isfinish = true
			end
		end
		if isfinish and 副本管理.SceneRunTime[sceneid] and 副本管理.SceneRunTime[sceneid] >= 10 then
			for robot,_ in pairs(scenehumans) do
				if robot:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and robot.isrobot then
					robot:Destroy()
				end
			end
			if 副本管理.SceneBossObj[sceneid] then
				for boss,_ in pairs(副本管理.SceneBossObj[sceneid]) do
					boss:Destroy()
				end
				副本管理.SceneBossObj[sceneid] = nil
			end
			if 副本管理.SceneTowerObj[sceneid] then
				for tower,_ in pairs(副本管理.SceneTowerObj[sceneid]) do
					tower:Destroy()
				end
				副本管理.SceneTowerObj[sceneid] = nil
			end
			if 副本管理.SceneMonsterObj[sceneid] then
				for 怪物,_ in pairs(副本管理.SceneMonsterObj[sceneid]) do
					怪物:Destroy()
				end
				副本管理.SceneMonsterObj[sceneid] = nil
			end
			if 副本管理.SceneItemObj[sceneid] then
				for 物品,_ in pairs(副本管理.SceneItemObj[sceneid]) do
					物品:Destroy()
				end
				副本管理.SceneItemObj[sceneid] = nil
			end
			if 副本管理.SceneNpcObj[sceneid] then
				for npc,_ in pairs(副本管理.SceneNpcObj[sceneid]) do
					npc:Destroy()
				end
				副本管理.SceneNpcObj[sceneid] = nil
			end
			if 副本管理.SceneCostTP[sceneid] then
				_DelTimer(副本管理.SceneCostTP[sceneid], sceneid)
				副本管理.SceneCostTP[sceneid] = nil
			end
			if 副本管理.SceneLastTime[sceneid] then
				副本管理.SceneLastTime[sceneid] = nil
			end
			for robot,_ in pairs(scenehumans) do
				if robot:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and robot.hp > 0 then
					robot.autoquitscene = 10
					robot:SendTipsMsg(3, "")
					robot:SendTipsMsg(0, "#s16,等待#c00ffff,10#C秒后自动退出")
				end
			end
			print("end scene",mapid,sceneid)
			副本管理.SceneHumanObj[sceneid] = nil
			副本管理.SceneTeamObj[sceneid] = nil
			table.insert(场景管理.IdleCopySceneIds,math.random(1,#场景管理.IdleCopySceneIds+1),{sceneid, {}})
		end
	end
	--[[for sceneid,mapid in pairs(场景管理.SceneId2ConfigMapId) do
		if 副本管理.SceneHumanObj[sceneid] then--and 副本管理.GetHumanCount(sceneid) > 0 then
			副本管理.SceneRunTime[sceneid] = (副本管理.SceneRunTime[sceneid] or 0) + 1
			local runtime = 副本管理.SceneRunTime[sceneid]
			local mapConfig = 地图表[mapid]
			if mapConfig and mapConfig._logicfile then
				mapConfig._logicfile.OnCopySceneAI(sceneid, runtime)
			end
		elseif 场景管理.GetIsCopy(mapid) and 场景管理.GetSceneObjCount(sceneid, 公共定义.OBJ_TYPE_HUMAN) == 0 then
			table.insert(idlescenes,math.random(1,#idlescenes+1),{sceneid, {}})
		end
	end]]
	for human,matchtb in pairs(副本管理.SceneMatchList) do
		matchtb[2] = (matchtb[2] or 0) + 1
		human:SendTipsMsg(3, "正在匹配中...("..matchtb[2]..")")
		local idlehumans = {human}
		local mapConfig = 地图表[matchtb[1]]
		if mapConfig and mapConfig.humancount > 1 and human.teamid ~= 0 and TeamList[human.teamid] then--and #TeamList[human.teamid] < mapConfig.humancount then
			for i,v in ipairs(TeamList[human.teamid]) do
				if v ~= human then
					idlehumans[#idlehumans+1] = v
				end
			end
		end
		local matching = false
		for _,idletb in ipairs(场景管理.IdleCopySceneIds) do
			local sceneid = idletb[1]
			local mapid = 场景管理.SceneId2ConfigMapId[sceneid]
			--local mapConfig = 地图表[mapid]
			if 副本管理.SceneHumanObj[sceneid] or 场景管理.GetSceneObjCount(sceneid, 公共定义.OBJ_TYPE_HUMAN) > 0 then
			elseif mapConfig and matchtb[1] == mapid then
				if mapConfig.humancount > 1 then
					if #idletb[2] == 0 then
						matching = true
						break
					end
				else
					local idletb2 = idletb[2]
					if #idletb2 < mapConfig.humancount then
						idletb2[#idletb2+1] = human
						matching = true
						break
					end
				end
			end
		end
		if not matching then
			local sceneid = 场景管理.AppendScene(matchtb[1], idlehumans)
			print("AppendScene", matchtb[1], sceneid)
		end
	end
	for _,idletb in pairs(场景管理.IdleCopySceneIds) do
		local sceneid = idletb[1]
		local idlehumans = idletb[2]
		local mapid = 场景管理.SceneId2ConfigMapId[sceneid]
		local maxtime = 0
		for _,human in ipairs(idlehumans) do
			if 副本管理.SceneMatchList[human][2] > maxtime then
				maxtime = 副本管理.SceneMatchList[human][2]
			end
		end
		local mapConfig = 地图表[mapid]
		if mapConfig and mapConfig._logicfile and mapConfig.humancount > 0 and (#idlehumans > 0 or #idlehumans >= mapConfig.humancount or maxtime >= 15) then
			print("start scene",mapid,sceneid)
			副本管理.SceneRunTime[sceneid] = 0
			local monstername = {}
			local teamobj = {}
			for _,human in ipairs(idlehumans) do
				human:SendTipsMsg(3, "")
				human.entersceneid = sceneid
				副本管理.SceneMatchList[human] = nil
				table.insert(teamobj,math.random(1,#teamobj+1),human)
				if #mapConfig.costtp > 0 then
					human:RecoverTP(-mapConfig.costtp[1])
				end
			end
			if #mapConfig.costtp > 1 then
				副本管理.SceneCostTP[sceneid] = _AddTimer(sceneid, 计时器ID.TIMER_COPYSCENE_COSTTP,mapConfig.costtp[2]*60000,-1, 0, 0, 0)
			end
			if mapConfig.maptype == 4 and #idlehumans == 1 and idlehumans[1].m_db.singlecopyfinish[mapid] == 1 then
			elseif mapConfig.持续时间 > 0 then
				副本管理.SceneLastTime[sceneid] = mapConfig.持续时间
			end
			--[[for i=#idlehumans+1,mapConfig.humancount do
				local name = 名字表[math.random(1,#名字表)].name
				while 副本管理.SceneHumanName[name] or monstername[name] do
					name = 名字表[math.random(1,#名字表)].name
				end
				monstername[name] = name
				local robot = 怪物对象类:CreateMonster(-1, robotid[math.random(1,#robotid)], 0, 0, -1, "[AI]"..name)
				robot.isrobot = true
				robot.entersceneid = sceneid
				table.insert(teamobj,math.random(1,#teamobj+1),robot)
			end]]
			mapConfig._logicfile.StartFight(sceneid, teamobj)
		end
		--for i=#idletb[2],1,-1 do
		--	table.remove(idletb[2], i)
		--end
		实用工具.DeleteTable(idletb[2])
	end
end

function OnCopySceneCostTP(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	local sceneid = nObjID
	local scenehumans = 副本管理.SceneHumanObj[sceneid]
	if scenehumans then
		local mapid = 场景管理.SceneId2ConfigMapId[sceneid]
		local mapConfig = 地图表[mapid]
		if mapConfig and #mapConfig.costtp > 0 then
			for human,_ in pairs(scenehumans) do
				if human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
					if human.m_db.tp < mapConfig.costtp[1] then
						CG_QUIT_COPYSCENE(human)
					else
						human:RecoverTP(-mapConfig.costtp[1])
					end
				end
			end
		end
	end
end
