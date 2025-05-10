module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 邮件管理 = require("邮件.邮件管理")

function CG_GUILD_QUERY(human, msg)
	邮件管理.SendMailList(human)
	return true
end

function CG_MAIL_DRAW(human, msg)
	邮件管理.SendMailDraw(human, msg.id)
	return true
end

function CG_MAIL_DELETE(human, msg)
	邮件管理.SendMailDelete(human, msg.id)
	return true
end
