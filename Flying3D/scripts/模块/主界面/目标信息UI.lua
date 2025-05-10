module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")

m_init = false
m_goalinfo = nil

function setGoalInfo(objid,head,name,lv,hp,hpmax)
	m_goalinfo = {objid=objid,head=head,name=name,lv=lv,hp=hp,hpmax=hpmax}
	update()
end

function update()
	if not m_init or not m_goalinfo then
		return
	end
	
	if m_goalinfo.objid ~= -1 then
		ui:setVisible(true)
		
		ui.head:setBackground(全局设置.getHeadIconUrl(m_goalinfo.head))
		ui.level:setTitleText(m_goalinfo.lv)
		if(m_goalinfo.head > 10000) then
			ui.hp:setPercent(m_goalinfo.hp / m_goalinfo.hpmax)
			ui.hp:setTitleText(m_goalinfo.hp .. "/" .. m_goalinfo.hpmax)
		else
			ui.hp:setPercent(100 / 100)
			ui.hp:setTitleText("")
		end
	else
		ui:setVisible(false)
	end
end

function onHeadClick(e)
	if not m_init or not m_goalinfo then
		return
	end
	local role = g_roles[m_goalinfo.objid]
	if role and role.objtype == 全局设置.OBJTYPE_PLAYER then
		消息.CG_EQUIP_VIEW(role.objid,"")
	elseif role and role.objtype == 全局设置.OBJTYPE_MONSTER then
		setMainRoleTarget(role)
	end
end

function onUIInit()
	ui:setVisible(false)
	ui.head = ui:findComponent("头像")
	ui.head:addEventListener(F3DMouseEvent.CLICK, func_me(onHeadClick))
	ui.hp = tt(ui:findComponent("hp"), F3DProgress)
	ui.level = ui:findComponent("level")
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
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."目标信息UIm.layout" or UIPATH.."目标信息UI.layout")
end
