module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 主逻辑 = require("主界面.主逻辑")
local 技能逻辑 = require("技能.技能逻辑")
local 消息框UI1 = require("主界面.消息框UI1")
local 角色逻辑 = require("主界面.角色逻辑")
local 主界面UI = require("主界面.主界面UI")
--local 技能预警表 = require("配置.技能预警表").Config
local targetPos = F3DVector3:new()
local halfzPos = F3DVector3:new(0,0,0.5)

function GC_SKILL_DISPLACE(objid,hitfly,posx,posy,time,passive)
	local role = g_roles[objid]
	if role then
		posy = g_is3D and posy or to3d(posy)
		role:startHitBack(posx, posy, time/1000)
		if hitfly > 0 and not role:isHitFly() then
			role:startHitFly(time/1000, hitfly, 0.2, 0.1, 0)--0.2
		end
		if passive == 0 and role.iscaller then
			role:setAnimRotationZ(F3DUtils:calcDirection(posx - role:getPositionX(), posy - role:getPositionY()))
		end
		if passive == 1 and hitfly > 0 then
			--role:setAnimName("hurt_2","idle",true,true)
		end
	end
end

function GC_USE_SKILL(objid,targetid,skillid,action,sound,effid1,effid2,effid3,posx,posy,flytime,follow)
	local role = g_roles[objid]
	if role then
		if role == g_role and g_openSound and sound ~= "" then
			F3DSoundManager:instance():playSound("/res/sound/"..sound)
		end
		posy = g_is3D and posy or to3d(posy)
		--stopRoleMove(role, true)
		if objid ~= targetid and role.bodyid ~= 0 and not role.istower then
			if not ISMIR2D then
				role:setRotationZ(F3DUtils:calcDirection(posx - role:getPositionX(), posy - role:getPositionY()))
			else
				role:setAnimRotationZ(F3DUtils:calcDirection(posx - role:getPositionX(), posy - role:getPositionY()))
			end
		end
		role:setAnimName((role.objtype ~= 全局设置.OBJTYPE_PLAYER and role.bodyid >= 1000 and not IS3G) and "attack_1" or action, (not ISMIR2D and role.objtype == 全局设置.OBJTYPE_PLAYER and not role.changefacade) and "attack_idle" or "idle", true, true)
		if IS3G then
			if effid1 ~= 0 then
				local delay = 0
				local rotz = F3DUtils:calcDirection(posx - role:getPositionX(), posy - role:getPositionY())
				local es = role:setEffectSystem(全局设置.getAnimPackUrl(effid1,true), false, nil, nil, delay, 0, nil, nil, rotz, 2)
				if follow ~= 0 then
					es:setFollowTime(follow)
				else
					es:setPositionZ(0)
				end
			end
			if effid2 ~= 0 then
				local delay = 0
				targetPos:setVal(posx, posy, g_scene and g_scene:getTerrainHeight(posx, posy) or 0)
				role:setEffectSystem(全局设置.getAnimPackUrl(effid2,true), false, targetPos, nil, delay, 0, nil, nil, -1, 2)
			end
			if effid3 ~= 0 then
				local target = targetid ~= -1 and g_roles[targetid] or nil
				if target == nil then
					targetPos:setVal(posx, posy, g_scene and g_scene:getTerrainHeight(posx, posy) or 0)
				end
				role:setEffectSystem(全局设置.getAnimPackUrl(effid3,true), false, nil, halfzPos, flytime / 1000, 0.3, target and halfzPos or targetPos, target, -1, 2)
			end
		elseif ISMIR2D then
			if effid1 ~= 0 then
				local delay = skillid == 2106 and 0.5 or 0
				local es = role:setEffectSystem(全局设置.getAnimPackUrl(effid1,true), false, nil, nil, delay, 0, nil, nil, -1, 2)
				if ISWZ then
					es:setScaleX(1.1)
					es:setScaleY(1.1)
				end
			end
			if effid2 ~= 0 then
				local delay = 0.5
				targetPos:setVal(posx, posy, g_scene and g_scene:getTerrainHeight(posx, posy) or 0)
				local es = role:setEffectSystem(全局设置.getAnimPackUrl(effid2,true), false, targetPos, nil, delay, 0, nil, nil, -1, 2)
				if ISWZ then
					es:setScaleX(1.1)
					es:setScaleY(1.1)
				end
			end
			if effid3 ~= 0 then
				local target = targetid ~= -1 and g_roles[targetid] or nil
				if target == nil then
					targetPos:setVal(posx, posy, g_scene and g_scene:getTerrainHeight(posx, posy) or 0)
				end
				local es = role:setEffectSystem(全局设置.getAnimPackUrl(effid3,true), false, nil, halfzPos, flytime / 1000, 0.3, target and halfzPos or targetPos, target, -1, 2)
				if ISWZ then
					es:setScaleX(1.1)
					es:setScaleY(1.1)
				end
			end
		else
			if effid1 ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid1), false, nil, nil, 0, 0, nil, nil, -1, 2)
			end
			if effid2 ~= 0 then
				targetPos:setVal(posx, posy, g_scene and g_scene:getTerrainHeight(posx, posy) or 0)
				role:setEffectSystem(全局设置.getEffectUrl(effid2), false, targetPos, nil, 0, 0, nil, nil, -1, 2)
			end
			if effid3 ~= 0 then
				local target = targetid ~= -1 and g_roles[targetid] or nil
				if target == nil then
					targetPos:setVal(posx, posy, g_scene and g_scene:getTerrainHeight(posx, posy) or 0)
				end
				local animset = role:getAnimSet()
				local hitpos = halfzPos
				if animset and animset:getAttachPos("hit") and animset:getAttachPos("hit"):getBone() == action then
					hitpos = animset:getAttachPos("hit"):getPosition()
				end
				role:setEffectSystem(全局设置.getEffectUrl(effid3), false, nil, hitpos, flytime / 1000, 0.3, target and halfzPos or targetPos, target, -1, 2)
			end
			--local conf = 技能预警表[skillid]
			--if conf then
			--	if conf.pos == 1 then
			--		targetPos:setVal(posx, posy, g_scene and g_scene:getTerrainHeight(posx, posy) or 0)
			--	end
			--	local es = role:setEffectSystem(全局设置.getEffectUrl(conf.effid), false, conf.pos == 1 and targetPos or nil, nil, 0, conf.time / 1000, nil, nil, -1, 2)
			--	es:setScale(conf.scalex / 100, conf.scaley / 100, 1)
			--end
		end
		if role == g_role then
			技能逻辑.onUseSkill(skillid)
			技能逻辑.m_usingSkill = false
		end
		--if objid ~= targetid and targetid == g_role.objid and 技能逻辑.autoUseSkill and not g_target then
		--	setMainRoleTarget(role)
		--end
	end
