module(..., package.seeall)

CG_CHAT = {
	{ "msgtype", "SHORT", 1 },		-- 聊天类型
    { "msg", "CHAR", 256 },		-- 聊天信息
}

GC_CHAT = {
    { "rolename", "CHAR", 64},		    -- 角色名字
    { "objid", "INT", 1},		    -- 角色ID
	{ "msgtype", "SHORT", 1 },		    -- 聊天类型
    { "msg", "CHAR", 2},		    -- 返回信息
}
