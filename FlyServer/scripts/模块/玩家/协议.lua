module(..., package.seeall)

local ItemProtocol = require("物品.协议")

CG_ASK_LOGIN = {
  { "account", "CHAR", 32 }, -- 帐号
  { "authkey", "CHAR", 128 }, -- 校验key
  { "timestamp", "INT", 1 }, -- 时间戳
  { "status", "CHAR", 1 }, -- 防沉迷状态[未填,未通过,已通过]
}

GC_ASK_LOGIN = {
  { "result", "CHAR", 1 }, -- 登录结果
  { "svrname", "CHAR", 32 }, -- 游戏服务器名称
  { "msvrip", "CHAR", 32 }, -- 跨服pk服ip
  { "msvrport", "SHORT", 1 }, -- 跨服pk服port
}

CG_CREATE_ROLE = {
  { "rolename", "CHAR", 32 }, -- 帐号
  { "sex", "CHAR", 1 }, -- 性别
  { "job", "CHAR", 1 }, -- 职业
}

GC_JUMP_SCENE = {
  { "objid", "INT", 1 }, -- 角色objid
  { "mapid", "SHORT", 1 }, -- 地图id
  { "x", "INT", 1 }, -- 移动位置的x坐标
  { "y", "INT", 1 }, -- 移动位置的y坐标
}

GC_ENTER_SCENE = {
  { "result", "SHORT", 1 }, -- 进入场景结果
  { "objid", "INT", 1 }, -- ObjID
  { "mapid", "SHORT", 1 }, -- 地图id
  { "maptype", "CHAR", 1 }, -- 地图类型
  { "scenex", "INT", 1 }, -- 场景x坐标
  { "sceney", "INT", 1 }, -- 场景y坐标
  { "mode", "CHAR", 1 }, -- 白天/黑夜模式
  { "mapwidth", "INT", 1 },
  { "mapheight", "INT", 1 },
  { "isstatshurt", "CHAR", 1 }
}

CG_ENTER_SCENE_OK = {
  { "isfirstenter", "CHAR", 1 }, -- 是否首次进入游戏场景
}

BuffInfo = {
  { "effid", "INT", 1 },
  { "icon", "INT", 1 },
  { "time", "INT", 1 },
}

MergeHP = {
  { "maxhp", "INT", 1 },
  { "hp", "INT", 1 },
  { "grade", "SHORT", 1 },
}

GC_ATTACK_GUILD = {
  { "challenge", "CHAR", 2 }, -- 敌对行会名字
  { "alliance", "CHAR", 2 }, -- 联盟行会名字
}

GC_CHANGE_NAME = {
  { "rolename", "CHAR", 64 }, -- 角色名字
  { "guildname", "CHAR", 64 }, -- 行会名字
  { "color", "CHAR", 1 }, -- 0普通,1灰名,2黄名,3红名,4紫名,5绿名,6蓝名,7橙名
  { "title", "SHORT", 16 }, -- 称号
  { "objid", "INT", 1 }, -- ObjID
  { "ownerid", "INT", 1 }, --主人ID
}

