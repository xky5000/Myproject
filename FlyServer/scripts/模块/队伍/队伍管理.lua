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
local 物品逻辑 = require("物品.物品逻辑")

TeamList = TeamList or {}
TeamIndex = TeamIndex or 1

function CreateTeam(human)
	if human.teamid ~= 0 then
		human:SendTipsMsg(1, "你已经有队伍了")
		return
	end
	human:ChangeTeam(TeamIndex)
	TeamList[TeamIndex] = {human}
	TeamIndex = TeamIndex + 1
	human:SendTipsMsg(1, "#cff00,成功创建队伍")
	SendTeammate(human)
end

function DismissTeam(human)
	if human.teamid == 0 then
		human:SendTipsMsg(1, "你还没有队伍")
		return
	end
	if not TeamList[human.teamid] or #TeamList[human.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[human.teamid][1] ~= human then
		human:SendTipsMsg(1, "你不是队长,无法解散队伍")
		return
	end
	for i,v in ipairs(TeamList[human.teamid]) do
		if v ~= human then
			v:ChangeTeam(0)
			v:SendTipsMsg(1, "#cffff00,你的队伍已解散")
			SendTeammate(v)
		end
	end
	TeamList[human.teamid] = nil
	human:ChangeTeam(0)
	human:SendTipsMsg(1, "#cffff00,成功解散队伍")
	SendTeammate(human)
end

function LeaveTeam(human)
	if human.teamid == 0 then
		human:SendTipsMsg(1, "你还没有队伍")
		return
	end
	if not TeamList[human.teamid] or #TeamList[human.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[human.teamid][1] == human then
		human:SendTipsMsg(1, "你是队长,无法离开队伍")
		return
	end
	for i,v in ipairs(TeamList[human.teamid]) do
		if v == human then
			table.remove(TeamList[human.teamid],i)
			break
		end
	end
	for i,v in ipairs(TeamList[human.teamid]) do
		SendTeammate(v)
	end
	TeamList[human.teamid] = nil
	human:ChangeTeam(0)
	human:SendTipsMsg(1, "#cffff00,你已离开队伍")
	SendTeammate(human)
end

function InviteMember(human, rolename)
	if human:GetName() == rolename then
		human:SendTipsMsg(1, "你不能邀请自己")
		return
	end
	if human.teamid == 0 then
		human:SendTipsMsg(1, "你还没有队伍")
		return
	end
	if not TeamList[human.teamid] or #TeamList[human.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[human.teamid][1] ~= human then
		human:SendTipsMsg(1, "你不是队长,无法邀请")
		return
	end
	if #TeamList[human.teamid] >= 5 then
		human:SendTipsMsg(1, "队伍人数达到上限")
		return
	end
	local inviteHuman = 在线玩家管理[rolename]
	if not inviteHuman then
		human:SendTipsMsg(1, "该玩家不在线")
		return
	end
	if inviteHuman.m_db.队伍拒绝邀请 == 1 then
		human:SendTipsMsg(1, "对方拒绝组队邀请")
		return
	end
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_TEAM_INVITE]
	returnMsg.rolename = human:GetName()
	消息类.SendMsg(returnMsg, inviteHuman.id)
	human:SendTipsMsg(1, "#cffff00,已发送邀请请求")
end

