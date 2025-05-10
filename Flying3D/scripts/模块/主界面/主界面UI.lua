module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 小地图UI = require("主界面.小地图UI")
local 任务追踪UI = require("主界面.任务追踪UI")
local 聊天UI = require("主界面.聊天UI")
local 角色UI = require("主界面.角色UI")
local 背包UI = require("主界面.背包UI")
local 头像信息UI = require("主界面.头像信息UI")
local 英雄信息UI = require("主界面.英雄信息UI")
local 宠物UI = require("宠物.宠物UI")
local 技能逻辑 = require("技能.技能逻辑")
local 宠物信息UI = require("宠物.宠物信息UI")
local 技能UI = require("技能.技能UI")
local 锻造UI = require("主界面.锻造UI")
local 商城UI = require("主界面.商城UI")
local 角色逻辑 = require("主界面.角色逻辑")
local 获得提示UI = require("主界面.获得提示UI")
local Boss信息UI = require("主界面.Boss信息UI")
local 队伍信息UI = require("主界面.队伍信息UI")
local 目标信息UI = require("主界面.目标信息UI")
local 活动UI = require("主界面.活动UI")
local 简单提示UI = require("主界面.简单提示UI")
local 地图表 = require("配置.地图表")
local 物品提示UI = require("主界面.物品提示UI")
local 装备提示UI = require("主界面.装备提示UI")
local 装备对比提示UI = require("主界面.装备对比提示UI")
local 宠物蛋提示UI = require("主界面.宠物蛋提示UI")
local 行会UI = require("主界面.行会UI")
local 消息框UI1 = require("主界面.消息框UI1")

m_init = false
m_tipsmsgcont1 = nil
m_tipsmsgcont2 = nil
m_tipsmsgcont3 = nil
m_tipsmsgcont4 = nil
m_tipsmsgs = {}
m_tipsrollmsgs = {}
m_tipsmsg3 = nil
m_tipsheartbeat = 0
m_tipsrollheartbeat1 = 0
m_tipsrollheartbeat2 = 0
m_quickid = nil
m_skillquickid = nil
m_xpinfo = nil
m_ptcache = F3DPoint:new()
m_startMoveDir = false
m_touchid = -1
tipsskill = nil
tipsskillmove = false
tipsui = nil
tipsgrid = nil
m_autofight = nil
m_autofindpath = nil
ROCKEROFFSET = 20

function update()
	if not m_init then return end
	
	if not g_mobileMode and ISMIRUI then
		

	end
end

function updateExp()
	if not m_init or not ui.exp then return end
	ui.exp:setMaxVal(角色逻辑.m_expmax)
	ui.exp:setCurrVal(角色逻辑.m_exp)
end

function updatePower()
	if not m_init or not ui.zhanli then return end
	实用工具.setClipNumber(角色逻辑.m_totalpower,ui.zhanli)
end

function setXPInfo(status,cd,cdmax,icon)
	m_xpinfo = {status=status,cd=cd,cdmax=cdmax,icon=icon}
	updateXP()
end

function updateXP()
	if not m_init or not m_xpinfo or not ui.xphead then return end
	if m_xpinfo.status == 0 then
		ui.xphead:setVisible(false)
		ui.xptext:setVisible(false)
		ui.xpprogress:setCurrVal(m_xpinfo.cd)
		ui.xpprogress:setMaxVal(m_xpinfo.cdmax)
		ui.xpprogress:doAnim(m_xpinfo.cdmax, (m_xpinfo.cdmax - m_xpinfo.cd) / 1000)
	elseif m_xpinfo.status == 1 then
		ui.xphead:setVisible(true)
		ui.xpimg:setTextureFile(全局设置.getSkillIconUrl(m_xpinfo.icon))
		ui.xptext:setVisible(true)
		ui.xpprogress:setCurrVal(m_xpinfo.cd)
		ui.xpprogress:setMaxVal(m_xpinfo.cdmax)
	elseif m_xpinfo.status == 2 then
		ui.xphead:setVisible(false)
		ui.xptext:setVisible(false)
		ui.xpprogress:setCurrVal(m_xpinfo.cd)
		ui.xpprogress:setMaxVal(m_xpinfo.cdmax)
		ui.xpprogress:doAnim(0, m_xpinfo.cd / 1000)
	end
end

function setQuickData(id)
	m_quickid = id
	updateQuick()
end

function setSkillQuickData(id)
	m_skillquickid = id
	updateSkill()
end

function initBGUI()
	bg = F3DComponent:new()
	bg:setPositionX(stage:getWidth()/5)
	bg:setPositionY(stage:getHeight()-stage:getHeight()/5)
	bg:setBackground("/res/game/direction_key_2.png")
	bg:getBackground():setPivot(0.5,0.5)
	bg:setAlpha(0.5)
	uiLayer:addChild(bg)

	btn = F3DComponent:new()
	btn:setBackground("/res/game/direction_key_1.png")
	btn:getBackground():setPivot(0.5,0.5)
	bg:addChild(btn)
end

function checkSkillQuickPos(px, py)
	if not m_init then return end
	--local top = ui:findComponent("top")
	local x = px - ui:getPositionX()-- - top:getPositionX()
	local y = py - ui:getPositionY()-- - top:getPositionY()
	local qbg = ui.skillbgs[1]
	while qbg and qbg:getParent() and qbg:getParent() ~= ui do
		qbg = qbg:getParent()
		x = x - qbg:getPositionX()
		y = y - qbg:getPositionY()
	end
	for i=1,6 do
		local skillbg = ui.skillbgs[i]
		if x >= skillbg:getPositionX() and x <= skillbg:getPositionX() + skillbg:getWidth() and
			y >= skillbg:getPositionY() and y <= skillbg:getPositionY() + skillbg:getHeight() then
			return i
		end
	end
end

function setSkillQuickItem(id, infoid)
	if not m_init or not m_skillquickid then return end
	for i=1,6 do
		if m_skillquickid[i] == infoid then
			m_skillquickid[i] = 0
		end
	end
	m_skillquickid[id] = infoid
	消息.CG_SKILL_QUICK_SETUP(m_skillquickid)
end

function checkQuickPos(px, py)
	if not m_init then return end
	--local top = ui:findComponent("top")
	local x = px - ui:getPositionX()-- - top:getPositionX()
	local y = py - ui:getPositionY()-- - top:getPositionY()
	local qbg = ui.quickbgs[1]
	while qbg and qbg:getParent() and qbg:getParent() ~= ui do
		qbg = qbg:getParent()
		x = x - qbg:getPositionX()
		y = y - qbg:getPositionY()
	end
	for i=1,6 do
		local quickbg = ui.quickbgs[i]
		if x >= quickbg:getPositionX() and x <= quickbg:getPositionX() + quickbg:getWidth() and
			y >= quickbg:getPositionY() and y <= quickbg:getPositionY() + quickbg:getHeight() then
			return i
		end
	end
end

