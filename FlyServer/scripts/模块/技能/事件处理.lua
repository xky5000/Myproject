module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 技能逻辑 = require("技能.技能逻辑")
local 技能表 = require("配置.技能表").Config
local Buff表 = require("配置.Buff表").Config

function CG_USE_SKILL(oHuman, oMsg)
	技能逻辑.DoUseSkill(oHuman, oMsg.skillid, oMsg.targetid, oMsg.posx, oMsg.posy)
end

function CG_SKILL_QUERY(oHuman, oMsg)
	技能逻辑.SendSkillInfo(oHuman)
end

function CG_SKILL_LEARN(oHuman, oMsg)
	技能逻辑.DoLearnSkill(oHuman, oMsg.infoid)
end

function CG_SKILL_UPGRADE(oHuman, oMsg)
	技能逻辑.DoUpgradeSkill(oHuman, oMsg.infoid)
end

function CG_SKILL_DISCARD(oHuman, oMsg)
	技能逻辑.DoDiscardSkill(oHuman, oMsg.infoid)
end

function CG_SKILL_QUICK_QUERY(oHuman, oMsg)
	技能逻辑.SendQuickQuery(oHuman)
end

function CG_SKILL_QUICK_SETUP(oHuman, oMsg)
	技能逻辑.DoQuickSetup(oHuman, oMsg.id)
end

function CG_SKILL_HANGUP(oHuman, oMsg)
	技能逻辑.DoSkillHangup(oHuman, oMsg.infoid, oMsg.hangup)
end

function OnUnattackableOut(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		技能逻辑.SendControlledOut(obj, 1)
	end
end

function OnUnmovableOut(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		技能逻辑.SendControlledOut(obj, 0)
	end
end

function OnDisplaceBegin(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		obj.displace = nil
		技能逻辑.DoDisplaceBegin(obj, nParams.skillid, nParams.targetid, nParams.posx, nParams.posy)
	end
end

function OnDisplaceEnd(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		obj.displace = nil
		obj.dismovex = nil
		obj.dismovey = nil
		--obj:ChangePosition(nParams.posx,nParams.posy)
		--obj:SetEngineMoveSpeed(obj:获取移动速度())
	end
end

function OnAttackHit(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		local conf = 技能表[nParams.skillid]
		技能逻辑.DoAttackHit(obj, nParams.skillid, nParams.targetid, nParams.posx, nParams.posy, nParams.hitindex)
		if obj.hitpoint then
			_DelTimer(obj.hitpoint, obj.id)
		end
		if #conf.hitpoint == nParams.hitindex then
			obj.hitpoint = nil
		else
			nParams.hitindex = nParams.hitindex + 1
			obj.hitpoint = _AddTimer(nObjID, 计时器ID.TIMER_ATTACK_HIT, conf.hitpoint[nParams.hitindex]-conf.hitpoint[nParams.hitindex-1], 1, nParams)
		end
	end
end

function 减少效果计时(obj, buffid, buffconf, time)
	if obj.buffend[buffid] then
		local timer = _GetTimer(obj.buffend[buffid], obj.id)
		if buffconf.last == 1 and timer and timer.interval > 0 then
			timer.interval = timer.interval - time
		end
		if timer.interval <= 0 then
			_DelTimer(obj.buffend[buffid], obj.id)
			技能逻辑.DoHitBuffEnd(obj, buffconf)
		end
	end
end

function OnBuffHit(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		local buffconf = Buff表[nParams.buffid]
		for i,v in ipairs(buffconf.buff) do
			if obj.hp <= 0 or obj.m_nSceneID == -1 then
			elseif v[1] == 公共定义.额外属性_每秒回血 then
				if buffconf.debuff == 0 then
					if obj:RecoverHP(v[2]) and buffconf.效果计时 == 1 then
						减少效果计时(obj, nParams.buffid, buffconf, v[2])
					end
				elseif obj:RecoverHP(-v[2]) then
					local atker = 对象类:GetObj(nParams.atkerid)
					技能逻辑.CheckObjDead(obj, atker, v[2])
				end
			elseif v[1] == 公共定义.额外属性_每秒回血+100 then
				if buffconf.debuff == 0 then
					if obj:RecoverHP(obj:获取生命值()*v[2]/100) and buffconf.效果计时 == 1 then
						减少效果计时(obj, nParams.buffid, buffconf, obj:获取生命值()*v[2]/100)
					end
				elseif obj:RecoverHP(-obj:获取生命值()*v[2]/100) then
					local atker = 对象类:GetObj(nParams.atkerid)
					技能逻辑.CheckObjDead(obj, atker, obj:获取生命值()*v[2]/100)
				end
			elseif v[1] == 公共定义.额外属性_每秒回魔 then
				if buffconf.debuff == 0 then
					if obj:RecoverMP(v[2]) and buffconf.效果计时 == 1 then
						减少效果计时(obj, nParams.buffid, buffconf, v[2])
					end
				else
					obj:RecoverMP(-v[2])
				end
			elseif v[1] == 公共定义.额外属性_每秒回魔+100 then
				if buffconf.debuff == 0 then
					if obj:RecoverMP(obj:获取魔法值()*v[2]/100) and buffconf.效果计时 == 1 then
						减少效果计时(obj, nParams.buffid, buffconf, obj:获取魔法值()*v[2]/100)
					end
				else
					obj:RecoverMP(-obj:获取魔法值()*v[2]/100)
				end
			elseif v[1] == 公共定义.额外属性_随机移动 then
				if obj.hp > 0 and nParams.time > nParams.hitindex * 1000 then
					local x,y = obj:GetPosition()
					local nX, nY = 实用工具.GetRandPos(x, y, 100, obj.Is2DScene, obj.MoveGridRate)
					obj:MoveTo(nX, nY, 1)
				end
			elseif v[1] == 公共定义.额外属性_范围伤害 then
				if obj.hp > 0 then
					技能逻辑.DoBuffAttack(obj, v[2], v[3])
				end
			end
		end
		if nParams.time <= nParams.hitindex * 1000 then
			obj.buffhit[nParams.buffid] = nil
		else
			nParams.hitindex = nParams.hitindex + 1
			obj.buffhit[nParams.buffid] = _AddTimer(nObjID, 计时器ID.TIMER_BUFF_HIT, 1000, 1, nParams)
		end
	end
end

function OnBuffEnd(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		local buffconf = Buff表[nParams.buffid]
		obj.buffend[nParams.buffid] = nil
		技能逻辑.DoHitBuffEnd(obj, buffconf)
	end
end

function OnChangeBodyID(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		obj.avatarid = 0
		obj:ChangeBody()
		obj.changebodyid = nil
		--技能逻辑.SendControlledOut(obj, 1)
		技能逻辑.SendSkillInfo(obj)
	end
end

function OnMonsterDisappear(nTimerID, nObjID, nEvent, nParams)
	local obj = 对象类:GetObj(nObjID)
	if obj then
		if obj.callid then
			obj:Destroy()
		else
			obj:LeaveScene()
		end
	end
end
