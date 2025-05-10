module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 背包UI = require("主界面.背包UI")

m_init = false
m_itemdata = nil
m_isEquipped = false
m_isbag = false
m_avt = nil
m_bodyid = 0
m_effid = 0

function setItemData(itemdata, isEquipped, isbag)
	m_itemdata = itemdata
	m_isEquipped = isEquipped
	m_isbag = isbag
	update()
end

function setEmptyItemData()
	if not m_init then
		return
	end
	if m_avt then
		m_avt:reset()
	end
	m_bodyid = 0
	m_effid = 0
	ui.color:setBackground(COLORBG[1])
	ui.img:setTextureFile("")
	ui.grade:setTextureFile("")
	ui.lock:setTextureFile("")
	ui.name:setTitleText("")
	ui.name:setTextColor(全局设置.getColorRgbVal(1))
	ui.desc:setTitleText("")
	ui.job:setTitleText("")
	ui.level:setTitleText("")
	ui.类型:setTitleText("")
	ui.isEquipped:setVisible(false)
	for i=1,#ui.props do
		ui.props[i]:setVisible(false)
	end
	local clips = F3DPointVector:new()
	clips:clear()
	clips:push(0, -clips:size()*13)
	ui.zhanli:setBatchClips(10, clips)
	ui.zhanli:setOffset(-13+clips:size()*13, 0)
	if g_mobileMode then
		for i = 1,5 do
			ui.menus[i]:setVisible(false)
		end
	end
end

