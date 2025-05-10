module(..., package.seeall)

local 网络连接 = require("公用.网络连接")

TYPE_SHORT = 0
TYPE_INT = 1
TYPE_STRING = 2
TYPE_BYTE = 3
TYPE_DOUBLE = 4

index = {}
decoder = {}

sendBuf = F3DByteArray:new()
sendBuf:init(10240)
sendBuf:setLength(0)

function register(cmd, decode, 消息处理)
	index[cmd] = 消息处理
	decoder[cmd] = decode
end

function doMessage(cmd, data)
	if index[cmd] then
		index[cmd](unpack(decode(decoder[cmd], data)))
	end
end

function sendMessage(cmd, data)
	sendBuf:setPosition(0)
	local encodeObj = decoder[cmd]
	for i=1,table.getn(encodeObj) do
		encode(encodeObj[i], data[i])
	end
	sendBuf:setLength(sendBuf:getPosition())
	网络连接.send(cmd, sendBuf)
end

function decode(decodeObj, data)
	local result = {}
	local length = table.getn(decodeObj)
	local obj, t
	for i=1,length do
		obj = decodeObj[i]
		if type(obj) == "table" then
			local len = data:readShort()
			local parent = {}
			if table.getn(obj) > 1 then
				table.insert(result, parent)
				for j=1,len do
					table.insert(parent, decode(obj, data))
				end
			else
				table.insert(result, parent)
				for j=1,len do
					t = obj[1]
					if t == TYPE_SHORT then
						table.insert(parent, data:readShort())
					elseif t == TYPE_INT then
						table.insert(parent, data:readInt())
					elseif t == TYPE_STRING then
						table.insert(parent, data:readUTF())
					elseif t == TYPE_BYTE then
						table.insert(parent, data:readByte())
					elseif t == TYPE_DOUBLE then
						table.insert(parent, data:readDouble())
					end
				end
			end
		else
			t = obj
			if t == TYPE_SHORT then
				table.insert(result, data:readShort())
			elseif t == TYPE_INT then
				table.insert(result, data:readInt())
			elseif t == TYPE_STRING then
				table.insert(result, data:readUTF())
			elseif t == TYPE_BYTE then
				table.insert(result, data:readByte())
			elseif t == TYPE_DOUBLE then
				table.insert(result, data:readDouble())
			end
		end
	end
	return result
end

function encode(encodeObj, data)
	if type(encodeObj) == "table" then
		sendBuf:writeShort(table.getn(data))
		for i=1,table.getn(data) do
			for j=1,table.getn(encodeObj) do
				encode(encodeObj[j], type(data[i]) == "table" and data[i][j] or data[i])
			end
		end
	else
		if encodeObj == TYPE_SHORT then
			sendBuf:writeShort(data)
		elseif encodeObj == TYPE_INT then
			sendBuf:writeInt(data)
		elseif encodeObj == TYPE_BYTE then
			sendBuf:writeByte(data)
		elseif encodeObj == TYPE_STRING then
			sendBuf:writeUTF(data)
		end
	end
end