function setQuickItem(id, itemid)
	if not m_init or not m_quickid then return end
	for i=1,6 do
		if m_quickid[i] == itemid then
			m_quickid[i] = 0
		end
	end
	m_quickid[id] = itemid
	消息.CG_QUICK_SETUP(m_quickid)
end

function setQuick(i, itemid)
	if not m_init then return end
	if ui.quickimg[i].itemid == itemid then
		return
	end
	if itemid == 0 then
		ui.quickimg[i].pic:setTextureFile("")
		ui.quickcnt[i]:setText("")
		ui.quickcdimg[i]:setFrameRate(0)
		ui.quickcdimg[i]:setVisible(false)
		ui.quickimg[i].itemid = 0
		return
	end
	local icon = 背包UI.getItemIcon(itemid)
	ui.quickimg[i].itemid = itemid
	ui.quickimg[i].pic:setTextureFile(全局设置.getItemIconUrl(icon))
	ui.quickcnt[i]:setText(背包UI.getItemCount(itemid))
	local cd, cdmax = 背包UI.getItemCD(itemid), 背包UI.getItemCDMax(itemid)
	if cd > rtime() and cdmax > 0 then
		local frameid = math.floor((1 - (cd - rtime()) / cdmax) * 32)
		ui.quickcdimg[i]:setVisible(true)
		ui.quickcdimg[i]:setFrameRate(1000*(32-frameid)/(cd - rtime()), frameid)
	else
		ui.quickcdimg[i]:setFrameRate(0)
		ui.quickcdimg[i]:setVisible(false)
	end
end

function updateQuick()
	if not m_init or not m_quickid then return end
	for i=1,6 do
		setQuick(i, m_quickid[i] or 0)
	end
end

function updateQuickItem()
	if not m_init then return end
	for i=1,6 do
		if ui.quickimg[i].itemid ~= 0 then
			local icon = 背包UI.getItemIcon(ui.quickimg[i].itemid)
			if icon ~= 0 then
				ui.quickimg[i].pic:setTextureFile(全局设置.getItemIconUrl(icon))
			end
			ui.quickcnt[i]:setText(背包UI.getItemCount(ui.quickimg[i].itemid))
			local cd, cdmax = 背包UI.getItemCD(ui.quickimg[i].itemid), 背包UI.getItemCDMax(ui.quickimg[i].itemid)
			if cd > rtime() and cdmax > 0 then
				local frameid = math.floor((1 - (cd - rtime()) / cdmax) * 32)
				ui.quickcdimg[i]:setVisible(true)
				ui.quickcdimg[i]:setFrameRate(1000*(32-frameid)/(cd - rtime()), frameid)
			else
				ui.quickcdimg[i]:setFrameRate(0)
				ui.quickcdimg[i]:setVisible(false)
			end
		end
	end
end

function DoUseQuick(id)
	if not m_init then return end
	if ui.quickimg[id] and ui.quickimg[id].itemid ~= 0 then
		背包UI.DoUseItem(ui.quickimg[id].itemid)
	end
end

function checkKeyCode(keyCode)
	if not m_init or not m_skillquickid then
		return
	end
	for i,v in ipairs(技能逻辑.keyCodes) do
		if v == keyCode and m_skillquickid[i] ~= 0 then
			local id = nil
			if i == 1 and g_role:isHitFly() then
				id = 技能逻辑.findJumpSkillIndex()
			elseif i == 1 and g_role.status == 1 and g_role:getAnimName() == "run" then
				id = 技能逻辑.findRunSkillIndex()
			else
				id = 技能逻辑.findSkillIndex(m_skillquickid[i])
			end
			return id
		end
	end
end

function updateSkill()
	if not m_init or not m_skillquickid then return end
	for i=1,6 do
		local id = 技能逻辑.findSkillIndex(m_skillquickid[i])
		if id and (not g_mobileMode or i > ((ISWZ or ISZY) and 1 or 1)) then
			ui.skillbgs[i].id = id
			local icon = g_skill[id].icon
			ui.skillimg[i]:setTextureFile(icon > 10000 and 全局设置.getBossHeadUrl(icon) or 全局设置.getSkillIconUrl(icon))
		else
			ui.skillbgs[i].id = id or 0
			ui.skillimg[i]:setTextureFile("")
			ui.skillcdimg[i]:setFrameRate(0)
			ui.skillcdimg[i]:setVisible(false)
		end
	end
end

function disableSkill(index, time)
	if not m_init or not m_skillquickid then return end
	for i=1,6 do
		if m_skillquickid[i] == index then
			ui.skillcdimg[i]:setVisible(true)
			ui.skillcdimg[i]:setFrameRate(((ISWZ or ISZY) and i == 1 and 14000 or 32000)/time, 0)
			break
		end
	end
end

function onCDPlayOut(e)
	e:getTarget():setFrameRate(0)
	e:getTarget():setVisible(false)
end

function onSkillGridDown(e)
	local g = e:getCurrentTarget()
	if g == nil or g_skill[g.id] == nil then
		return
	end
	local p = e:getLocalPos()
	if g then
		ui.skillbgs[g.pid]:removeChild(ui.skillimg[g.pid])
		ui:addChild(ui.skillimg[g.pid])
		local x = g:getPositionX() + (ISMIRUI and 3 - 4 or 6)
		local y = g:getPositionY() + (ISMIRUI and 2 - 3 or 5)
		local p = g:getParent()
		while p and p ~= ui do
			x = x + p:getPositionX()
			y = y + p:getPositionY()
			p = p:getParent()
		end
		ui.skillimg[g.pid]:setPositionX(x)
		ui.skillimg[g.pid]:setPositionY(y)
	end
	ui.skillgriddownpos = {x=p.x,y=p.y}
end

function onSkillGridMove(e)
	if ui.skillgriddownpos == nil then
		return
	end
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g then
		local x = p.x - ui.skillgriddownpos.x + g:getPositionX() + (ISMIRUI and 3 - 4 or 6)
		local y = p.y - ui.skillgriddownpos.y + g:getPositionY() + (ISMIRUI and 2 - 3 or 5)
		local p = g:getParent()
		while p and p ~= ui do
			x = x + p:getPositionX()
			y = y + p:getPositionY()
			p = p:getParent()
		end
		ui.skillimg[g.pid]:setPositionX(x)
		ui.skillimg[g.pid]:setPositionY(y)
	end
end

