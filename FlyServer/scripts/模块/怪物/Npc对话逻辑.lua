module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local Npc表 = require("配置.Npc表").Config
local 怪物表 = require("配置.怪物表").Config
local 任务表 = require("配置.任务表").Config
local 刷新表 = require("配置.刷新表").Config
local 物品表 = require("配置.物品表").Config
local 地图表 = require("配置.地图表").Config
local 背包逻辑 = require("物品.背包逻辑")
local 宠物DB = require("宠物.宠物DB")
local 玩家事件处理 = require("玩家.事件处理")
local 物品逻辑 = require("物品.物品逻辑")
local 聊天逻辑 = require("聊天.聊天逻辑")
local Npc触发 = require("触发器.Npc触发")
local 事件触发 = require("触发器.事件触发")
local 登录触发 = require("触发器.登录触发")

function SendCloseTalkMsg()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_NPC_TALK]
	oReturnMsg.objid = -1
	oReturnMsg.bodyid = 0
	oReturnMsg.effid = 0
	oReturnMsg.desc = ""
	oReturnMsg.taskid = 0
	oReturnMsg.state = 0
	oReturnMsg.talkLen = 0
	oReturnMsg.prizeLen = 0
	消息类.SendMsg(oReturnMsg, human.id)
end

function ShowTalkInfo(human, objid, sayret, bodyid, effid)
	if sayret == nil then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_NPC_TALK]
	oReturnMsg.objid = objid
	oReturnMsg.bodyid = bodyid or 0
	oReturnMsg.effid = effid or 0
	oReturnMsg.desc = sayret
	oReturnMsg.taskid = 0
	oReturnMsg.state = 0
	oReturnMsg.talkLen = 0
	oReturnMsg.prizeLen = 0
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendCallTalkPut(human, npcobjid, npctalkid, type, callid, talk)
	if human.hp <= 0 then
		return
	end
	if type == 1 then
		human.私人变量["S"..callid] = talk or ""
	else
		human.私人变量["N"..callid] = tonumber(talk) or 0
	end
	if npcobjid == -2 then
		local call = 事件触发._M["call_"..npctalkid]
		if call then
			human:显示对话(-2,call(human))
		end
		return
	elseif npcobjid == -3 then
		local call = 登录触发._M["call_"..npctalkid]
		if call then
			human:显示对话(-3,call(human))
		end
		return
	end
	local npc = 对象类:GetObj(npcobjid)
	if npc == nil then
		return
	end
	if npc:GetObjType() ~= 公共定义.OBJ_TYPE_NPC then
		return
	end
	local npcconf = npc:GetNPCConfig()
	if npcconf == nil then
		return
	end
	if npctalkid < 0 then
		return
	end
	local call = Npc触发._M["call_"..npc.m_nNpcID.."_"..npctalkid]
	local sayret = nil
	local ret = false
	if call then
		sayret = call(human)
	end
	ShowTalkInfo(human, npcobjid, sayret, npcconf.bodyid, npcconf.effid)
end

