module(...,package.seeall)

城堡定义 = 城堡定义 or {
	[1] = {"比奇皇宫",102,{101,330*48,267*32,100}},--id=名字,地图,{攻城地图,x,y,区域范围}
	[2] = {"封魔皇宫",502,{501,240*48,201*32,100}},
	[3] = {"沙巴克",413,{401,650*48,290*32,100}},
}
攻城时间 = {20,10,50}--时,分,持续分
行会挑战地图 = 186
行会挑战时间 = {20,0,30}--时,分,持续分
沃玛号角ID = 10025
祖玛头像ID = 10026
充值文件 = {}--{1,2,3,4,5,10,20,30,40,50,100,200,300,400,500,1000,2000,3000,4000,5000}
装备掉落品质 = Config.ISZY and 1 or 1--表示掉落最高品质
装备掉落属性 = Config.ISZY and 0 or 0--表示掉落最高属性
装备穿戴绑定 = Config.ISZY and 1 or 0--0表示不绑定
物品获得绑定 = Config.ISZY and 1 or 0--0表示不绑定
装备提示属性 = Config.ISZY and 0 or 1--0表示不提示
使用绑定货币 = Config.ISZY and 1 or 0--0表示不绑定
经验倍率 = Config.ISZY and 1 or 1
宠物死亡ID = Config.ISLT and 2003 or 2116
英雄怪物ID = Config.ISLT and 2001 or 2111
火墙怪物ID = Config.ISLT and 2002 or 0
骷髅怪物ID = 骷髅怪物ID or {2111,2249,2252,2255}
神兽怪物ID = 神兽怪物ID or {2112,2250,2253,2256}
神兽变身ID = 神兽变身ID or {}
元宝宝箱ID = Config.ISZY and 2114 or 0
隐身BUFF = 2014
潜行BUFF = 2015
裸模ID1 = 2001
裸模ID2 = 2002
出生地图 = 出生地图 or 101
复活地图 = 复活地图 or 101
PK等级限制 = 1
新手保护等级 = 1
新手无敌等级 = 1
经验物品ID = 10001
金币物品ID = 10002
元宝物品ID = 10003
传送卷ID = Config.ISZY and 0 or 99999
宠物蛋ID = Config.ISZY and 10041 or 0
聚灵珠ID = Config.ISZY and 11177 or 0
宠物蛋等级 = 70
日常任务NPC = Config.ISZY and 0 or 0
悬赏任务NPC = Config.ISZY and 1106 or 0
护送押镖NPC = Config.ISZY and 1110 or 0
护送灵兽NPC = Config.ISZY and 0 or 0
庄园采集NPC = Config.ISZY and 1112 or 0
庄园地图ID = Config.ISZY and 901 or 0
传送NPC = Config.ISZY and {1096,1097,1098,1099,1100,1101} or {}
传送地图ID = Config.ISZY and {101,401,301,701,501,601} or {}
英雄领取NPC = Config.ISZY and {1102,1103,1104} or {}
领取补偿NPC = Config.ISZY and 0 or 0
领取补偿元宝 = 10000
材料查看NPC = Config.ISZY and 1107 or 0
元宝充值NPC = Config.ISZY and {1108,1109} or 元宝充值NPC or {}
寻宝阁NPC = Config.ISZY and 1113 or 0
寻宝阁地图 = Config.ISZY and 902 or 0
特戒之城NPC = Config.ISZY and 1114 or 0
特戒之城地图 = Config.ISZY and 903 or 0
无限仓库NPC = Config.ISZY and 1115 or 0

--C++层中对象缓存属性
--玩家 对象缓存的属性 包括角色，怪物，宠物等
CHAR_ATTR_HP = 0
CHAR_ATTR_MP = 1
CHAR_ATTR_MAXHP = 2
CHAR_ATTR_MAXMP = 3
CHAR_ATTR_ALPHA = 4
CHAR_ATTR_PET = 5          --角色宠物objid
CHAR_ATTR_MASTER = 6       --宠物主人objid
CHAR_ATTR_RADIUS = 7