function onSkillGridUp(e)
	if ui.skillgriddownpos == nil then
		return
	end
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g then
		local x = ui.skillimg[g.pid]:getPositionX() + ui.skillgriddownpos.x
		local y = ui.skillimg[g.pid]:getPositionY() + ui.skillgriddownpos.y
		if x < 0 or x > ui:getWidth() or y < (ISMIRUI and 0 or -50) or y > ui:getHeight() then
			x = x + ui:getPositionX()
			y = y + ui:getPositionY()
			setSkillQuickItem(g.pid, 0)
		else
			x = x + ui:getPositionX()
			y = y + ui:getPositionY()
			local qid = checkSkillQuickPos(x, y)
			if qid and m_skillquickid then
				local infoid = m_skillquickid[g.pid]
				if m_skillquickid[qid] and m_skillquickid[qid] ~= 0 then
					setSkillQuickItem(g.pid, m_skillquickid[qid])
				end
				setSkillQuickItem(qid, infoid)
			end
		end
		ui.skillimg[g.pid]:setPositionX(ISMIRUI and 3 - 4 or 6)
		ui.skillimg[g.pid]:setPositionY(ISMIRUI and 2 - 3 or 5)
		ui.skillbgs[g.pid]:addChild(ui.skillimg[g.pid])
	end
	ui.skillgriddownpos = nil
end

function onSkillDown(e)
	local g = e:getCurrentTarget()
	if g and g_skill[g.id] == nil and g_mobileMode and g.pid == 1 then
		local gid = 技能逻辑.findNormalSkillIndex()
		if gid then
			local attackObj = findAttackObj(g_skill[gid].range - RANGEOFFSET)
			技能逻辑.doUseSkill(attackObj, gid, attackObj and attackObj:getPositionX() or g_role:getPositionX(), attackObj and attackObj:getPositionY() or g_role:getPositionY())
		end
	elseif g == nil or (g_skill[g.id] == nil and g.pid ~= 11) then
	elseif F3DUIManager.sTouchComp ~= g then
	elseif g_mobileMode and IS3G and g.pid == 11 then
		if g_role.hp > 0 and not g_role:isHitFly() and g_role.unmovable ~= 1 and g_role.unattackable ~= 1 then
			g_role:startHitFly(0.6, 200, 0.3, 0.3, 0)
			g_role:setAnimName("jump","",true,true)
			g_role.isjump = true
			消息.CG_CHANGE_STATUS(101,-1)
		end
	elseif g_mobileMode and IS3G then
		local gid = g.id
		if gid == 1 and g_role:isHitFly() then
			gid = 技能逻辑.findJumpSkillIndex()
		elseif gid == 1 and g_role.status == 1 and g_role:getAnimName() == "run" then
			gid = 技能逻辑.findRunSkillIndex()
		end
		if g_movedir.x ~= 0 or g_movedir.y ~= 0 then
			g_movedir:normalize(50)
		else
			g_movedir.x = 50
		end
		技能逻辑.doUseSkill(findAttackObj(g_skill[gid].range - RANGEOFFSET), gid, g_role:getPositionX()+g_movedir.x*8, g_role:getPositionY()+g_movedir.y*8)
	elseif g_mobileMode and (ISWZ or ISZY) then
		local attackObj = findAttackObj(g_skill[g.id].range - RANGEOFFSET)
		技能逻辑.doUseSkill(attackObj, g.id, attackObj and attackObj:getPositionX() or g_role:getPositionX(), attackObj and attackObj:getPositionY() or g_role:getPositionY())
	elseif g_skill[g.id].type == 0 or g_skill[g.id].type == 3 or g_skill[g.id].type == 5 or g_skill[g.id].range == 0 then
		local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
		技能逻辑.doUseSkill(findAttackObj(g_skill[g.id].range - RANGEOFFSET), g.id, pos.x, pos.y)
	else
		if not ISMIR2D then
			local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
			local es = g_role:setEffectSystem(全局设置.getEffectUrl(2965), false, nil, nil, 0, -1)
			es:setScale(1, 1, 1)
			if es then
				es:setPositionX(pos.x)
				es:setPositionY(pos.y)
				es:setPositionZ(g_scene and g_scene:getTerrainHeight(pos.x, pos.y) or 0)
			end
		end
		tipsskillmove = true
	end
	e:stopPropagation()
end

function onSkillMove(e)
	if ui.skillgriddownpos ~= nil then
		onSkillGridMove(e)
		return
	end
	local g = e:getCurrentTarget()
	if g == nil or g_skill[g.id] == nil or g_skill[g.id].range == 0 then
	elseif tipsskillmove then
		if not ISMIR2D then
			local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
			local es = g_role:getEffectSystem(全局设置.getEffectUrl(2965))
			if es then
				es:setPositionX(pos.x)
				es:setPositionY(pos.y)
				es:setPositionZ(g_scene and g_scene:getTerrainHeight(pos.x, pos.y) or 0)
			end
		end
	end
end

function onSkillUp(e)
	local g = e:getCurrentTarget()
	if g == nil or g_skill[g.id] == nil or g_skill[g.id].range == 0 then
	elseif tipsskillmove then
		local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
		技能逻辑.doUseSkill(findAttackObj(g_skill[g.id].range - RANGEOFFSET), g.id, pos.x, pos.y)
		if not ISMIR2D then
			g_role:removeEffectSystem(全局设置.getEffectUrl(2965))
		end
		tipsskillmove = nil
	end
end

function checkTipsPos()
	if not ui or not tipsgrid then
		return
	end
	if not tipsui or not tipsui:isVisible() or not tipsui:isInited() then
	else
		local x = ui:getPositionX()+tipsgrid:getPositionX()
		local y = ui:getPositionY()+tipsgrid:getPositionY()-tipsui:getHeight()
		local p = tipsgrid:getParent()
		while p and p ~= ui do
			x = x + p:getPositionX()
			y = y + p:getPositionY()
			p = p:getParent()
		end
		if x + tipsui:getWidth() > stage:getWidth() then
			tipsui:setPositionX(x - tipsui:getWidth() - tipsgrid:getWidth())
		else
			tipsui:setPositionX(x)
		end
		if y + tipsui:getHeight() > stage:getHeight() then
			tipsui:setPositionY(stage:getHeight() - tipsui:getHeight())
		else
			tipsui:setPositionY(y)
		end
	end
end

RANGETXT = {
	[0] = ("单体"),
	[1] = ("直线"),--矩形
	[2] = ("半圆"),--扇形
	[3] = ("圆形"),
	[4] = ("范围"),--目标圆形
}

function onGridDown(e)
	local g = e:getCurrentTarget()
	if g == nil or ui.quickimg[g.id] == nil or ui.quickimg[g.id].itemid == 0 then
		return
	end
	local p = e:getLocalPos()
	if g then
		ui.quickbgs[g.id]:removeChild(ui.quickimg[g.id])
		ui:addChild(ui.quickimg[g.id])
		local x = g:getPositionX() + 0
		local y = g:getPositionY() + 0
		local p = g:getParent()
		while p and p ~= ui do
			x = x + p:getPositionX()
			y = y + p:getPositionY()
			p = p:getParent()
		end
		ui.quickimg[g.id]:setPositionX(x)
		ui.quickimg[g.id]:setPositionY(y)
	end
	ui.griddownpos = {x=p.x,y=p.y}
end

