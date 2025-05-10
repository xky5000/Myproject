module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 商城表 = require("配置.商城表").Config
local 角色逻辑 = require("主界面.角色逻辑")
local 消息框UI2 = require("主界面.消息框UI2")
local 物品提示UI = require("主界面.物品提示UI")
local 装备提示UI = require("主界面.装备提示UI")
local 宠物蛋提示UI = require("主界面.宠物蛋提示UI")

ITEMCOUNT = 9
m_init = false
m_curpage = 1
m_mallinfo = nil
m_tabid = 0
m_subtabid = 0
m_selectitem = nil
m_itemdata = nil
m_timeShopItem = nil
tipsui = nil
tipsgrid = nil

if ISWZ then
	VIPPRIZE = {
		"#cffff00,VIP1.#C 总充值#cffff00,50元#C 杀怪经验加成#cffff00,10%#C #n   每日领取#cffff00,金币100W 双倍经验卡1个#C#n",
		"#cffff00,VIP2.#C 总充值#cffff00,100元#C 杀怪经验加成#cffff00,20%#C #n   每日领取#cffff00,金币200W 双倍经验卡2个#C#n",
		"#cffff00,VIP3.#C 总充值#cffff00,200元#C 杀怪经验加成#cffff00,30%#C #n   每日领取#cffff00,金币300W 双倍经验卡3个#C#n",
		"#cffff00,VIP4.#C 总充值#cffff00,500元#C 杀怪经验加成#cffff00,40%#C #n   每日领取#cffff00,金币400W 双倍经验卡4个#C#n",
		"#cffff00,VIP5.#C 总充值#cffff00,1000元#C 杀怪经验加成#cffff00,50%#C #n   每日领取#cffff00,金币500W 双倍经验卡5个#C#n",
		"#cffff00,VIP6.#C 总充值#cffff00,2000元#C 杀怪经验加成#cffff00,60%#C #n   每日领取#cffff00,金币600W 双倍经验卡6个#C#n",
		"#cffff00,VIP7.#C 总充值#cffff00,5000元#C 杀怪经验加成#cffff00,70%#C #n   每日领取#cffff00,金币700W 双倍经验卡7个#C#n",
		"#cffff00,VIP8.#C 总充值#cffff00,10000元#C 杀怪经验加成#cffff00,80%#C #n   每日领取#cffff00,金币800W 双倍经验卡8个#C#n",
		"#cffff00,VIP9.#C 总充值#cffff00,20000元#C 杀怪经验加成#cffff00,90%#C #n   每日领取#cffff00,金币900W 双倍经验卡9个#C#n",
		"#cffff00,VIP10.#C 总充值#cffff00,50000元#C 杀怪经验加成#cffff00,100%#C #n   每日领取#cffff00,金币1000W 双倍经验卡10个#C#n",
	}
elseif ISZY then
	VIPPRIZE = {
		"#cffff00,VIP1.#C 总充值#cffff00,50元#C 杀怪经验加成#cffff00,10%#C #n   每日领取#cffff00,金币100W 檀木宝箱1个#C#n",
		"#cffff00,VIP2.#C 总充值#cffff00,100元#C 杀怪经验加成#cffff00,20%#C #n   每日领取#cffff00,金币200W 檀木宝箱2个#C#n",
		"#cffff00,VIP3.#C 总充值#cffff00,200元#C 杀怪经验加成#cffff00,30%#C #n   每日领取#cffff00,金币300W 紫铜宝箱1个#C#n",
		"#cffff00,VIP4.#C 总充值#cffff00,500元#C 杀怪经验加成#cffff00,40%#C #n   每日领取#cffff00,金币400W 紫铜宝箱2个#C#n",
		"#cffff00,VIP5.#C 总充值#cffff00,1000元#C 杀怪经验加成#cffff00,50%#C #n   每日领取#cffff00,金币500W 白银宝箱1个#C#n",
		"#cffff00,VIP6.#C 总充值#cffff00,2000元#C 杀怪经验加成#cffff00,60%#C #n   每日领取#cffff00,金币600W 白银宝箱2个#C#n",
		"#cffff00,VIP7.#C 总充值#cffff00,5000元#C 杀怪经验加成#cffff00,70%#C #n   每日领取#cffff00,金币700W 赤金宝箱1个#C#n",
		"#cffff00,VIP8.#C 总充值#cffff00,10000元#C 杀怪经验加成#cffff00,80%#C #n   每日领取#cffff00,金币800W 赤金宝箱2个#C#n",
		"#cffff00,VIP9.#C 总充值#cffff00,20000元#C 杀怪经验加成#cffff00,90%#C #n   每日领取#cffff00,金币900W 神秘宝箱1个#C#n",
		"#cffff00,VIP10.#C 总充值#cffff00,50000元#C 杀怪经验加成#cffff00,100%#C #n   每日领取#cffff00,金币1000W 神秘宝箱2个#C#n",
	}
