module(..., package.seeall)

CG_USE_SKILL = {
  { "skillid", "SHORT", 1 },
  { "targetid", "INT", 1 },
  { "posx", "INT", 1 },
  { "posy", "INT", 1 },
}

GC_USE_SKILL = {
  { "objid", "INT", 1 },
  { "targetid", "INT", 1 },
  { "skillid", "SHORT", 1 },
  { "action", "CHAR", 2 },
  { "sound", "CHAR", 2 },
  { "effid1", "SHORT", 1 },--起手特效
  { "effid2", "SHORT", 1 },--目标特效
  { "effid3", "SHORT", 1 },--飞行特效
  { "posx", "INT", 1 },
  { "posy", "INT", 1 },
  { "flytime", "SHORT", 1 },--飞行特效开始时间
  { "follow", "SHORT", 1 },--跟随时间
}

GC_SKILL_ERR = {
  { "err", "CHAR", 2 },
}

GC_SKILL_HURT = {
  { "objid", "INT", 1 },
  { "effid1", "SHORT", 1 },--受击特效
  { "effid2", "SHORT", 1 },--死亡或复活特效
  { "dechp", "INT", 1 },
  { "crit", "CHAR", 1 },--0普通,1暴击,2无伤害
  { "status", "CHAR", 1 },--0普通,1死亡,2复活
  { "hittype", "CHAR", 1 },
}

GC_SKILL_DISPLACE = {
  { "objid", "INT", 1 },
  { "hitfly", "SHORT", 1 },--击飞高度
  { "posx", "INT", 1 },
  { "posy", "INT", 1 },
  { "time", "INT", 1 },
  { "passive", "INT", 1 },--被动
}

BuffInfo = {
  { "type", "CHAR", 1 },
  { "val", "SHORT", 1 },
}

GC_SKILL_BUFF = {
  { "objid", "INT", 1 },
  { "effid", "SHORT", 1 },--特效
  { "time", "INT", 1 },
  { "icon", "INT", 1 },
  { "info", BuffInfo, 10 },
}

--受控制
GC_SKILL_CONTROLLED = {
  { "objid", "INT", 1 },
  { "type", "CHAR", 1},--1不能攻击,0不能移动
  { "controlled", "CHAR", 1 },--1是,0否
}

CG_SKILL_QUERY = {
}

CostItem = {
  { "name", "CHAR", 2 },
  { "count", "SHORT", 1 },
}

SkillInfo = {
  { "infoid", "SHORT", 1 },--skillinfoid
  { "lv", "SHORT", 1 },--等级
  { "cd", "INT", 1 },--cd
  { "damage1", "SHORT", 1 },
  { "damage2", "SHORT", 1 },
  { "type", "SHORT", 1 },--0单体，1近程，2远程
  { "range", "SHORT", 1 },
  { "icon", "SHORT", 1 },
  { "desc", "CHAR", 2 },
  { "skillid", "SHORT", 5 },
  { "name", "CHAR", 2 },
  { "passive", "SHORT", 1 },--0主体，1被动
  { "hangup", "SHORT", 1 },--0不挂机，1挂机
  { "grade", "SHORT", 1 },
  { "lvmax", "SHORT", 1 },--最高等级
  { "updamage1", "SHORT", 1 },
  { "updamage2", "SHORT", 1 },
  { "costlevel", "SHORT", 1 },
  { "costitem", CostItem, 2 },
  { "hero", "CHAR", 1 },
  { "decmp", "SHORT", 1 },
  { "special", "CHAR", 1 },
}

GC_SKILL_INFO = {
  { "info", SkillInfo, 100 },
}

SkillLearn = {
  { "infoid", "SHORT", 1 },
  { "icon", "SHORT", 1 },
  { "name", "CHAR", 2 },
  { "grade", "SHORT", 1 },
}

GC_SKILL_LEARNINFO = {
  { "learn", SkillLearn, 5 },
}

CG_SKILL_LEARN = {
  { "infoid", "SHORT", 1 },
}

GC_SKILL_LEARN = {
  { "result", "CHAR", 1 },--0成功,1该技能已学习,2技能已满,3无技能学习
}

CG_SKILL_UPGRADE = {
  { "infoid", "SHORT", 1 },
}

GC_SKILL_UPGRADE = {
  { "result", "CHAR", 1 },--0成功,1该技能已学习,2技能已满,3无技能学习
}

CG_SKILL_DISCARD = {
  { "infoid", "SHORT", 1 },
}

GC_SKILL_DISCARD = {
  { "result", "CHAR", 1 },--0成功,1该技能已学习,2技能已满,3无技能学习
}

CG_SKILL_QUICK_QUERY = {
}

GC_SKILL_QUICK_LIST = {
  { "id", "SHORT", 6 },
}

CG_SKILL_QUICK_SETUP = {
  { "id", "SHORT", 6 },
}

CG_SKILL_HANGUP = {
  { "infoid", "SHORT", 1 },
  { "hangup", "SHORT", 1 },--0不挂机，1挂机
}
