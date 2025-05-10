module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 简单提示UI = require("主界面.简单提示UI")
local 消息框UI1 = require("主界面.消息框UI1")
local 消息框UI2 = require("主界面.消息框UI2")
local 主界面UI = require("主界面.主界面UI")

m_init = false
m_curpage = 1
m_skillinfo = nil
m_tabid = 0
tipsui = nil
tipsgrid = nil
discardskill = nil
ITEMCOUNT = 5

RANGETXT = {
	[0] = txt("单体"),
	[1] = txt("直线"),--矩形
	[2] = txt("半圆"),--扇形
	[3] = txt("圆形"),
	[4] = txt("范围"),--目标圆形
}

function update()
	if not m_init or g_skill == nil then
		return
	end
	m_skillinfo = {}
	for i,v in ipairs(g_skill) do
		if v.special ~= 0 then
		elseif m_tabid == 0 and v.hero == 0 then
			m_skillinfo[#m_skillinfo+1] = v
		elseif m_tabid == 1 and v.hero == 1 then
			m_skillinfo[#m_skillinfo+1] = v
		end
	end
	local index = (m_curpage-1)*ITEMCOUNT
	for i=1,ITEMCOUNT do
		local v = m_skillinfo[index+i]
		if v then
			ui.skills[i]:setVisible(true)
			if v.passive == 1 then
				ui.skills[i].desc:setTitleText(txt("被动技能"))
			else
				ui.skills[i].desc:setTitleText(txt("主动技能"))
			end
			
			ui.skills[i].grid:setTitleText(v.hangup == 1 and txt("挂") or "")
			ui.skills[i].name:setTitleText(txt(v.name))
			ui.skills[i].name:setTextColor(全局设置.getColorRgbVal(v.lv))--v.grade
			ui.skills[i].icon:setTextureFile(全局设置.getSkillIconUrl(v.icon))
			实用工具.setClipNumber(v.lv,ui.skills[i].lvpic)
			if not g_mobileMode then
				ui.skills[i].lvmax:setVisible(v.lv >= v.lvmax)
				ui.skills[i].upgrade:setVisible(v.lv < v.lvmax)
			end
		else
			ui.skills[i]:setVisible(false)
		end
	end
	local totalpage = math.ceil(#m_skillinfo / ITEMCOUNT)
	ui.page_cur:setTitleText(m_curpage.." / "..totalpage)
end

function onGridDown(e)
	local g = e:getCurrentTarget()
	if g == nil or not m_skillinfo or not m_skillinfo[(m_curpage-1)*ITEMCOUNT+g.id] then
		return
	end
	local p = e:getLocalPos()
	if g then
		ui.skills[g.id].grid:removeChild(ui.skills[g.id].icon)
		ui:addChild(ui.skills[g.id].icon)
		local x = g:getPositionX() + 8--2
		local y = g:getPositionY() + 8--2
		local p = g:getParent()
		while p and p ~= ui do
			x = x + p:getPositionX()
			y = y + p:getPositionY()
			p = p:getParent()
		end
		ui.skills[g.id].icon:setPositionX(x)
		ui.skills[g.id].icon:setPositionY(y)
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
		local x = p.x - ui.griddownpos.x + g:getPositionX() + 8--2
		local y = p.y - ui.griddownpos.y + g:getPositionY() + 8--2
		local p = g:getParent()
		while p and p ~= ui do
			x = x + p:getPositionX()
			y = y + p:getPositionY()
			p = p:getParent()
		end
		ui.skills[g.id].icon:setPositionX(x)
		ui.skills[g.id].icon:setPositionY(y)
		if g_mobileMode then
			x = x + ui.griddownpos.x
			y = y + ui.griddownpos.y
			if x < 0 or x > ui:getWidth()-(g_mobileMode and 290 or 0) or y < 0 or y > ui:getHeight() then
				x = x + ui:getPositionX()
				y = y + ui:getPositionY()
				local qid = 主界面UI.checkSkillQuickPos(x, y)
				if qid then
					ui:setAlpha(0.2)
					主界面UI.updateFightMode(2)
				end
			end
		end
	end
end

function onDiscardOK(count)
	if discardskill then
		消息.CG_SKILL_DISCARD(discardskill.infoid)
		discardskill = nil
	end
end

function onGridUp(e)
	if ui.griddownpos == nil then
		return
	end
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g then
		local x = ui.skills[g.id].icon:getPositionX() + ui.griddownpos.x
		local y = ui.skills[g.id].icon:getPositionY() + ui.griddownpos.y
		if x < 0 or x > ui:getWidth()-(g_mobileMode and 290 or 0) or y < 0 or y > ui:getHeight() then
			x = x + ui:getPositionX()
			y = y + ui:getPositionY()
			local qid = 主界面UI.checkSkillQuickPos(x, y)
			if qid then
				local 技能 = m_skillinfo[(m_curpage-1)*ITEMCOUNT+g.id]
				if 技能.passive == 0 and 技能.hero == 0 then
					主界面UI.setSkillQuickItem(qid, 技能.infoid)
				end
			--else
			--	discardskill = m_skillinfo[(m_curpage-1)*ITEMCOUNT+g.id]
			--	消息框UI2.hideUI()
			--	消息框UI1.initUI()
			--	消息框UI1.setData(txt("丢弃技能后无法恢复，是否丢弃该技能？"),onDiscardOK)
			end
		end
		ui.skills[g.id].icon:setPositionX(0)--2)
		ui.skills[g.id].icon:setPositionY(0)--2)
		ui.skills[g.id].grid:addChild(ui.skills[g.id].icon)
	end
	ui.griddownpos = nil
	ui:setAlpha(1)
	主界面UI.updateFightMode()
end

function checkTipsPos()
	if not ui or not tipsgrid then
		return
	end
	if not tipsui or not tipsui:isVisible() or not tipsui:isInited() then
	else
		local x = ui:getPositionX()+tipsgrid:getPositionX()+tipsgrid:getWidth()
		local y = ui:getPositionY()+tipsgrid:getPositionY()
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

function onGridOver(e)
	local g = g_mobileMode and e:getCurrentTarget() or e:getTarget()
	if g == nil or not m_skillinfo or not m_skillinfo[(m_curpage-1)*ITEMCOUNT+g.id] then
	elseif F3DUIManager.sTouchComp ~= g then
	else
		local v = m_skillinfo[(m_curpage-1)*ITEMCOUNT+g.id]
		简单提示UI.initUI()
		
		local 名称 = ""
		local 说明 = ""
		
		if v.passive == 1 then
			名称 = v.name.." [LV: "..v.lv.."]\n\n\n\n\n"..autoLine(v.desc,19)
		else
			名称 = v.name.." [LV: "..v.lv.."]\n\n冷却时间:"..(v.cd/1000).."秒\n法术值消耗:"..v.decmp.."点\n\n"..autoLine(v.desc,19)
		end
		
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

function onGridOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid and tipsui then
		简单提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
end

function onTabChange(e)
	m_tabid = ui.tab:getSelectIndex()
	m_curpage = 1
	update()
end

function onClose(e)
	if tipsui then
		简单提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui:setVisible(false)
	ui.close:releaseMouse()
	e:stopPropagation()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onUIInit()
	ui.close = ui:findComponent("关闭")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.skills = {}
	for i=1,ITEMCOUNT do
		ui.skills[i] = ui:findComponent("btncont,img_item_bg_"..i)
		ui.skills[i].desc = ui:findComponent("btncont,img_item_bg_"..i..",img_next_bg")
		ui.skills[i].name = ui:findComponent("btncont,img_item_bg_"..i..",component_1")
		ui.skills[i].grid = ui:findComponent("btncont,img_item_bg_"..i..",img_grid_bg")
		ui.skills[i].grid.id = i
		ui.skills[i].grid:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onGridDown))
		ui.skills[i].grid:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onGridMove))
		ui.skills[i].grid:addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onGridUp))
		ui.skills[i].grid:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
		ui.skills[i].grid:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		ui.skills[i].grid:addEventListener(F3DMouseEvent.RIGHT_CLICK, func_me(function(e)
			local btn = e:getCurrentTarget()
			if btn and m_skillinfo and m_skillinfo[(m_curpage-1)*ITEMCOUNT+btn.id] then
				local v = m_skillinfo[(m_curpage-1)*ITEMCOUNT+btn.id]
				消息.CG_SKILL_HANGUP(v.infoid, v.hangup == 1 and 0 or 1)
			end
		end))
		if g_mobileMode then
			ui.skills[i].grid:addEventListener(F3DMouseEvent.CLICK, func_me(onGridOver))
		end
		ui.skills[i].icon = F3DImage:new()
		ui.skills[i].icon:setPositionX(0)--2)
		ui.skills[i].icon:setPositionY(0)--2)
		ui.skills[i].grid:addChild(ui.skills[i].icon)
		ui.skills[i].clip_level = ui:findComponent("btncont,img_item_bg_"..i..",clip_lv")
		ui.skills[i].lvpic = ui.skills[i].clip_level:getBackground()
		if not g_mobileMode then
			ui.skills[i].lvmax = ui:findComponent("btncont,img_item_bg_"..i..",img_MAX")
			ui.skills[i].upgrade = ui:findComponent("btncont,img_item_bg_"..i..",button_blue_116X37")
			ui.skills[i].upgrade.id = i
			ui.skills[i].upgrade:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
				local btn = e:getCurrentTarget()
				if btn and m_skillinfo and m_skillinfo[(m_curpage-1)*ITEMCOUNT+btn.id] then
					消息.CG_SKILL_UPGRADE(m_skillinfo[(m_curpage-1)*ITEMCOUNT+btn.id].infoid)
				end
			end))
		end
	end
	ui.tab = tt(ui:findComponent("tab_1"), F3DTab)
	ui.tab:addEventListener(F3DUIEvent.CHANGE, func_me(onTabChange))
	ui.tab:setVisible(false)
	--ui.tab:getTabBtn(1):setDisable(true)
	ui.page_cur = ui:findComponent("btncont,page_cur")
	ui.page_pre = ui:findComponent("btncont,page_pre")
	ui.page_pre:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		if not m_skillinfo then
			return
		end
		local totalpage = math.ceil(#m_skillinfo / ITEMCOUNT)
		m_curpage = math.max(1, m_curpage - 1)
		update()
	end))
	ui.page_next = ui:findComponent("btncont,page_next")
	ui.page_next:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		if not m_skillinfo then
			return
		end
		local totalpage = math.ceil(#m_skillinfo / ITEMCOUNT)
		m_curpage = math.min(totalpage, m_curpage + 1)
		update()
	end))
	m_init = true
	update()
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if tipsui then
		简单提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	if ui then
		ui:setVisible(false)
	end
end

function toggle()
	if isHided() then
		initUI()
	else
		hideUI()
	end
end

function initUI()
	if ui then
		uiLayer:removeChild(ui)
		uiLayer:addChild(ui)
		ui:updateParent()
		ui:setVisible(true)
		return
	end
	ui = F3DLayout:new()
	uiLayer:addChild(ui)
	ui:setLoadPriority(getUIPriority())
	ui:setMovable(true)
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ITEMCOUNT = g_mobileMode and 6 or 5
	ui:setLayout(g_mobileMode and UIPATH.."技能UIm.layout" or UIPATH.."技能UI.layout")
end
