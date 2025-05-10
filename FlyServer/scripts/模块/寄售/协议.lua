module(..., package.seeall)

local ItemProtocol = require("物品.协议")

SellInfo = {
  { "id", "INT", 1 },			--唯一id
  { "icon", "SHORT", 1 },
  { "grade", "CHAR", 1 },
  { "count", "SHORT", 1 },
  { "name", "CHAR", 2 },
  { "job", "CHAR", 1 },
  { "level", "SHORT", 1 },
  { "time", "SHORT", 1 },		--期限，分钟单位
  { "rmb", "CHAR", 1 },			--0金币，1元宝
  { "price", "INT", 1 },
  { "type", "CHAR", 1 },		--类型
}

CG_SELL_QUERY = {
  { "type", "CHAR", 1 },
}

GC_SELL_LIST = {
  { "info", SellInfo, 50 },
}

CG_SELL_MINE_QUERY = {
}

GC_SELL_MINE_LIST = {
  { "info", SellInfo, 50 },
}

RecordInfo = {
  { "seller", "CHAR", 2 },
  { "buyer", "CHAR", 2 },
  { "name", "CHAR", 2 },
  { "timestr", "CHAR", 2 },			--时间
  { "rmb", "CHAR", 1 },			--0金币，1元宝
  { "price", "INT", 1 },
}

CG_SELL_RECORD_QUERY = {
}

GC_SELL_RECORD_LIST = {
  { "info", RecordInfo, 50 },
}

CG_SELL_ITEM = {
  { "pos", "SHORT", 1 },
  { "rmb", "CHAR", 1 },			--0金币，1元宝
  { "price", "INT", 1 },
}

CG_SELL_ITEM_BUY = {
  { "id", "INT", 1 },
}

CG_SELL_ITEM_OFF = {
  { "id", "INT", 1 },
}

CG_SELL_ITEM_QUERY = {
  { "id", "INT", 1 },
}

GC_SELL_ITEM_QUERY = {
  { "id", "INT", 1 },
  { "itemdata", ItemProtocol.ItemData, 2 },
}
