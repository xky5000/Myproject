module(..., package.seeall)

local ItemProtocol = require("物品.协议")
local CharProtocol = require("玩家.协议")

GG_ADD_MONSTER_CACHE_DATA = {
  { "name", "CHAR", 64 }, -- 怪物名字
  { "level", "SHORT", 1 }, -- 怪物等级
  { "status", "SHORT", 1 },
  { "buffinfo", CharProtocol.BuffInfo, 10 },
  { "confid", "SHORT", 1 }, --形象ID
  { "bodyid", "SHORT", 2 }, --形象ID
  { "effid", "SHORT", 2 }, --特效ID
  { "type", "SHORT", 1 }, --类型
  { "ownerid", "INT", 1 }, --主人ID
  { "teamid", "SHORT", 1 }, --特效ID
}

GC_ADD_MONSTER = {
  { "name", "CHAR", 64 }, -- 怪物名字
  { "level", "SHORT", 1 }, -- 怪物等级
  { "status", "SHORT", 1 },
  { "buffinfo", CharProtocol.BuffInfo, 10 },
  { "confid", "SHORT", 1 }, --形象ID
  { "bodyid", "SHORT", 2 }, --形象ID
  { "effid", "SHORT", 2 }, --特效ID
  { "type", "SHORT", 1 }, --类型
  { "ownerid", "INT", 1 }, --主人ID
  { "teamid", "SHORT", 1 }, --特效ID
-- 注意 下面开始是c++层数据 由c++层填充 顺序不能移到前面
  { "objid", "INT", 1 } , -- 怪物objid
  { "posx", "INT", 1 }, -- 怪物当前位置X
  { "posy", "INT", 1 }, -- 怪物当前位置X
  { "movex", "INT", 1},
  { "movey", "INT", 1},
  { "maxhp", "INT", 1 }, -- 怪物最大hp
  { "maxmp", "INT", 1 }, -- 怪物最大mp
  { "hp", "INT", 1 }, -- 怪物当前hp
  { "mp", "INT", 1 }, -- 怪物当前mp
  { "speed", "SHORT", 1 }, -- 怪物移动速度
}

GG_ADD_PET_CACHE_DATA = {
  { "name", "CHAR", 64 }, -- 宠物名字
  { "level", "SHORT", 1 }, --宠物等级
  { "status", "SHORT", 1 },
  { "buffinfo", CharProtocol.BuffInfo, 10 },
  { "confid", "SHORT", 1 }, --形象ID
  { "bodyid", "SHORT", 1 }, --形象ID
  { "effid", "SHORT", 1 }, --特效ID
  { "masterid", "INT", 1 }, --主人ID
  { "grade", "SHORT", 1 }, --品阶
  { "starlevel", "SHORT", 1 }, --星级
  { "teamid", "SHORT", 1 }, --队伍ID
}

GC_ADD_PET = {
  { "name", "CHAR", 64 }, -- 宠物名字
  { "level", "SHORT", 1 }, --宠物等级
  { "status", "SHORT", 1 },
  { "buffinfo", CharProtocol.BuffInfo, 10 },
  { "confid", "SHORT", 1 }, --形象ID
  { "bodyid", "SHORT", 1 }, --形象ID
  { "effid", "SHORT", 1 }, --特效ID
  { "masterid", "INT", 1 }, --主人ID
  { "grade", "SHORT", 1 }, --品阶
  { "starlevel", "SHORT", 1 }, --星级
  { "teamid", "SHORT", 1 }, --队伍ID
  -- 注意 下面开始是c++层数据 由c++层填充 顺序不能移到前面
  { "objid", "INT", 1 }, -- 宠物objid
  { "posx", "INT", 1 }, -- 宠物当前位置X
  { "posy", "INT", 1 }, -- 宠物当前位置X
  { "movex", "INT", 1},
  { "movey", "INT", 1},
  { "maxhp", "INT", 1 }, -- 宠物最大hp
  { "maxmp", "INT", 1 }, -- 宠物最大mp
  { "hp", "INT", 1 }, -- 宠物当前hp
  { "mp", "INT", 1 }, -- 宠物当前mp
  { "speed", "SHORT", 1 }, -- 宠物移动速度
}

GC_CHANGE_BODY = {
  { "objid", "INT", 1 }, -- objid
  { "bodyid", "SHORT", 1 }, --形象ID
  { "effid", "SHORT", 1 }, --特效ID
  { "speed", "SHORT", 1 }, -- 移动速度
}

GG_ADD_NPC_CACHE_DATA = {
  { "name", "CHAR", 32 }, -- NPC名字
  { "level", "SHORT", 1 }, -- 怪物等级
  { "confid", "SHORT", 1 }, --形象ID
  { "bodyid", "SHORT", 1 }, --形象ID
  { "effid", "SHORT", 1 }, --特效ID
}