function onGridMove(e)
	if ui.griddownpos == nil then
		return
	end
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g then
		local x = p.x - ui.griddownpos.x + g:getPositionX() + 0
		local y = p.y - ui.griddownpos.y + g:getPositionY() + 0
		local p = g:getParent()
		while p and p ~= ui do
			x = x + p:getPositionX()
			y = y + p:getPositionY()
			p = p:getParent()
		end
		ui.quickimg[g.id]:setPositionX(x)
		ui.quickimg[g.id]:setPositionY(y)
	end
end

function onGridUp(e)
	if ui.griddownpos == nil then
		return
	end
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g then
		local x = ui.quickimg[g.id]:getPositionX() + ui.griddownpos.x
		local y = ui.quickimg[g.id]:getPositionY() + ui.griddownpos.y
		if x < 0 or x > ui:getWidth() or y < (ISMIRUI and 0 or -50) or y > ui:getHeight() then
			x = x + ui:getPositionX()
			y = y + ui:getPositionY()
			setQuickItem(g.id, 0)
		else
			x = x + ui:getPositionX()
			y = y + ui:getPositionY()
			local qid = checkQuickPos(x, y)
			if qid then
				if ui.quickimg[qid] and ui.quickimg[qid].itemid ~= 0 then
					setQuickItem(g.id, ui.quickimg[qid].itemid)
				end
				setQuickItem(qid, ui.quickimg[g.id].itemid)
			end
		end
		ui.quickimg[g.id]:setPositionX(-1)
		ui.quickimg[g.id]:setPositionY(-1)
		ui.quickbgs[g.id]:addChild(ui.quickimg[g.id])
	end
	ui.griddownpos = nil
end

function onGridOver(e)
	local g = e:getTarget()
	if g == nil or ui.quickimg[g.id] == nil or ui.quickimg[g.id].itemid == 0 then
	elseif F3DUIManager.sTouchComp ~= g then
	elseif 背包UI.getItemCount(ui.quickimg[g.id].itemid) > 0 then
		local v = ui.quickimg[g.id]
		简单提示UI.initUI()
		
		local 名称 = 背包UI.getItemName(v.itemid).."\n\n\n\n"..背包UI.getItemDesc(v.itemid)
		简单提示UI.setItemData(全局设置.getItemIconUrl(背包UI.getItemIcon(v.itemid)),名称,背包UI.getItemGrade(v.itemid),背包UI.getItemDesc(v.itemid))
		tipsui = 简单提示UI.ui
		tipsgrid = g
		if not tipsui:isInited() then
			tipsui:addEventListener(F3DObjEvent.OBJ_INITED, func_oe(checkTipsPos))
		else
			checkTipsPos()
		end
	end
end

function onGridOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid and tipsui then
		简单提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
end

function onSkillOver(e)
	local g = e:getTarget()
	if g == nil or g_skill[g.id] == nil then
	else
		if g_skill[g.id].range > 0 and not ISMIR2D then
			local es = g_role:setEffectSystem(全局设置.getEffectUrl(2967), true)
			es:setScale(g_skill[g.id].range / 100, g_skill[g.id].range / 100, 1)
		end
		tipsskill = g
		if F3DUIManager.sTouchComp ~= g then
		else
			local v = g_skill[g.id]
			简单提示UI.initUI()
			
			local 名称 = ""
			local 说明 = ""
			
			名称 = v.name.." [LV: "..v.lv.."]\n\n冷却时间:"..(v.cd/1000).."秒\n法术值消耗:"..v.decmp.."点\n\n"..autoLine(v.desc,19)
			简单提示UI.setItemData(全局设置.getSkillIconUrl(v.icon),名称,v.lv,说明,v)
			
			tipsui = 简单提示UI.ui
			tipsgrid = g
			if not tipsui:isInited() then
				tipsui:addEventListener(F3DObjEvent.OBJ_INITED, func_oe(checkTipsPos))
			else
				checkTipsPos()
			end
		end
	end
end

function onSkillOut(e)
	local g = e:getTarget()
	if g ~= nil and tipsskill == g then
		if not ISMIR2D then
			g_role:removeEffectSystem(全局设置.getEffectUrl(2967))
		end
		tipsskill = nil
		if g == tipsgrid and tipsui then
			简单提示UI.hideUI()
			tipsui = nil
			tipsgrid = nil
		end
	end
end

function onQuickDown(e)
	local g = e:getCurrentTarget()
	if g == nil or ui.quickimg[g.id] == nil or ui.quickimg[g.id].itemid == 0 then
	elseif F3DUIManager.sTouchComp ~= g then
	else
		背包UI.DoUseItem(ui.quickimg[g.id].itemid)
	end
end

function onExpGridOver(e)
	local g = e:getTarget()
	if g == nil then
	else
		if g == ui.exptext then
			ui.exptext:setTitleText(角色逻辑.m_exp.." / "..角色逻辑.m_expmax)
		end
		tipsgrid = g
	end
end

function onExpGridOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid then
		ui.exptext:setTitleText("")
		tipsgrid = nil
	end
end

function onMouseOver(e)
	
	local g = e:getTarget()
	if g == nil then
		
	else
		if g == ui.button_role then
			ui.button_role:setTitleText(txt("人物(C)"))
		elseif g == ui.button_bag then
			ui.button_bag:setTitleText(txt("包裹(B)"))
		elseif g == ui.button_skill then
			ui.button_skill:setTitleText(txt("技能(V)"))
		end
		tipsgrid = g
	end
end

function onMouseOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid then
		if g == ui.button_role then
			ui.button_role:setTitleText("")
		elseif g == ui.button_bag then
			ui.button_bag:setTitleText("")
		elseif g == ui.button_skill then
			ui.button_skill:setTitleText("")
		end
		
		tipsgrid = nil
	end
end

function getUILocalPos(comp,stageX,stageY)
	local x = comp:getPositionX()
	local y = comp:getPositionY()
	local p = comp:getParent()
	while p and p ~= uiLayer do
		x = x + p:getPositionX()
		y = y + p:getPositionY()
		p = p:getParent()
	end
	return stageX - x, stageY - y
end

function updateRockerPos(localposx,localposy)
	local centerx = ui.chassis:getPositionX()+ui.chassis:getWidth()/2-ui.rocker:getWidth()/2
	local centery = ui.chassis:getPositionY()+ui.chassis:getHeight()/2-ui.rocker:getHeight()/2
	local posx = ui.chassis:getPositionX()+localposx-ui.rocker:getWidth()/2
	local posy = ui.chassis:getPositionY()+localposy-ui.rocker:getHeight()/2
	m_ptcache:setVal(posx-centerx,posy-centery)
	if m_ptcache:length() > ui.chassis:getWidth()/2 then
		m_ptcache:normalize(ui.chassis:getWidth()/2)
	end
	ui.rocker:setPositionX(centerx+m_ptcache.x)
	ui.rocker:setPositionY(centery+m_ptcache.y)
	return m_ptcache.x, m_ptcache.y
end

