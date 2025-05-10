module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 聊天定义 = require("聊天.聊天定义")
local 实用工具 = require("公用.实用工具")
local 消息类 = require("公用.消息类")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 背包逻辑 = require("物品.背包逻辑")
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local 副本逻辑 = require("副本.副本逻辑")
local 后台逻辑 = require("后台管理.后台逻辑")
local 物品逻辑 = require("物品.物品逻辑")
local 拾取物品逻辑 = require("怪物.拾取物品逻辑")
local 玩家属性表 = require("配置.玩家属性表").Config
local 玩家DB = require("玩家.玩家DB").玩家DB

local HELP = [[
.等级 等级
.英雄等级 等级
.转生 等级
.英雄转生 等级
.金币 数量
.绑定金币 数量
.元宝 数量 账号
.绑定元宝 数量
.物品 物品id 数量 绑定 品质 强化
.怪物 怪物id 数量 范围
.清空背包
.清空任务
.清空副本
.传送 地图id 坐标x 坐标y
.充值 金额 账号
.声望 值
.无敌 值
.秒杀 值
.潜行 值
]]

function 帮助(human)
  local msgRet = 派发器.ProtoContainer[协议ID.GC_CHAT]
  msgRet.rolename = ""
  msgRet.objid = -1
  msgRet.msgtype = 聊天定义.CHAT_TYPE_WORLD
  msgRet.msg = HELP
  消息类.SendMsg(msgRet, human.id)
  return true
end

