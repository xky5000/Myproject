module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 队伍信息UI = require("主界面.队伍信息UI")
local 主逻辑 = require("主界面.主逻辑")

m_init = false
m_winteam = 0
m_teaminfo = nil
m_score1 = 0
m_score2 = 0

function update()
	if not m_init or not m_teaminfo then
		return
	end
	ui.win:setVisible(m_winteam == g_role.teamid)
	ui.fail:setVisible(m_winteam == -1 or (m_winteam ~= 0 and m_winteam ~= g_role.teamid))
	ui.draw:setVisible(m_winteam == 0)
	local index = 0
	for i,v in ipairs(m_teaminfo) do
		if i <= 5 then
			ui.wanjia[i].ziji:setVisible(v[1]==g_role.objid)
			ui.wanjia[i].head:setBackground(全局设置.getHeadIconUrl(v[4]))
			ui.wanjia[i].mingzi:setTitleText(txt(v[2]))
			ui.wanjia[i].dengji:setTitleText(txt(v[3].."级"))
			ui.wanjia[i].jisha:setTitleText(v[5])
			ui.wanjia[i].siwang:setTitleText(v[6])
			ui.wanjia[i].score:setTitleText(v[7])
			ui.wanjia[i]:setVisible(true)
			index = i
		end
	end
	for i=index+1,5 do
		ui.wanjia[i]:setVisible(false)
	end
end

function onView(e)
	ui:setVisible(false)
	ui.view:releaseMouse()
	e:stopPropagation()
	if 队伍信息UI.m_teaminfo then
		for i,v in ipairs(队伍信息UI.m_teaminfo) do
			if v.hp > 0 then
				消息.CG_VIEWER(v.objid)
				break
			end
		end
	end
end

function onQuit(e)
	ui:setVisible(false)
	ui.quit:releaseMouse()
	e:stopPropagation()
	消息.CG_QUIT_COPYSCENE()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onZhezhaoDown(e)
	e:stopPropagation()
end

function onUIInit()
	ui.zhezhao = ui:findComponent("zhezhao")
	ui.zhezhao:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onZhezhaoDown))
	ui.view = ui:findComponent("zhong,view")
	ui.view:addEventListener(F3DMouseEvent.CLICK, func_me(onView))
	ui.quit = ui:findComponent("zhong,quit")
	ui.quit:addEventListener(F3DMouseEvent.CLICK, func_me(onQuit))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.win = ui:findComponent("zhong,win")
	ui.fail = ui:findComponent("zhong,fail")
	ui.draw = ui:findComponent("zhong,draw")
	ui.wanjia = {}
	for i=1,5 do
		ui.wanjia[i] = ui:findComponent("zhong,wanjia_"..i)
		ui.wanjia[i]:setVisible(false)
		ui.wanjia[i].ziji = ui:findComponent("zhong,wanjia_"..i..",ziji")
		ui.wanjia[i].head = ui:findComponent("zhong,wanjia_"..i..",head")
		ui.wanjia[i].mingzi = ui:findComponent("zhong,wanjia_"..i..",mingzi")
		ui.wanjia[i].dengji = ui:findComponent("zhong,wanjia_"..i..",dengji")
		ui.wanjia[i].jisha = ui:findComponent("zhong,wanjia_"..i..",jisha")
		ui.wanjia[i].siwang = ui:findComponent("zhong,wanjia_"..i..",siwang")
		ui.wanjia[i].score = ui:findComponent("zhong,wanjia_"..i..",score")
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
	ui:setLayout(UIPATH.."结算UI1.layout")
end
