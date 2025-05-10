module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 任务追踪UI = require("主界面.任务追踪UI")
local 技能逻辑 = require("技能.技能逻辑")
local 物品提示UI = require("主界面.物品提示UI")
local 装备提示UI = require("主界面.装备提示UI")
local 小地图UI = require("主界面.小地图UI")
local 背包UI = require("主界面.背包UI")
local 仓库UI = require("主界面.仓库UI")
local 商店UI = require("主界面.商店UI")
local 角色逻辑 = require("主界面.角色逻辑")
local 消息框UI1 = require("主界面.消息框UI1")
local 主界面UI = require("主界面.主界面UI")

对话_打开仓库 = 901--101
对话_打开结束 = 1000
对话_购买武器 = 102
对话_购买衣服 = 103
对话_购买戒指 = 104
对话_购买手镯 = 105
对话_购买项链 = 106
对话_购买药品 = 107
对话_购买书籍 = 108
对话_购买杂货 = 109
对话_购买头盔 = 110

m_init = false
m_objid = 0
m_bodyid = 0
m_oldbodyid = 0
m_effid = 0
m_oldeffid = 0
m_desc = ""
m_talk = nil
m_taskid = 0
m_state = 0
m_prize = nil
m_grids = {}
m_gridimgs = {}
m_gradeimgs = {}
m_uitype = 1
m_callput = {}
tipsui = nil
tipsgrid = nil

function setNpcBody(objid, bodyid, effid, desc, talk, taskid, state, prize)
	m_objid = objid
	m_bodyid = bodyid
	m_effid = effid
	m_desc = desc
	m_talk = talk
	m_taskid = taskid
	m_state = state
	m_prize = {}
	for i,v in ipairs(prize) do
		m_prize[i] = {
			pos=v[1],
			id=v[2],
			name=v[3],
			desc=v[4],
			type=v[5],
			count=v[6],
			icon=v[7],
			cd=v[8]+rtime(),
			cdmax=v[9],
			bind=v[10],
			grade=v[11],
			job=v[12],
			level=v[13],
			strengthen=v[14],
			prop=v[15],
			addprop=v[16],
			attachprop=v[17],
			gemprop=v[18],
			ringsoul=v[19],
			power=v[20],
			equippos=v[21],
			color=v[22],
			suitprop=v[23],
			suitname=v[24],
		}
	end
	if g_target and g_target.objid == m_objid then
		g_target:setAnimRotationZ(F3DUtils:calcDirection(g_role:getPositionX() - g_target:getPositionX(), g_role:getPositionY() - g_target:getPositionY()))
	end
	update()
end

function update()
	if not m_init or (m_objid == -1 and m_desc == "") then--(m_bodyid == 0 and m_taskid == 0) then
		return
	end
	
	if m_oldbodyid ~= m_bodyid or m_oldeffid ~= m_effid then
		ui.head:setBackground(全局设置.getHeadIconUrl(m_bodyid))
	end
	local role = g_roles[m_objid]
	if role and role.name then
		ui.myname:setTitleText(txt(role.name))
	else
		ui.myname:setTitleText("")
	end
	local str = (g_mobileMode and "#s22," or "#s12,")..m_desc:gsub("\n","#n").."#n"
	
	if m_talk then
		for i,v in ipairs(m_talk) do
			str = str.."#n#u#lc0000ff:"..v[3]..",#c"..F3DUtils:toString(v[2],16)..","..v[1].."#L#U#C"
		end
	end
	
	if m_taskid ~= 0 then
		if m_state == 0 then
			str = str.."#n#u#lc0000ff:"..m_state..",#cff00,接受任务#L#U#C"
		elseif m_state == 2 then
			str = str.."#n#u#lc0000ff:"..m_state..",#cff00,完成任务#L#U#C"
		end
	end
	
	ui.talktxt:setTitleText(txt(str:gsub("#n",g_mobileMode and "#n#s30,#s22," or "#n#s16,#s12,")))

	for i=1,6 do
		m_grids[i]:setVisible(m_taskid ~= 0)
		if #m_prize >= i then
			m_grids[i].count:setText(m_prize[i].count > 1 and m_prize[i].count or "")
			m_gridimgs[i]:setTextureFile(全局设置.getItemIconUrl(m_prize[i].icon))
			m_gradeimgs[i]:setTextureFile(全局设置.getGradeUrl(m_prize[i].grade))
		else
			m_grids[i].count:setText("")
			m_gridimgs[i]:setTextureFile("")
			m_gradeimgs[i]:setTextureFile("")
		end
	end
	updateUISize(实用工具.CountString(str,"#n") > 9 and 2 or 1)
