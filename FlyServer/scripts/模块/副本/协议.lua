module(..., package.seeall)

local ItemProtocol = require("物品.协议")

CopySceneInfo = {
  { "objid", "INT", 1 }, -- ObjID
  { "name", "CHAR", 2 },
  { "level", "SHORT", 1 }, -- 角色等级
  { "killcnt", "SHORT", 1 },
  { "posx", "SHORT", 1 },
  { "posy", "SHORT", 1 },
  { "status", "SHORT", 1 }, -- 0未进入,1正常,2死亡,3离开,4退出
  { "teamid", "SHORT", 1 },
}

GC_COPYSCENE_INFO = {
  { "time", "INT", 1 }, -- 游戏时间
  { "leftcnt", "SHORT", 1 }, -- 剩余人数
  { "totalcnt", "SHORT", 1 }, -- 总人数
  { "info", CopySceneInfo, 30 },
}

TeamInfo = {
  { "objid", "INT", 1 }, -- ObjID
  { "name", "CHAR", 2 },
  { "level", "SHORT", 1 }, -- 角色等级
  { "killcnt", "SHORT", 1 },
  { "hp", "INT", 1 }, -- 角色当前hp
  { "maxhp", "INT", 1 }, -- 角色最大hp
  { "job", "SHORT", 1 }, -- 角色当前hp
}

GC_TEAM_INFO = {
  { "info", TeamInfo, 5 },
}

FinishInfo = {
  { "objid", "INT", 1 }, -- ObjID
  { "name", "CHAR", 2 },
  { "level", "SHORT", 1 }, -- 角色等级
  { "head", "SHORT", 1 },
  { "killcnt", "SHORT", 1 },
  { "deadcnt", "SHORT", 1 },
  { "score", "SHORT", 1 },
  { "teamid", "SHORT", 1 },
  { "mvp", "CHAR", 1 },
}

GC_COPYSCENE_FINISH = {
  { "type", "CHAR", 1 },
  { "winteam", "SHORT", 1 },-- -1:失败 0:平局
  { "score1", "SHORT", 1 },
  { "score2", "SHORT", 1 },
  { "info", FinishInfo, 10 },
}

CG_VIEWER = {
  { "objid", "INT", 1 }, -- ObjID
}

GC_VIEWER = {
  { "objid", "INT", 1 }, -- ObjID
}

CG_CREATE_ROOM = {
  { "copyid", "SHORT", 1 }, -- 副本ID
}

GC_CREATE_ROOM = {
  { "result", "CHAR", 1 }, -- 结果
}

CG_SINGLECOPY_QUERY = {
}

SingleCopyInfo = {
  { "mapid", "SHORT", 1 },--地图id
  { "cnt", "SHORT", 1 },--次数
  { "cntmax", "SHORT", 1 },--最大次数
  { "dropitem", ItemProtocol.ItemData, 4 },
  { "首领", "CHAR", 2 },
  { "finish", "CHAR", 1 },
  { "relive", "INT", 1 }, --复活倒计时
}

GC_SINGLECOPY_INFO = {
  { "info", SingleCopyInfo, 100 },--个人副本
}

CG_ENTER_COPYSCENE = {
  { "mapid", "SHORT", 1 },--地图id
  { "刷怪数量", "CHAR", 1 },
}

GC_ENTER_COPYSCENE = {
  { "result", "CHAR", 1 }, -- 结果
}

CG_QUIT_COPYSCENE = {
}

GC_QUIT_COPYSCENE = {
  { "result", "CHAR", 1 }, -- 结果
}

CG_BOSSCOPY_QUERY = {
}

BossCopyInfo = {
  { "type", "SHORT", 1 },--0野外boss,1个人boss,2转生BOSS
  { "mapid", "SHORT", 1 },--地图id
  { "bodyid", "SHORT", 1 }, --形象ID
  { "effid", "SHORT", 1 }, --特效ID
  { "name", "CHAR", 2 },
  { "zhanli", "INT", 1 },
  { "level", "SHORT", 1 }, --特效ID
  { "status", "SHORT", 1 }, --0正常 1死亡 2已击杀
  { "relive", "INT", 1 }, --复活倒计时
  { "dropitem", ItemProtocol.ItemData, 4 },
}

GC_BOSSCOPY_INFO = {
  { "info", BossCopyInfo, 200 },--BOSS副本
}

CG_REFLESH_BOSS = {
}
