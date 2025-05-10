module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 计时器ID = require("公用.计时器ID")
local 消息类 = require("公用.消息类")
local 公共定义 = require("公用.公共定义")
local 实用工具 = require("公用.实用工具")
local 日志 = require("公用.日志")
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local 拾取物品逻辑 = require("怪物.拾取物品逻辑")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local AI = require("怪物.AI")
local 技能逻辑 = require("技能.技能逻辑")
local 聊天逻辑 = require("聊天.聊天逻辑")

function OnRespawn(nTimerID, nObjID,nEvent)
	local  obj = 对象类:GetObj(nObjID)
	if obj == nil or (obj:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER and obj:GetObjType() ~= 公共定义.OBJ_TYPE_COLLECT and obj:GetObjType() ~= 公共定义.OBJ_TYPE_PET) then
		_DelTimer(nTimerID, nObjID)
		return
	end
	local nSceneID = obj.m_nSceneID ~= -1 and obj.m_nSceneID or obj.oldsceneid
	if nSceneID ~= -1 then
		obj:ChangeStatus(公共定义.STATUS_NORMAL)
		obj:SetEngineMoveSpeed(obj:获取移动速度())
		obj.avatarid = 0
		obj:ChangeBody()
		obj.moveposindex = 1
		obj:RecoverHP(obj:获取生命值())
		obj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, obj:GetRadius())
		if obj:GetObjType() == 公共定义.OBJ_TYPE_PET then
			obj:JumpScene(nSceneID, obj:GetPosition())
		elseif obj.relivepos then
			obj:JumpScene(nSceneID, obj.relivepos[1], obj.relivepos[2])
			obj.bornx = obj.relivepos[1]
			obj.borny = obj.relivepos[2]
		else
			obj:JumpScene(nSceneID, obj:GetBornPos())
		end
		副本管理.ReliveSceneObj(obj.m_nSceneID, obj)
	end
end

function OnMoveAI(nTimerID, nObjID,nEvent)
	local  obj = 对象类:GetObj(nObjID)
	if obj == nil or (obj:GetObjType() ~= 公共定义.OBJ_TYPE_HERO and obj:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER and obj:GetObjType() ~= 公共定义.OBJ_TYPE_PET) then
		_DelTimer(nTimerID, nObjID)
		return
	end
	local movegridtime = obj.movegridtime or 500
	obj.movegridtime = nil
	AI.DoMoveAI(obj)
	--print(obj.id,obj.movegridtime,_CurrentTime())
	if (obj.movegridtime or 500) ~= movegridtime then
		_DelTimer(nTimerID, nObjID)
		--obj.moveaitimer = _AddTimer(obj.id, 计时器ID.TIMER_MONSTER_MOVEAI,obj.movegridtime or 500,-1, 0, 0, 0)
	end
end

