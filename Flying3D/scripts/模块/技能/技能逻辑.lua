module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 主界面UI = require("主界面.主界面UI")
local 角色逻辑 = require("主界面.角色逻辑")
local 技能UI = require("技能.技能UI")

pointcache = F3DPoint:new()
if IS3G then
	keyCodes = {F3DKeyboardCode.J,F3DKeyboardCode.U,F3DKeyboardCode.I,F3DKeyboardCode.O,F3DKeyboardCode.L,F3DKeyboardCode.H}
elseif __PLATFORM__ == "MAC" then
	keyCodes = {F3DKeyboardCodeMac.Q,F3DKeyboardCodeMac.W,F3DKeyboardCodeMac.E,F3DKeyboardCodeMac.R,F3DKeyboardCodeMac.T,F3DKeyboardCodeMac.Y}
else
	keyCodes = {F3DKeyboardCode.Q,F3DKeyboardCode.W,F3DKeyboardCode.E,F3DKeyboardCode.R,F3DKeyboardCode.T,F3DKeyboardCode.Y}
end
autoUseSkill = false
m_skilltime = m_skilltime or {}
m_usingSkill = false

function setSkillInfo(info)
	for i,v in ipairs(g_skill) do
		g_skill[i] = nil
	end
	local index = 1
	for i,v in ipairs(info) do
		g_skill[index] = {
			infoid = v[1],
			lv = v[2],
			cd = v[3],
			damage1 = v[4],
			damage2 = v[5],
			type = v[6],
			range = v[7],
			icon = v[8],
			desc = v[9],
			skillid = v[10],
			name = v[11],
			passive = v[12],
			hangup = v[13],
			grade = v[14],
			lvmax = v[15],
			updamage1 = v[16],
			updamage2 = v[17],
			costlevel = v[18],
			costitem = v[19],
			hero = v[20],
			decmp = v[21],
			special = v[22],
			--time = F3DScheduler:instance():getRunningTime() + v[3],
			--keyCode = keyCodes[i],
		}
		index = index + 1
	end
	主界面UI.updateSkill()
	技能UI.update()
end

function findSkillIndex(infoid)
	if infoid == 0 then
		return
	end
	for i,v in ipairs(g_skill) do
		if v.infoid == infoid then
			return i
		end
	end
end

function findNormalSkillIndex()
	for i,v in ipairs(g_skill) do
		if v.special == 3 then
			return i
		end
	end
end

function findJumpSkillIndex()
	for i,v in ipairs(g_skill) do
		if v.special == 1 then
			return i
		end
	end
end

function findRunSkillIndex()
	for i,v in ipairs(g_skill) do
		if v.special == 2 then
			return i
		end
	end
end

--function checkKeyCode(keyCode)
--	for i,v in ipairs(g_skill) do
--		if v.keyCode == keyCode then
--			return i
--		end
--	end
--end

function onUseSkill(skillid)
	for i,v in ipairs(g_skill) do
		local index = 实用工具.indexOf(v.skillid, skillid)
		if index then
			local cdreduce = 角色逻辑.m_skillcdreduce
			local cd = cdreduce and math.ceil(v.cd * (1-cdreduce/100)) or v.cd
			m_skilltime[v.infoid] = F3DScheduler:instance():getRunningTime() + cd
			if #v.skillid > 1 then
				if index + 1 <= #v.skillid then
					v.nextskill = v.skillid[index + 1]
				else
					v.nextskill = v.skillid[1]
				end
				v.nexttime = rtime() + 1000
			end

			主界面UI.disableSkill(v.infoid, cd)
			break
		end
	end
end

