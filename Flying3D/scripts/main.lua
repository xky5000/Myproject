print("__PLATFORM__",__PLATFORM__)
for k,v in pairs(__ARGS__) do
	print("__ARGS__",k,v,type(v))
end
__ARGS__.account = "loon"
--__ARGS__.server = 1

F3DAssets.ASSETS_URL = "http://113.125.78.208:6060/assets"

--F3DAssets.ASSETS_URL = "C:/x/projs/assets"
F3DAssets.ASSETS_URL = __SCRIPT_PATH__.."assets"--

F3DAssets.RES_CACHE = true
F3DDefaultEntity.DEFAULT_MESH_URL = "/res/tex/9999/9999.mesh"
F3DRenderer.sSimpleAvatar = false
F3DAvatar.sLoadUsePack = true
F3DImageAnim3D.sUseEntityPool = false
F3DImageAnim3D.sUseEffectSystemPool = false
F3DImageAnim3D:initPartOrder()
ISMIR2D = true
ISMIRUI = true
IS3G = false
ISWZ = false
ISLT = true
ISZY = false
MOVEGRID = true
MOVEQUERY = false
LEFTMOVE = true
ATTACKDIST = 240
PICKDIST = 40
RANGEOFFSET = 1
显示名字 = 0
快捷传送 = 0
隐藏任务界面 = 1
ITEMICON = 0
UIPATH = ISZY and "/res/ui/" or "/res/ui/"
GAMENAME = {"复古征途","fgzt"}

--资源更新版本,更改后无需清理缓存
URLVERSIONS = {
	{UIPATH.."背包UI.layout",0},
	{UIPATH.."主界面UI.layout",1},
	{UIPATH.."战斗界面UIm.layout",2},
	{UIPATH.."小地图UI.layout",2},
	{UIPATH.."小地图UIm.layout",2},
	{UIPATH.."血条UI.layout",1},
	{UIPATH.."血条UIm.layout",1},
	{UIPATH.."消息框UI1.layout",1},
	{UIPATH.."消息框UI1m.layout",2},
	{UIPATH.."行会UI.layout",1},
	{UIPATH.."行会UIm.layout",1},
	{UIPATH.."活动UI.layout",1},
	{UIPATH.."活动UIm.layout",1},
	{UIPATH.."宠物信息UI.layout",1},
	{UIPATH.."宠物信息UIm.layout",1},
	{UIPATH.."聊天UIm.layout",1},
	{UIPATH.."任务追踪UIm.layout",1},
	{UIPATH.."获得提示UIm.layout",1},
	{UIPATH.."Boss副本UI.layout",1},
	{UIPATH.."Boss副本UIm.layout",2},
	{UIPATH.."商城UI.layout",1},
	{UIPATH.."商城UIm.layout",1},
	{UIPATH.."商店UI.layout",1},
	{UIPATH.."商店UIm.layout",1},
	{UIPATH.."Npc对话UI.layout",1},
	{UIPATH.."Npc对话UIm.layout",1},
	{UIPATH.."角色UI.layout",2},
	{UIPATH.."角色UIm.layout",3},
	{UIPATH.."锻造UI.layout",2},
	{UIPATH.."锻造UIm.layout",2},
	{UIPATH.."福利UI.layout",2},
	{UIPATH.."福利UIm.layout",3},
}
for i,v in ipairs(URLVERSIONS) do
	F3DAssets:setUrlVersion(v[1], v[2])
end

--预加载贴图,别名
local PRELOAD_URLS =
{
	{"/res/tex/white.png", "tex_white"},
	{"/res/tex/black.png", "tex_black"},
	{"/res/tex/normal.png", "tex_normal"},
	{"/res/tex/shadow.png", "tex_shadow"},
	{"/res/tex/unknown.png", "tex_unknown"},
	{"/res/tex/noise.png", "tex_noise"},
	{"/res/tex/default.png", "tex_default"},
}
for i,v in ipairs(PRELOAD_URLS) do
	--F3DAssets:instance():setTextureAlias(v[1],v[2])
	F3DAssets:instance():loadTexture(v[1], v[2], F3DFunction:new(function (tex) tex:retain() end,"F3DObject"))
end
--F3DAssets:instance():loadFile("/res/tex/common.pack", F3DFunction:new(function (pack) pack:retain() end,"F3DObject"))

--事件监听
function func_n(func)
	return F3DFunction:new(func)
end

function func_o(func)
	return F3DFunction:new(func,"F3DObject")
end

function func_d(func)
	return F3DFunction:new(func,"F3DData")
end

function func_e(func)
	return F3DFunction:new(func,"F3DEvent")
end

function func_oe(func)
	return F3DFunction:new(func,"F3DObjEvent")
end

function func_me(func)
	return F3DFunction:new(func,"F3DMouseEvent")
end

function func_ke(func)
	return F3DFunction:new(func,"F3DKeyboardEvent")
end

function func_te(func)
	return F3DFunction:new(func,"F3DTouchEvent")
end

function func_ue(func)
	return F3DFunction:new(func,"F3DUIEvent")
end

--全局函数
function chsize(char)
	if not char then
		return 0
	elseif char > 240 then
		return 4
	elseif char > 225 then
		return 3
	elseif char > 192 then
		return 2
	else
		return 1
	end
end
--dxs取文本数量
function utf8len(str)
	local len = 0
	local currentIndex = 1
	while currentIndex <= #str do
		local char = string.byte(str, currentIndex)
		currentIndex = currentIndex + chsize(char)
		len = len +1
	end
	return len
end
--dxs取文本数量相加
function utf8sub(str, startChar, numChars)
	local startIndex = 1
	while startChar > 1 do
		local char = string.byte(str, startIndex)
		startIndex = startIndex + chsize(char)
		startChar = startChar - 1
	end

	local currentIndex = startIndex

	while numChars > 0 and currentIndex <= #str do
		local char = string.byte(str, currentIndex)
		currentIndex = currentIndex + chsize(char)
		numChars = numChars -1
	end
	return str:sub(startIndex, currentIndex - 1)
end

function autoLine(str,lineNum)
	local num = utf8len(str)
	if num <= lineNum then
		return str
	end
	
	local index = math.ceil(num / lineNum)
	local ss = ""
	
	for n = 1,index do
		local i = (n - 1) * lineNum + 1
		ss = ss..utf8sub(str,i,lineNum).."\n"
	end	
	
	return ss
end

function txt(str)
	return F3DPlatform:instance():convert(str)
end

function utf8(str)
	return F3DPlatform:instance():convert(str, false)
end

function tt(obj,class)
	return F3DPlatform:instance():typeTransform(obj,class.sType)
end

function uri(str)
	return F3DAssets.ASSETS_URL:find("http:") == 1 and F3DUtils:encodeURI(str) or txt(str)
end

function rtime()
	return F3DScheduler:instance():getRunningTime()
end
--gdb
function gdb()
	print(debug.traceback())
end

function topui()
	for i = uiLayer:numChildren() - 1, 0, -1 do
		if uiLayer:getChildAt(i):isVisible() then
			return uiLayer:getChildAt(i)
		end
	end
end

function tdisui(ui)
	for i = ui:numChildren() - 1, 0, -1 do
		ui:getChildAt(i):setTouchable(false)
	end
end

--加载脚本
_require = require
require = function(str)
	return _require(txt(str))
end

CAMERA_RATE = 2
ORTHO_CAMERA_RATE = 1/math.sqrt(CAMERA_RATE*CAMERA_RATE-1)

function setCameraRate(rate)
	CAMERA_RATE = rate
	ORTHO_CAMERA_RATE = 1/math.sqrt(CAMERA_RATE*CAMERA_RATE-1)
end

function to3d(y)
	return -y*CAMERA_RATE
end

function to2d(y)
	return -y/CAMERA_RATE
end

function toshuzhi(num)
	local 数值,左边,中间,右边,长度,文本 = "","","","",string.len(tostring(num)),tostring(num)
	
	if(长度 <= 2) then
		右边 = num.."文"
	elseif(长度 > 2 and 长度 <= 4) then
		中间 = string.sub(文本,0,长度 - 2).."两"
		右边 = string.sub(文本,长度 - 1,长度).."文"
	else
		左边 = string.sub(文本,0,长度 - 4).."锭"
		中间 = string.sub(文本,长度 - 3,长度 - 2).."两"
		右边 = string.sub(文本,长度 - 1,长度).."文"
	end

	数值 = 左边..中间..右边
	
	return txt(数值)
end

--舞台+层(全局)
--设置名称标题
stage = F3DStage:instance()
stage:setColor(0,0,0)--0.4,0.4,0.4)
stage:setSize(1024, 768)--960, 540--1120, 630--1280, 720
if IS3G then
	stage:setTitle(txt("乱斗三国 - "..(__ARGS__.account or "").." "..(__ARGS__.server or 0).."服 - Q群 996900302 - F5刷新 F11全屏 HOME键隐藏"))
elseif ISWZ then
	stage:setTitle(txt("王者之路 - "..(__ARGS__.account or "").." "..(__ARGS__.server or 0).."服 - Q群 996900302 - F5刷新 F11全屏 HOME键隐藏"))
elseif ISLT and not ISZY then
	stage:setTitle(txt("复古征途[三端] - "..(__ARGS__.account or "").." "..(__ARGS__.server or 0).."服 - Q群 996900302 - 老板键[HOME键]隐藏窗口"))
	stage:setIconFile("/res/icon/ico/zhengtu.ico")
	stage:setCursorFile("/res/icon/ico/mir.cur")
else
	stage:setTitle(txt(GAMENAME[1].." - "..(__ARGS__.account or "").." "..(__ARGS__.server or 0).."服 - F5刷新 F11全屏 HOME键隐藏"))
	stage:setIconFile("/res/icon/ico/zhengtu.ico")
	stage:setCursorFile("/res/icon/ico/mir.cur")
end

grabimage = F3DGrabImage:instance()
grabimage:setShaderType(F3DImage.SHADER_WARP)
grabimage:createTexture(stage:getWidth(),stage:getHeight())
mapLayer = F3DLayer:mapLayer()
grabimage:setTargetLayer(mapLayer)
stage:addChild(grabimage)
stage:addChild(mapLayer)

rolecont = F3DObj3D:new()
mapLayer:addChild(rolecont)

effectLayer = F3DLayer:effectLayer()
mapLayer:addChild(effectLayer)
--dxs地图类初始化
shadowMap = F3DShadowMap:instance()
shadowMap:createTexture(2048, 2048)
shadowMap:getCamera():ortho(4000, 4000, 1, 10000)
shadowMap:setTarget(rolecont)
reflectionMap = F3DReflectionMap:instance()
reflectionMap:createTexture(512, 512)
reflectionMap:getCamera():perspective(45, stage:getWidth(), stage:getHeight(), 1, 10000)
reflectionMap:setTarget(rolecont)
reflectionMap:setTargetEx(F3DObjectVector:new())

uiLayer = F3DLayer:uiLayer()
stage:addChild(uiLayer)

F3DUIManager:init(uiLayer)

hpcont = F3DDisplayContainer:new()
uiLayer:addChild(hpcont)

dechpcont = F3DDisplayContainer:new()
uiLayer:addChild(dechpcont)

shapeLayer = F3DLayer:shapeLayer()
stage:addChild(shapeLayer)

--stage:showStatus(true,0,100,12)

--lua文件路径
function AppendPath(path)
	local tmp = ";./scripts/" .. path
	if not string.find(package.path, tmp, 1, true) then
		package.path = package.path .. tmp
	end
end

--dxs引入脚本
AppendPath("?.lua")
AppendPath(txt("模块/?.lua"))

--外部类
local 消息 = require("网络.消息")
消息.init()

--dxs网络类
local 全局设置 = require("公用.全局设置")
local 网络连接 = require("公用.网络连接")
local 消息框UI1 = require("主界面.消息框UI1")

m_ReconnectTxt = ""
m_ReconnectCnt = 0

g_mapPriority = 5000000
g_rolePriority = 2000000
g_uiPriority = 3000000
g_uiFastPriority = 3000000
g_mapTilePriority = -1000000