end

function updateUISize(type)
	if type == 2 and m_uitype == 1 then
		for i=1,6 do
			m_grids[i]:setPositionY(m_grids[i]:getPositionY()+172)
		end
		m_uitype = 2
	elseif type == 1 and m_uitype == 2 then
		for i=1,6 do
			m_grids[i]:setPositionY(m_grids[i]:getPositionY()-172)
		end
		m_uitype = 1
	end
end

function onOK(rolename)
	if rolename == nil or rolename == "" then
		主界面UI.showTipsMsg(1,txt("请输入您的名字"))
		return
	end
	if rolename:len() > 14 then
		主界面UI.showTipsMsg(1, txt("名字不能超过7个汉字"))
		return
	end
	消息.CG_CREATE_ROLE(utf8(rolename), 角色逻辑.m_rolesex, 角色逻辑.m_rolejob)
end

function onPut(rolename)
	if rolename == nil or rolename == "" then
		主界面UI.showTipsMsg(1,txt("请输入文本或有效数字"))
		return
	end
	if rolename:len() > 84 then
		主界面UI.showTipsMsg(1, txt("文本不能超过42个汉字"))
		return
	end
	if m_callput.type ~= 1 and tonumber(rolename) == nil then
		主界面UI.showTipsMsg(1, txt("请输入有效的数字"))
		return
	end
	消息.CG_NPC_TALK_PUT(m_objid, m_callput.talkid or 0, m_callput.type or 0, m_callput.callid or 0, utf8(rolename))
end

function onLinkDown(e)
	if 角色逻辑.m_rolename == "" then
		消息框UI1.initUI()
		消息框UI1.setData(txt("#cffff00,千古留名: #C请留下您的#cff00ff,千古大名"),onOK,onOK,onOK,true)
		return
	end
	if m_taskid == 0 then
		local ss = 实用工具.SplitString(ui.talktxt:getCurrLinkSrc(), ":")
		local talkid = tonumber(ss[1]) or 0
		if #ss == 3 then
			m_callput.talkid = talkid
			m_callput.type = tonumber(ss[2]) or 0
			m_callput.callid = tonumber(ss[3]) or 0
			消息框UI1.initUI()
			消息框UI1.setData(m_callput.type == 1 and txt("请输入不超过42个汉字的文本") or txt("请输入有效数字"),onPut,nil,nil,true)
		elseif talkid == 对话_打开仓库 then
			背包UI.initUI()
			if 背包UI.m_init then
				消息.CG_STORE_QUERY(0)
				仓库UI.initUI()
				背包UI.otherui = 仓库UI
				背包UI.checkResize()
			else
				背包UI.ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(function(e)
					消息.CG_STORE_QUERY(0)
					仓库UI.initUI()
					背包UI.otherui = 仓库UI
					背包UI.checkResize()
				end))
			end
		elseif talkid > 对话_打开仓库 and talkid <= 对话_打开结束 then
			背包UI.initUI()
			if 背包UI.m_init then
				商店UI.setTalkID(talkid)
				商店UI.initUI()
				背包UI.otherui = 商店UI
				背包UI.checkResize()
			else
				背包UI.ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(function(e)
					商店UI.setTalkID(talkid)
					商店UI.initUI()
					背包UI.otherui = 商店UI
					背包UI.checkResize()
				end))
			end
		elseif talkid < 0 then
			onCloseUI()
		else
			消息.CG_NPC_TALK(m_objid, talkid)
		end
	elseif m_state == 0 then
		消息.CG_ACCEPT_TASK(m_taskid)
		onCloseUI()
	elseif m_state == 2 then
		消息.CG_FINISH_TASK(m_taskid)
		onCloseUI()
	end
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
	if g == nil then
	elseif F3DUIManager.sTouchComp ~= g then
	elseif m_prize == nil or m_prize[g.id] == nil then
	elseif m_prize[g.id].type == 3 then
		物品提示UI.hideUI()
		装备提示UI.initUI()
		装备提示UI.setItemData(m_prize[g.id], false)
		tipsui = 装备提示UI.ui
		tipsgrid = g
		if not tipsui:isInited() then
			tipsui:addEventListener(F3DObjEvent.OBJ_INITED, func_oe(checkTipsPos))
		else
			checkTipsPos()
		end
	else
		装备提示UI.hideUI()
		物品提示UI.initUI()
		物品提示UI.setItemData(m_prize[g.id])
		tipsui = 物品提示UI.ui
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
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
end

