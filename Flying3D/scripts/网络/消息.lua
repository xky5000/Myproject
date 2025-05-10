module(..., package.seeall)

local 消息管理 = require("公用.消息管理")
local 消息类型 = require("网络.消息类型")

register = 消息管理.register
sendMessage = 消息管理.sendMessage

function init()

	--- 场景CGMessage
	register(消息类型.CG_SHOW_FASHION, {3,3,3,3})
	register(消息类型.CG_TRANSPORT, {0,1,1})
	register(消息类型.CG_COLLECT_START, {1})
	register(消息类型.CG_XP_USE, {1})
	register(消息类型.CG_STOP_MOVE, {1,1})
	register(消息类型.CG_ASK_LOGIN, {2,2,1,3})
	register(消息类型.CG_ENTER_SCENE_OK, {3})
	register(消息类型.CG_REQUEST_RELIVE, {3})
	register(消息类型.CG_CREATE_ROLE, {2,3,3})
	register(消息类型.CG_HEART_BEAT, {})
	register(消息类型.CG_EQUIP_VIEW, {1,2})
	register(消息类型.CG_USE_WING, {1})
	register(消息类型.CG_COMMAND_MSG, {0,2})
	register(消息类型.CG_PROP_ADDPOINT, {3,3})
	register(消息类型.CG_MOVE, {1,1})
	register(消息类型.CG_VIP_SPREAD, {2,{0},3})
	register(消息类型.CG_CHANGE_STATUS, {0,3})
	register(消息类型.CG_DRAW_SRING, {3,3})
	register(消息类型.CG_HUMAN_SETUP, {0,0,0,0,3,3,3,3,3,3,0,0,0,0,3,0,3,3,3,3,3,3,3,3})
	register(消息类型.CG_USE_MOUNT, {1})
	register(消息类型.CG_VIP_REWARD, {})
	register(消息类型.CG_CHANGE_JOB, {3})
	register(消息类型.CG_MOVE_GRID, {1,1})

	--- 场景GCMessage
	local 场景消息处理 = require("网络.消息处理.场景消息处理")
	register(消息类型.GC_COLLECT_START, {1}, 场景消息处理.GC_COLLECT_START)
	register(消息类型.GC_HERO_INFO, {2,1,0,3,3,0,1,1,1,1}, 场景消息处理.GC_HERO_INFO)
	register(消息类型.GC_COMMAND_MSG, {0,2}, 场景消息处理.GC_COMMAND_MSG)
	register(消息类型.GC_CHANGE_SPEED, {1,0}, 场景消息处理.GC_CHANGE_SPEED)
	register(消息类型.GC_CHANGE_JOB, {1,2,3,3}, 场景消息处理.GC_CHANGE_JOB)
	register(消息类型.GC_CHANGE_INFO, {1,1,1,{1,1,0}}, 场景消息处理.GC_CHANGE_INFO)
	register(消息类型.GC_CHANGE_STATUS, {1,0,3}, 场景消息处理.GC_CHANGE_STATUS)
	register(消息类型.GC_STOP_MOVE, {1,1,1}, 场景消息处理.GC_STOP_MOVE)
	register(消息类型.GC_EQUIP_VIEW, {2,1,0,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2},3,0,3,3,0,0,0,0,0}, 场景消息处理.GC_EQUIP_VIEW)
	register(消息类型.GC_ASK_LOGIN, {3,2,2,0}, 场景消息处理.GC_ASK_LOGIN)
	register(消息类型.GC_DEL_ROLE, {1,0}, 场景消息处理.GC_DEL_ROLE)
	register(消息类型.GC_LEVEL_UP, {1,0}, 场景消息处理.GC_LEVEL_UP)
	register(消息类型.GC_MOVE, {1,0,1,1,1,1}, 场景消息处理.GC_MOVE)
	register(消息类型.GC_CHANGE_FACADE, {1,1,1,1,1,1,1,1,1,0,0}, 场景消息处理.GC_CHANGE_FACADE)
	register(消息类型.GC_CHANGE_TEAM, {1,0}, 场景消息处理.GC_CHANGE_TEAM)
	register(消息类型.GC_XP_INFO, {1,3,1,1,0}, 场景消息处理.GC_XP_INFO)
	register(消息类型.GC_ACTUAL_ATTR, {1,1,1,1,1,0}, 场景消息处理.GC_ACTUAL_ATTR)
	register(消息类型.GC_JUMP_SCENE, {1,0,1,1}, 场景消息处理.GC_JUMP_SCENE)
	register(消息类型.GC_VIP_SPREAD, {2,1,0,0,{0},{0}}, 场景消息处理.GC_VIP_SPREAD)
	register(消息类型.GC_PROP_ADDPOINT, {0,0}, 场景消息处理.GC_PROP_ADDPOINT)
	register(消息类型.GC_CHANGE_NAME, {2,2,3,{0},1,1}, 场景消息处理.GC_CHANGE_NAME)
	register(消息类型.GC_ADD_PLAYER, {2,2,3,{0},0,3,3,0,{1,1,1},{1,1,0},1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,3,1,1,1,1,0}, 场景消息处理.GC_ADD_PLAYER)
	register(消息类型.GC_DETAIL_ATTR, {1,1,1,1,1,1,1,1,1,1,0,1,1,{0},1,1,1,0,0,1,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 场景消息处理.GC_DETAIL_ATTR)
	register(消息类型.GC_HUMAN_INFO, {2,2,2,2,3,{0},1,0,3,3,0,3,0,1,1,0,1,1,1,1,0,{1,1,1},{1,1,0},1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,3,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3}, 场景消息处理.GC_HUMAN_INFO)
	register(消息类型.GC_ATTACK_GUILD, {2,2}, 场景消息处理.GC_ATTACK_GUILD)
	register(消息类型.GC_TIPS_MSG, {3,2}, 场景消息处理.GC_TIPS_MSG)
	register(消息类型.GC_XP_USE, {1,1}, 场景消息处理.GC_XP_USE)
	register(消息类型.GC_DISCONNECT_NOTIFY, {3}, 场景消息处理.GC_DISCONNECT_NOTIFY)
	register(消息类型.GC_ENTER_SCENE, {0,1,0,3,1,1,3,1,1,3}, 场景消息处理.GC_ENTER_SCENE)

	--- 场景CGMessage
	register(消息类型.CG_TASK_QUERY, {})
	register(消息类型.CG_PICK_ITEM, {1})
	register(消息类型.CG_FINISH_TASK, {0})
	register(消息类型.CG_ACCEPT_TASK, {0})
	register(消息类型.CG_NPC_TALK_PUT, {1,0,3,0,2})
	register(消息类型.CG_NPC_TALK, {1,0})

	--- 场景GCMessage
	local 场景消息处理 = require("网络.消息处理.场景消息处理")
	register(消息类型.GC_PICK_ITEM, {1}, 场景消息处理.GC_PICK_ITEM)
	register(消息类型.GC_ADD_MONSTER, {2,0,0,{1,1,1},0,{0},{0},0,1,0,1,1,1,1,1,1,1,1,1,0}, 场景消息处理.GC_ADD_MONSTER)
	register(消息类型.GC_ADD_ITEM, {2,0,0,1,1,0,0,1,1,1,1}, 场景消息处理.GC_ADD_ITEM)
	register(消息类型.GC_TASK_INFO, {{2,2,0,0,0,{0,2,0,1,1,0,0,0},0,0,0},3}, 场景消息处理.GC_TASK_INFO)
	register(消息类型.GC_ADD_NPC, {2,0,0,0,0,1,1,1}, 场景消息处理.GC_ADD_NPC)
	register(消息类型.GC_ADD_PET, {2,0,0,{1,1,1},0,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1,0}, 场景消息处理.GC_ADD_PET)
	register(消息类型.GC_NPC_TALK, {1,0,0,2,0,0,{2,1,0},{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}, 场景消息处理.GC_NPC_TALK)
	register(消息类型.GC_CHANGE_BODY, {1,0,0,0}, 场景消息处理.GC_CHANGE_BODY)

	--- 技能CGMessage
	register(消息类型.CG_USE_SKILL, {0,1,1,1})
	register(消息类型.CG_SKILL_HANGUP, {0,0})
	register(消息类型.CG_SKILL_QUICK_SETUP, {{0}})
	register(消息类型.CG_SKILL_QUICK_QUERY, {})
	register(消息类型.CG_SKILL_UPGRADE, {0})
	register(消息类型.CG_SKILL_LEARN, {0})
	register(消息类型.CG_SKILL_DISCARD, {0})
	register(消息类型.CG_SKILL_QUERY, {})

	--- 技能GCMessage
	local 技能消息处理 = require("网络.消息处理.技能消息处理")
	register(消息类型.GC_SKILL_DISPLACE, {1,0,1,1,1,1}, 技能消息处理.GC_SKILL_DISPLACE)
	register(消息类型.GC_SKILL_LEARN, {3}, 技能消息处理.GC_SKILL_LEARN)
	register(消息类型.GC_SKILL_BUFF, {1,0,1,1,{3,0}}, 技能消息处理.GC_SKILL_BUFF)
	register(消息类型.GC_SKILL_INFO, {{0,0,1,0,0,0,0,0,2,{0},2,0,0,0,0,0,0,0,{2,0},3,0,3}}, 技能消息处理.GC_SKILL_INFO)
	register(消息类型.GC_SKILL_LEARNINFO, {{0,0,2,0}}, 技能消息处理.GC_SKILL_LEARNINFO)
	register(消息类型.GC_SKILL_ERR, {2}, 技能消息处理.GC_SKILL_ERR)
	register(消息类型.GC_SKILL_UPGRADE, {3}, 技能消息处理.GC_SKILL_UPGRADE)
	register(消息类型.GC_SKILL_CONTROLLED, {1,3,3}, 技能消息处理.GC_SKILL_CONTROLLED)
	register(消息类型.GC_SKILL_QUICK_LIST, {{0}}, 技能消息处理.GC_SKILL_QUICK_LIST)
	register(消息类型.GC_SKILL_DISCARD, {3}, 技能消息处理.GC_SKILL_DISCARD)
	register(消息类型.GC_USE_SKILL, {1,1,0,2,2,0,0,0,1,1,0,0}, 技能消息处理.GC_USE_SKILL)
	register(消息类型.GC_SKILL_HURT, {1,0,0,1,3,3,3}, 技能消息处理.GC_SKILL_HURT)

	--- 物品CGMessage
	register(消息类型.CG_BAG_SWAP, {0,0})
	register(消息类型.CG_EQUIP_UNFIX, {0,3})
	register(消息类型.CG_STORE_QUERY, {0})
	register(消息类型.CG_QUICK_QUERY, {})
	register(消息类型.CG_BAG_DISCARD, {0})
	register(消息类型.CG_ITEM_QUERY, {1,0})
	register(消息类型.CG_STORE_SWAP, {0,0})
	register(消息类型.CG_STORE_REBUILD, {0})
	register(消息类型.CG_EQUIP_ENDUE, {0,0,3})
	register(消息类型.CG_BAG_QUERY, {})
	register(消息类型.CG_EQUIP_QUERY, {})
	register(消息类型.CG_ITEM_RESOLVE, {{0}})
	register(消息类型.CG_ITEM_BUY, {0,1,0})
	register(消息类型.CG_BAG_DIVIDE, {0,0})
	register(消息类型.CG_BAG_REBUILD, {})
	register(消息类型.CG_STORE_FETCHALL, {0})
	register(消息类型.CG_STORE_DISCARD, {0})
	register(消息类型.CG_ITEM_USE, {0,0,3})
	register(消息类型.CG_TIMESHOP_QUERY, {})
	register(消息类型.CG_QUICK_SETUP, {{1}})
	register(消息类型.CG_ITEM_STORE, {0,0})
	register(消息类型.CG_ITEM_RESOLVE_QUERY, {{0}})
	register(消息类型.CG_STORE_FETCH, {0,0})
	register(消息类型.CG_TIMESHOP_BUY, {1,0})

	--- 物品GCMessage
	local 物品消息处理 = require("网络.消息处理.物品消息处理")
	register(消息类型.GC_EQUIP_LIST, {3,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}, 物品消息处理.GC_EQUIP_LIST)
	register(消息类型.GC_ITEM_QUERY, {0,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}, 物品消息处理.GC_ITEM_QUERY)
	register(消息类型.GC_TIMESHOP_BUY, {0}, 物品消息处理.GC_TIMESHOP_BUY)
	register(消息类型.GC_BAG_LIST, {3,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}, 物品消息处理.GC_BAG_LIST)
	register(消息类型.GC_ITEM_RESOLVE, {0}, 物品消息处理.GC_ITEM_RESOLVE)
	register(消息类型.GC_ITEM_BUY, {3}, 物品消息处理.GC_ITEM_BUY)
	register(消息类型.GC_STORE_LIST, {3,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2},0}, 物品消息处理.GC_STORE_LIST)
	register(消息类型.GC_TIMESHOP_QUERY, {{1,2,0,3,0,1,3}}, 物品消息处理.GC_TIMESHOP_QUERY)
	register(消息类型.GC_QUICK_LIST, {{1}}, 物品消息处理.GC_QUICK_LIST)
	register(消息类型.GC_ITEM_RESOLVE_QUERY, {{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}, 物品消息处理.GC_ITEM_RESOLVE_QUERY)

	--- 宠物CGMessage
	register(消息类型.CG_BACK_PET, {0})
	register(消息类型.CG_BREAK_PET, {0})
	register(消息类型.CG_PET_ADDPOINT, {0,3})
	register(消息类型.CG_TRAIN_PET, {0,0})
	register(消息类型.CG_PET_QUERY, {})
	register(消息类型.CG_FEED_PET, {0})
	register(消息类型.CG_CALL_PET, {0})
	register(消息类型.CG_MERGE_PET, {0})

	--- 宠物GCMessage
	local 宠物消息处理 = require("网络.消息处理.宠物消息处理")
	register(消息类型.GC_STAR_UPGRADE, {1,0}, 宠物消息处理.GC_STAR_UPGRADE)
	register(消息类型.GC_MERGE_PET, {1,1}, 宠物消息处理.GC_MERGE_PET)
	register(消息类型.GC_TRAIN_PET, {0}, 宠物消息处理.GC_TRAIN_PET)
	register(消息类型.GC_PET_INFO, {{0,0,1,0,1,1,2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,1,1,1,1,0,3,2,2,0},{0,3,3,1}}, 宠物消息处理.GC_PET_INFO)

	--- 锻造CGMessage
	register(消息类型.CG_REFINE_WASH, {0,0,{0}})
	register(消息类型.CG_STRENGTHEN_ALL, {0,0,0,0,0,0})
	register(消息类型.CG_REFINE_UPGRADE, {0,0})
	register(消息类型.CG_EQUIP_PREVIEW, {0,0})
	register(消息类型.CG_STRENGTHEN_TRANSFER, {0,0,0,0})
	register(消息类型.CG_STRENGTHEN, {0,0})
	register(消息类型.CG_PERFECT_PREVIEW, {0,0})

	--- 锻造GCMessage
	local 锻造消息处理 = require("网络.消息处理.锻造消息处理")
	register(消息类型.GC_STRENGTHEN, {0}, 锻造消息处理.GC_STRENGTHEN)
	register(消息类型.GC_STRENGTHEN_TRANSFER, {0}, 锻造消息处理.GC_STRENGTHEN_TRANSFER)
	register(消息类型.GC_REFINE_WASH, {0}, 锻造消息处理.GC_REFINE_WASH)
	register(消息类型.GC_STRENGTHEN_ALL, {0}, 锻造消息处理.GC_STRENGTHEN_ALL)
	register(消息类型.GC_REFINE_UPGRADE, {0}, 锻造消息处理.GC_REFINE_UPGRADE)
	register(消息类型.GC_PERFECT_PREVIEW, {{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}, 锻造消息处理.GC_PERFECT_PREVIEW)
	register(消息类型.GC_EQUIP_PREVIEW, {{3,1,1}}, 锻造消息处理.GC_EQUIP_PREVIEW)

	--- 聊天CGMessage
	register(消息类型.CG_CHAT, {0,2})

	--- 聊天GCMessage
	local 聊天消息处理 = require("网络.消息处理.聊天消息处理")
	register(消息类型.GC_CHAT, {2,1,0,2}, 聊天消息处理.GC_CHAT)

	--- 场景CGMessage
	register(消息类型.CG_BOSSCOPY_QUERY, {})
	register(消息类型.CG_CREATE_ROOM, {0})
	register(消息类型.CG_REFLESH_BOSS, {})
	register(消息类型.CG_VIEWER, {1})
	register(消息类型.CG_QUIT_COPYSCENE, {})
	register(消息类型.CG_ENTER_COPYSCENE, {0,3})
	register(消息类型.CG_SINGLECOPY_QUERY, {})

	--- 场景GCMessage
	local 场景消息处理 = require("网络.消息处理.场景消息处理")
	register(消息类型.GC_CREATE_ROOM, {3}, 场景消息处理.GC_CREATE_ROOM)
	register(消息类型.GC_COPYSCENE_FINISH, {3,0,0,0,{1,2,0,0,0,0,0,0,3}}, 场景消息处理.GC_COPYSCENE_FINISH)
	register(消息类型.GC_COPYSCENE_INFO, {1,0,0,{1,2,0,0,0,0,0,0}}, 场景消息处理.GC_COPYSCENE_INFO)
	register(消息类型.GC_SINGLECOPY_INFO, {{0,0,0,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2},2,3,1}}, 场景消息处理.GC_SINGLECOPY_INFO)
	register(消息类型.GC_QUIT_COPYSCENE, {3}, 场景消息处理.GC_QUIT_COPYSCENE)
	register(消息类型.GC_TEAM_INFO, {{1,2,0,0,1,1,0}}, 场景消息处理.GC_TEAM_INFO)
	register(消息类型.GC_VIEWER, {1}, 场景消息处理.GC_VIEWER)
	register(消息类型.GC_ENTER_COPYSCENE, {3}, 场景消息处理.GC_ENTER_COPYSCENE)
	register(消息类型.GC_BOSSCOPY_INFO, {{0,0,0,0,2,1,0,0,1,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}}, 场景消息处理.GC_BOSSCOPY_INFO)

	--- 排行榜CGMessage
	register(消息类型.CG_RANK_QUERY, {})
	register(消息类型.CG_RANK_VIPSPREAD_QUERY, {})
	register(消息类型.CG_RANK_HERO_QUERY, {})
	register(消息类型.CG_RANK_PET_QUERY, {})

	--- 排行榜GCMessage
	local 排行榜消息处理 = require("网络.消息处理.排行榜消息处理")
	register(消息类型.GC_RANK_VIPSPREAD_LIST, {{0,2,3,0,0,1},{0,2,3,0,0,1}}, 排行榜消息处理.GC_RANK_VIPSPREAD_LIST)
	register(消息类型.GC_RANK_LIST, {{0,2,3,0,2,1},{0,2,3,0,2,1}}, 排行榜消息处理.GC_RANK_LIST)
	register(消息类型.GC_RANK_PET_LIST, {{0,2,0,0,2,1},{0,2,0,0,2,1}}, 排行榜消息处理.GC_RANK_PET_LIST)
	register(消息类型.GC_RANK_HERO_LIST, {{0,2,3,0,2,1},{0,2,3,0,2,1}}, 排行榜消息处理.GC_RANK_HERO_LIST)

	--- 寄售CGMessage
	register(消息类型.CG_SELL_ITEM_QUERY, {1})
	register(消息类型.CG_SELL_ITEM_OFF, {1})
	register(消息类型.CG_SELL_MINE_QUERY, {})
	register(消息类型.CG_SELL_ITEM, {0,3,1})
	register(消息类型.CG_SELL_RECORD_QUERY, {})
	register(消息类型.CG_SELL_ITEM_BUY, {1})
	register(消息类型.CG_SELL_QUERY, {3})

	--- 寄售GCMessage
	local 寄售消息处理 = require("网络.消息处理.寄售消息处理")
	register(消息类型.GC_SELL_ITEM_QUERY, {1,{0,1,2,2,3,1,0,1,1,3,3,0,0,3,{3,1,1},{3,1,1},{3,1,1},{3,1,1},{2,0,0,3},1,3,1,{3,1,1},2}}, 寄售消息处理.GC_SELL_ITEM_QUERY)
	register(消息类型.GC_SELL_LIST, {{1,0,3,0,2,3,0,0,3,1,3}}, 寄售消息处理.GC_SELL_LIST)
	register(消息类型.GC_SELL_RECORD_LIST, {{2,2,2,2,3,1}}, 寄售消息处理.GC_SELL_RECORD_LIST)
	register(消息类型.GC_SELL_MINE_LIST, {{1,0,3,0,2,3,0,0,3,1,3}}, 寄售消息处理.GC_SELL_MINE_LIST)

	--- 队伍CGMessage
	register(消息类型.CG_TEAM_LEAVE, {})
	register(消息类型.CG_TEAM_TEAMMATE, {})
	register(消息类型.CG_TEAM_INVITE, {2})
	register(消息类型.CG_TEAM_DISMISS, {})
	register(消息类型.CG_TEAM_NEARBY_MEMBER, {})
	register(消息类型.CG_TEAM_NEARBY_TEAM, {})
	register(消息类型.CG_TEAM_CREATE, {})
	register(消息类型.CG_TEAM_APPLY, {2})
	register(消息类型.CG_TEAM_DELMEMBER, {2})
	register(消息类型.CG_TEAM_APPLYENTER, {2})
	register(消息类型.CG_TEAM_TRANSFER, {2})
	register(消息类型.CG_TEAM_ADDMEMBER, {2})
	register(消息类型.CG_TEAM_SETUP, {3,3})

	--- 队伍GCMessage
	local 队伍消息处理 = require("网络.消息处理.队伍消息处理")
	register(消息类型.GC_TEAM_NEARBY_TEAM, {{2,3,0,3,3,2}}, 队伍消息处理.GC_TEAM_NEARBY_TEAM)
	register(消息类型.GC_TEAM_TEAMMATE, {{2,3,3,0,3,0,0,0,0}}, 队伍消息处理.GC_TEAM_TEAMMATE)
	register(消息类型.GC_TEAM_NEARBY_MEMBER, {{2,3,0,3,1,2}}, 队伍消息处理.GC_TEAM_NEARBY_MEMBER)
	register(消息类型.GC_TEAM_INVITE, {2}, 队伍消息处理.GC_TEAM_INVITE)
	register(消息类型.GC_TEAM_APPLY, {2}, 队伍消息处理.GC_TEAM_APPLY)

	--- 行会CGMessage
	register(消息类型.CG_GUILD_QUERY, {})
	register(消息类型.CG_GUILD_LEAVE, {})
	register(消息类型.CG_GUILD_ALLIANCE, {2,1})
	register(消息类型.CG_GUILD_APPLYAGREE, {2,3})
	register(消息类型.CG_GUILD_CHALLENGEAGREE, {2,3})
	register(消息类型.CG_GUILD_RECORD, {3})
	register(消息类型.CG_GUILD_CASTLEINFO, {})
	register(消息类型.CG_GUILD_MEMBER, {})
	register(消息类型.CG_GUILD_ATTACKMAP, {})
	register(消息类型.CG_GUILD_CREATE, {2})
	register(消息类型.CG_GUILD_LEVELUP, {})
	register(消息类型.CG_GUILD_DONATE, {1})
	register(消息类型.CG_GUILD_KICK, {2})
	register(消息类型.CG_GUILD_CHALLENGE, {2,1})
	register(消息类型.CG_GUILD_ALLIANCEAGREE, {2,3})
	register(消息类型.CG_GUILD_APPLY, {2})
	register(消息类型.CG_GUILD_ADJUST, {2,3})
	register(消息类型.CG_GUILD_CHALLENGEMAP, {})
	register(消息类型.CG_GUILD_ATTACKCASTLE, {3})

	--- 行会GCMessage
	local 行会消息处理 = require("网络.消息处理.行会消息处理")
	register(消息类型.GC_GUILD_MEMBER, {{0,2,2,0,0,1,1,3},{2,3,0,3,1,3,1,3}}, 行会消息处理.GC_GUILD_MEMBER)
	register(消息类型.GC_GUILD_CASTLEINFO, {{3,2,2,0}}, 行会消息处理.GC_GUILD_CASTLEINFO)
	register(消息类型.GC_GUILD_RECORD, {{2,1,2,3}}, 行会消息处理.GC_GUILD_RECORD)
	register(消息类型.GC_GUILD_LIST, {{0,2,2,0,0,1,1,3}}, 行会消息处理.GC_GUILD_LIST)
end


--- 场景CGMethod
function CG_SHOW_FASHION(显示时装,英雄显示时装,显示炫武,英雄显示炫武)
	sendMessage(消息类型.CG_SHOW_FASHION, {显示时装,英雄显示时装,显示炫武,英雄显示炫武})
end

function CG_TRANSPORT(mapid,posx,posy)
	sendMessage(消息类型.CG_TRANSPORT, {mapid,posx,posy})
end

function CG_COLLECT_START(objid)
	sendMessage(消息类型.CG_COLLECT_START, {objid})
end

function CG_XP_USE(targetid)
	sendMessage(消息类型.CG_XP_USE, {targetid})
end

function CG_STOP_MOVE(x,y)
	sendMessage(消息类型.CG_STOP_MOVE, {x,y})
end

function CG_ASK_LOGIN(account,authkey,timestamp,status)
	sendMessage(消息类型.CG_ASK_LOGIN, {account,authkey,timestamp,status})
end

function CG_ENTER_SCENE_OK(isfirstenter)
	sendMessage(消息类型.CG_ENTER_SCENE_OK, {isfirstenter})
end

function CG_REQUEST_RELIVE(type)
	sendMessage(消息类型.CG_REQUEST_RELIVE, {type})
end

function CG_CREATE_ROLE(rolename,sex,job)
	sendMessage(消息类型.CG_CREATE_ROLE, {rolename,sex,job})
end

function CG_HEART_BEAT()
	sendMessage(消息类型.CG_HEART_BEAT, {})
end

function CG_EQUIP_VIEW(objid,rolename)
	sendMessage(消息类型.CG_EQUIP_VIEW, {objid,rolename})
end

function CG_USE_WING(wingid)
	sendMessage(消息类型.CG_USE_WING, {wingid})
end

function CG_COMMAND_MSG(type,msg)
	sendMessage(消息类型.CG_COMMAND_MSG, {type,msg})
end

function CG_PROP_ADDPOINT(是否英雄,类型)
	sendMessage(消息类型.CG_PROP_ADDPOINT, {是否英雄,类型})
end

function CG_MOVE(movex,movey)
	sendMessage(消息类型.CG_MOVE, {movex,movey})
end

function CG_VIP_SPREAD(rolename,礼包领取,每日充值领取)
	sendMessage(消息类型.CG_VIP_SPREAD, {rolename,礼包领取,每日充值领取})
end

function CG_CHANGE_STATUS(status,pkmode)
	sendMessage(消息类型.CG_CHANGE_STATUS, {status,pkmode})
end

function CG_DRAW_SRING(drawcnt,type)
	sendMessage(消息类型.CG_DRAW_SRING, {drawcnt,type})
end

function CG_HUMAN_SETUP(HP保护,MP保护,英雄HP保护,英雄MP保护,自动分解白,自动分解绿,自动分解蓝,自动分解紫,自动分解橙,自动分解等级,使用生命药,使用魔法药,英雄使用生命药,英雄使用魔法药,使用物品HP,使用物品ID,自动使用合击,自动分解宠物白,自动分解宠物绿,自动分解宠物蓝,自动分解宠物紫,自动分解宠物橙,自动孵化宠物蛋,物品自动拾取)
	sendMessage(消息类型.CG_HUMAN_SETUP, {HP保护,MP保护,英雄HP保护,英雄MP保护,自动分解白,自动分解绿,自动分解蓝,自动分解紫,自动分解橙,自动分解等级,使用生命药,使用魔法药,英雄使用生命药,英雄使用魔法药,使用物品HP,使用物品ID,自动使用合击,自动分解宠物白,自动分解宠物绿,自动分解宠物蓝,自动分解宠物紫,自动分解宠物橙,自动孵化宠物蛋,物品自动拾取})
end

function CG_USE_MOUNT(mountid)
	sendMessage(消息类型.CG_USE_MOUNT, {mountid})
end

function CG_VIP_REWARD()
	sendMessage(消息类型.CG_VIP_REWARD, {})
end

function CG_CHANGE_JOB(job)
	sendMessage(消息类型.CG_CHANGE_JOB, {job})
end

function CG_MOVE_GRID(movex,movey)
	sendMessage(消息类型.CG_MOVE_GRID, {movex,movey})
end


--- 场景CGMethod
function CG_TASK_QUERY()
	sendMessage(消息类型.CG_TASK_QUERY, {})
end

function CG_PICK_ITEM(objid)
	sendMessage(消息类型.CG_PICK_ITEM, {objid})
end

function CG_FINISH_TASK(taskid)
	sendMessage(消息类型.CG_FINISH_TASK, {taskid})
end

function CG_ACCEPT_TASK(taskid)
	sendMessage(消息类型.CG_ACCEPT_TASK, {taskid})
end

function CG_NPC_TALK_PUT(objid,talkid,type,callid,talk)
	sendMessage(消息类型.CG_NPC_TALK_PUT, {objid,talkid,type,callid,talk})
end

function CG_NPC_TALK(objid,talkid)
	sendMessage(消息类型.CG_NPC_TALK, {objid,talkid})
end


--- 技能CGMethod
function CG_USE_SKILL(skillid,targetid,posx,posy)
	sendMessage(消息类型.CG_USE_SKILL, {skillid,targetid,posx,posy})
end

function CG_SKILL_HANGUP(infoid,hangup)
	sendMessage(消息类型.CG_SKILL_HANGUP, {infoid,hangup})
end

function CG_SKILL_QUICK_SETUP(id)
	sendMessage(消息类型.CG_SKILL_QUICK_SETUP, {id})
end

function CG_SKILL_QUICK_QUERY()
	sendMessage(消息类型.CG_SKILL_QUICK_QUERY, {})
end

function CG_SKILL_UPGRADE(infoid)
	sendMessage(消息类型.CG_SKILL_UPGRADE, {infoid})
end

function CG_SKILL_LEARN(infoid)
	sendMessage(消息类型.CG_SKILL_LEARN, {infoid})
end

function CG_SKILL_DISCARD(infoid)
	sendMessage(消息类型.CG_SKILL_DISCARD, {infoid})
end

function CG_SKILL_QUERY()
	sendMessage(消息类型.CG_SKILL_QUERY, {})
end


--- 物品CGMethod
function CG_BAG_SWAP(pos,posdst)
	sendMessage(消息类型.CG_BAG_SWAP, {pos,posdst})
end

function CG_EQUIP_UNFIX(pos,hero)
	sendMessage(消息类型.CG_EQUIP_UNFIX, {pos,hero})
end

function CG_STORE_QUERY(vip)
	sendMessage(消息类型.CG_STORE_QUERY, {vip})
end

function CG_QUICK_QUERY()
	sendMessage(消息类型.CG_QUICK_QUERY, {})
end

function CG_BAG_DISCARD(pos)
	sendMessage(消息类型.CG_BAG_DISCARD, {pos})
end

function CG_ITEM_QUERY(id,query)
	sendMessage(消息类型.CG_ITEM_QUERY, {id,query})
end

function CG_STORE_SWAP(pos,posdst)
	sendMessage(消息类型.CG_STORE_SWAP, {pos,posdst})
end

function CG_STORE_REBUILD(vip)
	sendMessage(消息类型.CG_STORE_REBUILD, {vip})
end

function CG_EQUIP_ENDUE(pos,equippos,hero)
	sendMessage(消息类型.CG_EQUIP_ENDUE, {pos,equippos,hero})
end

function CG_BAG_QUERY()
	sendMessage(消息类型.CG_BAG_QUERY, {})
end

function CG_EQUIP_QUERY()
	sendMessage(消息类型.CG_EQUIP_QUERY, {})
end

function CG_ITEM_RESOLVE(pos)
	sendMessage(消息类型.CG_ITEM_RESOLVE, {pos})
end

function CG_ITEM_BUY(type,id,count)
	sendMessage(消息类型.CG_ITEM_BUY, {type,id,count})
end

function CG_BAG_DIVIDE(pos,count)
	sendMessage(消息类型.CG_BAG_DIVIDE, {pos,count})
end

function CG_BAG_REBUILD()
	sendMessage(消息类型.CG_BAG_REBUILD, {})
end

function CG_STORE_FETCHALL(vip)
	sendMessage(消息类型.CG_STORE_FETCHALL, {vip})
end

function CG_STORE_DISCARD(pos)
	sendMessage(消息类型.CG_STORE_DISCARD, {pos})
end

function CG_ITEM_USE(pos,count,hero)
	sendMessage(消息类型.CG_ITEM_USE, {pos,count,hero})
end

function CG_TIMESHOP_QUERY()
	sendMessage(消息类型.CG_TIMESHOP_QUERY, {})
end

function CG_QUICK_SETUP(id)
	sendMessage(消息类型.CG_QUICK_SETUP, {id})
end

function CG_ITEM_STORE(pos,vip)
	sendMessage(消息类型.CG_ITEM_STORE, {pos,vip})
end

function CG_ITEM_RESOLVE_QUERY(pos)
	sendMessage(消息类型.CG_ITEM_RESOLVE_QUERY, {pos})
end

function CG_STORE_FETCH(pos,vip)
	sendMessage(消息类型.CG_STORE_FETCH, {pos,vip})
end

function CG_TIMESHOP_BUY(id,type)
	sendMessage(消息类型.CG_TIMESHOP_BUY, {id,type})
end


--- 宠物CGMethod
function CG_BACK_PET(index)
	sendMessage(消息类型.CG_BACK_PET, {index})
end

function CG_BREAK_PET(index)
	sendMessage(消息类型.CG_BREAK_PET, {index})
end

function CG_PET_ADDPOINT(index,类型)
	sendMessage(消息类型.CG_PET_ADDPOINT, {index,类型})
end

function CG_TRAIN_PET(index1,index2)
	sendMessage(消息类型.CG_TRAIN_PET, {index1,index2})
end

function CG_PET_QUERY()
	sendMessage(消息类型.CG_PET_QUERY, {})
end

function CG_FEED_PET(index)
	sendMessage(消息类型.CG_FEED_PET, {index})
end

function CG_CALL_PET(index)
	sendMessage(消息类型.CG_CALL_PET, {index})
end

function CG_MERGE_PET(index)
	sendMessage(消息类型.CG_MERGE_PET, {index})
end


--- 锻造CGMethod
function CG_REFINE_WASH(contpos,pos,lock)
	sendMessage(消息类型.CG_REFINE_WASH, {contpos,pos,lock})
end

function CG_STRENGTHEN_ALL(contpos,pos,contposdst,posdst,contposnxt,posnxt)
	sendMessage(消息类型.CG_STRENGTHEN_ALL, {contpos,pos,contposdst,posdst,contposnxt,posnxt})
end

function CG_REFINE_UPGRADE(contpos,pos)
	sendMessage(消息类型.CG_REFINE_UPGRADE, {contpos,pos})
end

function CG_EQUIP_PREVIEW(contpos,pos)
	sendMessage(消息类型.CG_EQUIP_PREVIEW, {contpos,pos})
end

function CG_STRENGTHEN_TRANSFER(contpos,pos,contposdst,posdst)
	sendMessage(消息类型.CG_STRENGTHEN_TRANSFER, {contpos,pos,contposdst,posdst})
end

function CG_STRENGTHEN(contpos,pos)
	sendMessage(消息类型.CG_STRENGTHEN, {contpos,pos})
end

function CG_PERFECT_PREVIEW(contpos,pos)
	sendMessage(消息类型.CG_PERFECT_PREVIEW, {contpos,pos})
end


--- 聊天CGMethod
function CG_CHAT(msgtype,msg)
	sendMessage(消息类型.CG_CHAT, {msgtype,msg})
end


--- 场景CGMethod
function CG_BOSSCOPY_QUERY()
	sendMessage(消息类型.CG_BOSSCOPY_QUERY, {})
end

function CG_CREATE_ROOM(copyid)
	sendMessage(消息类型.CG_CREATE_ROOM, {copyid})
end

function CG_REFLESH_BOSS()
	sendMessage(消息类型.CG_REFLESH_BOSS, {})
end

function CG_VIEWER(objid)
	sendMessage(消息类型.CG_VIEWER, {objid})
end

function CG_QUIT_COPYSCENE()
	sendMessage(消息类型.CG_QUIT_COPYSCENE, {})
end

function CG_ENTER_COPYSCENE(mapid,刷怪数量)
	sendMessage(消息类型.CG_ENTER_COPYSCENE, {mapid,刷怪数量})
end

function CG_SINGLECOPY_QUERY()
	sendMessage(消息类型.CG_SINGLECOPY_QUERY, {})
end


--- 排行榜CGMethod
function CG_RANK_QUERY()
	sendMessage(消息类型.CG_RANK_QUERY, {})
end

function CG_RANK_VIPSPREAD_QUERY()
	sendMessage(消息类型.CG_RANK_VIPSPREAD_QUERY, {})
end

function CG_RANK_HERO_QUERY()
	sendMessage(消息类型.CG_RANK_HERO_QUERY, {})
end

function CG_RANK_PET_QUERY()
	sendMessage(消息类型.CG_RANK_PET_QUERY, {})
end


--- 寄售CGMethod
function CG_SELL_ITEM_QUERY(id)
	sendMessage(消息类型.CG_SELL_ITEM_QUERY, {id})
end

function CG_SELL_ITEM_OFF(id)
	sendMessage(消息类型.CG_SELL_ITEM_OFF, {id})
end

function CG_SELL_MINE_QUERY()
	sendMessage(消息类型.CG_SELL_MINE_QUERY, {})
end

function CG_SELL_ITEM(pos,rmb,price)
	sendMessage(消息类型.CG_SELL_ITEM, {pos,rmb,price})
end

function CG_SELL_RECORD_QUERY()
	sendMessage(消息类型.CG_SELL_RECORD_QUERY, {})
end

function CG_SELL_ITEM_BUY(id)
	sendMessage(消息类型.CG_SELL_ITEM_BUY, {id})
end

function CG_SELL_QUERY(type)
	sendMessage(消息类型.CG_SELL_QUERY, {type})
end


--- 队伍CGMethod
function CG_TEAM_LEAVE()
	sendMessage(消息类型.CG_TEAM_LEAVE, {})
end

function CG_TEAM_TEAMMATE()
	sendMessage(消息类型.CG_TEAM_TEAMMATE, {})
end

function CG_TEAM_INVITE(rolename)
	sendMessage(消息类型.CG_TEAM_INVITE, {rolename})
end

function CG_TEAM_DISMISS()
	sendMessage(消息类型.CG_TEAM_DISMISS, {})
end

function CG_TEAM_NEARBY_MEMBER()
	sendMessage(消息类型.CG_TEAM_NEARBY_MEMBER, {})
end

function CG_TEAM_NEARBY_TEAM()
	sendMessage(消息类型.CG_TEAM_NEARBY_TEAM, {})
end

function CG_TEAM_CREATE()
	sendMessage(消息类型.CG_TEAM_CREATE, {})
end

function CG_TEAM_APPLY(rolename)
	sendMessage(消息类型.CG_TEAM_APPLY, {rolename})
end

function CG_TEAM_DELMEMBER(rolename)
	sendMessage(消息类型.CG_TEAM_DELMEMBER, {rolename})
end

function CG_TEAM_APPLYENTER(rolename)
	sendMessage(消息类型.CG_TEAM_APPLYENTER, {rolename})
end

function CG_TEAM_TRANSFER(rolename)
	sendMessage(消息类型.CG_TEAM_TRANSFER, {rolename})
end

function CG_TEAM_ADDMEMBER(rolename)
	sendMessage(消息类型.CG_TEAM_ADDMEMBER, {rolename})
end

function CG_TEAM_SETUP(refuse1,refuse2)
	sendMessage(消息类型.CG_TEAM_SETUP, {refuse1,refuse2})
end


--- 行会CGMethod
function CG_GUILD_QUERY()
	sendMessage(消息类型.CG_GUILD_QUERY, {})
end

function CG_GUILD_LEAVE()
	sendMessage(消息类型.CG_GUILD_LEAVE, {})
end

function CG_GUILD_ALLIANCE(guildname,funds)
	sendMessage(消息类型.CG_GUILD_ALLIANCE, {guildname,funds})
end

function CG_GUILD_APPLYAGREE(rolename,agree)
	sendMessage(消息类型.CG_GUILD_APPLYAGREE, {rolename,agree})
end

function CG_GUILD_CHALLENGEAGREE(guildname,agree)
	sendMessage(消息类型.CG_GUILD_CHALLENGEAGREE, {guildname,agree})
end

function CG_GUILD_RECORD(type)
	sendMessage(消息类型.CG_GUILD_RECORD, {type})
end

function CG_GUILD_CASTLEINFO()
	sendMessage(消息类型.CG_GUILD_CASTLEINFO, {})
end

function CG_GUILD_MEMBER()
	sendMessage(消息类型.CG_GUILD_MEMBER, {})
end

function CG_GUILD_ATTACKMAP()
	sendMessage(消息类型.CG_GUILD_ATTACKMAP, {})
end

function CG_GUILD_CREATE(guildname)
	sendMessage(消息类型.CG_GUILD_CREATE, {guildname})
end

function CG_GUILD_LEVELUP()
	sendMessage(消息类型.CG_GUILD_LEVELUP, {})
end

function CG_GUILD_DONATE(funds)
	sendMessage(消息类型.CG_GUILD_DONATE, {funds})
end

function CG_GUILD_KICK(rolename)
	sendMessage(消息类型.CG_GUILD_KICK, {rolename})
end

function CG_GUILD_CHALLENGE(guildname,funds)
	sendMessage(消息类型.CG_GUILD_CHALLENGE, {guildname,funds})
end

function CG_GUILD_ALLIANCEAGREE(guildname,agree)
	sendMessage(消息类型.CG_GUILD_ALLIANCEAGREE, {guildname,agree})
end

function CG_GUILD_APPLY(guildname)
	sendMessage(消息类型.CG_GUILD_APPLY, {guildname})
end

function CG_GUILD_ADJUST(rolename,zhiwei)
	sendMessage(消息类型.CG_GUILD_ADJUST, {rolename,zhiwei})
end

function CG_GUILD_CHALLENGEMAP()
	sendMessage(消息类型.CG_GUILD_CHALLENGEMAP, {})
end

function CG_GUILD_ATTACKCASTLE(castleid)
	sendMessage(消息类型.CG_GUILD_ATTACKCASTLE, {castleid})
end

