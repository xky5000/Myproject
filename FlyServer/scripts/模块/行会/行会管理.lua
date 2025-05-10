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
local 行会DB = require("行会.行会DB").GuildDB
local 背包DB = require("物品.背包DB")
local 行会定义 = require("行会.行会定义")
local 城堡管理 = require("行会.城堡管理")

GuildSorts = GuildSorts or {}
GuildList = GuildList or {}

function Init()
    local pCursor = _Find(g_oMongoDB,"guild","{}")
    if not pCursor then
        return true
    end
    while true do
		local guild = 行会DB:New()
		if not _NextCursor(pCursor,guild) then
			guild:Delete()
			break
		else
			GuildSorts[#GuildSorts+1] = guild
			GuildList[guild.name] = guild
		end
    end
	if Config.MERGEST and Config.SVRNAME:len() > 0 then
		for k,v in pairs(GuildList) do
			local name = k
			if k:sub(1,Config.SVRNAME:len()) ~= Config.SVRNAME then
				name = Config.SVRNAME..k
				GuildList[name] = vv
				GuildList[k] = nil
			end
		end
		for i,v in ipairs(GuildSorts) do
			if v.name:sub(1,Config.SVRNAME:len()) ~= Config.SVRNAME then
				v.name = Config.SVRNAME..v.name
			end
			if v.chairman:sub(1,Config.SVRNAME:len()) ~= Config.SVRNAME then
				v.chairman = Config.SVRNAME..v.chairman
			end
			for kk,vv in pairs(v.member) do
				local name = kk
				if kk:sub(1,Config.SVRNAME:len()) ~= Config.SVRNAME then
					name = Config.SVRNAME..kk
					v.member[name] = vv
					v.member[kk] = nil
				end
			end
			for kk,vv in pairs(v.apply) do
				local name = kk
				if kk:sub(1,Config.SVRNAME:len()) ~= Config.SVRNAME then
					name = Config.SVRNAME..kk
					v.apply[name] = vv
					v.apply[kk] = nil
				end
			end
			v:Save()
		end
	end
	table.sort(GuildSorts, CompareRanking)
    return true
end

function CompareRanking(first,second)
	if first.level ~= second.level then return first.level>second.level end
	if first.zhanli ~= second.zhanli then return first.zhanli>second.zhanli end
end

function UpdateMemberInfo(guildname,name,zhanli,job,level,转生等级)
	if guildname == "" or not GuildList[guildname] then
		return
	end
	local guild = GuildList[guildname]
	local member = guild.member[name]
	if not member then
		return
	end
	guild.zhanli = guild.zhanli - member[3]
	member[3] = zhanli or 0
	member[4] = job or member[4]
	member[5] = level or member[5]
	member[6] = 转生等级 or member[6]
	guild.zhanli = guild.zhanli + (zhanli or 0)
	guild:Save()
	table.sort(GuildSorts, CompareRanking)
end

function SendGuildList(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_GUILD_LIST]
	returnMsg.infoLen = 0
	for i,v in ipairs(GuildSorts) do
		if returnMsg.infoLen >= 100 then
			break
		else
			returnMsg.infoLen = returnMsg.infoLen + 1
			returnMsg.info[returnMsg.infoLen].ranking = i
			returnMsg.info[returnMsg.infoLen].guildname = v.name
			returnMsg.info[returnMsg.infoLen].chairman = v.chairman
			returnMsg.info[returnMsg.infoLen].level = v.level
			returnMsg.info[returnMsg.infoLen].number = v.num
			returnMsg.info[returnMsg.infoLen].zhanli = v.zhanli
			returnMsg.info[returnMsg.infoLen].funds = v.funds
			if human.m_db.guildname == "" then
				returnMsg.info[returnMsg.infoLen].status = human.m_db.guildapply[v.name] and 1 or 0
			elseif human.m_db.guildname == v.name then
				returnMsg.info[returnMsg.infoLen].status = 2
			elseif GuildList[human.m_db.guildname] then
				local guild = GuildList[human.m_db.guildname]
				returnMsg.info[returnMsg.infoLen].status = guild.challenge[v.name] and 3 or guild.alliance[v.name] and 4 or 5
			else
				human.m_db.guildname = ""
				returnMsg.info[returnMsg.infoLen].status = 0
			end
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end

function SendGuildMember(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_GUILD_MEMBER]
	returnMsg.guildLen = 0
	returnMsg.memberLen = 0
	if human.m_db.guildname ~= "" and not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
	end
	if human.m_db.guildname == "" then
		消息类.SendMsg(returnMsg, human.id)
		return
	end
	local guild = GuildList[human.m_db.guildname]
	returnMsg.guildLen = 1
	returnMsg.guild[1].ranking = 0
	for i,v in ipairs(GuildSorts) do
		if v == guild then
			returnMsg.guild[1].ranking = i
			break
		end
	end
	returnMsg.guild[1].guildname = guild.name
	returnMsg.guild[1].chairman = guild.chairman
	returnMsg.guild[1].level = guild.level
	returnMsg.guild[1].number = guild.num
	returnMsg.guild[1].zhanli = guild.zhanli
	returnMsg.guild[1].funds = guild.funds
	returnMsg.guild[1].status = 2
	for k,v in pairs(guild.member) do
		if returnMsg.memberLen >= 100 then
			break
		else
			returnMsg.memberLen = returnMsg.memberLen + 1
			returnMsg.member[returnMsg.memberLen].rolename = k
			returnMsg.member[returnMsg.memberLen].job = v[4] or 1
			returnMsg.member[returnMsg.memberLen].level = v[5] or 1
			returnMsg.member[returnMsg.memberLen].转生等级 = v[6] or 0
			returnMsg.member[returnMsg.memberLen].zhanli = v[3]
			returnMsg.member[returnMsg.memberLen].zhiwei = v[1]
			returnMsg.member[returnMsg.memberLen].gongxian = v[2]
			returnMsg.member[returnMsg.memberLen].status = 在线玩家管理[tostring(k)] and 1 or 0
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end

function SendGuildRecord(human, type)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_GUILD_RECORD]
	returnMsg.infoLen = 0
	if human.m_db.guildname ~= "" and not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
	end
	if human.m_db.guildname == "" then
		消息类.SendMsg(returnMsg, human.id)
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local curtime = os.time()
	if type == 2 then
		local member = guild.member[human:GetName()]
		if member and member[1] >= 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
			for k,v in pairs(guild.challenge) do
				if returnMsg.infoLen >= 100 then
					break
				elseif v == 2 then
					returnMsg.infoLen = returnMsg.infoLen + 1
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..k.."#C申请对你的行会发起挑战,挑战资金为#cffff00,"..(guild.challengefunds[k] or 0)
					returnMsg.info[returnMsg.infoLen].time = curtime - (guild.challengetime[k] or curtime)
					returnMsg.info[returnMsg.infoLen].rolename = k
					returnMsg.info[returnMsg.infoLen].type = 1
				end
			end
			for k,v in pairs(guild.alliance) do
				if returnMsg.infoLen >= 100 then
					break
				elseif v == 2 then
					returnMsg.infoLen = returnMsg.infoLen + 1
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..k.."#C申请和你的行会结为同盟,结盟资金为#cffff00,2000"..(guild.alliancefunds[k] or 0)
					returnMsg.info[returnMsg.infoLen].time = curtime - (guild.alliancetime[k] or curtime)
					returnMsg.info[returnMsg.infoLen].rolename = k
					returnMsg.info[returnMsg.infoLen].type = 2
				end
			end
		end
		if member and member[1] >= 行会定义.GUILD_ZHIWEI_MANAGER then
			for k,v in pairs(guild.apply) do
				if returnMsg.infoLen >= 100 then
					break
				elseif v == 1 then
					returnMsg.infoLen = returnMsg.infoLen + 1
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..k.."#C申请加入你的行会"
					returnMsg.info[returnMsg.infoLen].time = curtime - (guild.challengetime[k] or curtime)
					returnMsg.info[returnMsg.infoLen].rolename = k
					returnMsg.info[returnMsg.infoLen].type = 0
				end
			end
		end
	elseif type == 1 then
		for i=#guild.record,1,-1 do
			local v = guild.record[i]
			if returnMsg.infoLen >= 100 then
				break
			elseif v[1] and v[1] >= 行会定义.GUILD_LOG_CHALLENGE then
				returnMsg.infoLen = returnMsg.infoLen + 1
				if v[1] == 行会定义.GUILD_LOG_CHALLENGE then
					returnMsg.info[returnMsg.infoLen].record = "你的行会申请对#cffff00,"..v[3].."#C发起挑战,挑战资金为#cffff00,"..(v[4] or 0)
				elseif v[1] == 行会定义.GUILD_LOG_BECHALLENGE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C申请对你的行会发起挑战,挑战资金为#cffff00,"..(v[4] or 0)
				elseif v[1] == 行会定义.GUILD_LOG_CHALLENGEAGREE then
					returnMsg.info[returnMsg.infoLen].record = "你的行会同意了#cffff00,"..v[3].."#C发起的挑战"
				elseif v[1] == 行会定义.GUILD_LOG_BECHALLENGEAGREE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C同意了你的行会发起的挑战"
				elseif v[1] == 行会定义.GUILD_LOG_CHALLENGEREFUSE then
					returnMsg.info[returnMsg.infoLen].record = "你的行会拒绝了#cffff00,"..v[3].."#C发起的挑战"
				elseif v[1] == 行会定义.GUILD_LOG_BECHALLENGEREFUSE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C拒绝了你的行会发起的挑战"
				elseif v[1] == 行会定义.GUILD_LOG_ALLIANCE then
					returnMsg.info[returnMsg.infoLen].record = "你的行会申请与#cffff00,"..v[3].."#C结为同盟,结盟资金为#cffff00,"..(v[4] or 0)
				elseif v[1] == 行会定义.GUILD_LOG_BEALLIANCE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C申请与你的行会结为同盟,结盟资金为#cffff00,"..(v[4] or 0)
				elseif v[1] == 行会定义.GUILD_LOG_ALLIANCEAGREE then
					returnMsg.info[returnMsg.infoLen].record = "你的行会同意了#cffff00,"..v[3].."#C发起的结盟"
				elseif v[1] == 行会定义.GUILD_LOG_BEALLIANCEAGREE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C同意了你的行会发起的结盟"
				elseif v[1] == 行会定义.GUILD_LOG_ALLIANCEREFUSE then
					returnMsg.info[returnMsg.infoLen].record = "你的行会拒绝了#cffff00,"..v[3].."#C发起的结盟"
				elseif v[1] == 行会定义.GUILD_LOG_BEALLIANCEREFUSE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C拒绝了你的行会发起的结盟"
				elseif v[1] == 行会定义.GUILD_LOG_ATTACKCASTLE then
					returnMsg.info[returnMsg.infoLen].record = "你的行会申请了攻打#cffff00,"..v[3].."#C的城堡#cffff00,"..(城堡管理.GetCastleName(v[4] or 0) or "")
				elseif v[1] == 行会定义.GUILD_LOG_BEATTACKCASTLE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C申请了攻打你的行会的城堡#cffff00,"..(城堡管理.GetCastleName(v[4] or 0) or "")
				else
					returnMsg.info[returnMsg.infoLen].record = ""
				end
				returnMsg.info[returnMsg.infoLen].time = curtime - (v[2] or curtime)
				returnMsg.info[returnMsg.infoLen].rolename = ""
				returnMsg.info[returnMsg.infoLen].type = 0
			end
		end
	else
		for i=#guild.record,1,-1 do
			local v = guild.record[i]
			if returnMsg.infoLen >= 100 then
				break
			elseif v[1] and v[1] < 行会定义.GUILD_LOG_CHALLENGE then
				returnMsg.infoLen = returnMsg.infoLen + 1
				if v[1] == 行会定义.GUILD_LOG_CREATE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C创建了行会"
				elseif v[1] == 行会定义.GUILD_LOG_LEAVE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C离开了行会"
				elseif v[1] == 行会定义.GUILD_LOG_KICK then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C把#cffff00,"..(v[4] or "").."#C踢出了行会"
				elseif v[1] == 行会定义.GUILD_LOG_ADJUST then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C把#cffff00,"..(v[4] or "").."#C的职位从#cffff00,"..(行会定义.ZHIWEI_NAME[v[5] or 0] or "").."#C调整为#cffff00,"..(行会定义.ZHIWEI_NAME[v[6] or 0] or "")
				elseif v[1] == 行会定义.GUILD_LOG_APPLYAGREE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C同意了#cffff00,"..(v[4] or "").."#C的入会申请"
				elseif v[1] == 行会定义.GUILD_LOG_APPLYREFUSE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C拒绝了#cffff00,"..(v[4] or "").."#C的入会申请"
				elseif v[1] == 行会定义.GUILD_LOG_DONATE then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C贡献了#cffff00,"..(v[4] or "").."#C点行会资金"
				elseif v[1] == 行会定义.GUILD_LOG_LEVELUP then
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..v[3].."#C将行会升级为#cffff00,"..(v[4] or "").."级"
				else
					returnMsg.info[returnMsg.infoLen].record = ""
				end
				returnMsg.info[returnMsg.infoLen].time = curtime - (v[2] or curtime)
				returnMsg.info[returnMsg.infoLen].rolename = ""
				returnMsg.info[returnMsg.infoLen].type = 0
			end
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end

