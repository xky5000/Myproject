module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 背包UI = require("主界面.背包UI")
local 商城表 = require("配置.商城表").Config
local 角色逻辑 = require("主界面.角色逻辑")
local 消息框UI2 = require("主界面.消息框UI2")
local 物品提示UI = require("主界面.物品提示UI")
local 装备提示UI = require("主界面.装备提示UI")

m_init = false
m_curpage = 1
m_mallinfo = nil
m_selectitem = nil
m_itemdata = nil
m_talkid = 0
tipsui = nil
tipsgrid = nil
ITEMCOUNT = 5

function setTalkID(talkid)
	m_talkid = talkid
	m_curpage = 1
	update()
end

function update()
	if not m_init or not 商城表 then
		return
	end
	m_mallinfo = {}
	for i,v in ipairs(商城表) do
		--v.type == 3 and v.hot == 0 and v.商城类型 == 0 and
		if m_talkid == 0 and v.talkid == m_talkid and (v.type == 2 or v.type == 3) then
			m_mallinfo[#m_mallinfo+1] = v
		elseif m_talkid == -1 and v.talkid == 0 and v.guildshop == 1 then
			m_mallinfo[#m_mallinfo+1] = v
		elseif m_talkid ~= 0 and v.talkid == m_talkid then
			m_mallinfo[#m_mallinfo+1] = v
		end
	end
	local index = (m_curpage-1)*ITEMCOUNT
	for i=1,ITEMCOUNT do
		local v = m_mallinfo[index+i]
		if v then
			ui.items[i]:setVisible(true)
			local str = ""
			if #v.limit > 2 and v.limit[3] > 0 then
				str = str.."行会"..v.limit[3].."级"
			end
			if #v.limit > 1 and v.limit[2] > 0 then
				str = str.."VIP"..v.limit[2]
			end
			if #v.limit > 0 and v.limit[1] > 0 then
				str = str.."日限"..v.limit[1].."个"
			end
			ui.items[i].name:setTitleText(txt(v.name..(str ~= "" and "("..str..")" or "")))
			ui.items[i].name:setTextColor(全局设置.getColorRgbVal(v.grade))
			ui.items[i].icon:setTextureFile(全局设置.getItemIconUrl(v.icon))
			ui.items[i].grade:setTextureFile(全局设置.getGradeUrl(v.grade))
			ui.items[i].money:setBackground(全局设置.MONEYICON[v.type] or "")
			ui.items[i].money:setTitleText(txt(v.材料名称)..(v.price > 0 and v.price or ""))
			ui.items[i].money:setTextColor(v.price == 0 and 0xFF0000 or v.材料名称 ~= "" and 0xFF00FF or 0xFFFFFF)
		else
			ui.items[i]:setVisible(false)
		end
	end
	local totalpage = math.ceil(#m_mallinfo / ITEMCOUNT)
	ui.page_cur:setTitleText(m_curpage.." / "..totalpage)
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

function setItemData(itemdata)
	local v = itemdata[1]
	m_itemdata = {
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
	if tipsui and tipsgrid then
		local 提示UI = m_itemdata.type == 3 and 装备提示UI or 物品提示UI
		提示UI.setItemData(m_itemdata)
	end
end

function onGridOver(e)
	local g = g_mobileMode and e:getCurrentTarget() or e:getTarget()
	if g == nil or not m_mallinfo or not m_mallinfo[(m_curpage-1)*ITEMCOUNT+g.id] then
	elseif F3DUIManager.sTouchComp ~= g then
	else
		local mallinfo = m_mallinfo[(m_curpage-1)*ITEMCOUNT+g.id]
		local 提示UI = mallinfo.物品类型 == 1 and 装备提示UI or 物品提示UI
		提示UI.initUI()
		if not m_itemdata or m_itemdata.id ~= mallinfo.itemid then
			消息.CG_ITEM_QUERY(mallinfo.itemid, 2)
			提示UI.setEmptyItemData()
		else
			提示UI.setItemData(m_itemdata)
		end
		tipsui = 提示UI.ui
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

function onClose(e)
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui:setVisible(false)
	ui.close:releaseMouse()
	背包UI.checkResize()
	e:stopPropagation()
end

function onMouseDown(e)
	if 背包UI.ui and 背包UI.ui:isVisible() then
		uiLayer:removeChild(背包UI.ui)
		uiLayer:addChild(背包UI.ui)
	end
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onBuyItemOK(count)
	if m_selectitem then
		消息.CG_ITEM_BUY(m_talkid > 0 and m_talkid or m_selectitem.type, m_selectitem.itemid, count)
		m_selectitem = nil
	end
end

function onUIInit()
	ui.close = ui:findComponent("titlebar,close")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.items = {}
	for i=1,ITEMCOUNT do
		ui.items[i] = ui:findComponent("img_shopitembg_"..i)
		ui.items[i].name = ui:findComponent("img_shopitembg_"..i..",name")
		ui.items[i].grid = ui:findComponent("img_shopitembg_"..i..",grid")
		ui.items[i].grid.id = i
		if g_mobileMode then
			ui.items[i].grid:addEventListener(F3DMouseEvent.CLICK, func_me(onGridOver))
		else
			ui.items[i].grid:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
			ui.items[i].grid:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		end
		ui.items[i].icon = F3DImage:new()
		--ui.items[i].icon:setPositionX(2)
		--ui.items[i].icon:setPositionY(2)
		--ui.items[i].icon:setWidth(34)
		--ui.items[i].icon:setHeight(34)
		ui.items[i].icon:setPositionX(math.floor(ui.items[i].grid:getWidth()/2))
		ui.items[i].icon:setPositionY(math.floor(ui.items[i].grid:getHeight()/2))
		ui.items[i].icon:setPivot(0.5,0.5)
		ui.items[i].grid:addChild(ui.items[i].icon)
		ui.items[i].grade = F3DImage:new()
		ui.items[i].grade:setPositionX(1)
		ui.items[i].grade:setPositionY(1)
		ui.items[i].grade:setWidth(ui.items[i].grid:getWidth()-2)--36)
		ui.items[i].grade:setHeight(ui.items[i].grid:getHeight()-2)--36)
		ui.items[i].grid:addChild(ui.items[i].grade)
		ui.items[i].money = ui:findComponent("img_shopitembg_"..i..",money")
		ui.items[i].buy = ui:findComponent("img_shopitembg_"..i..",buy")
		ui.items[i].buy.id = i
		ui.items[i].buy:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
			local btn = e:getCurrentTarget()
			if btn and m_mallinfo and m_mallinfo[(m_curpage-1)*ITEMCOUNT+btn.id] then
				m_selectitem = m_mallinfo[(m_curpage-1)*ITEMCOUNT+btn.id]
				local maxcnt = 1
				if m_selectitem.type == 0 then
					maxcnt = math.floor(角色逻辑.m_rmb / m_selectitem.price)
				elseif m_selectitem.type == 1 then
					maxcnt = math.floor(角色逻辑.m_bindrmb / m_selectitem.price)
				elseif m_selectitem.type == 2 then
					maxcnt = math.floor(角色逻辑.m_money / m_selectitem.price)
				elseif m_selectitem.type == 3 then
					maxcnt = math.floor(角色逻辑.m_bindmoney / m_selectitem.price)
				end
				消息框UI2.initUI()
				消息框UI2.setData(5,1,math.min(100,math.max(1,maxcnt)),onBuyItemOK)
			end
		end))
	end
	ui.page_cur = ui:findComponent("btncont,page")
	ui.page_pre = ui:findComponent("btncont,pagepre")
	ui.page_pre:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		if not m_mallinfo then
			return
		end
		local totalpage = math.ceil(#m_mallinfo / ITEMCOUNT)
		m_curpage = math.max(1, m_curpage - 1)
		update()
	end))
	ui.page_next = ui:findComponent("btncont,pagenext")
	ui.page_next:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		if not m_mallinfo then
			return
		end
		local totalpage = math.ceil(#m_mallinfo / ITEMCOUNT)
		m_curpage = math.min(totalpage, m_curpage + 1)
		update()
	end))
	if g_mobileMode then
		ui.returncont = ui:findComponent("returncont")
		ui.returnui = ui:findComponent("returncont,return")
		ui.returnui:addEventListener(F3DMouseEvent.CLICK, func_me(背包UI.onOtherReturn))
		ui.returncont:setVisible(false)
	end
	m_init = true
	update()
	背包UI.checkResize()
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
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ITEMCOUNT = g_mobileMode and 6 or 5
	ui:setLayout(g_mobileMode and UIPATH.."商店UIm.layout" or UIPATH.."商店UI.layout")
end
