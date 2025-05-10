module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 聊天定义 = require("聊天.聊天定义")
local 聊天逻辑 = require("聊天.聊天逻辑")
local GM命令 = require("聊天.GM命令")
local 实用工具 = require("公用.实用工具")

function CG_CHAT(oHuman, oMsg)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHAT]
	oReturnMsg.msgtype = oMsg.msgtype
	oReturnMsg.rolename = oHuman.m_db.name--oHuman.platform..
	oReturnMsg.objid = oHuman.id
	
	local str = 实用工具.GetStringFromTable(oMsg.msgLen, oMsg.msg)
	if oHuman.chatcolor and oHuman.chatcolortime and oHuman.chatcolortime > _CurrentTime() then
		oReturnMsg.msg = oHuman.chatcolor..str
	else
		oReturnMsg.msg = str
	end
	
	if oMsg.msgtype == 聊天定义.CHAT_TYPE_WORLD then
		-- 世界聊天
		if not GM命令.CheckUserCmd(oHuman, str) and not GM命令.CheckGmCmd(oHuman, str) then
			消息类.WorldBroadCast(oReturnMsg)
		else
			return true
		end
	elseif oMsg.msgtype == 聊天定义.CHAT_TYPE_NEARBY then
		-- 附近聊天
		消息类.ZoneBroadCast(oReturnMsg, oHuman.id)
	elseif oMsg.msgtype == 聊天定义.CHAT_TYPE_GUILD then
		聊天逻辑.发送玩家聊天("#cff0000,你没有加入军团", oMsg.msgtype, oHuman)
	elseif oMsg.msgtype == 聊天定义.CHAT_TYPE_TEAM then
		聊天逻辑.发送玩家聊天("#cff0000,你没有加入队伍", oMsg.msgtype, oHuman)
	elseif oMsg.msgtype == 聊天定义.CHAT_TYPE_PRIVATE then
		聊天逻辑.发送玩家聊天("#cff0000,你没有可私聊的对象", oMsg.msgtype, oHuman)
	elseif oMsg.msgtype == 聊天定义.CHAT_TYPE_SPEAKER then
		聊天逻辑.发送玩家聊天("#cff0000,你不能使用喇叭", oMsg.msgtype, oHuman)
	end
	
	return true
end
