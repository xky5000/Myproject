module(..., package.seeall)

ItemProp = {
  { "key", "CHAR", 1 },
  { "val", "INT", 1 },
  { "addval", "INT", 1 },
}

RingSoul = {
  { "name", "CHAR", 2 },
  { "level", "SHORT", 1 },
  { "starlevel", "SHORT", 1 },
  { "grade", "CHAR", 1 },
}

ItemData = {
  { "pos", "SHORT", 1 },--pos
  { "id", "INT", 1 },--物品id
  { "name", "CHAR", 2 },
  { "desc", "CHAR", 2 },
  { "type", "CHAR", 1 }, --1:材料,2:消耗品,3:装备
  { "count", "INT", 1 },--数量
  { "icon", "SHORT", 1 },--icon
  { "cd", "INT", 1 },--冷却时间
  { "cdmax", "INT", 1 },--最大冷却时间
  { "bind", "CHAR", 1 },--是否绑定
  { "grade", "CHAR", 1 },--品阶,1白,2绿,3蓝,4紫,5橙
  { "job", "SHORT", 1 },
  { "level", "SHORT", 1 },
  { "strengthen", "CHAR", 1 },--强化
  { "prop", ItemProp, 50 },--基础属性
  { "addprop", ItemProp, 50 },--洗练属性
  { "attachprop", ItemProp, 2 },--附魔属性
  { "gemprop", ItemProp, 4 },--宝石属性
  { "ringsoul", RingSoul, 2 },--戒灵
  { "power", "INT", 1 },
  { "equippos", "CHAR", 1 },
  { "color", "INT", 1 },
  { "suitprop", ItemProp, 50 },--套装属性
  { "suitname", "CHAR", 2 },--套装名称
}

CG_BAG_QUERY = {
}

GC_BAG_LIST = {
  { "op", "CHAR", 1 },--0查询
  { "itemdata", ItemData, 96 },
}

CG_BAG_REBUILD = {
}

CG_BAG_DISCARD = {
  { "pos", "SHORT", 1 },
}

CG_BAG_SWAP = {
  { "pos", "SHORT", 1 },
  { "posdst", "SHORT", 1 },
}

CG_BAG_DIVIDE = {
  { "pos", "SHORT", 1 },
  { "count", "SHORT", 1 },
}

CG_ITEM_USE = {
  { "pos", "SHORT", 1 },
  { "count", "SHORT", 1 }, --使用数量
  { "hero", "CHAR", 1 },
}

CG_ITEM_STORE = {
  { "pos", "SHORT", 1 },
  { "vip", "SHORT", 1 },
}

CG_EQUIP_QUERY = {
}

GC_EQUIP_LIST = {
  { "op", "CHAR", 1 },
  { "itemdata", ItemData, 27 },
}

CG_EQUIP_ENDUE = {
  { "pos", "SHORT", 1 },
  { "equippos", "SHORT", 1 },
  { "hero", "CHAR", 1 },
}

--脱下装备
CG_EQUIP_UNFIX = {
  { "pos", "SHORT", 1 },
  { "hero", "CHAR", 1 },
}

CG_STORE_QUERY = {
  { "vip", "SHORT", 1 },
}

GC_STORE_LIST = {
  { "op", "CHAR", 1 },
  { "itemdata", ItemData, 192 },
  { "vip", "SHORT", 1 },
}

CG_STORE_REBUILD = {
  { "vip", "SHORT", 1 },
}

CG_STORE_DISCARD = {
  { "pos", "SHORT", 1 },
}

CG_STORE_SWAP = {
  { "pos", "SHORT", 1 },
  { "posdst", "SHORT", 1 },
}

--取出物品
CG_STORE_FETCH = {
  { "pos", "SHORT", 1 },
  { "vip", "SHORT", 1 },
}

CG_STORE_FETCHALL = {
  { "vip", "SHORT", 1 },
}

CG_QUICK_QUERY = {
}

GC_QUICK_LIST = {
  { "id", "INT", 6 },
}

CG_QUICK_SETUP = {
  { "id", "INT", 6 },
}

CG_ITEM_BUY = {
  { "type", "SHORT", 1 },--0元宝,1绑定元宝,2金币,3绑定金币
  { "id", "INT", 1 },
  { "count", "SHORT", 1 },
}

GC_ITEM_BUY = {
  { "result", "CHAR", 1 },
}

CG_ITEM_QUERY = {
  { "id", "INT", 1 },
  { "query", "SHORT", 1 },
}

GC_ITEM_QUERY = {
  { "query", "SHORT", 1 },
  { "itemdata", ItemData, 2 },
}

CG_ITEM_RESOLVE_QUERY = {
  { "pos", "SHORT", 40 },
}

GC_ITEM_RESOLVE_QUERY = {
  { "itemdata", ItemData, 24 },
}

CG_ITEM_RESOLVE = {
  { "pos", "SHORT", 40 },
}

GC_ITEM_RESOLVE = {
  { "result", "SHORT", 1 },
}

TimeShopItem = {
  { "id", "INT", 1 },--物品id
  { "name", "CHAR", 2 },
  { "icon", "SHORT", 1 },--icon
  { "grade", "CHAR", 1 },--品阶,1白,2绿,3蓝,4紫,5橙
  { "type", "SHORT", 1 },--0元宝,1绑定元宝,2金币,3绑定金币
  { "price", "INT", 1 },--价格
  { "status", "CHAR", 1 },--0未购买，1已购买
}

CG_TIMESHOP_QUERY = {
}

GC_TIMESHOP_QUERY = {
  { "item", TimeShopItem, 4 },
}

CG_TIMESHOP_BUY = {
  { "id", "INT", 1 },
  { "type", "SHORT", 1 },--0元宝,1绑定元宝,2金币,3绑定金币
}

GC_TIMESHOP_BUY = {
  { "result", "SHORT", 1 },
}
