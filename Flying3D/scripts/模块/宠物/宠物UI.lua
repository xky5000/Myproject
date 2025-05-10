module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 实用工具 = require("公用.实用工具")
local 宠物信息UI = require("宠物.宠物信息UI")
local 主界面UI = require("主界面.主界面UI")

m_init = false
m_petinfo = nil
m_petinfotb = nil
m_page = 1
m_pagemax = 1
m_select = 0
m_avt = nil
m_oldbodyid = 0
m_oldeffid = 0
m_downposx = 0
m_avt1 = nil
m_avt2 = nil
m_select1 = 0
m_select2 = 0

function setPetInfo(petinfo, callinfo)
	if not m_petinfo then
		m_petinfo = {}
	end
	for i,v in ipairs(petinfo) do
		m_petinfo[v[1]] = {
			index=v[1],
			level=v[2],
			exp=v[3],
			starlevel=v[4],
			starexp=v[5],
			icon=v[6],
			name=v[7],
			生命值=v[8],
			魔法值=v[9],
			防御=v[10],
			防御上限=v[11],
			魔御=v[12],
			魔御上限=v[13],
			攻击=v[14],
			攻击上限=v[15],
			魔法=v[16],
			魔法上限=v[17],
			道术=v[18],
			道术上限=v[19],
			准确=v[20],
			移动速度=v[21],
			power=v[22],
			type = v[23],
			grade = v[24],
			bodyid = v[25],
			effid = v[26],
			expmax=v[27],
			starexpmax=v[28],
			技能图标=v[29],
			技能品质=v[30],
			技能名字=v[31],
			技能描述=v[32],
			剩余点数=v[33],
			call = 0,
			merge = 0,
			objid = -1,
		}
	end
	for i,v in ipairs(callinfo) do
		if m_petinfo[v[1]] then
			m_petinfo[v[1]].call = v[2]
			m_petinfo[v[1]].merge = v[3]
			m_petinfo[v[1]].objid = v[4]
		end
	end
	m_petinfotb = {}
	for k,v in pairs(m_petinfo) do
		if v.level ~= 0 then
			m_petinfotb[#m_petinfotb+1] = v
		end
	end
	table.sort(m_petinfotb, SortPet)
	m_pagemax = math.max(1,math.ceil(#m_petinfotb / 5))
	宠物信息UI.update()
	宠物信息UI.updateHPBar()
	update()
end

function SortPet(p1, p2)
	if p1.call ~= p2.call then
		return p1.call > p2.call
	elseif p1.grade ~= p2.grade then
		return p1.grade > p2.grade
	elseif p1.starlevel ~= p2.starlevel then
		return p1.starlevel > p2.starlevel
	elseif p1.level ~= p2.level then
		return p1.level > p2.level
	elseif p1.level ~= p2.level then
		return p1.index < p2.index
	else
		return false
	end
end

function update()
	if not m_init or m_petinfotb == nil then
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
	local selectindex = 0
	if m_select ~= 0 then
		for i,v in ipairs(m_petinfotb) do
			if v.index == m_select and v.level > 0 then
				selectindex = i
				break
			end
		end
		if selectindex == 0 then
			m_select = 0
		end
		if selectindex < 1+5*(m_page-1) or selectindex > 5*m_page then
			m_page = math.max(1, math.floor((selectindex - 1) / 5 + 1))
			ui.page:setTitleText(m_page.." / "..m_pagemax)
		end
		setCBSelect(selectindex)
	end
	if selectindex < 1+5*(m_page-1) or selectindex > 5*m_page then
		selectindex = 1+5*(m_page-1)
		setCBSelect(selectindex)
	end
	for i=1,5 do
		local pet = ui.petlist[i]
		local info = m_petinfotb[i+5*(m_page-1)]
		if info and info.level > 0 then
			pet.head:setBackground(全局设置.getPetIconUrl(info.icon))
			pet.head:setVisible(true)
			if info.call ~= 0 then
				pet.state:setFrameRate(0, info.merge ~= 0 and 2 or 1)
				pet.state:setVisible(true)
			else
				pet.state:setVisible(false)
			end
			pet.name:setTitleText(txt(info.name))
			pet.name:setTextColor(全局设置.getColorRgbVal(info.grade))
			pet.level:setTitleText(info.level)
			pet.star:setTitleText(info.starlevel)
			--pet.cname:setVisible(true)
			pet.img_lv:setVisible(true)
			pet.image_star:setVisible(true)
			pet.cb:setTouchable(true)
		else
			pet.head:setVisible(false)
			pet.state:setVisible(false)
			pet.name:setTitleText("")
			pet.level:setTitleText("")
			pet.star:setTitleText("")
			--pet.cname:setVisible(false)
			pet.img_lv:setVisible(false)
			pet.image_star:setVisible(false)
			pet.cb:setTouchable(false)
		end
	end
end

function setCBSelect(selectindex)
	local info = m_petinfotb[selectindex]
	local pet = ui.petlist[selectindex%5==0 and 5 or selectindex%5]
	if info then
		pet.cb:setGroupSelected(false)
		pet.cb:setGroupSelected(true)
	else
		pet.cb:setGroupSelected(false)
	end
end

function onTabChange(e)
	local tabid = ui.tab:getSelectIndex()
	if tabid == 1 then
		local info = m_petinfo[m_select]
		if info and info.type == 0 and info.call == 0 then
			setSelectAvt2(info)
		else
			setSelectAvt1(info)
			for i,v in ipairs(m_petinfotb) do
				if v.type == 0 and v.call == 0 then
					setSelectAvt2(v)
					break
				end
			end
		end
	end
end

function onTrainSuccess()
	if m_avt1 and not ISMIR2D then
		m_avt1:setEffectSystem(全局设置.getEffectUrl(3668), true)
	end
	if m_avt2 then
		m_avt2:reset()
	end
	m_select2 = 0
	m_select = m_select1
	for i,v in ipairs(m_petinfotb) do
		if v.type == 0 and v.call == 0 then
			setSelectAvt2(v)
			break
		end
	end
	update()
end

function setSelectAvt1(info)
	if not m_avt1 then
		if ISMIR2D then
			m_avt1 = F3DImageAnim3D:new()
			m_avt1:setImage2D(true)
		else
			m_avt1 = F3DAvatar:new()
		end
		ui.avtcont1:addChild(m_avt1)
	end
	if not info then
		主界面UI.showTipsMsg(1,txt("请选择一个主宠"))
		return
	end
	if info.type == 0 then
		主界面UI.showTipsMsg(1,txt("特殊型宠物不能作为主宠"))
		return
	end
	if m_select2 == info.index then
		if m_avt2 then
			m_avt2:reset()
		end
		m_select2 = 0
	end
	m_select1 = info.index
	if m_avt1 then
		m_avt1:reset()
		m_avt1:setAnimName("idle")
		if ISMIR2D then
			m_avt1:setScaleX(1)
			m_avt1:setScaleY(1)
			m_avt1:setAnimRotationZ(30)
			m_avt1:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(info.bodyid))
			if info.effid ~= 0 then
				m_avt1:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(info.effid)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
		else
			m_avt1:setScale(1.5,1.5,1.5)
			m_avt1:setRotationZ(30)
			m_avt1:setShowShadow(true)
			m_avt1:setLighting(true)
			m_avt1:setEntity(F3DAvatar.PART_BODY, 全局设置.getPetUrl(info.bodyid))
			m_avt1:setAnimSet(F3DUtils:trimPostfix(全局设置.getPetUrl(info.bodyid))..".txt")
			if info.effid ~= 0 then
				m_avt1:setEffectSystem(全局设置.getEffectUrl(info.effid), true)
			end
		end
	end
end

function setSelectAvt2(info)
	if not m_avt2 then
		if ISMIR2D then
			m_avt2 = F3DImageAnim3D:new()
			m_avt2:setImage2D(true)
		else
			m_avt2 = F3DAvatar:new()
		end
		ui.avtcont2:addChild(m_avt2)
	end
	if not info or info.call ~= 0 or m_select1 == info.index then
		主界面UI.showTipsMsg(1,txt("出战宠物不能作为副宠"))
		return
	end
	m_select2 = info.index
	if m_avt2 then
		m_avt2:reset()
		m_avt2:setAnimName("idle")
		if ISMIR2D then
			m_avt2:setScaleX(1)
			m_avt2:setScaleY(1)
			m_avt2:setAnimRotationZ(-30)
			m_avt2:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(info.bodyid))
			if info.effid ~= 0 then
				m_avt2:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(info.effid)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
		else
			m_avt2:setScale(1.5,1.5,1.5)
			m_avt2:setRotationZ(-30)
			m_avt2:setShowShadow(true)
			m_avt2:setLighting(true)
			m_avt2:setEntity(F3DAvatar.PART_BODY, 全局设置.getPetUrl(info.bodyid))
			m_avt2:setAnimSet(F3DUtils:trimPostfix(全局设置.getPetUrl(info.bodyid))..".txt")
			if info.effid ~= 0 then
				m_avt2:setEffectSystem(全局设置.getEffectUrl(info.effid), true)
			end
		end
	end
end

function onCBChange(e)
	local cb = e:getTarget()
	if not cb or not cb:isSelected() then
		return
	end
	local info = m_petinfotb[cb.id+5*(m_page-1)]
	if not info or info.level == 0 then
		m_avt:reset()
		ui.namebg:setTitleText("")
		ui.xuanzhong:setVisible(false)
		ui.pettype:setVisible(false)
		if g_mobileMode then
			ui.加点背景:setVisible(false)
		end
		for i,v in ipairs(ui.addpoints) do
			v:setVisible(false)
		end
		ui.剩余点数:setTitleText("")
		return
	end
	m_select = info.index
	ui.xuanzhong:setPositionX(cb:getPositionX())
	ui.xuanzhong:setPositionY(cb:getPositionY())
	ui.xuanzhong:setVisible(true)
	ui.namebg:setTitleText(txt(info.name))
	ui.namebg:setTextColor(全局设置.getColorRgbVal(info.grade))
	ui.生命值:setTitleText(info.生命值)
	ui.魔法值:setTitleText(info.魔法值)
	ui.防御:setTitleText(info.防御.."-"..info.防御上限)
	ui.魔御:setTitleText(info.魔御.."-"..info.魔御上限)
	ui.攻击:setTitleText(info.攻击.."-"..info.攻击上限)
	ui.魔法:setTitleText(info.魔法.."-"..info.魔法上限)
	ui.道术:setTitleText(info.道术.."-"..info.道术上限)
	ui.准确:setTitleText(info.准确)
	ui.移动速度:setTitleText(info.移动速度)
	ui.exppro:setPercent(info.exp/info.expmax)
	ui.starexppro:setPercent(info.starexp/info.starexpmax)
	ui.技能格子_1:setTextureFile(全局设置.getSkillIconUrl(info.技能图标))
	ui.pettype:setFrameRate(0, info.type == 1 and 2 or info.type == 2 and 1 or 0)
	ui.pettype:setVisible(true)
	if g_mobileMode then
		ui.加点背景:setVisible(info.剩余点数 > 0)
	end
	for i,v in ipairs(ui.addpoints) do
		if info.剩余点数 > 0 then
			v:setVisible(true)
		else
			v:setVisible(false)
		end
	end
	if info.剩余点数 > 0 then
		ui.剩余点数:setTitleText(txt("剩余点数: ")..info.剩余点数)
	else
		ui.剩余点数:setTitleText("")
	end
	ui.lvnum:setTitleText(info.level)
	ui.starnum:setTitleText(info.starlevel)
	ui.call:setTitleText(info.call ~= 0 and txt("收回") or txt("出战"))
	实用工具.setClipNumber(info.power,ui.zhanli)
	if m_avt then
		if m_oldbodyid ~= info.bodyid or m_oldeffid ~= info.effid then
			m_avt:reset()
			m_avt:setAnimName("idle")
			if ISMIR2D then
				m_avt:setScaleX(1)
				m_avt:setScaleY(1)
				m_avt:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(info.bodyid))
				if info.effid ~= 0 then
					m_avt:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(info.effid)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			else
				m_avt:setScale(2,2,2)
				m_avt:setRotationZ(30)
				m_avt:setShowShadow(true)
				m_avt:setLighting(true)
				m_avt:setEntity(F3DAvatar.PART_BODY, 全局设置.getPetUrl(info.bodyid))
				m_avt:setAnimSet(F3DUtils:trimPostfix(全局设置.getPetUrl(info.bodyid))..".txt")
				if info.effid ~= 0 then
					m_avt:setEffectSystem(全局设置.getEffectUrl(info.effid), true)
				end
			end
			m_oldbodyid = info.bodyid
			m_oldeffid = info.effid
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
	ui.avtcont = ui:findComponent("tab_1,conts,cont_1,avtcont")
	ui.namebg = ui:findComponent("tab_1,conts,cont_1,img_name_bg")
	ui.namebg:setTitleText("")
	ui.pettype = ui:findComponent("tab_1,conts,cont_1,pettype")
	ui.pettype:setVisible(false)
	ui.生命值 = ui:findComponent("tab_1,conts,cont_1,shuxing,生命值")
	ui.魔法值 = ui:findComponent("tab_1,conts,cont_1,shuxing,魔法值")
	ui.防御 = ui:findComponent("tab_1,conts,cont_1,shuxing,防御")
	ui.魔御 = ui:findComponent("tab_1,conts,cont_1,shuxing,魔御")
	ui.攻击 = ui:findComponent("tab_1,conts,cont_1,shuxing,攻击")
	ui.魔法 = ui:findComponent("tab_1,conts,cont_1,shuxing,魔法")
	ui.道术 = ui:findComponent("tab_1,conts,cont_1,shuxing,道术")
	ui.准确 = ui:findComponent("tab_1,conts,cont_1,shuxing,准确")
	ui.移动速度 = ui:findComponent("tab_1,conts,cont_1,shuxing,移动速度")
	ui.lvnum = ui:findComponent("tab_1,conts,cont_1,shuxing,img_lv_2")
	ui.starnum = ui:findComponent("tab_1,conts,cont_1,shuxing,image_star_1")
	ui.zhanli = ui:findComponent("tab_1,conts,cont_1,shuxing,zhan_shuzhi"):getBackground()
	ui.starexppro = tt(ui:findComponent("tab_1,conts,cont_1,shuxing,progress_4"),F3DProgress)
	ui.exppro = tt(ui:findComponent("tab_1,conts,cont_1,shuxing,progress_3"),F3DProgress)
	ui.技能框_1 = ui:findComponent("tab_1,conts,cont_1,shuxing,技能框_1")
	ui.技能格子_1 = F3DImage:new()
	ui.技能格子_1:setPositionX(math.floor(ui.技能框_1:getWidth()/2))
	ui.技能格子_1:setPositionY(math.floor(ui.技能框_1:getWidth()/2))
	ui.技能格子_1:setPivot(0.5, 0.5)
	ui.技能框_1:addChild(ui.技能格子_1)
	ui.addpoints = {}
	for i=1,7 do
		local addpoint = ui:findComponent("tab_1,conts,cont_1,shuxing,btn_add_"..i)
		addpoint.id = i
		addpoint:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
			local g = e:getCurrentTarget()
			if g == nil or g.id == nil then
			else
				local info = m_petinfo[m_select]
				if info then
					消息.CG_PET_ADDPOINT(info.index, g.id)
				end
			end
		end))
		addpoint:setVisible(false)
		ui.addpoints[#ui.addpoints+1] = addpoint
	end
	if g_mobileMode then
		ui.加点背景 = ui:findComponent("tab_1,conts,cont_1,shuxing,加点背景")
		ui.加点背景:setVisible(false)
	end
	ui.剩余点数 = ui:findComponent("tab_1,conts,cont_1,剩余点数")
	ui.剩余点数:setVisible(false)
	ui.avtcont1 = ui:findComponent("tab_1,conts,cont_2,avtcont_1")
	ui.avtcont2 = ui:findComponent("tab_1,conts,cont_2,avtcont_2")
	ui.xuanzhong = ui:findComponent("component_2,xuanzhong")
	ui.xuanzhong:setVisible(false)
	ui.select1 = ui:findComponent("tab_1,conts,cont_2,select1")
	ui.select1:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		local info = m_petinfo[m_select]
		if info then
			setSelectAvt1(info)
		end
	end))
	tdisui(ui.select1)
	ui.select2 = ui:findComponent("tab_1,conts,cont_2,select2")
	ui.select2:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		local info = m_petinfo[m_select]
		if info then
			setSelectAvt2(info)
		end
	end))
	tdisui(ui.select2)
	ui.rolerect = ui:findComponent("tab_1,conts,cont_1,rolerect")
	ui.rolerect:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(function (e)
		if m_avt then
			m_downposx = e:getStageX()
		end
	end))
	ui.rolerect:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(function (e)
		if m_avt then
			if ISMIR2D then
				m_avt:setAnimRotationZ(m_avt:getAnimRotationZ()+e:getStageX()-m_downposx)
			else
				m_avt:setRotationZ(m_avt:getRotationZ()+e:getStageX()-m_downposx)
			end
			m_downposx = e:getStageX()
		end
	end))
	ui.call = ui:findComponent("tab_1,conts,cont_1,call")
	ui.call:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		local info = m_petinfo[m_select]
		if info then
			if info.call ~= 0 then
				消息.CG_BACK_PET(info.index)
			else
				消息.CG_CALL_PET(info.index)
			end
		end
	end))
	ui.page = ui:findComponent("component_2,page")
	ui.page:setTitleText(m_page.." / "..m_pagemax)
	ui.page_next = ui:findComponent("component_2,page_next")
	ui.page_next:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		if m_page < m_pagemax then
			m_page = m_page + 1
			ui.page:setTitleText(m_page.." / "..m_pagemax)
			local selectindex = 1+5*(m_page-1)
			if m_petinfotb[selectindex] then
				m_select = m_petinfotb[selectindex].index
			end
			update()
		end
	end))
	ui.page_pre = ui:findComponent("component_2,page_pre")
	ui.page_pre:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		if m_page > 1 then
			m_page = m_page - 1
			ui.page:setTitleText(m_page.." / "..m_pagemax)
			local selectindex = 1+5*(m_page-1)
			if m_petinfotb[selectindex] then
				m_select = m_petinfotb[selectindex].index
			end
			update()
		end
	end))
	ui.petlist = {}
	for i=1,5 do
		local pet = {
			cb = tt(ui:findComponent("component_2,pet_"..i),F3DCheckBox),
			head = ui:findComponent("component_2,pet_"..i..",head"),
			name = ui:findComponent("component_2,pet_"..i..",name"),
			level = ui:findComponent("component_2,pet_"..i..",level"),
			star = ui:findComponent("component_2,pet_"..i..",star"),
			state = ui:findComponent("component_2,pet_"..i..",state"),
			--cname = ui:findComponent("component_2,pet_"..i..",cname"),
			img_lv = ui:findComponent("component_2,pet_"..i..",img_lv"),
			image_star = ui:findComponent("component_2,pet_"..i..",image_star"),
		}
		pet.cb.id = i
		pet.cb:addEventListener(F3DUIEvent.CHANGE, func_ue(onCBChange))
		pet.head:setTouchable(false)
		pet.state:setTouchable(false)
		pet.name:setTouchable(false)
		pet.level:setTouchable(false)
		pet.star:setTouchable(false)
		pet.img_lv:setTouchable(false)
		pet.image_star:setTouchable(false)
		ui.petlist[#ui.petlist+1] = pet
	end
	ui.tab = tt(ui:findComponent("tab_1"), F3DTab)
	ui.tab:addEventListener(F3DUIEvent.CHANGE, func_me(onTabChange))
	ui.train = ui:findComponent("tab_1,conts,cont_2,train")
	ui.train:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		local tabid = ui.tab:getSelectIndex()
		if tabid ~= 1 then
			ui.tab:setSelectIndex(1)
		else
			local info1 = m_petinfo[m_select1]
			local info2 = m_petinfo[m_select2]
			if info1 and info2 then
				消息.CG_TRAIN_PET(info1.index, info2.index)
			end
		end
	end))
	tdisui(ui.train)
	m_init = true
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
		if m_avt then
			if ISMIR2D then
				m_avt:setAnimRotationZ(0)
			else
				m_avt:setRotationZ(0)
			end
		end
		return
	end
	ui = F3DLayout:new()
	uiLayer:addChild(ui)
	ui:setLoadPriority(getUIPriority())
	ui:setMovable(true)
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."宠物UIm.layout" or UIPATH.."宠物UI.layout")
end
