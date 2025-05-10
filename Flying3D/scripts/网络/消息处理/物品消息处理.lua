module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 背包UI = require("主界面.背包UI")
local 角色UI = require("主界面.角色UI")
local 主界面UI = require("主界面.主界面UI")
local 商城UI = require("主界面.商城UI")
local 商店UI = require("主界面.商店UI")
local 装备分解UI = require("主界面.装备分解UI")
local 仓库UI = require("主界面.仓库UI")
local 福利UI = require("主界面.福利UI")

function GC_STORE_LIST(op,itemdata,vip)
	if 仓库UI.m_vip ~= vip then
		仓库UI.m_itemdata = nil
	end
	仓库UI.m_vip = vip
	仓库UI.setItemData(op,itemdata)
	if vip > 0 and (背包UI.isHided() or 仓库UI.isHided()) then
		背包UI.initUI()
		if 背包UI.m_init then
			仓库UI.initUI()
			背包UI.otherui = 仓库UI
			背包UI.checkResize()
		else
			背包UI.ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(function(e)
				仓库UI.initUI()
				背包UI.otherui = 仓库UI
				背包UI.checkResize()
			end))
		end
	end
end

function GC_EQUIP_LIST(op,itemdata)
	角色UI.setEquipData(op,itemdata)
end

function GC_BAG_LIST(op,itemdata)
	背包UI.setItemData(op,itemdata)
end

function GC_QUICK_LIST(id)
	主界面UI.setQuickData(id)
end

function GC_ITEM_BUY(result)
end

function GC_ITEM_QUERY(query,itemdata)
	if query == 1 then
		商城UI.setItemData(itemdata)
	elseif query == 2 then
		商店UI.setItemData(itemdata)
	elseif query == 3 then
		福利UI.setItemData(itemdata)
	end
end

function GC_ITEM_RESOLVE(result)
end

function GC_ITEM_RESOLVE_QUERY(itemdata)
	装备分解UI.setGainItemInfo(itemdata)
end

function GC_TIMESHOP_BUY(result)
end

function GC_TIMESHOP_QUERY(item)
	商城UI.setTimeShopItem(item)
end

