module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 角色逻辑 = require("主界面.角色逻辑")
local 地图表 = require("配置.地图表")

m_init = false
m_curpage = 1
m_copyinfo = nil
m_pagecnt = 3
m_tp = 0
m_刷怪数量 = 10
m_selectindex = 0
m_selectmapid = 0

copyscenemap = {
	--[190]={UIPATH.."副本/copyscene/copypic_3.jpg",UIPATH.."副本/copyscene/copytxt_3.png"},
	--[192]={UIPATH.."副本/copyscene/copypic_2.jpg",UIPATH.."副本/copyscene/copytxt_2.png"},
	--[191]={UIPATH.."副本/copyscene/copypic_7.jpg",UIPATH.."副本/copyscene/copytxt_7.png"},
	--[196]={UIPATH.."副本/copyscene/copypic_4.jpg",UIPATH.."副本/copyscene/copytxt_4.png"},
	--[193]={UIPATH.."副本/copyscene/copypic_8.jpg",UIPATH.."副本/copyscene/copytxt_8.png"},
}

function SortCopyinfo(v1, v2)
	local conf1 = 地图表.Config[v1[1]]
	local conf2 = 地图表.Config[v2[1]]
	if conf1.level ~= conf2.level then
		return conf1.level < conf2.level
	elseif v1[1] ~= v2[1] then
		return v1[1] < v2[1]
	else
		return false
	end
end

function setSelectMapID(mapid)
	m_selectmapid = mapid
	update()
end

function setCopyInfo(info)
	m_copyinfo = info
	table.sort(m_copyinfo, SortCopyinfo)
	update()
end

function setKeduBar(刷怪数量)
	m_刷怪数量 = 刷怪数量
	updateKeduBar()
end

function updateKeduBar()
	if not m_init then
		return
	end
	ui.刷怪数量:setTitleText(txt("刷怪数量: ")..m_刷怪数量)
	ui.刷怪刻度:setCurrVal(m_刷怪数量)
end

function setTP(tp)
	m_tp = tp
	updateTP()
end

function updateTP()
	if not m_init then
		return
	end
	ui.我的体力:setTitleText(txt("我的体力: ")..m_tp.." / 500")
end

