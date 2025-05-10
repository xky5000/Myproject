---
-- Created by IntelliJ IDEA.
-- User: xq
-- Date: 12-1-6
-- Time: 下午2:12
-- To change this template use File | Settings | File Templates.
--


module(..., package.seeall)
--local ItemReader = require("物品.ItemReader")
--local Grid = require("物品.Grid")

--消息显示位置
POS_TOP = 1 --上方中央广播
POS_CENTER = 2 --中方中央广播
POS_DOWN = 3 --下方中央广播
POS_CHAT = 4 --世界聊天广播
POS_TEAM_CHAT = 5 --队伍聊天广播
POS_GUILD_CHAT = 6 --帮派频道广播
POS_SPEAKER = 7 --喇叭
POS_ONLY_TOP = 8 --仅上方中央广播
POS_ONLY_CENTER = 9 --仅中央广播
POS_ONLY_RIGHT = 10 --仅右下角提示
POS_WORD_TIP = 11 --特殊字体
POS_ONLY_DOWN = 12 --仅下方中央广播

 

--消息类型定义
B_GET_CHARGE_PRESENT = 1 -- 领取首充礼包
B_ESCORT_CALL_RESCURE = 2 --紧急呼救
B_SHOP_LIMIT_BUY = 3 -- 商店限时抢购

Msg = {}


Msg[B_GET_CHARGE_PRESENT] = "%s 领取了价值<font color=\"#E47833\">1388</font>元宝【%s】x1。<font color=\"#0ff00\"><a href=\"event:4 3,1\">内含100万经验、%s x 10个，<u>我要围观</u></a></font>"
Msg[B_ESCORT_CALL_RESCURE] = "紧急呼救！盟友%s在护送任务过程中遇到困难啦，<font color=\"#0ff00\"><a href=\"event:2 %d,%d,%d\"><u>前往搭救</u></a></font>"
Msg[B_SHOP_LIMIT_BUY] = "%s 在商城限时抢购中使用<font color=\"#E47833\">%d</font>元宝购买【%s】x1，当前剩余<font color=\"#F7C030\">%d</font>个。<font color=\"#0ff00\"><a href=\"event:4 4,1\"><u>我要抢购</u></a></font>"


colorRgb = {}
colorRgb[0] = "#cCCCCCC,"  --"#cFFFFFF,"  --白色
colorRgb[1] = "#cCCCCCC,"  --白色
colorRgb[2] = "#c38BB41,"  --绿色
colorRgb[3] = "#c1FABE1,"  --蓝色
colorRgb[4] = "#cDD61E2,"  --紫色
colorRgb[5] = "#cEB7B29,"  --橙色
colorRgb[6] = "#cEB7B29,"  --"#cF1C735,"  --浅黄橙色

TYPE_ACTION_ON_NAME_MENU = 0
TYPE_ACTION_ON_SHOW_ITEM = 1
TYPE_ON_XY = 2
TYPE_ON_GO = 3
TYPE_OPEN_PANEL = 4
TYPE_JOIN_ACTIVITY = 5
TYPE_JOIN_GUILD = 6
TYPE_TEAM_INVITE = 7

PANEL_MAGICBOX = 1 --结界
PANEL_VIP = 2 --vip
PANEL_ACTIVITY_PRESENT = 3 --活动面板-礼包领取
PANEL_SHOP_HOT = 4 --商城面板-热卖


local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")

function BroadcastMsg(pos, msg, arg1, arg2, arg3, arg4, arg5)
  msg = string.format(msg, arg1, arg2, arg3, arg4, arg5)
  local gcBroadcast = 派发器.ProtoContainer[协议ID.GC_BROADCAST]
  gcBroadcast.pos = pos
  gcBroadcast.msg = msg
  消息类.WorldBroadCast(gcBroadcast)
end

function BroadcastUserMsg(pos, msg, ids, arg1, arg2, arg3, arg4, arg5)
  msg = string.format(msg, arg1, arg2, arg3, arg4, arg5)
  local gcBroadcast = 派发器.ProtoContainer[协议ID.GC_BROADCAST]
  gcBroadcast.pos = pos
  gcBroadcast.msg = msg
  消息类.UserBroadCast(gcBroadcast, ids)
