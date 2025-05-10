module(..., package.seeall)

local 寄售UI = require("主界面.寄售UI")

function GC_SELL_LIST(info)
	寄售UI.setInfo(info)
end

function GC_SELL_MINE_LIST(info)
	寄售UI.setInfo(info)
end

function GC_SELL_RECORD_LIST(info)
	寄售UI.setRecordInfo(info)
end

function GC_SELL_ITEM_QUERY(id,itemdata)
	寄售UI.setItemData(id,itemdata)
end

