module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 角色逻辑 = require("主界面.角色逻辑")
local 地图表 = require("配置.地图表")
local 主界面UI = require("主界面.主界面UI")

m_init = false
m_info = nil
m_myinfo = nil
m_curtype = 1
m_pool = {}
m_poolindex = 1

function setInfo(info,myinfo)
	m_info = info
	m_myinfo = myinfo
	update()
end

function setHeroInfo(info,myinfo)
	m_info = info
	m_myinfo = myinfo
	update()
end

function setPetInfo(info,myinfo)
	m_info = info
	m_myinfo = myinfo
	update()
end

function setVIPSpreadInfo(info,myinfo)
	m_info = info
	m_myinfo = myinfo
	update()
end

function update()
	if not m_init or not m_info or not m_myinfo then
		return
	end
	ui.排行表标头:findComponent("component_3"):setTitleText((m_curtype==1 or m_curtype==2 or m_curtype==4) and txt("职业") or txt("星级"))
	ui.排行表标头:findComponent("component_5"):setTitleText((m_curtype==1 or m_curtype==2) and txt("转生") or m_curtype==4 and txt("推广有效人数") or txt("所属"))
	ui.排行表标头:findComponent("component_4"):setTitleText(m_curtype==4 and txt("推广人数") or txt("等级"))
	ui.排行表标头:findComponent("component_6"):setTitleText(m_curtype==4 and txt("VIP成长经验") or txt("战斗力"))
	ui.list:removeAllItems()
	m_poolindex = 1
	for i,v in ipairs(m_info) do
		local item = nil
		if #m_pool >= m_poolindex then
			item = m_pool[m_poolindex]
			m_poolindex = m_poolindex + 1
		else
			item = tt(ui.checkbox:clone(),F3DCheckBox)
			item.查看 = item:findComponent("查看")
			item.查看:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
				if e:getCurrentTarget().name then
					消息.CG_EQUIP_VIEW(-1,e:getCurrentTarget().name)
				end
			end))
			m_pool[m_poolindex] = item
			m_poolindex = m_poolindex + 1
		end
		item:findComponent("排名"):setBackground(
			v[1]==1 and UIPATH.."排行榜/第一.png" or
			v[1]==2 and UIPATH.."排行榜/第二.png" or
			v[1]==3 and UIPATH.."排行榜/第三.png" or UIPATH.."排行榜/排行通用.png")
		item:findComponent("排名"):setTitleText(v[1]>3 and v[1] or "")
		item:findComponent("名字"):setTitleText(txt(v[2]))
		if m_curtype==1 or m_curtype==2 or m_curtype==4 then
			item:findComponent("职业"):setTitleText(txt(全局设置.获取职业类型(v[3])))
		else
			item:findComponent("职业"):setTitleText(v[3])
		end
		item:findComponent("等级"):setTitleText(v[4])
		item:findComponent("转生"):setTitleText(v[5]=="" and txt("无") or txt(v[5]))
		item:findComponent("战斗力"):setTitleText(v[6])
		item.查看:setVisible(m_curtype ~= 3)
		item.查看.name = v[2]
		ui.list:addItem(item)
	end
	if #m_myinfo > 0 then
		v = m_myinfo[1]
		ui.mycheckbox:findComponent("排名"):setBackground(
			v[1]==1 and UIPATH.."排行榜/第一.png" or
			v[1]==2 and UIPATH.."排行榜/第二.png" or
			v[1]==3 and UIPATH.."排行榜/第三.png" or UIPATH.."排行榜/排行通用.png")
		ui.mycheckbox:findComponent("排名"):setTitleText(v[1]>3 and v[1] or "")
		ui.mycheckbox:findComponent("名字"):setTitleText(txt(v[2]))
		if m_curtype==1 or m_curtype==2 then
			ui.mycheckbox:findComponent("职业"):setTitleText(txt(全局设置.获取职业类型(v[3])))
		else
			ui.mycheckbox:findComponent("职业"):setTitleText(v[3])
		end
		ui.mycheckbox:findComponent("等级"):setTitleText(v[4])
		ui.mycheckbox:findComponent("转生"):setTitleText(v[5]=="" and txt("无") or txt(v[5]))
		ui.mycheckbox:findComponent("战斗力"):setTitleText(v[6])
		ui.mycheckbox:setVisible(true)
	else
		ui.mycheckbox:setVisible(false)
	end
end

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

function setCurType(type)
	m_curtype = type
	if g_mobileMode then
		if type == 1 then
			消息.CG_RANK_QUERY()
		elseif type == 2 then
			消息.CG_RANK_HERO_QUERY()
		elseif type == 3 then
			消息.CG_RANK_PET_QUERY()
		elseif type == 4 then
			消息.CG_RANK_VIPSPREAD_QUERY()
		end
		return
	end
	if type == 1 then
		ui.当前状态:setPositionX(ui.战力榜:getPositionX()+2)
		ui.当前状态:setPositionY(ui.战力榜:getPositionY()+1)
		消息.CG_RANK_QUERY()
	elseif type == 2 then
		ui.当前状态:setPositionX(ui.英雄战力榜:getPositionX()+2)
		ui.当前状态:setPositionY(ui.英雄战力榜:getPositionY()+1)
		消息.CG_RANK_HERO_QUERY()
	elseif type == 3 then
		ui.当前状态:setPositionX(ui.宠物战力榜:getPositionX()+2)
		ui.当前状态:setPositionY(ui.宠物战力榜:getPositionY()+1)
		消息.CG_RANK_PET_QUERY()
	elseif type == 4 then
		ui.当前状态:setPositionX(ui.VIP推广成长榜:getPositionX()+2)
		ui.当前状态:setPositionY(ui.VIP推广成长榜:getPositionY()+1)
		消息.CG_RANK_VIPSPREAD_QUERY()
	end
end

function onUIInit()
	ui.close = ui:findComponent("titlebar,close")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.list = tt(ui:findComponent("list_1"),F3DList)
	ui.list:getVScroll():setPercent(0)
	ui.checkbox = ui:findComponent("checkbox_3")
	ui.checkbox:setVisible(false)
	ui.mycheckbox = ui:findComponent("checkbox_4")
	ui.排行表标头 = ui:findComponent("排行表标头")
	ui.战力榜 = tt(ui:findComponent("checkbox_1"),F3DCheckBox)
	ui.战力榜:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		setCurType(1)
	end))
	ui.英雄战力榜 = tt(ui:findComponent("checkbox_2"),F3DCheckBox)
	ui.英雄战力榜:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		setCurType(2)
	end))
	ui.宠物战力榜 = tt(ui:findComponent("checkbox_5"),F3DCheckBox)
	ui.宠物战力榜:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		setCurType(3)
	end))
	ui.VIP推广成长榜 = tt(ui:findComponent("checkbox_6"),F3DCheckBox)
	ui.VIP推广成长榜:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		setCurType(4)
	end))
	if g_mobileMode then
		ui.战力榜:setGroupSelected()
	else
		ui.当前状态 = ui:findComponent("当前状态")
	end
	setCurType(m_curtype)
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
	if 角色逻辑.m_level < 35 then
		主界面UI.showTipsMsg(1,txt("35级才可查看排行榜"))
		return
	end
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
	ui:setLayout(g_mobileMode and UIPATH.."排行榜UIm.layout" or UIPATH.."排行榜UI.layout")
end