GC_ADD_NPC = {
  { "name", "CHAR", 32 }, -- NPC名字
  { "level", "SHORT", 1 }, -- 怪物等级
  { "confid", "SHORT", 1 }, --形象ID
  { "bodyid", "SHORT", 1 }, --形象ID
  { "effid", "SHORT", 1 }, --特效ID
  -- 注意 下面开始是c++层数据 由c++层填充 顺序不能移到前面
  { "objid", "INT", 1 }, -- objid
  { "posx", "INT", 1 }, -- 当前位置X
  { "posy", "INT", 1 }, -- 当前位置X
}

GG_ADD_ITEM_CACHE_DATA = {
  { "name", "CHAR", 32 }, -- 道具名称
  { "icon", "SHORT", 1 }, -- ITEM图标
  { "itemid", "SHORT", 1 }, --形象ID
  { "cnt", "INT", 1 }, -- ITEM图标
  { "ownerid", "INT", 1 }, -- 物主
  { "grade", "SHORT", 1 }, --品阶
  { "teamid", "SHORT", 1 }, --队伍ID
  { "color", "INT", 1 }, -- 颜色
}

GC_ADD_ITEM = {
  { "name", "CHAR", 32 }, -- 道具名称
  { "icon", "SHORT", 1 }, -- ITEM图标
  { "itemid", "SHORT", 1 }, --形象ID
  { "cnt", "INT", 1 }, -- ITEM图标
  { "ownerid", "INT", 1 }, -- 物主
  { "grade", "SHORT", 1 }, --品阶
  { "teamid", "SHORT", 1 }, --队伍ID
  { "color", "INT", 1 }, -- 颜色
  -- 注意 下面开始是c++层数据 由c++层填充 顺序不能移到前面
  { "objid", "INT", 1 }, -- objid
  { "posx", "INT", 1 }, -- 当前位置X
  { "posy", "INT", 1 }, -- 当前位置X
}

CG_NPC_TALK = {
  { "objid", "INT", 1 }, -- objid
  { "talkid", "SHORT", 1 }, -- objid
}

NpcTalk = {
  { "talk", "CHAR", 2 }, -- objid
  { "color", "INT", 1 }, -- objid
  { "talkid", "SHORT", 1},
}

GC_NPC_TALK = {
  { "objid", "INT", 1 }, -- objid
  { "bodyid", "SHORT", 1 }, -- objid
  { "effid", "SHORT", 1 }, -- objid
  { "desc", "CHAR", 2 }, -- objid
  { "taskid", "SHORT", 1 }, -- taskid
  { "state", "SHORT", 1 }, -- 0:未接受,1:已接受,2:已完成
  { "talk", NpcTalk, 10 }, -- objid
  { "prize", ItemProtocol.ItemData, 6 }, -- objid
}

CG_NPC_TALK_PUT = {
  { "objid", "INT", 1 }, -- objid
  { "talkid", "SHORT", 1 }, -- objid
  { "type", "CHAR", 1 }, -- 1:string,2:integer
  { "callid", "SHORT", 1 }, -- callid
  { "talk", "CHAR", 128 }, -- objid
}

CG_PICK_ITEM = {
  { "objid", "INT", 1 }, -- objid
}

GC_PICK_ITEM = {
  { "objid", "INT", 1 }, -- objid
}

CG_ACCEPT_TASK = {
  { "taskid", "SHORT", 1 }, -- objid
}

CG_FINISH_TASK = {
  { "taskid", "SHORT", 1 }, -- objid
}

TaskObj = {
  { "type", "SHORT", 1 }, -- 0:NPC,1:打怪,2:采集,3:收集
  { "name", "CHAR", 2 }, -- objid
  { "mapid", "SHORT", 1 }, -- objid
  { "posx", "INT", 1 }, -- objid
  { "posy", "INT", 1 }, -- objid
  { "confid", "SHORT", 1 }, -- objid
  { "cnt", "SHORT", 1 }, -- objid
  { "cntmax", "SHORT", 1 }, -- objid
}

TaskInfo = {
  { "name", "CHAR", 2 }, -- objid
  { "explain", "CHAR", 2 }, -- objid
  { "taskid", "SHORT", 1 }, -- objid
  { "state", "SHORT", 1 }, -- 0:未接受,1:已接受,2:已完成
  { "level", "SHORT", 1 }, -- objid
  { "obj", TaskObj, 10 }, -- TaskObj
  { "type", "SHORT", 1 }, -- 0:主线,1:支线,2:日常
  { "cnt", "SHORT", 1 }, -- objid
  { "cntmax", "SHORT", 1 }, -- objid
}

CG_TASK_QUERY = {
}

GC_TASK_INFO = {
  { "info", TaskInfo, 20 }, -- objid
  { "query", "CHAR", 1 }, -- objid
}