function SendTalkInfo(human, npcobjid, npctalkid)
	if human.hp <= 0 then
		return
	end
	if npcobjid == -2 then
		local call = 事件触发._M["call_"..npctalkid]
		if call then
			human:显示对话(-2,call(human))
		end
		return
	elseif npcobjid == -3 then
		local call = 登录触发._M["call_"..npctalkid]
		if call then
			human:显示对话(-3,call(human))
		end
		return
	elseif npcobjid == -1 and npctalkid ~= 0 then
		local conf = 任务表[npctalkid]
		if not conf then
			return
		end
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_NPC_TALK]
		oReturnMsg.objid = npcobjid
		oReturnMsg.bodyid = 0
		oReturnMsg.effid = 0
		if human.m_db.task[npctalkid] ~= nil then
			oReturnMsg.desc = ReplaceTaskDesc(human, conf.desc, npctalkid)
			oReturnMsg.taskid = npctalkid
			oReturnMsg.state = human.m_db.task[npctalkid].state
			oReturnMsg.talkLen = 0
			oReturnMsg.prizeLen = 0
			for _,itemconf in ipairs(conf.prize) do
				if #itemconf >= 3 and itemconf[3] ~= 0 and human.m_db.job ~= itemconf[3] then
				elseif #itemconf >= 4 and itemconf[4] ~= 0 and human.m_db.sex ~= itemconf[4] then
				else
					local g = {pos=0,id=itemconf[1],count=itemconf[2]+human:GetLevel()*conf.levelprize,bind=itemconf[1]==公共定义.经验物品ID and 0 or 1,cd=0,grade=#itemconf >= 5 and itemconf[5] or nil,strengthen=#itemconf >= 6 and itemconf[6] or nil,wash=nil,attach=nil}
					oReturnMsg.prizeLen = oReturnMsg.prizeLen + 1
					背包逻辑.PutItemData(oReturnMsg.prize[oReturnMsg.prizeLen], 0, g, 0)
				end
			end
		else
			oReturnMsg.desc = ""
			oReturnMsg.taskid = 0
			oReturnMsg.state = 0
			oReturnMsg.talkLen = 0
			oReturnMsg.prizeLen = 0
		end
		消息类.SendMsg(oReturnMsg, human.id)
		return
	end
	local npc = 对象类:GetObj(npcobjid)
	if npc == nil then
		return
	end
	if npc:GetObjType() ~= 公共定义.OBJ_TYPE_NPC then
		return
	end
	local npcconf = npc:GetNPCConfig()
	if npcconf == nil then
		return
	end
	if npctalkid < 0 then
		return
	end
	if npc.m_nSceneID ~= human.m_nSceneID then
		return
	end
	local rx,ry = human:GetPosition()
	local nx,ny = npc:GetPosition()
	if 实用工具.GetDistance(rx,ry,nx,ny,human.Is2DScene,human.MoveGridRate) > 300 then
		human:SendTipsMsg(1,"距离太远")
		return
	end
	human:StopMove()
	human.opennpcobjid = npcobjid
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_NPC_TALK]
	oReturnMsg.objid = npcobjid
	oReturnMsg.bodyid = npcconf.bodyid
	oReturnMsg.effid = npcconf.effid
	if npctalkid == 0 and human.m_db.task[human.m_db.currtaskid] ~= nil then
		local state = human.m_db.task[human.m_db.currtaskid].state
		local conf = 任务表[human.m_db.currtaskid]
		if conf and state ~= 3 then
			local refconf = 刷新表[state == 2 and conf.finishid or conf.acceptid]
			if refconf and npc.m_nNpcID == refconf.monid and 场景管理.GetMapId(npc.m_nSceneID) == refconf.mapid then
				npctalkid = human.m_db.currtaskid
			end
		end
	end
	local call = Npc触发._M["call_"..npc.m_nNpcID.."_"..npctalkid]
	local sayret = nil
	local ret = false
	if call then
		sayret = call(human)
	end
	
	if (npctalkid == 0 and not call) or sayret then
		oReturnMsg.desc = sayret or ReplaceNpcDesc(human, npcconf.desc, npc.m_nNpcID)
		oReturnMsg.taskid = 0
		oReturnMsg.state = 0
		oReturnMsg.talkLen = 0
		oReturnMsg.prizeLen = 0
		for taskid,task in pairs(human.m_db.task) do
			local conf = 任务表[taskid]
			if conf and task.state ~= 3 then
				local refconf = 刷新表[task.state == 2 and conf.finishid or conf.acceptid]
				if refconf and npc.m_nNpcID == refconf.monid and 场景管理.GetMapId(npc.m_nSceneID) == refconf.mapid then
					oReturnMsg.talkLen = oReturnMsg.talkLen + 1
					oReturnMsg.talk[oReturnMsg.talkLen].talk = conf.name
					oReturnMsg.talk[oReturnMsg.talkLen].color = 0x00ff00
					oReturnMsg.talk[oReturnMsg.talkLen].talkid = taskid
				end
			end
		end
		for i,talkconf in ipairs(npcconf.func) do
			oReturnMsg.talkLen = oReturnMsg.talkLen + 1
			oReturnMsg.talk[oReturnMsg.talkLen].talk = talkconf[1]
			oReturnMsg.talk[oReturnMsg.talkLen].color = 0xff00ff
			oReturnMsg.talk[oReturnMsg.talkLen].talkid = talkconf[2]--i
		end
	--elseif npctalkid <= #npcconf.func then
	elseif npctalkid <= 100 then
		if not call then--and Config.ISZY then
			ret = Npc对话(human, npc.m_nNpcID, npctalkid)
		end
		if ret then
			SendTalkInfo(human, npcobjid, 0)
		end
		return
	elseif human.m_db.task[npctalkid] ~= nil then
		local conf = 任务表[npctalkid]
		if conf then
			oReturnMsg.desc = ReplaceTaskDesc(human, conf.desc, npctalkid)
			oReturnMsg.taskid = npctalkid
			oReturnMsg.state = human.m_db.task[npctalkid].state
			oReturnMsg.talkLen = 0
			oReturnMsg.prizeLen = 0
			
			if(npctalkid == 1001) then
				if(human.m_db.job == 1) then
					conf.prize = {{10001,5},{10004,1},}
				elseif(human.m_db.job == 2) then
					conf.prize = {{10001,5},{10005,1},}
				elseif(human.m_db.job == 3) then
					conf.prize = {{10001,5},{10007,1},}
				end
			elseif(npctalkid == 1002) then
				if(human.m_db.job == 1) then
					conf.prize = {{10001,9},{10488,1},}
				elseif(human.m_db.job == 2) then
					conf.prize = {{10001,9},{10498,1},}
				elseif(human.m_db.job == 3) then
					conf.prize = {{10001,9},{10508,1},}
				end
			elseif(npctalkid == 1003) then
				if(human.m_db.sex == 1) then
					conf.prize = {{10001,10},{10009,1},}
				else
					conf.prize = {{10001,10},{10010,1},}
				end
			end
			
			for _,itemconf in ipairs(conf.prize) do
				if #itemconf >= 3 and itemconf[3] ~= 0 and human.m_db.job ~= itemconf[3] then
				elseif #itemconf >= 4 and itemconf[4] ~= 0 and human.m_db.sex ~= itemconf[4] then
				else
					local g = {pos=0,id=itemconf[1],count=itemconf[2]+human:GetLevel()*conf.levelprize,bind=itemconf[1]==公共定义.经验物品ID and 0 or 1,cd=0,grade=#itemconf >= 5 and itemconf[5] or nil,strengthen=#itemconf >= 6 and itemconf[6] or nil,wash=nil,attach=nil}
					oReturnMsg.prizeLen = oReturnMsg.prizeLen + 1
					背包逻辑.PutItemData(oReturnMsg.prize[oReturnMsg.prizeLen], 0, g, 0)
				end
			end
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendAcceptTask(human, taskid)
	local conf = 任务表[taskid]
	if conf == nil then
		return
	end
	if conf.type == 2 and human.m_db.日常任务次数 >= 20 + human.m_db.vip等级 then
		human:SendTipsMsg(1,"次数不足")
		return
	end
	if conf.type == 3 and human.m_db.悬赏任务次数 >= 20 + human.m_db.vip等级 then
		human:SendTipsMsg(1,"次数不足")
		return
	end
	if conf.type == 4 and human.m_db.护送押镖次数 >= 2 + (human.m_db.vip等级 > 0 and 1 or 0) then
		human:SendTipsMsg(1,"次数不足")
		return
	end
	if conf.type == 5 and human.m_db.护送灵兽次数 >= 2 + (human.m_db.vip等级 > 0 and 1 or 0) then
		human:SendTipsMsg(1,"次数不足")
		return
	end
	if conf.type == 6 and human.m_db.庄园采集次数 >= 2 + (human.m_db.vip等级 > 0 and 1 or 0) then
		human:SendTipsMsg(1,"次数不足")
		return
	end
	if conf.type == 4 then
		local spiritId = CheckSpiritTask(human)
		if spiritId and human.m_db.task[spiritId].state ~= 0 then
			human:SendTipsMsg(1,"请先完成护送灵兽任务")
			return
		end
	end
	if conf.type == 5 then
		local escortId = CheckEscortTask(human)
		if escortId and human.m_db.task[escortId].state ~= 0 then
			human:SendTipsMsg(1,"请先完成护送押镖任务")
			return
		end
	end
	
	if conf.acceptid ~= 0 then
		local refconf = 刷新表[conf.acceptid]
		if refconf == nil then
			return
		end
		if human.m_db.mapid ~= refconf.mapid then
			return
		end
		local x,y = human:GetPosition()
		if 实用工具.GetDistanceSq(x,y,refconf.bornpos[1],refconf.bornpos[2],human.Is2DScene,human.MoveGridRate) > 90000 then
			human:SendTipsMsg(1,"距离太远")
			return
		end
	end
	if human.m_db.task[taskid] == nil then
		return
	end
	if human.m_db.task[taskid].state ~= 0 then
		return
	end
	if human.m_db.level < conf.level then
		human:SendTipsMsg(1,"等级不足")
		return
	end
	human.m_db.task[taskid].state = 1
	for i,func in ipairs(conf.func) do
		if func[1] == 5 then
			human.m_db.task[taskid].mapid = func[2]
		elseif func[1] == 6 then
			human.m_db.task[taskid].mapid = func[2]
			human.m_db.task[taskid].mons[0] = {func[2],func[3],0}
		elseif func[1] == 4 then
			human.m_db.task[taskid].mons[func[2]] = {0,func[3],0}
		else
			local refconf = 刷新表[ func[2] ]
			human.m_db.task[taskid].mons[refconf.monid] = {refconf.mapid,func[3],0}
		end
	end
	if (conf.type == 4 or conf.type == 5) and conf.escortid ~= 0 then
		if human.call[-1] then
			human.m_db.镖车血量 = 0
			human.m_db.镖车玩家伤害 = {}
			human.call[-1]:Destroy()
			human.call[-1] = nil
		end
		local ox,oy = human:GetPosition()
		local m = 怪物对象类:CreateMonster(-1, conf.escortid, ox, oy, human.id)
		m.teamid = human.teamid
		m:EnterScene(human.m_nSceneID, m.bornx, m.borny)
		human.call[-1] = m
		local nX, nY = 实用工具.GetRandPos(ox, oy, 200, m.Is2DScene, m.MoveGridRate)
		m:MoveTo(nX, nY)
		聊天逻辑.SendSystemChat("#cff00ff,"..human:GetName().."#C在#cffff00,"..(conf.acceptid ~= 0 and 刷新表[conf.acceptid].name or "").."#C领取了#cffff00,"..m:GetName().."#C,开始护送"..(conf.type == 4 and "押镖" or "灵兽"))
	end
	if conf.quickmove == 1 and #conf.func > 0 then
		if conf.func[1][1] == 1 or conf.func[1][1] == 2 or conf.func[1][1] == 3 then
			local refconf = 刷新表[conf.func[1][2]]
			if refconf then
				human:Transport(refconf.mapid,refconf.bornpos[1],refconf.bornpos[2])
			end
		elseif conf.func[1][1] == 6 then
			human:RandomTransport(conf.func[1][2])
		end
	end
	日志.Write(日志.LOGID_OSS_TASK, os.time(), human:GetAccount(), human:GetName(), taskid, 1)
	CheckHumanTaskFinish(human, taskid)
	SendTaskInfo(human)
end

function SendFinishTask(human, taskid)
	local conf = 任务表[taskid]
	if conf == nil then
		return
	end
	if conf.finishid ~= 0 then
		local refconf = 刷新表[conf.finishid]
		if refconf == nil then
			return
		end
		if human.m_db.mapid ~= refconf.mapid then
			return
		end
		local x,y = human:GetPosition()
		if 实用工具.GetDistanceSq(x,y,refconf.bornpos[1],refconf.bornpos[2],human.Is2DScene,human.MoveGridRate) > 90000 then
			human:SendTipsMsg(1,"距离太远")
			return
		end
	end
	if human.m_db.task[taskid] == nil then
		return
	end
	if human.m_db.task[taskid].state ~= 2 then
		return
	end
	local percnt = 1
	if (conf.type == 4 or conf.type == 5) and human.call[-1] then
		percnt = math.max(0.1, human.call[-1].hp / human.call[-1].hpMax)
		human.m_db.镖车血量 = 0
		human.m_db.镖车玩家伤害 = {}
		human.call[-1]:Destroy()
		human.call[-1] = nil
	elseif conf.type == 4 then
		percnt = 0.1
	end
	local equippos = {}
	local indexs = {}
	local prizecnt = 0
	for _,itemconf in ipairs(conf.prize) do
		if #itemconf >= 3 and itemconf[3] ~= 0 and human.m_db.job ~= itemconf[3] then
		elseif #itemconf >= 4 and itemconf[4] ~= 0 and human.m_db.sex ~= itemconf[4] then
		else
			if itemconf[1] == 公共定义.经验物品ID then
			elseif itemconf[1] == 公共定义.金币物品ID then
			elseif itemconf[1] == 公共定义.元宝物品ID then
			else
				prizecnt = prizecnt + 1
			end
		end
	end
	if prizecnt > 0 and 背包逻辑.GetEmptyIndexCount(human) < prizecnt then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	for _,itemconf in ipairs(conf.prize) do
		if #itemconf >= 3 and itemconf[3] ~= 0 and human.m_db.job ~= itemconf[3] then
		elseif #itemconf >= 4 and itemconf[4] ~= 0 and human.m_db.sex ~= itemconf[4] then
		else
			local itconf = 物品表[itemconf[1]]
			local itcnt = math.ceil(itemconf[2]*percnt+human:GetLevel()*conf.levelprize)
			if itconf.type1 == 2 and itconf.type2 == 4 then
				local index = itconf._func(human)
				if index then
					宠物DB.CallPet(human, index)
				end
			elseif itconf.type1 == 3 and itconf.type2 == 14 then
				local inds = human:PutItemGrids(itemconf[1], itcnt, 1, true)
				if inds and #inds > 0 then
					背包逻辑.InsertIndexes(indexs, inds[1])
					背包逻辑.DoEquipEndue(human, inds[1], 14, 0)
					宠物DB.CallPet(human, 1)
				end
			elseif itconf.type1 == 3 then
				local type2 = itconf.type2
				if type2 == 5 then
					if human.m_db.bagdb.equips[5] == nil or human.m_db.bagdb.equips[5].count == 0 then
					elseif human.m_db.bagdb.equips[14] == nil or human.m_db.bagdb.equips[14].count == 0 then
						type2 = 14
					elseif 物品逻辑.GetItemLevel(human.m_db.bagdb.equips[5].id) > 物品逻辑.GetItemLevel(human.m_db.bagdb.equips[14].id) then
						type2 = 14
					end
				elseif type2 == 6 then
					if human.m_db.bagdb.equips[6] == nil or human.m_db.bagdb.equips[6].count == 0 then
					elseif human.m_db.bagdb.equips[15] == nil or human.m_db.bagdb.equips[15].count == 0 then
						type2 = 15
					elseif 物品逻辑.GetItemLevel(human.m_db.bagdb.equips[6].id) > 物品逻辑.GetItemLevel(human.m_db.bagdb.equips[15].id) then
						type2 = 15
					end
				end
				local posnew = human:PutEquip(type2, itemconf[1], #itemconf >= 5 and itemconf[5] or nil, #itemconf >= 6 and itemconf[6] or nil)
				if posnew then
					背包逻辑.InsertIndexes(equippos, type2)
					if posnew ~= 0 then
						背包逻辑.InsertIndexes(indexs, posnew)
					end
				end
			else
				local inds = human:PutItemGrids(itemconf[1], itcnt, 1, true)
				if inds then
					for i,v in ipairs(inds) do
						背包逻辑.InsertIndexes(indexs, v)
					end
				end
				human:AddQuickItem(itemconf[1])
			end
			if itemconf[1] == 公共定义.经验物品ID then
				human:SendTipsMsg(2, "获得经验#cff00,"..itcnt)
			elseif itemconf[1] == 公共定义.金币物品ID then
				human:SendTipsMsg(2, "获得绑定金币#cffff00,"..itcnt)
			elseif itemconf[1] == 公共定义.元宝物品ID then
				human:SendTipsMsg(2, "获得绑定元宝#cffff00,"..itcnt)
			else
				human:SendTipsMsg(2, "获得物品"..广播.colorRgb[#itemconf >= 4 and itemconf[4] or itconf.grade]..itconf.name..(itcnt > 1 and "x"..itcnt or ""))
			end
		end
	end
	if #equippos > 0 then
		背包逻辑.SendEquipQuery(human, equippos)
	end
	if #indexs > 0 then
		背包逻辑.SendBagQuery(human, indexs)
	end
	if conf.type == 2 then
		human.m_db.日常任务次数 = human.m_db.日常任务次数 + 1
		human.m_db.task[taskid] = nil
	elseif conf.type == 3 then
		human.m_db.悬赏任务次数 = human.m_db.悬赏任务次数 + 1
		human.m_db.task[taskid] = nil
	elseif conf.type == 4 then
		human.m_db.护送押镖次数 = human.m_db.护送押镖次数 + 1
		human.m_db.task[taskid] = nil
	elseif conf.type == 5 then
		human.m_db.护送灵兽次数 = human.m_db.护送灵兽次数 + 1
		human.m_db.task[taskid] = nil
	elseif conf.type == 6 then
		human.m_db.庄园采集次数 = human.m_db.庄园采集次数 + 1
		human.m_db.task[taskid] = nil
	else
		human.m_db.task[taskid].state = 3
	end
	日志.Write(日志.LOGID_OSS_TASK, os.time(), human:GetAccount(), human:GetName(), taskid, 3)
	CheckHumanTaskAccept(human)
	SendTaskInfo(human)
end

function OnMonsterDead(怪物, atker)
	local human
	if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
		human = 对象类:GetObj(atker.ownerid)
		while human.ownerid ~= -1 do
			human = 对象类:GetObj(human.ownerid)
		end
	else
		human = atker
	end
	local master = 对象类:GetObj(怪物.ownerid)
	if master and master:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and master.call[-1] == 怪物 then
		--local escortId = CheckEscortTask(master)
		--if escortId then
		--	master.m_db.task[escortId] = nil
		--	CheckHumanTaskAccept(master)
		--end
		聊天逻辑.SendSystemChat("#cff00ff,"..master:GetName().."#C的#cffff00,"..怪物:GetName().."#C被#cffff00,"..(human and human:GetName() or "").."#C击杀了,真可怜")
	end
	if not human or human:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN then
		return
	end
	local 消灭 = 怪物:GetObjType() == 公共定义.OBJ_TYPE_COLLECT and "采集" or "消灭"
	for taskid,task in pairs(human.m_db.task) do
		if task.state == 1 then
			if task.mons[0] and task.mons[0][1] == 场景管理.GetMapId(怪物.m_nSceneID) then
				local cnt = task.mons[0][3]
				local cntmax = task.mons[0][2]
				if cnt < cntmax then
					task.mons[0][3] = cnt + 1
					if cnt + 1 == cntmax then
						CheckHumanTaskFinish(human, taskid)
						SendTaskInfo(human)
					end
				end
				human:SendTipsMsg(0, string.format("#s16,#cffff00,"..消灭.."#cff0000,%s#cffff00,(%d/%d)","任意怪物",math.min(cnt + 1,cntmax),cntmax))
			elseif task.mons[怪物.m_nMonsterID] and (task.mons[怪物.m_nMonsterID][1] == 0 or task.mons[怪物.m_nMonsterID][1] == 场景管理.GetMapId(怪物.m_nSceneID)) then
				local cnt = task.mons[怪物.m_nMonsterID][3]
				local cntmax = task.mons[怪物.m_nMonsterID][2]
				if cnt < cntmax then
					task.mons[怪物.m_nMonsterID][3] = cnt + 1
					if cnt + 1 == cntmax then
						CheckHumanTaskFinish(human, taskid)
						SendTaskInfo(human)
					end
				end
				human:SendTipsMsg(0, string.format("#s16,#cffff00,"..消灭.."#cff0000,%s#cffff00,(%d/%d)",怪物:GetName(),math.min(cnt + 1,cntmax),cntmax))
			end
		end
	end
end

function CheckHumanTaskFinish(human, taskid)
	local task = human.m_db.task[taskid]
	if not task or task.state ~= 1 then
		return
	end
	for k,v in pairs(task.mons) do
		if v[3] < v[2] then
			return
		end
	end
	if task.mapid ~= 0 then
		if 场景管理.GetIsCopy(task.mapid) and human.m_db.singlecopyfinish[task.mapid] ~= 1 then
			return
		end
	end
	task.state = 2
	local conf = 任务表[taskid]
	if conf == nil then
		return
	end
	if conf.quickmove == 1 and conf.finishid ~= 0 then
		local refconf = 刷新表[conf.finishid]
		if refconf then
			human:Transport(refconf.mapid,refconf.bornpos[1],refconf.bornpos[2])
		end
	end
end

function FillTaskType(msginfo, type, human)
	msginfo.type = type
	if type == 2 then
		msginfo.cnt = human.m_db.日常任务次数
		msginfo.cntmax = 20 + human.m_db.vip等级
	elseif type == 3 then
		msginfo.cnt = human.m_db.悬赏任务次数
		msginfo.cntmax = 20 + human.m_db.vip等级
	elseif type == 4 then
		msginfo.cnt = human.m_db.护送押镖次数
		msginfo.cntmax = 2 + (human.m_db.vip等级 > 0 and 1 or 0)
	elseif type == 5 then
		msginfo.cnt = human.m_db.护送灵兽次数
		msginfo.cntmax = 2 + (human.m_db.vip等级 > 0 and 1 or 0)
	elseif type == 6 then
		msginfo.cnt = human.m_db.庄园采集次数
		msginfo.cntmax = 2 + (human.m_db.vip等级 > 0 and 1 or 0)
	else
		msginfo.cnt = 0
		msginfo.cntmax = 0
	end
end

function CheckTaskCountFinish(human, type)
	if type == 2 then
		return human.m_db.日常任务次数 >= 20 + human.m_db.vip等级
	elseif type == 3 then
		return human.m_db.悬赏任务次数 >= 20 + human.m_db.vip等级
	elseif type == 4 then
		return human.m_db.护送押镖次数 >= 2 + (human.m_db.vip等级 > 0 and 1 or 0)
	elseif type == 5 then
		return human.m_db.护送灵兽次数 >= 2 + (human.m_db.vip等级 > 0 and 1 or 0)
	elseif type == 6 then
		return human.m_db.庄园采集次数 >= 2 + (human.m_db.vip等级 > 0 and 1 or 0)
	else
		return false
	end
end

function SendTaskInfo(human, query)
	if not human.m_db then return end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_TASK_INFO]
	oReturnMsg.query = query or 0
	oReturnMsg.infoLen = 0
	for taskid,task in pairs(human.m_db.task) do
		local conf = 任务表[taskid]
		if not conf or CheckTaskCountFinish(human, conf.type) then
		elseif task.state == 0 then
			local refconf = 刷新表[conf.acceptid]
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			oReturnMsg.info[oReturnMsg.infoLen].name = conf.name
			oReturnMsg.info[oReturnMsg.infoLen].explain = conf.explain
			oReturnMsg.info[oReturnMsg.infoLen].taskid = taskid
			oReturnMsg.info[oReturnMsg.infoLen].state = task.state
			oReturnMsg.info[oReturnMsg.infoLen].level = conf.level
			oReturnMsg.info[oReturnMsg.infoLen].objLen = 1
			FillTaskObj(oReturnMsg.info[oReturnMsg.infoLen].obj[1], 0, refconf, 0, 0)
			FillTaskType(oReturnMsg.info[oReturnMsg.infoLen], conf.type, human)
		elseif task.state == 1 then
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			oReturnMsg.info[oReturnMsg.infoLen].name = conf.name
			oReturnMsg.info[oReturnMsg.infoLen].explain = conf.explain
			oReturnMsg.info[oReturnMsg.infoLen].taskid = taskid
			oReturnMsg.info[oReturnMsg.infoLen].state = task.state
			oReturnMsg.info[oReturnMsg.infoLen].level = conf.level
			oReturnMsg.info[oReturnMsg.infoLen].objLen = #conf.func
			for i,func in ipairs(conf.func) do
				if func[1] == 5 then
					local mapconf = 地图表[func[2]]
					FillTaskMapObj(oReturnMsg.info[oReturnMsg.infoLen].obj[i], func[1], mapconf, func[2], 0, 0)
				elseif func[1] == 6 then
					local mapconf = 地图表[func[2]]
					FillTaskMapObj(oReturnMsg.info[oReturnMsg.infoLen].obj[i], func[1], mapconf, func[2], task.mons[0] and task.mons[0][3] or 0, func[3])
				elseif func[1] == 4 then
					local monconf = 怪物表[func[2]]
					FillTaskMonObj(oReturnMsg.info[oReturnMsg.infoLen].obj[i], func[1], monconf, task.mons[func[2]] and task.mons[func[2]][3] or 0, func[3])
				else
					local refconf = 刷新表[func[2]]
					FillTaskObj(oReturnMsg.info[oReturnMsg.infoLen].obj[i], func[1], refconf, task.mons[refconf.monid] and task.mons[refconf.monid][3] or 0, func[3])
				end
			end
			FillTaskType(oReturnMsg.info[oReturnMsg.infoLen], conf.type, human)
		elseif task.state == 2 then
			local refconf = 刷新表[conf.finishid]
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			oReturnMsg.info[oReturnMsg.infoLen].name = conf.name
			oReturnMsg.info[oReturnMsg.infoLen].explain = conf.explain
			oReturnMsg.info[oReturnMsg.infoLen].taskid = taskid
			oReturnMsg.info[oReturnMsg.infoLen].state = task.state
			oReturnMsg.info[oReturnMsg.infoLen].level = conf.level
			oReturnMsg.info[oReturnMsg.infoLen].objLen = 1
			FillTaskObj(oReturnMsg.info[oReturnMsg.infoLen].obj[1], 0, refconf, 0, 0)
			FillTaskType(oReturnMsg.info[oReturnMsg.infoLen], conf.type, human)
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function FillTaskObj(msginfo, type, refconf, cnt, cntmax)
	msginfo.type = type
	msginfo.name = refconf and refconf.name or ""
	msginfo.mapid = refconf and refconf.mapid or -1
	msginfo.posx = refconf and refconf.bornpos[1] or 0
	msginfo.posy = refconf and refconf.bornpos[2] or 0
	msginfo.confid = refconf and (refconf.type == 0 and Npc表[refconf.monid].bodyid or 怪物表[refconf.monid].bodyid[1]) or 0
	msginfo.cnt = cnt
	msginfo.cntmax = cntmax
end

function FillTaskMonObj(msginfo, type, monconf, cnt, cntmax)
	msginfo.type = type
	msginfo.name = monconf.name
	msginfo.mapid = 0
	msginfo.posx = 0
	msginfo.posy = 0
	msginfo.confid = monconf.bodyid[1] or 0
	msginfo.cnt = cnt
	msginfo.cntmax = cntmax
end

function FillTaskMapObj(msginfo, type, mapconf, mapid, cnt, cntmax)
	msginfo.type = type
	msginfo.name = mapconf.name
	msginfo.mapid = mapid
	msginfo.posx = 0
	msginfo.posy = 0
	msginfo.confid = 0
	msginfo.cnt = cnt
	msginfo.cntmax = cntmax
end

function CheckDailyTask(human)
	for taskid,task in pairs(human.m_db.task) do
		local conf = 任务表[taskid]
		if conf and conf.type == 2 then
			return taskid
		end
	end
end

function CheckPostTask(human)
	for taskid,task in pairs(human.m_db.task) do
		local conf = 任务表[taskid]
		if conf and conf.type == 3 then
			return taskid
		end
	end
end

function CheckEscortTask(human)
	for taskid,task in pairs(human.m_db.task) do
		local conf = 任务表[taskid]
		if conf and conf.type == 4 then
			return taskid
		end
	end
end

function CheckSpiritTask(human)
	for taskid,task in pairs(human.m_db.task) do
		local conf = 任务表[taskid]
		if conf and conf.type == 5 then
			return taskid
		end
	end
end

function CheckCollectTask(human)
	for taskid,task in pairs(human.m_db.task) do
		local conf = 任务表[taskid]
		if conf and conf.type == 6 then
			return taskid
		end
	end
end

function CheckHumanTaskAccept(human)
	local dailyTask = {}
	local postTask = {}
	local escortTask = {}
	local spiritTask = {}
	local collectTask = {}
	local dailyId = CheckDailyTask(human)
	local postId = CheckPostTask(human)
	local escortId = CheckEscortTask(human)
	local spiritId = CheckSpiritTask(human)
	local collectId = CheckCollectTask(human)
	for taskid,conf in pairs(任务表) do
		if human.m_db.task[taskid] == nil then
			if human.m_db.level >= conf.showlevel and (conf.showlevelmax == 0 or human.m_db.level < conf.showlevelmax) and
				(conf.pretask == 0 or (human.m_db.task[conf.pretask] and human.m_db.task[conf.pretask].state == 3)) and
				(conf.type ~= 2 or not dailyId) and (conf.type ~= 3 or not postId) and (conf.type ~= 4 or not escortId) and (conf.type ~= 5 or not spiritId) and (conf.type ~= 6 or not collectId) then
				local task = human.m_db.task
				if conf.type == 2 then
					task = {}
					dailyTask[#dailyTask+1] = {taskid,task}
				elseif conf.type == 3 then
					task = {}
					postTask[#postTask+1] = {taskid,task}
				elseif conf.type == 4 then
					task = {}
					escortTask[#escortTask+1] = {taskid,task}
				elseif conf.type == 5 then
					task = {}
					spiritTask[#spiritTask+1] = {taskid,task}
				elseif conf.type == 6 then
					task = {}
					collectTask[#collectTask+1] = {taskid,task}
				end
				if conf.acceptid == 0 and human.m_db.level >= conf.level then
					task[taskid] = {state=1,cnt=0,mons={},mapid=0}
					for i,func in ipairs(conf.func) do
						if func[1] == 5 then
							task[taskid].mapid = func[2]
						elseif func[1] == 6 then
							task[taskid].mapid = func[2]
							task[taskid].mons[0] = {func[2],func[3],0}
						elseif func[1] == 4 then
							task[taskid].mons[func[2]] = {0,func[3],0}
						else
							local refconf = 刷新表[ func[2] ]
							task[taskid].mons[refconf.monid] = {refconf.mapid,func[3],0}
						end
					end
					CheckHumanTaskFinish(human, taskid)
				else
					task[taskid] = {state=0,cnt=0,mons={},mapid=0}
				end
				if conf.type == 0 then
					human.m_db.currtaskid = taskid
				end
			end
		end
	end
	if #dailyTask > 0 then
		local tid = math.random(1, #dailyTask)
		local taskid = dailyTask[tid][1]
		human.m_db.task[taskid] = dailyTask[tid][2][taskid]
	end
	if #postTask > 0 then
		local tid = math.random(1, #postTask)
		local taskid = postTask[tid][1]
		human.m_db.task[taskid] = postTask[tid][2][taskid]
	end
	if #escortTask > 0 then
		local tid = math.random(1, #escortTask)
		local taskid = escortTask[tid][1]
		human.m_db.task[taskid] = escortTask[tid][2][taskid]
	end
	if #spiritTask > 0 then
		local tid = math.random(1, #spiritTask)
		local taskid = spiritTask[tid][1]
		human.m_db.task[taskid] = spiritTask[tid][2][taskid]
	end
	if #collectTask > 0 then
		local tid = math.random(1, #collectTask)
		local taskid = collectTask[tid][1]
		human.m_db.task[taskid] = collectTask[tid][2][taskid]
	end
end

function ReplaceNpcDesc(human, desc, npcid)
	if npcid == 公共定义.日常任务NPC then
		desc = desc:gsub("$1",human.m_db.日常任务次数)
		desc = desc:gsub("$2",20+human.m_db.vip等级)
	elseif npcid == 公共定义.悬赏任务NPC then
		desc = desc:gsub("$1",human.m_db.悬赏任务次数)
		desc = desc:gsub("$2",20+human.m_db.vip等级)
	elseif npcid == 公共定义.护送押镖NPC then
		desc = desc:gsub("$1",human.m_db.护送押镖次数)
		desc = desc:gsub("$2",2+(human.m_db.vip等级 > 0 and 1 or 0))
	elseif npcid == 公共定义.护送灵兽NPC then
		desc = desc:gsub("$1",human.m_db.护送灵兽次数)
		desc = desc:gsub("$2",2+(human.m_db.vip等级 > 0 and 1 or 0))
	elseif npcid == 公共定义.庄园采集NPC then
		desc = desc:gsub("$1",human.m_db.庄园采集次数)
		desc = desc:gsub("$2",2+(human.m_db.vip等级 > 0 and 1 or 0))
	elseif npcid == 公共定义.材料查看NPC then
		desc = desc:gsub("$1",human.m_db.战魂值)
		desc = desc:gsub("$2",human.m_db.神石结晶)
		desc = desc:gsub("$3",human.m_db.魂珠碎片)
		desc = desc:gsub("$4",human.m_db.灵韵值)
	end
	return desc
end

function ReplaceTaskDesc(human, desc, taskid)
	return desc
end

function Npc对话(human, npcid, talkid)
	--print("talk",npcid,talkid)
	if 实用工具.FindIndex(公共定义.传送NPC, npcid) then--npcid == 1096 or npcid == 1097 or npcid == 1098 or npcid == 1099 or npcid == 1100 or npcid == 1101 then
		local 地图id
		if 公共定义.传送地图ID[talkid] then
			地图id = 公共定义.传送地图ID[talkid]
		else
			return
		end
		local conf = 地图表[地图id]
		if conf then
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
			if #conf.costtp > 0 and human.m_db.tp < conf.costtp[1] then
				human:SendTipsMsg(1,"体力不足")
				return
			end
			if #conf.relivepos > 1 then
				human:Transport(地图id,
					conf.relivepos[1] + math.random(-conf.relivepos[3],conf.relivepos[3]),
					conf.relivepos[2] + math.random(-conf.relivepos[3],conf.relivepos[3]))
			else
				human:RandomTransport(地图id)
			end
			return
		end
	elseif 实用工具.FindIndex(公共定义.英雄领取NPC, npcid) then--npcid == 1102 or npcid == 1103 or npcid == 1104 then
		local 英雄职业 = 0
		local 英雄性别 = 0
		if talkid == 1 then
			英雄职业 = 1
			英雄性别 = 1
		elseif talkid == 2 then
			英雄职业 = 1
			英雄性别 = 2
		elseif talkid == 3 then
			英雄职业 = 2
			英雄性别 = 1
		elseif talkid == 4 then
			英雄职业 = 2
			英雄性别 = 2
		elseif talkid == 5 then
			英雄职业 = 3
			英雄性别 = 1
		elseif talkid == 6 then
			英雄职业 = 3
			英雄性别 = 2
		else
			return
		end
		if human.m_db.英雄职业 ~= 0 then
			human:SendTipsMsg(1,"你已经有英雄了")
			return
		else
			human.m_db.英雄职业 = 英雄职业
			human.m_db.英雄性别 = 英雄性别
			human:召唤英雄()
			玩家事件处理.OnXpPrepare(-1, human.id)
			return
		end
	elseif 实用工具.FindIndex(公共定义.元宝充值NPC, npcid) then
		if talkid == 1 then
			human:打开网站("http://pay1.wodepay.net/app/acquire/req?id="..Config.PAY_CHANNEL_ID)
		elseif talkid == 2 then
			human:打开网站("http://pay2.wodepay.com/app/acquire/req?id="..Config.PAY_CHANNEL_ID)
		elseif talkid == 3 then
			human:打开网站("http://pay1.kuaidicaiwu.com/app/acquire/req?id="..Config.PAY_CHANNEL_ID)
		elseif talkid == 4 then
			human:打开网站("http://pay2.kuaidicaiwu.com/app/acquire/req?id="..Config.PAY_CHANNEL_ID)
		elseif talkid == 5 then
			human:打开网站("http://pay1.junweidun.com/app/acquire/req?id="..Config.PAY_CHANNEL_ID)
		elseif talkid == 6 then
			human:打开网站("http://pay2.junweidun.com/app/acquire/req?id="..Config.PAY_CHANNEL_ID)
		elseif talkid == 7 then
			human:领取充值()
		else
			return
		end
	elseif npcid == 公共定义.日常任务NPC then
		if talkid == 1 then
			local npcconf = Npc表[npcid]
			local taskid = CheckDailyTask(human)
			if not taskid then
				human:SendTipsMsg(1,"找不到可刷新的任务")
				return
			end
			if human.m_db.task[taskid].state == 2 then
				human:SendTipsMsg(1,"当前任务已完成,无法刷新")
				return
			end
			local 刷新金币 = npcconf.func[talkid][3]
			if human:GetMoney(true) < 刷新金币 then
				human:SendTipsMsg(1,"绑定金币不足")
				return
			end
			human:DecMoney(刷新金币, true)
			--if human.m_db.rmb < 公共定义.悬赏刷新元宝 then
			--	human:SendTipsMsg(1,"元宝不足")
			--	return
			--end
			--human:DecRmb(公共定义.悬赏刷新元宝, false)
			human.m_db.task[taskid] = nil
			CheckHumanTaskAccept(human)
			return true
		else
			return
		end
	elseif npcid == 公共定义.悬赏任务NPC then
		if talkid == 1 then
			local npcconf = Npc表[npcid]
			local taskid = CheckPostTask(human)
			if not taskid then
				human:SendTipsMsg(1,"找不到可刷新的任务")
				return
			end
			if human.m_db.task[taskid].state == 2 then
				human:SendTipsMsg(1,"当前任务已完成,无法刷新")
				return
			end
			local 刷新金币 = npcconf.func[talkid][3]
			if human:GetMoney(true) < 刷新金币 then
				human:SendTipsMsg(1,"绑定金币不足")
				return
			end
			human:DecMoney(刷新金币, true)
			--if human.m_db.rmb < 公共定义.悬赏刷新元宝 then
			--	human:SendTipsMsg(1,"元宝不足")
			--	return false
			--end
			--human:DecRmb(公共定义.悬赏刷新元宝, false)
			human.m_db.task[taskid] = nil
			CheckHumanTaskAccept(human)
			return true
		else
			return
		end
	elseif npcid == 公共定义.护送押镖NPC then
		if talkid == 1 then
			local npcconf = Npc表[npcid]
			local taskid = CheckEscortTask(human)
			if not taskid then
				human:SendTipsMsg(1,"找不到可刷新的任务")
				return
			end
			local 刷新金币 = npcconf.func[talkid][3]
			if human:GetMoney(true) < 刷新金币 then
				human:SendTipsMsg(1,"绑定金币不足")
				return
			end
			if human.call[-1] then
				human.m_db.镖车血量 = 0
				human.m_db.镖车玩家伤害 = {}
				human.call[-1]:Destroy()
				human.call[-1] = nil
			end
			human:DecMoney(刷新金币, true)
			human.m_db.task[taskid] = nil
			CheckHumanTaskAccept(human)
			return true
		else
			return
		end
	elseif npcid == 公共定义.护送灵兽NPC then
		if talkid == 1 then
			local npcconf = Npc表[npcid]
			local taskid = CheckSpiritTask(human)
			if not taskid then
				human:SendTipsMsg(1,"找不到可刷新的任务")
				return
			end
			local 刷新金币 = npcconf.func[talkid][3]
			if human:GetMoney(true) < 刷新金币 then
				human:SendTipsMsg(1,"绑定金币不足")
				return
			end
			if human.call[-1] then
				human.m_db.镖车血量 = 0
				human.m_db.镖车玩家伤害 = {}
				human.call[-1]:Destroy()
				human.call[-1] = nil
			end
			human:DecMoney(刷新金币, true)
			human.m_db.task[taskid] = nil
			CheckHumanTaskAccept(human)
			return true
		else
			return
		end
	elseif npcid == 公共定义.庄园采集NPC then
		if talkid == 1 then
			local npcconf = Npc表[npcid]
			local taskid = CheckCollectTask(human)
			if not taskid then
				human:SendTipsMsg(1,"找不到可刷新的任务")
				return
			end
			if human.m_db.task[taskid].state == 2 then
				human:SendTipsMsg(1,"当前任务已完成,无法刷新")
				return
			end
			local 刷新金币 = npcconf.func[talkid][3]
			if human:GetMoney(true) < 刷新金币 then
				human:SendTipsMsg(1,"绑定金币不足")
				return
			end
			human:DecMoney(刷新金币, true)
			human.m_db.task[taskid] = nil
			CheckHumanTaskAccept(human)
			return true
		elseif talkid == 2 then
			local conf = 地图表[公共定义.庄园地图ID]
			if conf then
				if #conf.relivepos > 1 then
					human:Transport(公共定义.庄园地图ID,
						conf.relivepos[1] + math.random(-conf.relivepos[3],conf.relivepos[3]),
						conf.relivepos[2] + math.random(-conf.relivepos[3],conf.relivepos[3]))
				else
					human:RandomTransport(公共定义.庄园地图ID)
				end
				return
			end
		else
			return
		end
	elseif npcid == 公共定义.领取补偿NPC then
		if talkid == 1 then
			if human.m_db.领取补偿[talkid] then
				human:SendTipsMsg(1,"你已经领取过补偿")
				return
			end
			human:AddRmb(公共定义.领取补偿元宝, true)
			human:SendTipsMsg(1,"#cff00,成功领取补偿")
			human.m_db.领取补偿[talkid] = 1
			return
		else
			return
		end
	elseif npcid == 公共定义.寻宝阁NPC then
		if talkid == 1 then
			if human:GetLevel() < 35 then
				human:SendTipsMsg(1,"等级不足")
				return
			end
			if 玩家事件处理.寻宝阁状态 ~= 1 then
				human:SendTipsMsg(1,"寻宝阁暂未开启")
				return
			end
			local conf = 地图表[公共定义.寻宝阁地图]
			if conf then
				if #conf.relivepos > 1 then
					human:Transport(公共定义.寻宝阁地图,
						conf.relivepos[1] + math.random(-conf.relivepos[3],conf.relivepos[3]),
						conf.relivepos[2] + math.random(-conf.relivepos[3],conf.relivepos[3]))
				else
					human:RandomTransport(公共定义.寻宝阁地图)
				end
				return
			end
		else
			return
		end
	elseif npcid == 公共定义.特戒之城NPC then
		if talkid == 1 then
			if human:GetLevel() < 35 then
				human:SendTipsMsg(1,"等级不足")
				return
			end
			if 玩家事件处理.特戒之城开启 ~= 1 then
				human:SendTipsMsg(1,"特戒之城暂未开启")
				return
			end
			local conf = 地图表[公共定义.特戒之城地图]
			if conf then
				if #conf.relivepos > 1 then
					human:Transport(公共定义.特戒之城地图,
						conf.relivepos[1] + math.random(-conf.relivepos[3],conf.relivepos[3]),
						conf.relivepos[2] + math.random(-conf.relivepos[3],conf.relivepos[3]))
				else
					human:RandomTransport(公共定义.特戒之城地图)
				end
				return
			end
		else
			return
		end
	elseif npcid == 公共定义.无限仓库NPC then
		if talkid >= 1 and talkid <= 10 then
			if human.m_db.vip等级 < talkid then
				human:SendTipsMsg(1,"VIP等级不足")
				return
			end
			if not human.m_db.bagdb.vipstoregrids[talkid] then
				human.m_db.bagdb.vipstoregrids[talkid] = {}
			end
			背包逻辑.SendStoreQuery(human, nil, talkid)
		else
			return
		end
	end
end
