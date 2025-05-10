module(..., package.seeall)

function indexOf(tb, val)
	for i,v in ipairs(tb) do
		if v == val then
			return i
		end
	end
end

--[[function splitString(str, delim)
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
end]]

function IsEmptyTable(tb)
	for k,v in pairs(tb) do
		return false
	end
	return true
end

function CountString(str, delim)
	local cnt = 0
	local p1 = 1
	local p2 = str:find(delim, p1)
	while p2 do
		if empty or p2-1 >= p1 then
			cnt = cnt + 1
		end
		p1 = p2 + delim:len()
		p2 = str:find(delim, p1)
	end
	if empty or str:len() >= p1 then
		cnt = cnt + 1
	end
	return cnt
end

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

function JoinString(strs, delim)
	local str = nil
	for i,v in ipairs(strs) do
		str = (str and str..delim or "")..v
	end
	return str
end

function GetDistance(x1,y1,x2,y2)
	if x2 == nil or y2 == nil then
		return math.sqrt(x1 * x1 + y1 * y1)
	else
		return math.sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1))
	end
end

function GetDistanceSq(x1,y1,x2,y2)
	if x2 == nil or y2 == nil then
		return x1 * x1 + y1 * y1
	else
		return (x2-x1) * (x2-x1) + (y2-y1) * (y2-y1)
	end
end

function GetNormalize(norm,x1,y1,x2,y2)
	if norm == 0 then
		return 0,0
	end
	local len = GetDistance(x1,y1,x2,y2)
	if len == 0 then
		return 0,0
	end
	if x2 == nil or y2 == nil then
		return x1*norm/len,y1*norm/len
	else
		return (x2-x1)*norm/len,(y2-y1)*norm/len
	end
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

function setClipNumber(num, clip, center, pushzero)
	local width = clip:getWidth()
	local clips = F3DPointVector:new()
	clips:clear()
	if num == 0 then
		clips:push(0, -clips:size()*width)
	else
		while num >= 1 do
			clips:push(math.floor(num%10), -clips:size()*width)
			num = num / 10
		end
	end
	if clips:size() == 1 and pushzero then
		clips:push(0, -clips:size()*width)
	end
	clip:setBatchClips(10, clips)
	clip:setOffset(center and -width+clips:size()*width/2 or -width+clips:size()*width, 0)
end
