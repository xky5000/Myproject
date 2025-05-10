module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 地图UI = require("主界面.地图UI")
local 地图表 = require("配置.地图表")
local 角色逻辑 = require("主界面.角色逻辑")
local 消息 = require("网络.消息")
local 技能逻辑 = require("技能.技能逻辑")
local 辅助UI = require("主界面.辅助UI")
local 聊天UI = require("主界面.聊天UI")
local 主界面UI = require("主界面.主界面UI")
local 好友UI = require("主界面.好友UI")
local 队伍UI = require("主界面.队伍UI")
local 邮件UI = require("主界面.邮件UI")

m_init = false
m_money1 = 0
m_money2 = 0
m_windowsize = 1
m_showQuit = false
m_simpleMode = false
m_staticFrameTime = 0
enemyinfo = nil
enemylist = {}

function setShowQuit(show)
	m_showQuit = show
	updateShowQuit()
end

function updateShowQuit()
	if not m_init then
		return
	end
end

function setCurrency(money1, money2)
	m_money1 = money1
	m_money2 = money2
	updateCurrency()
end

function updateCurrency()
	if not m_init then
		return
	end
end

function showEnemyInfo(info)
	enemyinfo = info
	updateEnemyInfo()
end

function updateEnemyInfo()
	if not m_init or enemyinfo == nil then
		return
	end
	local img, type
	local currindex = 1
	for i,v in ipairs(enemyinfo) do
		if not g_roles[v[1]] then
			local x = v[5]
			local y = -v[6]
			local rx = g_role:getPositionX()
			local ry = -g_role:getPositionY()
			local pt = F3DPoint:new(x-rx,y-ry)
			local radiusw = minimapcomp:getWidth()/2
			local radiush = minimapcomp:getHeight()/2
			pt:normalize(math.max(radiusw,radiush)*1.414)
			if pt.x < -radiusw then
				pt.x = -radiusw
			elseif pt.x > radiusw then
				pt.x = radiusw
			end
			if pt.y < -radiush then
				pt.y = -radiush
			elseif pt.y > radiush then
				pt.y = radiush
			end
			img = #enemylist >= currindex and enemylist[currindex]
			if not img then
				img = F3DImage:new()
				enemylist[currindex] = img
			end
			type = (v[8] ~= 0 and v[8] == 角色逻辑.m_teamid) and "team" or "enemy"
			img:setTextureFile(UIPATH.."公用/radar/icon_radar_"..type..".png")
			img:setPivot(0.5,0)
			img:setRotationZ(F3DUtils:calcDirection(x-rx,y-ry))
			if g_is3D then
				img:setPositionX(minimapmeimg:getPositionX()+pt.x)
				img:setPositionY(minimapmeimg:getPositionY()+pt.y)
			end
			enemycont:addChild(img)
			currindex = currindex+1
		end
	end
	for i=currindex,#enemylist do
		enemylist[i]:removeFromParent()
	end
end

pt1 = F3DPoint:new()
pt2 = F3DPoint:new()
pt3 = F3DPoint:new()
function clearShape()
	if shape then
		shape:clearAll()
	end
	地图UI.clearShape()
	m_pts = nil
end