COLORBG = {
	"",
	UIPATH.."公用/tip/tips_color_1.png",
	UIPATH.."公用/tip/tips_color_2.png",
	UIPATH.."公用/tip/tips_color_3.png",
	UIPATH.."公用/tip/tips_color_4.png",
}
function update()
	if not m_init or not m_itemdata then
		return
	end
	if not m_avt then
		if ISMIR2D then
			m_avt = F3DImageAnim3D:new()
			m_avt:setImage2D(true)
		else
			m_avt = F3DAvatar:new()
		end
		ui.avtcont:addChild(m_avt)
	end
	if #m_itemdata.prop > 0 and (m_bodyid ~= m_itemdata.prop[1][2] or m_effid ~= m_itemdata.prop[1][3]) then
		m_bodyid = m_itemdata.prop[1][2]
		m_effid = m_itemdata.prop[1][3]
		local url = ISMIR2D and 全局设置.getAnimPackUrl(m_bodyid) or 全局设置.getModelUrl(m_bodyid)
		m_avt:reset()
		m_avt:setAnimName("idle")
		if ISMIR2D then
			m_avt:setScaleX(1)
			m_avt:setScaleY(1)
			if m_bodyid ~= 0 then
				m_avt:setEntity(F3DImageAnim3D.PART_BODY, url)
			end
			if m_effid ~= 0 then
				if m_bodyid == 0 then
					m_avt:setEffectSystem(全局设置.getAnimPackUrl(m_effid), true, nil, nil, 0, -1)
				else
					m_avt:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(m_effid)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			end
		else
			m_avt:setScale(1,1,1)
			m_avt:setLighting(true)
			if m_bodyid ~= 0 then
				m_avt:setEntity(F3DAvatar.PART_BODY, url)
				m_avt:setAnimSet(F3DUtils:trimPostfix(url)..".txt")
			end
			if m_effid ~= 0 then
				m_avt:setEffectSystem(全局设置.getEffectUrl(m_effid))
			end
		end
	end
	ui.color:setBackground(COLORBG[m_itemdata.grade])
	ui.img:setTextureFile(全局设置.getItemIconUrl(m_itemdata.icon))
	ui.grade:setTextureFile(全局设置.getGradeUrl(m_itemdata.grade))
	ui.lock:setTextureFile(m_itemdata.bind == 1 and UIPATH.."公用/grid/img_bind.png" or "")
	ui.strengthen:setText(m_itemdata.strengthen > 0 and "+"..m_itemdata.strengthen or "")
	ui.name:setTitleText(txt(m_itemdata.name))--..(m_itemdata.strengthen ~= 0 and " +"..m_itemdata.strengthen or ""))
	ui.name:setTextColor(m_itemdata.color > 0 and m_itemdata.color or 全局设置.getColorRgbVal(m_itemdata.grade))
	ui.desc:setTitleText(txt(m_itemdata.desc))
	ui.job:setTitleText(txt("职业："..全局设置.获取职业类型(m_itemdata.job)))
	if m_itemdata.type == 3 and m_itemdata.equippos == 14 then
		ui.level:setTitleText(txt("孵化时间："..(m_itemdata.cdmax/3600000).."小时"))
	else
		ui.level:setTitleText(txt("等级："..m_itemdata.level))
	end
	ui.类型:setTitleText(txt("类型："..全局设置.获取物品类型(m_itemdata.type, m_itemdata.equippos)))
	ui.isEquipped:setVisible(m_isEquipped)
	local props = {}
	local aprops = {}
	local gprops = {}
	for i = 2, #m_itemdata.prop do
		v = m_itemdata.prop[i]
		props[v[1]] = (props[v[1]] or 0) + v[2] + v[3]
		if v[1] == 4 or v[1] == 6 or v[1] == 8 or v[1] == 10 or v[1] == 12 then
			props[v[1]-1] = (props[v[1]-1] or 0)
		end
	end
	for i,v in ipairs(m_itemdata.addprop) do
		props[v[1]] = (props[v[1]] or 0) + v[2]
		if v[1] == 4 or v[1] == 6 or v[1] == 8 or v[1] == 10 or v[1] == 12 then
			props[v[1]-1] = (props[v[1]-1] or 0)
		end
		aprops[v[1]] = (aprops[v[1]] or 0) + v[2]
		gprops[v[1]] = math.max(gprops[v[1]] or 1, v[3])
	end
	local index = 1
	for _,v in ipairs(全局设置.proptexts) do
		i = v[2]
		if props[i] then
			checkPropIndex(index)
			if i >= 3 and i <= 12 then
				if i % 2 == 1 then
					local str = props[i].."-"..(props[i+1] or 0)
					if aprops[i] or aprops[i+1] then
						str = str.." ("..(aprops[i] or 0).."-"..(aprops[i+1] or 0)..")"
					end
					ui.props[index]:setTitleText(txt(v[1].."：")..str)
					ui.props[index]:setTextColor(全局设置.getColorRgbVal(math.max(gprops[i] or 1, gprops[i+1] or 1)))
					ui.props[index]:setVisible(true)
					index = index + 1
				end
			else
				local str = props[i]..(v[3] and "%" or "")..(aprops[i] and " ("..aprops[i]..")" or "")
				ui.props[index]:setTitleText(txt(v[1].."：")..str)
				ui.props[index]:setTextColor(全局设置.getColorRgbVal(gprops[i] or 1))
				ui.props[index]:setVisible(true)
				index = index + 1
			end
		end
	end
	for i=index,#ui.props do
		ui.props[i]:setVisible(false)
	end
	local proph = g_mobileMode and 25 or 20
	ui.img_tipsBg:setHeight(ui.oldheight+(index-2)*proph)--370+index*20)
	ui:setHeight(ui.oldheight+(index-2)*proph)--370+index*20)
	ui.zhanlicont:setPositionY(ui.zhanlicont.oldposy+(index-2)*proph)--320+index*20)
	if g_mobileMode then
		for i = 1,5 do
			ui.menus[i]:setPositionY(ui.menus[i].oldposy+(index-2)*proph)
			ui.menus[i]:setVisible(m_isbag)
		end
	end
	local clips = F3DPointVector:new()
	clips:clear()
	local zhanli = m_itemdata.power
	if zhanli == 0 then
		clips:push(0, -clips:size()*13)
	else
		while zhanli >= 1 do
			clips:push(math.floor(zhanli%10), -clips:size()*13)
			zhanli = zhanli / 10
		end
	end
	ui.zhanli:setBatchClips(10, clips)
	ui.zhanli:setOffset(-13+clips:size()*13, 0)
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onMenuClick(e)
	local g = e:getCurrentTarget()
	if g == ui.menus[1] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onUse(e)
	elseif g == ui.menus[2] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onBatchUse(e)
	elseif g == ui.menus[3] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onDivide(e)
	elseif g == ui.menus[4] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onDiscard(e)
	elseif g == ui.menus[5] then
		背包UI.m_selectitem = m_itemdata
		背包UI.onSell(e)
	end
	背包UI.hideAllTipsUI()