function CreateGuild(human, guildname)
	if human.m_db.guildname ~= "" then
		human:SendTipsMsg(1, "你已经有行会了")
		return
	end
	if human:GetMoney(true) < 1000000 then
		human:SendTipsMsg(1, "金币不足")
		return
	end
	if guildname == "" or guildname:find(" ") or guildname:find("　") or guildname:find("%.") or guildname=="无" then
		human:SendTipsMsg(1, "请输入有效行会名")
		return
	end
	if Config.USESVR and human.m_db.svrname ~= "" then
		guildname = human.m_db.svrname..guildname
	end
	if tonumber(guildname) ~= nil then
		human:SendTipsMsg(1, "行会名称不能全为数字")
		return
	end
	if GuildList[guildname] then
		human:SendTipsMsg(1, "行会名称不能与其他行会重复")
		return
	end
	if 公共定义.沃玛号角ID ~= 0 then
		if 背包DB.CheckCount(human, 公共定义.沃玛号角ID) < 1 then
			human:SendTipsMsg(1,"沃玛号角数量不足")
			return
		end
		背包DB.RemoveCount(human, 公共定义.沃玛号角ID, 1)
	end
	human:DecMoney(1000000, true)
	local guild = 行会DB:New()
	guild.name = guildname
	guild.chairman = human:GetName()
	guild.zhanli = human:CalcPower()
	guild.member[human:GetName()] = {行会定义.GUILD_ZHIWEI_CHAIRMAN,0,guild.zhanli,human.m_db.job,human:GetLevel(),human.m_db.转生等级}
	guild.num = 1
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_CREATE,os.time(),human:GetName()}
	guild:Add()
	GuildSorts[#GuildSorts+1] = guild
	GuildList[guild.name] = guild
	table.sort(GuildSorts, CompareRanking)
	human.m_db.guildname = guildname
	human:SendTipsMsg(1, "#cff00,成功创建行会")
	SendGuildList(human)
	human:ChangeName()
	human:UpdateObjInfo()
end

function LeaveGuild(human)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	if guild.chairman == human:GetName() then--and guild.num > 1 then
		human:SendTipsMsg(1, "你是会长,无法退出行会")
		return
	end
	local member = guild.member[human:GetName()]
	if not member then
		human:SendTipsMsg(1, "成员不存在")
		return
	end
	guild.zhanli = guild.zhanli - member[3]
	guild.member[human:GetName()] = nil
	guild.num = guild.num - 1
	--if guild.num == 0 then
	--	guild:Delete()
	--	GuildList[human.m_db.guildname] = nil
	--else
		guild.record[#guild.record+1] = {行会定义.GUILD_LOG_LEAVE,os.time(),human:GetName()}
		guild:Save()
		table.sort(GuildSorts, CompareRanking)
	--end
	human.m_db.guildname = ""
	human:SendTipsMsg(1, "#cffff00,成功退出行会")
	SendGuildMember(human)
	human:ChangeName()
	human:UpdateObjInfo()
end

function KickMember(human, rolename)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if rolename == human:GetName() then
		human:SendTipsMsg(1, "你无法踢出自己")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local mymember = guild.member[human:GetName()]
	local member = guild.member[rolename]
	if not mymember or not member or mymember[1] <= member[1] then
		human:SendTipsMsg(1, "你没有相应权限,无法踢出")
		return
	end
	guild.zhanli = guild.zhanli - member[3]
	guild.member[rolename] = nil
	guild.num = guild.num - 1
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_KICK,os.time(),human:GetName(),rolename}
	guild:Save()
	table.sort(GuildSorts, CompareRanking)
	local kickhuman = 在线玩家管理[rolename]
	if kickhuman then
		kickhuman.m_db.guildname = ""
		kickhuman:SendTipsMsg(1, "#cffff00,你被踢出行会")
		SendGuildMember(kickhuman)
		kickhuman:ChangeName()
		kickhuman:UpdateObjInfo()
	end
	human:SendTipsMsg(1, "#cffff00,成功踢出行会")
	SendGuildMember(human)
end

function AdjustMember(human, rolename, zhiwei)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if rolename == human:GetName() then
		human:SendTipsMsg(1, "你无法调整自己")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local mymember = guild.member[human:GetName()]
	local member = guild.member[rolename]
	if not mymember or not member or mymember[1] <= member[1] then
		human:SendTipsMsg(1, "你没有相应权限,无法调整")
		return
	end
	local oldzhiwei = member[1]
	if oldzhiwei == zhiwei then
		human:SendTipsMsg(1, "已经是相同职位,无法调整")
		return
	end
	if zhiwei == 行会定义.GUILD_ZHIWEI_CHAIRMAN then
		mymember[1] = 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN
		member[1] = zhiwei
		guild.chairman = rolename
	else
		member[1] = zhiwei
	end
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_ADJUST,os.time(),human:GetName(),rolename,oldzhiwei,zhiwei}
	guild:Save()
	local adjusthuman = 在线玩家管理[rolename]
	if adjusthuman then
		adjusthuman:SendTipsMsg(1, "#cffff00,你的行会职位被调整为#cff00,"..(行会定义.ZHIWEI_NAME[zhiwei] or "其他"))
		SendGuildMember(adjusthuman)
	end
	human:SendTipsMsg(1, "#cffff00,成功调整职位")
	SendGuildMember(human)