g_is3D = false
g_scene = nil
g_sceneEffect = nil
g_map = nil
g_mapid = 0
g_mapfileid = ""
g_mapdirname = ""
g_mapWidth = 0
g_mapHeight = 0
g_mapLoaded = false
g_roles = {}
g_items = {}
g_role = nil
g_skill = {}
g_movePoints = nil
g_movePoint = nil
g_skillkeycode = nil
g_skillkeytime = 0
g_usexpskill = false
g_heartbeatcnt = 0
g_dologiccnt = 0
g_target = nil
g_hoverPos = {x=0,y=0}
g_hoverObj = nil
g_attackObj = nil
g_autoAttack = false
g_cameraLength = (stage:getHeight()/2)/math.tan(22.5*math.pi/180)
g_targetPos = {x=0,y=0,bodyid = 0}
g_showStatus = false
g_firstEnterGame = true
g_autoPickItem = false
g_openSound = true
g_mapsafeanims = {}
g_moveUp = false
g_moveDown = false
g_moveLeft = false
g_moveRight = false
g_movedir = F3DPoint:new()
g_moveDirDown = false
g_moveDirTime = 0
g_moveUpTime = 0
g_moveDownTime = 0
g_moveLeftTime = 0
g_moveRightTime = 0
--设置平台
g_mobileMode = __PLATFORM__ == "ANDROID" or __PLATFORM__ == "IOS"
--g_mobileMode = true
g_downfindPath = false
g_pickitemtime = 0
g_UsePool = true
g_ItemPool = {}
g_RolePool = {}

function getRolePriority()
	g_rolePriority = g_rolePriority - 1
	if g_rolePriority < 1000000 then
		g_rolePriority = 2000000
	end
	return g_rolePriority
end

function getUIPriority()
	g_uiPriority = g_uiPriority - 1
	if g_uiPriority < 2000000 then
		g_uiPriority = 3000000
	end
	return g_uiPriority
end
--dxs网络设置
function onReconnectTips()
	m_ReconnectCnt = m_ReconnectCnt - 1
	if m_ReconnectCnt == 0 then
		消息框UI1.hideUI()
		onReconnect()
	else
		消息框UI1.setData(m_ReconnectTxt.."("..m_ReconnectCnt..txt("秒后自动连接)"),onReconnect,onReconnect,onReconnect)
	end
end

function onReconnect()
	if 消息框UI1.m_repeatanim then
		F3DScheduler:instance():removeAnimatable(消息框UI1.m_repeatanim)
		消息框UI1.m_repeatanim = nil
	end
	if not 网络连接.isConnected() then
		网络连接.connect(全局设置.SERVERS[__ARGS__.server or 0].ip, 全局设置.SERVERS[__ARGS__.server or 0].port)
	end
end

function doReconnect(reasontxt, reconnect)
	m_ReconnectCnt = 30
	m_ReconnectTxt = reasontxt
	if 消息框UI1.m_repeatanim then
		F3DScheduler:instance():removeAnimatable(消息框UI1.m_repeatanim)
		消息框UI1.m_repeatanim = nil
	end
	if reconnect then
		消息框UI1.m_repeatanim = F3DScheduler:instance():repeatCall(func_n(onReconnectTips), 1000)
		消息框UI1.initUI()
		消息框UI1.setData(m_ReconnectTxt..txt("(30秒后自动连接)"),onReconnect,onReconnect,onReconnect)
	else
		消息框UI1.initUI()
		消息框UI1.setData(m_ReconnectTxt,nil,nil,nil)
	end
end

function onConnect()
	print(txt("连接成功..."))
	if __ARGS__.account and __ARGS__.account ~= "" then
		消息.CG_ASK_LOGIN(__ARGS__.account, __PLATFORM__ or "", __ARGS__.server or 0, 1)
	end
end

function onClose()
	print(txt("关闭连接..."))
end

function onIOError()
	print(txt("连接失败..."))
	doReconnect(txt("服务器连接失败"), true)
end

网络连接.init(onConnect, onClose, onIOError)
网络连接.connect(全局设置.SERVERS[__ARGS__.server or 0].ip, 全局设置.SERVERS[__ARGS__.server or 0].port)

--主界面UI
local 主界面UI = require("主界面.主界面UI")
主界面UI.initTipsCont()
--登录UI
if __ARGS__.account == nil or __ARGS__.account == "" then
	local 登录UI = require("登录.登录UI")
	登录UI.initUI()
end
local 主逻辑 = require("主界面.主逻辑")
local 技能逻辑 = require("技能.技能逻辑")
local 地图表 = require("配置.地图表")
local 小地图UI = require("主界面.小地图UI")
local 地图UI = require("主界面.地图UI")
local Npc对话UI = require("主界面.Npc对话UI")
local 角色UI = require("主界面.角色UI")
local 背包UI = require("主界面.背包UI")
local 聊天UI = require("主界面.聊天UI")
local 角色逻辑 = require("主界面.角色逻辑")
local 加载UI = require("主界面.加载UI")
local 宠物UI = require("宠物.宠物UI")
local 技能UI = require("技能.技能UI")
local 目标信息UI = require("主界面.目标信息UI")
local 活动UI = require("主界面.活动UI")
local 个人副本UI = require("主界面.个人副本UI")
local Boss副本UI = require("主界面.Boss副本UI")
local 头像信息UI = require("主界面.头像信息UI")
local 英雄信息UI = require("主界面.英雄信息UI")
local 排行榜UI = require("主界面.排行榜UI")
local 寄售UI = require("主界面.寄售UI")
local 商城UI = require("主界面.商城UI")
local 辅助UI = require("主界面.辅助UI")
local 福利UI = require("主界面.福利UI")
local 采集进度UI = require("主界面.采集进度UI")
local 行会UI = require("主界面.行会UI")
local 锻造UI = require("主界面.锻造UI")

--设置摄像机,光照
F3DRenderContext.sCamera:lookAt(0,-1000,1000,0,0,0)
F3DRenderContext.sCamera:perspective(45,stage:getWidth(),stage:getHeight(),1,20000)
F3DRenderContext.sUICamera:lookAt(0, -(stage:getHeight()/2)/math.tan(22.5*math.pi/180), math.tan(10*math.pi/180)*(stage:getHeight()/2)/math.tan(22.5*math.pi/180), 0, 0, 0)
F3DRenderContext.sUICamera:perspective(45, stage:getWidth(), stage:getHeight(), 1, 10000)
F3DRenderContext:setLightDirection(1,1,-2)
F3DRenderContext:setSpecularDirection(1,1,-2)
F3DRenderContext:setGlowDirection(0,1,-1)

加载UI.initUI()
加载UI.hideUI()

function setOpenSound(val)
	g_openSound = val
	if g_role then
		g_role:setPlaySound(val)
	end
end

function stopRoleMove(role, clearpts)
	role:stopMove((role:getAnimName()=="run" or role:getAnimName()=="walk") and "idle" or "")
	role:stopHitBack()
	if not ISMIR2D then
		role:stopRotate()
	end
	
	if role == g_role then--and clearpts then
		--地图UI.movedownfunc = nil
		小地图UI.clearShape()
		g_movePoints = nil
	end
end

function destoryScene()
	if g_scene then
		g_scene:removeFromParent(true)
		g_scene = nil
	end
	if g_map then
		g_map:removeFromParent(true)
		g_map = nil
	end
	if g_sceneEffect then
		g_sceneEffect:removeFromParent(true)
		g_sceneEffect = nil
	end
	for i,v in ipairs(g_mapsafeanims) do
		v:removeFromParent(true)
	end
	g_mapsafeanims = {}
	g_mapLoaded = false
end
--连接服务器消息
function onLoadSceneFinish()
	消息.CG_ENTER_SCENE_OK(g_firstEnterGame and 1 or 0)
	if g_firstEnterGame then
		消息.CG_TASK_QUERY()
		消息.CG_SKILL_QUERY()
		消息.CG_BAG_QUERY()
		--消息.CG_STORE_QUERY()
		消息.CG_EQUIP_QUERY()
		消息.CG_QUICK_QUERY()
		消息.CG_SKILL_QUICK_QUERY()
		消息.CG_PET_QUERY()
		消息.CG_SINGLECOPY_QUERY()
		消息.CG_BOSSCOPY_QUERY()
		消息.CG_TIMESHOP_QUERY()
		g_firstEnterGame = false
	end
	g_mapLoaded = true
	if g_moveUp or g_moveDown or g_moveLeft or g_moveRight or g_moveDirDown then
		doMoveRoleLogic()
	elseif (rightMouseDown or (LEFTMOVE and leftMouseDown and not g_target)) then
		doMoveRoleLogic()
	end
end

function setScene(url)
	if g_map and g_map:getResUrl() == url then
		onLoadSceneFinish()
		return
	end
	destoryScene()
	F3DRenderer.sOpenFogLamp = true
	g_scene = F3DScene:new()
	g_scene:setLoadPriority(g_mapPriority)
	g_scene:setPositionZ(-10)
	g_scene:setSceneFile(url)
	mapLayer:addChild(g_scene, 0)
	if 地图表.Config[g_mapid].sceneeff ~= 0 then
		g_sceneEffect = F3DEffectSystem:new()
		g_sceneEffect:setEffect(全局设置.getEffectUrl(g_mapid))
		effectLayer:addChild(g_sceneEffect)
	end
	加载UI.loadScene(g_scene, onLoadSceneFinish)
end

--dxs加载地图


