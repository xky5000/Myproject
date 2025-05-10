module(..., package.seeall)

local ItemProtocol = require("物品.协议")

ItemProp = {
  { "key", "CHAR", 1 },
  { "val", "INT", 1 },
  { "addval", "INT", 1 },
}

CG_EQUIP_PREVIEW = {
  { "contpos", "SHORT", 1 },
  { "pos", "SHORT", 1 },
}

GC_EQUIP_PREVIEW = {
  { "prop", ItemProp, 10 },--基础属性
}

CG_PERFECT_PREVIEW = {
  { "contpos", "SHORT", 1 },
  { "pos", "SHORT", 1 },
}

GC_PERFECT_PREVIEW = {
  { "itemdata", ItemProtocol.ItemData, 2 },
}

CG_STRENGTHEN = {
  { "contpos", "SHORT", 1 },
  { "pos", "SHORT", 1 },
}

GC_STRENGTHEN = {
  { "result", "SHORT", 1 },
}

CG_STRENGTHEN_TRANSFER = {
  { "contpos", "SHORT", 1 },
  { "pos", "SHORT", 1 },
  { "contposdst", "SHORT", 1 },
  { "posdst", "SHORT", 1 },
}

GC_STRENGTHEN_TRANSFER = {
  { "result", "SHORT", 1 },
}

CG_REFINE_WASH = {
  { "contpos", "SHORT", 1 },
  { "pos", "SHORT", 1 },
  { "lock", "SHORT", 4 },
}

GC_REFINE_WASH = {
  { "result", "SHORT", 1 },
}

CG_REFINE_UPGRADE = {
  { "contpos", "SHORT", 1 },
  { "pos", "SHORT", 1 },
}

GC_REFINE_UPGRADE = {
  { "result", "SHORT", 1 },
}

CG_STRENGTHEN_ALL = {
  { "contpos", "SHORT", 1 },
  { "pos", "SHORT", 1 },
  { "contposdst", "SHORT", 1 },
  { "posdst", "SHORT", 1 },
  { "contposnxt", "SHORT", 1 },
  { "posnxt", "SHORT", 1 },
}

GC_STRENGTHEN_ALL = {
  { "result", "SHORT", 1 },
}
