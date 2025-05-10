module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 聊天定义 = require("聊天.聊天定义")
local GM命令 = require("聊天.GM命令")
local 实用工具 = require("公用.实用工具")

function SendSystemChat(str, sceneid)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHAT]
	oReturnMsg.msgtype = 0
	oReturnMsg.rolename = ""
	oReturnMsg.objid = -1
	oReturnMsg.msg = str
	oReturnMsg.msgLen = #str
	
	if sceneid and sceneid ~= -1 then
		消息类.SceneBroadCast(oReturnMsg, sceneid)
	else
		消息类.WorldBroadCast(oReturnMsg)
	end
	
	return true
end

function 发送玩家聊天(str, msgtype, human)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHAT]
	oReturnMsg.msgtype = msgtype
	oReturnMsg.rolename = ""
	oReturnMsg.objid = -1
	oReturnMsg.msg = str
	oReturnMsg.msgLen = #str
	
	消息类.SendMsg(oReturnMsg, human.id)
	return true
end
