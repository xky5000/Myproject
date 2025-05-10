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
m_titlepicindex = 0
m_countnum = 0
m_countnummax = 0
m_okfunc = nil

titlepictb = {
	UIPATH.."image/标题_提示.png",--提示
	UIPATH.."image/标题_使用.png",--使用
	UIPATH.."image/标题_拆分.png",--拆分
	UIPATH.."image/标题_寄售.png",--寄售
	UIPATH.."image/标题_购买.png",--购买
}

function setData(index, num, nummax, func)
	m_titlepicindex = index
	m_countnum = num
	m_countnummax = nummax
	m_okfunc = func
	update()
end

function update()
	if not m_init or m_titlepicindex == 0 then
		return
	end
	ui.count:setTitleText(m_countnum)
end

function onOK(e)
	ui:setVisible(false)
	ui.ok:releaseMouse()
	e:stopPropagation()
	if m_okfunc then
		m_countnum = tonumber(ui.count:getTitleText())
		m_okfunc(m_countnum)
		m_okfunc = nil
	end
end

function onCancel(e)
	ui:setVisible(false)
	ui.cancel:releaseMouse()
	e:stopPropagation()
end

function onDec(e)
	m_countnum = tonumber(ui.count:getTitleText())
	m_countnum = math.max(1, m_countnum - 1)
	ui.count:setTitleText(m_countnum)
	e:stopPropagation()
end

function onAdd(e)
	m_countnum = tonumber(ui.count:getTitleText())
	m_countnum = math.min(m_countnummax, m_countnum + 1)
	ui.count:setTitleText(m_countnum)
	e:stopPropagation()
end

function onMax(e)
	ui.count:setTitleText(m_countnummax)
	e:stopPropagation()
end

function onUIInit()
	ui.ok = ui:findComponent("ok")
	ui.ok:addEventListener(F3DMouseEvent.CLICK, func_me(onOK))
	ui.cancel = ui:findComponent("cancel")
	ui.cancel:addEventListener(F3DMouseEvent.CLICK, func_me(onCancel))
	ui.count = ui:findComponent("count")
	ui.dec = ui:findComponent("dec")
	ui.dec:addEventListener(F3DMouseEvent.CLICK, func_me(onDec))
	ui.add = ui:findComponent("add")
	ui.add:addEventListener(F3DMouseEvent.CLICK, func_me(onAdd))
	ui.max = ui:findComponent("max")
	ui.max:addEventListener(F3DMouseEvent.CLICK, func_me(onMax))
	ui.max:setVisible(false)
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
	ui:setLayout(g_mobileMode and UIPATH.."消息框UI2m.layout" or UIPATH.."消息框UI2.layout")
end
