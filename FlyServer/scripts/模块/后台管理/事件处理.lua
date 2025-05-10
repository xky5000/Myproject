module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 后台逻辑 = require("后台管理.后台逻辑")

CatchPayQuery = {}

function OnAdminLogic(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	if not 后台逻辑.catchhttpresp then
		return
	end
	后台逻辑.catchhttpresp = false
	if Config.CATCH_PAY_GAME ~= "" and not Config.DEBUG then
		--[[
		if #CatchPayQuery > 0 then
			_SetCrossServerInfo("47.104.193.32", 20000)
			_SendHttpRequest("/api/admin.php?method=catchpay&game="..Config.CATCH_PAY_GAME.."&server="..Config.SVRID.."&key="..Config.CATCH_PAY_KEY.."&account="..CatchPayQuery[1])
			table.remove(CatchPayQuery, 1)
		else
			_SetCrossServerInfo("47.104.193.32", 20000)
			_SendHttpRequest("/api/admin.php?method=catchpay&game="..Config.CATCH_PAY_GAME.."&server="..Config.SVRID.."&key="..Config.CATCH_PAY_KEY)
		end
		]]
	end
end