end

function GC_SKILL_INFO(info)
	技能逻辑.setSkillInfo(info)
end

m_ReliveTxt = ""
m_ReliveCnt = 0

function onReliveTips()
	m_ReliveCnt = m_ReliveCnt - 1
	if m_ReliveCnt == 0 then
		消息框UI1.hideUI()
		onRelive()
	else
		消息框UI1.setData(m_ReliveTxt.."("..m_ReliveCnt..txt("秒后自动复活)"),onRelive,onRelive,onRelive)
	end
end

function onRelive()
	if 消息框UI1.m_repeatanim then
		F3DScheduler:instance():removeAnimatable(消息框UI1.m_repeatanim)
		消息框UI1.m_repeatanim = nil
	end
	消息.CG_REQUEST_RELIVE(0)
end

function onReliveThere()
	if 消息框UI1.m_repeatanim then
		F3DScheduler:instance():removeAnimatable(消息框UI1.m_repeatanim)
		消息框UI1.m_repeatanim = nil
	end
	消息.CG_REQUEST_RELIVE(1)
end

function GC_SKILL_HURT(objid,effid1,effid2,dechp,crit,status,hittype)
	local role = g_roles[objid]
	if not role then return end
	if role.iscaller then return end
	if status == 0 then
		if dechp > 0 and not role.istower and (hittype~=0 or role:getAnimName():find("idle") or role:getAnimName():find("hurt")) then
			role:setAnimName(hittype==2 and "hurt_3" or hittype==1 and "hurt_2" or "hurt", (not ISMIR2D and role.objtype == 全局设置.OBJTYPE_PLAYER and not role.changefacade) and "attack_idle" or role.objtype == 全局设置.OBJTYPE_PLAYER and "idle" or "idle", true, true)
		end
		if ISMIR2D then
			if effid1 ~= 0 then
				role:setEffectSystem(全局设置.getAnimPackUrl(effid1,true), true, nil, halfzPos)
			end
		else
			if effid1 ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid1), true, nil, halfzPos)
			end
		end
	elseif status == 1 then
		--stopRoleMove(role, true)
		if not role.istower then
			role:setAnimName("dead", "", true, true)
		end
		if g_target == role then
			setMainRoleTarget(nil)
		end
		if g_attackObj == role then
			resetAttackObj(nil)
		end
		if ISMIR2D then
			if effid1 ~= 0 then
				role:setEffectSystem(全局设置.getAnimPackUrl(effid1,true), true, nil, halfzPos)
			end
			if effid2 ~= 0 then
				role:setEffectSystem(全局设置.getAnimPackUrl(effid2,true), false)
			end
		else
			if effid1 ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid1), true, nil, halfzPos)
			end
			if effid2 ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid2), false)
			end
		end
		if role == g_role then
			if __PLATFORM__ ~= "IOS" then
				grabimage:setShaderType(F3DImage.SHADER_GRAY)
			end
			m_ReliveCnt = 10
			m_ReliveTxt = txt("是否立即回城复活？")--角色逻辑.m_level < 30 and txt("30级之前免费原地复活！") or txt("30级以后回城复活！")
			if 消息框UI1.m_repeatanim then
				F3DScheduler:instance():removeAnimatable(消息框UI1.m_repeatanim)
				消息框UI1.m_repeatanim = nil
			end
			消息框UI1.m_repeatanim = F3DScheduler:instance():repeatCall(func_n(onReliveTips), 1000)
			消息框UI1.initUI()
			消息框UI1.setData(m_ReliveTxt..txt("(10秒后自动复活)"),onReliveThere,onRelive,onRelive)
		end
	elseif status == 2 then
		role:setAnimName("idle")
		if not ISMIR2D then
			if effid2 ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid2), false)
			end
		end
		if role == g_role then
			grabimage:setShaderType(F3DImage.SHADER_WARP)
		end
		if 消息框UI1.m_repeatanim then
			F3DScheduler:instance():removeAnimatable(消息框UI1.m_repeatanim)
			消息框UI1.m_repeatanim = nil
		end
		消息框UI1.hideUI()
	end
	if status ~= 2 then
		if not role.nobody and crit ~= 2 then
			主逻辑.showFlytext(role, dechp, crit)
		end
		if not ISMIR2D then
			if dechp > 0 then
				role:setBeAttack(true)
			end
		end
	end
