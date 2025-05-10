module(..., package.seeall)

CG_TEAM_TEAMMATE = {
}

TeammateInfo = {
    { "rolename", "CHAR", 2},		    -- 角色名字
    { "job", "CHAR", 1},		    -- 职业
    { "sex", "CHAR", 1},		    -- 性别
    { "level", "SHORT", 1},		    -- 等级
    { "转生等级", "CHAR", 1},		    -- 转生等级
    { "weaponicon", "SHORT", 1},		    -- 武器icon
    { "bodyicon", "SHORT", 1},		    -- 衣服icon
    { "toukuiicon", "SHORT", 1},		    -- 头盔icon
    { "mianjinicon", "SHORT", 1},		    -- 面巾icon
}

GC_TEAM_TEAMMATE = {
    { "info", TeammateInfo, 5},		    -- 角色名字
}

CG_TEAM_SETUP = {
    { "refuse1", "CHAR", 1},		    -- 队伍拒绝邀请
    { "refuse2", "CHAR", 1},		    -- 队伍拒绝申请
}

CG_TEAM_CREATE = {
}

CG_TEAM_ADDMEMBER = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

GC_TEAM_INVITE = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

CG_TEAM_INVITE = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

CG_TEAM_DELMEMBER = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

CG_TEAM_LEAVE = {
}

CG_TEAM_DISMISS = {
}

CG_TEAM_TRANSFER = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

CG_TEAM_APPLYENTER = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

GC_TEAM_APPLY = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

CG_TEAM_APPLY = {
    { "rolename", "CHAR", 64},		    -- 角色名字
}

TeamInfo = {
    { "captain", "CHAR", 2},		    -- 队长名字
    { "job", "CHAR", 1},		    -- 队长职业
    { "level", "SHORT", 1},		    -- 队长等级
    { "转生等级", "CHAR", 1},		    -- 转生等级
    { "number", "CHAR", 1},		    -- 队伍人数
    { "guildname", "CHAR", 2},		    -- 队长行会
}

CG_TEAM_NEARBY_TEAM = {
}

GC_TEAM_NEARBY_TEAM = {
    { "info", TeamInfo, 50},		    -- 角色名字
}

MemberInfo = {
    { "rolename", "CHAR", 2},		    -- 角色名字
    { "job", "CHAR", 1},		    -- 职业
    { "level", "SHORT", 1},		    -- 等级
    { "转生等级", "CHAR", 1},		    -- 转生等级
    { "zhanli", "INT", 1},		    -- 战力
    { "guildname", "CHAR", 2},		    -- 队长行会
}

CG_TEAM_NEARBY_MEMBER = {
}

GC_TEAM_NEARBY_MEMBER = {
    { "info", MemberInfo, 50},		    -- 角色名字
}
