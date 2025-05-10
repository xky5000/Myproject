module(..., package.seeall)

local 排行榜UI = require("主界面.排行榜UI")

function GC_RANK_LIST(info,myinfo)
	排行榜UI.setInfo(info,myinfo)
end

function GC_RANK_PET_LIST(info,myinfo)
	排行榜UI.setPetInfo(info,myinfo)
end

function GC_RANK_HERO_LIST(info,myinfo)
	排行榜UI.setHeroInfo(info,myinfo)
end

function GC_RANK_VIPSPREAD_LIST(info,myinfo)
	排行榜UI.setVIPSpreadInfo(info,myinfo)
end

