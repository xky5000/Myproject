module(..., package.seeall)

local 行会UI = require("主界面.行会UI")

function GC_GUILD_MEMBER(guild,member)
	行会UI.设置行会信息(guild)
	行会UI.设置行会成员(member)
end

function GC_GUILD_RECORD(info)
	行会UI.设置行会日志(info)
end

function GC_GUILD_LIST(info)
	行会UI.设置行会列表(info)
end

function GC_GUILD_CASTLEINFO(info)
	行会UI.设置城堡信息(info)
end