--- objtype enum ---
OBJ_TYPE_INVALID = -1			--// 无效
OBJ_TYPE_HUMAN = 0	            --// 玩家
OBJ_TYPE_NPC = 1
OBJ_TYPE_MONSTER = 2
OBJ_TYPE_COLLECT = 3
OBJ_TYPE_JUMP = 4
OBJ_TYPE_ITEM = 5
OBJ_TYPE_PET  = 6
OBJ_TYPE_SERVER = 7             --跨服与游戏服的连接的连接
OBJ_TYPE_HERO = 8

附魔_技能1 = 1
附魔_技能2 = 2
附魔_技能3 = 3
附魔_技能4 = 4
附魔_技能5 = 5
附魔_生命值 = 6
附魔_魔法值 = 7
附魔_防御 = 8
附魔_魔御 = 9
附魔_攻击 = 10
附魔_魔法 = 11
附魔_道术 = 12

附魔_力量 = 13
附魔_智力 = 14
附魔_敏捷 = 15
附魔_精神 = 16
附魔_体质 = 17
附魔_重击 = 18

属性_生命值 = 1
属性_魔法值 = 2
属性_防御 = 3
属性_防御上限 = 4
属性_魔御 = 5
属性_魔御上限 = 6
属性_攻击 = 7
属性_攻击上限 = 8
属性_魔法 = 9
属性_魔法上限 = 10
属性_道术 = 11
属性_道术上限 = 12

属性_幸运 = 13
属性_准确 = 14
属性_敏捷 = 15
属性_魔法命中 = 16
属性_魔法躲避 = 17
属性_生命恢复 = 18
属性_魔法恢复 = 19
属性_中毒恢复 = 20
属性_攻击速度 = 21
属性_移动速度 = 22

属性_力量 = 23
属性_智力 = 24
属性_精神 = 25
属性_体质 = 26
属性_重击 = 27

属性文字 = 
{
	"生命值",
	"魔法值",
	"防御",
	"防御上限",
	"魔御",
	"魔御上限",
	"攻击",
	"攻击上限",
	"魔法",
	"魔法上限",
	"道术",
	"道术上限",

	"幸运",
	"准确",
	"敏捷",
	"魔法命中",
	"魔法躲避",
	"生命恢复",
	"魔法恢复",
	"中毒恢复",
	"攻击速度",
	"移动速度",
	
	"力量",
	"智力",
	"精神",
	"体质",
	"重击",
	
}

额外属性_技能冷却 = 23--(百分比)
额外属性_攻击吸血 = 24--(百分比)
额外属性_伤害反弹 = 25--(百分比)
额外属性_攻击加成 = 26--(百分比)
额外属性_真实伤害 = 27
额外属性_伤害抵挡 = 28

额外属性_麻痹 = 29--几率麻痹2秒，战士
额外属性_护身 = 30--先减魔法，再减生命，法道
额外属性_复活 = 31--死亡复活，60秒cd
额外属性_火焰 = 32--几率附加灼烧buff，持续5秒
额外属性_寒冰 = 33--几率附加减速buff，持续5秒
额外属性_红毒 = 34--几率附加红毒buff，持续5秒
额外属性_绿毒 = 35--几率附加绿毒buff，持续5秒
额外属性_防御 = 36--几率抵御一次伤害
额外属性_暴击 = 37--几率150%伤害
额外属性_忽视防御 = 38--忽视防御百分比
额外属性_物理抵挡 = 39--(百分比)
额外属性_魔法抵挡 = 40--(百分比)
额外属性_体质 = 41--(血魔百分比)
额外属性_经验加成 = 42--(百分比)
额外属性_物品掉率 = 43--(百分比)
额外属性_极品爆率 = 44--(百分比)
额外属性_抵抗 = 45--抵抗伤害百分比
额外属性_经验存储 = 46--经验存储

额外属性_每秒回血 = 61--(BUFF属性)
额外属性_每秒回魔 = 62--(BUFF属性)
额外属性_随机移动 = 63--(BUFF属性)
额外属性_无法移动 = 64--(BUFF属性)
额外属性_无法攻击 = 65--(BUFF属性)
额外属性_范围伤害 = 66--(BUFF属性)
额外属性_霸体 = 67--不受位移影响
额外属性_免疫 = 68--不受BUFF影响
额外属性_双倍经验 = 69--(BUFF属性)
额外属性_三倍经验 = 70--(BUFF属性)
额外属性_无敌 = 71--(BUFF属性)
额外属性_隐身 = 72--(BUFF属性)
额外属性_潜行 = 73--(BUFF属性)
额外属性_秒杀 = 74--(BUFF属性)

