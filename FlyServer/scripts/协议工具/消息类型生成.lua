local PacketID = require(arg[1])
local str = ""
local IdToStr = {}
for k, v in pairs(PacketID) do
    if k:sub(1, 2) == "CG" or k:sub(1, 2) == "GC" then
        table.insert(IdToStr, {v, k})
    end
end

table.sort(IdToStr, function(a, b) return a[1] < b[1] end)
for _, v in pairs(IdToStr) do
    str = str .. v[2] .. " = " .. v[1] .. "\n"
end

str = [[
module(..., package.seeall)

]]..str..[[

]]

function PrintToFile(fileName, str)
	local f = assert(io.open(fileName, "wb"))
	if not f then
		return
	end
	f:write(str)
	assert(f:close())
end

PrintToFile(arg[2], str)