function AgreeInvite(human, rolename)
	if human.teamid ~= 0 then
		human:SendTipsMsg(1, "你已经有队伍了")
		return
	end
	local inviteHuman = 在线玩家管理[rolename]
	if not inviteHuman then
		human:SendTipsMsg(1, "该玩家不在线")
		return
	end
	if inviteHuman.teamid == 0 then
		human:SendTipsMsg(1, "该玩家没有队伍")
		return
	end
	if not TeamList[inviteHuman.teamid] or #TeamList[inviteHuman.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[inviteHuman.teamid][1] ~= inviteHuman then
		human:SendTipsMsg(1, "对方不是队长,无法同意邀请")
		return
	end
	if #TeamList[inviteHuman.teamid] >= 5 then
		human:SendTipsMsg(1, "队伍人数达到上限")
		return
	end
	for i,v in ipairs(TeamList[inviteHuman.teamid]) do
		if v == human then
			human:SendTipsMsg(1, "你已经在队伍里了")
			return
		end
	end
	TeamList[inviteHuman.teamid][#TeamList[inviteHuman.teamid]+1] = human
	human:ChangeTeam(inviteHuman.teamid)
	human:SendTipsMsg(1, "#cff00,成功加入队伍")
	for i,v in ipairs(TeamList[human.teamid]) do
		SendTeammate(v)
	end
end

function ApplyEnter(human, rolename)
	if human.teamid ~= 0 then
		human:SendTipsMsg(1, "你已经有队伍了")
		return
	end
	local applyHuman = 在线玩家管理[rolename]
	if not applyHuman then
		human:SendTipsMsg(1, "该玩家不在线")
		return
	end
	if applyHuman.teamid == 0 then
		human:SendTipsMsg(1, "该玩家没有队伍")
		return
	end
	if not TeamList[applyHuman.teamid] or #TeamList[applyHuman.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[applyHuman.teamid][1] ~= applyHuman then
		human:SendTipsMsg(1, "该玩家不是队长,无法申请")
		return
	end
	if #TeamList[applyHuman.teamid] >= 5 then
		human:SendTipsMsg(1, "队伍人数达到上限")
		return
	end
	if applyHuman.m_db.队伍拒绝申请 == 1 then
		human:SendTipsMsg(1, "对方拒绝组队申请")
		return
	end
	for i,v in ipairs(TeamList[applyHuman.teamid]) do
		if v == human then
			human:SendTipsMsg(1, "你已经在队伍里了")
			return
		end
	end
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_TEAM_APPLY]
	returnMsg.rolename = human:GetName()
	消息类.SendMsg(returnMsg, applyHuman.id)
	human:SendTipsMsg(1, "#cffff00,已发送申请请求")
end

