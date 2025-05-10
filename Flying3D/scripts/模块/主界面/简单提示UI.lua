module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 背包UI = require("主界面.背包UI")

m_init = false
m_itemdata = nil
m_skill = nil

function setItemData(iconurl,name,grade,desc,skill)
	m_itemdata = {iconurl=iconurl,name=name,grade=grade,desc=desc}
	m_skill = skill
	update()
end

COLORBG = {
	"",
	UIPATH.."image/界面_气泡背景颜色1.png",
	UIPATH.."image/界面_气泡背景颜色2.png",
	UIPATH.."image/界面_气泡背景颜色3.png",
	UIPATH.."image/界面_气泡背景颜色4.png",
}

function update()
	if not m_init or not m_itemdata then
		return
	end
	
	ui.name:setTitleText(txt(m_itemdata.name))
	ui.name:setTextColor(全局设置.getColorRgbVal(m_itemdata.grade))
	if g_mobileMode then
		ui.menus[1]:setTitleText((m_skill ~= nil and m_skill.hangup == 1) and txt("关闭挂机") or txt("开启挂机"))
		ui.menus[1]:setVisible(m_skill ~= nil)
		ui.menus[2]:setVisible(m_skill ~= nil and m_skill.lv < m_skill.lvmax)
		ui.levelmax:setVisible(m_skill ~= nil and m_skill.lv >= m_skill.lvmax)
	end
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onMenuClick(e)
	local g = e:getCurrentTarget()
	if g == ui.menus[1] then
		if m_skill ~= nil then
			消息.CG_SKILL_HANGUP(m_skill.infoid, m_skill.hangup == 1 and 0 or 1)
		end
	elseif g == ui.menus[2] then
		if m_skill ~= nil then
			消息.CG_SKILL_UPGRADE(m_skill.infoid)
		end
	end
	背包UI.hideAllTipsUI()
end

function onUIInit()
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.grid = ui:findComponent("grid")
	ui.name = ui:findComponent("name")
	ui.menus = {}
	if g_mobileMode then
		for i = 1,2 do
			ui.menus[i] = ui:findComponent("menu_"..i)
			ui.menus[i]:addEventListener(F3DMouseEvent.CLICK, func_me(onMenuClick))
		end
		ui.levelmax = ui:findComponent("img_MAX")
	end
	m_init = true
	update()
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
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
	if not g_mobileMode then
		ui:setTouchable(false)
	end
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."简单提示UIm.layout" or UIPATH.."简单提示UI.layout")
end
