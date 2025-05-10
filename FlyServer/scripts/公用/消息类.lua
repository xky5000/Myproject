module(..., package.seeall)
local 派发器 = require("公用.派发器")
local ProtoContainer = 派发器.ProtoContainer
local ProtoContainer2PacketID = 派发器.ProtoContainer2PacketID
local 协议ID = require("公用.协议ID")
local _ReadMsg = _ReadMsg
local _SendMsg = _SendMsg
local _SendMsgByFD = _SendMsgByFD
local _UserBroadcast = _UserBroadcast
local _ZoneBroadcast = _ZoneBroadcast
local _SceneBroadcast = _SceneBroadcast
local _WorldBroadcast = _WorldBroadcast

function RecvMsg(packetID)
    local ret = ProtoContainer[packetID]
    if _ReadMsg(packetID, ret) then
        return ret
    end
end

function SendMsg(msg, objID)
    return _SendMsg(ProtoContainer2PacketID[msg], objID, msg)
end

function SendMsgByFD(msg, fd)
    return _SendMsgByFD(ProtoContainer2PacketID[msg], fd, msg)
end

function UserBroadCast(msg, userList)
    return _UserBroadcast(ProtoContainer2PacketID[msg], userList, msg) 
end

function ZoneBroadCast(msg, objID)
	-- print(ProtoContainer2PacketID[msg])
    return _ZoneBroadcast(ProtoContainer2PacketID[msg], objID, msg)
end

function SceneBroadCast(msg, sceneID)
	-- print(ProtoContainer2PacketID[msg])
    return _SceneBroadcast(ProtoContainer2PacketID[msg], sceneID, msg)
end

function WorldBroadCast(msg)
	-- print(ProtoContainer2PacketID[msg])
    return _WorldBroadcast(ProtoContainer2PacketID[msg], msg)
end

function Get(str)
	return ProtoContainer[协议ID[str]]
end

function Trace(msg)
	派发器.TraceMsg(msg)
end