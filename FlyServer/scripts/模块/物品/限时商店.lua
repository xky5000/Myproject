module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 日志 = require("公用.日志")
local 日志 = require("公用.日志")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 物品表 = require("配置.物品表").Config
local 商城表 = require("配置.商城表").Config
local 物品逻辑 = require("物品.物品逻辑")

ShopItemID = {}
for i,v in ipairs(商城表) do
	if v.timeshop == 1 then
		ShopItemID[#ShopItemID+1] = {v.itemid, v.type}
	end
end
ShopItems = ShopItems or {}
ShopItemBuy = ShopItemBuy or {}

function Init()
	实用工具.DeleteTable(ShopItems)--ShopItems = {}
	实用工具.DeleteTable(ShopItemBuy)--ShopItemBuy = {}
	local ids = 实用工具.GetRandomTB(#ShopItemID)
	for i=1,4 do
		ShopItems[#ShopItems+1] = ShopItemID[ids[i]]
	end
end

if not ShopItems then
	Init()
end

function FindMallShop(itemid, type)
	for i,v in ipairs(商城表) do
		if v.type == type and v.itemid == itemid then
			return v
		end
	end
end

function SendShopQuery(human)
	local bagdb = human.m_db.bagdb
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_TIMESHOP_QUERY]
	for i,pos in ipairs(ShopItems) do
		local itemid = ShopItems[i][1]
		oReturnMsg.item[i].id = itemid
		oReturnMsg.item[i].name = 物品逻辑.GetItemName(itemid)
		oReturnMsg.item[i].icon = 物品逻辑.GetItemIcon(itemid)
		oReturnMsg.item[i].grade = 物品逻辑.GetItemGrade(itemid)
		oReturnMsg.item[i].type = ShopItems[i][2]
		local 物品 = FindMallShop(itemid, ShopItems[i][2])
		oReturnMsg.item[i].price = 物品 and math.ceil(物品.price * 0.8) or 0
		oReturnMsg.item[i].status = (ShopItemBuy[itemid] and ShopItemBuy[itemid][human:GetName()]) and 1 or 0
	end
	oReturnMsg.itemLen = #ShopItems
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoShopItemBuy(human, id, type)
	if id == 0 then
		return
	end
	local 物品 = FindMallShop(id, type)
	if not 物品 then
		human:SendTipsMsg(1,"找不到指定商品")
		return
	end
	if ShopItemBuy[id] and ShopItemBuy[id][human:GetName()]  then
		human:SendTipsMsg(1,"你已购买此物品")
		return
	end
	local price = math.ceil(物品.price * 0.8)
	local count = 1
	if 物品.type == 0 and price * count > human.m_db.rmb then
		human:SendTipsMsg(1,"元宝不足")
		return
	end
	if 物品.type == 1 and price * count > human.m_db.bindrmb then
		human:SendTipsMsg(1,"绑定元宝不足")
		return
	end
	if 物品.type == 2 and price * count > human.m_db.money then
		human:SendTipsMsg(1,"金币不足")
		return
	end
	if 物品.type == 3 and price * count > human.m_db.bindmoney then
		human:SendTipsMsg(1,"绑定金币不足")
		return
	end
	local indexs = human:PutItemGrids(物品.itemid, count, 0, true) or {}
	if #indexs == 0 then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	if 物品.type == 0 then
		human:DecRmb(price * count, false)
	elseif 物品.type == 1 then
		human:DecRmb(price * count, true)
	elseif 物品.type == 2 then
		human:DecMoney(price * count, false)
	elseif 物品.type == 3 then
		human:DecMoney(price * count, true)
	end
	SendShopQuery(human, indexs)
	human:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品.grade]..物品.name..(count > 1 and "x"..count or ""))
	human:AddQuickItem(物品.itemid)
	human:SendTipsMsg(0,"购买成功")
	ShopItemBuy[id] = ShopItemBuy[id] or {}
	ShopItemBuy[id][human:GetName()] = true
	SendShopQuery(human)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_TIMESHOP_BUY]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end
