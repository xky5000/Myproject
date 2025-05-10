module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 队伍管理 = require("队伍.队伍管理")

function CG_TEAM_TEAMMATE(human, msg)
	队伍管理.SendTeammate(human)
	return true
end

function CG_TEAM_SETUP(human, msg)
	human.m_db.队伍拒绝邀请 = msg.refuse1
	human.m_db.队伍拒绝申请 = msg.refuse2
	return true
end

function CG_TEAM_CREATE(human, msg)
	队伍管理.CreateTeam(human)
	return true
end

function CG_TEAM_ADDMEMBER(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	队伍管理.InviteMember(human, rolename)
	return true
end

function CG_TEAM_INVITE(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	队伍管理.AgreeInvite(human, rolename)
	return true
end

function CG_TEAM_DELMEMBER(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	队伍管理.KickMember(human, rolename)
	return true
end

function CG_TEAM_LEAVE(human, msg)
	队伍管理.LeaveTeam(human)
	return true
end

function CG_TEAM_DISMISS(human, msg)
	队伍管理.DismissTeam(human)
	return true
end

function CG_TEAM_TRANSFER(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	队伍管理.TransferMember(human, rolename)
	return true
end

function CG_TEAM_APPLYENTER(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	队伍管理.ApplyEnter(human, rolename)
	return true
end

function CG_TEAM_APPLY(human, msg)
	local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	队伍管理.AgreeApply(human, rolename)
	return true
end

function CG_TEAM_NEARBY_TEAM(human, msg)
	队伍管理.SendNearbyTeam(human)
	return true
end

function CG_TEAM_NEARBY_MEMBER(human, msg)
	队伍管理.SendNearbyMember(human)
	return true
end
