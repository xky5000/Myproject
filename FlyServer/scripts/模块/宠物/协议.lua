module(..., package.seeall)

CG_PET_QUERY = {
}

PetInfo = {
  { "index", "SHORT", 1 },
  { "level", "SHORT", 1 },
  { "exp", "INT", 1 },
  { "starlevel", "SHORT", 1 },
  { "starexp", "INT", 1 },
  { "icon", "INT", 1 },
  { "name", "CHAR", 2 },
  { "生命值", "INT", 1 }, -- 生命上限
  { "魔法值", "INT", 1 },
  { "防御", "SHORT", 1 },
  { "防御上限", "SHORT", 1 },
  { "魔御", "SHORT", 1 },
  { "魔御上限", "SHORT", 1 },
  { "攻击", "SHORT", 1 },
  { "攻击上限", "SHORT", 1 },
  { "魔法", "SHORT", 1 },
  { "魔法上限", "SHORT", 1 },
  { "道术", "SHORT", 1 },
  { "道术上限", "SHORT", 1 },
  { "准确", "SHORT", 1 },
  { "移动速度", "SHORT", 1 },
  { "power", "INT", 1 }, --战力
  { "type", "CHAR", 1 },
  { "grade", "CHAR", 1 },
  { "bodyid", "INT", 1 },
  { "effid", "INT", 1 },
  { "expmax", "INT", 1 },
  { "starexpmax", "INT", 1 },
  { "技能图标", "SHORT", 1 },
  { "技能品质", "CHAR", 1 },
  { "技能名字", "CHAR", 2 },
  { "技能描述", "CHAR", 2 },
  { "剩余点数", "SHORT", 1 },
}

CallInfo = {
  { "index", "SHORT", 1 },
  { "call", "CHAR", 1 },
  { "merge", "CHAR", 1 },
  { "objid", "INT", 1 }, -- ObjID
}

GC_PET_INFO = {
  { "petinfo", PetInfo, 20 },
  { "callinfo", CallInfo, 5 },
}

CG_CALL_PET = {
  { "index", "SHORT", 1 },
}

CG_BACK_PET = {
  { "index", "SHORT", 1 },
}

CG_MERGE_PET = {
  { "index", "SHORT", 1 },
}

GC_MERGE_PET = {
  { "objid", "INT", 1 }, -- ObjID
  { "petobjid", "INT", 1 },
}

CG_BREAK_PET = {
  { "index", "SHORT", 1 },
}

CG_TRAIN_PET = {
  { "index1", "SHORT", 1 },
  { "index2", "SHORT", 1 },
}

GC_TRAIN_PET = {
  { "result", "SHORT", 1 },
}

CG_FEED_PET = {
  { "index", "SHORT", 1 },
}

GC_STAR_UPGRADE = {
  { "objid", "INT", 1 },
  { "starlevel", "SHORT", 1 },
}

CG_PET_ADDPOINT = {
  { "index", "SHORT", 1 },
  { "类型", "CHAR", 1 }, --1生命2魔法3防御4魔御5攻击6魔法7道术
}
