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
local 宠物排行DB = require("排行榜.宠物排行DB").RankingDB

rankingsorts = rankingsorts or {}
rankingnames = rankingnames or {}

function Init()
    local pCursor = _Find(g_oMongoDB,"petranking","{}")
    if not pCursor then
        return true
    end
    while true do
		local ranking = 宠物排行DB:New()
		if not _NextCursor(pCursor,ranking) then
			ranking:Delete()
			break
		else
			rankingsorts[#rankingsorts+1] = ranking
			rankingnames[ranking.belong..ranking.index] = ranking
		end
    end
	table.sort(rankingsorts, CompareRanking)
    return true
end

function CompareRanking(first,second)
	if first.power ~= second.power then return first.power>second.power end
	if first.belong..first.index ~= second.belong..second.index then
		return first.belong..first.index>second.belong..second.index
	end
end

function UpdatePower(name,belong,index,power,starlevel,level)
	local ranking = rankingnames[belong..index]
	if ranking then
		ranking.name = name
		ranking.power = power
		ranking.starlevel = starlevel
		ranking.level = level
		ranking:Save()
	else
		ranking = 宠物排行DB:New()
		ranking.name = name
		ranking.belong = belong
		ranking.index = index
		ranking.power = power
		ranking.starlevel = starlevel
		ranking.level = level
		ranking:Add()
		rankingsorts[#rankingsorts+1] = ranking
		rankingnames[belong..index] = ranking
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