function OnMonsterCollect(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	local obj = 对象类:GetObj(nObjID)
	if obj and obj:GetObjType() == 公共定义.OBJ_TYPE_COLLECT then
		local human = 对象类:GetObj(nParam1)
		if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
			local monconf = obj:GetConfig()
			if monconf and #monconf.drop > 0 then
				local x,y = obj:GetPosition()
				local posindex = 1
				local posloop = false
				local itemx, itemy
				local drop = (obj.isrobot or obj.useitems) and obj.items or monconf.drop
				local ownerid = human.id
				local owner = human
				for i,v in ipairs(drop) do
					if math.random(1,10000) <= v[3] then
						if v[1] < 10000 then
							local m = 怪物对象类:CreateMonster(obj.m_nSceneID, v[1], x, y, -1)
							m.callid = -1
							if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
								聊天逻辑.SendSystemChat("#cffff00,"..owner:GetName().."#C在#cff0000,"..
								场景管理.GetMapName(场景管理.GetMapId(owner.m_nSceneID)).."#C采集,#cffff00,"..
								m:GetName().."#C被唤醒")
							end
							break
						end
						while 1 do
							itemx = x+技能逻辑.itemdroppos[posindex][1]*(obj.MoveGrid and obj.MoveGrid[1] or 50)
							itemy = y+技能逻辑.itemdroppos[posindex][2]*(obj.MoveGrid and obj.MoveGrid[1] or 50)*(obj.Is2DScene and 1/obj.MoveGridRate or 1)
							if not posloop then
								posindex = posindex + 1
							end
							if posindex > #技能逻辑.itemdroppos then
								posindex = 1
								posloop = true
							end
							if obj.m_nSceneID == -1 then
								break
							end
							if posloop or obj:IsPosWalkable(itemx, itemy) then
								local grade = nil
								local 物品 = 物品对象类:CreateItem(-1, ownerid, v[1], v[2], posloop and x or itemx, posloop and y or itemy, grade)--v[4], v[5])
								if 物品==nil then
									print("null itemid: ",v[1])
									break
								end
								物品.teamid = owner.teamid
								物品:EnterScene(obj.m_nSceneID, itemx, itemy)
								if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and owner.m_db.物品自动拾取 == 1 then
									拾取物品逻辑.SendPickItem(owner, 物品.id)
								end
								break
							end
						end
					end
				end
			end
			human.collectid = -1
			human:SendTipsMsg(2, "获得#cffff00,"..obj:GetName())
			human:SendTipsMsg(1, "#s16,#cff00,今日采集次数: "..human.m_db.每日采集次数.." / 100")
			human.m_db.每日采集次数 = human.m_db.每日采集次数 + 1
			Npc对话逻辑.OnMonsterDead(obj, human)
		end
		obj.oldsceneid = obj.m_nSceneID
		MonsterRespawn[obj.id] = obj
		obj.respawntime = _CurrentTime() + obj:GetRelive()
		obj.collecter = -1
		obj.collecttimer = nil
		obj:LeaveScene()
		obj:RecoverHP(-obj:获取生命值())
	end
end

function OnDropItemExpire(nTimerID, nObjID,nEvent, nParam1, nParam2, nParam3)
	local  oItem = 对象类:GetObj(nObjID)
	if oItem == nil or oItem:GetObjType() ~= 公共定义.OBJ_TYPE_ITEM then
		_DelTimer(nTimerID, nObjID)
		return
	end
	if oItem.m_nOwnerId ~= -1 then
		物品对象类:CreateItem(oItem.m_nSceneID, -1, oItem.m_nItemId, oItem.m_nCount, oItem.m_nBornX, oItem.m_nBornY, oItem.grade, oItem.strengthen, oItem.wash, oItem.attach)
	end
	oItem:Destroy()
end

function OnDropItemRoll(nTimerID, nObjID,nEvent, nParam1, nParam2, nParam3)
end

function OnBiaocheExpire(nTimerID, nObjID,nEvent, nParam1, nParam2, nParam3)
end

function CG_NPC_TALK(oHuman, oMsg)
	Npc对话逻辑.SendTalkInfo(oHuman, oMsg.objid, oMsg.talkid)
end

function CG_NPC_TALK_PUT(oHuman, oMsg)
	local talk = 实用工具.GetStringFromTable(oMsg.talkLen, oMsg.talk)
	Npc对话逻辑.SendCallTalkPut(oHuman, oMsg.objid, oMsg.talkid, oMsg.type, oMsg.callid, talk)
end

function CG_PICK_ITEM(oHuman, oMsg)
	拾取物品逻辑.SendPickItem(oHuman, oMsg.objid)
end

function CG_ACCEPT_TASK(oHuman, oMsg)
	Npc对话逻辑.SendAcceptTask(oHuman, oMsg.taskid)
end

function CG_FINISH_TASK(oHuman, oMsg)
	Npc对话逻辑.SendFinishTask(oHuman, oMsg.taskid)
end

function CG_TASK_QUERY(oHuman, oMsg)
	Npc对话逻辑.SendTaskInfo(oHuman, 1)
end
