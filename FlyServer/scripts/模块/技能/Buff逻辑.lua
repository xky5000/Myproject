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
local 技能表 = require("配置.技能表").Config
local 技能信息表 = require("配置.技能信息表").Config
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local Buff表 = require("配置.Buff表").Config
local 怪物表 = require("配置.怪物表").Config
local 宠物逻辑 = require("宠物.宠物逻辑")
local 技能逻辑 = require("技能.技能逻辑")

function DoBuff(obj, type, value, debuff)
	local 属性 = type > 100 and type - 100 or type
	local 值 = value or 1
	if 属性 <= 公共定义.属性_移动速度 then
		值 = type > 100 and obj.属性值[属性] * value / 100 or value
	end
	if obj.attr[属性] then
		if debuff == 1 then
			obj.attr[属性][2] = math.max(obj.attr[属性][2], 值)
		else
			obj.attr[属性][1] = math.max(obj.attr[属性][1], 值)
		end
		obj.attr[属性][3] = obj.attr[属性][3] + 1
	else
		obj.attr[属性] = {debuff == 1 and 0 or 值, debuff == 1 and 值 or 0, 1}
	end
	if 属性 == 公共定义.属性_移动速度 then
		obj:ChangeSpeed()
	end
	if 属性 == 公共定义.属性_生命值 or 属性 == 公共定义.属性_魔法值 then
		obj:CalcDynamicAttr()
	end
	if 属性 == 公共定义.额外属性_免疫 then
		for k,v in pairs(obj.buffhit) do
			local buffconf = Buff表[k]
			if buffconf.debuff == 1 then
				_DelTimer(v, obj.id)
				obj.buffhit[k] = nil
			end
		end
		for k,v in pairs(obj.buffend) do
			local buffconf = Buff表[k]
			if buffconf.debuff == 1 then
				_DelTimer(v, obj.id)
				obj.buffend[k] = nil
				技能逻辑.DoHitBuffEnd(obj, buffconf)
				技能逻辑.SendBuff(obj.id,buffconf,10)
			end
		end
		obj:UpdateObjInfo()
	end
end

function DoBuffEnd(obj, type, value, debuff)
	local 属性 = type > 100 and type - 100 or type
	local 值 = value or 1
	if obj.attr[属性] then
		if obj.attr[属性][3] == 1 then
			obj.attr[属性] = nil
		else
			obj.attr[属性][3] = obj.attr[属性][3] - 1
		end
	end
	if 属性 == 公共定义.属性_移动速度 then
		obj:ChangeSpeed()
	end
end
