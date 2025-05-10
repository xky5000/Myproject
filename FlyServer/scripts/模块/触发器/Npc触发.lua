module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 全局变量 = require("触发器.全局变量")

function call_4056_10011(human)
	local sayret = nil

	if true then
		sayret = [[
#cEFC400,任务：#cFFFFFF,
    乡勇团

#cEFC400,任务目标：#cFFFFFF,
    如果想加入乡勇团，可以找#c00ff00,武器商王仁#cFFFFFF,选择
武器。

#cEFC400,任务描述：#cFFFFFF,
    哟，几天不见，又长高不少嘛！
    村里最近组了个乡勇团。想加入的话，可以
找#c00ff00,武器商王仁#cFFFFFF,免费领一样兵器。
你想加入么？
]]
	end
	return sayret
end
