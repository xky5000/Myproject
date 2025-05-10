module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 寄售逻辑 = require("寄售.寄售逻辑")

function CG_SELL_QUERY(oHuman, oMsg)
	寄售逻辑.SendSellList(oHuman, oMsg.type)
end

function CG_SELL_MINE_QUERY(oHuman, oMsg)
	寄售逻辑.SendSellMineList(oHuman)
end

function CG_SELL_RECORD_QUERY(oHuman, oMsg)
	寄售逻辑.SendSellRecordList(oHuman)
end

function CG_SELL_ITEM(oHuman, oMsg)
	寄售逻辑.SendSellItem(oHuman, oMsg.pos, oMsg.rmb, oMsg.price)
end

function CG_SELL_ITEM_BUY(oHuman, oMsg)
	寄售逻辑.SendSellItemBuy(oHuman, oMsg.id)
end

function CG_SELL_ITEM_OFF(oHuman, oMsg)
	寄售逻辑.SendSellItemOff(oHuman, oMsg.id)
end

function CG_SELL_ITEM_QUERY(oHuman, oMsg)
	寄售逻辑.SendSellItemQuery(oHuman, oMsg.id)
end
