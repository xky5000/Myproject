module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 背包UI = require("主界面.背包UI")

m_init = false
m_itemdata = nil
m_isbag = false

function setItemData(itemdata, isbag)
	m_itemdata = itemdata
	m_isbag = isbag
	update()
end

function setEmptyItemData()
	if not m_init then
		return
	end
	ui.color:setBackground(COLORBG[1])
	ui.img:setTextureFile("")
	ui.grade:setTextureFile("")
	ui.name:setTitleText("")
	ui.name:setTextColor(全局设置.getColorRgbVal(1))
	ui.desc:setTitleText("")
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
	ui.color:setBackground(COLORBG[m_itemdata.grade])
	ui.img:setTextureFile(全局设置.getItemIconUrl(m_itemdata.icon))
	ui.grade:setTextureFile(全局设置.getGradeUrl(m_itemdata.grade))
	ui.name:setTitleText(txt(m_itemdata.name))
	ui.name:setTextColor(m_itemdata.color > 0 and m_itemdata.color or 全局设置.getColorRgbVal(m_itemdata.grade))
	ui.desc:setTitleText(txt(m_itemdata.desc))
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onMenuClick(e)
	local g = e:getCurrentTarget()
	if g == ui.menus[1] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onUse(e)
	elseif g == ui.menus[2] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onBatchUse(e)
	elseif g == ui.menus[3] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onDivide(e)
	elseif g == ui.menus[4] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onDiscard(e)
	elseif g == ui.menus[5] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onSell(e)
	end
	背包UI.hideAllTipsUI()
end

function onUIInit()
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.grid = ui:findComponent("图标")
	ui.name = ui:findComponent("名称")
	ui.desc = ui:findComponent("说明")
	ui.color = ui:findComponent("颜色")
	ui.img = F3DImage:new()
	--ui.img:setPositionX(2)
	--ui.img:setPositionY(2)
	ui.img:setPositionX(math.floor(ui.grid:getWidth()/2))
	ui.img:setPositionY(math.floor(ui.grid:getHeight()/2))
	ui.img:setPivot(0.5,0.5)
	ui.grid:addChild(ui.img)
	ui.grade = F3DImage:new()
	ui.grade:setPositionX(1)
	ui.grade:setPositionY(1)
	ui.grade:setWidth(ui.grid:getWidth()-2)
	ui.grade:setHeight(ui.grid:getHeight()-2)
	ui.grid:addChild(ui.grade)
	m_init = true
	setEmptyItemData()
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
	ui:setLayout(g_mobileMode and UIPATH.."物品提示UIm.layout" or UIPATH.."物品提示UI.layout")
end
