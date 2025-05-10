module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 排行榜逻辑 = require("排行榜.排行榜逻辑")

function CG_RANK_QUERY(oHuman, oMsg)
	排行榜逻辑.SendRankList(oHuman)
end

function CG_RANK_HERO_QUERY(oHuman, oMsg)
	排行榜逻辑.SendHeroRankList(oHuman)
end

function CG_RANK_PET_QUERY(oHuman, oMsg)
	排行榜逻辑.SendPetRankList(oHuman)
end

function CG_RANK_VIPSPREAD_QUERY(oHuman, oMsg)
	排行榜逻辑.SendVIPSpreadRankList(oHuman)
end
