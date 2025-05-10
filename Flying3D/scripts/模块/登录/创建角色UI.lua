module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 名字表 = require("配置.名字表").Config
local 主界面UI = require("主界面.主界面UI")

sound = nil

rolename = ""
rolejob = 1
rolesex = 1

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

function onEnterGame(e)
	checkJobSex()
	if not ui.nameinput:isDefault() and ui.nameinput:getTitleText() ~= "" then
		if ui.nameinput:getTitleText():len() > 15 then
			主界面UI.showTipsMsg(1, txt("名字字数超过上限"))
		else
			
			rolename = ui.nameinput:getTitleText()
			--F3DPlatform:instance():navigateToURL('http://' .. 全局设置.SERVERS[__ARGS__.server or 0].ip .. ':' .. 全局设置.SERVERS[__ARGS__.server or 0].hport .. '/api/admin.php?method=createrole&account=' .. (__ARGS__.account or ""))
			消息.CG_CREATE_ROLE(utf8(rolename), rolesex, rolejob)
			--removeUI()
			e:stopPropagation()
		end
	else
		主界面UI.showTipsMsg(1, txt("请输入名字"))
	end
end

function checkJobSex()
	if ui.战士男:isSelected() then
		rolejob = 1
		rolesex = 1
	elseif ui.战士女:isSelected() then
		rolejob = 1
		rolesex = 2
	elseif ui.法师男:isSelected() then
		rolejob = 2
		rolesex = 1
	elseif ui.法师女:isSelected() then
		rolejob = 2
		rolesex = 2
	elseif ui.道士男:isSelected() then
		rolejob = 3
		rolesex = 1
	else
		rolejob = 3
		rolesex = 2
	end
end

function setJobSexEx(job, sex)
	rolejob = job
	rolesex = sex
	if job == 1 and sex == 1 then
		ui.战士男:setGroupSelected()
	elseif job == 1 and sex == 2 then
		ui.战士女:setGroupSelected()
	elseif job == 2 and sex == 1 then
		ui.法师男:setGroupSelected()
	elseif job == 2 and sex == 2 then
		ui.法师女:setGroupSelected()
	elseif job == 3 and sex == 1 then
		ui.道士男:setGroupSelected()
	else
		ui.道士女:setGroupSelected()
	end
end

function onUIInit()

	ui.战士男 = tt(ui:findComponent("zhong,战士男"),F3DCheckBox)
	ui.战士女 = tt(ui:findComponent("zhong,战士女"),F3DCheckBox)
	ui.法师男 = tt(ui:findComponent("zhong,法师男"),F3DCheckBox)
	ui.法师女 = tt(ui:findComponent("zhong,法师女"),F3DCheckBox)
	ui.道士男 = tt(ui:findComponent("zhong,道士男"),F3DCheckBox)
	ui.道士女 = tt(ui:findComponent("zhong,道士女"),F3DCheckBox)
	ui:findComponent("zhong,queding"):addEventListener(F3DMouseEvent.CLICK, func_me(onEnterGame))
	ui.nameinput = tt(ui:findComponent("zhong,mingzi"),F3DTextInput)
	setJobSexEx(1,1)
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
	ui:setLayout(ISMIRUI and UIPATH.."创建角色UI.layout" or UIPATH.."创建角色UIs.layout")
end
