module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 寄售管理 = require("寄售.寄售管理")
local 寄售记录管理 = require("寄售.寄售记录管理")
local 物品逻辑 = require("物品.物品逻辑")
local 背包逻辑 = require("物品.背包逻辑")
local 物品表 = require("配置.物品表").Config
local 玩家DB = require("玩家.玩家DB").玩家DB

TYPES = {
	{{1,0},{2,0}},
	{{3,14}},
	{{3,1}},
	{{3,2}},
	{{3,3}},
	{{3,4}},
	{{3,5}},
	{{3,6}},
	{{3,7},{3,8}},
	{{3,9},{3,10},{3,11},{3,12},{3,13},{3,16}},
}

function SendSellList(human, type)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SELL_LIST]
	oReturnMsg.infoLen = 0
	for i,v in ipairs(寄售管理.dbsorts) do
		if oReturnMsg.infoLen < 50 then
			if v.belong ~= human:GetName() and GetSellItemType(v.grid.id) == type and
				24*60-math.floor((os.time() - v.time) / 60) > 0 then
				oReturnMsg.infoLen = oReturnMsg.infoLen + 1
				oReturnMsg.info[oReturnMsg.infoLen].id = v.id
				oReturnMsg.info[oReturnMsg.infoLen].type = type
				oReturnMsg.info[oReturnMsg.infoLen].icon = 物品逻辑.GetItemIcon(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].grade = v.grid.grade or 物品逻辑.GetItemGrade(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].count = v.grid.count
				oReturnMsg.info[oReturnMsg.infoLen].name = 物品逻辑.GetItemName(v.grid.id, v.grid.strengthen)
				oReturnMsg.info[oReturnMsg.infoLen].job = 物品逻辑.GetItemJob(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].level = 物品逻辑.GetItemLevel(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].time = math.max(0, 24*60-math.floor((os.time() - v.time) / 60))
				oReturnMsg.info[oReturnMsg.infoLen].rmb = v.rmb
				oReturnMsg.info[oReturnMsg.infoLen].price = v.price
			end
		else
			break
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendSellMineList(human)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SELL_MINE_LIST]
	oReturnMsg.infoLen = 0
	for i,v in ipairs(寄售管理.dbsorts) do
		if oReturnMsg.infoLen < 50 then
			if v.belong == human:GetName() then
				oReturnMsg.infoLen = oReturnMsg.infoLen + 1
				oReturnMsg.info[oReturnMsg.infoLen].id = v.id
				oReturnMsg.info[oReturnMsg.infoLen].type = GetSellItemType(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].icon = 物品逻辑.GetItemIcon(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].grade = v.grid.grade or 物品逻辑.GetItemGrade(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].count = v.grid.count
				oReturnMsg.info[oReturnMsg.infoLen].name = 物品逻辑.GetItemName(v.grid.id, v.grid.strengthen)
				oReturnMsg.info[oReturnMsg.infoLen].job = 物品逻辑.GetItemJob(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].level = 物品逻辑.GetItemLevel(v.grid.id)
				oReturnMsg.info[oReturnMsg.infoLen].time = math.max(0, 24*60-math.floor((os.time() - v.time) / 60))
				oReturnMsg.info[oReturnMsg.infoLen].rmb = v.rmb
				oReturnMsg.info[oReturnMsg.infoLen].price = v.price
			end
		else
			break
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendSellRecordList(human)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SELL_RECORD_LIST]
	oReturnMsg.infoLen = 0
	for i=#寄售记录管理.dbsorts,1,-1 do
		v = 寄售记录管理.dbsorts[i]
		if oReturnMsg.infoLen < 50 then
			if v.seller == human:GetName() or v.buyer == human:GetName() then
				oReturnMsg.infoLen = oReturnMsg.infoLen + 1
				oReturnMsg.info[oReturnMsg.infoLen].seller = v.seller
				oReturnMsg.info[oReturnMsg.infoLen].buyer = v.buyer
				oReturnMsg.info[oReturnMsg.infoLen].name = v.name
				local dt = os.date("*t",v.time)
				local dtstr = string.format("%02d:%02d:%02d",dt.hour,dt.min,dt.sec)
				oReturnMsg.info[oReturnMsg.infoLen].timestr = dtstr
				oReturnMsg.info[oReturnMsg.infoLen].rmb = v.rmb
				oReturnMsg.info[oReturnMsg.infoLen].price = human:GetName() == v.seller and math.floor(v.price*0.9) or v.price
			end
		else
			break
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function GetSellItemType(itemid)
	local conf = 物品表[itemid]
	if conf == nil then
		return
	end
	for i,v in ipairs(TYPES) do
		for ii,vv in ipairs(v) do
			if vv[1] == conf.type1 and (vv[2] == 0 or vv[2] == conf.type2) then
				return i
			end
		end
	end
end