end

function BroadcastUser1Msg(pos, msg, id)
  local gcBroadcast = 派发器.ProtoContainer[协议ID.GC_BROADCAST]
  gcBroadcast.pos = pos
  gcBroadcast.msg = msg
  消息类.SendMsg(gcBroadcast, id)
end

--UserBroadCast

function BroadCastSceneMsg(sceneId, pos, msg)
  local gcBroadcast = 派发器.ProtoContainer[协议ID.GC_BROADCAST]
  gcBroadcast.pos = pos
  gcBroadcast.msg = msg
  消息类.SceneBroadCast(gcBroadcast, sceneId)
end

function BroadCastSceneMsg2(pos, sceneId, msg, arg1, arg2, arg3, arg4, arg5)
  msg = string.format(msg, arg1, arg2, arg3, arg4, arg5)
  local gcBroadcast = 派发器.ProtoContainer[协议ID.GC_BROADCAST]
  gcBroadcast.pos = pos
  gcBroadcast.msg = msg
  消息类.SceneBroadCast(gcBroadcast, sceneId)
end

function GetColorRgb(color)
  return colorRgb[color + 1]
end

function font(content, color, size)
  if not color then
    color = "#FFF000"
  end
  if not size then
    size = 12
  end
  return "<font color='" .. color .. "' size='" .. size .. "'>" .. content .. "</font>";
end

function fontName(name)
  return "<a href=\'event:" .. TYPE_ACTION_ON_NAME_MENU .. " "
          .. "0,0," .. name .. "\'><font color=\"#facca7\"> "
          .. name .. " </font></a>"
end

local tb = {
	"#38BB41",  --绿色
	"#1FABE1",  --蓝色
	"#DD61E2",  --紫色
	"#EB7B29",  --橙色
	"#F1C735"   --浅黄橙色
}
tb[0] = "#FFFFFF"   --白色
function fontEquip(equipID, color)
	--color = color or ItemReader.GetColor(equipID)
	--return "<font color='" .. tb[color] .. "'>【" .. ItemReader.GetValue(equipID, "name") .. "】</font>"
end
function fontItemTips(itemID, color)
	--color = color or ItemReader.GetColor(itemID)
	--local itemicon = ItemReader.GetValue(itemID, "icon")
	--return "<u><a href='event:8 " .. itemID .. "," .. itemicon .. "," .. color .. "'><font color='" .. tb[color] .. "'>【" .. ItemReader.GetValue(itemID, "name") .. "】</font></a></u>"
end
function fontNormal(name, color)
	return "<font color='" .. tb[color] .. "'>" .. name .. "</font>"
end

local function DfsMakeEquip(s, t)
	for k, v in pairs(s) do
		if type(k) == "number" then
			table.insert(t, "[")
		end
		table.insert(t, k)
		if type(k) == "number" then
			table.insert(t, "]")
		end
		table.insert(t, "=")
		if type(v) == "number" then
			table.insert(t, v)
		elseif type(v) == "string" then
			table.insert(t, "[[")
			table.insert(t, v)
			table.insert(t, "]]")
		else
			table.insert(t, "{")
			DfsMakeEquip(v, t)
			table.insert(t, "}")
		end
		if next(s, k) then
			table.insert(t, ",")
		end
	end
end

function fontEquipTips(grid)
	--if not ItemReader.IsEquip(grid.id) then
	--	return fontItemTips(grid.id)
	--end
	--local msgRet = 消息类.Get("GC_EQUIP_SHOW")
	--Grid.MakeEquipInfo(msgRet.data[1], grid, 0)
	--local out = {}
	--DfsMakeEquip(msgRet.data[1], out)
	--return "<u><a href='event:9 " .. table.concat(out) .. "'><font color='" .. tb[grid.equip.color] .. "'>【" .. ItemReader.GetValue(grid.id, "name") .. "】</font></a></u>"
end

local tb