function checkZuoxiaTouchable()
	if not F3DUIManager.sTouchComp or F3DUIManager.sTouchComp == ui.zuoxia then
		return true
	end
	local p = F3DUIManager.sTouchComp:getParent()
	while p and p ~= ui.zuoxia do
		p = p:getParent()
	end
	return p == ui.zuoxia
end

function onChassisDown(e)
	if not checkZuoxiaTouchable() then
		return
	end
	if m_touchid == -1 then
		local zuoxiaposx,zuoxiaposy = getUILocalPos(ui.zuoxia,e:getStageX(),e:getStageY())
		if zuoxiaposx < 0 or zuoxiaposx > ui.zuoxia:getWidth() or zuoxiaposy < 0 or zuoxiaposy > ui.zuoxia:getHeight() then
		else
			local localposx,localposy = getUILocalPos(ui.chassis,e:getStageX(),e:getStageY())
			local rockerposx,rockerposy = localposx-ui.rockerposx,localposy-ui.rockerposy--getUILocalPos(ui.rocker,e:getStageX(),e:getStageY())
			local rockermovex,rockermovey = updateRockerPos(localposx,localposy)
			m_touchid = e:getID()
			ui.rocker:setState(F3DComponent.STATE_HOVER)
			if rockerposx < ROCKEROFFSET or rockerposx > ui.rocker:getWidth()-ROCKEROFFSET or rockerposy < ROCKEROFFSET or rockerposy > ui.rocker:getHeight()-ROCKEROFFSET then
				setMoveDir(rockermovex,-rockermovey,1)
				m_startMoveDir = true
			else
				autoPickItem()
			end
		end
	end
end

function onChassisMove(e)
	if not checkZuoxiaTouchable() then
		return
	end
	if m_touchid == e:getID() then
		local localposx,localposy = getUILocalPos(ui.chassis,e:getStageX(),e:getStageY())
		local rockerposx,rockerposy = localposx-ui.rockerposx,localposy-ui.rockerposy--getUILocalPos(ui.rocker,e:getStageX(),e:getStageY())
		local rockermovex,rockermovey = updateRockerPos(localposx,localposy)
		if not m_startMoveDir and (rockerposx < ROCKEROFFSET or rockerposx > ui.rocker:getWidth()-ROCKEROFFSET or rockerposy < ROCKEROFFSET or rockerposy > ui.rocker:getHeight()-ROCKEROFFSET) then
			setMoveDir(rockermovex,-rockermovey,1)
			m_startMoveDir = true
		elseif m_startMoveDir then
			setMoveDir(rockermovex,-rockermovey,2)
		end
	end
end

function onChassisUp(e)
	if m_touchid == e:getID() then
		ui.rocker:setPositionX(ui.chassis:getPositionX()+ui.chassis:getWidth()/2-ui.rocker:getWidth()/2)
		ui.rocker:setPositionY(ui.chassis:getPositionY()+ui.chassis:getHeight()/2-ui.rocker:getHeight()/2)
		ui.rocker:setState(F3DComponent.STATE_NORMAL)
		if m_startMoveDir then
			setMoveDir(0,0)
			m_startMoveDir = false
		end
		m_touchid = -1
	end
end

function onChassisWinDown(e)
	if not checkZuoxiaTouchable() then
		return
	end
	local localposx,localposy = getUILocalPos(ui.chassis,e:getStageX(),e:getStageY())
	local rockerposx,rockerposy = localposx-ui.rockerposx,localposy-ui.rockerposy--getUILocalPos(ui.rocker,e:getStageX(),e:getStageY())
	local rockermovex,rockermovey = updateRockerPos(localposx,localposy)
	ui.rocker:setState(F3DComponent.STATE_HOVER)
	if rockerposx < ROCKEROFFSET or rockerposx > ui.rocker:getWidth()-ROCKEROFFSET or rockerposy < ROCKEROFFSET or rockerposy > ui.rocker:getHeight()-ROCKEROFFSET then
		setMoveDir(rockermovex,-rockermovey,1)
		m_startMoveDir = true
	else
		autoPickItem()
	end
end

function onChassisWinMove(e)
	if not checkZuoxiaTouchable() then
		return
	end
	local localposx,localposy = getUILocalPos(ui.chassis,e:getStageX(),e:getStageY())
	local rockerposx,rockerposy = localposx-ui.rockerposx,localposy-ui.rockerposy--getUILocalPos(ui.rocker,e:getStageX(),e:getStageY())
	local rockermovex,rockermovey = updateRockerPos(localposx,localposy)
	if not m_startMoveDir and (rockerposx < ROCKEROFFSET or rockerposx > ui.rocker:getWidth()-ROCKEROFFSET or rockerposy < ROCKEROFFSET or rockerposy > ui.rocker:getHeight()-ROCKEROFFSET) then
		setMoveDir(rockermovex,-rockermovey,1)
		m_startMoveDir = true
	elseif m_startMoveDir then
		setMoveDir(rockermovex,-rockermovey,2)
	end
end

function onChassisWinUp(e)
	ui.rocker:setPositionX(ui.chassis:getPositionX()+ui.chassis:getWidth()/2-ui.rocker:getWidth()/2)
	ui.rocker:setPositionY(ui.chassis:getPositionY()+ui.chassis:getHeight()/2-ui.rocker:getHeight()/2)
	ui.rocker:setState(F3DComponent.STATE_NORMAL)
	if m_startMoveDir then
		setMoveDir(0,0)
		m_startMoveDir = false
	end
end

function updateFightMode(fightMode)
	if fightMode then
		fightMode = fightMode == 1
	else
		fightMode = 头像信息UI.m_fightMode
	end
	if g_mobileMode then
		--ui:findComponent("zuoxia"):setVisible(fightMode)
		--ui:findComponent("xia"):setVisible(not fightMode)
		--ui:findComponent("youxia"):setVisible(fightMode)
		--ui:findComponent("menu"):setVisible(fightMode)
	end
	--updateSimpleMode(fightMode)
end

function updateSimpleMode(fightMode)
	if fightMode then
		fightMode = fightMode == 1
	else
		fightMode = 头像信息UI.m_fightMode
	end
	if not 小地图UI.m_simpleMode then--(not g_mobileMode or not fightMode) and 
		聊天UI.initUI()
		任务追踪UI.initUI()
		获得提示UI.initUI()
	else
		聊天UI.hideUI()
		任务追踪UI.hideUI()
		获得提示UI.hideUI()
	end
	--if not 小地图UI.m_simpleMode then
	--	活动UI.initUI()
	--else
	--	活动UI.hideUI()
	--end
	--聊天UI.toggle()
	--任务追踪UI.toggle()
	--获得提示UI.toggle()
	--活动UI.toggle()
end

function checkFindPathPos(x, y)
	if 快捷传送 == 1 and m_autofindpath:isVisible() and x >= m_autofindpath:getPositionX()+8 and x <= m_autofindpath:getPositionX()+8+48 and
		y >= m_autofindpath:getPositionY()+215 and y <= m_autofindpath:getPositionY()+215+48 then
		return true
	else
		return false
	end