function 等级(human, val)
	if human.m_db.level == tonumber(val) then
		return false
	end
	local oldlevel = human.m_db.level
	human.m_db.level = math.max(1,math.min(#玩家属性表,tonumber(val) or 0))
	human.m_db.exp = 0
	if human.m_db.level ~= oldlevel then
		human:LevelUp()
	end
	human:SendActualAttr()
	return true
end

function 英雄等级(human, val)
	if not human.英雄 then
		return false
	end
	if human.英雄.m_db.level == tonumber(val) then
		return false
	end
	local oldlevel = human.英雄.m_db.level
	human.英雄.m_db.level = math.max(1,math.min(#玩家属性表,tonumber(val) or 0))
	human.英雄.m_db.exp = 0
	if human.英雄.m_db.level ~= oldlevel then
		human.英雄:LevelUp()
	end
	human.英雄:SendActualAttr()
	human:SendEquipView(human.英雄, true)
	return true
end

function 转生(human, val)
	if human.m_db.转生等级 == tonumber(val) then
		return false
	end
	human.m_db.转生等级 = math.max(0,math.min(9,tonumber(val) or 0))
	human:CheckAttrLearn()
	human:SendPropAddPoint()
	return true
end

function 英雄转生(human, val)
	if not human.英雄 then
		return false
	end
	if human.m_db.英雄转生等级 == tonumber(val) then
		return false
	end
	human.m_db.英雄转生等级 = math.max(0,math.min(9,tonumber(val) or 0))
	human.英雄.m_db.转生等级 = human.m_db.英雄转生等级
	human:SendEquipView(human.英雄, true)
	human:CheckAttrLearn(true)
	human:SendPropAddPoint()
	return true
end

function 金币(human, val)
  return human:AddMoney(tonumber(val), false)
end

function 绑定金币(human, val)
  return human:AddMoney(tonumber(val), true)
end

function 元宝(human, val, 账号, svrid)
  if 账号 == nil or 账号 == "" then
	return human:AddRmb(tonumber(val), false)
  else
	local shuman = 在线账号管理[账号]
	if not shuman then
		local db = 玩家DB:New()
		local svrname = svrid and "s"..svrid.."." or nil
		local ret = db:LoadByAccount(账号, svrname)
		if ret then
			db.rmb = math.max(0, db.rmb + tonumber(val))
			db:Save()
			return true
		end
	else
		shuman.m_db.rmb = math.max(0, shuman.m_db.rmb + tonumber(val))
		return true
	end
  end
end

function 绑定元宝(human, val)
  return human:AddRmb(tonumber(val), true)
end

function 声望(human, val)
  human.m_db.声望值 = tonumber(val) or 0
  return true
end

function 物品(human, id, count, bind, grade, strengthen)
	id = tonumber(id) or 0
	count = tonumber(count) or 1
	bind = tonumber(bind) or 0
	grade = tonumber(grade)
	strengthen = tonumber(strengthen)
	local wash = nil
	if 物品逻辑.GetItemType1(id) == 3 and 物品逻辑.GetItemType2(id) == 14 then
		wash = 拾取物品逻辑.宠物蛋极品属性(strengthen or 0,grade or 1)
	elseif 物品逻辑.GetItemType1(id) == 3 and grade and grade > 1 then
		wash = 拾取物品逻辑.自动极品属性(grade-1,grade-1)
	end
	local indexs = human:PutItemGrids(id, count, bind, true, grade, strengthen, wash)
	if indexs == nil then
		return false
	end
	背包逻辑.SendBagQuery(human, indexs)
	human:AddQuickItem(id)
	return true
end

function 怪物(human, id, count, range)
	id = tonumber(id) or 0
	count = tonumber(count) or 1
	range = tonumber(range) or 0
	local cnt = 0
	local px,py = human:GetPosition()
	while cnt < count do
		local x = px + (range == 0 and 0 or math.random(-range, range))
		local y = py + (range == 0 and 0 or math.random(-range, range) * (human.Is2DScene and 1/human.MoveGridRate or 1))
		if _IsPosCanRun(human.m_nSceneID, x, y) then
			local m = 怪物对象类:CreateMonster(human.m_nSceneID, id, x, y)
			m.relivetime = -1
			cnt = cnt + 1
		end
	end
	return true
end

function 清空背包(human)
	local bagdb = human.m_db.bagdb
	local indexs = {}
	for k,v in pairs(bagdb.baggrids) do
		indexs[#indexs+1] = k
		bagdb.baggrids[k] = nil
	end
	背包逻辑.SendBagQuery(human, indexs)
	return true
end

function 清空任务(human)
	human.m_db.task = {}
	human.m_db.currtaskid = 0
	human.m_db.日常任务次数 = 0
	human.m_db.悬赏任务次数 = 0
	human.m_db.护送押镖次数 = 0
	human.m_db.护送灵兽次数 = 0
	human.m_db.庄园采集次数 = 0
	Npc对话逻辑.CheckHumanTaskAccept(human)
	return true
end

function 清空副本(human)
	human.m_db.singlecopy = {}
	human.m_db.singlecopyfinish = {}
	human.m_db.bosscopy = {}
	human.m_db.bosssinglecopy = {}
	副本逻辑.SendSingleCopyInfo(human)
	副本逻辑.SendBossCopyInfo(human)
	return true
end

function 传送(human, mapid, posx, posy)
	if mapid and posx and posy then
		human:Transport(tonumber(mapid), posx*(human.MoveGrid and human.MoveGrid[1] or 1), posy*(human.MoveGrid and human.MoveGrid[2] or 1))
	elseif mapid and posx then
		human:Transport(场景管理.GetMapId(human.m_nSceneID), mapid*(human.MoveGrid and human.MoveGrid[1] or 1), posx*(human.MoveGrid and human.MoveGrid[2] or 1))
	elseif mapid then
		human:RandomTransport(tonumber(mapid))
	else
		human:RandomTransport()
		--print(场景管理.GetMapId(human.m_nSceneID))
	end
	return true
end

function 充值(human, 金额, 账号)
	后台逻辑.catchpay({result=0,account=账号 or human:GetAccount(),rmb=tonumber(金额) or 0})
	return true
end

function 无敌(human, 值)
	human:管理模式(公共定义.额外属性_无敌, tonumber(值) or 1, 0)
	return true
end

function 秒杀(human, 值)
	human:管理模式(公共定义.额外属性_秒杀, tonumber(值) or 1, 0)
	return true
end

function 潜行(human, 值)
	human:管理模式(公共定义.额外属性_潜行, tonumber(值) or 1, 0)
	return true
end