m_pts = nil
function drawShape(pts)
	m_pts = {{x=g_role:getPositionX(),y=g_role:getPositionY()}}
	for i=1,pts:size() do
		local pt = pts:get(i-1)
		m_pts[#m_pts+1] = {x=pt.x,y=pt.y}
	end
	updateShape(pts)
	地图UI.updateShape()
end

function updateShape(pts)
	if not m_init or m_pts == nil then
		return
	end
	if minimapimg:getWidth() == 0 or minimapimg:getHeight() == 0 then
		return
	end
	shape:clearAll()
	if g_is3D then
		pt1.x = minimapimg:getWidth()*m_pts[1].x/g_mapWidth
		pt1.y = minimapimg:getHeight()*(g_mapHeight-m_pts[1].y)/g_mapHeight
	else
		pt1.x = minimapimg:getWidth()*m_pts[1].x/g_mapWidth
		pt1.y = minimapimg:getHeight()*to2d(m_pts[1].y)/g_mapHeight
	end
	for i=2,#m_pts do
		local pt = m_pts[i]
		if g_is3D then
			pt2.x = minimapimg:getWidth()*pt.x/g_mapWidth
			pt2.y = minimapimg:getHeight()*(g_mapHeight-pt.y)/g_mapHeight
		else
			pt2.x = minimapimg:getWidth()*pt.x/g_mapWidth
			pt2.y = minimapimg:getHeight()*pt.y/g_mapHeight
		end
		pt3.x = pt2.x - pt1.x
		pt3.y = pt2.y - pt1.y
		local len = pt3:length()
		pt3:normalize()
		while len > 10 do
			pt2.x = pt1.x + pt3.x * 10
			pt2.y = pt1.y + pt3.y * 10
			shape:drawLine(pt1, pt2)
			len = len - 10
			if len > 10 then
				pt1.x = pt2.x + pt3.x * 10
				pt1.y = pt2.y + pt3.y * 10
			else
				pt1.x = pt2.x + pt3.x * len
				pt1.y = pt2.y + pt3.y * len
			end
			len = len - 10
			if len <= 10 then
				pt2.x = pt1.x + pt3.x * len
				pt2.y = pt1.y + pt3.y * len
				break
			end
		end
		if len > 0 then
			shape:drawLine(pt1, pt2)
			pt1.x = pt2.x
			pt1.y = pt2.y
		end
	end
end

m_mapurl = ""
m_mapid = 0

--function onLoadTex(e)
--	if e then
--		e:getTarget():removeEventListener(F3DObjEvent.OBJ_LOADED, func_oe(onLoadTex))
--	end
--	updateShape()
--end

function updateSize(mapWidth, mapHeight)
	if minimapimg and g_mapWidth > 0 and g_mapHeight > 0 then
		local w = math.floor(mapWidth / 32)
		local h = math.floor(mapHeight / 32)
		local r = math.min(w / 200, h / 200)
		minimapimg:setWidth(math.floor(r >= 1 and w or w / r))
		minimapimg:setHeight(math.floor(r >= 1 and h or h / r))
	end
end

function setMapUrl(url, mapid)
	if m_mapid ~= mapid then
		m_mapurl = url
		m_mapid = mapid
		if minimapimg then
			minimapimg:setTextureFile(m_mapurl, g_mapPriority)
		end
	end
	地图UI.setMapUrl(m_mapurl, mapid)
end

imglist = {}

function updateImgList()
	if not m_init or g_mapWidth == 0 or g_mapHeight == 0 then
		return
	end
	local img, type
	local currindex = 1
	for i,v in pairs(g_roles) do
		local role = v
		if role ~= g_role and role:isVisible() then
			img = #imglist >= currindex and imglist[currindex]
			if not img then
				img = F3DImage:new()
				img:setPivot(0.5,0.5)
				imglist[currindex] = img
			end
			type = (role.objtype == 全局设置.OBJTYPE_PLAYER or (role.objtype == 全局设置.OBJTYPE_MONSTER and role.isrobot)) and
				((role.teamid ~= 0 and role.teamid == 角色逻辑.m_teamid) and 5 or 6) or
				role.objtype == 全局设置.OBJTYPE_NPC and 2 or role.objtype == 全局设置.OBJTYPE_PET and 7 or
				(role.objtype == 全局设置.OBJTYPE_MONSTER and role.isboss) and 8 or 1
			img:setTextureFile(UIPATH.."公用/radar/icon_radar_"..type..".png")
			if g_is3D then
				img:setPositionX(minimapimg:getWidth()*role:getPositionX()/g_mapWidth)
				img:setPositionY(minimapimg:getHeight()*(g_mapHeight-role:getPositionY())/g_mapHeight)
			else
				img:setPositionX(minimapimg:getWidth()*role:getPositionX()/g_mapWidth)
				img:setPositionY(minimapimg:getHeight()*to2d(role:getPositionY())/g_mapHeight)
			end
			if 实用工具.GetDistance(img:getPositionX()+minimapimg:getPositionX(),img:getPositionY()+minimapimg:getPositionY(),
				ui.maskradius,ui.maskradius) <= ui.maskradius then
				minimapimglist:addChild(img)
			else
				img:removeFromParent()
			end
			currindex = currindex+1
		end
	end
	for i=currindex,#imglist do
		imglist[i]:removeFromParent()
	end
	地图UI.updateImgList()
end

function updatePos(posx, posy, rotate)
	if not m_init or g_mapWidth == 0 or g_mapHeight == 0 then
		return
	end
	
	minimapmeimg:setRotationZ(rotate)
	if g_is3D then
		minimaptext:setTitleText(math.floor(posx)..","..math.floor(posy))
		minimapimg:setPositionX(-(minimapimg:getWidth()*posx/g_mapWidth-minimapcomp:getWidth()/2))
		minimapimg:setPositionY(-(minimapimg:getHeight()*(g_mapHeight-posy)/g_mapHeight-minimapcomp:getHeight()/2))
		minimapmeimg:setPositionX(minimapcomp:getWidth()/2)
		minimapmeimg:setPositionY(minimapcomp:getHeight()/2)
	else
		local 格子大小X = 地图表.Config[g_mapid].movegrid[1] or 50
		local 格子大小Y = 地图表.Config[g_mapid].movegrid[2] or 25
		
		minimaptext:setTitleText(txt(地图表.Config[m_mapid].name..":"..math.floor(posx/格子大小X)..","..math.floor(to2d(posy)/格子大小Y)))
		minimapimg:setPositionX(-(minimapimg:getWidth()*posx/g_mapWidth-minimapcomp:getWidth()/2))
		minimapimg:setPositionY(-(minimapimg:getHeight()*to2d(posy)/g_mapHeight-minimapcomp:getHeight()/2))
		minimapimg:setPositionX(math.min(0,math.max(-(minimapimg:getWidth()-minimapcomp:getWidth()),minimapimg:getPositionX())))
		minimapimg:setPositionY(math.min(0,math.max(-(minimapimg:getHeight()-minimapcomp:getHeight()),minimapimg:getPositionY())))
		minimapmeimg:setPositionX(minimapimg:getPositionX()+minimapimg:getWidth()*posx/g_mapWidth)
		minimapmeimg:setPositionY(minimapimg:getPositionY()+minimapimg:getHeight()*to2d(posy)/g_mapHeight)
	end
	ui.maskshp:clearAll()
	ui.maskshp:drawCircle(F3DPoint:new(ui.maskradius-minimapimg:getPositionX(), ui.maskradius-minimapimg:getPositionY()), ui.maskradius)
	minimapimglist:setPositionX(minimapimg:getPositionX())
	minimapimglist:setPositionY(minimapimg:getPositionY())
	if shape then
		shape:setPositionX(minimapimg:getPositionX())
		shape:setPositionY(minimapimg:getPositionY())
	end
	地图UI.updatePos(posx, posy, rotate)
end

function onMapClick(e)
	地图UI.toggle()
	地图UI.setMapUrl(m_mapurl, m_mapid)
end

function onSetupClick(e)
	辅助UI.toggle()
end

function onQuit(e)
	if 地图表.Config[m_mapid].maptype ~= 0 then
		消息.CG_QUIT_COPYSCENE()
	elseif 地图表.Config[101] then
		消息.CG_TRANSPORT(101, 地图表.Config[101].bornpos[1], 地图表.Config[101].bornpos[2])
	end
end

function CheckHandup(autofindpath)
	if not m_init then
		return
	end
	主界面UI.m_autofindpath:setVisible(autofindpath and not 技能逻辑.autoUseSkill)
	主界面UI.m_autofight:setVisible(技能逻辑.autoUseSkill)
	if m_staticFrameTime == 0 and 技能逻辑.autoUseSkill then
		m_staticFrameTime = rtime() + 60000
	elseif not 技能逻辑.autoUseSkill then
		m_staticFrameTime = 0
	end
end

function onUIInit(e)
	ui.属性 = ui:findComponent("属性")
	minimapcomp = ui:findComponent("属性,背景")
	minimaptext = ui:findComponent("坐标")
	ui.mapbtn = ui:findComponent("属性,地图")
	ui.mapbtn:addEventListener(F3DMouseEvent.CLICK, func_me(onMapClick))
	ui.maskradius = minimapcomp:getWidth()/2
	ui.maskshp = F3DShape:new()
	minimapimg = F3DImage:new()
	minimapimg:setMask(ui.maskshp)
	minimapcomp:addChild(minimapimg)
	shape = F3DShape:new()
	shape:setPenColor(0,1,1,0.5)
	shape:setPenSize(2)
	shape:setMask(ui.maskshp)
	minimapcomp:addChild(shape)
	minimapimglist = F3DDisplayContainer:new()
	minimapcomp:addChild(minimapimglist)
	minimapmeimg = F3DImage:new()
	minimapmeimg:setTextureFile(UIPATH.."公用/radar/icon_radar_me.png")
	minimapmeimg:setPivot(0.5,0.5)
	minimapcomp:addChild(minimapmeimg)
	
	if m_mapurl ~= "" then
		minimapimg:setTextureFile(m_mapurl, g_mapPriority)
	end
	
	enemycont = F3DDisplayContainer:new()
	minimapcomp:addChild(enemycont)
	
	ui.hangup = ui:findComponent("属性,挂机")
	ui.hangup:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		技能逻辑.autoUseSkill = not 技能逻辑.autoUseSkill
		CheckHandup()
	end))
	ui.精简 = ui:findComponent("精简")
	ui.精简:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		m_simpleMode = not m_simpleMode
		主界面UI.updateSimpleMode()
		ui.精简:setVisible(false)
		ui.开启:setVisible(true)
		
		ui.属性:setVisible(false)
	end))
	
	ui.开启 = ui:findComponent("开启")
	ui.开启:setVisible(false)
	ui.开启:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		m_simpleMode = not m_simpleMode
		主界面UI.updateSimpleMode()
		ui.精简:setVisible(true)
		ui.开启:setVisible(false)
		
		ui.属性:setVisible(true)
	end))
	
	m_init = true
	CheckHandup()
	updateShowQuit()
	updateCurrency()
	updateShape()
	updateEnemyInfo()
	updateSize(g_mapWidth, g_mapHeight)
end

function initUI()
	if ui then
		uiLayer:removeChild(ui)
		uiLayer:addChild(ui)
		ui:updateParent()
		ui:setVisible(true)
		return
	end
	ui = F3DLayout:new()
	uiLayer:addChild(ui)
	ui:setLoadPriority(getUIPriority())
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."小地图UIm.layout" or UIPATH.."小地图UI.layout")
end
