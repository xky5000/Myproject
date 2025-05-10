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

function GetFunctionNames(str)
	local tb = {}
	local i = 1
	local j = 1
	for _ = 1, math.huge do
		i = str:find("function GC_", j)
		if not i then
			break
		end
        i = i + string.len("function ")
		j = str:find("(", i, true)
		if not j then
			break
		end
		tb[str:sub(i, j - 1)] = true
	end
	return tb
end

function GetFuncLine(strNew, funcName)
	local i = strNew:find(funcName, 1, true)
    while strNew:sub(i + #funcName, i + #funcName) ~= "(" and strNew:sub(i + #funcName, i + #funcName) ~= " " do
        i = strNew:find(funcName, i + 1)
    end
	local j = i
	while strNew:sub(i, i) ~= "\n" do
		i = i - 1
	end
	while strNew:sub(j, j) ~= "\n" do
		j = j + 1
	end
	return strNew:sub(i, j)
end

function ReplaceFuncLine(strOld, funcName, funcLine)    
	local i = strOld:find(funcName)
    while strOld:sub(i + #funcName, i + #funcName) ~= "(" and strOld:sub(i + #funcName, i + #funcName) ~= " " do
        i = strOld:find(funcName, i + 1)
    end
	local j = i
	while strOld:sub(i, i) ~= "\n" do
		i = i - 1
	end
	while strOld:sub(j, j) ~= "\n" do
		j = j + 1
	end
	return strOld:sub(1, i - 1) .. funcLine .. strOld:sub(j + 1)
end

function AddFuncLine(strOld, strFuncLine)
	local i = #strOld
	while i > 0 do
		if i > 2 and strOld:sub(i-2, i) == "end" then
			break
		end
		i = i - 1
	end
	if i == 0 then return strOld end
	return strOld:sub(1, i) .. "\n" .. strFuncLine .. "end" .. strOld:sub(i + 1)
end

local strOld = GetStrFromFile(arg[1])
local strNew = GetStrFromFile(arg[2])
if not strOld then
	PrintToFile(arg[1], strNew)
    return
end

local fnOld = GetFunctionNames(strOld)
local fnNew = GetFunctionNames(strNew)

for k, v in pairs(fnNew) do
	local funcLine = GetFuncLine(strNew, k)
	if fnOld[k] then
		strOld = ReplaceFuncLine(strOld, k, funcLine)
	else
		strOld = AddFuncLine(strOld, funcLine)
	end
end

PrintToFile(arg[3], strOld)
