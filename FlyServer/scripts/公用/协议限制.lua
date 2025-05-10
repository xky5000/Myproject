--[[
_SetPkLimit(协议ID.CG_CHAT, 3, 2)表示3秒2次
_SetPkLimit(协议ID.CG_CHAT, 3, 0)表示该功能在维护中
_SetPkLimit(协议ID.CG_CHAT, 0, 2)表示无限制
--]]
module(..., package.seeall)
local 协议ID = require("公用.协议ID")

function SetAllUnLimit()
	for k, v in pairs(协议ID) do
		if k:sub(1, 3) == "CG_" then
			_SetPkLimit(v, 0, 1)
		end
	end
end

local HashID = 0
for k, v in pairs(协议ID) do
	if k:sub(1, 3) == "CG_" or k:sub(1,3) == "SG_" or k:sub(1,3) == "GS_" then
		HashID = HashID + 1
		_SetHashPk(v, HashID)
		_SetPkLimit(v, 1, 3)	--默认所有的CG协议1秒3次
	end
end

_SetPkLimit(协议ID.CG_MOVE, 1, 20)
_SetPkLimit(协议ID.CG_MOVE_GRID, 1, 20)
_SetPkLimit(协议ID.CG_PICK_ITEM, 1, 20)
_SetPkLimit(协议ID.CG_USE_SKILL, 1, 20)
_SetPkLimit(协议ID.CG_ITEM_USE, 1, 20)
_SetPkLimit(协议ID.CG_ITEM_QUERY, 1, 20)
_SetPkLimit(协议ID.CG_CHANGE_STATUS, 1, 10)
_SetPkLimit(协议ID.CG_NPC_TALK, 1, 10)
_SetPkLimit(协议ID.CG_COLLECT_START, 1, 10)
_SetPkLimit(协议ID.CG_QUICK_SETUP, 1, 10)
_SetPkLimit(协议ID.CG_SKILL_QUICK_SETUP, 1, 10)
_SetPkLimit(协议ID.CG_DRAW_SRING, 1, 10)
_SetPkLimit(协议ID.CG_XP_USE, 1, 10)
--SetAllUnLimit()