function update()
	if not m_init or not m_copyinfo then
		return
	end
	if m_selectmapid ~= 0 then
		for i,v in ipairs(m_copyinfo) do
			if v[1] == m_selectmapid then
				m_curpage = math.ceil(i / m_pagecnt)
				m_selectindex = i
				break
			end
		end
		m_selectmapid = 0
	end
	local index = (m_curpage-1)*m_pagecnt
	for i=1,m_pagecnt do
		local v = m_copyinfo[index+i]
		if v then
			local conf = 地图表.Config[v[1]]
			local s = F3DUtils:getFilename(conf.map)
			s = F3DUtils:trimPostfix(s)
			local dirname = conf.map:sub(1,conf.map:find("/")-1)
			--local mapfileid = tonumber(s)
			--local vv = copyscenemap[mapfileid]
			ui.copyscenes[i]:setVisible(true)
			--ui.copyscenes[i].copypic:setBackground(vv and vv[1] or "")
			--ui.copyscenes[i].copytxt:setBackground(vv and vv[2] or "")
			--ui.copyscenes[i].copytxt:setTitleText(vv and vv[3] or "")
			if IS3G then
				ui.copyscenes[i].copypic:setBackground("/res/icon/copyscene/"..s..".png")
			else
				ui.copyscenes[i].copypic:setBackground(全局设置.getMinimapUrl(s, dirname))
			end
			ui.copyscenes[i].copytxt:setBackground("")
			ui.copyscenes[i].copytxt:setTitleText(txt(conf.name))
			ui.copyscenes[i].shouling:setTitleText(v[5] ~= "" and txt("BOSS: "..v[5]) or "")
			实用工具.setClipNumber(conf.level,ui.copyscenes[i].lvpic)
			ui.copyscenes[i].zudui:setVisible(conf.humancount > 1)
			if #conf.costtp == 1 then
				ui.copyscenes[i].tili:setTitleText(txt("消耗体力：")..conf.costtp[1])
			elseif #conf.costtp == 2 then
				ui.copyscenes[i].tili:setTitleText(txt("每")..(conf.costtp[2] > 1 and conf.costtp[2] or "")..txt("分钟消耗体力：")..conf.costtp[1])
			else
				ui.copyscenes[i].tili:setTitleText(txt("无消耗体力"))
			end
			ui.copyscenes[i].cishu:setTitleText(txt("挑战次数: ")..(v[3] == 0 and txt("无限制") or v[2].." / "..v[3]))
			ui.copyscenes[i].img_lock:setVisible(角色逻辑.m_level < conf.level)
			ui.copyscenes[i].imgisFinish:setVisible(v[6] == 1 or (v[3] ~= 0 and v[2] >= v[3]))
			local dead = v[7]>0
			ui.copyscenes[i].fenge0:setVisible(dead)
			ui.copyscenes[i].fenge1:setVisible(dead)
			ui.copyscenes[i].shi:setVisible(dead)
			ui.copyscenes[i].fen:setVisible(dead)
			ui.copyscenes[i].miao:setVisible(dead)
			if dead then
				实用工具.setClipNumber(math.floor(v[7]/(1000*60*60)), ui.copyscenes[i].shipic, true, true)
				实用工具.setClipNumber(math.floor(v[7]/(1000*60))%60, ui.copyscenes[i].fenpic, true, true)
				实用工具.setClipNumber(math.floor(v[7]/(1000))%60, ui.copyscenes[i].miaopic, true, true)
			end
			ui.copyscenes[i].zhezhao:setVisible(角色逻辑.m_level < conf.level)
			--ui.copyscenes[i].xuanzhong:setVisible(m_selectindex == index+i)
			ui.copyscenes[i].xuanzhong:setBackground(m_selectindex == index+i and UIPATH.."副本/xuanzhong.png" or "")
		else
			ui.copyscenes[i]:setVisible(false)
		end
	end
end

