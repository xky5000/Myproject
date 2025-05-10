module(..., package.seeall)

local 协议ID = require("公用.协议ID")
local 派发器 = require("公用.派发器")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 聊天定义 = require("聊天.聊天定义")
local GM命令函数 = require("聊天.GM命令函数")
local 登录触发 = require("触发器.登录触发")
local 事件触发 = require("触发器.事件触发")

function splitString(str, delim)
	local strs = {}
	local s,e = 1
	e = str:find(delim,s)
	while e do
		strs[#strs+1] = str:sub(s,e-1)
		s = e+1
		e = str:find(delim,s)
	end
	strs[#strs+1] = str:sub(s)
	return strs
end

function CheckUserCmd(human, str)
	if str:byte(1) ~= string.byte("@") then
		return false
	end
	local cmdexist = false
	local err
	local vals = splitString(str:sub(2), " ")
	if vals[1] == "管理" and human:GetAccount() == Config.GM_ACCOUNT then
		local call = 登录触发._M["call_管理员"]
		if call then
			human:显示对话(-3,call(human))
			err = true
			cmdexist = true
		end
	else
		local call = 事件触发._M["call_用户命令_"..vals[1]]
		if call then
			human:显示对话(-2,call(human))
			err = true
			cmdexist = true
		end
	end
	if not cmdexist then
		return false
	end
	local msgRet = 派发器.ProtoContainer[协议ID.GC_CHAT]
	msgRet.rolename = ""
	msgRet.objid = -1
	msgRet.msgtype =  聊天定义.CHAT_TYPE_WORLD
	if err then
		msgRet.msg = "TRUE"
	else
		msgRet.msg = "FALSE"
	end
	消息类.SendMsg(msgRet, human.id)
	return true
end

function CheckGmCmd(human, str)
	if str:byte(1) ~= string.byte(".") then
		return false
	end
	local cmdexist = false
	local err
	local vals = splitString(str:sub(2), " ")
	for k, v in pairs(GM命令函数) do
		if vals[1] == k then
			if Config.DEBUG or human:GetAccount() == Config.GM_ACCOUNT then
				table.remove(vals, 1)
				err = v(human, unpack(vals))
				cmdexist = true
			end
			break
		end
	end
	if not cmdexist then
		return false
	end
	local msgRet = 派发器.ProtoContainer[协议ID.GC_CHAT]
	msgRet.rolename = ""
	msgRet.objid = -1
	msgRet.msgtype =  聊天定义.CHAT_TYPE_WORLD
	if err then
		msgRet.msg = "TRUE"
	else
		msgRet.msg = "FALSE"
	end
	消息类.SendMsg(msgRet, human.id)
	return true
end