function AgreeApply(human, rolename)
	local applyHuman = 在线玩家管理[rolename]
	if not applyHuman then
		human:SendTipsMsg(1, "该玩家不在线")
		return
	end
	if applyHuman.teamid ~= 0 then
		human:SendTipsMsg(1, "对方已经有队伍了")
		return
	end
	if human.teamid == 0 then
		human:SendTipsMsg(1, "你还没有队伍")
		return
	end
	if not TeamList[human.teamid] or #TeamList[human.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[human.teamid][1] ~= human then
		human:SendTipsMsg(1, "你不是队长,无法同意申请")
		return
	end
	if #TeamList[human.teamid] >= 5 then
		human:SendTipsMsg(1, "队伍人数达到上限")
		return
	end
	for i,v in ipairs(TeamList[human.teamid]) do
		if v == applyHuman then
			human:SendTipsMsg(1, "对方已经在队伍里了")
			return
		end
	end
	TeamList[human.teamid][#TeamList[human.teamid]+1] = applyHuman
	applyHuman:ChangeTeam(human.teamid)
	human:SendTipsMsg(1, "#cff00,你同意了对方的申请")
	for i,v in ipairs(TeamList[human.teamid]) do
		SendTeammate(v)
	end
end

function KickMember(human, rolename)
	if human.teamid == 0 then
		human:SendTipsMsg(1, "你还没有队伍")
		return
	end
	if not TeamList[human.teamid] or #TeamList[human.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[human.teamid][1] ~= human then
		human:SendTipsMsg(1, "你不是队长,无法踢出")
		return
	end
	if human:GetName() == rolename then
		human:SendTipsMsg(1, "你不能踢出自己")
		return
	end
	local kickHuman = 在线玩家管理[rolename]
	if not kickHuman then
		human:SendTipsMsg(1, "该玩家不在线")
		return
	end
	for i,v in ipairs(TeamList[human.teamid]) do
		if v == kickHuman then
			table.remove(TeamList[human.teamid],i)
			break
		end
	end
	kickHuman:ChangeTeam(0)
	kickHuman:SendTipsMsg(1, "#cffff00,你被踢出队伍")
	SendTeammate(kickHuman)
	human:SendTipsMsg(1, "#cff00,成功踢出玩家")
	for i,v in ipairs(TeamList[human.teamid]) do
		SendTeammate(v)
	end
end

function TransferMember(human, rolename)
	if human.teamid == 0 then
		human:SendTipsMsg(1, "你还没有队伍")
		return
	end
	if not TeamList[human.teamid] or #TeamList[human.teamid] == 0 then
		human:SendTipsMsg(1, "找不到队伍")
		return
	end
	if TeamList[human.teamid][1] ~= human then
		human:SendTipsMsg(1, "你不是队长,无法移交")
		return
	end
	if human:GetName() == rolename then
		human:SendTipsMsg(1, "你不能移交自己")
		return
	end
	local teamHuman = 在线玩家管理[rolename]
	if not teamHuman then
		human:SendTipsMsg(1, "该玩家不在线")
		return
	end
	for i,v in ipairs(TeamList[human.teamid]) do
		if v == teamHuman then
			table.remove(TeamList[human.teamid],i)
			break
		end
	end
	table.insert(TeamList[human.teamid],1,teamHuman)
	human:SendTipsMsg(1, "#cff00,成功移交队长")
	for i,v in ipairs(TeamList[human.teamid]) do
		SendTeammate(v)
	end
end

function SendTeammate(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_TEAM_TEAMMATE]
	returnMsg.infoLen = 0
	if human.teamid ~= 0 and TeamList[human.teamid] then
		for i,v in ipairs(TeamList[human.teamid]) do
			if returnMsg.infoLen >= 5 then
				break
			elseif v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				returnMsg.infoLen = returnMsg.infoLen + 1
				returnMsg.info[returnMsg.infoLen].rolename = v:GetName()
				returnMsg.info[returnMsg.infoLen].job = v.m_db.job
				returnMsg.info[returnMsg.infoLen].sex = v.m_db.sex
				returnMsg.info[returnMsg.infoLen].level = v:GetLevel()
				returnMsg.info[returnMsg.infoLen].转生等级 = v.m_db.转生等级
				returnMsg.info[returnMsg.infoLen].weaponicon =
					v.m_db.bagdb.equips[1] and 物品逻辑.GetItemIcon(v.m_db.bagdb.equips[1].id) or 0
				returnMsg.info[returnMsg.infoLen].bodyicon =
					(v.m_db.显示时装 == 1 and v.m_db.bagdb.equips[23]) and 物品逻辑.GetItemIcon(v.m_db.bagdb.equips[23].id) or
					v.m_db.bagdb.equips[2] and 物品逻辑.GetItemIcon(v.m_db.bagdb.equips[2].id) or 0
				returnMsg.info[returnMsg.infoLen].toukuiicon =
					v.m_db.bagdb.equips[11] and 物品逻辑.GetItemIcon(v.m_db.bagdb.equips[11].id) or
					v.m_db.bagdb.equips[3] and 物品逻辑.GetItemIcon(v.m_db.bagdb.equips[3].id) or 0
				returnMsg.info[returnMsg.infoLen].mianjinicon =
					v.m_db.bagdb.equips[12] and 物品逻辑.GetItemIcon(v.m_db.bagdb.equips[12].id) or 0
			end
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end

function SendNearbyTeam(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_TEAM_NEARBY_TEAM]
	returnMsg.infoLen = 0
	local x,y = human:GetPosition()
	local humans = human:ScanCircleObjs(x,y,1000)
	if humans and #humans > 0 then
		local teamlist = {}
		for _,v in ipairs(humans) do
			if v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and v.teamid ~= 0 then
				teamlist[v.teamid] = TeamList[v.teamid]
			end
		end
		for _,v in pairs(teamlist) do
			if returnMsg.infoLen >= 50 then
				break
			elseif #v > 0 and v[1]:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				returnMsg.infoLen = returnMsg.infoLen + 1
				returnMsg.info[returnMsg.infoLen].captain = v[1]:GetName()
				returnMsg.info[returnMsg.infoLen].job = v[1].m_db.job
				returnMsg.info[returnMsg.infoLen].level = v[1]:GetLevel()
				returnMsg.info[returnMsg.infoLen].转生等级 = v[1].m_db.转生等级
				returnMsg.info[returnMsg.infoLen].number = #v
				returnMsg.info[returnMsg.infoLen].guildname = ""
			end
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end

function SendNearbyMember(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_TEAM_NEARBY_MEMBER]
	returnMsg.infoLen = 0
	local x,y = human:GetPosition()
	local humans = human:ScanCircleObjs(x,y,1000)
	if humans and #humans > 0 then
		for _,v in ipairs(humans) do
			if returnMsg.infoLen >= 50 then
				break
			elseif v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and v.teamid == 0 and v ~= human then
				returnMsg.infoLen = returnMsg.infoLen + 1
				returnMsg.info[returnMsg.infoLen].rolename = v:GetName()
				returnMsg.info[returnMsg.infoLen].job = v.m_db.job
				returnMsg.info[returnMsg.infoLen].level = v:GetLevel()
				returnMsg.info[returnMsg.infoLen].转生等级 = v.m_db.转生等级
				returnMsg.info[returnMsg.infoLen].zhanli = v:CalcPower()
				returnMsg.info[returnMsg.infoLen].guildname = ""
			end
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end
