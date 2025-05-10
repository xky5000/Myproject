names = "协议,场景,玩家,怪物,技能,物品,宠物,锻造,聊天,副本,排行榜,寄售,队伍,行会"
namesmap = {}

function SplitString(str, delim)
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

local ns1 = SplitString(arg[4], ",")
local ns2 = SplitString(names, ",")
for i,v in ipairs(ns1) do
	namesmap[v] = ns2[i]
end
REAL_REQUIRE = REAL_REQUIRE or require
require = function(str)
	for k,v in pairs(namesmap) do
		str = str:gsub(v,k)
	end
	return REAL_REQUIRE(str)
end

moduleName = namesmap[arg[3]] or arg[3]

function PrintToFile(fileName, str)
	local f = assert(io.open(fileName, "ab"))
	f:write(str)
	assert(f:close())
end

function IsNeedDivide(k)
	if k < 2 then
		return ""
	end
	return ","
end

function AAAtoA(str, cnt)
	if str == "SHORT" then return 0 end
	if str == "INT" then return 1 end
	if str == "DOUBLE" then return 4 end
	if str == "CHAR" and cnt > 1 then return 2 end
	if str == "CHAR" and cnt == 1 then return 3 end
	return -1
end

function GetDecodeStr(template, rw)
	local res = ""
	for k, v in ipairs(template) do
		if v[3] > 1 then
			if v[2] == "CHAR" then
				res = res .. IsNeedDivide(k) .. AAAtoA(v[2], v[3])
			elseif type(v[2]) == "string" then
				res = res .. IsNeedDivide(k) .. "{" .. AAAtoA(v[2], v[3]) .. "}"
			elseif type(v[2]) == "table" then
				res = res .. IsNeedDivide(k) .. "{" .. GetDecodeStr(v[2], rw) .. "}"
			end
		else
			if type(v[2]) == "string" then
				res = res .. IsNeedDivide(k) .. AAAtoA(v[2], v[3])
			elseif type(v[2]) == "table" then
				res = res .. IsNeedDivide(k) .. "{" .. GetDecodeStr(v[2], rw) .. ",}"
			end
		end
	end
	return res
end

function GetArgForAs3(template)
	local res = ""
	for k, v in ipairs(template) do
		if k > 1 then
			res = res .. ","
		end
		res = res .. v[1]
	end
	return res
end

function PrintCGMethod(protoEnumName, template)
	local res = "function " .. protoEnumName .. "(" .. GetArgForAs3(template) .. ")\n"
	res = res .. "\tsendMessage(消息类型." .. protoEnumName .. ", {" .. GetArgForAs3(template) .. "})\n"
	res = res .. "end\n"
	return res
end

function PrintCG(protoEnumName, template)
	return "	register(消息类型." .. protoEnumName .. ", {" .. GetDecodeStr(template, "read") .. "})"
end

function PrintGC(protoEnumName, template)
	return "	register(消息类型." .. protoEnumName .. ", {" .. GetDecodeStr(template, "read") .. "}, " .. moduleName .. "消息处理." .. protoEnumName .. ")"
end

function AddHandlerHead(res)
	return [[
module(..., package.seeall)

]]..res..[[
]]
end

function PrintAs3Handler(protoEnumName, template)
	return "function " .. protoEnumName .. "(" .. GetArgForAs3(template) .. ")\nend\n"
end

package.path = package.path .. ";" .. arg[1]

local m = require(arg[2] .. ".协议")
--cggc
local str = "\n\t--- " .. moduleName .. "CGMessage\n"
for k, v in pairs(m) do
	if k:sub(1, 2) == "CG" then
		str = str .. PrintCG(k, v) .. "\n"
	end
end
str = str .. "\n\t--- " .. moduleName .. "GCMessage\n"
str = str .. "\tlocal " .. moduleName .. "消息处理 = require(\"网络.消息处理." .. moduleName .. "消息处理\")\n"
for k, v in pairs(m) do
	if k:sub(1, 2) == "GC" then
		str = str .. PrintGC(k, v) .. "\n"
	end
end
PrintToFile("Message.lua", str)

--handler
local str = ""
for k, v in pairs(m) do
	if k:sub(1, 2) == "GC" then
		str = str .. PrintAs3Handler(k, v) .. "\n"
	end
end
str = AddHandlerHead(str)
PrintToFile(arg[3] .. arg[5], str)

--PrintCGMethod
local str = "\n--- " .. moduleName .. "CGMethod\n"
for k, v in pairs(m) do
	if k:sub(1, 2) == "CG" then
		str = str .. PrintCGMethod(k, v) .. "\n"
	end
end
PrintToFile("CGMethod.lua", str)