function GetSellItemCount(human)
	local count = 0
	for i,v in ipairs(寄售管理.dbsorts) do
		if v.belong == human:GetName() then
			count = count + 1
		end
	end
	return count
end

function SendSellItem(human, pos, rmb, price)
	if human.hp <= 0 then
		return
	end
	local bagdb = human.m_db.bagdb
	if pos <= 0 or pos > bagdb.bagcap then
		return
	end
	local grid = bagdb.baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	if grid.bind == 1 then
		return
	end
	if GetSellItemCount(human) >= 10 then--(human.m_db.vip等级 > 0 and 10 or 3) then
		human:SendTipsMsg(1,"上架商品已满")
		return
	end
	local type = GetSellItemType(grid.id)
	if not type then
		human:SendTipsMsg(1,"该物品无法寄售")
		return
	end
	if price <= 0 then
		human:SendTipsMsg(1,"价格不能为0")
		return
	end
	if human:GetMoney(true) < 2000 then
		human:SendTipsMsg(1,"绑定金币不足")
		return
	end
	human:DecMoney(2000, true)
	寄售管理.AddSellGrid(grid,human:GetName(),rmb,price)
	bagdb.baggrids[pos] = nil
	背包逻辑.SendBagQuery(human, {pos})
	human:SendTipsMsg(0,"寄售成功")
end

function SendSellItemBuy(human, id)
	if human.hp <= 0 then
		return
	end
	local db = nil
	for i,v in ipairs(寄售管理.dbsorts) do
		if v.id == id then
			db = v
			break
		end
	end
	if not db then
		return
	end
	if os.time() - db.time >= 24*60*60 then
		return
	end
	if db.belong == human:GetName() then
		human:SendTipsMsg(1,"不能购买自己的物品")
		return
	end
	if db.rmb == 1 and human.m_db.rmb < db.price then
		human:SendTipsMsg(1,"金子不足")
		return
	end
	if db.rmb ~= 1 and human.m_db.money < db.price then
		human:SendTipsMsg(1,"银子不足")
		return
	end
	local index = 背包逻辑.GetEmptyIndex(human)
	if not index then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	if db.rmb == 1 then
		human:DecRmb(db.price)
	else
		human:DecMoney(db.price)
	end
	local seller = 在线玩家管理[db.belong]
	if seller then
		if db.rmb == 1 then
			seller:AddRmb(math.floor(db.price*0.9))
		else
			seller:AddMoney(math.floor(db.price*0.9))
		end
	else
		local chardb = 玩家DB:New()
		local ret = chardb:LoadByName(db.belong)
		if ret then
			if db.rmb == 1 then
				chardb.rmb = chardb.rmb + math.floor(db.price*0.9)
			else
				chardb.money = chardb.money + math.floor(db.price*0.9)
			end
			chardb:Save()
		end
	end
	local type = GetSellItemType(db.grid.id)
	human.m_db.bagdb.baggrids[index] = db.grid
	背包逻辑.SendBagQuery(human, {index})
	human:SendTipsMsg(2, "获得物品"..(广播.colorRgb[db.grid.grade or 物品逻辑.GetItemGrade(db.grid.id)] or "")..物品逻辑.GetItemName(db.grid.id, db.grid.strengthen)..(db.grid.count > 1 and "x"..db.grid.count or ""))
	寄售记录管理.AddSellRecord(db.belong,human:GetName(),物品逻辑.GetItemName(db.grid.id, db.grid.strengthen),db.rmb,db.price)
	寄售管理.DelSellID(id)
	human:SendTipsMsg(0,"#cff00,购买成功")
	SendSellList(human, type)
end

function SendSellItemOff(human, id)
	if human.hp <= 0 then
		return
	end
	local db = nil
	for i,v in ipairs(寄售管理.dbsorts) do
		if v.id == id then
			db = v
			break
		end
	end
	if not db then
		return
	end
	if db.belong ~= human:GetName() then
		human:SendTipsMsg(1,"该物品不属于你")
		return
	end
	local index = 背包逻辑.GetEmptyIndex(human)
	if not index then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	human.m_db.bagdb.baggrids[index] = db.grid
	背包逻辑.SendBagQuery(human, {index})
	寄售管理.DelSellID(id)
	human:SendTipsMsg(0,"成功取回物品")
	SendSellMineList(human)
end

function SendSellItemQuery(human, id)
	if human.hp <= 0 then
		return
	end
	local db = nil
	for i,v in ipairs(寄售管理.dbsorts) do
		if v.id == id then
			db = v
			break
		end
	end
	if not db then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SELL_ITEM_QUERY]
	oReturnMsg.id = id
	oReturnMsg.itemdataLen = 1
	背包逻辑.PutItemData(oReturnMsg.itemdata[1], 0, db.grid, 0)
	消息类.SendMsg(oReturnMsg, human.id)
end
