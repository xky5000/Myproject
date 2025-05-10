module(..., package.seeall)

local ItemProtocol = require("物品.协议")

CG_MAIL_QUERY = {
}

MailInfo = {
    { "id", "INT", 1},		    -- id
    { "name", "CHAR", 2},		    -- 标题
    { "sender", "CHAR", 2},		    -- 发送者
    { "time", "INT", 1},		    -- 时间
    { "content", "CHAR", 2},		    -- 内容
    { "grids", ItemProtocol.ItemData, 10},		    -- 附件
    { "status", "CHAR", 1},		    -- 0未开启,1已开启,2已领取
}

GC_MAIL_LIST = {
    { "type", "char", 1},		    -- 0查询,1更新
    { "info", GuildInfo, 50},
}

CG_MAIL_DRAW = {
    { "id", "INT", 1},		    -- id
}

CG_MAIL_DELETE = {
    { "id", "INT", 1},		    -- id
}