function checkUseSkillDist()
	local maxdist = 0
	local maxcd = 0
	for i,v in ipairs(g_skill) do
		if v.passive == 0 and (v.special == 0 or v.special == 3) and v.hero == 0 and v.hangup == 1 and 角色逻辑.m_mp >= v.decmp and (m_skilltime[v.infoid] or 0) < F3DScheduler:instance():getRunningTime() then
			maxdist = math.max(maxdist, v.range)
		end
	end
	return (maxdist == 0 and #g_skill > 0) and g_skill[1].range or maxdist
end

function checkUseSkill(target)
	local skills = {}
	local maxcd = 0
	local normalatk = nil
	for i,v in ipairs(g_skill) do
		if v.passive == 0 and (v.special == 0 or v.special == 3) and v.hero == 0 and v.hangup == 1 and 角色逻辑.m_mp >= v.decmp and (m_skilltime[v.infoid] or 0) < F3DScheduler:instance():getRunningTime() then
			pointcache.x = target:getPositionX() - g_role:getPositionX()
			pointcache.y = target:getPositionY() - g_role:getPositionY()
			if v.type == 5 or pointcache:length() <= v.range - RANGEOFFSET then
				if v.special == 3 then
					normalatk = i
				elseif v.cd > maxcd then
					maxcd = v.cd
					skills = {}
					skills[#skills+1] = i
				elseif v.cd == maxcd then
					skills[#skills+1] = i
				end
			end
		end
	end
	if #skills > 0 then
		local id = #skills > 1 and math.random(1,#skills) or 1
		return skills[id]
	else
		return normalatk
	end
end

function doUseSkill(target, i, posx, posy)
	if not i then return end
	if not g_role or g_role.hp <= 0 or g_role.unattackable == 1 then return end
	local v = g_skill[i]
	if not v then return end
	if (m_skilltime[v.infoid] or 0) > F3DScheduler:instance():getRunningTime() then
		return
	end
	if v.type == 0 then
		if target == nil then
			主界面UI.showTipsMsg(1,txt("请选择一个目标"))
			return
		end
		if target and target.hp <= 0 then return end
		posx = target:getPositionX()
		posy = target:getPositionY()
	else
		pointcache.x = posx - g_role:getPositionX()
		pointcache.y = posy - g_role:getPositionY()
		if pointcache:length() > v.range - RANGEOFFSET then
			pointcache:normalize(v.range - RANGEOFFSET)
			posx = g_role:getPositionX() + pointcache.x
			posy = g_role:getPositionY() + pointcache.y
		end
	end
	
	
	
	--(v.nexttime and v.nexttime > rtime()) and 
	消息.CG_USE_SKILL(v.nextskill or v.skillid[1], target and target.objid or -1, posx, g_is3D and posy or to2d(posy))
	m_usingSkill = true
	return true
end

function setSkillBuff(objid,effid,time,icon)
	local role = g_roles[objid]
	if not role then return end
	if ISMIR2D then
		if effid == -1 then
			role:setDurationColor(1,0,0, time)
		elseif effid == -2 then
			role:setDurationColor(0,1,0, time)
		elseif effid == -3 then
			role:setDurationGray(time)
		elseif effid == -4 then
			role:setDurationColor(0,0,1, time)
		elseif effid == -5 or (effid == -6 and role == g_role) then
			role:setAlpha(0.5)
			role.alphaendtime = rtime()+time
		elseif effid == -6 then
			role:setVisible(false)
			role.disapearendtime = rtime()+time
		elseif effid ~= 0 then
			local es = role:setEffectSystem(全局设置.getAnimPackUrl(effid,true), true, nil, nil, 0, time/1000)
			if ISWZ then
				es:setScaleX(1.1)
				es:setScaleY(1.1)
			end
		end
	else
		if effid == -1 then
			role:setDurationColor(1,0,0, time)
		elseif effid == -2 then
			role:setDurationColor(0,1,0, time)
		elseif effid == -3 then
			role:setDurationGray(time)
		elseif effid == -4 then
			role:setDurationColor(0,0,1, time)
		elseif effid == -5 or (effid == -6 and role == g_role) then
			role:setAlpha(0.5)
			role.alphaendtime = rtime()+time
		elseif effid == -6 then
			role:setVisible(false)
			role.disapearendtime = rtime()+time
		elseif effid ~= 0 then
			role:setEffectSystem(全局设置.getEffectUrl(effid), true, nil, nil, 0, time/1000)
		end
	end
end
