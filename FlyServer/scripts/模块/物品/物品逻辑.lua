module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 日志 = require("公用.日志")
local 日志 = require("公用.日志")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 物品表 = require("配置.物品表").Config
local 怪物表 = require("配置.怪物表").Config
local 宠物表 = require("配置.宠物表").Config

function GetItemName(itemid, strengthen)
	local conf = 物品表[itemid]
	if not conf then
		return ""
	end
	if conf.type1 == 3 and conf.type2 == 14 and strengthen then
		local monconf = 宠物表[strengthen] or 怪物表[strengthen]
		return conf.name.."("..(monconf and monconf.name or "")..")"
	else
		return conf.name
	end
end

function GetItemIcon(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 0
	end
	return conf.icon
end

function GetItemGrade(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 1
	end
	return conf.grade
end

function GetItemLevel(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 1
	end
	return conf.level
end

function GetItemJob(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 1
	end
	return conf.job
end

function GetItemColor(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 0
	end
	return tonumber(conf.color) or 0
end

function GetItemType1(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 0
	end
	return conf.type1
end

function GetItemType2(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 0
	end
	return conf.type2
end

function GetItemBodyID(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 0
	end
	return conf.bodyid
end

function GetItemEffID(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return 0
	end
	return conf.effid
end

function IsEquip(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return false
	end
	return conf.type1 == 3 and conf.type2 ~= 14
end

function IsStone(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return false
	end
	return conf.type1 == 1 and conf.type2 == 5
end

function IsLuckStone(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return false
	end
	return conf.type1 == 1 and conf.type2 == 6
end

function IsAutoBind(itemid)
	local conf = 物品表[itemid]
	if not conf then
		return false
	end
	return conf.autobind == 1
end