GC_HUMAN_INFO = {
  { "rolename", "CHAR", 64 }, -- 角色名字
  { "guildname", "CHAR", 64 }, -- 行会名字
  { "challenge", "CHAR", 2 }, -- 敌对行会名字
  { "alliance", "CHAR", 2 }, -- 联盟行会名字
  { "color", "CHAR", 1 }, -- 0普通,1灰名,2黄名,3红名,4紫名,5绿名,6蓝名,7橙名
  { "title", "SHORT", 16 }, -- 称号
  { "objid", "INT", 1 }, -- ObjID
  { "level", "SHORT", 1 }, -- 角色等级
  { "job", "CHAR", 1 }, -- 1狂战,2魔导,3龙骑,4亡灵
  { "sex", "CHAR", 1 }, -- 1男,2女
  { "status", "SHORT", 1 },
  { "pkmode", "CHAR", 1 },
  { "mapid", "SHORT", 1 }, -- 地图id
  { "scenex", "INT", 1 }, -- 场景x坐标
  { "sceney", "INT", 1 }, -- 场景y坐标
  { "speed", "SHORT", 1 }, -- 移动速度
  { "maxhp", "INT", 1 }, -- 角色最大hp
  { "maxmp", "INT", 1 }, -- 角色最大mp
  { "hp", "INT", 1 }, -- 角色当前hp
  { "mp", "INT", 1 }, -- 角色当前mp
  { "tp", "SHORT", 1 }, -- tp
  { "buffinfo", BuffInfo, 10 },
  { "mergehp", MergeHP, 5 },
  { "bodyid", "INT", 1 }, -- 身体外观
  { "weaponid", "INT", 1 }, -- 武器外观
  { "wingid", "INT", 1 }, -- 翅膀外观
  { "horseid", "INT", 1 }, -- 坐骑外观
  { "bodyeff", "INT", 1 }, -- 身上特效
  { "weaponeff", "INT", 1 }, -- 身上特效
  { "wingeff", "INT", 1 }, -- 身上特效
  { "horseeff", "INT", 1 }, -- 身上特效
  { "teamid", "SHORT", 1 }, -- 队伍ID
  { "斗笠外观", "SHORT", 1 },
  { "总充值", "INT", 1 },
  { "每日充值", "INT", 1 },
  { "特戒抽取次数", "SHORT", 1 },
  { "刷新BOSS次数", "SHORT", 1 },
  { "开区活动倒计时", "INT", 1 },
  { "vip等级", "CHAR", 1 },
  { "HP保护", "CHAR", 1 },
  { "MP保护", "CHAR", 1 },
  { "英雄HP保护", "CHAR", 1 },
  { "英雄MP保护", "CHAR", 1 },
  { "自动分解白", "CHAR", 1 },
  { "自动分解绿", "CHAR", 1 },
  { "自动分解蓝", "CHAR", 1 },
  { "自动分解紫", "CHAR", 1 },
  { "自动分解橙", "CHAR", 1 },
  { "自动分解等级", "CHAR", 1 },
  { "使用生命药", "SHORT", 1 },
  { "使用魔法药", "SHORT", 1 },
  { "英雄使用生命药", "SHORT", 1 },
  { "英雄使用魔法药", "SHORT", 1 },
  { "使用物品HP", "CHAR", 1 },
  { "使用物品ID", "SHORT", 1 },
  { "自动使用合击", "CHAR", 1 },
  { "自动分解宠物白", "CHAR", 1 },
  { "自动分解宠物绿", "CHAR", 1 },
  { "自动分解宠物蓝", "CHAR", 1 },
  { "自动分解宠物紫", "CHAR", 1 },
  { "自动分解宠物橙", "CHAR", 1 },
  { "自动孵化宠物蛋", "CHAR", 1 },
  { "物品自动拾取", "CHAR", 1 },
  { "显示时装", "CHAR", 1 },
  { "英雄显示时装", "CHAR", 1 },
  { "显示炫武", "CHAR", 1 },
  { "英雄显示炫武", "CHAR", 1 },
  { "副本刷怪数量", "CHAR", 1 },
  { "队伍拒绝邀请", "CHAR", 1 },
  { "队伍拒绝申请", "CHAR", 1 },
}

GC_HERO_INFO = {
  { "rolename", "CHAR", 64 }, -- 角色名字
  { "objid", "INT", 1 }, -- ObjID
  { "level", "SHORT", 1 }, -- 角色等级
  { "job", "CHAR", 1 }, -- 1狂战,2魔导,3龙骑,4亡灵
  { "sex", "CHAR", 1 }, -- 1男,2女
  { "status", "SHORT", 1 },
  { "maxhp", "INT", 1 }, -- 角色最大hp
  { "maxmp", "INT", 1 }, -- 角色最大mp
  { "hp", "INT", 1 }, -- 角色当前hp
  { "mp", "INT", 1 }, -- 角色当前mp
}

