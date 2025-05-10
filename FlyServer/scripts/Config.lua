module(..., package.seeall)

ISGAMESVR = true	-- true表示是正常server false表示是跨服server
DEBUG = true		-- true的话表示是测试模式 gm指令等都可以用 正式服需要设置为false
IS3G = false
ISWZ = false
ISLT = true
ISZY = false
MERGEDB = false
MERGEST = false

GAME_IO_LISTEN_PORT = 5020			-- Logic接入端口
GAME_HTTP_LISTEN_PORT = 10000		-- Http接入端口
MEMORY_USE = 0						-- 这里只能填 1 2 3 4 设置内存占用 4为最大 1为最小 0为内部开发 开服的话要设置>0
MEMORY_THRESHOLD = 3700				-- 内存阈值 单位M 超过此值 服务端会踢掉所有人 然后重启 windows才生效 高枕无忧
--开服相关
ADMIN_KEY   = ""		--管理http接口key
ADMIN_AGENT = "aiwan"		--代理

SERVER_NAME = "复古征途"		--游戏名
SERVER_IP = "127.0.0.1"		--服务器IP
WEBSITE = ""				--游戏官网
BBSSITE = ""				--游戏论坛

CATCH_PAY_GAME = "复古征途"		--充值游戏名
CATCH_PAY_KEY = ""			--充值KEY
LOG_QUERY_KEY = ""	--日志查询KEY
GM_ACCOUNT = "1"		--GM账号
GAME_NAME = "复古征途#C 游戏Q群:#cff00,996900302"	--欢迎提示
PAY_CHANNEL_ID = 76548
MAX_ONLINE_NUM = MAX_ONLINE_NUM or 3000			-- 最大同时在线人数

-- 正常游戏服相关字段 跨服pk服可不配置
DBIP="127.0.0.1"		--数据库IP
DBNAME="s0"				--数据库名
DBUSER="test"			--数据库账号
DBPWD="test123"			--数据库密码

SVRNAME="s0."		-- 服务器名
SVRID=0				-- 服务器id
AGENTID=1			-- 代理商id
CHECKAUTH = false	-- 登录验证是否开启
USESVR = true

MSVRIP="127.0.0.1"
MSVRPORT=20000
MSVRHTTPPORT=30000

-- 跨服pk服相关字段 正常游戏服可不配置
GSVR = {}
GSVR[1] = {svrName="[01]", ip="127.0.0.1", ioPort = 5000, httpPort = 10000, dbIP = "127.0.0.1", dbName = "c4", dbUser="test", dbPwd = "test123"}