转生 = {
	"一转",
	"二转",
	"三转",
	"四转",
	"五转",
	"六转",
	"七转",
	"八转",
	"九转",
}

--- job enum ---
JOB_TYPE_INVALID = 0			--// 还没有职业
JOB_TYPE_ZHUNZHE = 1			--// 尊者   (new 武尊）
JOB_TYPE_WUSHEN = 2				--// 武圣   (new 仙师）
JOB_TYPE_XIULUO = 3				--// 修罗   (new 刀王)
JOB_TYPE_XIANLIN = 4			--// 仙灵   (new 药师）

-- 怪物 type --
MONSTER_COMMON  = 1    --普通怪
MONSTER_BOSS    = 2    --ＢＯＳＳ怪
MONSTER_BUFF    = 3    --ＢＵＦＦ怪
MONSTER_ELITE   = 4    --精英怪
MONSTER_SPECIAL = 5    --特殊怪

STATUS_NORMAL = 0			-- 正常
STATUS_WALK = 2			-- 走
STATUS_DISAPPEAR = 2		-- 消失

-- 游戏参数
MAX_LEVEL	          = 100       -- 最大等级
CHAR_BORN_MAPID       = 101       -- 角色出生地图
WORLD_MAIN_MAPID      = 101       -- 世界主地图（一些默认的跳转操作都会回到这里，暂时和新手村一样）

--- 攻击模式 enum ---
ATK_MODE_PEACE = 0					-- 和平：此模式下无法攻击其他玩家，但会被攻击。
ATK_MODE_ALL = 1					-- 全体：此模式下可攻击其他玩家。
ATK_MODE_GOOD = 2					-- 善恶：此模式下只能攻击黄名，红名的玩家。
ATK_MODE_TEAM = 3					-- 队伍：此模式下只能攻击非队友的玩家。
ATK_MODE_GUILD = 4					-- 帮派：此模式下只能攻击非帮派帮友的玩家。

-- 登录错误码
ASK_LOGIN_OK = 1				-- 成功登录
ASK_LOGIN_ERROR_CREATE_CHAR = 2 -- 登录失败 创建角色失败
ASK_LOGIN_GO_TO_MSVR = 3		-- 跨服pk中，需要重定向到msvr
ASK_LOGIN_SERVER_FULL = 4		-- 服务器人数已满 无法登录

--NPC功能列表---
NPC_ABILITY_SHOP	= 1			--购买
NPC_ABILITY_LEARN_SKILL = 2		--学习技能
NPC_ABILITY_STROE	= 3			--仓库
NPC_ABILITY_ENTER_COPYSCENE	= 4			--入口出口NPC
NPC_ABILITY_DUIHUAN = 6			--兑换积分

--- 人物复活请求 ---
PLAYER_DIE_RESULT_GOHOME = 1	-- 回城复活 立即回主城复活（恢复100%气血）
PLAYER_DIE_RESULT_WAIT = 2		-- 原地复活 等待120秒原地复活（恢复10%气血）
PLAYER_DIE_RESULT_NOW = 3		-- 原地复活 立即原地复活需花N铜币（恢复100%气血）--- 人物复活请求结果 ---
PLAYER_DIE_RESULT_NOW_USE_RMB = 4

PLAYER_DIE_RESULT_RELIVE_FREE = 1				-- 成功复活（不需要钱的）
PLAYER_DIE_RESULT_RELIVE_COST_MONEY = 2			-- 成功复活（需要花钱的）
PLAYER_DIE_RESULT_RELIVE_FAIL_NO_MONEY = 3		-- 无法复活 金钱不足
PLAYER_DIE_RESULT_RELIVE_FAIL_INVALID = 4		-- 无法复活 复活请求码无效-- 断开连接原因
PLAYER_DIE_RESULT_RELIVE_FAIL_NO_RMB  = 5       -- 元宝不足，不能立即复活
PLAYER_DIE_RESULT_RELIVE_COST_RMB = 6	--成功复活（需要元宝的）