CG_HUMAN_SETUP = {
  { "HP保护", "SHORT", 1 },
  { "MP保护", "SHORT", 1 },
  { "英雄HP保护", "SHORT", 1 },
  { "英雄MP保护", "SHORT", 1 },
  { "自动分解白", "CHAR", 1 },
  { "自动分解绿", "CHAR", 1 },
  { "自动分解蓝", "CHAR", 1 },
  { "自动分解紫", "CHAR", 1 },
  { "自动分解橙", "CHAR", 1 },
  { "自动分解等级", "CHAR", 1 },
  { "使用生命药", "SHORT", 1 },
  { "使用魔法药", "SHORT", 1 },
  { "英雄使用生命药", "SHORT", 1 },
  { "英雄使用魔法药", "SHORT", 1 },
  { "使用物品HP", "CHAR", 1 },
  { "使用物品ID", "SHORT", 1 },
  { "自动使用合击", "CHAR", 1 },
  { "自动分解宠物白", "CHAR", 1 },
  { "自动分解宠物绿", "CHAR", 1 },
  { "自动分解宠物蓝", "CHAR", 1 },
  { "自动分解宠物紫", "CHAR", 1 },
  { "自动分解宠物橙", "CHAR", 1 },
  { "自动孵化宠物蛋", "CHAR", 1 },
  { "物品自动拾取", "CHAR", 1 },
}

CG_PROP_ADDPOINT = {
  { "是否英雄", "CHAR", 1 },
  { "类型", "CHAR", 1 }, --1生命2魔法3防御4魔御5攻击6魔法7道术
}

GC_PROP_ADDPOINT = {
  { "剩余点数", "SHORT", 1 },
  { "英雄剩余点数", "SHORT", 1 },
}

CG_VIP_SPREAD = {
  { "rolename", "CHAR", 32 },
  { "礼包领取", "SHORT", 2 },
  { "每日充值领取", "CHAR", 1 },
}

GC_VIP_SPREAD = {
  { "rolename", "CHAR", 2 },
  { "成长经验", "INT", 1 }, -- ObjID
  { "推广人数", "SHORT", 1 }, -- ObjID
  { "推广有效人数", "SHORT", 1 }, -- ObjID
  { "礼包领取", "SHORT", 20 }, -- ObjID
  { "每日充值领取", "SHORT", 20 }, -- ObjID
}

GC_LEVEL_UP = {
  { "objid", "INT", 1 }, -- ObjID
  { "level", "SHORT", 1 },
}

GC_XP_INFO = {
  { "objid", "INT", 1 }, -- ObjID
  { "status", "CHAR", 1 }, -- 0未变身,1可变身,2已变身
  { "cd", "INT", 1 }, -- 变身cd
  { "cdmax", "INT", 1 }, -- 变身cdmax
  { "icon", "SHORT", 1 }, -- 变身图标
}

CG_XP_USE = {
  { "targetid", "INT", 1 }, -- ObjID
}

GC_XP_USE = {
  { "objid", "INT", 1 }, -- ObjID
  { "effid", "INT", 1 }, -- ObjID
}

CG_USE_MOUNT = {
  { "mountid", "INT", 1 }, -- ObjID
}

CG_USE_WING = {
  { "wingid", "INT", 1 }, -- ObjID
}

CG_REQUEST_RELIVE = {
  { "type", "CHAR", 1 }, -- 0原地,1回城
}

CG_SHOW_FASHION = {
  { "显示时装", "CHAR", 1 },
  { "英雄显示时装", "CHAR", 1 },
  { "显示炫武", "CHAR", 1 },
  { "英雄显示炫武", "CHAR", 1 },
}

GC_CHANGE_INFO = {
  { "objid", "INT", 1 }, -- ObjID
  { "maxhp", "INT", 1 },
  { "hp", "INT", 1 },
  { "mergehp", MergeHP, 5 },
}

GC_CHANGE_FACADE = {
  { "objid", "INT", 1 }, -- ObjID
  { "bodyid", "INT", 1 }, -- 身体外观
  { "weaponid", "INT", 1 }, -- 武器外观
  { "wingid", "INT", 1 }, -- 翅膀外观
  { "horseid", "INT", 1 }, -- 坐骑外观
  { "bodyeff", "INT", 1 }, -- 身上特效
  { "weaponeff", "INT", 1 }, -- 身上特效
  { "wingeff", "INT", 1 }, -- 身上特效
  { "horseeff", "INT", 1 }, -- 身上特效
  { "speed", "SHORT", 1 }, -- 移动速度
  { "斗笠外观", "SHORT", 1 }, -- 队伍ID
}

