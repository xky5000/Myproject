module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 角色逻辑 = require("主界面.角色逻辑")
local 背包UI = require("主界面.背包UI")
local 角色UI = require("主界面.角色UI")

m_init = false
m_itemdata = nil
m_isEquipped = false
m_isbag = false
COLORBG = {
	"",
	UIPATH.."image/界面_气泡背景颜色1.png",
	UIPATH.."image/界面_气泡背景颜色2.png",
	UIPATH.."image/界面_气泡背景颜色3.png",
	UIPATH.."image/界面_气泡背景颜色4.png",
}

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
	ui.color:setBackground(COLORBG[1])
	ui.img:setTextureFile("")
	ui.grade:setTextureFile("")
	ui.name:setTitleText("")
	ui.name:setTextColor(全局设置.getColorRgbVal(1))
	ui.desc:setTitleText("")
	ui.level:setTitleText("")
	ui.类型:setTitleText("")
	ui.isEquipped:setVisible(false)
	for i=1,#ui.props do
		ui.props[i]:setVisible(false)
	end
	local clips = F3DPointVector:new()
	clips:clear()
	clips:push(0, -clips:size()*13)
end

function update()
	if not m_init or not m_itemdata then
		return
	end
	ui.color:setBackground(COLORBG[m_itemdata.grade])
	ui.img:setTextureFile(全局设置.getItemIconUrl(m_itemdata.icon))
	ui.grade:setTextureFile(全局设置.getGradeUrl(m_itemdata.grade))
	ui.strengthen:setText(m_itemdata.strengthen > 0 and "+"..m_itemdata.strengthen or "")
	ui.name:setTitleText(txt(m_itemdata.name))--..(m_itemdata.strengthen ~= 0 and txt(" (强化+"..m_itemdata.strengthen..")") or ""))
	ui.name:setTextColor(m_itemdata.color > 0 and m_itemdata.color or 全局设置.getColorRgbVal(m_itemdata.grade))
	ui.desc:setTitleText(txt(m_itemdata.desc))
	if m_itemdata.type == 3 and m_itemdata.equippos == 14 then
		ui.level:setTitleText(txt("孵化时间："..(m_itemdata.cdmax/3600000).."小时"))
	elseif m_itemdata.level >= 100 then
		ui.level:setTitleText(txt("转生等级："..全局设置.转生[math.floor(m_itemdata.level/100)]))--("..(m_itemdata.level%100)..")"))
	else
		ui.level:setTitleText(txt("需要等级："..m_itemdata.level))
	end
	ui.类型:setTitleText(txt("装备类型："..全局设置.获取物品类型(m_itemdata.type, m_itemdata.equippos)))
	ui.isEquipped:setVisible(m_isEquipped)
	local props = {}
	local aprops = {}
	local gprops = {}
	for i,v in ipairs(m_itemdata.prop) do
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
					local str = ""
					if(i >= 3 and i <= 6) then
						str = (props[i+1] or 0)
					else
						str = props[i].."-"..(props[i+1] or 0)
					end
					if aprops[i] or aprops[i+1] then
						str = str.." ("..(aprops[i] or 0).."-"..(aprops[i+1] or 0)..")"
					end
					ui.props[index]:setTitleText(txt(v[1].."：")..str)
					ui.props[index]:setTextColor(全局设置.getColorRgbVal(math.max(gprops[i] or 1, gprops[i+1] or 1)))
					ui.props[index].pic:setTextureFile("")
					ui.props[index]:setVisible(true)
					index = index + 1
				end
			else
				local str = props[i]..(v[3] and "%" or "")..(aprops[i] and " ("..aprops[i]..")" or "")
				ui.props[index]:setTitleText(txt(v[1].."：")..str)
				ui.props[index]:setTextColor(全局设置.getColorRgbVal(gprops[i] or 1))
				ui.props[index].pic:setTextureFile("")
				ui.props[index]:setVisible(true)
				index = index + 1
			end
		end
	end
	if #m_itemdata.attachprop > 0 then
		checkPropIndex(index)
		if m_itemdata.attachprop[1][1] <= 5 then
			ui.props[index]:setTitleText(txt("附魔：")..txt(全局设置.附魔[m_itemdata.attachprop[1][1]][m_itemdata.job==0 and 角色逻辑.m_rolejob or 1]).." +"..m_itemdata.attachprop[1][2].."%")
		else
			ui.props[index]:setTitleText(txt("附魔：")..txt(全局设置.附魔[m_itemdata.attachprop[1][1]][1]).." +"..m_itemdata.attachprop[1][2].."%")
		end
		ui.props[index]:setTextColor(0xDD2020)
		ui.props[index].pic:setTextureFile("")
		ui.props[index]:setVisible(true)
		index = index + 1
	end
	for i,v in ipairs(m_itemdata.gemprop) do
		checkPropIndex(index)
		if m_itemdata.gemprop[i][1] == 1 then
			ui.props[index]:setTitleText(txt("镶嵌：")..txt(全局设置.宝石[m_itemdata.gemprop[i][1]][1]).." ("..(m_itemdata.gemprop[i][2]*10)..")")
		else
			ui.props[index]:setTitleText(txt("镶嵌：")..txt(全局设置.宝石[m_itemdata.gemprop[i][1]][1]).." (0-"..m_itemdata.gemprop[i][2]..")")
		end
		ui.props[index]:setTextColor(全局设置.getColorRgbVal(m_itemdata.gemprop[i][2]))
		ui.props[index].pic:setTextureFile(全局设置.getItemIconUrl(全局设置.宝石[m_itemdata.gemprop[i][1]][2]))
		ui.props[index]:setVisible(true)
		index = index + 1
	end
	if #m_itemdata.ringsoul > 0 then
		checkPropIndex(index)
		ui.props[index]:setTitleText(txt("戒灵：")..txt(m_itemdata.ringsoul[1][1].." ("..m_itemdata.ringsoul[1][2].."级"..m_itemdata.ringsoul[1][3].."星)"))
		ui.props[index]:setTextColor(全局设置.getColorRgbVal(m_itemdata.ringsoul[1][4]))
		ui.props[index].pic:setTextureFile("")
		ui.props[index]:setVisible(true)
		index = index + 1
	end
	if m_itemdata.suitname ~= "" and #m_itemdata.suitprop > 1 then
		checkPropIndex(index)
		local cnt = 0
		local suitid = 角色UI.m_tabid == 1 and -m_itemdata.suitprop[1][1] or m_itemdata.suitprop[1][1]
		for i=1,#角色逻辑.m_suitcnts,2 do
			if 角色逻辑.m_suitcnts[i] == suitid then
				cnt = 角色逻辑.m_suitcnts[i+1]
				break
			end
		end
		ui.props[index]:setTitleText(txt(m_itemdata.suitname).." ("..cnt.." / "..m_itemdata.suitprop[1][2]..")")
		local color = cnt >= m_itemdata.suitprop[1][2] and 0x00cccc or 0x006666
		ui.props[index]:setTextColor(color)
		ui.props[index].pic:setTextureFile("")
		ui.props[index]:setVisible(true)
		index = index + 1
		local suitprops = {}
		for i,v in ipairs(m_itemdata.suitprop) do
			if i > 1 then
				suitprops[v[1]] = (suitprops[v[1]] or 0) + v[2] + v[3]
				if v[1] == 4 or v[1] == 6 or v[1] == 8 or v[1] == 10 or v[1] == 12 then
					suitprops[v[1]-1] = (suitprops[v[1]-1] or 0)
				end
			end
		end
		for _,v in ipairs(全局设置.proptexts) do
			i = v[2]
			if suitprops[i] then
				checkPropIndex(index)
				if i >= 3 and i <= 12 then
					if i % 2 == 1 then
						local str = suitprops[i].."-"..(suitprops[i+1] or 0)
						ui.props[index]:setTitleText(txt(v[1].."：")..str)
						ui.props[index]:setTextColor(color)
						ui.props[index].pic:setTextureFile("")
						ui.props[index]:setVisible(true)
						index = index + 1
					end
				else
					local str = suitprops[i]..(v[3] and "%" or "")
					ui.props[index]:setTitleText(txt(v[1].."：")..str)
					ui.props[index]:setTextColor(color)
					ui.props[index].pic:setTextureFile("")
					ui.props[index]:setVisible(true)
					index = index + 1
				end
			end
		end
	end
	for i=index,#ui.props do
		ui.props[i]:setVisible(false)
	end
	local proph = g_mobileMode and 25 or 20
	ui.img_tipsBg:setHeight(ui.oldheight+(index-2)*proph)--270+index*20)
	ui:setHeight(ui.oldheight+(index-2)*proph)--270+index*20)
	local clips = F3DPointVector:new()
	clips:clear()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function checkPropIndex(i)
	if not ui.props[i] then
		local proph = g_mobileMode and 25 or 20
		ui.props[i] = i == 1 and ui:findComponent("属性") or ui.props[1]:clone()
		ui.props[i].pic = F3DImage:new()
		ui.props[i].pic:setWidth(22)
		ui.props[i].pic:setHeight(18)
		ui.props[i].pic:setPositionX(-25)
		ui.props[i]:addChild(ui.props[i].pic)
		ui.props[i]:setPositionY(ui.props[1]:getPositionY()+(proph*(i-1)))
		ui:addChild(ui.props[i])
	end
end

function onUIInit()
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.grid = ui:findComponent("图标")
	ui.name = ui:findComponent("名称")
	ui.desc = ui:findComponent("说明")
	ui.level = ui:findComponent("等级")
	ui.类型 = ui:findComponent("类型")
	ui.color = ui:findComponent("颜色")
	ui.props = {}
	ui.isEquipped = ui:findComponent("已装备")
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
	ui.strengthen = F3DTextField:new()
	if g_mobileMode then
		ui.strengthen:setTextFont("宋体",16,false,false,false)
	end
	ui.strengthen:setPositionX(ui.grid:getWidth()-4)
	ui.strengthen:setPositionY(4)
	ui.strengthen:setPivot(1,0)
	ui.grid:addChild(ui.strengthen)
	ui.img_tipsBg = ui:findComponent("背景")
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
	ui:setLayout(g_mobileMode and UIPATH.."装备提示UIm.layout" or UIPATH.."装备提示UI.layout")
end
