module(..., package.seeall)
local 协议ID = require("公用.协议ID")
local Register = require("公用.派发器").Register

function RegisterOneModuleProtos(moduleName, isRobot)
	local 事件处理 = require(moduleName .. ".事件处理")
	if isRobot then
		事件处理 = require("robot.EventAI")
	end
	local 协议 = require(moduleName .. ".协议")
	for k, v in pairs(协议) do
		if k:sub(1, 2) == "CG" or k:sub(1, 2) == "GC" or k:sub(1, 2) == "GG" or k:sub(1,2) == "SG" or k:sub(1,2) == "GS" then
			if not 协议ID[k] then
				print(k, _convert(" not exist in 协议ID.lua"))
				assert(nil)
			end
			if not (isRobot or k:sub(1, 2) == "GC" or k:sub(1, 2) == "GG" or 事件处理[k] or k == "CG_MOVE" or k == "CG_STOP_MOVE") then
				print(k, _convert(" not exist in 事件处理.lua"))
				assert(nil)
			end
			Register(协议ID[k], v, k, 事件处理[k])
		end
	end
	local ret, err = pcall(require, moduleName .. ".初始化")
	if not ret and not err:find(_convert(".初始化' not found:")) then
		print(err)
	end
end