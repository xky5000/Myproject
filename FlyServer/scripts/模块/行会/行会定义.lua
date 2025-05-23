module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")

GUILD_ZHIWEI_MEMBER = 0
GUILD_ZHIWEI_MANAGER = 1
GUILD_ZHIWEI_VICE_CHAIRMAN = 2
GUILD_ZHIWEI_CHAIRMAN = 3

ZHIWEI_NAME = {
	[0] = "成员",
	[1] = "管理员",
	[2] = "副会长",
	[3] = "会长",
}

GUILD_LOG_CREATE = 1
GUILD_LOG_LEAVE = 2
GUILD_LOG_KICK = 3
GUILD_LOG_APPLYAGREE = 4
GUILD_LOG_APPLYREFUSE = 5
GUILD_LOG_DONATE = 6
GUILD_LOG_LEVELUP = 7
GUILD_LOG_ADJUST = 8
GUILD_LOG_CHALLENGE = 101
GUILD_LOG_BECHALLENGE = 102
GUILD_LOG_CHALLENGEAGREE = 103
GUILD_LOG_BECHALLENGEAGREE = 104
GUILD_LOG_CHALLENGEREFUSE = 105
GUILD_LOG_BECHALLENGEREFUSE = 106
GUILD_LOG_ALLIANCE = 107
GUILD_LOG_BEALLIANCE = 108
GUILD_LOG_ALLIANCEAGREE = 109
GUILD_LOG_BEALLIANCEAGREE = 110
GUILD_LOG_ALLIANCEREFUSE = 111
GUILD_LOG_BEALLIANCEREFUSE = 112
GUILD_LOG_ATTACKCASTLE = 113
GUILD_LOG_BEATTACKCASTLE = 114
