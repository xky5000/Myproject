module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 主界面UI = require("主界面.主界面UI")
local 网络连接 = require("公用.网络连接")

sound = nil

function removeUI()
	if ui then
		ui:removeFromParent(true)
		ui = nil
	end
	if sound then
		sound:destory()
		sound = nil
	end
end

function onAskLogin(e)
	if not 网络连接.isConnected() then
		主界面UI.showTipsMsg(1, txt("服务器连接失败"))
		return
	end
	if not ui.zhanghao:isDefault() and ui.zhanghao:getTitleText() ~= "" then
		if ui.zhanghao:getTitleText():len() > 11 then
			主界面UI.showTipsMsg(1, txt("账号不能超过11个字符"))
		else
			__ARGS__.account = ui.zhanghao:getTitleText()
			消息.CG_ASK_LOGIN(__ARGS__.account, __PLATFORM__ or "", __ARGS__.server or 0, 1)
			--removeUI()
			e:stopPropagation()
		end
	else
		主界面UI.showTipsMsg(1, txt("请输入账号"),-290)
	end
	F3DSoundManager:instance():playSound("/res/sound/104.mp3")
end

function onUIInit()
	ui.zhanghao = ISMIRUI and tt(ui:findComponent("denglu,zhanghao"),F3DTextInput) or tt(ui:findComponent("zhanghao"),F3DTextInput)
	ui.queding = ISMIRUI and ui:findComponent("denglu,queding") or ui:findComponent("queding")
	ui.queding:addEventListener(F3DMouseEvent.CLICK, func_me(onAskLogin))
	if not sound then
		sound = F3DSoundManager:instance():playSound("/res/sound/log-in-long2.mp3", true)
	end
end

function initUI()
	if ui then
		uiLayer:removeChild(ui)
		uiLayer:addChild(ui, 0)
		ui:updateParent()
		ui:setVisible(true)
		return
	end
	ui = F3DLayout:new()
	uiLayer:addChild(ui, 0)
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(ISMIRUI and UIPATH.."登录UI.layout" or UIPATH.."登录UIs.layout")
end