GC_CHANGE_TEAM = {
  { "objid", "INT", 1 }, -- ObjID
  { "teamid", "SHORT", 1 },
}

CG_CHANGE_JOB = {
  { "job", "CHAR", 1 }, -- 职业
}

GC_CHANGE_JOB = {
  { "objid", "INT", 1 }, -- ObjID
  { "rolename", "CHAR", 32 }, -- 帐号
  { "sex", "CHAR", 1 }, -- 性别
  { "job", "CHAR", 1 }, -- 职业
}

GC_ACTUAL_ATTR = {
  { "objid", "INT", 1 }, -- ObjID
  { "expmax", "INT", 1 }, -- 经验值
  { "exp", "INT", 1 }, -- 经验值
  { "mpmax", "INT", 1 }, -- 角色最大mp
  { "mp", "INT", 1 }, -- 角色当前mp
  { "tp", "SHORT", 1 }, -- tp
}

GC_DETAIL_ATTR = {
  { "expmax", "INT", 1 }, -- 经验值
  { "exp", "INT", 1 }, -- 经验值
  { "hpmax", "INT", 1 }, -- 角色最大hp
  { "hp", "INT", 1 }, -- 角色当前hp
  { "mpmax", "INT", 1 }, -- 角色最大mp
  { "mp", "INT", 1 }, -- 角色当前mp
  { "money", "INT", 1 }, -- 金币
  { "bindmoney", "INT", 1 }, -- 绑定金币
  { "rmb", "INT", 1 }, -- 元宝
  { "bindrmb", "INT", 1 }, -- 绑定元宝
  { "speed", "SHORT", 1 }, -- 移动速度
  { "power", "INT", 1 }, --战力
  { "totalpower", "INT", 1 }, --总战力
  { "suitcnts", "SHORT", 20 },
  { "PK值", "INT", 1 },
  { "总充值", "INT", 1 },
  { "每日充值", "INT", 1 },
  { "特戒抽取次数", "SHORT", 1 },
  { "刷新BOSS次数", "SHORT", 1 },
  { "开区活动倒计时", "INT", 1 },
  { "vip等级", "CHAR", 1 },
  { "转生等级", "CHAR", 1 },
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
  { "幸运", "SHORT", 1 },
  { "准确", "SHORT", 1 },
  { "敏捷", "SHORT", 1 },
  { "魔法命中", "SHORT", 1 },
  { "魔法躲避", "SHORT", 1 },
  { "生命恢复", "SHORT", 1 },
  { "魔法恢复", "SHORT", 1 },
  { "中毒恢复", "SHORT", 1 },
  { "攻击速度", "SHORT", 1 },
  { "移动速度", "SHORT", 1 },
  { "力量", "SHORT", 1 },
  { "智力", "SHORT", 1 },
  { "精神", "SHORT", 1 },
  { "体质", "SHORT", 1 },
  { "重击", "SHORT", 1 },
}

CG_EQUIP_VIEW = {
  { "objid", "INT", 1 }, -- ObjID
  { "rolename", "CHAR", 64 }, -- 角色名字
}