end

function checkPropIndex(i)
	if not ui.props[i] then
		local proph = g_mobileMode and 25 or 20
		ui.props[i] = i == 1 and ui:findComponent("prop_1") or ui.props[1]:clone()
		ui.props[i]:setPositionY(ui.props[1]:getPositionY()+(proph*(i-1)))
		ui:addChild(ui.props[i])
	end
end

function onUIInit()
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.avtcont = ui:findComponent("avtcont")
	ui.grid = ui:findComponent("gridBg_49X49")
	ui.name = ui:findComponent("component_1")
	ui.desc = ui:findComponent("component_2")
	ui.job = ui:findComponent("component_10")
	ui.level = ui:findComponent("component_11")
	ui.类型 = ui:findComponent("component_9")
	ui.color = ui:findComponent("tips_color_1")
	if g_mobileMode then
		ui.menus = {}
		for i = 1,5 do
			ui.menus[i] = ui:findComponent("menu_"..i)
			ui.menus[i].oldposy = ui.menus[i]:getPositionY()
			ui.menus[i]:addEventListener(F3DMouseEvent.CLICK, func_me(onMenuClick))
		end
	end
	ui.props = {}
	--for i = 1,17 do
	--end
	ui.zhanli = F3DImage:new()
	ui.zhanli:setTextureFile(UIPATH.."公用/equipTips/clip_powerNum.png")
	ui.zhanli:setWidth(17)
	ui:findComponent("zhanlicont,clip_powerNum"):addChild(ui.zhanli)
	ui.isEquipped = ui:findComponent("img_isEquipped")
	ui.img = F3DImage:new()
	--ui.img:setPositionX(2)
	--ui.img:setPositionY(2)
	ui.img:setPositionX(math.floor(ui.grid:getWidth()/2))
	ui.img:setPositionY(math.floor(ui.grid:getHeight()/2))
	ui.img:setPivot(0.5,0.5)
	ui.grid:addChild(ui.img)
	ui.grade = F3DImage:new()
	ui.grade:setPositionX(1)
	ui.grade:setPositionY(1)
	ui.grade:setWidth(ui.grid:getWidth()-2)
	ui.grade:setHeight(ui.grid:getHeight()-2)
	ui.grid:addChild(ui.grade)
	ui.lock = F3DImage:new()
	ui.lock:setPositionX(4)
	ui.lock:setPositionY(ui.grid:getHeight()-4)--32)
	ui.lock:setPivot(0,1)
	ui.grid:addChild(ui.lock)
	ui.strengthen = F3DTextField:new()
	if g_mobileMode then
		ui.strengthen:setTextFont("宋体",16,false,false,false)
	end
	ui.strengthen:setPositionX(ui.grid:getWidth()-4)
	ui.strengthen:setPositionY(4)
	ui.strengthen:setPivot(1,0)
	ui.grid:addChild(ui.strengthen)
	ui.img_tipsBg = ui:findComponent("img_tipsBg")
	ui.zhanlicont = ui:findComponent("zhanlicont")
	ui.zhanlicont.oldposy = ui.zhanlicont:getPositionY()
	ui.oldheight = ui:getHeight()
	m_init = true
	setEmptyItemData()
	update()
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
	if not g_mobileMode then
		ui:setTouchable(false)
	end
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."宠物蛋提示UIm.layout" or UIPATH.."宠物蛋提示UI.layout")
end
