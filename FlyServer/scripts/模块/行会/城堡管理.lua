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
local 城堡DB = require("行会.城堡DB").CastleDB
local 行会管理 = require("行会.行会管理")

CastleList = CastleList or {}
ForbidMapID = ForbidMapID or {}
AttackGuild = AttackGuild or {}

function Init()
    local pCursor = _Find(g_oMongoDB,"castle","{}")
    if pCursor then
		while true do
			local castle = 城堡DB:New()
			if not _NextCursor(pCursor,castle) then
				castle:Delete()
				break
			else
				CastleList[castle.castleid] = castle
			end
		end
    end
	for k,v in pairs(公共定义.城堡定义) do
		InitCastle(k, v[1], v[2], v[3])
	end
    return true
end

function InitCastle(castleid, name, mapid, maparea)
	local castle = CastleList[castleid]
	if castle == nil then
		castle = 城堡DB:New()
		castle.name = name
		castle.castleid = castleid
		castle.mapid = mapid
		castle.maparea = maparea
		castle:Add()
		CastleList[castle.castleid] = castle
	else
		castle.name = name
		castle.mapid = mapid
		castle.maparea = maparea
		castle:Save()
	end
end

function 城堡经验极品率(human)
	if Config.ISLT then
		return 1
	end
	if human.m_db.guildname == "" then
		return 1
	end
	local castle = nil
	for k,v in pairs(CastleList) do
		if v.guild == human.m_db.guildname then
			castle = v
			break
		end
	end
	if not castle then
		return 1
	end
	local maptype = 0
	if human.m_db.mapid > 1000 then
		maptype = math.floor(human.m_db.mapid / 1000)
	else
		maptype = math.floor(human.m_db.mapid / 100)
	end
	if castle.castleid == 1 then
		if maptype == 1 or maptype == 2 or maptype == 7 or maptype == 8 then
			return 1.1
		end
	elseif castle.castleid == 2 then
		if maptype == 5 then
			return 1.1
		end
	elseif castle.castleid == 3 then
		if maptype == 4 or maptype == 6 then
			return 1.1
		end
	end
	return 1
end

function GetCastleGuildName(guildname)
	if guildname == "" then return "" end
	for k,v in pairs(CastleList) do
		if v.guild == guildname then
			return "["..v.name.."]"
		end
	end
	return ""
end

function AddAttackGuild(human, guildname, castleid)
	local castle = CastleList[castleid]
	if not castle then
		human:SendTipsMsg(1,"找不到指定城堡")
		return
	end
	if castle.guild == guildname then
		human:SendTipsMsg(1,"你的行会已是城堡主人")
		return
	end
	if 实用工具.FindIndex(castle.attackguild,guildname) then
		human:SendTipsMsg(1,"你的行会已经申请了攻城")
		return
	end
	if 实用工具.FindIndex(castle.unionguild,guildname) then
		human:SendTipsMsg(1,"你的行会已经申请了守城")
		return
	end
	if castle.guild ~= "" then
		if 行会管理.IsAllianceGuild(castle.guild, guildname) then
			castle.unionguild[#castle.unionguild] = guildname
		elseif #castle.attackguild >= 1 and not 行会管理.IsAllianceGuild(castle.guild, guildname) then
			human:SendTipsMsg(1,"已经有行会申请了攻城")
			return
		else
			castle.attackguild[#castle.attackguild+1] = guildname
		end
	else
		castle.attackguild[#castle.attackguild+1] = guildname
	end
	if castle.attacktime == 0 then
		castle.attacktime = os.time()+3600*24
	else
		local isoneday = 实用工具.IsInOneDay(castle.attacktime)
		if isoneday then
			human:SendTipsMsg(1,"今日攻城报名结束无法申请")
			return
		end
		if os.time() > castle.attacktime then
			castle.attacktime = os.time()+3600*24
		end
	end
	for k,v in pairs(CastleList) do
		if v.castleid ~= castle.castleid then
			local index1 = 实用工具.FindIndex(v.unionguild,guildname)
			if index1 then
				table.remove(v.unionguild, index1)
				break
			end
			local index2 = 实用工具.FindIndex(v.attackguild,guildname)
			if index2 then
				table.remove(v.attackguild, index2)
				break
			end
			if v.guild == guildname then
				v.guild = ""
				for ii,vv in ipairs(v.unionguild) do
					v.attackguild[#v.attackguild+1] = vv
				end
				实用工具.DeleteTable(v.unionguild)
			end
			if #v.attackguild == 0 then
				v.attacktime = 0
			end
			v:Save()
		end
	end
	castle:Save()
	return true
end

function MoveAttackMap(human, guildname, checkmap)
	local castle = nil
	for k,v in pairs(CastleList) do
		if v.guild == guildname or 实用工具.FindIndex(v.attackguild,guildname) then
			castle = v
			break
		end
	end
	if not castle then
		human:SendTipsMsg(1,"你的行会不在攻城或守城列表")
		return
	end
	local isoneday = 实用工具.IsInOneDay(castle.attacktime)
	if not isoneday then
		human:SendTipsMsg(1,"今日不是攻城日期")
		return
	end
	local dt = os.date("*t")
	local mintime1 = dt.hour * 60 + dt.min
	local mintime2 = 公共定义.攻城时间[1] * 60 + 公共定义.攻城时间[2]
	if mintime1 < mintime2 or mintime1 > mintime2 + 公共定义.攻城时间[3] then
	--if dt.hour ~= 公共定义.攻城时间[1] or dt.min < 公共定义.攻城时间[2] or dt.min > 公共定义.攻城时间[2] + 公共定义.攻城时间[3] then
		human:SendTipsMsg(1,"现在不是攻城时间")
		return
	end
	if checkmap then
		local x,y = human:GetPosition()
		return human.m_db.mapid == castle.maparea[1] and
			x >= castle.maparea[2]-castle.maparea[4] and x <= castle.maparea[2]+castle.maparea[4] and
			y >= castle.maparea[3]-castle.maparea[4] and y <= castle.maparea[3]+castle.maparea[4]
	else
		return human:Transport(castle.maparea[1],
			castle.maparea[2]+math.random(-castle.maparea[4],castle.maparea[4]),
			castle.maparea[3]+math.random(-castle.maparea[4],castle.maparea[4]))
	end
end

function GetCastleGuild(castleid)
	local castle = CastleList[castleid]
	if castle then
		return castle.guild
	end
end

function GetCastleName(castleid)
	local castle = CastleList[castleid]
	if castle then
		return castle.name
	end
end

function GetCastleMapID(castleid)
	local castle = CastleList[castleid]
	if castle then
		return castle.mapid
	end
end

function GetCastleMapArea(castleid)
	local castle = CastleList[castleid]
	if castle then
		return castle.maparea
	end
end

function UpdateCastle(castleid,guild,unionguild,attackguild,attacktime,level)
	local castle = CastleList[castleid]
	if castle then
		castle.guild = guild
		castle.unionguild = unionguild
		castle.attackguild = attackguild
		castle.attacktime = attacktime
		castle.level = level
		castle:Save()
	end
end

function DelAll()
	for k,v in pairs(CastleList) do
		v:Delete()
	end
	CastleList = {}
end
