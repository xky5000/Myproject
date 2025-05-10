module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 日志 = require("公用.日志")
local 日志 = require("公用.日志")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 技能逻辑 = require("技能.技能逻辑")
local 技能表 = require("配置.技能表").Config
local Buff表 = require("配置.Buff表").Config
local 锻造逻辑 = require("锻造.锻造逻辑")

function CG_STRENGTHEN(oHuman, oMsg)
	锻造逻辑.DoStrengthen(oHuman, oMsg.contpos, oMsg.pos)
end

function CG_STRENGTHEN_TRANSFER(oHuman, oMsg)
	锻造逻辑.DoStrengthenTransfer(oHuman, oMsg.contpos, oMsg.pos, oMsg.contposdst, oMsg.posdst)
end

function CG_REFINE_WASH(oHuman, oMsg)
	锻造逻辑.DoRefineWash(oHuman, oMsg.contpos, oMsg.pos, oMsg.lock)
end

function CG_REFINE_UPGRADE(oHuman, oMsg)
	锻造逻辑.DoRefineUpgrade(oHuman, oMsg.contpos, oMsg.pos)
end

function CG_EQUIP_PREVIEW(oHuman, oMsg)
end

function CG_PERFECT_PREVIEW(oHuman, oMsg)
	锻造逻辑.DoPerfectReview(oHuman, oMsg.contpos, oMsg.pos)
end

function CG_STRENGTHEN_ALL(oHuman, oMsg)
	锻造逻辑.DoStrengthenAll(oHuman, oMsg.contpos, oMsg.pos, oMsg.contposdst, oMsg.posdst, oMsg.contposnxt, oMsg.posnxt)
end
