module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 地图表 = require("配置.地图表")
local 刷新表 = require("配置.刷新表")
local 技能逻辑 = require("技能.技能逻辑")
local 小地图UI = require("主界面.小地图UI")
local 角色逻辑 = require("主界面.角色逻辑")
local 主界面UI = require("主界面.主界面UI")

jumpmap = {}
for i,v in ipairs(刷新表.Config) do
	if v.type == 0 and v.jumpmap ~= 0 then
		if not jumpmap[v.mapid] then
			jumpmap[v.mapid] = {ref={},jump={}}
		end
		jumpmap[v.mapid].ref[#jumpmap[v.mapid].ref+1] = v
		jumpmap[v.mapid].jump[#jumpmap[v.mapid].jump+1] = v.jumpmap
	end
end

overBg = nil
tb = {
	{"glow_101","title_101"},
	{"glow_102","title_102"},
	{"glow_103","title_103"},
	{"glow_104","title_104"},
	{"glow_112","title_112"},
	{"glow_113","title_113"},
	{"glow_114","title_114"},
	{"glow_115","title_115"},
	{"glow_116","title_116"},
	{"glow_119","title_119"},
	{"glow_120","title_120"},
	{"glow_130","title_130"},
	{"glow_131","title_131"},
}

pt1 = F3DPoint:new()
pt2 = F3DPoint:new()
pt3 = F3DPoint:new()
function clearShape()
	if shape then
		shape:clearAll()
	end
	if movegoalimg and g_mapid == m_movemapid then
		movegoalimg:setVisible(false)
	end
	startHangup()
	--if movedownmapid == g_mapid and movedownfunc then
	--	movedownfunc()
	--	movedownfunc = nil
	--	movedownmapid = 0
	--end
end

function releaseMovePos()
	movepos = nil
	movepath = nil
end

function startHangup()
	if g_targetPos.bodyid ~= 0 and movepos and checkRoleDist(movepos[1], movepos[2], movepos[3]) then
		setMainRoleTarget(nil)
		技能逻辑.autoUseSkill = true
		小地图UI.CheckHandup()
		doRoleLogic()
		movepos = nil
		movepath = nil
	else
		小地图UI.CheckHandup()
	end
end

function updateShape()
	if not ui then
		return
	end
	if not mapimg or m_mapid ~= g_mapid or g_mapWidth == 0 or height == 0 then
		return
	end
	if 小地图UI.m_pts == nil then
		return
	end
	if mapimg:getWidth() == 0 or mapimg:getHeight() == 0 then
		return
	end
	shape:clearAll()
	if g_is3D then
		pt1.x = mapimg:getWidth()*小地图UI.m_pts[1].x/g_mapWidth
		pt1.y = mapimg:getHeight()*(g_mapHeight-小地图UI.m_pts[1].y)/g_mapHeight
	else
		pt1.x = mapimg:getWidth()*小地图UI.m_pts[1].x/g_mapWidth
		pt1.y = mapimg:getHeight()*to2d(小地图UI.m_pts[1].y)/g_mapHeight
	end
	for i=2,#小地图UI.m_pts do
		local pt = 小地图UI.m_pts[i]
		if g_is3D then
			pt2.x = mapimg:getWidth()*pt.x/g_mapWidth
			pt2.y = mapimg:getHeight()*(g_mapHeight-pt.y)/g_mapHeight
		else
			pt2.x = mapimg:getWidth()*pt.x/g_mapWidth
			pt2.y = mapimg:getHeight()*pt.y/g_mapHeight
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
	shape:setPositionX(mapimg:getPositionX())
	shape:setPositionY(mapimg:getPositionY())
	if g_mapid == m_movemapid then
		updateMoveGoal(g_mapid, 小地图UI.m_pts[#小地图UI.m_pts].x, 小地图UI.m_pts[#小地图UI.m_pts].y, g_mapWidth, g_mapHeight)
	end
end

m_mapurl = ""
m_mapid = 0
m_movemapid = 0
m_mapWidth = 0
m_mapHeight = 0
m_is3D = false

function setMapUrl(url, mapid)
	m_is3D = 地图表.Config[mapid].scenetype ~= 0
	if mapimg then
		minimapimglist:setVisible(mapid == g_mapid)
		shape:setVisible(mapid == g_mapid)
		minimapmeimg:setVisible(mapid == g_mapid)
		movegoalimg:setVisible(mapid == m_movemapid)
	end
	if m_mapid ~= mapid then
		m_mapurl = url
		m_mapid = mapid
		if mapimg then
			m_mapWidth = 0
			m_mapHeight = 0
			maptxtcont:removeChildren(true)
			ui.npc:removeAllItems()
			ui.monster:removeAllItems()
			mapimg:setWidth(0)
			mapimg:setHeight(0)
			mapimg:setTextureFile(m_mapurl, g_mapPriority)
			if mapimg:getWidth() ~= 0 and mapimg:getHeight() ~= 0 then
				onLoadTex(nil)
			else
				mapimg:addEventListener(F3DObjEvent.OBJ_LOADED, func_oe(onLoadTex))
			end
		end
	end
end

imglist = {}

function updateImgList()
	if not ui or not ui:isVisible() then
		return
	end
	if not mapimg or m_mapid ~= g_mapid or g_mapWidth == 0 or g_mapHeight == 0 then
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
				img:setPositionX(mapimg:getPositionX()+mapimg:getWidth()*role:getPositionX()/g_mapWidth)
				img:setPositionY(mapimg:getPositionY()+mapimg:getHeight()*(g_mapHeight-role:getPositionY())/g_mapHeight)
			else
				img:setPositionX(mapimg:getPositionX()+mapimg:getWidth()*role:getPositionX()/g_mapWidth)
				img:setPositionY(mapimg:getPositionY()+mapimg:getHeight()*to2d(role:getPositionY())/g_mapHeight)
			end
			minimapimglist:addChild(img)
			currindex = currindex+1
		end
	end
	for i=currindex,#imglist do
		imglist[i]:removeFromParent()
	end
end

function updatePos(posx, posy, rotate)
	if not ui or not ui:isVisible() then
		return
	end
	if not mapimg or m_mapid ~= g_mapid or g_mapWidth == 0 or g_mapHeight == 0 then
		return
	end
	minimapmeimg:setRotationZ(rotate)
	if g_is3D then
		minimapmeimg:setPositionX(mapimg:getPositionX()+mapimg:getWidth()*posx/g_mapWidth)
		minimapmeimg:setPositionY(mapimg:getPositionY()+mapimg:getHeight()*(g_mapHeight-posy)/g_mapHeight)
	else
		minimapmeimg:setPositionX(mapimg:getPositionX()+mapimg:getWidth()*posx/g_mapWidth)
		minimapmeimg:setPositionY(mapimg:getPositionY()+mapimg:getHeight()*to2d(posy)/g_mapHeight)
	end
end

function updateMoveGoal(mapid, posx, posy, mapWidth, mapHeight)
	if not mapimg or mapWidth == 0 or mapHeight == 0 then
		return
	end
	m_movemapid = mapid
	if m_is3D then
		movegoalimg:setPositionX(mapimg:getPositionX()+mapimg:getWidth()*posx/mapWidth)
		movegoalimg:setPositionY(mapimg:getPositionY()+mapimg:getHeight()*(mapHeight-posy)/mapHeight)
	else
		movegoalimg:setPositionX(mapimg:getPositionX()+mapimg:getWidth()*posx/mapWidth)
		movegoalimg:setPositionY(mapimg:getPositionY()+mapimg:getHeight()*posy/mapHeight)
	end
	movegoalimg:setVisible(m_mapid == m_movemapid)
end

function onLoadTex(e)
	if e then
		e:getTarget():removeEventListener(F3DObjEvent.OBJ_LOADED, func_oe(onLoadTex))
	end
	local w = ui.left:getWidth()
	local h = ui.left:getHeight()
	local wr = w / mapimg:getWidth()
	local hr = h / mapimg:getHeight()
	local mr = math.min(wr, hr)
	
	
--	mapimg:setWidth(mapimg:getWidth() * mr)
--	mapimg:setHeight(mapimg:getHeight() * mr)
	
	mapimg:setWidth(w)
	mapimg:setHeight(h)	
	
	mapimg:setPositionX((w-mapimg:getWidth())/2)
	mapimg:setPositionY((h-mapimg:getHeight())/2)
	
	updateShape()
	local s = F3DUtils:getFilename(地图表.Config[m_mapid].map)
	s = F3DUtils:trimPostfix(s)
	local dirname = 地图表.Config[m_mapid].map:sub(1,地图表.Config[m_mapid].map:find("/")-1)
	local url = 全局设置.getMapUrl(s, dirname)--m_is3D)
	local map = F3DAssets:instance():getMap(url)
	if map then
		onLoadMap(map)
	else
		F3DAssets:instance():loadFile(url, F3DFunction:new(onLoadMap,"F3DMap"), g_mapPriority)
	end
end

function onLoadMap(map)
	m_mapWidth = map:getMapWidth()
	m_mapHeight = map:getMapHeight()
	for i,v in ipairs(刷新表.Config) do
		if v.mapid == m_mapid and v.show == 1 then
			local tf = F3DTextField:new()
			if g_mobileMode then
				tf:setTextFont("宋体",16,false,false,false)
			end
			tf:setPivot(0.5,0.5)
			tf:setText(txt(v.name))
			tf:setTextColor(v.type==1 and 0xff0000 or v.jumpmap==0 and 0xff00 or 0xffffff, 0)
			if m_is3D then
				tf:setPositionX(math.floor(mapimg:getPositionX()+mapimg:getWidth()*v.bornpos[1]/m_mapWidth))
				tf:setPositionY(math.floor(mapimg:getPositionY()+mapimg:getHeight()*(m_mapHeight-v.bornpos[2])/m_mapHeight))
			else
				tf:setPositionX(math.floor(mapimg:getPositionX()+mapimg:getWidth()*v.bornpos[1]/m_mapWidth))
				tf:setPositionY(math.floor(mapimg:getPositionY()+mapimg:getHeight()*v.bornpos[2]/m_mapHeight))
			end
			maptxtcont:addChild(tf)
			local list = (v.type == 0 and v.jumpmap ~= 0) and ui.npc or ui.monster
			list:getVScroll():setPercent(0)
			local item = tt(ui.checkbox:clone(),F3DCheckBox)
			item:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
				if not 主界面UI.checkFindPathPos(e:getStageX(), e:getStageY()) then
					moveToMap(v.mapid, v.bornpos[1], v.bornpos[2])
				end
			end))
			item:findComponent("component_1"):addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
				resetMovePoint()
				消息.CG_TRANSPORT(v.mapid, v.bornpos[1], v.bornpos[2])
				g_targetPos.bodyid = 0
				setMainRoleTarget(nil)
				--技能逻辑.autoUseSkill = v.type == 1
				--小地图UI.CheckHandup()
			end))
			if ISLT then
				item:findComponent("component_1"):setVisible(false)
			end
			item:setTitleText(txt(v.name))
			list:addItem(item)
		end
	end