else
	VIPPRIZE = {
		"#cffff00,VIP1.#C 总充值#cffff00,50元#C 杀怪经验加成#cffff00,10%#C #n   每日领取#cffff00,金币10W 元宝10个#C#n",
		"#cffff00,VIP2.#C 总充值#cffff00,100元#C 杀怪经验加成#cffff00,20%#C #n   每日领取#cffff00,金币20W 元宝20个#C#n",
		"#cffff00,VIP3.#C 总充值#cffff00,200元#C 杀怪经验加成#cffff00,30%#C #n   每日领取#cffff00,金币30W 元宝30个#C#n",
		"#cffff00,VIP4.#C 总充值#cffff00,500元#C 杀怪经验加成#cffff00,40%#C #n   每日领取#cffff00,金币40W 元宝40个#C#n",
		"#cffff00,VIP5.#C 总充值#cffff00,1000元#C 杀怪经验加成#cffff00,50%#C #n   每日领取#cffff00,金币50W 元宝50个#C#n",
		"#cffff00,VIP6.#C 总充值#cffff00,2000元#C 杀怪经验加成#cffff00,60%#C #n   每日领取#cffff00,金币60W 元宝60个#C#n",
		"#cffff00,VIP7.#C 总充值#cffff00,5000元#C 杀怪经验加成#cffff00,70%#C #n   每日领取#cffff00,金币70W 元宝70个#C#n",
		"#cffff00,VIP8.#C 总充值#cffff00,10000元#C 杀怪经验加成#cffff00,80%#C #n   每日领取#cffff00,金币80W 元宝80个#C#n",
		"#cffff00,VIP9.#C 总充值#cffff00,20000元#C 杀怪经验加成#cffff00,90%#C #n   每日领取#cffff00,金币90W 元宝90个#C#n",
		"#cffff00,VIP10.#C 总充值#cffff00,50000元#C 杀怪经验加成#cffff00,100%#C #n   每日领取#cffff00,金币100W 元宝100个#C#n",
	}
end

function setTimeShopItem(item)
	m_timeShopItem = {}
	for i,v in ipairs(item) do
		m_timeShopItem[#m_timeShopItem+1] = {
			id = v[1],
			name = v[2],
			icon = v[3],
			grade = v[4],
			type = v[5],
			price = v[6],
			status = v[7],
		}
	end
	updateTimeShop()
end

function updateTimeShop()
	if not m_init or m_timeShopItem == nil then
		return
	end
	--[[for i=1,4 do
		local v = m_timeShopItem[i]
		if v then
			ui.限时商店物品[i]:setVisible(true)
			ui.限时商店物品[i].name:setTitleText(txt(v.name))
			ui.限时商店物品[i].name:setTextColor(全局设置.getColorRgbVal(v.grade))
			ui.限时商店物品[i].icon:setTextureFile(全局设置.getItemIconUrl(v.icon))
			ui.限时商店物品[i].grade:setTextureFile(全局设置.getGradeUrl(v.grade))
			ui.限时商店物品[i].money:setBackground(全局设置.MONEYICON[v.type] or "")
			ui.限时商店物品[i].money:setTitleText(v.price)
			ui.限时商店物品[i].isbuy:setVisible(v.status == 1)
		else
			ui.限时商店物品[i]:setVisible(false)
		end
	end]]
