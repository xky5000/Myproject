module(..., package.seeall)

local R2D = (180.0 / 3.14159265358979323846)

function GetRandomVal(val1, val2)
	if val1 == val2 then
		return val1
	elseif val1 < val2 then
		return math.random(val1, val2)
	else
		return math.random(val2, val1)
	end
end

function GetRandomTB(cnt)
	local tb1 = {}
	for i=1,cnt do
		tb1[#tb1+1] = i
	end
	local tb2 = {}
	for i=1,cnt do
		local id = math.random(1,#tb1)
		tb2[#tb2+1] = tb1[id]
		table.remove(tb1,id)
	end
	return tb2
end

function SumString(val1, val2)
	if type(val1) == "string" or type(val2) == "string" then
		return val1..val2
	else
		return val1 + val2
	end
end

function GetDirection(mx, my)
	local dir = 0
	if (mx == 0) then
		dir = (my > 0) and 180 or 0
	elseif (mx > 0) then
		dir = math.atan(my / mx) * R2D + 90
	else
		dir = math.atan(my / mx) * R2D + 270
	end
	return dir
end

--[[function SplitString(str, delim)
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

function JoinString(strs, delim)
	local str = nil
	for i,v in ipairs(strs) do
		str = (str and str..delim or "")..v
	end
	return str
end]]

function GetDistance(x1,y1,x2,y2,Is2DScene,MoveGridRate)
	if x2 == nil or y2 == nil then
		return math.sqrt(x1 * x1 + y1 * y1 * (Is2DScene and MoveGridRate * MoveGridRate or 1))
	else
		return math.sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1) * (Is2DScene and MoveGridRate * MoveGridRate or 1))
	end
end

function GetDistanceSq(x1,y1,x2,y2,Is2DScene,MoveGridRate)
	if x2 == nil or y2 == nil then
		return x1 * x1 + y1 * y1 * (Is2DScene and MoveGridRate * MoveGridRate or 1)
	else
		return (x2-x1) * (x2-x1) + (y2-y1) * (y2-y1) * (Is2DScene and MoveGridRate * MoveGridRate or 1)
	end
end

function GetNormalize(norm,x1,y1,x2,y2,Is2DScene,MoveGridRate)
	if norm == 0 then
		return 0,0
	end
	local len = GetDistance(x1,y1,x2,y2,Is2DScene,MoveGridRate)
	if len == 0 then
		return 0,0
	end
	if x2 == nil or y2 == nil then
		return x1*norm/len,y1*norm/len
	else
		return (x2-x1)*norm/len,(y2-y1)*norm/len
	end
end

function GetTableWeight(tb, key)
	local weight=0
	for _,conf in ipairs(tb) do
		weight = weight + conf[key]
	end
	local wei = math.random(1,weight)
	weight=0
	for _,conf in ipairs(tb) do
		weight = weight + conf[key]
		if wei <= weight then
			return conf, _
		end
	end
end

function GetRandPos(x, y, nRadius,Is2DScene,MoveGridRate)
	return x + math.random(-nRadius, nRadius), y + math.random(-nRadius, nRadius) * (Is2DScene and 1/MoveGridRate or 1)
end

function FindIndex(tb, val)
	for k,v in pairs(tb) do
		if v == val then
			return k
		end
	end
end

function GetRandPosOnEdge(x, y, r)
	local hudu = math.random() * 2 * math.pi
	x = x + math.cos(hudu) * r
	y = y + math.sin(hudu) * r
	return math.floor(x), math.floor(y)
end

tbCharArrayToString = tbCharArrayToString or {}
function GetStringFromTable(tbLen, tb)
    for i = 1, tbLen do
        tbCharArrayToString[i] = string.char(tb[i] % 256)
    end
    return table.concat(tbCharArrayToString, "", 1, tbLen)
end

function NewEnum(tb, nStartFrom)	--创建一个枚举类型
    nStartFrom = nStartFrom or 1
    local o = {m_begin = nStartFrom, m_end = nStartFrom + #tb}
    for i = 1, #tb do
		o[tb[i]] = i - 1 + nStartFrom
    end
    o.__index = function(t, k) assert(nil, k .. " not exist") end
    setmetatable(o, o)
    return o
end

--获取一个整形的第几位是什么
function GetBit(n, bitIndex)
    return math.floor(n / 2^bitIndex) % 2
end

--设置一个整形的第几位为0或1
function SetBit(n, bitIndex, zeroOrOne)
   local bit = GetBit(n, bitIndex)
   if bit == 0 and zeroOrOne == 1 then
    return n + 2 ^ bitIndex
   end
   if bit == 1 and zeroOrOne == 0 then
    return n - 2 ^ bitIndex
   end
   return n
end

function IsEmptyTable(tb)
	for k,v in pairs(tb) do
		return false
	end
	return true
end

function InsertArrayTable(tb,val)
	for i,v in ipairs(tb) do
		if v == val then
			return
		end
	end
	tb[#tb + 1] = val
end

function DeleteTable(tb)
	for k,v in pairs(tb) do
		tb[k] = nil
	end
end

function PrintTable(tb, step, steplmt)
	step = step or 0
	steplmt = steplmt or 10
	for k, v in pairs(tb) do
		local kk = k
		if type(kk) == "string" then
			kk = "\"" .. kk .. "\""
		end
		local vv = v
		if type(vv) == "string" then
			vv = "\"" .. vv .. "\""
		end
		print(string.rep("	", step), kk, "=", vv)
		if type(v) == "table" and step < steplmt then
			PrintTable(v, step + 1, steplmt)
		end
	end
end

function GDB()
	print("\n--------Begin GDB\n")
	local level = 2
	local info = debug.getinfo(level)
	print(info.source, info.name, info.currentline)
	for i = 1, math.huge do
		local name, value = debug.getlocal(level, i)
		if not name then break end
		print(name, "=", value)
	end
	print("\n--------End GDB\n")
end

function IncludeClassHeader(moduleName)
	loadfile((__SCRIPT_PATH__ or "") .. _convert("./scripts/公用/类定义.lua"))(moduleName)
end

function CopyTable(src,dst)
    for k,v in pairs(src) do
        local t = type(v)
        if t == "table" then
          if dst[k] == nil then
             dst[k] = {}
          end
          CopyTable(v, dst[k])
        elseif t == "number" or t == "string" or t == "boolean"  then
          dst[k] = v
        else
          assert(" can't copy ",t)
        end
    end
end

function CmpTable(a, b)
	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end
	for k, v in pairs(a) do
		if type(v) == "table" then
			if not CmpTable(v, b[k]) then
				return false
			end
		elseif v ~= b[k] then
			return false
		end
	end
	return true
end

function IsInOneDay(t)
	local curTime = os.time()
	local sub = t - curTime
	return -24 * 3600 < sub and sub < 24 * 3600 and os.date("%d", t) == os.date("%d", curTime)
end

function file2str(fileName, str)
	local f = io.open(fileName, "rb")
	if not f then
		return
	end
	local str = f:read("*all")
	assert(f:close())
	return 0 < #str and str
end

function str2file(str, fileName)
	local f = assert(io.open(fileName, "wb"))
	f:write(str)
	assert(f:close())
end

local function tb2str(s, t, step)
	step = step or 0
	for k, v in pairs(s) do
		table.insert(t, "\n")
		for i = 0, step do
			table.insert(t, "\t")
		end
		if type(k) == "number" then
			table.insert(t, "[")
		end
		table.insert(t, k)
		if type(k) == "number" then
			table.insert(t, "]")
		end
		table.insert(t, "=")
		if type(v) == "number" then
			table.insert(t, v)
		elseif type(v) == "string" then
			table.insert(t, "[[")
			table.insert(t, v)
			table.insert(t, "]]")
		else
			table.insert(t, "{")
			tb2str(v, t, step + 1)
			table.insert(t, "}")
		end
		if 0 < step then
			table.insert(t, ",")
		end
	end
end

function HotConfigFile(tb, filename)
	local t = {}
	table.insert(t, "module(..., package.seeall)\n")
	tb2str(tb, t)
	str2file(table.concat(t), "../scripts/phpconfig/" .. filename .. ".lua")
	Hot()
end

-- 随机一个[range_min, range_max]的数组
function GenerateRandomNumberArray(range_min, range_max)
    assert(range_min <= range_max, "range_min不能大于range_max")
    local result = {}
    local result_size = (range_max + 1) - range_min
    local cur_result_size = 0
    while (cur_result_size < result_size) do
        local generate_idx = math.random(1, result_size)
        if (result[generate_idx] == nil) then
            cur_result_size = cur_result_size + 1
            result[generate_idx] = range_min + cur_result_size - 1
        end
    end
    return result
end


function tabtostr( tab, is )
	if tab == nil then
		return nil
	end
	local result = "{"

	for k,v in pairs(tab) do
		if type(k) == "number" then
			if type(v) == "table" then
				result = string.format( "%s[%d]=%s,", result, k, tabtostr( v ,is) )
			elseif type(v) == "number" then
				result = string.format( "%s[%d]=%d,", result, k, v )
			elseif type(v) == "string" then
				result = string.format( "%s[%d]=%q,", result, k, v )
			elseif type(v) == "boolean" then
				result = string.format( "%s[%d]=%s,", result, k, tostring(v) )
			else
				if is then
					result = string.format("%s[%d]=%q,", result, k, type(v) )
				else
					error("the type of value is a function or userdata")
				end
			end
		else
			if type(v) == "table" then
				result = string.format( "%s%s=%s,", result, k, tabtostr( v, is ) )
			elseif type(v) == "number" then
				result = string.format( "%s%s=%d,", result, k, v )
			elseif type(v) == "string" then
				result = string.format( "%s%s=%q,", result, k, v )
			elseif type(v) == "boolean" then
				result = string.format( "%s%s=%s,", result, k, tostring(v) )
			else
				if is then
					result = string.format( "%s[%s]=%q,", result, k, type(v) )
				else
					error("the type of value is a function or userdata")
				end
			end
		end
	end
	result = result .. "}"
	return result
end


local EscapeTable = {
    ["\""] = "\\\"",
    ["\\"] = "\\\\",
}
function EscapeChatMessage(str)
    return string.gsub(str, "[\"\\]", EscapeTable)
end

--从文件获取文本
function GetStrFromFile(fileName)
	local f = io.open(fileName, "rb")
	if not f then
		return
	end
	local strs = {}
	while true do
		local str = f:read()
		if not str then
			break
		elseif str ~= "" and str ~= "\r" then
			strs[#strs+1] = str:sub(-1) == "\r" and str:sub(1,-2) or str
		end
	end
	assert(f:close())
	return strs
end

--写入文件
function PrintToFile(fileName, str)
	local f = assert(io.open(fileName, "wb"))
	if not f then
		return
	end
	f:write(str)
	assert(f:close())
end

--切割字符串
function SplitString(str, delim, empty)
	local strs = {}
	local p1 = 1
	local p2,p3 = str:find(delim, p1)
	while p2 do
		if empty or p2-1 >= p1 then
			strs[#strs+1] = str:sub(p1, p2-1)
		end
		p1 = p3 + 1--p2 + delim:len()
		p2,p3 = str:find(delim, p1)
	end
	if empty or str:len() >= p1 then
		strs[#strs+1] = str:sub(p1)
	end
	return strs
end

--合并字符串
function JoinString(strs, delim)
	local str = nil
	for i,v in ipairs(strs) do
		str = (str and str..delim or "")..v
	end
	return str or ""
end

--获取文件名
function GetFilename(str)
	local s = str:gsub("\\","/")
	local p
	p = s:find("/")
	while p do
		s = s:sub(p+1)
		p = s:find("/")
	end
	return s
end

--去掉后缀
function TrimPostfix(str)
	local s = str
	local p = s:find("%.")
	if p then
		s = s:sub(1, p-1)
	end
	return s
end

--去掉首尾空格
function TrimSpace(str)
	local s = str
	while s:sub(1,1) == " " or s:sub(1,1) == "\t" do
		s = s:sub(2)
	end
	while s:sub(-1,-1) == " " or s:sub(-1,-1) == "\t" do
		s = s:sub(1,-2)
	end
	return s
end