end

function onClose(e)
	ui:setVisible(false)
	ui.close:releaseMouse()
	e:stopPropagation()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onUIInit()
	ui.close = ui:findComponent("titlebar,close")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	mapimg = F3DImage:new()
	ui.left = ui:findComponent("cont_1,left")
	ui.left:addChild(mapimg)
	maptxtcont = F3DDisplayContainer:new()
	ui.left:addChild(maptxtcont)
	shape = F3DShape:new()
	shape:setPenColor(0,1,1,0.5)
	shape:setPenSize(2)
	ui.left:addChild(shape)
	movegoalimg = F3DImage:new()
	movegoalimg:setTextureFile(UIPATH.."公用/radar/icon_radar_3.png")
	movegoalimg:setPivot(0.5,0.8)
	movegoalimg:setVisible(false)
	ui.left:addChild(movegoalimg)
	minimapimglist = F3DDisplayContainer:new()
	ui.left:addChild(minimapimglist)
	minimapmeimg = F3DImage:new()
	minimapmeimg:setTextureFile(UIPATH.."公用/radar/icon_radar_me.png")
	minimapmeimg:setPivot(0.5,0.5)
	ui.left:addChild(minimapmeimg)

	ui.left:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(function (e)
		if not 主界面UI.checkFindPathPos(e:getStageX(), e:getStageY()) and m_mapWidth ~= 0 and m_mapHeight ~= 0 then
			local rx = (e:getLocalPos().x - mapimg:getPositionX()) / mapimg:getWidth()
			local ry = (e:getLocalPos().y - mapimg:getPositionY()) / mapimg:getHeight()
			local posx = math.floor(rx * m_mapWidth)
			local posy = math.floor(m_is3D and m_mapHeight - ry * m_mapHeight or ry * m_mapHeight)
			moveToMap(m_mapid, posx, posy)
		end
	end))
	ui.npc = tt(ui:findComponent("cont_1,npc"),F3DList)
	ui.monster = tt(ui:findComponent("cont_1,monster"),F3DList)
	ui.checkbox = ui:findComponent("cont_1,checkbox")
	ui.checkbox:setVisible(false)
	if m_mapurl ~= "" then
		mapimg:setWidth(0)
		mapimg:setHeight(0)
		mapimg:setTextureFile(m_mapurl, g_mapPriority)
		if mapimg:getWidth() ~= 0 and mapimg:getHeight() ~= 0 then
			onLoadTex(nil)
		else
			mapimg:addEventListener(F3DObjEvent.OBJ_LOADED, func_oe(onLoadTex))
		end
	end
