module(..., package.seeall)

local 消息管理 = require("公用.消息管理")

socket = F3DPlatform:instance():createSocket()
recvBuf = F3DByteArray:new()
recvBuf:init(102400)
recvBuf:setLength(0)

function init(connect, close, ioError)
	connectHandler = connect
	closeHandler = close
	ioErroHandlerr = ioError
	socket:addEventListener(F3DEvent.CONNECT, func_e(onConnect))
	socket:addEventListener(F3DEvent.IO_ERROR, func_e(onIOError))
	socket:addEventListener(F3DEvent.SOCKET_DATA, func_e(onSocketData))
end

function onConnect(e)
	if connectHandler then connectHandler() end
end

function onIOError(e)
	if ioErroHandlerr then ioErroHandlerr() end
end

m_SocketDataCheck = false
m_SocketDataTime = 0

function onSocketData(e)
	if m_SocketDataCheck then
		m_SocketDataTime = rtime()
	end
	local len
	local cmd
	if recvBuf:getLength() > 0 and recvBuf:getLength() == recvBuf:getPosition() then
		recvBuf:setLength(0)
		recvBuf:setPosition(0)
	end
	local bytesAvailable = socket:bytesAvailable()
	socket:readBytes(recvBuf, recvBuf:getLength(), bytesAvailable)
	recvBuf:setLength(recvBuf:getLength() + bytesAvailable)
	while recvBuf:bytesAvailable() >= 4 do
		len = recvBuf:readShort()
		if recvBuf:bytesAvailable() >= len - 2 then
			cmd = recvBuf:readShort()
			消息管理.doMessage(cmd, recvBuf)
		else
			recvBuf:setPosition(recvBuf:getPosition() - 2)
			break
		end
	end
end

function connect(ip, port)
	socket:connect(ip, port)
end

function send(cmd, body)
	if not socket:isConnected() then return end
	socket:writeShort(body:getLength() + 4)
	socket:writeShort(cmd)
	socket:writeBytes(body, 0, body:getLength())
	socket:flush()
end

function isConnected()
	return socket:isConnected()
end

function closeConnect()
	m_SocketDataCheck = false
	if not socket:isConnected() then return end
	socket:close()
	if closeHandler then closeHandler() end
end
