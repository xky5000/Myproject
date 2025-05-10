module(..., package.seeall)
local 实用工具 = require("公用.实用工具")
local 派发器 = require( "公用.派发器" )

WriteLog = _WriteLuaLog
Write = _WriteLuaLog

-- 1- 1000 给系统模块写开发日志使用
LOGID_MONITOR = 1				-- 系统核心数据监控
LOGID_USER_LOGIN = 2			-- 用户尝试登录
LOGID_USER_OUTLIFE = 3			-- 用户下线
LOGIN_SAVE_DB_ERR = 4			-- 存DB的报错
LOGIN_ADMIN_ERR   = 5           -- 后台http请求处理报错
LOGIN_PCALL_TIMER = 6			-- timerHandler的pcall报错

-- 1001-2000 给管理后台写统计日志使用
LOGID_OSS_LOGIN = 1001			-- 登录日志
LOGID_OSS_LOGOUT = 1002			-- 退出登录日志
LOGID_OSS_CREATEROLE = 1003		-- 创角日志
LOGID_OSS_LEVELUP = 1004         -- 升级日志
LOGID_OSS_TASK = 1005         -- 任务日志(接受,完成)
LOGID_OSS_ITEM = 1006         -- 物品日志(获得,拆分,丢弃)
LOGID_OSS_ITEMUSE = 1007         -- 物品使用日志
LOGID_OSS_EQUIP = 1008         -- 装备日志(获得,穿戴,丢弃)
LOGID_OSS_REFINE = 1009         -- 锻造日志
LOGID_OSS_COPYSCENE = 1010         -- 副本日志(进入,完成,离开)
LOGID_OSS_RECHARGE = 1011         -- 充值日志

function Init()
	--最后一个参数为分隔时间间隔单位s, 为0时不分隔
	_RegistLuaLogFile(LOGID_MONITOR, "./log/monitor", "totalcount[scene1|scene2|scene3]\n", 0)
	_RegistLuaLogFile(LOGID_USER_LOGIN, "./log/userlogin", "", 0)
	_RegistLuaLogFile(LOGID_USER_OUTLIFE, "./log/useroutlife", "", 0)
	_RegistLuaLogFile(LOGIN_SAVE_DB_ERR, "./log/error_pcall_savedb", "", 0)
	_RegistLuaLogFile(LOGIN_ADMIN_ERR, "./log/admin", "", 0)
	_RegistLuaLogFile(LOGIN_PCALL_TIMER, "./log/error_pcall_timer", "", 0)
	_RegistLuaLogFile(LOGID_OSS_LOGIN, "./log/oss_login", "mdate,mtime,account_name,role_name,level,ip\n", 300)
	_RegistLuaLogFile(LOGID_OSS_LOGOUT,"./log/oss_logout","mdate,mtime,account_name,role_name,level,online_time,ip,reason,map_id,map_x,map_y\n",300)
	_RegistLuaLogFile(LOGID_OSS_CREATEROLE, "./log/oss_createrole", "mdate,mtime,account_name,role_name,sex,job,agent\n", 300)
	_RegistLuaLogFile(LOGID_OSS_TASK, "./log/oss_task", "mdate,mtime,account_name,role_name,taskid,state\n", 300)
	_RegistLuaLogFile(LOGID_OSS_RECHARGE, "./log/oss_recharge", "mdate,mtime,account_name,role_name,recharge,agent\n", 300)
end
