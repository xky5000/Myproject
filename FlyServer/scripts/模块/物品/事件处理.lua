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
local 背包逻辑 = require("物品.背包逻辑")
local 限时商店 = require("物品.限时商店")

function CG_BAG_QUERY(oHuman, oMsg)
	背包逻辑.SendBagQuery(oHuman)
end

function CG_BAG_REBUILD(oHuman, oMsg)
	背包逻辑.DoBagRebuild(oHuman)
end

function CG_BAG_DISCARD(oHuman, oMsg)
	背包逻辑.DoBagDiscard(oHuman, oMsg.pos)
end

function CG_BAG_SWAP(oHuman, oMsg)
	背包逻辑.DoBagSwap(oHuman, oMsg.pos, oMsg.posdst)
end

function CG_BAG_DIVIDE(oHuman, oMsg)
	背包逻辑.DoBagDivide(oHuman, oMsg.pos, oMsg.count)
end

function CG_ITEM_USE(oHuman, oMsg)
	背包逻辑.DoItemUse(oHuman, oMsg.pos, oMsg.count, oMsg.hero)
end

function CG_ITEM_STORE(oHuman, oMsg)
	背包逻辑.DoItemStore(oHuman, oMsg.pos, oMsg.vip)
end

function CG_EQUIP_QUERY(oHuman, oMsg)
	背包逻辑.SendEquipQuery(oHuman)
end

function CG_EQUIP_ENDUE(oHuman, oMsg)
	if oMsg.hero == 1 and not oHuman.英雄 then
		--oHuman:SendTipsMsg(1,"请先召唤英雄")
		--return
	end
	背包逻辑.DoEquipEndue(oHuman, oMsg.pos, oMsg.equippos, oMsg.hero)
end

function CG_EQUIP_UNFIX(oHuman, oMsg)
	if oMsg.hero == 1 and not oHuman.英雄 then
		--oHuman:SendTipsMsg(1,"请先召唤英雄")
		--return
	end
	背包逻辑.DoEquipUnfix(oHuman, oMsg.pos, oMsg.hero)
end

function CG_STORE_QUERY(oHuman, oMsg)
	背包逻辑.SendStoreQuery(oHuman, nil, oMsg.vip)
end

function CG_STORE_REBUILD(oHuman, oMsg)
	背包逻辑.DoStoreRebuild(oHuman, oMsg.vip)
end

function CG_STORE_DISCARD(oHuman, oMsg)
end

function CG_STORE_SWAP(oHuman, oMsg)
end

function CG_STORE_FETCH(oHuman, oMsg)
	背包逻辑.DoStoreFetch(oHuman, oMsg.pos, oMsg.vip)
end

function CG_STORE_FETCHALL(oHuman, oMsg)
	背包逻辑.DoStoreFetchAll(oHuman, oMsg.vip)
end

function CG_QUICK_QUERY(oHuman, oMsg)
	背包逻辑.SendQuickQuery(oHuman)
end

function CG_QUICK_SETUP(oHuman, oMsg)
	背包逻辑.DoQuickSetup(oHuman, oMsg.id)
end

function CG_ITEM_BUY(oHuman, oMsg)
	背包逻辑.DoBuyItem(oHuman, oMsg.type, oMsg.id, oMsg.count)
end

function CG_ITEM_QUERY(oHuman, oMsg)
	背包逻辑.DoQueryItem(oHuman, oMsg.id, oMsg.query)
end

function CG_ITEM_RESOLVE_QUERY(oHuman, oMsg)
	背包逻辑.DoQueryResolveItem(oHuman, oMsg.pos)
end

function CG_ITEM_RESOLVE(oHuman, oMsg)
	背包逻辑.DoResolveItem(oHuman, oMsg.pos)
end

function CG_TIMESHOP_QUERY(oHuman, oMsg)
	限时商店.SendShopQuery(oHuman)
end

function CG_TIMESHOP_BUY(oHuman, oMsg)
	限时商店.DoShopItemBuy(oHuman, oMsg.id, oMsg.type)
end
