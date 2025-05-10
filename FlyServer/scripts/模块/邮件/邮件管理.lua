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
local 邮件DB = require("行会.邮件DB").MailDB
local 背包DB = require("物品.背包DB")

MailList = MailList or {}

function Init()
    local pCursor = _Find(g_oMongoDB,"mail","{}")
    if not pCursor then
        return true
    end
    while true do
		local mail = 邮件DB:New()
		if not _NextCursor(pCursor,mail) then
			mail:Delete()
			break
		else
			MailList[#MailList+1] = mail
		end
    end
    return true
end

function AddMailInfo(mailname,name,zhanli,job,level,转生等级)
	if mailname == "" or not MailList[mailname] then
		return
	end
	local mail = MailList[mailname]
	local member = mail.member[name]
	if not member then
		return
	end
	mail.zhanli = mail.zhanli - member[3]
	member[3] = zhanli or 0
	member[4] = job or member[4]
	member[5] = level or member[5]
	member[6] = 转生等级 or member[6]
	mail.zhanli = mail.zhanli + (zhanli or 0)
	mail:Save()
	table.sort(MailSorts, CompareRanking)
end

function SendMailList(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_GUILD_LIST]
	returnMsg.infoLen = 0
	for i,v in ipairs(MailSorts) do
		if returnMsg.infoLen >= 100 then
			break
		else
			returnMsg.infoLen = returnMsg.infoLen + 1
			returnMsg.info[returnMsg.infoLen].ranking = i
			returnMsg.info[returnMsg.infoLen].mailname = v.name
			returnMsg.info[returnMsg.infoLen].chairman = v.chairman
			returnMsg.info[returnMsg.infoLen].level = v.level
			returnMsg.info[returnMsg.infoLen].number = v.num
			returnMsg.info[returnMsg.infoLen].zhanli = v.zhanli
			returnMsg.info[returnMsg.infoLen].funds = v.funds
			if human.m_db.mailname == "" then
				returnMsg.info[returnMsg.infoLen].status = human.m_db.mailapply[v.name] and 1 or 0
			elseif human.m_db.mailname == v.name then
				returnMsg.info[returnMsg.infoLen].status = 2
			elseif MailList[human.m_db.mailname] then
				local mail = MailList[human.m_db.mailname]
				returnMsg.info[returnMsg.infoLen].status = mail.challenge[v.name] and 3 or mail.alliance[v.name] and 4 or 5
			else
				human.m_db.mailname = ""
				returnMsg.info[returnMsg.infoLen].status = 0
			end
		end
	end
	消息类.SendMsg(returnMsg, human.id)
end

function SendMailMember(human)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_GUILD_MEMBER]
	returnMsg.mailLen = 0
	returnMsg.memberLen = 0
	if human.m_db.mailname ~= "" and not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
	end
	if human.m_db.mailname == "" then
		消息类.SendMsg(returnMsg, human.id)
		return
	end
	local mail = MailList[human.m_db.mailname]
	returnMsg.mailLen = 1
	returnMsg.mail[1].ranking = 0
	for i,v in ipairs(MailSorts) do
		if v == mail then
			returnMsg.mail[1].ranking = i
			break
		end
	end
	returnMsg.mail[1].mailname = mail.name
	returnMsg.mail[1].chairman = mail.chairman
	returnMsg.mail[1].level = mail.level
	returnMsg.mail[1].number = mail.num
	returnMsg.mail[1].zhanli = mail.zhanli
	returnMsg.mail[1].funds = mail.funds
	returnMsg.mail[1].status = 2
	for k,v in pairs(mail.member) do
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