GC_EQUIP_VIEW = {
  { "rolename", "CHAR", 64 }, -- 角色名字
  { "objid", "INT", 1 }, -- ObjID
  { "level", "SHORT", 1 }, -- 角色等级
  { "job", "CHAR", 1 }, -- 1狂战,2魔导,3龙骑,4亡灵
  { "sex", "CHAR", 1 }, -- 1男,2女
  { "expmax", "INT", 1 }, -- 经验值
  { "exp", "INT", 1 }, -- 经验值
  { "bodyid", "INT", 1 }, -- 身体外观
  { "weaponid", "INT", 1 }, -- 武器外观
  { "wingid", "INT", 1 }, -- 翅膀外观
  { "horseid", "INT", 1 }, -- 坐骑外观
  { "bodyeff", "INT", 1 }, -- 身上特效
  { "weaponeff", "INT", 1 }, -- 身上特效
  { "wingeff", "INT", 1 }, -- 身上特效
  { "horseeff", "INT", 1 }, -- 身上特效
  { "hpmax", "INT", 1 }, -- 角色最大hp
  { "mpmax", "INT", 1 }, -- 角色最大mp
  { "speed", "SHORT", 1 }, -- 移动速度
  { "power", "INT", 1 }, --战力
  { "转生等级", "CHAR", 1 },
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
  { "幸运", "SHORT", 1 },
  { "准确", "SHORT", 1 },
  { "敏捷", "SHORT", 1 },
  { "魔法命中", "SHORT", 1 },
  { "魔法躲避", "SHORT", 1 },
  { "生命恢复", "SHORT", 1 },
  { "魔法恢复", "SHORT", 1 },
  { "中毒恢复", "SHORT", 1 },
  { "攻击速度", "SHORT", 1 },
  { "移动速度", "SHORT", 1 },
  { "itemdata", ItemProtocol.ItemData, 27 },
  { "是否英雄", "CHAR", 1 },
  { "斗笠外观", "SHORT", 1 }, -- 队伍ID
  { "显示时装", "CHAR", 1 },
  { "显示炫武", "CHAR", 1 },
  { "力量", "SHORT", 1 },
  { "智力", "SHORT", 1 },
  { "精神", "SHORT", 1 },
  { "体质", "SHORT", 1 },
  { "重击", "SHORT", 1 },
}

CG_CHANGE_STATUS = {
  { "status", "SHORT", 1 },
  { "pkmode", "CHAR", 1 },
}

GC_CHANGE_STATUS = {
  { "objid", "INT", 1 }, -- ObjID
  { "status", "SHORT", 1 },
  { "pkmode", "CHAR", 1 },
}

GC_CHANGE_SPEED = {
  { "objid", "INT", 1 }, -- ObjID
  { "speed", "SHORT", 1 },
}

CG_MOVE_GRID = {
  { "movex", "INT", 1},
  { "movey", "INT", 1},
}

CG_MOVE = {
  { "movex", "INT", 1},
  { "movey", "INT", 1},
}

GC_MOVE = {
  { "objid", "INT", 1 }, -- 角色objid
  { "objtype", "SHORT", 1 }, -- 角色objtype
  { "posx", "INT", 1},
  { "posy", "INT", 1},
  { "movex", "INT", 1},
  { "movey", "INT", 1},
}

CG_TRANSPORT = {
  { "mapid", "SHORT", 1 }, -- 地图id
  { "posx", "INT", 1},
  { "posy", "INT", 1},
}

GG_ADD_PLAYER_CACHE_DATA = {
  { "rolename", "CHAR", 64 }, -- 角色名字
  { "guildname", "CHAR", 64 }, -- 行会名字
  { "color", "CHAR", 1 }, -- 0普通,1灰名,2黄名,3红名,4紫名,5绿名,6蓝名,7橙名
  { "title", "SHORT", 16 }, -- 称号
  { "level", "SHORT", 1 }, -- 角色等级
  { "job", "CHAR", 1 }, -- 1龙骑,2狂战,3魔导,4亡灵
  { "sex", "CHAR", 1 }, -- 1男,2女
  { "status", "SHORT", 1 },
  { "buffinfo", BuffInfo, 10 },
  { "mergehp", MergeHP, 5 },
  { "bodyid", "INT", 1 }, -- 身体外观
  { "weaponid", "INT", 1 }, -- 武器外观
  { "wingid", "INT", 1 }, -- 翅膀外观
  { "horseid", "INT", 1 }, -- 坐骑外观
  { "bodyeff", "INT", 1 }, -- 身上特效
  { "weaponeff", "INT", 1 }, -- 身上特效
  { "wingeff", "INT", 1 }, -- 身上特效
  { "horseeff", "INT", 1 }, -- 身上特效
  { "ownerid", "INT", 1 }, --主人ID
  { "teamid", "SHORT", 1 }, -- 队伍ID
  { "斗笠外观", "SHORT", 1 }, -- 队伍ID
}