function setMap(map)
	F3DRenderer.sOpenFogLamp = false
	F3DRenderContext:setLightColor(F3DColor:new(0.6,0.6,0.6),F3DColor:new(0.6,0.6,0.6),F3DColor:new(0.3,0.3,0.3),5)
	map:initMapQueue(g_mapTilePriority)
	map:initMinimap(全局设置.getMinimapUrl(g_mapfileid, g_mapdirname), g_mapPriority)--F3DUtils:trimPostfix(map:getResUrl()) .. ".png"
	map:getMinimap():setWidth(map:getMapWidth())
	map:getMinimap():setHeight(map:getMapHeight())
	mapLayer:addChild(map, 0)
	if 地图表.Config[g_mapid].sceneeff ~= 0 then
		g_sceneEffect = F3DEffectSystem:new()
		g_sceneEffect:setEffect(全局设置.getEffectUrl(地图表.Config[g_mapid].sceneeff))
		effectLayer:addChild(g_sceneEffect)
	end
	if #地图表.Config[g_mapid].safearea > 0 and #地图表.Config[g_mapid].movegrid > 0 then
		local gridx = 地图表.Config[g_mapid].movegrid[1]
		local gridy = 地图表.Config[g_mapid].movegrid[2]
		for i,v in ipairs(地图表.Config[g_mapid].safearea) do
			local posx = math.floor(v[1]/gridx)*gridx+gridx/2
			local posy = math.floor(v[2]/gridy)*gridy+gridy/2
			local rangex = v[3]
			local rangey = rangex / (gridx / gridy)
			local x,y
			y = posy-rangey
			for x=posx-rangex,posx+rangex,gridx do
				local anim = F3DImageAnim3D:new()
				anim:setTouchable(false)
				anim:setAnimPack(全局设置.getAnimPackUrl(6000))
				anim:setBlendType(F3DRenderContext.BLEND_ADD)
				anim:setPosition(x, to3d(y), 0)
				anim:setZOrder(-anim:getPositionY())
				g_mapsafeanims[#g_mapsafeanims+1] = anim
				rolecont:addChild(anim)
			end
			y = posy+rangey
			for x=posx-rangex,posx+rangex,gridx do
				local anim = F3DImageAnim3D:new()
				anim:setTouchable(false)
				anim:setAnimPack(全局设置.getAnimPackUrl(6000))
				anim:setBlendType(F3DRenderContext.BLEND_ADD)
				anim:setPosition(x, to3d(y), 0)
				anim:setZOrder(-anim:getPositionY())
				g_mapsafeanims[#g_mapsafeanims+1] = anim
				rolecont:addChild(anim)
			end
			x = posx-rangex
			for y=posy-rangey+gridy,posy+rangey-gridy,gridy do
				local anim = F3DImageAnim3D:new()
				anim:setTouchable(false)
				anim:setAnimPack(全局设置.getAnimPackUrl(6000))
				anim:setBlendType(F3DRenderContext.BLEND_ADD)
				anim:setPosition(x, to3d(y), 0)
				anim:setZOrder(-anim:getPositionY())
				g_mapsafeanims[#g_mapsafeanims+1] = anim
				rolecont:addChild(anim)
			end
			x = posx+rangex
			for y=posy-rangey+gridy,posy+rangey-gridy,gridy do
				local anim = F3DImageAnim3D:new()
				anim:setTouchable(false)
				anim:setAnimPack(全局设置.getAnimPackUrl(6000))
				anim:setBlendType(F3DRenderContext.BLEND_ADD)
				anim:setPosition(x, to3d(y), 0)
				anim:setZOrder(-anim:getPositionY())
				g_mapsafeanims[#g_mapsafeanims+1] = anim
				rolecont:addChild(anim)
			end
		end
	end
	g_map = map
	onLoadSceneFinish()
end

function setMapUrl(url)
	if g_map and g_map:getResUrl() == url then
		onLoadSceneFinish()
		return
	end
	destoryScene()
	local map = F3DAssets:instance():getMap(url)
	if map then
		setMap(map)
	else
		F3DAssets:instance():loadFile(url, F3DFunction:new(setMap,"F3DMap"), g_mapPriority)
	end
end

function pushItem(item)
	item.tf:setText("")
	item.tfcont:removeFromParent()
	item:removeFromParent()
	g_ItemPool[#g_ItemPool+1] = item
end

function popItem()
	if #g_ItemPool > 0 then
		local item = g_ItemPool[#g_ItemPool]
		table.remove(g_ItemPool, #g_ItemPool)
		return item
	end
end

function pushRole(role)
	role:stopMove("idle")
	role:stopHitBack()
	role:reset()
	role:removeFromParent()
	g_RolePool[#g_RolePool+1] = role
end

function popRole()
	if #g_RolePool > 0 then
		local role = g_RolePool[#g_RolePool]
		table.remove(g_RolePool, #g_RolePool)
		return role
	end
end

function addItem(url, objid, objtype, x, y)
	if g_items[objid] ~= nil then
		g_items[objid]:removeFromParent(true)
		g_items[objid] = nil
	end
	local item = g_UsePool and popItem() or F3DImage:new()
	item.objid = objid
	item.objtype = objtype
	item.pos = {x=x, y=g_is3D and y or to3d(y), z=g_scene and g_scene:getTerrainHeight(x, y) or 0}
	item:setZOrder(-item.pos.y)
	item:setTextureFile(url)
	if not item.tfcont then
		item.tfcont = F3DImage:new()
	end
	item.tfcont:setZOrder(-item.pos.y)
	g_items[objid] = item
	rolecont:addChild(item)
	hpcont:addChild(item.tfcont)
	return item
end

function addMainRole(bodyid, weaponid, wingid, horseid, job, sex, objid, objtype, x, y, speed, 斗笠外观)
	if g_roles[objid] ~= nil then
		g_roles[objid]:removeFromParent(true)
		g_roles[objid] = nil
	end
	local role = ISMIR2D and (g_UsePool and popRole() or F3DImageAnim3D:new()) or F3DMainRole:new()
	role:setLoadPriority(getRolePriority())
	role.objid = objid
	role.objtype = objtype
	role:setMoveSpeed(speed)
	
	role:setPosition(x, g_is3D and y or to3d(y), g_scene and g_scene:getTerrainHeight(x, y) or 0)
	role:setZOrder(-role:getPositionY())
	if IS3G then
		role:setShowShadow(true)
		role:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(bodyid))
	elseif ISMIR2D then
		role:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(bodyid))
		if ISWZ then
			role:setShowShadow(true)
		elseif 斗笠外观 ~= 0 then
			role:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getAnimPackUrl(斗笠外观))
		else
			role:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getMirHairUrl(sex))
		end
		if weaponid ~= 0 then
			role:setEntity(F3DImageAnim3D.PART_WEAPON, 全局设置.getAnimPackUrl(weaponid))
		end
		if wingid ~= 0 then
			role:setEntity(F3DImageAnim3D.PART_WING, 全局设置.getAnimPackUrl(wingid))
		end
		if horseid ~= 0 then
			role:setEntity(F3DImageAnim3D.PART_HORSE, 全局设置.getAnimPackUrl(horseid))
		end
	else
		role:setLighting(g_is3D)
		role:setShowShadow(true)
		role:getBody():setEntity(F3DAvatar.PART_BODY, 全局设置.getBodyUrl(bodyid))
		role:getBody():setEntity(F3DAvatar.PART_FACE, 全局设置.getFaceUrl(job))
		role:getBody():setEntity(F3DAvatar.PART_HAIR, 全局设置.getHairUrl(job))
		role:getBody():setAnimSet(全局设置.getAnimsetUrl(job))
		if weaponid ~= 0 then
			role:getBody():setEntity(F3DAvatar.PART_WEAPON, 全局设置.getWeaponUrl(weaponid))
		end
		if wingid ~= 0 then
			role:setWingUrl(全局设置.getWingUrl(wingid))
		end
		if horseid ~= 0 then
			role:setHorseUrl(全局设置.getPetUrl(horseid))
		end
	end
	g_roles[objid] = role
	rolecont:addChild(role)
	return role
end

function addRole(bodyid, objid, objtype, x, y, speed)
	local url = ISMIR2D and 全局设置.getAnimPackUrl(bodyid) or 全局设置.getModelUrl(bodyid)
	if g_roles[objid] ~= nil then
		g_roles[objid]:removeFromParent(true)
		g_roles[objid] = nil
	end
	local role = ISMIR2D and (g_UsePool and popRole() or F3DImageAnim3D:new()) or F3DRole:new()
	role:setLoadPriority(getRolePriority())
	role.objid = objid
	role.objtype = objtype
	role:setMoveSpeed(speed)
	role:setPosition(x, g_is3D and y or to3d(y), g_scene and g_scene:getTerrainHeight(x, y) or 0)
	role:setZOrder(-role:getPositionY())
	if IS3G then
		role:setShowShadow(true)
		if bodyid ~= 0 then
			role:setEntity(F3DImageAnim3D.PART_BODY, url)
		end
	elseif ISMIR2D then
		if url:find(".animpack") ~= nil then
			role:setEntity(F3DImageAnim3D.PART_BODY, url)
		end
		if bodyid ~= 0 and ISWZ then
			role:setShowShadow(true)
		end
	else
		if url:find(".txt") ~= nil then
			role:setLighting(g_is3D)
			role:setAvatarTxt(url)
			role:setShowShadow(true)
		elseif url:find(".mesh") ~= nil then
			role:setLighting(g_is3D)
			role:setEntity(F3DAvatar.PART_BODY, url)
			role:setAnimSet(F3DUtils:trimPostfix(url)..".txt")
			role:setShowShadow(true)
		else
			role:getAxisBox():mergePos(1,1,1)
			role:setShowShadow(false)
		end
	end
	g_roles[objid] = role
	rolecont:addChild(role)
	return role
end

function setMoveGoal(url)
	if ISMIR2D then return end
	moveGoal = F3DEffectSystem:new()
	moveGoal:setEffect(url)
	effectLayer:addChild(moveGoal)
end

function showMoveGoal(x, y)
	if ISMIR2D then return end
	moveGoal:setPosition(x, g_is3D and y or to3d(y), g_scene and g_scene:getTerrainHeight(x, y) or 0)
	moveGoal:replay()
end

function setHoverObj(obj)
	if g_hoverObj == obj then return end
	if g_hoverObj then
		g_hoverObj:setShowEdge(false)
		if g_hoverObj.hpbar and g_hoverObj.hpbar.name and not g_hoverObj.hpbar.showname then--and g_hoverObj.hp == g_hoverObj.maxhp and not g_hoverObj.hpbar.mergehp then
			g_hoverObj.hpbar.name:setVisible(false)
		end
	end
	if obj then
		obj:setShowEdge(true)
		if obj.hpbar and obj.hpbar.name and obj:isVisible() then
			obj.hpbar.name:setVisible(true)
		end
	end
	g_hoverObj = obj
end

function checkHoverObj(x, y)
	if F3DUIManager.sTouchComp then
		setHoverObj(nil)
		return
	end
	local intobj = nil
	local firstobj = nil
	if ISMIR2D then
		for i = rolecont:numChildren() - 1, 0, -1 do
			local role = rolecont:getChildAt(i)
			if role:isTouchable() and role:isTypeOf(F3DImageAnim3D.sType) then
				role:setImage2D(true)
				if IS3G and x > role:getPositionX() - role:getImgWidth()/2 and x < role:getPositionX() + role:getBoxWidth()/2 and
					y > role:getPositionY() - role:getImgHeight() and y < role:getPositionY() then
					intobj = role
					role:setImage2D(false)
					break
				elseif x > role:getPositionX() - 24 and x < role:getPositionX() + 24 and
					y > role:getPositionY() - 80 and y < role:getPositionY() then
					role:setImage2D(false)
					if role.objtype == 全局设置.OBJTYPE_NPC then
						intobj = role
						break
					elseif not intobj then
						intobj = role
					end
				else
					role:setImage2D(false)
				end
			end
		end
	else
		local ray = F3DUtils:getMouseRay(x, y)
		intobj = F3DUtils:intersectRay(rolecont, ray, ray.result)
		while intobj and not intobj:isTypeAs(F3DRole.sType) do
			intobj = intobj:getParent()
		end
	end
	if intobj ~= g_role and intobj ~= g_hoverObj then
		setHoverObj(intobj)
	end
end

function onHeartBeat()
	g_heartbeatcnt = g_heartbeatcnt + 1
	if 网络连接.m_SocketDataCheck and rtime() - 网络连接.m_SocketDataTime > 30000 then
		网络连接.closeConnect()
		doReconnect(txt("客户端断开连接"), true)
		return
	end
	if not g_role or not 网络连接.isConnected() then
		return
	end
	--if 小地图UI.m_staticFrameTime > 0 and rtime() > 小地图UI.m_staticFrameTime then
	--	F3DImageAnim.sUseStaticFrame = true
	--else
	--	F3DImageAnim.sUseStaticFrame = false
	--end
	if g_heartbeatcnt % 100 == 0 then
		消息.CG_HEART_BEAT()
	end
	if g_heartbeatcnt % 10 == 0 then
		消息.CG_TASK_QUERY()
	end
	if g_heartbeatcnt % 10 == 0 and not Boss副本UI.isHided() then
		消息.CG_BOSSCOPY_QUERY()
	end
	if g_heartbeatcnt % 10 == 0 and not 个人副本UI.isHided() then
		消息.CG_SINGLECOPY_QUERY()
	end
	if g_heartbeatcnt % 10 == 0 and (头像信息UI.m_setTakeDrug or 英雄信息UI.m_setTakeDrug) then
		头像信息UI.m_setTakeDrug = false
		英雄信息UI.m_setTakeDrug = false
		消息.CG_HUMAN_SETUP(
			头像信息UI.m_autoTakeDrug1*100,
			头像信息UI.m_autoTakeDrug2*100,
			英雄信息UI.m_autoTakeDrug1*100,
			英雄信息UI.m_autoTakeDrug2*100,
			辅助UI.m_自动分解白,
			辅助UI.m_自动分解绿,
			辅助UI.m_自动分解蓝,
			辅助UI.m_自动分解紫,
			辅助UI.m_自动分解橙,
			辅助UI.m_自动分解等级,
			辅助UI.m_使用生命药,
			辅助UI.m_使用魔法药,
			辅助UI.m_英雄使用生命药,
			辅助UI.m_英雄使用魔法药,
			辅助UI.m_使用物品HP,
			辅助UI.m_使用物品ID,
			辅助UI.m_自动使用合击,
			辅助UI.m_自动分解宠物白,
			辅助UI.m_自动分解宠物绿,
			辅助UI.m_自动分解宠物蓝,
			辅助UI.m_自动分解宠物紫,
			辅助UI.m_自动分解宠物橙,
			辅助UI.m_自动孵化宠物蛋,
			辅助UI.m_物品自动拾取)
	end
	if __PLATFORM__ == "WIN" or __PLATFORM__ == "MAC" then
		checkHoverObj(g_hoverPos.x, g_hoverPos.y)
	end
	--if g_heartbeatcnt > g_dologiccnt and (LEFTMOVE or rightMouseDown) and doMoveRoleLogic() then
	--else
	if g_heartbeatcnt > g_dologiccnt and (g_heartbeatcnt - g_dologiccnt) % 3 == 0 then
		doRoleLogic()
	end
	--if not g_movegrid and not g_role.querymove and not g_role:needMove() and g_movePoints and g_movePoints:size() > 0 then
	if MOVEQUERY and g_mapLoaded and not g_role.querymove and not g_role:needMove() and g_movePoints and g_movePoints:size() > 0 then-- 
		g_role.querymove = true
		local front = g_movePoints:front()
		if IS3G then
			消息.CG_MOVE_GRID(front.x, front.y)
		else
			消息.CG_MOVE_GRID(front.x, front.y)
		end
		g_role:startMove(front.x, g_is3D and front.y or to3d(front.y),
			(not IS3G or (not g_role:isHitFly() and not g_role:getAnimName():find("attack_"))) and (g_role.status==1 and "walk" or "run") or "")
		g_movePoints:erase(0)
	end
	主界面UI.onHeartBeat()
end

F3DScheduler:instance():repeatCall(func_n(onHeartBeat), 100)

function enterScene(mapid, x, y)
	g_mapid = mapid
	g_is3D = 地图表.Config[mapid].scenetype ~= 0
	if #地图表.Config[mapid].movegrid > 0 then
		setCameraRate(地图表.Config[mapid].movegrid[1] / 地图表.Config[mapid].movegrid[2])
	else
		setCameraRate(2)
	end
	--g_movegrid = #地图表.Config[mapid].movegrid > 0
	local s = F3DUtils:getFilename(地图表.Config[mapid].map)
	s = F3DUtils:trimPostfix(s)
	g_mapfileid = s
	g_mapdirname = 地图表.Config[g_mapid].map:sub(1,地图表.Config[g_mapid].map:find("/")-1)
	--resetMovePoint()
	if not ISMIR2D then
		g_role:setLighting(g_is3D)
	end
	g_mapWidth = 0
	g_mapHeight = 0
	if g_is3D then
		setScene(全局设置.getSceneUrl(g_mapfileid))
	else
		setMapUrl(全局设置.getMapUrl(g_mapfileid, g_mapdirname))
	end
	if g_role then
		jumpScene(g_role, x, y)
	end
	小地图UI.setShowQuit(地图表.Config[mapid].maptype ~= 0 or (IS3G and mapid > 1000))
	小地图UI.setMapUrl(全局设置.getMinimapUrl(g_mapfileid, g_mapdirname), g_mapid)--g_is3D
	if not Npc对话UI.isHided() then
		Npc对话UI.hideUI()
	end
	F3DRenderContext.sCamera:lookAt(0,-1000,1000,0,0,0)
	onStageResize(nil)
end

function jumpScene(role, x, y)
	role:setPosition(x, g_is3D and y or to3d(y), g_scene and g_scene:getTerrainHeight(x, y) or 0)
	role:setZOrder(-role:getPositionY())
	if role == g_role and (g_moveUp or g_moveDown or g_moveLeft or g_moveRight or g_moveDirDown) then
		doMoveRoleLogic()
	elseif role == g_role and (rightMouseDown or (LEFTMOVE and leftMouseDown and not g_target)) then
		doMoveRoleLogic()
	end
	if role == g_role then
		地图UI.startHangup()
		小地图UI.CheckHandup()
	end
	if not Npc对话UI.isHided() then
		Npc对话UI.hideUI()
	end
	if 是否在安全区() and 技能逻辑.autoUseSkill then
		技能逻辑.autoUseSkill = false
		小地图UI.CheckHandup()
	end
end

function startGame(job, sex, objid, mapid, x, y, speed, bodyid, weaponid, wingid, horseid, 斗笠外观)
	主界面UI.initUI()
	if IS3G then
		--主界面UI.ui:setVisible(false)
		--聊天UI.ui:setVisible(false)
		--头像信息UI.ui:setVisible(false)
	end
	g_mapid = mapid
	g_is3D = 地图表.Config[mapid].scenetype ~= 0
	if #地图表.Config[mapid].movegrid > 0 then
		setCameraRate(地图表.Config[mapid].movegrid[1] / 地图表.Config[mapid].movegrid[2])
	else
		setCameraRate(2)
	end
	--g_movegrid = #地图表.Config[mapid].movegrid > 0
	local s = F3DUtils:getFilename(地图表.Config[mapid].map)
	s = F3DUtils:trimPostfix(s)
	g_mapfileid = s
	g_mapdirname = 地图表.Config[g_mapid].map:sub(1,地图表.Config[g_mapid].map:find("/")-1)
	if not moveGoal then
		setMoveGoal(全局设置.getEffectUrl(3642))
	end
	setMainRoleTarget(nil)
	resetAttackObj(nil)
	setHoverObj(nil)
	for k,v in pairs(g_items) do
		v.tfcont:removeFromParent(true)
		g_items[k]:removeFromParent(true)
		g_items[k] = nil
	end
	for k,v in pairs(g_roles) do
		主逻辑.delHPBar(v)
		g_roles[k]:removeFromParent(true)
		g_roles[k] = nil
	end
	g_firstEnterGame = true
	g_role = addMainRole(bodyid, weaponid, wingid, horseid, job, sex, objid, 全局设置.OBJTYPE_PLAYER, x, y, speed, 斗笠外观)
	g_role:setPlaySound(g_openSound)
	g_role:setTouchable(false)
	if not ISMIR2D then
		g_role:setOpenBlend(true)
		g_role:setLighting(g_is3D)
	end
	g_mapWidth = 0
	g_mapHeight = 0
	if g_is3D then
		setScene(全局设置.getSceneUrl(g_mapfileid))
	else
		setMapUrl(全局设置.getMapUrl(g_mapfileid, g_mapdirname))
	end
	if ISZY and g_mobileMode then
		活动UI.setActivityInfo(1,true,UIPATH.."活动图标/button_copy.png",txt("副本"),function()--挑战
			个人副本UI.toggle()
		end)
		活动UI.setActivityInfo(2,true,UIPATH.."活动图标/button_bosstaofa.png",txt("BOSS"),function()--讨伐
			Boss副本UI.toggle()
		end)
		活动UI.setActivityInfo(3,true,UIPATH.."活动图标/button_ranking.png",txt("排行"),function()--榜
			排行榜UI.toggle()
		end)
		活动UI.setActivityInfo(4,true,UIPATH.."活动图标/button_jishou.png",txt("寄售"),function()--市场
			寄售UI.toggle()
		end)
		活动UI.setActivityInfo(5,true,UIPATH.."活动图标/button_activityHall.png",txt("福利"),function()--大厅
			福利UI.toggle()
		end)
		活动UI.setActivityInfo(6,true,UIPATH.."主界面/mainicon/button_faction.png",txt("行会"),function()
			行会UI.toggle()
		end)
		活动UI.setActivityInfo(7,true,UIPATH.."主界面/mainicon/button_strength.png",txt("锻造"),function()
			锻造UI.toggle()
		end)
		活动UI.setActivityInfo(8,true,UIPATH.."主界面/mainicon/button_pet.png",txt("宠物"),function()
			宠物UI.toggle()
		end)
		活动UI.setActivityInfo(9,true,UIPATH.."主界面/mainicon/button_skill.png",txt("技能"),function()
			技能UI.toggle()
		end)
		活动UI.setActivityInfo(10,true,UIPATH.."主界面/mainicon/button_bag.png",txt("背包"),function()
			背包UI.toggle()
		end)
		活动UI.setActivityInfo(11,true,UIPATH.."主界面/商城.png","",function()
			商城UI.toggle()
		end)
	elseif ISZY then
		活动UI.setActivityInfo(1,true,UIPATH.."活动图标/button_copy.png",txt("副本"),function()--挑战
			个人副本UI.toggle()
		end)
		活动UI.setActivityInfo(2,true,UIPATH.."活动图标/button_bosstaofa.png",txt("BOSS"),function()--讨伐
			Boss副本UI.toggle()
		end)
		活动UI.setActivityInfo(3,true,UIPATH.."活动图标/button_ranking.png",txt("排行"),function()--榜
			排行榜UI.toggle()
		end)
		活动UI.setActivityInfo(4,true,UIPATH.."活动图标/button_jishou.png",txt("寄售"),function()--市场
			寄售UI.toggle()
		end)
		活动UI.setActivityInfo(5,true,UIPATH.."活动图标/button_activityHall.png",txt("福利"),function()--大厅
			福利UI.toggle()
		end)
	elseif g_mobileMode then
		活动UI.setActivityInfo(4,true,UIPATH.."活动图标/button_ranking.png",txt("排行"),function()--榜
			排行榜UI.toggle()
		end)
		活动UI.setActivityInfo(5,true,UIPATH.."活动图标/button_jishou.png",txt("寄售"),function()--市场
			寄售UI.toggle()
		end)
		活动UI.setActivityInfo(1,true,UIPATH.."主界面/mainicon/button_faction.png",txt("行会"),function()
			行会UI.toggle()
		end)
		活动UI.setActivityInfo(2,true,UIPATH.."主界面/mainicon/button_skill.png",txt("技能"),function()
			技能UI.toggle()
		end)
		活动UI.setActivityInfo(3,true,UIPATH.."主界面/mainicon/button_bag.png",txt("背包"),function()
			背包UI.toggle()
		end)
		活动UI.setActivityInfo(6,true,UIPATH.."主界面/商城.png","",function()
			商城UI.toggle()
		end)
		活动UI.setActivityInfo(7,true,UIPATH.."活动图标/button_activityHall.png",txt("会员"),function()--大厅
			消息.CG_CHAT(1,"@会员")
		end)
	else
		活动UI.setActivityInfo(2,true,UIPATH.."活动图标/button_ranking.png",txt("排行"),function()--榜
			排行榜UI.toggle()
		end)
		活动UI.setActivityInfo(3,true,UIPATH.."活动图标/button_jishou.png",txt("寄售"),function()--市场
			寄售UI.toggle()
		end)
		活动UI.setActivityInfo(1,true,UIPATH.."活动图标/button_climbTower.png",txt("行会"),function()
			行会UI.toggle()
		end)
		活动UI.setActivityInfo(4,true,UIPATH.."活动图标/button_activityHall.png",txt("会员"),function()--大厅
			消息.CG_CHAT(1,"@会员")
		end)
	end
	小地图UI.setShowQuit(地图表.Config[mapid].maptype ~= 0 or (IS3G and mapid > 1000))
	小地图UI.setMapUrl(全局设置.getMinimapUrl(g_mapfileid, g_mapdirname), g_mapid)--g_is3D
	if not Npc对话UI.isHided() then
		Npc对话UI.hideUI()
	end
	F3DRenderContext.sCamera:lookAt(0,-1000,1000,0,0,0)
	onStageResize(nil)
	网络连接.m_SocketDataCheck = true
	网络连接.m_SocketDataTime = rtime()
end

function updateMapPos()
	if not g_role then return end
	local viewer = (g_role.viewerid and g_roles[g_role.viewerid]) and g_roles[g_role.viewerid] or g_role
	if g_scene then
		local dir = F3DRenderContext.sCamera:getDirection()
		dir:normalizeVal(g_cameraLength)
		F3DRenderContext.sCamera:lookAt(
			viewer:getPositionX() - dir.x, viewer:getPositionY() - dir.y, viewer:getPositionZ() - dir.z,
			viewer:getPositionX(), viewer:getPositionY(), viewer:getPositionZ())
	elseif g_map then
		local mapx = stage:getWidth()/2 - viewer:getPositionX()
		local mapy = stage:getHeight()/2 - to2d(viewer:getPositionY()) - ((not g_mobileMode and ISMIRUI) and 60 or 10)
		if IS3G or ISWZ then
			mapx = math.min(0, math.max(stage:getWidth() - g_map:getMapWidth(), mapx))
			mapy = math.min(0, math.max(stage:getHeight() - g_map:getMapHeight(), mapy))
		end
		g_map:setPositionX(mapx)
		g_map:setPositionY(mapy)
		g_map:updateQueue(mapx, mapy, 1)
		local camerax = stage:getWidth()/2 - mapx
		local cameray = to3d(stage:getHeight()/2 - mapy)
		F3DRenderContext.sCamera:setCenter(camerax, cameray, 0)
		F3DRenderContext.sCamera:setEye(camerax, cameray-1000, 1000*ORTHO_CAMERA_RATE)
	end
end

function checkTarget(target)
	pointcache:setVal(g_role:getPositionX()-target:getPositionX(), g_role:getPositionY()-target:getPositionY())
	local dist = pointcache:length()
	local maxdist = (target.objtype == 全局设置.OBJTYPE_NPC or target.是否采集物 or #g_skill == 0) and ATTACKDIST or 技能逻辑.checkUseSkillDist() - RANGEOFFSET--g_skill[1].range
	if dist <= maxdist then
		if target.objtype == 全局设置.OBJTYPE_NPC and (Npc对话UI.isHided() or Npc对话UI.m_objid ~= target.objid) then
			g_movePoint = nil
			消息.CG_NPC_TALK(target.objid, 0)--,target.teamid,target.ownerid)
			技能逻辑.autoUseSkill = false
			小地图UI.CheckHandup()
			return true
		elseif target.是否采集物 then
			g_movePoint = nil
			消息.CG_COLLECT_START(target.objid)
			return true
		elseif (g_autoAttack or target.objtype == 全局设置.OBJTYPE_MONSTER) and target.hp > 0 and not target.iscaller and (target.teamid == 0 or target.teamid ~= 角色逻辑.m_teamid) and target.ownerid ~= g_role.objid then
			g_movePoint = nil
			resetAttackObj(target)
			return 技能逻辑.doUseSkill(target, 技能逻辑.checkUseSkill(target), target:getPositionX(), target:getPositionY())
		end
	end
end

function resetSkillKeycode()
	g_skillkeycode = nil
	g_skillkeytime = 0
end

function onEnterFrame(e)
	local time = e:getElapsedTime() / 1000
	if not g_role then return end
	for i,v in pairs(g_roles) do
		local role = v
		if role.alphaendtime and rtime() >= role.alphaendtime then
			role:setAlpha(1)
			role.alphaendtime = nil
		end
		if role.disapearendtime and rtime() >= role.disapearendtime then
			role:setVisible(true)
			role.disapearendtime = nil
		end
		if role:calcFrameHitFly(time, (role:getAnimName() == "hurt" or role:getAnimName() == "hurt_2") and not role.isjump) then
			if role:getAnimName() == "jump" then
				role:setAnimName("idle")
			end
			role.isjump = nil
		end
		if role:updateMove(time) then
			if role.alphaendtime then
			elseif g_map and g_map:getAStar():isTranslucent(role:getPositionX(), g_is3D and role:getPositionY() or to2d(role:getPositionY())) then
				role:setAlpha(0.7)
			else
				role:setAlpha(1)
			end
			role:setPositionZ((g_scene and g_scene:getTerrainHeight(role:getPositionX(), role:getPositionY()) or 0) + role:getFlyHeight())
			role:setZOrder(-role:getPositionY())
			if role == g_role then
				if not Npc对话UI.isHided() and Npc对话UI.m_objid ~= -1 then
					local npc = g_roles[Npc对话UI.m_objid]
					if not npc then
						Npc对话UI.hideUI()
					else
						pointcache:setVal(g_role:getPositionX()-npc:getPositionX(), g_role:getPositionY()-npc:getPositionY())
						local dist = pointcache:length()
						if dist > ATTACKDIST then
							Npc对话UI.hideUI()
						end
					end
				end
			end
		else
			role:setPositionZ((g_scene and g_scene:getTerrainHeight(role:getPositionX(), role:getPositionY()) or 0) + role:getFlyHeight())
		end
		if g_scene then
			role:setLampLight(g_scene:getLampLight(role:getPositionX(), role:getPositionY()))
		end
		if role:needStopMove() then
			--if g_movegrid and role == g_role and g_movePoint then
			--	role:stopMove()
			--	startAStar(g_movePoint[1],g_movePoint[2],true,false)
			--	g_movePoint = nil
			--else
			
			if role == g_role and g_skillkeycode and g_role.unattackable ~= 1 and rtime() - g_skillkeytime < 200 then-- and not IS3G
				g_movePoint = nil
				local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
				local target = g_hoverObj or findAttackObj(g_skill[g_skillkeycode].range - RANGEOFFSET)
				local ret
				
				if IS3G then
					if g_moveUp or g_moveDown or g_moveLeft or g_moveRight then
						g_movedir:setVal(g_moveLeft and -1 or (g_moveRight and 1 or 0), g_moveUp and 1 or (g_moveDown and -1 or 0))
						g_movedir:normalize(50)
					end
					if g_movedir.x == 0 and g_movedir.y == 0 then
						g_movedir.x = 50
					end
					ret = 技能逻辑.doUseSkill(target, g_skillkeycode, g_role:getPositionX()+g_movedir.x*8, g_role:getPositionY()+g_movedir.y*8)
				else
					ret = 技能逻辑.doUseSkill(target, g_skillkeycode, pos.x, pos.y)
				end
				g_skillkeycode = nil
				if target then
					--setMainRoleTarget(target)
					resetAttackObj(target)
				end
				if ret then
					stopRoleMove(role)
				end
			elseif role == g_role and g_usexpskill then
				local target = g_hoverObj or findAttackObj(450)
				if not target then
					主界面UI.showTipsMsg(1,txt("请选择一个目标"))
				else
					--setMainRoleTarget(target)
					resetAttackObj(target)
					消息.CG_XP_USE(target and target.objid or -1)
				end
				g_usexpskill = false
			elseif role == g_role and g_target and checkTarget(g_target) then
				stopRoleMove(role)
			elseif role == g_role and (g_moveUp or g_moveDown or g_moveLeft or g_moveRight or g_moveDirDown) then
				if not doMoveRoleLogic(true) then
					stopRoleMove(role)
				end
			elseif role == g_role and (rightMouseDown or (leftMouseDown and not g_target)) then
				if not doMoveRoleLogic(true) then
					stopRoleMove(role)
				end
			elseif role == g_role and g_autoPickItem then
				if not autoPickItem() then
					stopRoleMove(role)
				end
				g_autoPickItem = false
			elseif not MOVEQUERY and g_mapLoaded and role == g_role and g_movePoints and g_movePoints:size() > 0 then--
				local front = g_movePoints:front()
				if IS3G then
					消息.CG_MOVE_GRID(front.x, front.y)
				else
					消息.CG_MOVE_GRID(front.x, front.y)
				end
				g_role:startMove(front.x, g_is3D and front.y or to3d(front.y),
					(not IS3G or (not g_role:isHitFly() and not g_role:getAnimName():find("attack_"))) and (g_role.status==1 and "walk" or "run") or "")
				g_movePoints:erase(0)
			elseif role == g_role then
				role:stopMove((role:getAnimName() ~= "run" and role:getAnimName() ~= "walk") and role:getAnimName() or
					(g_movePoints and g_movePoints:size() > 0) and (role.status==1 and "walk" or "run") or "idle")
			else
				role:stopMove((role:getAnimName() ~= "run" and role:getAnimName() ~= "walk") and role:getAnimName() or "idle", 100)
				--role:stopMove((role == g_role and g_movePoints and g_movePoints:size() > 0) and "run" or "idle", 100)
			end
			if role == g_role and (not g_movePoints or g_movePoints:size() == 0) then
				小地图UI.clearShape()
				if g_movePoint and g_movePoint[3] == 0 then
					g_movePoint = nil
				end
			end
		end
		--主逻辑.updateHPBar(role)
	end
	if g_mapWidth == 0 or g_mapHeight == 0 then
		if g_scene then
			g_mapWidth = g_scene:getSceneWidth()
			g_mapHeight = g_scene:getSceneHeight()
		elseif g_map then
			g_mapWidth = g_map:getMapWidth()
			g_mapHeight = g_map:getMapHeight()
		end
		if g_mapWidth ~= 0 and g_mapHeight ~= 0 then
			地图UI.checkMovePath()
		end
		小地图UI.updateSize(g_mapWidth, g_mapHeight)
	end
	local viewer = (g_role.viewerid and g_roles[g_role.viewerid]) and g_roles[g_role.viewerid] or g_role
	小地图UI.updatePos(viewer:getPositionX(), viewer:getPositionY(), 180-(ISMIR2D and viewer:getAnimRotationZ() or viewer:getRotationZ()))
	小地图UI.updateImgList()
	updateMapPos()
	for i,v in pairs(g_roles) do
		local role = v
		主逻辑.updateHPBar(role)
	end
	for i,v in pairs(g_items) do
		local pt = F3DUtils:getScreenPosition(v.pos.x, v.pos.y, v.pos.z)
		if pt then
			v:setPositionX(pt.x)
			v:setPositionY(pt.y)
			v.tfcont:setPositionX(math.floor(pt.x))
			v.tfcont:setPositionY(math.floor(pt.y))
		end
	end
end

stage:addEventListener(F3DEvent.ENTER_FRAME, func_e(onEnterFrame))

function onStageResize(e)
	if stage:getWidth() == 0 or stage:getHeight() == 0 then return end
	if g_is3D then
		g_cameraLength = (stage:getHeight()/2)/math.tan(22.5*math.pi/180)
		F3DRenderContext.sCamera:perspective(45,stage:getWidth(),stage:getHeight(),1,20000)
	else
		F3DRenderContext.sCamera:ortho(stage:getWidth(),stage:getHeight(),-5000,5000)
	end
	F3DRenderContext.sUICamera:lookAt(0, -(stage:getHeight()/2)/math.tan(22.5*math.pi/180), math.tan(10*math.pi/180)*(stage:getHeight()/2)/math.tan(22.5*math.pi/180), 0, 0, 0)
	F3DRenderContext.sUICamera:perspective(45, stage:getWidth(), stage:getHeight(), 1, 10000)
	grabimage:createTexture(stage:getWidth(),stage:getHeight())
	reflectionMap:getCamera():perspective(45, stage:getWidth(), stage:getHeight(), 1, 10000)
end

stage:addEventListener(F3DEvent.RESIZE, func_e(onStageResize))

function onMouseMove(e)
	g_hoverPos.x = e:getStageX()
	g_hoverPos.y = e:getStageY()
end

F3DTouchProcessor:instance():addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onMouseMove))

local resultObjs = F3DObjectVector:new()
function getMousePoint(x, y)
	local ray = F3DUtils:getMouseRay(x, y)
	if g_scene then
		resultObjs:clear()
		F3DUtils:intersectRay(g_scene:getOctreeTr(), ray, ray.result, nil, nil, resultObjs)
		if resultObjs:size() > 0 then
			return ray:getPoint(ray.result.w)
		end
	end
	local t = -ray.orig:dotProduct(F3DVector3.Z_AXIS) / ray.dir:dotProduct(F3DVector3.Z_AXIS)
	return ray:getPoint(t)
end

pointcache = F3DPoint:new()

function checkRoleDist(mapid, posx, posy)
	if mapid ~= g_mapid then
		return false
	end
	if posx == 0 and posy == 0 then
		return true
	end
	pointcache:setVal(g_role:getPositionX()-posx, g_role:getPositionY()-(g_is3D and posy or to3d(posy)))
	local dist = pointcache:length()
	if dist < ATTACKDIST then
		return true
	else
		return false
	end
end

function 获取生命药水(药水ID)
	local 药水列表 = nil
	for i,v in ipairs(辅助UI.生命药水) do
		if 药水ID == v[2] then
			药水列表 = {v}
			break
		end
	end
	if not 药水列表 then
		return 辅助UI.生命药水
	end
	for i,v in ipairs(辅助UI.生命药水) do
		if 药水列表[1][2] ~= v[2] then
			药水列表[#药水列表+1] = v
		end
	end
	return 药水列表
end

function 获取魔法药水(药水ID)
	local 药水列表 = nil
	for i,v in ipairs(辅助UI.魔法药水) do
		if 药水ID == v[2] then
			药水列表 = {v}
			break
		end
	end
	if not 药水列表 then
		return 辅助UI.魔法药水
	end
	for i,v in ipairs(辅助UI.魔法药水) do
		if 药水列表[1][2] ~= v[2] then
			药水列表[#药水列表+1] = v
		end
	end
	return 药水列表
end

function 是否在安全区()
	if g_role and g_map and g_map:getAStar():isSafeArea(g_role:getPositionX(), g_is3D and g_role:getPositionY() or to2d(g_role:getPositionY())) then
		return true
	end
	if g_role and #地图表.Config[g_mapid].safearea > 0 and #地图表.Config[g_mapid].movegrid > 0 then
		local gridx = 地图表.Config[g_mapid].movegrid[1]
		local gridy = 地图表.Config[g_mapid].movegrid[2]
		for i,v in ipairs(地图表.Config[g_mapid].safearea) do
			local posx = math.floor(v[1]/gridx)*gridx+gridx/2
			local posy = math.floor(v[2]/gridy)*gridy+gridy/2
			local rangex = v[3]
			local rangey = rangex / (gridx / gridy)
			local x,y = g_role:getPositionX(), to2d(g_role:getPositionY())
			if x >= posx-rangex and x <= posx+rangex and y >= posy-rangey and y <= posy+rangey then
				return true
			end
		end
	end
	return false
end

function doRoleLogic()
	if not g_role then return end
	if not g_mapLoaded then return end
	if g_role.hp and g_role.hp <= 0 then return end
	if 辅助UI.m_使用物品ID ~= 0 and not 是否在安全区() and 头像信息UI.m_hpbar and 头像信息UI.m_hpbar.hp / 头像信息UI.m_hpbar.hpmax < 辅助UI.m_使用物品HP/100 then
		if 背包UI.getItemCount(辅助UI.m_使用物品ID) > 0 and rtime() > 背包UI.getItemCD(辅助UI.m_使用物品ID) then
			背包UI.DoUseItem(辅助UI.m_使用物品ID)
		end
	end
	local 药水列表 = nil
	药水列表 = 获取生命药水(辅助UI.m_使用生命药)
	if 头像信息UI.m_hpbar and 头像信息UI.m_hpbar.hp / 头像信息UI.m_hpbar.hpmax < 头像信息UI.m_autoTakeDrug1 then
		for i,v in ipairs(药水列表) do
			if g_role.level >= v[3] and 背包UI.getItemCount(v[2]) > 0 and rtime() > 背包UI.getItemCD(v[2]) then
				背包UI.DoUseItem(v[2])
				break
			end
		end
	end
	药水列表 = 获取魔法药水(辅助UI.m_使用魔法药)
	if 头像信息UI.m_mpbar and 头像信息UI.m_mpbar.mp / 头像信息UI.m_mpbar.mpmax < 头像信息UI.m_autoTakeDrug2 then
		for i,v in ipairs(药水列表) do
			if g_role.level >= v[3] and 背包UI.getItemCount(v[2]) > 0 and rtime() > 背包UI.getItemCD(v[2]) then
				背包UI.DoUseItem(v[2])
				break
			end
		end
	end
	药水列表 = 获取生命药水(辅助UI.m_英雄使用生命药)
	if 英雄信息UI.m_hpbar and 英雄信息UI.m_hpbar.hp / 英雄信息UI.m_hpbar.hpmax < 英雄信息UI.m_autoTakeDrug1 then
		for i,v in ipairs(药水列表) do
			if 英雄信息UI.m_level >= v[3] and 背包UI.getItemCount(v[2]) > 0 and rtime() > 背包UI.getItemCD(v[2]) then
				背包UI.DoUseItem(v[2], true)
				break
			end
		end
	end
	药水列表 = 获取魔法药水(辅助UI.m_英雄使用魔法药)
	if 英雄信息UI.m_mpbar and 英雄信息UI.m_mpbar.mp / 英雄信息UI.m_mpbar.mpmax < 英雄信息UI.m_autoTakeDrug2 then
		for i,v in ipairs(药水列表) do
			if 英雄信息UI.m_level >= v[3] and 背包UI.getItemCount(v[2]) > 0 and rtime() > 背包UI.getItemCD(v[2]) then
				背包UI.DoUseItem(v[2], true)
				break
			end
		end
	end
	if 技能逻辑.autoUseSkill and 辅助UI.m_自动使用合击 == 1 and 主界面UI.m_init and 主界面UI.ui.xphead:isVisible() then
		useXPSkill(true)
	end
	if Boss副本UI.m_init and Boss副本UI.ui.自动挑战BOSS:isSelected() and 角色逻辑.m_vip等级 > 2 and 地图表.Config[g_mapid].maptype == 0 then
		if Boss副本UI.m_copyinfo then
			for i,v in ipairs(Boss副本UI.m_copyinfo) do
				if v[1] == 1 and v[8] == 0 then
					local conf = 地图表.Config[v[2]]
					if conf and 角色逻辑.m_level >= conf.level and 角色逻辑.m_转生等级 >= conf.转生等级 then
						消息.CG_ENTER_COPYSCENE(v[2], 1)
						return
					end
				end
			end
		end
	end
	if Boss副本UI.m_init and Boss副本UI.ui.自动挑战武神殿:isSelected() and 角色逻辑.m_vip等级 > 4 and 地图表.Config[g_mapid].maptype == 0 then
		if Boss副本UI.m_copyinfo then
			for i,v in ipairs(Boss副本UI.m_copyinfo) do
				if v[1] == 3 and v[8] == 0 then
					local conf = 地图表.Config[v[2]]
					if conf and 角色逻辑.m_level >= conf.level and 角色逻辑.m_转生等级 >= conf.转生等级 then
						消息.CG_ENTER_COPYSCENE(v[2], 1)
						return
					end
				end
			end
		end
	end
	if g_movePoint and not g_role:needMove() and (not g_movePoints or g_movePoints:size() == 0) then
		if g_movePoint[3] == 0 then
			if IS3G then
				消息.CG_MOVE_GRID(g_role:getPositionX(), g_scene and g_role:getPositionY() or to2d(g_role:getPositionY()))
			else
				消息.CG_MOVE_GRID(g_role:getPositionX(), g_scene and g_role:getPositionY() or to2d(g_role:getPositionY()))
			end
			g_movePoint[3] = 1
		else
			startAStar(g_movePoint[1], g_movePoint[2], false)
		end
	end
	if not g_target and rtime() >= g_pickitemtime then
		local item = nil
		local mindist = nil
		for i,v in pairs(g_items) do
			if (v.ownerid == -1 or v.ownerid == g_role.objid or (v.teamid ~= 0 and v.teamid == g_role.teamid)) and 背包UI.getLeftCount() > 0 then
				local itempos = v.pos
				pointcache:setVal(g_role:getPositionX()-itempos.x, g_role:getPositionY()-itempos.y)
				local dist = pointcache:length()
				if dist < PICKDIST and not g_role:needMove() then
					消息.CG_PICK_ITEM(v.objid)
					return
				end
				if mindist == nil or dist < mindist then
					mindist = dist
					item = v
				end
			end
		end
		if item and 技能逻辑.autoUseSkill then--and not 是否在安全区() then
			if not g_role:needMove() then
				if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
					消息.CG_CHANGE_STATUS(0,-1)
					--g_role.status = 1
					--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
				end
				startAStar(item.pos.x, g_is3D and item.pos.y or to2d(item.pos.y), false)
			end
			return
		end
	end
	if not g_target and not 技能逻辑.autoUseSkill and g_targetPos.bodyid ~= 0 then
		for _,role in pairs(g_roles) do
			if role.bodyid == g_targetPos.bodyid and role.objtype == 全局设置.OBJTYPE_NPC then
				pointcache:setVal(g_role:getPositionX()-role:getPositionX(), g_role:getPositionY()-role:getPositionY())
				local dist = pointcache:length()
				if dist < ATTACKDIST then
					g_target = role
					--地图UI.movedownfunc = nil
					break
				end
			end
		end
	end
	if not g_target and 技能逻辑.autoUseSkill then--and not 是否在安全区() then
		local target = nil
		local mindist = nil
		for _,role in pairs(g_roles) do
			if ((g_targetPos.bodyid ~= 0 and role.bodyid == g_targetPos.bodyid and (role.objtype == 全局设置.OBJTYPE_NPC or role.是否采集物 or (role.hp > 0 and role.objtype == 全局设置.OBJTYPE_MONSTER))) or
				(g_targetPos.bodyid == 0 and role ~= g_role and role.hp > 0 and role.objtype ~= 全局设置.OBJTYPE_NPC and role.objtype ~= 全局设置.OBJTYPE_PLAYER and role.objtype ~= 全局设置.OBJTYPE_PET and not role.iscaller and not role.是否练功师 and (role.teamid == 0 or role.teamid ~= 角色逻辑.m_teamid) and role.ownerid ~= g_role.objid and role.ownerid == -1)) then
				pointcache:setVal(g_role:getPositionX()-role:getPositionX(), g_role:getPositionY()-role:getPositionY())
				local dist = pointcache:length()
				if mindist == nil or dist < mindist then
					mindist = dist
					target = role
				end
			end
		end
		if target then
			setMainRoleTarget(target)
		end
	end
	if not g_target and leftMouseDown and not LEFTMOVE then
		local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
		startAStar(pos.x, g_is3D and pos.y or to2d(pos.y), true)
	elseif g_target and not g_role:needMove() then
		pointcache:setVal(g_role:getPositionX()-g_target:getPositionX(), g_role:getPositionY()-g_target:getPositionY())
		local dist = pointcache:length()
		local maxdist = (g_target.objtype == 全局设置.OBJTYPE_NPC or g_target.是否采集物 or #g_skill == 0) and ATTACKDIST or 技能逻辑.checkUseSkillDist() - RANGEOFFSET--g_skill[1].range
		if dist <= maxdist then
			if g_target.objtype == 全局设置.OBJTYPE_NPC and (leftMouseDown or Npc对话UI.isHided() or (Npc对话UI.m_objid >= 0 and Npc对话UI.m_objid ~= g_target.objid)) then
				g_movePoint = nil
				消息.CG_NPC_TALK(g_target.objid, 0)--,g_target.teamid,g_target.ownerid)
				技能逻辑.autoUseSkill = false
				小地图UI.CheckHandup()
			elseif g_target.是否采集物 then
				g_movePoint = nil
				消息.CG_COLLECT_START(g_target.objid)
			elseif (g_autoAttack or g_target.objtype == 全局设置.OBJTYPE_MONSTER) and g_target.hp > 0 and not g_target.iscaller and (g_target.teamid == 0 or g_target.teamid ~= 角色逻辑.m_teamid) and g_target.ownerid ~= g_role.objid then
				g_movePoint = nil
				resetAttackObj(g_target)
				技能逻辑.doUseSkill(g_target, 技能逻辑.checkUseSkill(g_target), g_target:getPositionX(), g_target:getPositionY())
			end
		elseif g_autoAttack or g_target.objtype == 全局设置.OBJTYPE_NPC or g_target.objtype == 全局设置.OBJTYPE_MONSTER then
			if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
				消息.CG_CHANGE_STATUS(0,-1)
				--g_role.status = 1
				--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
			end
			startAStar(g_target:getPositionX(), g_is3D and g_target:getPositionY() or to2d(g_target:getPositionY()))
		end
	end
	if (g_moveUp or g_moveDown or g_moveLeft or g_moveRight or g_moveDirDown) and not g_role:needMove() then
		doMoveRoleLogic()
	elseif (rightMouseDown or (LEFTMOVE and leftMouseDown and not g_target)) and not g_role:needMove() then
		doMoveRoleLogic()
	end
end

function doMoveRoleLogic(force)
	if not g_role then return end
	if not g_mapLoaded then return end
	if g_role.hp and g_role.hp <= 0 then return end
	if g_moveUp or g_moveDown or g_moveLeft or g_moveRight then
		g_movedir:setVal(g_moveLeft and -1 or (g_moveRight and 1 or 0), g_moveUp and 1 or (g_moveDown and -1 or 0))
		g_movedir:normalize(50)
		startAStar(g_role:getPositionX()+g_movedir.x, to2d(g_role:getPositionY()+g_movedir.y), false)
		return true
	end
	if g_moveDirDown and (g_movedir.x ~= 0 or g_movedir.y ~= 0) then
		g_movedir:normalize(50)
		startAStar(g_role:getPositionX()+g_movedir.x, to2d(g_role:getPositionY()+g_movedir.y), false)
		return true
	end
	if not rightMouseDown and (not leftMouseDown or g_target) then
	 	return false
	end
	if not force and g_role:needMove() then
	 	return false
	end
	if rightMouseDown or g_mobileMode then
		if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
			消息.CG_CHANGE_STATUS(0,-1)
			--g_role.status = 1
			--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
		end
	else
		if g_role.status ~= 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
			消息.CG_CHANGE_STATUS(1,-1)
			--g_role.status = 0
			--g_role:setMoveSpeed(g_role:getMoveSpeed()/2)
		end
	end
	local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
	local 角度 = F3DMath:atan2((pos.x-g_role:getPositionX()),(pos.y-g_role:getPositionY()))*180/math.pi
	local 移动x = math.floor(g_role:getPositionX())
	local 移动y = math.floor(g_role:getPositionY())
	local 格子大小 = 地图表.Config[g_mapid].movegrid[1] or 50
	
	local 方向 = "无"
	if (角度 <= 0 and 角度 >= -22.5 or 角度 >= 0 and 角度 < 22.5) then  --上
		移动y = 移动y + 格子大小 * (rightMouseDown and 2 or 1)
	elseif (角度 >= 22.5 and 角度 < 67.5) then  --右上
		移动x = 移动x + 格子大小 * (rightMouseDown and 2 or 1)
		移动y = 移动y + 格子大小 * (rightMouseDown and 2 or 1)
	elseif (角度 >= 67.5 and 角度 < 112.5) then  --右
		移动x = 移动x + 格子大小 * (rightMouseDown and 2 or 1)
	elseif (角度 >= 112.5 and 角度 < 157.5) then  --右下
		移动x = 移动x + 格子大小 * (rightMouseDown and 2 or 1)
		移动y = 移动y - 格子大小 * (rightMouseDown and 2 or 1)
	elseif (角度 >= 0 and 角度 >= 157.5 or 角度 <= 0 and 角度 < -157.5) then  --下
		移动y = 移动y - 格子大小 * (rightMouseDown and 2 or 1)
	elseif (角度 >= -157.5 and 角度 < -112.5) then  --左下
		移动x = 移动x - 格子大小 * (rightMouseDown and 2 or 1)
		移动y = 移动y - 格子大小 * (rightMouseDown and 2 or 1)
	elseif (角度 >= -112.5 and 角度 < -67.5) then  --左
		移动x = 移动x - 格子大小 * (rightMouseDown and 2 or 1)
	elseif (角度 >= -67.5 and 角度 < -22.5) then  --左上
		移动x = 移动x - 格子大小 * (rightMouseDown and 2 or 1)
		移动y = 移动y + 格子大小 * (rightMouseDown and 2 or 1)
	end
	startAStar(移动x, to2d(移动y), false)
	return true
end

local ptscache = F3DPointVector:new()
function (x, y, showGoal, mounting)
	if not g_role or g_role.unmovable == 1 then return end
	if not g_mapLoaded then return end
	if g_role.hp and g_role.hp <= 0 then return end
	--if g_movegrid and g_role:getAnimName() == "run" then
		g_movePoint = {x,y,0}
	--	return
	--end
	local map = g_scene and g_scene:getMap() or g_map
	if not map then return end
	local pts = map:getAStar():findPath(g_role:getPositionX(), g_scene and g_role:getPositionY() or to2d(g_role:getPositionY()), x, y, MOVEGRID)
	if pts and pts:size() > 0 then
		ptscache:clear()
		local 格子大小X = 地图表.Config[g_mapid].movegrid[1] or 50
		local 格子大小Y = 地图表.Config[g_mapid].movegrid[2] or 25
		local rx = math.floor(g_role:getPositionX()/格子大小X)*格子大小X+格子大小X/2
		local ry = math.floor(to2d(g_role:getPositionY())/格子大小Y)*格子大小Y+格子大小Y/2
		for i=0,pts:size()-1 do
			local pt = pts:get(i)
			local cnt = F3DMath:round(math.max(math.abs(pt.x - rx)/格子大小X, math.abs(pt.y - ry)/格子大小Y))
			for ii=1,cnt do
				ptscache:push(rx+ii*(pt.x - rx)/cnt, ry+ii*(pt.y - ry)/cnt)
			end
			rx = pt.x
			ry = pt.y
		end
		if g_scene then
			小地图UI.drawShape(pts, g_scene:getSceneWidth(), g_scene:getSceneHeight(), true)
		elseif g_map then
			小地图UI.drawShape(pts, g_map:getMapWidth(), g_map:getMapHeight(), false)
		end
		pts = ptscache
		if mounting and 角色逻辑.m_level >= 10 then
			--消息.CG_USE_MOUNT(1)
		end
		g_role.querymove = true
		local front = pts:front()
		if IS3G then
			消息.CG_MOVE_GRID(front.x, front.y)
		else
			消息.CG_MOVE_GRID(front.x, front.y)
		end
		if not 采集进度UI.isHided() then
			消息.CG_COLLECT_START(-1)
		end
		g_role:startMove(front.x, g_is3D and front.y or to3d(front.y),
			(not IS3G or (not g_role:isHitFly() and not g_role:getAnimName():find("attack_"))) and (g_role.status==1 and "walk" or "run") or "")
		if showGoal then
			local back = pts:back()
			showMoveGoal(back.x, back.y)
		end
		pts:erase(0)
		--for i=1,pts:size() do
		--	local pt = pts:get(i-1)
		--	print("pt",pt.x,pt.y)
		--end
	end
	g_movePoints = pts
end

function setMainRoleTarget(target)
	if g_target == target then return end
	if g_target then
		if not ISMIR2D then
			g_target:removeEffectSystem(全局设置.getEffectUrl(g_target.objtype == 全局设置.OBJTYPE_NPC and 3643 or 3644))
		end
		if g_target.objtype == 全局设置.OBJTYPE_NPC then
			g_target:setAnimRotationZ(0)
		end
	end
	if target then
		if not ISMIR2D then
			target:setEffectSystem(全局设置.getEffectUrl(target.objtype == 全局设置.OBJTYPE_NPC and 3643 or 3644), true)
		end
		--目标信息UI.setGoalInfo(target.objid,target.bodyid,target.name,target.level,target.hp,target.maxhp)
	else
		--目标信息UI.setGoalInfo(-1)
	end
	g_target = target
end

function onMouseDown(e)
	if 主界面UI.checkFindPathPos(e:getStageX(), e:getStageY()) and 地图UI.movepos then
		g_downfindPath = true
		return
	end
	if F3DUIManager.sTouchComp then
		return
	end
	if __PLATFORM__ == "ANDROID" or __PLATFORM__ == "IOS" then
		g_hoverPos.x = e:getStageX()
		g_hoverPos.y = e:getStageY()
		checkHoverObj(g_hoverPos.x, g_hoverPos.y)
	end
	if g_role then
		leftMouseDown = true
		if (e:isShiftKey() or 头像信息UI.m_pkmode == 1 or 头像信息UI.m_pkmode == 2) and g_hoverObj and (g_hoverObj.objtype == 全局设置.OBJTYPE_PLAYER or g_hoverObj.objtype == 全局设置.OBJTYPE_PET) then
			g_autoAttack = true
		else
			g_autoAttack = false
		end
		g_targetPos.bodyid = 0
		g_targetPos.x = 0
		g_targetPos.y = 0
		g_movePoint = nil
		地图UI.releaseMovePos()
		技能逻辑.autoUseSkill = 技能逻辑.autoUseSkill and g_hoverObj ~= nil
		小地图UI.CheckHandup()
		if g_hoverObj and ((g_hoverObj.bodyid and g_hoverObj.bodyid ~= 0) or g_hoverObj.objtype == 全局设置.OBJTYPE_PLAYER) then
			setMainRoleTarget(g_hoverObj)
			resetAttackObj(g_hoverObj)
		--elseif e:isShiftKey() and #g_skill > 0 then
		--	local target = findAttackObj(g_skill[1].range - RANGEOFFSET)
		--	setMainRoleTarget(target)
		--	resetAttackObj(target)
		else
			setMainRoleTarget(nil)
		end
		g_dologiccnt = g_heartbeatcnt
		--g_movedir:setVal(0, 0)
		if g_target or not LEFTMOVE then
			doRoleLogic()
		else
			doMoveRoleLogic()
		end
	end
end

F3DTouchProcessor:instance():addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))

function onMouseUp(e)
	if g_downfindPath and 主界面UI.checkFindPathPos(e:getStageX(), e:getStageY()) and 地图UI.movepos then
		if 地图UI.movepos[2] == 0 and 地图UI.movepos[3] == 0 then
			消息.CG_TRANSPORT(地图UI.movepos[1],-1,-1)
		else
			消息.CG_TRANSPORT(地图UI.movepos[1],地图UI.movepos[2],地图UI.movepos[3])
		end
	end
	g_downfindPath = false
	leftMouseDown = false
end

F3DTouchProcessor:instance():addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onMouseUp))

function onRightDown(e)
	if F3DUIManager.sTouchComp then
		return
	end
	if g_role and e:isCtrlKey() and g_hoverObj and g_hoverObj.objtype == 全局设置.OBJTYPE_PLAYER then
		消息.CG_EQUIP_VIEW(g_hoverObj.objid,"")
	elseif g_role then
		rightMouseDown = true
		g_targetPos.bodyid = 0
		g_targetPos.x = 0
		g_targetPos.y = 0
		g_movePoint = nil
		地图UI.releaseMovePos()
		技能逻辑.autoUseSkill = false--g_hoverObj ~= nil
		小地图UI.CheckHandup()
		setMainRoleTarget(nil)
		g_dologiccnt = g_heartbeatcnt
		--g_movedir:setVal(0, 0)
		doMoveRoleLogic()
	end
end

F3DTouchProcessor:instance():addEventListener(F3DMouseEvent.RIGHT_DOWN, func_me(onRightDown))

function onRightUp(e)
	--if g_role.status ~= 1 then
	--	消息.CG_CHANGE_STATUS(1,-1)
	--end
	rightMouseDown = false
end

F3DTouchProcessor:instance():addEventListener(F3DMouseEvent.RIGHT_UP, func_me(onRightUp))

function resetMovePoint()
	g_movePoint = nil
end

function resetPickItemTime()
	g_pickitemtime = rtime() + 1000
end

function resetAttackObj(obj)
	if g_attackObj == obj then
		return
	end
	if g_attackObj then
		if ISMIR2D then
			--g_attackObj:removeEffectSystem(全局设置.getAnimPackUrl(836))--829 836
		end
	end
	
	if obj then
		if ISMIR2D then
			--obj:setEffectSystem(全局设置.getAnimPackUrl(836), true, nil, nil, 0, -1)--:setZOrder(-1)
		end
		
		目标信息UI.setGoalInfo(obj.objid,obj.bodyid,obj.name,obj.level,obj.hp,obj.maxhp)
		
	else
		目标信息UI.setGoalInfo(-1)
	end
	g_attackObj = obj
end

function findAttackObj(maxdist,自动战斗)
	local attackObj = g_attackObj
	if g_hoverObj then
		attackObj = g_hoverObj
	elseif g_target then
		attackObj = g_target
	end
	if attackObj and attackObj ~= g_role and attackObj.hp > 0 and attackObj.objtype == 全局设置.OBJTYPE_PLAYER then
		resetAttackObj(attackObj)
		return g_attackObj
	end
	if attackObj and attackObj ~= g_role and attackObj.hp > 0 and attackObj.objtype ~= 全局设置.OBJTYPE_NPC and attackObj.objtype ~= 全局设置.OBJTYPE_PLAYER and attackObj.objtype ~= 全局设置.OBJTYPE_PET and not attackObj.iscaller and not attackObj.是否练功师 and (attackObj.teamid == 0 or attackObj.teamid ~= 角色逻辑.m_teamid) and attackObj.ownerid ~= g_role.objid and attackObj.ownerid == -1 then
		pointcache:setVal(g_role:getPositionX()-attackObj:getPositionX(), g_role:getPositionY()-attackObj:getPositionY())
		local dist = pointcache:length()
		if dist <= maxdist then
			resetAttackObj(attackObj)
			return g_attackObj
		end
	end
	local target = nil
	local mindist = nil
	for _,role in pairs(g_roles) do
		if role ~= g_role and role.hp > 0 and role.objtype ~= 全局设置.OBJTYPE_NPC and role.objtype ~= 全局设置.OBJTYPE_PLAYER and role.objtype ~= 全局设置.OBJTYPE_PET and not role.iscaller and not role.是否练功师 and (role.teamid == 0 or role.teamid ~= 角色逻辑.m_teamid) and role.ownerid ~= g_role.objid and role.ownerid == -1 then
			pointcache:setVal(g_role:getPositionX()-role:getPositionX(), g_role:getPositionY()-role:getPositionY())
			local dist = pointcache:length()
			if dist <= maxdist and (mindist == nil or dist < mindist) then
				mindist = dist
				target = role
			end
		end
	end
	if target then
		resetAttackObj(target)
		return g_attackObj
	end
	if not 自动战斗 then
		return g_attackObj
	end
end

function autoPickItem()
	setMainRoleTarget(nil)
	local item = nil
	local mindist = nil
	for i,v in pairs(g_items) do
		local itempos = v.pos
		pointcache:setVal(g_role:getPositionX()-itempos.x, g_role:getPositionY()-itempos.y)
		local dist = pointcache:length()
		if dist < PICKDIST then
			消息.CG_PICK_ITEM(v.objid)
			return
		end
		if mindist == nil or dist < mindist then
			mindist = dist
			item = v
		end
	end
	if item then
		if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
			消息.CG_CHANGE_STATUS(0,-1)
			--g_role.status = 1
			--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
		end
		startAStar(item.pos.x, g_is3D and item.pos.y or to2d(item.pos.y), true)
		return true
	end
end

function useXPSkill(自动使用)
	if g_role.hp and g_role.hp <= 0 then return end
	if not 英雄信息UI.m_hpbar or 英雄信息UI.m_hpbar.hp <= 0 then
		if not 自动使用 then 主界面UI.showTipsMsg(1,txt("英雄已经死亡")) end
		return
	end
	if not g_role:needMove() then
		local target = not 自动使用 and g_hoverObj or findAttackObj(450,自动使用)
		if not target then
			if not 自动使用 then 主界面UI.showTipsMsg(1,txt("请选择一个目标")) end
		else
			--setMainRoleTarget(target)
			resetAttackObj(target)
			消息.CG_XP_USE(target and target.objid or -1)
		end
	elseif not 自动使用 then
		g_usexpskill = true
	end
end

function setMoveDir(x,y,status)
	if status == 1 or status == 2 then
		g_movedir:setVal(x,y)
		g_moveDirDown = true
	end
	if status == nil then
		g_moveDirTime = rtime()
		g_moveDirDown = false
	end
	if not IS3G then
		if status == 1 and g_role.status == 1 then
			消息.CG_CHANGE_STATUS(0,-1)
		end
	elseif status == 1 and g_role.status == 1 and rtime() - g_moveDirTime < 500 and (not IS3G or not g_role:getAnimName():find("attack_")) then
		消息.CG_CHANGE_STATUS(0,-1)
		g_moveDirTime = 0
		--g_role.status = 1
		--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
	elseif status == nil and g_role and g_role.status ~= 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
		消息.CG_CHANGE_STATUS(1,-1)
		--g_role.status = 0
		--g_role:setMoveSpeed(g_role:getMoveSpeed()/2)
	end
	if status == 1 and (g_movedir.x ~= 0 or g_movedir.y ~= 0) then
		doKeyMove()
	end
end

function doKeyMove()
	g_targetPos.bodyid = 0
	g_targetPos.x = 0
	g_targetPos.y = 0
	g_movePoint = nil
	地图UI.releaseMovePos()
	技能逻辑.autoUseSkill = false--g_hoverObj ~= nil
	小地图UI.CheckHandup()
	setMainRoleTarget(nil)
	g_dologiccnt = g_heartbeatcnt
	doMoveRoleLogic()
end

function onKeyDown(e)
	if F3DTextInput.sTextInput then return end
	--[[
	if e:isShiftKey() and __PLATFORM__ == "WIN" and e:getKeyCode() ~= F3DKeyboardCode.LSHIFT then
		if e:getKeyCode() == F3DKeyboardCode.TAB and __PLATFORM__ == "WIN" then
			print("===========DUMP===========")
			F3DObject:DUMP()
			print("===========DUMP===========")
			F3DAssets:DUMP()
		end
		if e:getKeyCode() == F3DKeyboardCode.Q then
			grabimage:setPostBloom(not grabimage:isPostBloom())
		elseif e:getKeyCode() == F3DKeyboardCode.W then
			grabimage:setPostDepthBlur(not grabimage:isPostDepthBlur())
		elseif e:getKeyCode() == F3DKeyboardCode.E then
			F3DRenderer.sSimpleShadow = not F3DRenderer.sSimpleShadow
		elseif e:getKeyCode() == F3DKeyboardCode.R then
			F3DRenderer.sOpenShadowMap = not F3DRenderer.sOpenShadowMap
		elseif e:getKeyCode() == F3DKeyboardCode.T then
			F3DRenderer.sOpenReflectionMap = not F3DRenderer.sOpenReflectionMap
		elseif e:getKeyCode() == F3DKeyboardCode.F then
			g_showStatus = not g_showStatus
			stage:showStatus(g_showStatus,0,100,12)
		end
		return
	end
	]]
	if not g_role or (not g_scene and not g_map) then return end
	local i = 主界面UI.checkKeyCode(e:getKeyCode())
	if i then
		if g_role.unattackable ~= 1 and (not g_role:needMove()) then-- or IS3G
			g_movePoint = nil
			local pos = getMousePoint(g_hoverPos.x, g_hoverPos.y)
			local target = g_hoverObj or findAttackObj(g_skill[i].range - RANGEOFFSET)
			if IS3G then
				if g_moveUp or g_moveDown or g_moveLeft or g_moveRight then
					g_movedir:setVal(g_moveLeft and -1 or (g_moveRight and 1 or 0), g_moveUp and 1 or (g_moveDown and -1 or 0))
					g_movedir:normalize(50)
				end
				if g_movedir.x == 0 and g_movedir.y == 0 then
					g_movedir.x = 50
				end
				技能逻辑.doUseSkill(target, i, g_role:getPositionX()+g_movedir.x*8, g_role:getPositionY()+g_movedir.y*8)
			else
				技能逻辑.doUseSkill(target, i, pos.x, pos.y)
			end
			if target then
				--setMainRoleTarget(target)
				resetAttackObj(target)
			end
		else
			g_skillkeycode = i
			g_skillkeytime = rtime()
		end
		return
	end
	--[[
	if e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.W or F3DKeyboardCode.W) then
		g_moveUp = true
		if g_role.status == 1 and rtime() - g_moveUpTime < 500 and (not IS3G or not g_role:getAnimName():find("attack_")) then
			消息.CG_CHANGE_STATUS(0,-1)
			g_moveUpTime = 0
			--g_role.status = 1
			--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
		end
		doKeyMove()
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.S or F3DKeyboardCode.S) then
		g_moveDown = true
		if g_role.status == 1 and rtime() - g_moveDownTime < 500 and (not IS3G or not g_role:getAnimName():find("attack_")) then
			消息.CG_CHANGE_STATUS(0,-1)
			g_moveDownTime = 0
			--g_role.status = 1
			--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
		end
		doKeyMove()
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.A or F3DKeyboardCode.A) then
		g_moveLeft = true
		if g_role.status == 1 and rtime() - g_moveLeftTime < 500 and (not IS3G or not g_role:getAnimName():find("attack_")) then
			消息.CG_CHANGE_STATUS(0,-1)
			g_moveLeftTime = 0
			--g_role.status = 1
			--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
		end
		doKeyMove()
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.D or F3DKeyboardCode.D) then
		g_moveRight = true
		if g_role.status == 1 and rtime() - g_moveRightTime < 500 and (not IS3G or not g_role:getAnimName():find("attack_")) then
			消息.CG_CHANGE_STATUS(0,-1)
			g_moveRightTime = 0
			--g_role.status = 1
			--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
		end
		doKeyMove()
	
	elseif IS3G and e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.K or F3DKeyboardCode.K) then
		
		if g_role.hp > 0 and not g_role:isHitFly() and g_role.unmovable ~= 1 and g_role.unattackable ~= 1 then
			g_role:startHitFly(0.6, 200, 0.3, 0.3, 0)
			g_role:setAnimName("jump","",true,true)
			g_role.isjump = true
			消息.CG_CHANGE_STATUS(101,-1)
		end
	end
	]]
	
	if e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.Tab or F3DKeyboardCode.TAB) then
		
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.Escape or F3DKeyboardCode.ESCAPE) then
		resetAttackObj(nil)
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.Return or F3DKeyboardCode.RETURN) then
		
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.NUM1 or F3DKeyboardCode.NUM1) then
		主界面UI.DoUseQuick(1)
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.NUM2 or F3DKeyboardCode.NUM2) then
		主界面UI.DoUseQuick(2)
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.NUM3 or F3DKeyboardCode.NUM3) then
		主界面UI.DoUseQuick(3)
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.NUM4 or F3DKeyboardCode.NUM4) then
		主界面UI.DoUseQuick(4)
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.NUM5 or F3DKeyboardCode.NUM5) then
		主界面UI.DoUseQuick(5)
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.NUM6 or F3DKeyboardCode.NUM6) then
		主界面UI.DoUseQuick(6)
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.M or F3DKeyboardCode.M) then
		地图UI.toggle()
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.C or F3DKeyboardCode.C) then
		if ISWZ then
			角色UI.toggle()
		elseif not 角色UI.isHided() and 角色UI.m_tabid ~= 0 then--角色逻辑.m_rolejob-1 then
			角色UI.setTabID(0)--角色逻辑.m_rolejob-1)
		else
			角色UI.setTabID(0)--角色逻辑.m_rolejob-1)
			角色UI.toggle()
		end
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.V or F3DKeyboardCode.V) then
		技能UI.toggle()
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.B or F3DKeyboardCode.B) then
		背包UI.toggle()
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.P or F3DKeyboardCode.P) then
		
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.N or F3DKeyboardCode.N) then
		
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.Z or F3DKeyboardCode.Z) then
		--技能逻辑.autoUseSkill = not 技能逻辑.autoUseSkill
		--小地图UI.CheckHandup()
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.Space or F3DKeyboardCode.SPACE) then
		
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.H or F3DKeyboardCode.H) then
		
	end
