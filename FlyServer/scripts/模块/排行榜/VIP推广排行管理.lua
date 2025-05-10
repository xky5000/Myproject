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
local VIP推广排行DB = require("排行榜.VIP推广排行DB").RankingDB

rankingsorts = rankingsorts or {}
rankingnames = rankingnames or {}

function Init()
    local pCursor = _Find(g_oMongoDB,"vipspreadranking","{}")
    if not pCursor then
        return true
    end
    while true do
		local ranking = VIP推广排行DB:New()
		if not _NextCursor(pCursor,ranking) then
			ranking:Delete()
			break
		else
			rankingsorts[#rankingsorts+1] = ranking
			rankingnames[ranking.name] = ranking
		end
    end
	table.sort(rankingsorts, CompareRanking)
    return true
end

function CompareRanking(first,second)
	if first.growexp ~= second.growexp then return first.growexp>second.growexp end
	if first.name ~= second.name then return first.name>second.name end
end

function UpdatePower(name,num,validnum,job,growexp,level)
	local ranking = rankingnames[name]
	if ranking then
		ranking.num = num
		ranking.validnum = validnum
		ranking.job = job
		ranking.growexp = growexp
		ranking.level = level
		ranking:Save()
	else
		ranking = VIP推广排行DB:New()
		ranking.name = name
		ranking.num = num
		ranking.validnum = validnum
		ranking.job = job
		ranking.growexp = growexp
		ranking.level = level
		ranking:Add()
		rankingsorts[#rankingsorts+1] = ranking
		rankingnames[name] = ranking
	end
	table.sort(rankingsorts, CompareRanking)
end

function DelAll()
	for i,v in ipairs(rankingsorts) do
		v:Delete()
	end
	rankingsorts = {}
	rankingnames = {}
end