GC_ADD_PLAYER = {
  { "rolename", "CHAR", 64 }, -- 角色名字
  { "guildname", "CHAR", 64 }, -- 行会名字
  { "color", "CHAR", 1 }, -- 0普通,1灰名,2黄名,3红名,4紫名,5绿名,6蓝名,7橙名
  { "title", "SHORT", 16 }, -- 称号
  { "level", "SHORT", 1 }, -- 角色等级
  { "job", "CHAR", 1 }, -- 1龙骑,2狂战,3魔导,4亡灵
  { "sex", "CHAR", 1 }, -- 1男,2女
  { "status", "SHORT", 1 },
  { "buffinfo", BuffInfo, 10 },
  { "mergehp", MergeHP, 5 },
  { "bodyid", "INT", 1 }, -- 身体外观
  { "weaponid", "INT", 1 }, -- 武器外观
  { "wingid", "INT", 1 }, -- 翅膀外观
  { "horseid", "INT", 1 }, -- 坐骑外观
  { "bodyeff", "INT", 1 }, -- 身上特效
  { "weaponeff", "INT", 1 }, -- 身上特效
  { "wingeff", "INT", 1 }, -- 身上特效
  { "horseeff", "INT", 1 }, -- 身上特效
  { "ownerid", "INT", 1 }, --主人ID
  { "teamid", "SHORT", 1 }, -- 队伍ID
  { "斗笠外观", "SHORT", 1 }, -- 队伍ID
  -- 注意 下面开始是c++层数据 由c++层填充 顺序不能移到前面
  { "objid", "INT", 1 }, -- 角色objid
  { "posx", "INT", 1 }, -- 角色当前位置X
  { "posy", "INT", 1 }, -- 角色当前位置X
  { "movex", "INT", 1},
  { "movey", "INT", 1},
  { "targetdirection", "CHAR", 1 }, -- 角色面朝的方向
  { "maxhp", "INT", 1 }, -- 角色最大hp
  { "maxmp", "INT", 1 }, -- 角色最大mp
  { "hp", "INT", 1 }, -- 角色当前hp
  { "mp", "INT", 1 }, -- 角色当前mp
  { "speed", "SHORT", 1 }, -- 角色移动速度
}

GC_DEL_ROLE = {
  { "objid", "INT", 1 }, -- 角色objid
  { "objtype", "SHORT", 1 }, -- 角色objtype
}

GG_DISCONNECT = {
  { "reason", "CHAR", 1 }, -- 断开原因
}

GC_DISCONNECT_NOTIFY = {
  { "reason", "CHAR", 1 },
}

CG_STOP_MOVE = {
  { "x", "INT", 1 }, -- 移动位置的x坐标
  { "y", "INT", 1 }, -- 移动位置的y坐标
}

GC_STOP_MOVE = {
  { "objid", "INT", 1 }, -- 角色objid
  { "x", "INT", 1 }, -- 移动位置的x坐标
  { "y", "INT", 1 }, -- 移动位置的y坐标
}

CG_HEART_BEAT = {
}

GC_TIPS_MSG = {
  { "postype", "CHAR", 1 }, -- 0顶部跑马灯,1上黄字,2下红字,3右下提示-都支持富文本
  { "msg", "CHAR", 2 },
}

CG_VIP_REWARD = {
}

CG_DRAW_SRING = {
  { "drawcnt", "CHAR", 1 },
  { "type", "CHAR", 1 },
}

CG_COLLECT_START = {
  { "objid", "INT", 1 }, -- 角色objid
}

GC_COLLECT_START = {
  { "objid", "INT", 1 }, -- 角色objid
}

GC_COMMAND_MSG = {
  { "type", "SHORT", 1 },
  { "msg", "CHAR", 2 },
}

CG_COMMAND_MSG = {
  { "type", "SHORT", 1 },
  { "msg", "CHAR", 256 },
}