end

function onUIInit()
	if g_mobileMode then
		F3DTouchProcessor:instance():addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(function(e)
			local g = F3DUIManager.sTouchComp
			while g do
				if g == 物品提示UI.ui or g == 装备提示UI.ui or g == 装备对比提示UI.ui or g == 宠物蛋提示UI.ui or g == 简单提示UI.ui then
					return
				end
				g = g:getParent()
			end
			背包UI.hideAllTipsUI()
		end))
		ui.zuoxia = ui:findComponent("zuoxia")
		ui.chassis = ui:findComponent("zuoxia,Control,Chassis")
		ui.rocker = ui:findComponent("zuoxia,Control,Button_Rocker")
		ui.rockerposx = ui.rocker:getPositionX() - ui.chassis:getPositionX()
		ui.rockerposy = ui.rocker:getPositionY() - ui.chassis:getPositionY()
		if __PLATFORM__ == "WIN" or __PLATFORM__ == "MAC" then
			ui.zuoxia:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onChassisWinDown))
			ui.zuoxia:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onChassisWinMove))
			ui.zuoxia:addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onChassisWinUp))
		else
			F3DTouchProcessor:instance():addEventListener(F3DTouchEvent.BEGIN, func_te(onChassisDown))
			F3DTouchProcessor:instance():addEventListener(F3DTouchEvent.MOVE, func_te(onChassisMove))
			F3DTouchProcessor:instance():addEventListener(F3DTouchEvent.END, func_te(onChassisUp))
		end
	end
	local shp = F3DShape:new()
	shp:drawCircle(g_mobileMode and F3DPoint:new(35,35) or F3DPoint:new(16,16), g_mobileMode and 35 or 16)
	local qshp = F3DShape:new()
	qshp:drawCircle(g_mobileMode and F3DPoint:new(32,32) or F3DPoint:new(16,16), g_mobileMode and 32 or 16)
	ui.skillbgs = {}
	ui.skillbg11 = nil
	ui.skillimg = {}
	ui.skillcdimg = {}
	ui.quickbgs = {}
	ui.quickimg = {}
	ui.quickcnt = {}
	ui.quickcdimg = {}
	if g_mobileMode and IS3G then
		local skillbg = ui:findComponent("youxia,Skill_box_11")
		skillbg.id = 0
		skillbg.pid = 11
		skillbg:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onSkillDown))
		skillbg:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onSkillMove))
		skillbg:addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onSkillUp))
		ui.skillbg11 = skillbg
	end
	for i=0,5 do
		local img = F3DImage:new()
		img:setPositionX(g_mobileMode and 9 or ISMIRUI and 3 - 4 or 6)
		img:setPositionY(g_mobileMode and 9 or ISMIRUI and 2 - 3 or 5)
		img:setWidth(g_mobileMode and 70 or 32)
		img:setHeight(g_mobileMode and 70 or 32)
		--img:setMask(shp)
		local cd = F3DComponent:new()
		if not g_mobileMode or i > 0 then
			if g_mobileMode and (ISWZ or ISZY) and i == 0 then
				cd:setBackground(UIPATH.."主界面/cd2.png")
				cd:setSizeClips("14,1,0,0")
				cd:setWidth(g_mobileMode and 70 or 32)
				cd:setHeight(g_mobileMode and 70 or 32)
			else
				cd:setBackground(UIPATH.."主界面/cd.png")
				cd:setSizeClips("32,1,0,0")
				cd:setWidth(g_mobileMode and 70 or 32)
				cd:setHeight(g_mobileMode and 70 or 32)
				--cd:getBackground():setMask(shp)
			end
			cd:addEventListener(F3DObjEvent.OBJ_PLAYOUT, func_oe(onCDPlayOut))
		end
		cd:setVisible(false)
		img:addChild(cd)
		ui.skillimg[i+1] = img
		ui.skillcdimg[i+1] = cd
		local skillbg = g_mobileMode and ui:findComponent("youxia,Skill_box_"..(i+1)) or ISMIRUI and ui:findComponent("top,skillbg_"..i) or ui:findComponent("skillbg_"..i)
		skillbg.id = 0
		skillbg.pid = i+1
		if not g_mobileMode then
			skillbg:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onSkillGridDown))
			skillbg:addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onSkillGridUp))
			skillbg:addEventListener(F3DMouseEvent.RIGHT_DOWN, func_me(onSkillDown))
			skillbg:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onSkillMove))
			skillbg:addEventListener(F3DMouseEvent.RIGHT_UP, func_me(onSkillUp))
			skillbg:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onSkillOver))
			skillbg:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onSkillOut))
		else
			skillbg:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onSkillDown))
			skillbg:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onSkillMove))
			skillbg:addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onSkillUp))
		end
		skillbg:addChild(img)
		ui.skillbgs[i+1] = skillbg
		local qimg = F3DImage:new()
		qimg.itemid = 0
		qimg:setPositionX(g_mobileMode and 4 or 3 - 4)
		qimg:setPositionY(g_mobileMode and 4 or 2 - 3)
		qimg:setWidth(g_mobileMode and 64 or 32)
		qimg:setHeight(g_mobileMode and 64 or 32)
		--qimg:setMask(qshp)
		qimg.pic = F3DImage:new()
		qimg.pic:setPositionX(math.floor(qimg:getWidth()/2))
		qimg.pic:setPositionY(math.floor(qimg:getHeight()/2))
		qimg.pic:setPivot(0.5,0.5)
		qimg:addChild(qimg.pic)
		local qcnt = F3DTextField:new()
		if g_mobileMode then
			qcnt:setTextFont("宋体",16,false,false,false)
		end
		qcnt:setPivot(0.5,0)
		qcnt:setPositionX(g_mobileMode and 32 or 18)
		qimg:addChild(qcnt)
		local qcd = F3DComponent:new()
		qcd:setBackground(UIPATH.."主界面/cd.png")
		qcd:setSizeClips("32,1,0,0")
		qcd:setWidth(g_mobileMode and 64 or 32)
		qcd:setHeight(g_mobileMode and 64 or 32)
		if g_mobileMode or not ISMIRUI then
			qcd:getBackground():setMask(qshp)
		end
		qcd:addEventListener(F3DObjEvent.OBJ_PLAYOUT, func_oe(onCDPlayOut))
		qcd:setVisible(false)
		qimg:addChild(qcd)
		ui.quickimg[i+1] = qimg
		ui.quickcnt[i+1] = qcnt
		ui.quickcdimg[i+1] = qcd
		local quickbg = g_mobileMode and ui:findComponent("xia,component_2,Props_box_"..(i+1)) or ISMIRUI and ui:findComponent("top,quickBg_"..i) or ui:findComponent("quickBg_"..i)
		quickbg.id = i+1
		if not g_mobileMode then
			quickbg:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onGridDown))
			quickbg:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onGridMove))
			quickbg:addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onGridUp))
			quickbg:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
			quickbg:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
			quickbg:addEventListener(F3DMouseEvent.RIGHT_DOWN, func_me(onQuickDown))
		else
			quickbg:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onQuickDown))
		end
		quickbg:addChild(qimg)
		ui.quickbgs[i+1] = quickbg
	end
	
	ui.button_role = g_mobileMode and ui:findComponent("menu,component_2,button_role") or ISMIRUI and ui:findComponent("top,role") or ui:findComponent("button_role")

	ui.button_role:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		if not 角色UI.isHided() and 角色UI.m_tabid ~= 0 then--角色逻辑.m_rolejob-1 then
			角色UI.setTabID(0)--角色逻辑.m_rolejob-1)
		else
			角色UI.setTabID(0)--角色逻辑.m_rolejob-1)
			角色UI.toggle()
		end
	end))
	ui.button_role:addEventListener(F3DUIEvent.MOUSE_OVER,func_ue(onMouseOver))
	ui.button_role:addEventListener(F3DUIEvent.MOUSE_OUT,func_ue(onMouseOut))
	
	
	ui.button_bag = g_mobileMode and ui:findComponent("menu,component_2,button_bag") or ISMIRUI and ui:findComponent("top,bag") or ui:findComponent("button_bag")
	ui.button_bag:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		背包UI.toggle()
	end))
	ui.button_bag:addEventListener(F3DUIEvent.MOUSE_OVER,func_ue(onMouseOver))
	ui.button_bag:addEventListener(F3DUIEvent.MOUSE_OUT,func_ue(onMouseOut))
	
	ui.button_skill = g_mobileMode and ui:findComponent("menu,component_2,button_skill") or ISMIRUI and ui:findComponent("top,skill") or ui:findComponent("button_skill")
	ui.button_skill:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		技能UI.toggle()
	end))
	ui.button_skill:addEventListener(F3DUIEvent.MOUSE_OVER,func_ue(onMouseOver))
	ui.button_skill:addEventListener(F3DUIEvent.MOUSE_OUT,func_ue(onMouseOut))
	
	
	
	--[[
	ui.button_pet = g_mobileMode and ui:findComponent("menu,component_2,button_pet") or ISMIRUI and ui:findComponent("top,pet") or ui:findComponent("button_pet")
	ui.button_pet:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		宠物UI.toggle()
	end))
	if not ISZY or g_mobileMode then
		ui.button_pet:setVisible(false)
	end
	
	ui.button_strength = g_mobileMode and ui:findComponent("menu,component_2,button_strength") or ISMIRUI and ui:findComponent("top,strength") or ui:findComponent("button_strength")
	ui.button_strength:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		锻造UI.toggle()
	end))
	if not ISZY or g_mobileMode then
		ui.button_strength:setVisible(false)
	end
	
	ui.button_faction = g_mobileMode and ui:findComponent("menu,component_2,button_faction") or ISMIRUI and ui:findComponent("top,faction") or ui:findComponent("button_faction")
	ui.button_faction:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		--showTipsMsg(1,txt("暂未开放"))
		行会UI.toggle()
	end))
	if not ISZY or g_mobileMode then
		ui.button_faction:setVisible(false)
	end
	
	ui.button_shop = g_mobileMode and ui:findComponent("menu,component_2,button_shop") or ISMIRUI and ui:findComponent("top,shop") or ui:findComponent("button_shop")
	ui.button_shop:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		商城UI.toggle()
	end))
	
	if g_mobileMode then
		ui:findComponent("menu"):setVisible(false)
	end
	if not g_mobileMode and ISMIRUI then
		ui.button_sound = ui:findComponent("top,sound")
		ui.button_sound:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
			setOpenSound(not g_openSound)
			F3DSoundManager:instance():playSound("/res/sound/105.mp3")
			聊天UI.添加文本("",-1,0,"音效开关: "..(g_openSound and "#cff00,开" or "#cff0000,关"))
		end))
	end
	]]
	
	ui.exp = ISMIRUI and tt(ui:findComponent("top,exp"),F3DProgress) or tt(ui:findComponent("exp"),F3DProgress)
	ui.exptext = ui.exp
	ui.exptext:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onExpGridOver))
	ui.exptext:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onExpGridOut))

	m_init = true
	updateSkill()
	updateQuick()
	updateXP()
	updateExp()
	updateFightMode()