end

function ApplyGuild(human, guildname)
	if human.m_db.guildname ~= "" then
		human:SendTipsMsg(1, "你已经有行会了")
		return
	end
	if not GuildList[guildname] then
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if human.m_db.guildapply[guildname] then
		human:SendTipsMsg(1, "你已经申请过了")
		return
	end
	local guild = GuildList[guildname]
	if guild.num >= guild.level*10 then
		human:SendTipsMsg(1, "行会人数已满")
		return
	end
	guild.apply[human:GetName()] = 1
	guild:Save()
	human.m_db.guildapply[guildname] = 1
	human:SendTipsMsg(1, "#cffff00,成功申请加入行会")
	SendGuildList(human)
end

function ApplyAgree(human, rolename, agree)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if rolename == human:GetName() then
		human:SendTipsMsg(1, "你无法同意自己")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	if guild.apply[rolename] ~= 1 then
		human:SendTipsMsg(1, "该玩家不在申请列表")
		return
	end
	if guild.member[rolename] then
		human:SendTipsMsg(1, "该玩家已是行会成员")
		return
	end
	if guild.num >= guild.level*10 then
		human:SendTipsMsg(1, "行会人数已满")
		return
	end
	local mymember = guild.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_MANAGER then
		human:SendTipsMsg(1, "你没有相应权限,无法同意")
		return
	end
	if agree == 1 then
		guild.apply[rolename] = 2
		guild.record[#guild.record+1] = {行会定义.GUILD_LOG_APPLYAGREE,os.time(),human:GetName(),rolename}
		guild:Save()
		human:SendTipsMsg(1, "#cff00,成功同意玩家申请")
		SendGuildRecord(human, 2)
	else
		guild.apply[rolename] = nil
		guild.record[#guild.record+1] = {行会定义.GUILD_LOG_APPLYREFUSE,os.time(),human:GetName(),rolename}
		guild:Save()
		human:SendTipsMsg(1, "#cffff00,你拒绝了玩家申请")
		SendGuildRecord(human, 2)
	end
	local applyhuman = 在线玩家管理[rolename]
	if applyhuman then
		if guild.apply[rolename] == 2 then
			local zhanli = applyhuman:CalcPower()
			guild.apply[rolename] = nil
			guild.zhanli = guild.zhanli + zhanli
			guild.member[rolename] = {行会定义.GUILD_ZHIWEI_MEMBER,0,zhanli,applyhuman.m_db.job,applyhuman:GetLevel(),applyhuman.m_db.转生等级}
			guild.num = guild.num + 1
			guild:Save()
			table.sort(GuildSorts, CompareRanking)
			applyhuman.m_db.guildapply[human.m_db.guildname] = nil
			for k,v in pairs(applyhuman.m_db.guildapply) do
				local g = GuildList[k]
				if g then
					g.apply[rolename] = nil
					g:Save()
				end
			end
			applyhuman.m_db.guildapply = {}
			applyhuman.m_db.guildname = human.m_db.guildname
			applyhuman:SendTipsMsg(1, "#cff00,你的行会申请已经通过")
			applyhuman:ChangeName()
			applyhuman:UpdateObjInfo()
		else
			applyhuman.m_db.guildapply[human.m_db.guildname] = nil
			applyhuman:SendTipsMsg(1, "#cffff00,你的行会申请已被拒绝")
		end
	end
end

function ChallengeGuild(human, guildname, funds)
	if funds <= 0 then
		human:SendTipsMsg(1, "请输入挑战资金")
		return
	end
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if guildname == human.m_db.guildname then
		human:SendTipsMsg(1, "无法挑战自己的行会")
		return
	end
	if not GuildList[human.m_db.guildname] or not GuildList[guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local otherGuild = GuildList[guildname]
	local mymember = guild.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法挑战")
		return
	end
	if guild.alliance[guildname] then
		human:SendTipsMsg(1, "联盟行会无法发起挑战")
		return
	end
	if guild.challenge[guildname] == 2 then
		human:SendTipsMsg(1, "该行会已对你发起了挑战")
		return
	end
	if guild.challenge[guildname] == 1 then
		human:SendTipsMsg(1, "已经发起对该行会的挑战")
		return
	end
	if guild.funds < funds then
		human:SendTipsMsg(1, "挑战资金不足")
		return
	end
	guild.funds = guild.funds - funds
	guild.challenge[guildname] = 1
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_CHALLENGE,os.time(),guildname,funds}
	guild:Save()
	otherGuild.challenge[human.m_db.guildname] = 2
	otherGuild.challengefunds[human.m_db.guildname] = funds
	otherGuild.challengetime[human.m_db.guildname] = os.time()
	otherGuild.record[#otherGuild.record+1] = {行会定义.GUILD_LOG_BECHALLENGE,os.time(),human.m_db.guildname,funds}
	otherGuild:Save()
	human:SendTipsMsg(1, "#cffff00,成功对行会发起挑战")
	SendGuildList(human)
end

function GetChallengeGuild(guildname)
	if not GuildList[guildname] then
		return
	end
	local guild = GuildList[guildname]
	for k,v in pairs(guild.challenge) do
		if v == 1 then
			local otherGuild = GuildList[k]
			if otherGuild and otherGuild.challenge[guildname] == 1 then
				return k
			end
		end
	end
end

function IsChallengeGuild(guildname1,guildname2)
	if GetChallengeGuild(guildname1) == guildname2 then
		return true
	end
	local castleid1 = 城堡管理.AttackGuild[guildname1]
	local castleid2 = 城堡管理.AttackGuild[guildname2]
	if castleid1 and castleid1 and not IsAllianceGuild(guildname1, guildname2) then
		return true
	end
	return false
end

function ChallengeAgree(human, guildname, agree)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if guildname == human.m_db.guildname then
		human:SendTipsMsg(1, "无法同意自己的行会")
		return
	end
	if not GuildList[human.m_db.guildname] or not GuildList[guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local otherGuild = GuildList[guildname]
	local mymember = guild.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_MANAGER then
		human:SendTipsMsg(1, "你没有相应权限,无法同意")
		return
	end
	if guild.challenge[guildname] ~= 2 then
		human:SendTipsMsg(1, "该行会不在挑战列表")
		return
	end
	if GetChallengeGuild(human.m_db.guildname) then
		human:SendTipsMsg(1, "你已经同意了其他行会的挑战")
		return
	end
	if agree == 1 then
		guild.challenge[guildname] = 1
		guild.record[#guild.record+1] = {行会定义.GUILD_LOG_CHALLENGEAGREE,os.time(),guildname}
		guild:Save()
		otherGuild.record[#otherGuild.record+1] = {行会定义.GUILD_LOG_BECHALLENGEAGREE,os.time(),human.m_db.guildname}
		otherGuild:Save()
		human:SendTipsMsg(1, "#cff00,成功同意行会挑战")
		SendGuildRecord(human, 2)
	else
		otherGuild.funds = otherGuild.funds + guild.challengefunds[guildname]
		otherGuild.record[#otherGuild.record+1] = {行会定义.GUILD_LOG_BECHALLENGEREFUSE,os.time(),human.m_db.guildname}
		otherGuild:Save()
		guild.challenge[guildname] = nil
		guild.challengefunds[guildname] = nil
		guild.challengetime[guildname] = nil
		guild.record[#guild.record+1] = {行会定义.GUILD_LOG_CHALLENGEREFUSE,os.time(),guildname}
		guild:Save()
		human:SendTipsMsg(1, "#cffff00,你拒绝了行会挑战")
		SendGuildRecord(human, 2)
	end
end

function IsAllianceGuild(guildname1, guildname2)
	if not GuildList[guildname1] or not GuildList[guildname2] then
		return false
	end
	local guild1 = GuildList[guildname1]
	local guild2 = GuildList[guildname2]
	if guild1.alliance[guildname2] == 1 and guild2.alliance[guildname1] == 1 then
		return true
	else
		return false
	end
end

function AllianceGuild(human, guildname, funds)
	if funds <= 0 then
		human:SendTipsMsg(1, "请输入结盟资金")
		return
	end
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if guildname == human.m_db.guildname then
		human:SendTipsMsg(1, "无法结盟自己的行会")
		return
	end
	if not GuildList[human.m_db.guildname] or not GuildList[guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local otherGuild = GuildList[guildname]
	local mymember = guild.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法结盟")
		return
	end
	if guild.challenge[guildname] then
		human:SendTipsMsg(1, "已经发起挑战的行会无法结盟")
		return
	end
	if guild.alliance[guildname] then
		human:SendTipsMsg(1, "联盟行会无法再次结盟")
		return
	end
	if guild.funds < funds then
		human:SendTipsMsg(1, "结盟资金不足")
		return
	end
	guild.funds = guild.funds - funds
	guild.alliance[guildname] = 1
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_ALLIANCE,os.time(),guildname,funds}
	guild:Save()
	otherGuild.alliance[human.m_db.guildname] = 2
	otherGuild.alliancefunds[human.m_db.guildname] = funds
	otherGuild.alliancetime[human.m_db.guildname] = os.time()
	otherGuild.record[#otherGuild.record+1] = {行会定义.GUILD_LOG_BEALLIANCE,os.time(),human.m_db.guildname,funds}
	otherGuild:Save()
	human:SendTipsMsg(1, "#cffff00,成功对行会发起结盟")
	SendGuildList(human)
end

function AllianceAgree(human, guildname, agree)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if guildname == human.m_db.guildname then
		human:SendTipsMsg(1, "无法同意自己的行会")
		return
	end
	if not GuildList[human.m_db.guildname] or not GuildList[guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local otherGuild = GuildList[guildname]
	local mymember = guild.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_MANAGER then
		human:SendTipsMsg(1, "你没有相应权限,无法同意")
		return
	end
	if guild.alliance[guildname] ~= 2 then
		human:SendTipsMsg(1, "该行会不在结盟列表")
		return
	end
	if agree == 1 then
		guild.alliance[guildname] = 1
		guild.funds = guild.funds + guild.alliancefunds[guildname]
		guild.alliancefunds[guildname] = nil
		guild.alliancetime[guildname] = nil
		guild.record[#guild.record+1] = {行会定义.GUILD_LOG_ALLIANCEAGREE,os.time(),guildname}
		guild:Save()
		otherGuild.record[#otherGuild.record+1] = {行会定义.GUILD_LOG_BEALLIANCEAGREE,os.time(),human.m_db.guildname}
		otherGuild:Save()
		human:SendTipsMsg(1, "#cff00,成功同意行会结盟")
		SendGuildRecord(human, 2)
	else
		otherGuild.funds = otherGuild.funds + guild.alliancefunds[guildname]
		otherGuild.record[#otherGuild.record+1] = {行会定义.GUILD_LOG_BEALLIANCEREFUSE,os.time(),human.m_db.guildname}
		otherGuild:Save()
		guild.alliance[guildname] = nil
		guild.alliancefunds[guildname] = nil
		guild.alliancetime[guildname] = nil
		guild.record[#guild.record+1] = {行会定义.GUILD_LOG_ALLIANCEREFUSE,os.time(),guildname}
		guild:Save()
		human:SendTipsMsg(1, "#cffff00,你拒绝了行会结盟")
		SendGuildRecord(human, 2)
	end
end

function DonateGuild(human, funds, normb)
	if funds <= 0 then
		human:SendTipsMsg(1, "请输入贡献资金")
		return
	end
	if not normb and human.m_db.rmb < funds then
		human:SendTipsMsg(1, "元宝不足")
		return
	end
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local member = guild.member[human:GetName()]
	if not member then
		human:SendTipsMsg(1, "成员不存在")
		return
	end
	member[2] = member[2] + funds
	guild.funds = guild.funds + funds
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_DONATE,os.time(),human:GetName(),funds}
	guild:Save()
	if not normb then
		human:DecRmb(funds)
		human:SendTipsMsg(1, "#cff00,成功捐献#cffff00,"..funds.."元宝")
	else
		human:SendTipsMsg(1, "#cff00,成功增加#cffff00,"..funds.."行会贡献")
	end
	SendGuildMember(human)
	return true
end

function LevelUpGuild(human)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local member = guild.member[human:GetName()]
	if not member or member[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法升级")
		return
	end
	local upfunds = math.pow(2,guild.level)*10000
	if guild.funds < upfunds then
		human:SendTipsMsg(1, "行会资金不足")
		return
	end
	guild.funds = guild.funds - upfunds
	guild.level = guild.level + 1
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_LEVELUP,os.time(),human:GetName(),guild.level}
	guild:Save()
	human:SendTipsMsg(1, "#cff00,成功升级行会")
	SendGuildMember(human)
	return true
end

function AttackCastle(human, castleid)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local guild = GuildList[human.m_db.guildname]
	local member = guild.member[human:GetName()]
	if not member or member[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法申请")
		return
	end
	if 公共定义.祖玛头像ID ~= 0 and 背包DB.CheckCount(human, 公共定义.祖玛头像ID) < 1 then
		human:SendTipsMsg(1,"祖玛头像数量不足")
		return
	end
	if not 城堡管理.AddAttackGuild(human, human.m_db.guildname, castleid) then
		return
	end
	if 公共定义.祖玛头像ID ~= 0 then
		背包DB.RemoveCount(human, 公共定义.祖玛头像ID, 1)
	end
	local castleGuild = 城堡管理.GetCastleGuild(castleid)
	guild.record[#guild.record+1] = {行会定义.GUILD_LOG_ATTACKCASTLE,os.time(),castleGuild,castleid}
	guild:Save()
	local otherGuild = castleGuild and GuildList[castleGuild]
	if otherGuild then
		otherGuild.record[#otherGuild.record+1] = {行会定义.GUILD_LOG_BEATTACKCASTLE,os.time(),human.m_db.guildname,castleid}
		otherGuild:Save()
	end
	human:SendTipsMsg(1, "#cff00,成功申请攻城")
	SendCastleInfo(human)
	return true
end

function AttackMap(human)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if not 城堡管理.MoveAttackMap(human, human.m_db.guildname) then
		return
	end
	return true
end

function ChallengeMap(human)
	if human.m_db.guildname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not GuildList[human.m_db.guildname] then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if 公共定义.行会挑战地图 == 0 then
		human:SendTipsMsg(1, "行会挑战地图暂未开放")
	end
	if human.m_nSceneID ~= -1 and 场景管理.IsCopyscene(human.m_nSceneID) then
		human:SendTipsMsg(1,"你已在副本中,请先退出")
		return
	end
	if not GetChallengeGuild(human.m_db.guildname) then
		human:SendTipsMsg(1, "找不到敌对行会")
	end
	human:RandomTransport(公共定义.行会挑战地图)
	return true
end

function SendCastleInfo(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_GUILD_CASTLEINFO]
	returnMsg.infoLen = 0
	for k,v in pairs(城堡管理.CastleList) do
		if returnMsg.infoLen >= 10 then
			break
		else
			returnMsg.infoLen = returnMsg.infoLen + 1
			returnMsg.info[returnMsg.infoLen].castleid = v.castleid
			returnMsg.info[returnMsg.infoLen].guildname = v.guild
			for ii,vv in ipairs(v.unionguild) do
				returnMsg.info[returnMsg.infoLen].guildname = returnMsg.info[returnMsg.infoLen].guildname.."、"..vv
			end
			returnMsg.info[returnMsg.infoLen].attackguild = ""
			for ii,vv in ipairs(v.attackguild) do
				returnMsg.info[returnMsg.infoLen].attackguild = returnMsg.info[returnMsg.infoLen].attackguild..(ii==1 and vv or "、"..vv)
			end
			if v.attacktime == 0 then
				returnMsg.info[returnMsg.infoLen].daytime = 0
			else
				local dt1 = os.date("*t")
				local dt2 = os.date("*t", v.attacktime)
				local yunyear = false
				if dt2.year % 100 == 0 then
					yunyear = dt2.year % 400 == 0
				else
					yunyear = dt2.year % 4 == 0
				end
				returnMsg.info[returnMsg.infoLen].daytime = dt1.yday + (dt1.year-dt2.year)*(yunyear and 366 or 365) - dt2.yday
			end
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end