function onCloseUI()
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui.titlebar:releaseMouse()
	ui:setVisible(false)
	ui.talktxt:releaseLinkRect()
	if g_target and g_target.objid == m_objid then
		setMainRoleTarget(nil)
	end
	g_targetPos.bodyid = 0
	g_targetPos.x = 0
	g_targetPos.y = 0
	技能逻辑.autoUseSkill = false
	小地图UI.CheckHandup()
end

function onClose(e)
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui.titlebar:releaseMouse()
	ui:setVisible(false)
	ui.close:releaseMouse()
	ui.talktxt:releaseLinkRect()
	e:stopPropagation()
	if g_target and g_target.objid == m_objid then
		setMainRoleTarget(nil)
	end
	g_targetPos.bodyid = 0
	g_targetPos.x = 0
	g_targetPos.y = 0
	技能逻辑.autoUseSkill = false
	小地图UI.CheckHandup()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onClick(e)
	if 角色逻辑.m_rolename == "" then
		消息框UI1.initUI()
		消息框UI1.setData(txt("#cffff00,千古留名: #C请留下您的#cff00ff,千古大名"),onOK,onOK,onOK,true)
		return
	end
	
	if m_taskid == 0 then
	elseif m_state == 0 then
		消息.CG_ACCEPT_TASK(m_taskid)
		onCloseUI()
	elseif m_state == 2 then
		消息.CG_FINISH_TASK(m_taskid)
		onCloseUI()
	end
end

function onUIInit()
	ui.titlebar = ui:findComponent("背景")
	ui.titlebar:addEventListener(F3DMouseEvent.CLICK, func_me(onClick))
	ui.close = ui:findComponent("关闭")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui.head = ui:findComponent("头像")
	ui.myname = ui:findComponent("myname")
	ui.talktxt = tt(ui:findComponent("talktxt"),F3DRichTextField)
	ui.talktxt:addEventListener(F3DUIEvent.LINK_DOWN, func_ue(onLinkDown))
	for i=1,6 do
		m_grids[i] = ui:findComponent("grid_"..(i-1))
		m_grids[i].id = i
		if g_mobileMode then
			m_grids[i]:addEventListener(F3DMouseEvent.CLICK, func_ue(onGridOver))
		else
			m_grids[i]:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
			m_grids[i]:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		end
		local img = F3DImage:new()
		--img:setPositionX(2)
		--img:setPositionY(2)
		img:setPositionX(math.floor(m_grids[i]:getWidth()/2))
		img:setPositionY(math.floor(m_grids[i]:getHeight()/2))
		img:setPivot(0.5,0.5)
		m_grids[i]:addChild(img)
		m_gridimgs[i] = img
		local gimg = F3DImage:new()
		gimg:setPositionX(1)
		gimg:setPositionY(1)
		gimg:setWidth(m_grids[i]:getWidth()-2)
		gimg:setHeight(m_grids[i]:getHeight()-2)
		m_grids[i]:addChild(gimg)
		m_gradeimgs[i] = gimg
		local limg = F3DImage:new()
		limg:setPositionX(4)
		limg:setPositionY(m_grids[i]:getHeight()-4)--32)
		limg:setPivot(0,1)
		m_grids[i]:addChild(limg)
		m_grids[i].count = F3DTextField:new()
		if g_mobileMode then
			m_grids[i].count:setTextFont("宋体",16,false,false,false)
		end
		m_grids[i].count:setPositionX(m_grids[i]:getWidth()-(g_mobileMode and 8 or 2))--36)
		m_grids[i].count:setPositionY(m_grids[i]:getHeight()-(g_mobileMode and 8 or 2))--36)
		m_grids[i].count:setPivot(1,1)
		m_grids[i]:addChild(m_grids[i].count)
	end
	m_init = true
	update()
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	if ui then
		ui:releaseMouse()
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
	ui:setLayout(g_mobileMode and UIPATH.."Npc对话UIm.layout" or UIPATH.."Npc对话UI.layout")
end
