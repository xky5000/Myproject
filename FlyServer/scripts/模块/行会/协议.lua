module(..., package.seeall)

CG_GUILD_QUERY = {
}

GuildInfo = {
    { "ranking", "SHORT", 1},		    -- 排名
    { "guildname", "CHAR", 2},		    -- 行会名称
    { "chairman", "CHAR", 2},		    -- 会长名字
    { "level", "SHORT", 1},		    -- 等级
    { "number", "SHORT", 1},		    -- 人数
    { "zhanli", "INT", 1},		    -- 总战力
    { "funds", "INT", 1},		    -- 行会资金
    { "status", "CHAR", 1},		    -- 0未加入,1已申请,2已加入,3已挑战,4已联盟,5已有行会
}

GC_GUILD_LIST = {
    { "info", GuildInfo, 100},
}

CG_GUILD_MEMBER = {
}

MemberInfo = {
    { "rolename", "CHAR", 2},		    -- 角色名字
    { "job", "CHAR", 1},		    -- 职业
    { "level", "SHORT", 1},		    -- 等级
    { "转生等级", "CHAR", 1},		    -- 转生等级
    { "zhanli", "INT", 1},		    -- 战力
    { "zhiwei", "CHAR", 1},		    -- 职位:3会长,2副会长,1管理员,0成员
    { "gongxian", "INT", 1},		    -- 贡献
    { "status", "CHAR", 1},		    -- 1在线,0离线
}

GC_GUILD_MEMBER = {
    { "guild", GuildInfo, 2},
    { "member", MemberInfo, 100},
}

CG_GUILD_RECORD = {
    { "type", "CHAR", 1},		    -- 类型0,1,2
}

RecordInfo = {
    { "record", "CHAR", 2},		    -- 日志信息
    { "time", "INT", 1},		    -- 时间
    { "rolename", "CHAR", 2},
    { "type", "CHAR", 1},		    -- 类型0申请,1挑战,2结盟
}

GC_GUILD_RECORD = {
    { "info", RecordInfo, 100},
}

CG_GUILD_CREATE = {
    { "guildname", "CHAR", 64},
}

CG_GUILD_LEAVE = {
}

CG_GUILD_KICK = {
    { "rolename", "CHAR", 64},
}

CG_GUILD_ADJUST = {
    { "rolename", "CHAR", 64},
    { "zhiwei", "CHAR", 1},		    -- 职位:3会长,2副会长,1管理员,0成员
}

CG_GUILD_APPLY = {
    { "guildname", "CHAR", 64},
}

CG_GUILD_APPLYAGREE = {
    { "rolename", "CHAR", 64},
    { "agree", "CHAR", 1},		    -- 1同意,0拒绝
}

CG_GUILD_CHALLENGE = {
    { "guildname", "CHAR", 64},
    { "funds", "INT", 1},		    -- 挑战资金
}

CG_GUILD_CHALLENGEAGREE = {
    { "guildname", "CHAR", 64},
    { "agree", "CHAR", 1},		    -- 1同意,0拒绝
}

CG_GUILD_ALLIANCE = {
    { "guildname", "CHAR", 64},
    { "funds", "INT", 1},		    -- 结盟资金
}

CG_GUILD_ALLIANCEAGREE = {
    { "guildname", "CHAR", 64},
    { "agree", "CHAR", 1},		    -- 1同意,0拒绝
}

CG_GUILD_DONATE = {
    { "funds", "INT", 1},		    -- 贡献资金
}

CG_GUILD_LEVELUP = {
}

CG_GUILD_ATTACKCASTLE = {
    { "castleid", "CHAR", 1},		    -- 1比奇皇宫,2封魔皇宫,3沙巴克
}

CG_GUILD_ATTACKMAP = {
}

CG_GUILD_CHALLENGEMAP = {
}

CG_GUILD_CASTLEINFO = {
}

CastleInfo = {
    { "castleid", "CHAR", 1},		    -- 1比奇皇宫,2封魔皇宫,3沙巴克
    { "guildname", "CHAR", 2},
    { "attackguild", "CHAR", 2},
    { "daytime", "SHORT", 1},		    -- 攻城时间
}

GC_GUILD_CASTLEINFO = {
    { "info", CastleInfo, 20},
}
