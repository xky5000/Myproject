module(..., package.seeall)

local 队伍UI = require("主界面.队伍UI")
local 消息框UI1 = require("主界面.消息框UI1")
local 消息 = require("网络.消息")

function GC_TEAM_TEAMMATE(info)
	队伍UI.设置队友信息(info)
end

function GC_TEAM_NEARBY_TEAM(info)
	队伍UI.设置附近队伍(info)
end

function GC_TEAM_NEARBY_MEMBER(info)
	队伍UI.设置附近玩家(info)
end

function GC_TEAM_INVITE(rolename)
	消息框UI1.initUI()
	消息框UI1.setData(txt("#cffff00,"..rolename.."#C邀请你加入队伍，是否同意？"),function()
		消息.CG_TEAM_INVITE(rolename)
	end)
end

function GC_TEAM_APPLY(rolename)
	消息框UI1.initUI()
	消息框UI1.setData(txt("#cffff00,"..rolename.."#C申请加入你的队伍，是否同意？"),function()
		消息.CG_TEAM_APPLY(rolename)
	end)
end

