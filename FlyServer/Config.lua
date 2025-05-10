module(..., package.seeall)
--=================================================================
ISGAMESVR = true	-- true表示是正常server false表示是跨服server
-- DEBUG = false		-- true的话表示是测试模式 gm指令等都可以用 正式服需要设置为false
DEBUG = true		-- true的话表示是测试模式 gm指令等都可以用 正式服需要设置为false
IS3G = false
ISWZ = false
ISLT = true
ISZY = false
MERGEDB = false
MERGEST = false

GAME_IO_LISTEN_PORT = 5020			-- Logic接入端口
GAME_HTTP_LISTEN_PORT = 10000		-- Http接入端口
MEMORY_USE = 1						-- 这里只能填 1 2 3 4 设置内存占用 4为最大 1为最小 0为内部开发 开服的话要设置>0
MEMORY_THRESHOLD = 3700				-- 内存阈值 单位M 超过此值 服务端会踢掉所有人 然后重启 windows才生效 高枕无忧

--开服相关
--ADMIN_KEY   = ""		--管理http接口key
--ADMIN_AGENT = "aiwan"		--代理

D_GAME = "幽兰传奇"
SERVER_NAME = D_GAME		--游戏名
D_getQQ = "312948690"	
SERVER_IP = "127.0.0.1"		--服务器IP
-- SERVER_IP = "103.85.84.97"		--服务器IP
WEBSITE = ""				--游戏官网
BBSSITE = ""				--游戏论坛

CATCH_PAY_GAME = D_GAME		--充值游戏名
CATCH_PAY_KEY = ""			--充值KEY
LOG_QUERY_KEY = ""	--日志查询KEY
GM_ACCOUNT = "a"		--GM账号
GAME_NAME = D_GAME .. " 官方QQ群:#cff00,"..D_getQQ.." 微端正在拼命加载中·····"	--欢迎提示

--充值配置
PAY_CHANNEL_ID = 0 --充值ID
PAYWEB_CHANNEL_URL = ""
PAYWEB_CHANNEL_PORT = "99"
--充值地址分区dx
PAY_CHANNEL_URL = {
"",
"",
"",
"",
"",
""
}

MAX_ONLINE_NUM = MAX_ONLINE_NUM or 300			-- 最大同时在线人数
DAY_RESTART_TIME = {8,00}		--服务器每天重启时间 每天早上8点
LOGIN_IP_MAX = 3				--最大同时在线IP数


--口 名字过滤
FILTER_CHAT = "内服,管理,GM,gm,拖服,都是拖,tuo,加我QQ,QQ,qq,微信,wei信,威信,托,垃圾服,垃圾fu,麻痹,妈逼,妈,操,内服,内fu,nei服,neifu,手机,手机号,服,fu,拖,托,tuo,laji,啦级,辣鸡,内,内fu,比例,比例服,比,例,比例fu,内服,GM,管理,内fu,托服,拖服,垃圾服,垃圾fu,荣耀GM,麻痹,妈逼,妈,爸,爷,孙子,坟头,拖真多,拖,托,奶,娘,女,马,屄,nei,fu,拖,托,服,fu,F,f,nf,tu,tuo,循环,内f,内,nei,充钱,别充钱,没法玩,别冲,r,m,rmb,RMB,内福,付,福,副,富,负,夫,复,內,㐻,㘨,呐i,NEI,讷,吶i,㘨,訥,有tuo,tuo真多,tuo多,游戏,游戏有tuo,隐藏属性,隐,藏,隐藏,属性,鼠,鼠性,鼠姓,内附乱比莉,附,富,府,符,扶,浮,比利,比例,臂力,笔力,笔立,比里,乱,管李乱比莉,馆里,管,管理,馆立,老区,死,老区二刀死,老区一刀死,老区三刀死,老区四刀死,活人,活,没人,没几个,没几个活人,坑,吭,阬,千万,隐c鼠姓f,"		--聊天过滤

--口 聊天过滤
FILTER_NAME = "内服,GM,管理,内fu,托服,拖服,垃圾服,垃圾fu,麻痹,妈逼,妈,爸,爷,孙子,坟头,拖真多,拖,托,奶,娘,女,马,屄,nei,fu,拖,托,服,fu,F,f,nf,tu,tuo,循环,内f,内,nei,充钱,别充钱,没法玩,别冲,r,m,rmb,RMB,内福,付,福,副,富,负,夫,复,內,㐻,㘨,呐i,NEI,讷,吶i,㘨,訥,有tuo,tuo真多,tuo多,游戏,游戏有tuo,隐藏属性,隐,藏,隐藏,属性,鼠,鼠性,鼠姓,内附乱比莉,附,富,府,符,扶,浮,比利,比例,臂力,笔力,笔立,比里,乱,管李乱比莉,馆里,管,管理,馆立,老区,死,老区二刀死,老区一刀死,老区三刀死,老区四刀死,活人,活,没人,没几个,没几个活人,坑,吭,阬,千万,隐c鼠姓f,老区秒人,秒人,一刀秒,"		--名字过滤

-- 正常游戏服相关字段 跨服pk服可不配置
DBIP="127.0.0.1"		--数据库IP
DBNAME="f1"				--数据库名
DBUSER="test"			--数据库账号
DBPWD="test123"			--数据库密码


SVRNAME="f1."		-- 服务器名
SVRID=0			-- 服务器id
AGENTID=0		-- 代理商id
CHECKAUTH = false	-- 登录验证是否开启
USESVR = true

MSVRIP="127.0.0.1"
MSVRPORT=20000
MSVRHTTPPORT=30000

-- 跨服pk服相关字段 正常游戏服可不配置
GSVR = {}
GSVR[1] = {svrName="[01]", ip="127.0.0.1", ioPort = 5000, httpPort = 10000, dbIP = "127.0.0.1", dbName = "c4", dbUser="test", dbPwd = "test123"}