end

function moveToMap(mapid, posx, posy)
	技能逻辑.autoUseSkill = false
	小地图UI.CheckHandup(true)
	setMainRoleTarget(nil)
	g_targetPos.bodyid = 0
	g_targetPos.x = 0
	g_targetPos.y = 0
	movedownfunc = nil
	updateMoveGoal(mapid, posx, posy, m_mapWidth, m_mapHeight)

	if mapid == g_mapid then
		if g_role.unmovable == 1 then
			g_targetPos.x = posx
			g_targetPos.y = posy
		else
			if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
				消息.CG_CHANGE_STATUS(0,-1)
				--g_role.status = 1
				--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
			end
			startAStar(posx, posy, true, true)
		end
	else
		tbpath = {}
		local tb = moveTo({to=mapid}, mapid, 1)
		movepath = {}
		while tb do
			movepath[#movepath+1] = tb.to
			tb = tb.tb
		end
		--print("=========================")
		--for i,v in ipairs(movepath) do print(v) end
		--print("=========================")
		if #movepath > 0 then
			--movepos = {mapid, posx, posy}
		end
		checkMovePath()
	end
	movepos = {mapid, posx, posy}
end

function moveTo(tb, mapid, i)
	for k,v in pairs(jumpmap) do
		if 实用工具.indexOf(v.jump, mapid) then
			--local s = mapid.."\t"..k
			--for ii=1,i do s = "\t"..s end
			--print(s)
			if k == g_mapid then
				return tb
			end
			if tbpath[k] == nil then
				tb[k] = {to=k,tb=tb}
				tbpath[k] = 1
			end
		end
	end
	for k,v in pairs(tb) do
		if k ~= "to" and k ~= "tb" then
			local t = moveTo(v, k, i+1)
			if t then
				return t
			end
		end
	end
end

movepath = nil
movepos = nil
movedownfunc = nil
movedownmapid = 0

function startMoveTo(mapid)
	if jumpmap[g_mapid] then
		for i,v in ipairs(jumpmap[g_mapid].ref) do
			if v.mapid == g_mapid and v.type == 0 and v.jumpmap == mapid then
				if g_role.unmovable == 1 then
					g_targetPos.x = v.bornpos[1]
					g_targetPos.y = v.bornpos[2]
				else
					if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
						消息.CG_CHANGE_STATUS(0,-1)
						--g_role.status = 1
						--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
					end
					startAStar(v.bornpos[1], v.bornpos[2], true, true)
				end
				return true
			end
		end
	end
end

function checkMovePath()
	if movepos and movepos[1] == g_mapid then
		if movepos[2] == 0 and movepos[3] == 0 then
		elseif g_role.unmovable == 1 then
			g_targetPos.x = movepos[2]
			g_targetPos.y = movepos[3]
		else
			if g_role.status == 1 and (not IS3G or not g_role:getAnimName():find("attack_")) then
				消息.CG_CHANGE_STATUS(0,-1)
				--g_role.status = 1
				--g_role:setMoveSpeed(g_role:getMoveSpeed()*2)
			end
			startAStar(movepos[2], movepos[3], true, true)
		end
		小地图UI.CheckHandup(not (movepos[2] == 0 and movepos[3] == 0))
		--movepos = nil
		--movepath = nil
	elseif movepath and #movepath > 0 then
		local mapid = movepath[1]
		if startMoveTo(mapid) then
			table.remove(movepath, 1)
		end
		小地图UI.CheckHandup(true)
	end
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if ui then
		ui:setVisible(false)
	end
end

function toggle()
	if isHided() then
		initUI()
		setMapUrl(全局设置.getMinimapUrl(g_mapfileid, g_mapdirname), g_mapid)--g_is3D
	else
		hideUI()
	end
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
	ui:setMovable(true)
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."地图UIm.layout" or UIPATH.."地图UI.layout")
end