end

function updateVipLevel(updatetxt)
	if not m_init then
		return
	end
	if updatetxt then
		local vipi = math.max(1, math.min(6, 角色逻辑.m_vip等级 - 3))
		ui.vip特权:setTitleText(txt(VIPPRIZE[vipi]..VIPPRIZE[vipi+1]..VIPPRIZE[vipi+2]..VIPPRIZE[vipi+3]..VIPPRIZE[vipi+4]))
	end
	ui.vip等级:setTitleText("VIP"..角色逻辑.m_vip等级)
	ui.总充值:setTitleText(txt("我的总充值: "..角色逻辑.m_总充值.."元"))
end

function updateMoney()
	if not m_init then
		return
	end
	ui.bindmoney:setTitleText(角色逻辑.m_bindmoney)
	ui.money:setTitleText(角色逻辑.m_money)
	ui.bindrmb:setTitleText(角色逻辑.m_bindrmb)
	ui.rmb:setTitleText(角色逻辑.m_rmb)
end

function update()
	if not m_init or not 商城表 then
		return
	end
	m_mallinfo = {}
	for i,v in ipairs(商城表) do
		if v.talkid ~= 0 or v.guildshop == 1 then
		elseif m_tabid == 0 and v.hot == 1 then
			m_mallinfo[#m_mallinfo+1] = v
		elseif m_tabid == 3 and v.商城类型 ~= 0 and v.subtype == m_subtabid then-- and g_mobileMode
			m_mallinfo[#m_mallinfo+1] = v
		--elseif m_tabid == 3 and v.商城类型 == 1 then
		--	m_mallinfo[#m_mallinfo+1] = v
		--elseif m_tabid == 4 and v.商城类型 == 2 then
		--	m_mallinfo[#m_mallinfo+1] = v
		--elseif m_tabid == 5 and v.商城类型 == 3 then
		--	m_mallinfo[#m_mallinfo+1] = v
		elseif m_tabid == 1 and (v.type == 0 or v.type == 1) and v.hot == 0 and v.商城类型 == 0 and v.subtype == m_subtabid then
			m_mallinfo[#m_mallinfo+1] = v
		elseif m_tabid == 2 and (v.type == 2 or v.type == 3) and v.hot == 0 and v.商城类型 == 0 and v.subtype == m_subtabid then
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
	if ISZY and m_tabid == 1 then
		ui.subtab:setVisible(true)
		ui.subtab:getTabBtn(0):setTitleText(txt("常用"))
		ui.subtab:getTabBtn(1):setTitleText(txt("变强"))
		ui.subtab:getTabBtn(2):setTitleText(txt("材料"))
		ui.subtab:getTabBtn(3):setTitleText(txt("图纸"))
		ui.subtab:getTabBtn(4):setTitleText(txt("时装"))
	elseif ISZY and m_tabid == 3 then
		ui.subtab:setVisible(true)
		ui.subtab:getTabBtn(0):setTitleText(txt("宠物"))
		ui.subtab:getTabBtn(1):setTitleText(txt("碎片"))
		ui.subtab:getTabBtn(2):setTitleText(txt("技能"))
		ui.subtab:getTabBtn(3):setTitleText(txt("特戒"))
		ui.subtab:getTabBtn(4):setTitleText(txt("装备"))
	else
		ui.subtab:setVisible(ISLT and m_tabid == 1)
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
	if tipsui and tipsgrid and 提示UI then
		local 提示UI = (m_itemdata.type == 3 and m_itemdata.equippos == 14) and 宠物蛋提示UI or m_itemdata.type == 3 and 装备提示UI or 物品提示UI
		提示UI.setItemData(m_itemdata)
		checkTipsPos()
	end
end

function onTimeGridOver(e)
	local g = e:getTarget()
	if g == nil or not m_timeShopItem or not m_timeShopItem[g.id] then
	elseif F3DUIManager.sTouchComp ~= g then
	else
		local mallinfo = m_timeShopItem[g.id]
		local 提示UI = mallinfo.物品类型 == 2 and 宠物蛋提示UI or mallinfo.物品类型 == 1 and 装备提示UI or 物品提示UI
		提示UI.initUI()
		if not m_itemdata or m_itemdata.id ~= mallinfo.id then
			消息.CG_ITEM_QUERY(mallinfo.id, 1)
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

function onTimeGridOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid and tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		宠物蛋提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
end

function onGridOver(e)
	local g = g_mobileMode and e:getCurrentTarget() or e:getTarget()
	if g == nil or not m_mallinfo or not m_mallinfo[(m_curpage-1)*ITEMCOUNT+g.id] then
	elseif F3DUIManager.sTouchComp ~= g then
	else
		local mallinfo = m_mallinfo[(m_curpage-1)*ITEMCOUNT+g.id]
		提示UI = mallinfo.物品类型 == 2 and 宠物蛋提示UI or mallinfo.物品类型 == 1 and 装备提示UI or 物品提示UI
		提示UI.initUI()
		if not m_itemdata or m_itemdata.id ~= mallinfo.itemid then
			消息.CG_ITEM_QUERY(mallinfo.itemid, 1)
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
		宠物蛋提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
end

function onTabChange(e)
	m_tabid = ui.tab:getSelectIndex()
	m_subtabid = 0
	ui.subtab:setSelectIndex(0)
	m_curpage = 1
	update()
end

function onSubTabChange(e)
	m_subtabid = ui.subtab:getSelectIndex()
	m_curpage = 1
	update()
end

function onClose(e)
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		宠物蛋提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui:setVisible(false)
	ui.close:releaseMouse()
	e:stopPropagation()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onBuyItemOK(count)
	if m_selectitem then
		消息.CG_ITEM_BUY(m_selectitem.type, m_selectitem.itemid, count)
		m_selectitem = nil
	end
end

function onUIInit()
	ui.close = ui:findComponent("titlebar,close")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	--[[ui.限时商店物品 = {}
	for i=1,4 do
		ui.限时商店物品[i] = ui:findComponent("xianshi,xianshi_item_"..i)
		ui.限时商店物品[i].name = ui:findComponent("xianshi,xianshi_item_"..i..",name")
		ui.限时商店物品[i].grid = ui:findComponent("xianshi,xianshi_item_"..i..",grid")
		ui.限时商店物品[i].grid.id = i
		ui.限时商店物品[i].grid:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onTimeGridOver))
		ui.限时商店物品[i].grid:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onTimeGridOut))
		ui.限时商店物品[i].icon = F3DImage:new()
		--ui.限时商店物品[i].icon:setPositionX(2)
		--ui.限时商店物品[i].icon:setPositionY(2)
		--ui.限时商店物品[i].icon:setWidth(34)
		--ui.限时商店物品[i].icon:setHeight(34)
		ui.限时商店物品[i].icon:setPositionX(math.floor(ui.限时商店物品[i].grid:getWidth()/2))
		ui.限时商店物品[i].icon:setPositionY(math.floor(ui.限时商店物品[i].grid:getHeight()/2))
		ui.限时商店物品[i].icon:setPivot(0.5,0.5)
		ui.限时商店物品[i].grid:addChild(ui.限时商店物品[i].icon)
		ui.限时商店物品[i].grade = F3DImage:new()
		ui.限时商店物品[i].grade:setPositionX(1)
		ui.限时商店物品[i].grade:setPositionY(1)
		ui.限时商店物品[i].grade:setWidth(36)
		ui.限时商店物品[i].grade:setHeight(36)
		ui.限时商店物品[i].grid:addChild(ui.限时商店物品[i].grade)
		ui.限时商店物品[i].money = ui:findComponent("xianshi,xianshi_item_"..i..",money")
		ui.限时商店物品[i].buy = ui:findComponent("xianshi,xianshi_item_"..i..",buy")
		ui.限时商店物品[i].buy.id = i
		ui.限时商店物品[i].buy:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
			local btn = e:getCurrentTarget()
			if btn and m_timeShopItem and m_timeShopItem[btn.id] then
				消息.CG_TIMESHOP_BUY(m_timeShopItem[btn.id].id, m_timeShopItem[btn.id].type)
			end
		end))
		ui.限时商店物品[i].isbuy = ui:findComponent("xianshi,xianshi_item_"..i..",isbuy")
	end]]
	ui.items = {}
	for i=1,ITEMCOUNT do
		ui.items[i] = ui:findComponent("component_1,img_itembg_"..i)
		ui.items[i].name = ui:findComponent("component_1,img_itembg_"..i..",name")
		ui.items[i].grid = ui:findComponent("component_1,img_itembg_"..i..",grid")
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
		ui.items[i].money = ui:findComponent("component_1,img_itembg_"..i..",money")
		ui.items[i].buy = ui:findComponent("component_1,img_itembg_"..i..",buy")
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
	ui.page_cur = ui:findComponent("button_page_cur")
	ui.page_pre = ui:findComponent("button_page_pre")
	ui.page_pre:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		if not m_mallinfo then
			return
		end
		local totalpage = math.ceil(#m_mallinfo / ITEMCOUNT)
		m_curpage = math.max(1, m_curpage - 1)
		update()
	end))
	ui.page_next = ui:findComponent("button_page_next")
	ui.page_next:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		if not m_mallinfo then
			return
		end
		local totalpage = math.ceil(#m_mallinfo / ITEMCOUNT)
		m_curpage = math.min(totalpage, m_curpage + 1)
		update()
	end))
	ui.tab = tt(ui:findComponent("tab_1"), F3DTab)
	ui.tab:addEventListener(F3DUIEvent.CHANGE, func_me(onTabChange))
	if not ISLT then
		--ui.tab:getTabBtn(3):setDisable(true)
	end
	if not g_mobileMode and not ISLT then
		--ui.tab:getTabBtn(4):setDisable(true)
		--ui.tab:getTabBtn(5):setDisable(true)
	end
	ui.subtab = tt(ui:findComponent("tab_2"), F3DTab)
	ui.subtab:addEventListener(F3DUIEvent.CHANGE, func_me(onSubTabChange))
	ui.bindmoney = ui:findComponent("bindmoney")
	ui.money = ui:findComponent("money")
	ui.bindrmb = ui:findComponent("bindrmb")
	ui.rmb = ui:findComponent("rmb")
	ui.vip特权 = ui:findComponent("xianshi,vip特权")
	local vipi = math.max(1, math.min(6, 角色逻辑.m_vip等级 - 3))
	ui.vip特权:setTitleText(txt(VIPPRIZE[vipi]..VIPPRIZE[vipi+1]..VIPPRIZE[vipi+2]..VIPPRIZE[vipi+3]..VIPPRIZE[vipi+4]))
	ui.vip等级 = ui:findComponent("xianshi,vip等级")
	ui.总充值 = ui:findComponent("xianshi,总充值")
	ui.元宝比例 = ui:findComponent("xianshi,元宝比例")
	if ISZY then
		ui.元宝比例:setTitleText(txt("充值元宝比例: 1元 = 200元宝"))
	else
		ui.元宝比例:setTitleText(txt("请查找元宝充值NPC查看充值比例"))
	end
	ui.领取奖励 = ui:findComponent("xianshi,领取奖励")
	ui.领取奖励:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		消息.CG_VIP_REWARD()
	end))
	if g_mobileMode then
		ui:findComponent("xianshi"):setVisible(false)
		ui.充值说明 = ui:findComponent("充值说明")
		ui.充值说明:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
			ui:findComponent("xianshi"):setVisible(not ui:findComponent("xianshi"):isVisible())
		end))
	end
	m_init = true
	update()
	updateTimeShop()
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		宠物蛋提示UI.hideUI()
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
	ui:setMovable(true)
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."商城UIm.layout" or UIPATH.."商城UI.layout")
end