function SendMailRecord(human, type)
	local returnMsg = 派发器.ProtoContainer[协议ID.GC_GUILD_RECORD]
	returnMsg.infoLen = 0
	if human.m_db.mailname ~= "" and not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
	end
	if human.m_db.mailname == "" then
		消息类.SendMsg(returnMsg, human.id)
		return
	end
	local mail = MailList[human.m_db.mailname]
	local curtime = os.time()
	if type == 2 then
		local member = mail.member[human:GetName()]
		if member and member[1] >= 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
			for k,v in pairs(mail.challenge) do
				if returnMsg.infoLen >= 100 then
					break
				elseif v == 2 then
					returnMsg.infoLen = returnMsg.infoLen + 1
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..k.."#C申请对你的行会发起挑战,挑战资金为#cffff00,"..(mail.challengefunds[k] or 0)
					returnMsg.info[returnMsg.infoLen].time = curtime - (mail.challengetime[k] or curtime)
					returnMsg.info[returnMsg.infoLen].rolename = k
					returnMsg.info[returnMsg.infoLen].type = 1
				end
			end
			for k,v in pairs(mail.alliance) do
				if returnMsg.infoLen >= 100 then
					break
				elseif v == 2 then
					returnMsg.infoLen = returnMsg.infoLen + 1
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..k.."#C申请和你的行会结为同盟,结盟资金为#cffff00,2000"..(mail.alliancefunds[k] or 0)
					returnMsg.info[returnMsg.infoLen].time = curtime - (mail.alliancetime[k] or curtime)
					returnMsg.info[returnMsg.infoLen].rolename = k
					returnMsg.info[returnMsg.infoLen].type = 2
				end
			end
		end
		if member and member[1] >= 行会定义.GUILD_ZHIWEI_MANAGER then
			for k,v in pairs(mail.apply) do
				if returnMsg.infoLen >= 100 then
					break
				elseif v == 1 then
					returnMsg.infoLen = returnMsg.infoLen + 1
					returnMsg.info[returnMsg.infoLen].record = "#cffff00,"..k.."#C申请加入你的行会"
					returnMsg.info[returnMsg.infoLen].time = curtime - (mail.challengetime[k] or curtime)
					returnMsg.info[returnMsg.infoLen].rolename = k
					returnMsg.info[returnMsg.infoLen].type = 0
				end
			end
		end
	elseif type == 1 then
		for i=#mail.record,1,-1 do
			local v = mail.record[i]
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
		for i=#mail.record,1,-1 do
			local v = mail.record[i]
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

function CreateMail(human, mailname)
	if human.m_db.mailname ~= "" then
		human:SendTipsMsg(1, "你已经有行会了")
		return
	end
	if human:GetMoney(true) < 1000000 then
		human:SendTipsMsg(1, "金币不足")
		return
	end
	if mailname == "" or mailname:find(" ") or mailname:find("　") or mailname:find("%.") or mailname=="无" then
		human:SendTipsMsg(1, "请输入有效行会名")
		return
	end
	if tonumber(mailname) ~= nil then
		human:SendTipsMsg(1, "行会名称不能全为数字")
		return
	end
	if MailList[mailname] then
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
	local mail = 邮件DB:New()
	mail.name = mailname
	mail.chairman = human:GetName()
	mail.zhanli = human:CalcPower()
	mail.member[human:GetName()] = {行会定义.GUILD_ZHIWEI_CHAIRMAN,0,mail.zhanli,human.m_db.job,human:GetLevel(),human.m_db.转生等级}
	mail.num = 1
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_CREATE,os.time(),human:GetName()}
	mail:Add()
	MailSorts[#MailSorts+1] = mail
	MailList[mail.name] = mail
	table.sort(MailSorts, CompareRanking)
	human.m_db.mailname = mailname
	human:SendTipsMsg(1, "#cff00,成功创建行会")
	SendMailList(human)
	human:ChangeName()
	human:UpdateObjInfo()
end

function LeaveMail(human)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	if mail.chairman == human:GetName() then--and mail.num > 1 then
		human:SendTipsMsg(1, "你是会长,无法退出行会")
		return
	end
	local member = mail.member[human:GetName()]
	if not member then
		human:SendTipsMsg(1, "成员不存在")
		return
	end
	mail.zhanli = mail.zhanli - member[3]
	mail.member[human:GetName()] = nil
	mail.num = mail.num - 1
	--if mail.num == 0 then
	--	mail:Delete()
	--	MailList[human.m_db.mailname] = nil
	--else
		mail.record[#mail.record+1] = {行会定义.GUILD_LOG_LEAVE,os.time(),human:GetName()}
		mail:Save()
		table.sort(MailSorts, CompareRanking)
	--end
	human.m_db.mailname = ""
	human:SendTipsMsg(1, "#cffff00,成功退出行会")
	SendMailMember(human)
	human:ChangeName()
	human:UpdateObjInfo()
end

function KickMember(human, rolename)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if rolename == human:GetName() then
		human:SendTipsMsg(1, "你无法踢出自己")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local mymember = mail.member[human:GetName()]
	local member = mail.member[rolename]
	if not mymember or not member or mymember[1] <= member[1] then
		human:SendTipsMsg(1, "你没有相应权限,无法踢出")
		return
	end
	mail.zhanli = mail.zhanli - member[3]
	mail.member[rolename] = nil
	mail.num = mail.num - 1
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_KICK,os.time(),human:GetName(),rolename}
	mail:Save()
	table.sort(MailSorts, CompareRanking)
	local kickhuman = 在线玩家管理[rolename]
	if kickhuman then
		kickhuman.m_db.mailname = ""
		kickhuman:SendTipsMsg(1, "#cffff00,你被踢出行会")
		SendMailMember(kickhuman)
		kickhuman:ChangeName()
		kickhuman:UpdateObjInfo()
	end
	human:SendTipsMsg(1, "#cffff00,成功踢出行会")
	SendMailMember(human)
end

function AdjustMember(human, rolename, zhiwei)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if rolename == human:GetName() then
		human:SendTipsMsg(1, "你无法调整自己")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local mymember = mail.member[human:GetName()]
	local member = mail.member[rolename]
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
		mail.chairman = rolename
	else
		member[1] = zhiwei
	end
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_ADJUST,os.time(),human:GetName(),rolename,oldzhiwei,zhiwei}
	mail:Save()
	local adjusthuman = 在线玩家管理[rolename]
	if adjusthuman then
		adjusthuman:SendTipsMsg(1, "#cffff00,你的行会职位被调整为#cff00,"..(行会定义.ZHIWEI_NAME[zhiwei] or "其他"))
		SendMailMember(adjusthuman)
	end
	human:SendTipsMsg(1, "#cffff00,成功调整职位")
	SendMailMember(human)
