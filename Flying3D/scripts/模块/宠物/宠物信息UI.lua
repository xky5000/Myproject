module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 宠物UI = require("宠物.宠物UI")

m_init = false
m_hpbar = {}
tipsgrid = nil
PETCNT = 1

function setHPBar(objid, hp, hpmax, mp, mpmax)
	m_hpbar[objid] = {objid = objid, hp = hp, hpmax = hpmax, mp = mp, mpmax = mpmax}
	updateHPBar()
end

function updateHPBar()
	if not m_init then
		return
	end
	for i=1,PETCNT do
		local pet = ui.petlist[i]
		if pet:isVisible() and m_hpbar[pet.objid] then
			pet.hp:setPercent(m_hpbar[pet.objid].hp/m_hpbar[pet.objid].hpmax)
		end
	end
end

function findCallPet()
	local tb = {}
	if not 宠物UI.m_petinfotb then
		return tb
	end
	for i,v in ipairs(宠物UI.m_petinfotb) do
		if v.call ~= 0 then
			tb[#tb+1] = v
		end
	end
	return tb
end

function update()
	if not m_init or not 宠物UI.m_petinfotb then
		return
	end
	local callpet = findCallPet()
	for i=1,PETCNT do
		local pet = ui.petlist[i]
		local info = callpet[i]
		if info then
			pet.objid = info.objid
			pet.index = info.index
			pet.mergetype = info.merge
			pet.merge:setTitleText(info.merge == 0 and txt("合体") or txt("解体"))
			pet.merge:setDisable(info.type ~= 2)
			pet.head:setBackground(全局设置.getPetHeadUrl(info.icon))
			pet.name:setTextColor(全局设置.getColorRgbVal(info.grade) or 0xffffff)
			pet.name:setTitleText(txt(info.name))
			pet.lv:setTitleText(info.level)
			if m_hpbar[pet.objid] then
				pet.hp:setPercent(m_hpbar[pet.objid].hp/m_hpbar[pet.objid].hpmax)
			end
			pet:setVisible(true)
		else
			pet:setVisible(false)
		end
	end
end

function onGridOver(e)
	local g = e:getTarget()
	if g == nil then
	else
		for i=1,PETCNT do
			local pet = ui.petlist[i]
			if g == pet.hp and m_hpbar[pet.objid] then
				pet.hp:setTitleText(m_hpbar[pet.objid].hp.." / "..m_hpbar[pet.objid].hpmax)
				pet.mp:setTitleText("")
			--elseif g == pet.mp and m_hpbar[pet.objid] then
			--	pet.mp:setTitleText(m_hpbar[pet.objid].mp.." / "..m_hpbar[pet.objid].mpmax)
			--	pet.hp:setTitleText("")
			end
		end
		tipsgrid = g
	end
end

function onGridOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid then
		for i=1,PETCNT do
			local pet = ui.petlist[i]
			pet.hp:setTitleText("")
			pet.mp:setTitleText("")
		end
		tipsgrid = nil
	end
end

function onUIInit()
	ui.petlist = {}
	for i=1,PETCNT do
		local pet = ui:findComponent("component_"..i)
		pet.index = 0
		pet.mergetype = 0
		pet.merge = ui:findComponent("component_"..i..",merge")
		pet.merge:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
			if pet.mergetype == 0 then
				消息.CG_MERGE_PET(pet.index)
			else
				消息.CG_BREAK_PET(pet.index)
			end
		end))
		if not g_mobileMode then
			pet.takeback = ui:findComponent("component_"..i..",takeback")
			pet.takeback:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
				消息.CG_BACK_PET(pet.index)
			end))
		end
		pet.head = ui:findComponent("component_"..i..",head")
		pet.head:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
			宠物UI.toggle()
		end))
		pet.lv = ui:findComponent("component_"..i..",lv")
		pet.name = ui:findComponent("component_"..i..",myname")
		pet.hp = tt(ui:findComponent("component_"..i..",hp"),F3DProgress)
		pet.hp:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
		pet.hp:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		pet.mp = tt(ui:findComponent("component_"..i..",mp"),F3DProgress)
		pet.mp:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
		pet.mp:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		ui.petlist[i] = pet
	end
	m_init = true
	update()
	updateHPBar()
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
	ui:setLayout(g_mobileMode and UIPATH.."宠物信息UIm.layout" or ISMIRUI and UIPATH.."宠物信息UI.layout" or UIPATH.."宠物信息UIs.layout")
end