end

function GC_SKILL_CONTROLLED(objid,type,controlled)
	local role = g_roles[objid]
	if not role then return end
	if type == 1 then
		role.unattackable = controlled
	else
		role.unmovable = controlled
	end
	if type == 0 and controlled == 0 and role == g_role then
		if g_moveUp or g_moveDown or g_moveLeft or g_moveRight or g_moveDirDown then
			doMoveRoleLogic()
		elseif (rightMouseDown or (LEFTMOVE and leftMouseDown and not g_target)) then
			doMoveRoleLogic()
		elseif g_targetPos.x ~= 0 and g_targetPos.y ~= 0 then--g_targetPos.bodyid == 0 and
			if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
				消息.CG_CHANGE_STATUS(0,-1)
				--g_role.status = 1
				--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
			end
			startAStar(g_targetPos.x, g_targetPos.y, true, true)
			g_targetPos.x = 0
			g_targetPos.y = 0
		else
			doRoleLogic()
		end
	end
	if type == 1 and controlled == 0 and role == g_role then
		if g_skillkeycode and g_role.unattackable ~= 1 and rtime() - g_skillkeytime < 200 then
			g_movePoint = nil
			local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
			local target = g_hoverObj or findAttackObj(g_skill[g_skillkeycode].range - RANGEOFFSET)
			if IS3G then
				if g_moveUp or g_moveDown or g_moveLeft or g_moveRight then
					g_movedir:setVal(g_moveLeft and -1 or (g_moveRight and 1 or 0), g_moveUp and 1 or (g_moveDown and -1 or 0))
					g_movedir:normalize(50)
				end
				if g_movedir.x == 0 and g_movedir.y == 0 then
					g_movedir.x = 50
				end
				技能逻辑.doUseSkill(target, g_skillkeycode, g_role:getPositionX()+g_movedir.x*8, g_role:getPositionY()+g_movedir.y*8)
			else
				技能逻辑.doUseSkill(target, g_skillkeycode, pos.x, pos.y)
			end
			resetSkillKeycode()
			if target then
				--setMainRoleTarget(target)
				resetAttackObj(target)
			end
		end
		doRoleLogic()
	end
end

function GC_SKILL_BUFF(objid,effid,time,icon,info)
	技能逻辑.setSkillBuff(objid,effid,time,icon)
end

function GC_SKILL_LEARN(result)
end

function GC_SKILL_LEARNINFO(learn)
end

function GC_SKILL_UPGRADE(result)
end

function GC_SKILL_QUICK_LIST(id)
	主界面UI.setSkillQuickData(id)
end

function GC_SKILL_DISCARD(result)
end

function GC_SKILL_ERR(err)
	if err ~= "" then
		if err == "距离太远" and g_attackObj then
			startAStar(g_attackObj:getPositionX(), g_is3D and g_attackObj:getPositionY() or to2d(g_attackObj:getPositionY()))
		else
			主界面UI.showTipsMsg(1,txt(err))
		end
	end
	技能逻辑.m_usingSkill = false
	if g_moveUp or g_moveDown or g_moveLeft or g_moveRight or g_moveDirDown then
		doMoveRoleLogic()
	elseif (rightMouseDown or (LEFTMOVE and leftMouseDown and not g_target)) then
		doMoveRoleLogic()
	end
end

