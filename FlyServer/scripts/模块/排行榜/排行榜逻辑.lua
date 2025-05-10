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
local 排行榜管理 = require("排行榜.排行榜管理")
local 英雄排行管理 = require("排行榜.英雄排行管理")
local 宠物排行管理 = require("排行榜.宠物排行管理")
local VIP推广排行管理 = require("排行榜.VIP推广排行管理")

function SendRankList(human)
	if human:GetLevel() < 35 then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_RANK_LIST]
	oReturnMsg.infoLen = 0
	local ranking = nil
	local rank = 0
	for i,v in ipairs(排行榜管理.rankingsorts) do
		if oReturnMsg.infoLen < 50 then
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			oReturnMsg.info[oReturnMsg.infoLen].rank = i
			oReturnMsg.info[oReturnMsg.infoLen].name = v.name
			oReturnMsg.info[oReturnMsg.infoLen].job = v.job
			oReturnMsg.info[oReturnMsg.infoLen].level = v.level
			oReturnMsg.info[oReturnMsg.infoLen].guild = v.guild
			oReturnMsg.info[oReturnMsg.infoLen].power = v.power
		end
		if v.name == human:GetName() then
			ranking = v
			rank = i
		end
	end
	if ranking and rank then
		oReturnMsg.myinfoLen = 1
		oReturnMsg.myinfo[1].rank = rank
		oReturnMsg.myinfo[1].name = ranking and ranking.name or ""
		oReturnMsg.myinfo[1].job = ranking and ranking.job or 0
		oReturnMsg.myinfo[1].level = ranking and ranking.level or 0
		oReturnMsg.myinfo[1].guild = ranking and ranking.guild or ""
		oReturnMsg.myinfo[1].power = ranking and ranking.power or 0
	else
		oReturnMsg.myinfoLen = 0
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendHeroRankList(human)
	if human:GetLevel() < 35 then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_RANK_HERO_LIST]
	oReturnMsg.infoLen = 0
	local ranking = nil
	local rank = 0
	for i,v in ipairs(英雄排行管理.rankingsorts) do
		if oReturnMsg.infoLen < 50 then
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			oReturnMsg.info[oReturnMsg.infoLen].rank = i
			oReturnMsg.info[oReturnMsg.infoLen].name = v.name
			oReturnMsg.info[oReturnMsg.infoLen].job = v.job
			oReturnMsg.info[oReturnMsg.infoLen].level = v.level
			oReturnMsg.info[oReturnMsg.infoLen].guild = v.guild
			oReturnMsg.info[oReturnMsg.infoLen].power = v.power
		end
		if v.name == human:GetName().."的英雄" then
			ranking = v
			rank = i
		end
	end
	if ranking and rank then
		oReturnMsg.myinfoLen = 1
		oReturnMsg.myinfo[1].rank = rank
		oReturnMsg.myinfo[1].name = ranking and ranking.name or ""
		oReturnMsg.myinfo[1].job = ranking and ranking.job or 0
		oReturnMsg.myinfo[1].level = ranking and ranking.level or 0
		oReturnMsg.myinfo[1].guild = ranking and ranking.guild or ""
		oReturnMsg.myinfo[1].power = ranking and ranking.power or 0
	else
		oReturnMsg.myinfoLen = 0
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendPetRankList(human)
	if human:GetLevel() < 35 then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_RANK_PET_LIST]
	oReturnMsg.infoLen = 0
	local ranking = nil
	local rank = 0
	local petpower = 0
	for i,v in ipairs(宠物排行管理.rankingsorts) do
		if oReturnMsg.infoLen < 50 then
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			oReturnMsg.info[oReturnMsg.infoLen].rank = i
			oReturnMsg.info[oReturnMsg.infoLen].name = v.name
			oReturnMsg.info[oReturnMsg.infoLen].starlevel = v.starlevel
			oReturnMsg.info[oReturnMsg.infoLen].level = v.level
			oReturnMsg.info[oReturnMsg.infoLen].belong = v.belong
			oReturnMsg.info[oReturnMsg.infoLen].power = v.power
		end
		if v.belong == human:GetName() and v.power > petpower then
			ranking = v
			rank = i
			petpower = v.power
		end
	end
	if ranking and rank then
		oReturnMsg.myinfoLen = 1
		oReturnMsg.myinfo[1].rank = rank
		oReturnMsg.myinfo[1].name = ranking and ranking.name or ""
		oReturnMsg.myinfo[1].starlevel = ranking and ranking.starlevel or 0
		oReturnMsg.myinfo[1].level = ranking and ranking.level or 0
		oReturnMsg.myinfo[1].belong = ranking and ranking.belong or ""
		oReturnMsg.myinfo[1].power = ranking and ranking.power or 0
	else
		oReturnMsg.myinfoLen = 0
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendVIPSpreadRankList(human)
	if human:GetLevel() < 35 then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_RANK_VIPSPREAD_LIST]
	oReturnMsg.infoLen = 0
	local ranking = nil
	local rank = 0
	for i,v in ipairs(VIP推广排行管理.rankingsorts) do
		if oReturnMsg.infoLen < 50 then
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			oReturnMsg.info[oReturnMsg.infoLen].rank = i
			oReturnMsg.info[oReturnMsg.infoLen].name = v.name
			oReturnMsg.info[oReturnMsg.infoLen].job = v.job
			oReturnMsg.info[oReturnMsg.infoLen].num = v.num
			oReturnMsg.info[oReturnMsg.infoLen].validnum = v.validnum
			oReturnMsg.info[oReturnMsg.infoLen].growexp = v.growexp
		end
		if v.name == human:GetName() then
			ranking = v
			rank = i
		end
	end
	if ranking and rank then
		oReturnMsg.myinfoLen = 1
		oReturnMsg.myinfo[1].rank = rank
		oReturnMsg.myinfo[1].name = ranking and ranking.name or ""
		oReturnMsg.myinfo[1].job = ranking and ranking.job or 0
		oReturnMsg.myinfo[1].num = ranking and ranking.num or 0
		oReturnMsg.myinfo[1].validnum = ranking and ranking.validnum or 0
		oReturnMsg.myinfo[1].growexp = ranking and ranking.growexp or 0
	else
		oReturnMsg.myinfoLen = 0
	end
	消息类.SendMsg(oReturnMsg, human.id)
end
