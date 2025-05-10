function GetStrFromFile(fileName)
	local f = io.open(fileName, "rb")
	if not f then
		return
	end
	local str = f:read("*all")
	assert(f:close())
	return str
end

function PrintToFile(fileName, str)
	local f = assert(io.open(fileName, "wb"))
	if not f then
		return
	end
	f:write(str)
	assert(f:close())
end

--setmetatable(_M, MessageManager)
--_M.__index = _M

local str = [[
module(..., package.seeall)

local 消息管理 = require("公用.消息管理")
local 消息类型 = require("网络.消息类型")

register = 消息管理.register
sendMessage = 消息管理.sendMessage

function init()
]]..GetStrFromFile("Message.lua")..[[
end

]]..GetStrFromFile("CGMethod.lua")..[[
]]

PrintToFile("Message.lua", str)