end

F3DTouchProcessor:instance():addEventListener(F3DKeyboardEvent.KEY_DOWN, func_ke(onKeyDown))

function onKeyUp(e)
	--[[
	if F3DTextInput.sTextInput then return end
	local movekeyup = false
	if e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.W or F3DKeyboardCode.W) then
		g_moveUp = false
		g_moveUpTime = rtime()
		movekeyup = true
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.S or F3DKeyboardCode.S) then
		g_moveDown = false
		g_moveDownTime = rtime()
		movekeyup = true
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.A or F3DKeyboardCode.A) then
		g_moveLeft = false
		g_moveLeftTime = rtime()
		movekeyup = true
	elseif e:getKeyCode() == (__PLATFORM__ == "MAC" and F3DKeyboardCodeMac.D or F3DKeyboardCode.D) then
		g_moveRight = false
		g_moveRightTime = rtime()
		movekeyup = true
	end
	if movekeyup and not g_moveUp and not g_moveDown and not g_moveLeft and not g_moveRight then
		if g_role and g_role.status ~= 1 then
			消息.CG_CHANGE_STATUS(1,-1)
			--g_role.status = 0
			--g_role:setMoveSpeed(g_role:getMoveSpeed()/2)
		end
		--g_movedir:setVal(0, 0)
	end
	]]
end

F3DTouchProcessor:instance():addEventListener(F3DKeyboardEvent.KEY_UP, func_ke(onKeyUp))