end

function initUI()
	if ui then
		--uiLayer:removeChild(ui)
		--uiLayer:addChild(ui)
		ui:updateParent()
		ui:setVisible(true)
		return
	end
	ui = F3DLayout:new()
	获得提示UI.initUI()
	uiLayer:addChild(ui)
	ui:setLoadPriority(getUIPriority())
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."战斗界面UIm.layout" or ISMIRUI and UIPATH.."主界面UI.layout" or UIPATH.."主界面UIs.layout")
	--活动UI.initUI()
	--Boss信息UI.initUI()
	--队伍信息UI.initUI()
	--英雄信息UI.initUI()
	--宠物信息UI.initUI()
	
	任务追踪UI.initUI()
	头像信息UI.initUI()
	聊天UI.initUI()
	目标信息UI.initUI()
	小地图UI.initUI()
	
end

function initAutoFight()
	m_autofight = F3DImageAnim:new()
	m_autofight:setAnimPack("/res/animpack/9000/9000.animpack")
	m_autofight:setPositionX(stage:getWidth() / 2 - 110)
	m_autofight:setPositionY(stage:getHeight() / 2 - 90)
	m_autofight:setVisible(false)
	uiLayer:addChild(m_autofight)
	
	
	m_autofindpath = F3DImageAnim:new()
	m_autofindpath:setAnimPack("/res/animpack/9001/9001.animpack")
	m_autofindpath:setPositionX(stage:getWidth() / 2 - 126)
	m_autofindpath:setPositionY(stage:getHeight() / 2 - 60)
	m_autofindpath:setVisible(false)
	shapeLayer:addChild(m_autofindpath)
	
	--[[
	m_autofindpath = F3DImage:new()
	m_autofindpath:setTextureFile(快捷传送 == 1 and UIPATH.."手机界面/8005.png" or UIPATH.."手机界面/8004.png")
	m_autofindpath:setPositionX(stage:getWidth()-(快捷传送 == 1 and 310 or 300))
	m_autofindpath:setPositionY(130)
	m_autofindpath:setVisible(false)
	shapeLayer:addChild(m_autofindpath)
	]]
end

