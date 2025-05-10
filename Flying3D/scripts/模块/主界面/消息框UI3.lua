module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")

function onClose(e)
	ui:setVisible(false)
	ui.close:releaseMouse()
	e:stopPropagation()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

m_init = false
m_rmb = 0
m_price = 0
m_okfunc = nil

function setData(rmb, price, func)
	m_rmb = rmb
	m_price = price
	m_okfunc = func
	update()
end

function update()
	if not m_init then
		return
	end
	setMoneyType(m_rmb)
	ui.count:setTitleText(m_price)
end

function onOK(e)
	ui:setVisible(false)
	ui.ok:releaseMouse()
	e:stopPropagation()
	
	if m_okfunc then
		m_price = tonumber(ui.count:getTitleText())
		m_okfunc(m_rmb,m_price)
		m_okfunc = nil
	end
end

function onCancel(e)
	ui:setVisible(false)
	ui.cancel:releaseMouse()
	e:stopPropagation()
end

function setMoneyType(rmb)
	m_rmb = rmb
	--ui.money_0_img:setShaderType(rmb==1 and F3DImage.SHADER_GRAY or F3DImage.SHADER_NULL)
	--ui.money_0_img:setAlpha(rmb==1 and 0.5 or 1)
	--ui.money_2_img:setShaderType(rmb==1 and F3DImage.SHADER_NULL or F3DImage.SHADER_GRAY)
	--ui.money_2_img:setAlpha(rmb==1 and 1 or 0.5)
	ui.money_0:setDisable(m_rmb == 1)
	ui.money_0:setAlpha(rmb==1 and 0.5 or 1)
	ui.money_2:setDisable(m_rmb == 0)
	ui.money_2:setAlpha(rmb==1 and 1 or 0.5)
end

function onUIInit()
	ui.ok = ui:findComponent("ok")
	ui.ok:addEventListener(F3DMouseEvent.CLICK, func_me(onOK))
	ui.cancel = ui:findComponent("cancel")
	ui.cancel:addEventListener(F3DMouseEvent.CLICK, func_me(onCancel))
	ui.count = ui:findComponent("count")
	ui.money_0 = ui:findComponent("money_0")
	--ui.money_0:setBackground("")
	--ui.money_0_img = F3DImage:new()
	--ui.money_0_img:setTextureFile(UIPATH.."公用/money/money_0.png")
	--ui.money_0:addChild(ui.money_0_img)
	--ui.money_0:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
	--	setMoneyType(0)
	--end))
	ui.money_2 = ui:findComponent("money_2")
	--ui.money_2:setBackground("")
	--ui.money_2_img = F3DImage:new()
	--ui.money_2_img:setTextureFile(UIPATH.."公用/money/money_2.png")
	--ui.money_2:addChild(ui.money_2_img)
	--ui.money_2:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
	--	setMoneyType(1)
	--end))
	setMoneyType(1)
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
	ui:setMovable(true)
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."消息框UI3m.layout" or UIPATH.."消息框UI3.layout")
end