function onBtnLeft(e)
	if not m_copyinfo then
		return
	end
	local totalpage = math.ceil(#m_copyinfo / m_pagecnt)
	m_curpage = math.max(1, m_curpage - 1)
	update()
end

function onBtnRight(e)
	if not m_copyinfo then
		return
	end
	local totalpage = math.ceil(#m_copyinfo / m_pagecnt)
	m_curpage = math.min(totalpage, m_curpage + 1)
	update()
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

function onKeduChange(e)
	m_刷怪数量 = math.floor(ui.刷怪刻度:getCurrVal())
	ui.刷怪数量:setTitleText(txt("刷怪数量: ")..m_刷怪数量)
end

function onUIInit()
	ui.close = ui:findComponent("titlebar,close")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.copyscenes = {}
	for i=1,m_pagecnt do
		ui.copyscenes[i] = ui:findComponent("copyscene_"..i)
		ui.copyscenes[i].copypic = ui:findComponent("copyscene_"..i..",copypic")
		ui.copyscenes[i].copytxt = ui:findComponent("copyscene_"..i..",copytxt")
		ui.copyscenes[i].shouling = ui:findComponent("copyscene_"..i..",shouling")
		ui.copyscenes[i].clip_level = ui:findComponent("copyscene_"..i..",clip_level")
		ui.copyscenes[i].lvpic = ui.copyscenes[i].clip_level:getBackground()
		ui.copyscenes[i].zudui = ui:findComponent("copyscene_"..i..",zudui")
		ui.copyscenes[i].cishu = ui:findComponent("copyscene_"..i..",cishu")
		ui.copyscenes[i].tili = ui:findComponent("copyscene_"..i..",tili")
		if g_mobileMode then
			ui.copyscenes[i].diaoluo = ui:findComponent("copyscene_"..i..",diaoluo")
			ui.copyscenes[i].diaoluo:setVisible(false)
		end
		ui.copyscenes[i].grid_1 = ui:findComponent("copyscene_"..i..",gridBg_0")
		ui.copyscenes[i].grid_2 = ui:findComponent("copyscene_"..i..",gridBg_1")
		ui.copyscenes[i].grid_3 = ui:findComponent("copyscene_"..i..",gridBg_2")
		ui.copyscenes[i].grid_4 = ui:findComponent("copyscene_"..i..",gridBg_3")
		ui.copyscenes[i].img_lock = ui:findComponent("copyscene_"..i..",img_lock")
		ui.copyscenes[i].imgisFinish = ui:findComponent("copyscene_"..i..",imgisFinish")
		ui.copyscenes[i].fenge0 = ui:findComponent("copyscene_"..i..",img_semicolon")
		ui.copyscenes[i].fenge1 = ui:findComponent("copyscene_"..i..",img_semicolon_1")
		ui.copyscenes[i].shi = ui:findComponent("copyscene_"..i..",shi")
		ui.copyscenes[i].shipic = ui.copyscenes[i].shi:getBackground()
		ui.copyscenes[i].fen = ui:findComponent("copyscene_"..i..",fen")
		ui.copyscenes[i].fenpic = ui.copyscenes[i].fen:getBackground()
		ui.copyscenes[i].miao = ui:findComponent("copyscene_"..i..",miao")
		ui.copyscenes[i].miaopic = ui.copyscenes[i].miao:getBackground()
		ui.copyscenes[i].zhezhao = ui:findComponent("copyscene_"..i..",zhezhao")
		ui.copyscenes[i].xuanzhong = ui:findComponent("copyscene_"..i..",xuanzhong")
		ui.copyscenes[i].xuanzhong.id = i
		ui.copyscenes[i].xuanzhong:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
			local btn = e:getCurrentTarget()
			if btn and m_copyinfo and m_copyinfo[(m_curpage-1)*m_pagecnt+btn.id] then
				local index = (m_curpage-1)*m_pagecnt
				m_selectindex = index+btn.id
				update()
			end
		end))
		ui.copyscenes[i].lijiqianwang = ui:findComponent("copyscene_"..i..",lijiqianwang")
		ui.copyscenes[i].lijiqianwang.id = i
		ui.copyscenes[i].lijiqianwang:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
			local btn = e:getCurrentTarget()
			if btn and m_copyinfo and m_copyinfo[(m_curpage-1)*m_pagecnt+btn.id] then
				消息.CG_ENTER_COPYSCENE(m_copyinfo[(m_curpage-1)*m_pagecnt+btn.id][1], m_刷怪数量)
			end
		end))
	end
	ui.我的体力 = ui:findComponent("component_1")
	ui.刷怪数量 = ui:findComponent("component_4")
	ui.刷怪刻度 = tt(ui:findComponent("scroll_1"), F3DScroll)
	ui.刷怪刻度:setMinVal(1)
	ui.刷怪刻度:setMaxVal(30)
	ui.刷怪刻度:setStepVal(1)
	ui.刷怪刻度:addEventListener(F3DUIEvent.CHANGE, func_ue(onKeduChange))
	ui.btn_left = ui:findComponent("btn_left")
	ui.btn_left:addEventListener(F3DMouseEvent.CLICK, func_me(onBtnLeft))
	ui.btn_right = ui:findComponent("btn_right")
	ui.btn_right:addEventListener(F3DMouseEvent.CLICK, func_me(onBtnRight))
	m_init = true
	update()
	updateTP()
	updateKeduBar()
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
	ui:setMovable(true)
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."个人副本UIm.layout" or UIPATH.."个人副本UI.layout")
end