-- DB标志
DB_IN_NORMAL_GAME_SERVER = 0				-- 角色在正常游戏服中，跨服pk服不能写这个角色的db
DB_IN_NORMAL_CROSS_SCENE_SERVER = 1			-- 角色在跨服pk服中，正常游戏服不能写这个角色的db

-- 断开连接错误码
DISCONNECT_REASON_ANOTHER_CHAR_LOGIN = 1		-- 角色在其它地方上线
DISCONNECT_REASON_CHANGE_TO_CROSS_SCENE = 2		-- 角色从游戏服切换到跨服副本服 游戏服断开连接
DISCONNECT_REASON_CROSS_SCENE_GAMING = 3		-- 角色正在跨服副本中 无法登录 请先断开原连接
DISCONNECT_REASON_ADMIN_KICK = 4				-- 管理后台踢人
DISCONNECT_REASON_SERVER_FULL = 5				-- 服务器人满
DISCONNECT_REASON_FORBID_ACCOUNT = 6            -- 帐号被禁止登陆
DISCONNECT_REASON_FORBID_IP     =  7            -- IP被禁止登陆
DISCONNECT_REASON_AUTH_FAIL = 8					-- 登录认证失败
DISCONNECT_REASON_SERVER_CLOSE = 9				-- 服务器关闭连接
DISCONNECT_REASON_SERVER_CLOSE_ALL = 10			-- 服务器关闭连接,请稍后再试
DISCONNECT_REASON_CROSS_ACCOUNT_ERR = 50		-- 错误帐号（登录中间服）

-- 100 开始是c++层的错误码
DISCONNECT_REASON_CLIENT = 100					-- client主动断开
DISCONNECT_REASON_TIMEOUT = 101					-- 长时间没有发包断开
DISCONNECT_REASON_PACKET_ERR = 102				-- 发送非法包断开

-- 人物状态
HUMAN_STATUS_NORMAL = 1			-- 正常
HUMAN_STATUS_SIT = 2			-- 打坐
HUMAN_STATUS_HORSE = 3			-- 上马
HUMAN_STATUS_COLLECT = 4		-- 采集
HUMAN_STATUS_ESCORT = 5			-- 护送

HUMAN_STATUS_TRICK = 7			--沙滩整蛊
HUMAN_STATUS_KISS = 8			--沙滩飞吻
HUMAN_STATUS_DRINK = 9			--沙滩喝饮料
HUMAN_STATUS_DOUBLE = 10			--沙滩双修

HUMAN_STATUD_CHANGE_OK = 0					--状态切换OK
HUMAN_STATUD_CHANGE_ERR_OLD_EQUAL_NEW = 1	--新旧状态相同
HUMAN_STATUS_CHANGE_ERR_NO_NEW_STATUS = 2	--新状态不存在
HUMAN_STATUS_CHANGE_ERR_COLLECT_TO_SIT = 3 --采集期间不能打坐
HUMAN_STATUS_CHANGE_ERR_COLLECT_TO_HORSE = 4 --采集期间不能骑马
HUMAN_STATUS_CHANGE_ERR_DEAD = 5 --挂了
HUMAN_STATUS_CHANGE_ERR_HORSE_TO_SIT = 6    --骑马状态下不能打坐
HUMAN_STATUS_CHANGE_ERR_CAN_NOT_FIND_HORSE = 7 --找不到坐骑
HUMAN_STATUS_CHANGE_ERR_HAVE_NO_NAME = 9       --没有名字(凤凰)
HUMAN_STATUS_CHANGE_ERR_BEACH_TO_SIT =10 --沙滩里不能打坐
HUMAN_STATUS_CHANGE_ERR_BEACH_TO_HORSE = 11 --沙滩里不能骑马

-- 战斗分组
COMBAT_GROUP_NORMAL = 0			-- 普通地图中 无分组
COMBAT_GROUP_JINGJI_1 = 1		-- 竞技场甲方
COMBAT_GROUP_JINGJI_2 = 2		-- 竞技场乙方
COMBAT_GROUP_TD1 = 3			-- 守护副本1的阵营
COMBAT_GROUP_TD2 = 4			-- 守护副本2的阵营
COMBAT_GROUP_TD3 = 5			-- 守护副本3的阵营
