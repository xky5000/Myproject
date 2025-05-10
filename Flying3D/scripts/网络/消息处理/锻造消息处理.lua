module(..., package.seeall)

local 锻造UI = require("主界面.锻造UI")
local 主界面UI = require("主界面.主界面UI")

function GC_STRENGTHEN(result)
	if result == 0 then
		--主界面UI.showTipsMsg(0,txt("#s14,#c0x00ff00,强化成功"))
	end
end

function GC_STRENGTHEN_TRANSFER(result)
	if result == 0 then
		--主界面UI.showTipsMsg(0,txt("#s14,#c0x00ff00,强化转移成功"))
	end
end

function GC_REFINE_WASH(result)
	if result == 0 then
		--主界面UI.showTipsMsg(0,txt("#s14,#c0x00ff00,洗练成功"))
	end
end

function GC_REFINE_UPGRADE(result)
	if result == 0 then
		--主界面UI.showTipsMsg(0,txt("#s14,#c0x00ff00,提品成功"))
	end
end

function GC_PERFECT_PREVIEW(itemdata)
	if #itemdata > 0 then
		--锻造UI.updatePerfectGrid(itemdata[1])
	end
end

function GC_EQUIP_PREVIEW(prop)
end

function GC_STRENGTHEN_ALL(result)
end