end

function ApplyMail(human, mailname)
	if human.m_db.mailname ~= "" then
		human:SendTipsMsg(1, "你已经有行会了")
		return
	end
	if not MailList[mailname] then
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if human.m_db.mailapply[mailname] then
		human:SendTipsMsg(1, "你已经申请过了")
		return
	end
	local mail = MailList[mailname]
	mail.apply[human:GetName()] = 1
	mail:Save()
	human.m_db.mailapply[mailname] = 1
	human:SendTipsMsg(1, "#cffff00,成功申请加入行会")
	SendMailList(human)
end

function ApplyAgree(human, rolename, agree)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if rolename == human:GetName() then
		human:SendTipsMsg(1, "你无法同意自己")
		return
	end
	local mail = MailList[human.m_db.mailname]
	if mail.apply[rolename] ~= 1 then
		human:SendTipsMsg(1, "该玩家不在申请列表")
		return
	end
	if mail.member[rolename] then
		human:SendTipsMsg(1, "该玩家已是行会成员")
		return
	end
	local mymember = mail.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_MANAGER then
		human:SendTipsMsg(1, "你没有相应权限,无法同意")
		return
	end
	if agree == 1 then
		mail.apply[rolename] = 2
		mail.record[#mail.record+1] = {行会定义.GUILD_LOG_APPLYAGREE,os.time(),human:GetName(),rolename}
		mail:Save()
		human:SendTipsMsg(1, "#cff00,成功同意玩家申请")
		SendMailRecord(human, 2)
	else
		mail.apply[rolename] = nil
		mail.record[#mail.record+1] = {行会定义.GUILD_LOG_APPLYREFUSE,os.time(),human:GetName(),rolename}
		mail:Save()
		human:SendTipsMsg(1, "#cffff00,你拒绝了玩家申请")
		SendMailRecord(human, 2)
	end
	local applyhuman = 在线玩家管理[rolename]
	if applyhuman then
		if mail.apply[rolename] == 2 then
			local zhanli = applyhuman:CalcPower()
			mail.apply[rolename] = nil
			mail.zhanli = mail.zhanli + zhanli
			mail.member[rolename] = {行会定义.GUILD_ZHIWEI_MEMBER,0,zhanli,applyhuman.m_db.job,applyhuman:GetLevel(),applyhuman.m_db.转生等级}
			mail.num = mail.num + 1
			mail:Save()
			table.sort(MailSorts, CompareRanking)
			applyhuman.m_db.mailapply[human.m_db.mailname] = nil
			for k,v in pairs(applyhuman.m_db.mailapply) do
				local g = MailList[k]
				if g then
					g.apply[rolename] = nil
					g:Save()
				end
			end
			applyhuman.m_db.mailapply = {}
			applyhuman.m_db.mailname = human.m_db.mailname
			applyhuman:SendTipsMsg(1, "#cff00,你的行会申请已经通过")
			applyhuman:ChangeName()
			applyhuman:UpdateObjInfo()
		else
			applyhuman.m_db.mailapply[human.m_db.mailname] = nil
			applyhuman:SendTipsMsg(1, "#cffff00,你的行会申请已被拒绝")
		end
	end
end

function ChallengeMail(human, mailname, funds)
	if funds <= 0 then
		human:SendTipsMsg(1, "请输入挑战资金")
		return
	end
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if mailname == human.m_db.mailname then
		human:SendTipsMsg(1, "无法挑战自己的行会")
		return
	end
	if not MailList[human.m_db.mailname] or not MailList[mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local otherMail = MailList[mailname]
	local mymember = mail.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法挑战")
		return
	end
	if mail.alliance[mailname] then
		human:SendTipsMsg(1, "联盟行会无法发起挑战")
		return
	end
	if mail.challenge[mailname] == 2 then
		human:SendTipsMsg(1, "该行会已对你发起了挑战")
		return
	end
	if mail.challenge[mailname] == 1 then
		human:SendTipsMsg(1, "已经发起对该行会的挑战")
		return
	end
	if mail.funds < funds then
		human:SendTipsMsg(1, "挑战资金不足")
		return
	end
	mail.funds = mail.funds - funds
	mail.challenge[mailname] = 1
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_CHALLENGE,os.time(),mailname,funds}
	mail:Save()
	otherMail.challenge[human.m_db.mailname] = 2
	otherMail.challengefunds[human.m_db.mailname] = funds
	otherMail.challengetime[human.m_db.mailname] = os.time()
	otherMail.record[#otherMail.record+1] = {行会定义.GUILD_LOG_BECHALLENGE,os.time(),human.m_db.mailname,funds}
	otherMail:Save()
	human:SendTipsMsg(1, "#cffff00,成功对行会发起挑战")
	SendMailList(human)
end

function GetChallengeMail(mailname)
	if not MailList[mailname] then
		return
	end
	local mail = MailList[mailname]
	for k,v in pairs(mail.challenge) do
		if v == 1 then
			local otherMail = MailList[k]
			if otherMail and otherMail.challenge[mailname] == 1 then
				return k
			end
		end
	end
end

function IsChallengeMail(mailname1,mailname2)
	if GetChallengeMail(mailname1) == mailname2 then
		return true
	end
	local castleid1 = 城堡管理.AttackMail[mailname1]
	local castleid2 = 城堡管理.AttackMail[mailname2]
	if castleid1 and castleid1 and not IsAllianceMail(mailname1, mailname2) then
		return true
	end
	return false
end

function ChallengeAgree(human, mailname, agree)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if mailname == human.m_db.mailname then
		human:SendTipsMsg(1, "无法同意自己的行会")
		return
	end
	if not MailList[human.m_db.mailname] or not MailList[mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local otherMail = MailList[mailname]
	local mymember = mail.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_MANAGER then
		human:SendTipsMsg(1, "你没有相应权限,无法同意")
		return
	end
	if mail.challenge[mailname] ~= 2 then
		human:SendTipsMsg(1, "该行会不在挑战列表")
		return
	end
	if GetChallengeMail(human.m_db.mailname) then
		human:SendTipsMsg(1, "你已经同意了其他行会的挑战")
		return
	end
	if agree == 1 then
		mail.challenge[mailname] = 1
		mail.record[#mail.record+1] = {行会定义.GUILD_LOG_CHALLENGEAGREE,os.time(),mailname}
		mail:Save()
		otherMail.record[#otherMail.record+1] = {行会定义.GUILD_LOG_BECHALLENGEAGREE,os.time(),human.m_db.mailname}
		otherMail:Save()
		human:SendTipsMsg(1, "#cff00,成功同意行会挑战")
		SendMailRecord(human, 2)
	else
		otherMail.funds = otherMail.funds + mail.challengefunds[mailname]
		otherMail.record[#otherMail.record+1] = {行会定义.GUILD_LOG_BECHALLENGEREFUSE,os.time(),human.m_db.mailname}
		otherMail:Save()
		mail.challenge[mailname] = nil
		mail.challengefunds[mailname] = nil
		mail.challengetime[mailname] = nil
		mail.record[#mail.record+1] = {行会定义.GUILD_LOG_CHALLENGEREFUSE,os.time(),mailname}
		mail:Save()
		human:SendTipsMsg(1, "#cffff00,你拒绝了行会挑战")
		SendMailRecord(human, 2)
	end
end

function IsAllianceMail(mailname1, mailname2)
	if not MailList[mailname1] or not MailList[mailname2] then
		return false
	end
	local mail1 = MailList[mailname1]
	local mail2 = MailList[mailname2]
	if mail1.alliance[mailname2] == 1 and mail2.alliance[mailname1] == 1 then
		return true
	else
		return false
	end
end

function AllianceMail(human, mailname, funds)
	if funds <= 0 then
		human:SendTipsMsg(1, "请输入结盟资金")
		return
	end
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if mailname == human.m_db.mailname then
		human:SendTipsMsg(1, "无法结盟自己的行会")
		return
	end
	if not MailList[human.m_db.mailname] or not MailList[mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local otherMail = MailList[mailname]
	local mymember = mail.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法结盟")
		return
	end
	if mail.challenge[mailname] then
		human:SendTipsMsg(1, "已经发起挑战的行会无法结盟")
		return
	end
	if mail.alliance[mailname] then
		human:SendTipsMsg(1, "联盟行会无法再次结盟")
		return
	end
	if mail.funds < funds then
		human:SendTipsMsg(1, "结盟资金不足")
		return
	end
	mail.funds = mail.funds - funds
	mail.alliance[mailname] = 1
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_ALLIANCE,os.time(),mailname,funds}
	mail:Save()
	otherMail.alliance[human.m_db.mailname] = 2
	otherMail.alliancefunds[human.m_db.mailname] = funds
	otherMail.alliancetime[human.m_db.mailname] = os.time()
	otherMail.record[#otherMail.record+1] = {行会定义.GUILD_LOG_BEALLIANCE,os.time(),human.m_db.mailname,funds}
	otherMail:Save()
	human:SendTipsMsg(1, "#cffff00,成功对行会发起结盟")
	SendMailList(human)
end

function AllianceAgree(human, mailname, agree)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if mailname == human.m_db.mailname then
		human:SendTipsMsg(1, "无法同意自己的行会")
		return
	end
	if not MailList[human.m_db.mailname] or not MailList[mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local otherMail = MailList[mailname]
	local mymember = mail.member[human:GetName()]
	if not mymember or mymember[1] < 行会定义.GUILD_ZHIWEI_MANAGER then
		human:SendTipsMsg(1, "你没有相应权限,无法同意")
		return
	end
	if mail.alliance[mailname] ~= 2 then
		human:SendTipsMsg(1, "该行会不在结盟列表")
		return
	end
	if agree == 1 then
		mail.alliance[mailname] = 1
		mail.funds = mail.funds + mail.alliancefunds[mailname]
		mail.alliancefunds[mailname] = nil
		mail.alliancetime[mailname] = nil
		mail.record[#mail.record+1] = {行会定义.GUILD_LOG_ALLIANCEAGREE,os.time(),mailname}
		mail:Save()
		otherMail.record[#otherMail.record+1] = {行会定义.GUILD_LOG_BEALLIANCEAGREE,os.time(),human.m_db.mailname}
		otherMail:Save()
		human:SendTipsMsg(1, "#cff00,成功同意行会结盟")
		SendMailRecord(human, 2)
	else
		otherMail.funds = otherMail.funds + mail.alliancefunds[mailname]
		otherMail.record[#otherMail.record+1] = {行会定义.GUILD_LOG_BEALLIANCEREFUSE,os.time(),human.m_db.mailname}
		otherMail:Save()
		mail.alliance[mailname] = nil
		mail.alliancefunds[mailname] = nil
		mail.alliancetime[mailname] = nil
		mail.record[#mail.record+1] = {行会定义.GUILD_LOG_ALLIANCEREFUSE,os.time(),mailname}
		mail:Save()
		human:SendTipsMsg(1, "#cffff00,你拒绝了行会结盟")
		SendMailRecord(human, 2)
	end
end

function DonateMail(human, funds, normb)
	if funds <= 0 then
		human:SendTipsMsg(1, "请输入贡献资金")
		return
	end
	if not normb and human.m_db.rmb < funds then
		human:SendTipsMsg(1, "元宝不足")
		return
	end
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local member = mail.member[human:GetName()]
	if not member then
		human:SendTipsMsg(1, "成员不存在")
		return
	end
	member[2] = member[2] + funds
	mail.funds = mail.funds + funds
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_DONATE,os.time(),human:GetName(),funds}
	mail:Save()
	if not normb then
		human:DecRmb(funds)
		human:SendTipsMsg(1, "#cff00,成功捐献#cffff00,"..funds.."元宝")
	else
		human:SendTipsMsg(1, "#cff00,成功增加#cffff00,"..funds.."行会贡献")
	end
	SendMailMember(human)
	return true
end

function LevelUpMail(human)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local member = mail.member[human:GetName()]
	if not member or member[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法升级")
		return
	end
	local upfunds = math.pow(2,mail.level)*10000
	if mail.funds < upfunds then
		human:SendTipsMsg(1, "行会资金不足")
		return
	end
	mail.funds = mail.funds - upfunds
	mail.level = mail.level + 1
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_LEVELUP,os.time(),human:GetName(),mail.level}
	mail:Save()
	human:SendTipsMsg(1, "#cff00,成功升级行会")
	SendMailMember(human)
	return true
end

function AttackCastle(human, castleid)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	local mail = MailList[human.m_db.mailname]
	local member = mail.member[human:GetName()]
	if not member or member[1] < 行会定义.GUILD_ZHIWEI_VICE_CHAIRMAN then
		human:SendTipsMsg(1, "你没有相应权限,无法申请")
		return
	end
	if 公共定义.祖玛头像ID ~= 0 and 背包DB.CheckCount(human, 公共定义.祖玛头像ID) < 1 then
		human:SendTipsMsg(1,"祖玛头像数量不足")
		return
	end
	if not 城堡管理.AddAttackMail(human, human.m_db.mailname, castleid) then
		return
	end
	if 公共定义.祖玛头像ID ~= 0 then
		背包DB.RemoveCount(human, 公共定义.祖玛头像ID, 1)
	end
	local castleMail = 城堡管理.GetCastleMail(castleid)
	mail.record[#mail.record+1] = {行会定义.GUILD_LOG_ATTACKCASTLE,os.time(),castleMail,castleid}
	mail:Save()
	local otherMail = castleMail and MailList[castleMail]
	if otherMail then
		otherMail.record[#otherMail.record+1] = {行会定义.GUILD_LOG_BEATTACKCASTLE,os.time(),human.m_db.mailname,castleid}
		otherMail:Save()
	end
	human:SendTipsMsg(1, "#cff00,成功申请攻城")
	SendCastleInfo(human)
	return true
end

function AttackMap(human)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
		human:SendTipsMsg(1, "行会不存在")
		return
	end
	if not 城堡管理.MoveAttackMap(human, human.m_db.mailname) then
		return
	end
	return true
end

function ChallengeMap(human)
	if human.m_db.mailname == "" then
		human:SendTipsMsg(1, "你还没有行会")
		return
	end
	if not MailList[human.m_db.mailname] then
		human.m_db.mailname = ""
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
	if not GetChallengeMail(human.m_db.mailname) then
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
			returnMsg.info[returnMsg.infoLen].mailname = v.mail
			for ii,vv in ipairs(v.unionmail) do
				returnMsg.info[returnMsg.infoLen].mailname = returnMsg.info[returnMsg.infoLen].mailname.."、"..vv
			end
			returnMsg.info[returnMsg.infoLen].attackmail = ""
			for ii,vv in ipairs(v.attackmail) do
				returnMsg.info[returnMsg.infoLen].attackmail = returnMsg.info[returnMsg.infoLen].attackmail..(ii==1 and vv or "、"..vv)
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