function initTipsCont()
	initAutoFight()
	stage:addEventListener(F3DEvent.RESIZE, func_e(onStageResize))
	m_tipsmsgcont1 = F3DDisplayContainer:new()
	m_tipsmsgcont1:setPositionX(math.floor(stage:getWidth()/2))
	m_tipsmsgcont1:setPositionY(150)--200)
	shapeLayer:addChild(m_tipsmsgcont1)
	m_tipsmsgcont2 = F3DDisplayContainer:new()
	m_tipsmsgcont2:setPositionX(math.floor(stage:getWidth()/2))
	m_tipsmsgcont2:setPositionY(stage:getHeight()-100)
	shapeLayer:addChild(m_tipsmsgcont2)
	m_tipsmsgcont3 = F3DDisplayContainer:new()
	m_tipsmsgcont3:setPositionX(math.floor(stage:getWidth()/2))
	m_tipsmsgcont3:setPositionY((not g_mobileMode and ISMIRUI) and 120 or 150)--stage:getHeight()-150)
	shapeLayer:addChild(m_tipsmsgcont3)
	m_tipsmsgcont4 = F3DDisplayContainer:new()
	m_tipsmsgcont4:setVisible(false)
	m_tipsmsgcont4:setPositionX(math.floor(stage:getWidth()/2))
	m_tipsmsgcont4:setPositionY(85)
	m_tipsmsgcont4:setClipRect(-250,-20,500,40)
	m_tipsmsgcont4.bg = F3DImage:new()
	m_tipsmsgcont4.bg:setWidth(500)
	m_tipsmsgcont4.bg:setHeight(g_mobileMode and 30 or 20)
	m_tipsmsgcont4.bg:setPivot(0.5,0.5)
	m_tipsmsgcont4.bg:setTextureFile("tex_white")
	m_tipsmsgcont4.bg:setColor(0.2,0.2,0.2)
	m_tipsmsgcont4.bg:setAlpha(0.8)
	m_tipsmsgcont4:addChild(m_tipsmsgcont4.bg)
	shapeLayer:addChild(m_tipsmsgcont4)
end

function showTipsMsg(postype, msg,_y)
	if(_y == nil) then
		_y = -180
	end
	
	if postype == 3 then
		if m_tipsmsg3 == nil then
			m_tipsmsg3 = F3DRichTextField:new()
			m_tipsmsg3:getTitle():setPivot(0.5,1)
			--m_tipsmsg3:setTextColor(0xff0000,0xff0000ff)
			m_tipsmsg3:setTextColor(0xff00ff)
			m_tipsmsg3:getTitle():setTextFont(F3DPlatform:instance():convert("楷体"), 24, false, false, false)
			m_tipsmsgcont3:addChild(m_tipsmsg3)
		end
		m_tipsmsg3:setTitleText(msg)
		if msg ~= "" then
			m_tipsheartbeat = g_heartbeatcnt + 50
		end
		return
	elseif postype == 5 then
		消息框UI1.initUI()
		消息框UI1.setData(msg)
		return
	end
	if msg == "" then return end
	local tf = nil
	for i,v in ipairs(m_tipsmsgs) do
		if not v:isVisible() then
			tf = v
			break
		end
	end
	if tf == nil then
		tf = F3DRichTextField:new()
		m_tipsmsgs[#m_tipsmsgs+1] = tf
	end
	if postype == 0 then
		tf:getTitle():setPivot(0.5,1)
		tf:setTextColor(0xffff00)
		tf:setPositionX(0)
	elseif postype == 1 then
		tf:getTitle():setPivot(0.5,1)
		tf:setTextColor(0xff0000)
		tf:setPositionX(0)
	else
		tf:getTitle():setPivot(0,0.5)
		tf:setTextColor(0xff00ff)
		tf:setPositionX(250)
	end
	tf:setVisible(true)
	tf:setTitleText((g_mobileMode and "#s16," or "")..msg)
	tf:setPositionY(_y)
	if postype == 0 then
		m_tipsmsgcont1:addChild(tf)
	elseif postype == 1 then
		m_tipsmsgcont2:addChild(tf)
	else
		m_tipsrollmsgs[#m_tipsrollmsgs+1] = tf
	end
	local sec = 1
	if postype == 0 or postype == 1 then
		local prop = F3DTweenProp:new()
		prop:push("y", -40 + _y, F3DTween.TYPE_LINEAR)
		local sec = 1
		F3DTween:fromPool():start(tf, prop, sec, func_n(function()
			tf:setVisible(false)
			tf:removeFromParent()
		end))
	end
end

function onHeartBeat()
	if m_tipsheartbeat > 0 and g_heartbeatcnt >= m_tipsheartbeat then
		showTipsMsg(3,"")
		m_tipsheartbeat = 0
	end
	if m_tipsrollheartbeat1 > 0 and g_heartbeatcnt < m_tipsrollheartbeat1 then
	elseif #m_tipsrollmsgs > 0 then
		local tf = m_tipsrollmsgs[1]
		table.remove(m_tipsrollmsgs, 1)
		m_tipsmsgcont4:setVisible(true)
		m_tipsmsgcont4:addChild(tf)
		local w = 聊天UI.calcTextWidth(tf:getTitleText(), g_mobileMode and 16 or 12)
		local prop = F3DTweenProp:new()
		prop:push("x", -250-w, F3DTween.TYPE_LINEAR)
		local sec = (500+w)/50
		F3DTween:fromPool():start(tf, prop, sec, func_n(function()
			tf:setVisible(false)
			tf:removeFromParent()
		end))
		m_tipsrollheartbeat1 = g_heartbeatcnt + ((50+w)/50)*10
		m_tipsrollheartbeat2 = g_heartbeatcnt + ((500+w)/50)*10
	elseif m_tipsrollheartbeat2 > 0 and g_heartbeatcnt < m_tipsrollheartbeat2 then
	else
		m_tipsrollheartbeat1 = 0
		m_tipsrollheartbeat2 = 0
		m_tipsmsgcont4:setVisible(false)
	end
end

function onStageResize()
	聊天UI.checkResize()
	背包UI.checkResize()
	if bg then
		bg:setPositionX(stage:getWidth()/5)
		bg:setPositionY(stage:getHeight()-stage:getHeight()/5)
	end
	if m_tipsmsgcont1 then
		m_tipsmsgcont1:setPositionX(math.floor(stage:getWidth()/2))
		m_tipsmsgcont1:setPositionY(150)--200)
	end
	if m_tipsmsgcont2 then
		m_tipsmsgcont2:setPositionX(math.floor(stage:getWidth()/2))
		m_tipsmsgcont2:setPositionY(stage:getHeight()-100)
	end
	if m_tipsmsgcont3 then
		m_tipsmsgcont3:setPositionX(math.floor(stage:getWidth()/2))
		m_tipsmsgcont3:setPositionY((not g_mobileMode and ISMIRUI) and 120 or 150)--stage:getHeight()-150)
	end
	if m_tipsmsgcont4 then
		m_tipsmsgcont4:setPositionX(math.floor(stage:getWidth()/2))
		m_tipsmsgcont4:setPositionY(85)
	end
	m_autofight:setPositionX(stage:getWidth() / 2 - 110)
	m_autofight:setPositionY(stage:getHeight() / 2 - 90)
	m_autofindpath:setPositionX(stage:getWidth() / 2 - 114)
	m_autofindpath:setPositionY(stage:getHeight() / 2 - 74)
	
end
