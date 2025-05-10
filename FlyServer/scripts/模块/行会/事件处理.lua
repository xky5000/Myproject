module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 行会管理 = require("行会.行会管理")

function CG_GUILD_QUERY(human, msg)
	行会管理.SendGuildList(human)
	return true
end

function CG_GUILD_MEMBER(human, msg)
	行会管理.SendGuildMember(human)
	return true
end

function CG_GUILD_RECORD(human, msg)
	行会管理.SendGuildRecord(human, msg.type)
	return true
end

function CG_GUILD_CREATE(human, msg)
	local guildname = 实用工具.GetStringFromTable(msg.guildnameLen, msg.guildname)
	行会管理.CreateGuild(human, guildname)
	return true
end

function CG_GUILD_LEAVE(human, msg)
	行会管理.LeaveGuild(human)
	return true
end

function CG_GUILD_KICK(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	行会管理.KickMember(human, rolename)
	return true
end

function CG_GUILD_ADJUST(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	行会管理.AdjustMember(human, rolename, msg.zhiwei)
	return true
end

function CG_GUILD_APPLY(human, msg)
	local guildname = 实用工具.GetStringFromTable(msg.guildnameLen, msg.guildname)
	行会管理.ApplyGuild(human, guildname)
	return true
end

function CG_GUILD_APPLYAGREE(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	行会管理.ApplyAgree(human, rolename, msg.agree)
	return true
end

function CG_GUILD_CHALLENGE(human, msg)
	local guildname = 实用工具.GetStringFromTable(msg.guildnameLen, msg.guildname)
	行会管理.ChallengeGuild(human, guildname, msg.funds)
	return true
end

function CG_GUILD_CHALLENGEAGREE(human, msg)
	local guildname = 实用工具.GetStringFromTable(msg.guildnameLen, msg.guildname)
	行会管理.ChallengeAgree(human, guildname, msg.agree)
	return true
end

function CG_GUILD_ALLIANCE(human, msg)
	local guildname = 实用工具.GetStringFromTable(msg.guildnameLen, msg.guildname)
	行会管理.AllianceGuild(human, guildname, msg.funds)
	return true
end

function CG_GUILD_ALLIANCEAGREE(human, msg)
	local guildname = 实用工具.GetStringFromTable(msg.guildnameLen, msg.guildname)
	行会管理.AllianceAgree(human, guildname, msg.agree)
	return true
end

function CG_GUILD_DONATE(human, msg)
	行会管理.DonateGuild(human, msg.funds)
	return true
end

function CG_GUILD_LEVELUP(human, msg)
	行会管理.LevelUpGuild(human)
	return true
end

function CG_GUILD_ATTACKCASTLE(human, msg)
	行会管理.AttackCastle(human, msg.castleid)
	return true
end

function CG_GUILD_ATTACKMAP(human, msg)
	行会管理.AttackMap(human)
	return true
end

function CG_GUILD_CHALLENGEMAP(human, msg)
	行会管理.ChallengeMap(human)
	return true
end

function CG_GUILD_CASTLEINFO(human, msg)
	行会管理.SendCastleInfo(human)
	return true
end
