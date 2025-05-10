module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 角色逻辑 = require("主界面.角色逻辑")
local 装备提示UI = require("主界面.装备提示UI")
local 锻造UI = require("主界面.锻造UI")
local 物品内观表 = require("配置.物品内观表").Config
local 背包UI = require("主界面.背包UI")
local 主界面UI = require("主界面.主界面UI")

m_init = false
m_downposx = 0
m_avt = nil
m_rolejob = 0
m_bodyid = 0
m_weaponid = 0
m_bodyeff = 0
m_weaponeff = 0
m_itemdata = nil
m_tabid = 0
tipsui = nil
tipsgrid = nil
英雄角色逻辑 = {}
英雄物品数据 = {}
显示内观 = not IS3G and not ISWZ
m_剩余点数 = 0
m_英雄剩余点数 = 0
EQUIPMAX = ISZY and 27 or ISLT and 25 or ISWZ and 23 or 17

function setAddPointCnt(剩余点数, 英雄剩余点数)
	m_剩余点数 = 剩余点数
	m_英雄剩余点数 = 英雄剩余点数
	update()
end

function setTabID(tabid)
	if m_tabid == tabid then
		return
	end
	m_tabid = tabid
	if m_init then
		ui.tab:setSelectIndex(m_tabid)
	end
end

function setHeroEquipData(rolename,objid,level,job,sex,expmax,exp,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,hpmax,mpmax,speed,power,转生等级,防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,itemdata,力量,智力,精神,体质,重击)
	英雄角色逻辑 = {
		m_rolename = rolename,
		m_rolejob = job,
		m_rolesex = sex,
		m_expmax = expmax,
		m_exp = exp,
		m_bodyid = bodyid,
		m_weaponid = weaponid,
		m_wingid = wingid,
		m_horseid = horseid,
		m_bodyeff = bodyeff,
		m_weaponeff = weaponeff,
		m_wingeff = wingeff,
		m_horseeff = horseeff,
		m_level = level,
		m_hpmax = hpmax,
		m_mpmax = mpmax,
		m_speed = speed,
		m_power = power,
		m_转生等级 = 转生等级,
		m_防御 = 防御,
		m_防御上限 = 防御上限,
		m_魔御 = 魔御,
		m_魔御上限 = 魔御上限,
		m_攻击 = 攻击,
		m_攻击上限 = 攻击上限,
		m_魔法 = 魔法,
		m_魔法上限 = 魔法上限,
		m_道术 = 道术,
		m_道术上限 = 道术上限,
		m_幸运 = 幸运,
		m_准确 = 准确,
		m_敏捷 = 敏捷,
		m_魔法命中 = 魔法命中,
		m_魔法躲避 = 魔法躲避,
		m_生命恢复 = 生命恢复,
		m_魔法恢复 = 魔法恢复,
		m_中毒恢复 = 中毒恢复,
		m_攻击速度 = 攻击速度,
		m_移动速度 = 移动速度,
		m_力量 = 力量,
		m_智力 = 智力,
		m_精神 = 精神,
		m_体质 = 体质,
		m_重击 = 重击,
		
	}
	英雄物品数据 = {}
	for i,v in ipairs(itemdata) do
		英雄物品数据[v[1]] = {
			pos=v[1],
			id=v[2],
			name=v[3],
			desc=v[4],
			type=v[5],
			count=v[6],
			icon=v[7],
			cd=v[8]+rtime(),
			cdmax=v[9],
			bind=v[10],
			grade=v[11],
			job=v[12],
			level=v[13],
			strengthen=v[14],
			prop=v[15],
			addprop=v[16],
			attachprop=v[17],
			gemprop=v[18],
			ringsoul=v[19],
			power=v[20],
			equippos=v[21],
			color=v[22],
			suitprop=v[23],
			suitname=v[24],
		}
	end
	update()
	updateEquips()
end

function setEquipData(op, itemdata)
	if not m_itemdata then
		m_itemdata = {}
	end
	for i,v in ipairs(itemdata) do
		m_itemdata[v[1]] = {
			pos=v[1],
			id=v[2],
			name=v[3],
			desc=v[4],
			type=v[5],
			count=v[6],
			icon=v[7],
			cd=v[8]+rtime(),
			cdmax=v[9],
			bind=v[10],
			grade=v[11],
			job=v[12],
			level=v[13],
			strengthen=v[14],
			prop=v[15],
			addprop=v[16],
			attachprop=v[17],
			gemprop=v[18],
			ringsoul=v[19],
			power=v[20],
			equippos=v[21],
			color=v[22],
			suitprop=v[23],
			suitname=v[24],
		}
	end
	updateEquips()
	锻造UI.update()
end

function updateEquips()
	local itemdata = m_itemdata
	if not m_init or itemdata == nil then
		return
	end
	for i=1,EQUIPMAX do
		local v = itemdata[i]
		if v then
			ui.equips[i].id = v.pos
			ui.equips[i]:setTextureFile(全局设置.getItemIconUrl(v.icon))
			ui.equips[i].grade:setTextureFile(全局设置.getGradeUrl(v.grade))
			ui.equips[i].lock:setTextureFile(v.bind == 1 and UIPATH.."公用/grid/img_bind.png" or "")
			ui.equips[i].strengthen:setText(v.strengthen > 0 and "+"..v.strengthen or "")
		else
			ui.equips[i].id = 0
			ui.equips[i]:setTextureFile("")
			ui.equips[i].grade:setTextureFile("")
			ui.equips[i].lock:setTextureFile("")
			ui.equips[i].strengthen:setText("")
		end
	end
	更新内观()
end

function checkEquipPos(px, py)
	if not m_init or isHided() then return end
	local x = px - ui:getPositionX()
	local y = py - ui:getPositionY()
	for i=1,EQUIPMAX do
		local equipbg = ui:findComponent("equippos_"..i)
		if x >= equipbg:getPositionX() and x <= equipbg:getPositionX() + equipbg:getWidth() and
			y >= equipbg:getPositionY() and y <= equipbg:getPositionY() + equipbg:getHeight() then
			return i
		end
	end
end

function 更新内观()
	local itemdata = m_itemdata
	local 显示时装 = 角色逻辑.m_显示时装
	local 显示炫武 = 角色逻辑.m_显示炫武
	local 逻辑 = 角色逻辑
	if not m_init or itemdata == nil then
		return
	end
	
	if 显示内观 and m_tabid == 0 then
		m_avt:setVisible(false)
		ui.男:setVisible(逻辑.m_rolesex == 1)
		ui.女:setVisible(逻辑.m_rolesex == 2)
		
		ui.内观位置:setVisible(true)
		if 显示炫武 == 1 and itemdata[27] and itemdata[27].count > 0 and 物品内观表[itemdata[27].id] then
			ui.武器位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[27].id].图标ID))
			ui.武器位置:setPositionX(物品内观表[itemdata[27].id].偏移X)
			ui.武器位置:setPositionY(物品内观表[itemdata[27].id].偏移Y)
			ui.武器背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[27].id].背景图片))
			ui.武器背景:setPositionX(物品内观表[itemdata[27].id].背景偏移X)
			ui.武器背景:setPositionY(物品内观表[itemdata[27].id].背景偏移Y)
			if 物品内观表[itemdata[27].id].特效ID ~= 0 then
				ui.武器特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[itemdata[27].id].特效ID))
			else
				ui.武器特效:reset()
			end
		elseif itemdata[1] and itemdata[1].count > 0 and 物品内观表[itemdata[1].id] then
			ui.武器位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[1].id].图标ID))
			ui.武器位置:setPositionX(物品内观表[itemdata[1].id].偏移X)
			ui.武器位置:setPositionY(物品内观表[itemdata[1].id].偏移Y)
			ui.武器背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[1].id].背景图片))
			ui.武器背景:setPositionX(物品内观表[itemdata[1].id].背景偏移X)
			ui.武器背景:setPositionY(物品内观表[itemdata[1].id].背景偏移Y)
			if 物品内观表[itemdata[1].id].特效ID ~= 0 then
				ui.武器特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[itemdata[1].id].特效ID))
			else
				ui.武器特效:reset()
			end
		else
			ui.武器位置:setTextureFile("")
			ui.武器背景:setTextureFile("")
			ui.武器特效:reset()
		end
		
		if 显示时装 == 1 and itemdata[23] and itemdata[23].count > 0 and 物品内观表[itemdata[23].id] then
			ui.衣服位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[23].id].图标ID))
			ui.衣服位置:setPositionX(物品内观表[itemdata[23].id].偏移X)
			ui.衣服位置:setPositionY(物品内观表[itemdata[23].id].偏移Y)
			ui.衣服背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[23].id].背景图片))
			ui.衣服背景:setPositionX(物品内观表[itemdata[23].id].背景偏移X)
			ui.衣服背景:setPositionY(物品内观表[itemdata[23].id].背景偏移Y)
			if 物品内观表[itemdata[23].id].特效ID ~= 0 then
				ui.衣服特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[itemdata[23].id].特效ID))
			else
				ui.衣服特效:reset()
			end
			
			ui.男:setVisible(false)
			ui.女:setVisible(false)
		elseif itemdata[2] and itemdata[2].count > 0 and 物品内观表[itemdata[2].id] then
			ui.衣服位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[2].id].图标ID))
			ui.衣服位置:setPositionX(物品内观表[itemdata[2].id].偏移X)
			ui.衣服位置:setPositionY(物品内观表[itemdata[2].id].偏移Y)
			ui.衣服背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[2].id].背景图片))
			ui.衣服背景:setPositionX(物品内观表[itemdata[2].id].背景偏移X)
			ui.衣服背景:setPositionY(物品内观表[itemdata[2].id].背景偏移Y)
			if 物品内观表[itemdata[2].id].特效ID ~= 0 then
				ui.衣服特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[itemdata[2].id].特效ID))
			else
				ui.衣服特效:reset()
			end
			
			ui.男:setVisible(false)
			ui.女:setVisible(false)
		else
			ui.衣服位置:setTextureFile("")
			ui.衣服背景:setTextureFile("")
			ui.衣服特效:reset()
		end
		if itemdata[11] and itemdata[11].count > 0 and 物品内观表[itemdata[11].id] then
			ui.头盔位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[11].id].图标ID))
			ui.头盔位置:setPositionX(物品内观表[itemdata[11].id].偏移X)
			ui.头盔位置:setPositionY(物品内观表[itemdata[11].id].偏移Y)
		elseif itemdata[3] and itemdata[3].count > 0 and 物品内观表[itemdata[3].id] then
			ui.头盔位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[3].id].图标ID))
			ui.头盔位置:setPositionX(物品内观表[itemdata[3].id].偏移X)
			ui.头盔位置:setPositionY(物品内观表[itemdata[3].id].偏移Y)
		else
			ui.头盔位置:setTextureFile("")
		end
		if itemdata[12] and itemdata[12].count > 0 and 物品内观表[itemdata[12].id] then
			ui.面巾位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[itemdata[12].id].图标ID))
			ui.面巾位置:setPositionX(物品内观表[itemdata[12].id].偏移X)
			ui.面巾位置:setPositionY(物品内观表[itemdata[12].id].偏移Y)
		else
			ui.面巾位置:setTextureFile("")
		end
		
		ui.男发:setVisible(逻辑.m_rolesex == 1)
		ui.女发:setVisible(逻辑.m_rolesex == 2)
	end
end

function update()
	local 逻辑 = 角色逻辑
	
	if not m_init or 逻辑.m_rolejob == nil or 逻辑.m_rolejob == 0 then
		return
	end
	
	local 剩余点数 = m_剩余点数

	for i,v in ipairs(ui.addpoints) do
		if 剩余点数 > 0 then
			v:setVisible(true)
		else
			v:setVisible(false)
		end
	end
	
	ui.剩余点数:setTitleText(剩余点数)
	
	if not m_avt then
		if ISMIR2D then
			m_avt = F3DImageAnim3D:new()
			m_avt:setImage2D(true)
		else
			m_avt = F3DAvatar:new()
		end
		ui.avtcont:addChild(m_avt)
	end
	
	if m_tabid == 0 then
		if IS3G or m_rolejob ~= 逻辑.m_rolejob or m_bodyid ~= 逻辑.m_bodyid or m_weaponid ~= 逻辑.m_weaponid then
			m_avt:reset()
			if 显示内观 then
			
			elseif IS3G then
				m_avt:setVisible(true)
				ui.男:setVisible(false)
				ui.女:setVisible(false)
				ui.男发:setVisible(false)
				ui.女发:setVisible(false)
				ui.内观位置:setVisible(false)
				m_avt:setScaleX(1)
				m_avt:setScaleY(1)
				m_avt:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(1001+m_tabid))
				m_avt:setAnimName("idle")
			elseif ISMIR2D then
				m_avt:setVisible(true)
				ui.男:setVisible(false)
				ui.女:setVisible(false)
				ui.男发:setVisible(false)
				ui.女发:setVisible(false)
				ui.内观位置:setVisible(false)
				m_avt:setScaleX(1)
				m_avt:setScaleY(1)
				m_avt:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(逻辑.m_bodyid))
				if not ISWZ then
					m_avt:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getMirHairUrl(逻辑.m_rolesex))
				end
				if 逻辑.m_weaponid ~= 0 then
					m_avt:setEntity(F3DImageAnim3D.PART_WEAPON, 全局设置.getAnimPackUrl(逻辑.m_weaponid))
				end
			else
				m_avt:setVisible(true)
				ui.男:setVisible(false)
				ui.女:setVisible(false)
				ui.男发:setVisible(false)
				ui.女发:setVisible(false)
				ui.内观位置:setVisible(false)
				m_avt:setScale(1.5,1.5,1.5)
				m_avt:setShowShadow(true)
				m_avt:setLighting(true)
				m_avt:setEntity(F3DAvatar.PART_BODY, 全局设置.getBodyUrl(逻辑.m_bodyid))
				m_avt:setEntity(F3DAvatar.PART_FACE, 全局设置.getFaceUrl(逻辑.m_rolejob))
				m_avt:setEntity(F3DAvatar.PART_HAIR, 全局设置.getHairUrl(逻辑.m_rolejob))
				m_avt:setAnimSet(全局设置.getAnimsetUrl(逻辑.m_rolejob))
				if 逻辑.m_weaponid ~= 0 then
					m_avt:setEntity(F3DAvatar.PART_WEAPON, 全局设置.getWeaponUrl(逻辑.m_weaponid))
				end
			end
			m_rolejob = 逻辑.m_rolejob
			m_bodyid = 逻辑.m_bodyid
			m_weaponid = 逻辑.m_weaponid
		end
		if m_bodyeff ~= 逻辑.m_bodyeff or m_weaponeff ~= 逻辑.m_weaponeff then
			if ISMIR2D then
				if m_bodyeff ~= 0 then
					m_avt:removeEntity(F3DImageAnim3D.PART_BODY_EFFECT)
				end
				if m_weaponeff ~= 0 then
					m_avt:removeEntity(F3DImageAnim3D.PART_WEAPON_EFFECT)
				end
				if 逻辑.m_bodyeff ~= 0 then
					m_avt:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(逻辑.m_bodyeff)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
				if 逻辑.m_weaponeff ~= 0 then
					m_avt:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl(逻辑.m_weaponeff)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			else
				if m_bodyeff ~= 0 then
					m_avt:removeEffectSystem(全局设置.getEffectUrl(m_bodyeff))
				end
				if m_weaponeff ~= 0 then
					m_avt:removeEffectSystem(全局设置.getEffectUrl(m_weaponeff))
				end
				if 逻辑.m_bodyeff ~= 0 then
					m_avt:setEffectSystem(全局设置.getEffectUrl(逻辑.m_bodyeff), true)
				end
				if 逻辑.m_weaponeff ~= 0 then
					m_avt:setEffectSystem(全局设置.getEffectUrl(逻辑.m_weaponeff), true)
				end
			end
			m_bodyeff = 逻辑.m_bodyeff
			m_weaponeff = 逻辑.m_weaponeff
		end
	
		ui.显示时装:setSelected(角色逻辑.m_显示时装 == 1)
		ui.显示炫武:setSelected(角色逻辑.m_显示炫武 == 1)
	end	
	
	local name = string.gsub(txt(逻辑.m_rolename),"s0.","")
	ui.rolename:setTitleText(name)

	ui.防御:setTitleText(逻辑.m_防御上限)
	ui.魔御:setTitleText(逻辑.m_魔御上限)
	ui.攻击:setTitleText(逻辑.m_攻击.."-"..逻辑.m_攻击上限)
	ui.魔法:setTitleText(逻辑.m_魔法.."-"..逻辑.m_魔法上限)
	
	ui.职业:setTitleText(txt(全局设置.获取职业类型(逻辑.m_rolejob)))
	ui.等级:setTitleText(逻辑.m_level..(逻辑.m_转生等级 > 0 and txt(" ("..全局设置.转生[逻辑.m_转生等级]..")") or ""))
	ui.经验值:setTitleText(math.floor(逻辑.m_exp*100/逻辑.m_expmax).."%")
	ui.生命值:setTitleText(逻辑.m_hp.."-"..逻辑.m_hpmax)
	ui.战斗力:setTitleText(逻辑.m_power)
	--实用工具.setClipNumber(逻辑.m_power * 1,ui.战斗力,true)

	ui.力量:setTitleText(逻辑.m_力量)
	ui.智力:setTitleText(逻辑.m_智力)
	ui.敏捷:setTitleText(逻辑.m_敏捷)
	ui.精神:setTitleText(逻辑.m_精神)
	ui.体质:setTitleText(逻辑.m_体质)
	
	ui.防御_属性:setTitleText(逻辑.m_防御上限)
	ui.魔御_属性:setTitleText(逻辑.m_魔御上限)
	ui.攻击_属性:setTitleText(逻辑.m_攻击.."-"..逻辑.m_攻击上限)
	ui.魔法_属性:setTitleText(逻辑.m_魔法.."-"..逻辑.m_魔法上限)
	ui.重击:setTitleText(逻辑.m_重击)
	
end

function onClose(e)
	if tipsui then
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui:setVisible(false)
	ui.close:releaseMouse()
	setTabID(0)
	e:stopPropagation()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onGridDBClick(e)
	local itemdata = m_itemdata
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g == nil or itemdata[g.id] == nil or itemdata[g.id].id == 0 then
	else
		消息.CG_EQUIP_UNFIX(g.id, (not isHided() and m_tabid == 1) and 1 or 0)
		背包UI.hideAllTipsUI()
	end
end

function checkTipsPos()
	if not ui or not tipsgrid then
		return
	end
	if not tipsui or not tipsui:isVisible() or not tipsui:isInited() then
	else
		local x = ui:getPositionX()+tipsgrid:getPositionX()+tipsgrid:getWidth()
		local y = ui:getPositionY()+tipsgrid:getPositionY()
		if x + tipsui:getWidth() > stage:getWidth() then
			tipsui:setPositionX(x - tipsui:getWidth() - tipsgrid:getWidth())
		else
			tipsui:setPositionX(x)
		end
		if y + tipsui:getHeight() > stage:getHeight() then
			tipsui:setPositionY(stage:getHeight() - tipsui:getHeight())
		else
			tipsui:setPositionY(y)
		end
	end
end

function onGridOver(e)
	local itemdata = m_itemdata
	local g = g_mobileMode and e:getCurrentTarget() or e:getTarget()
	if g == nil or itemdata[g.id] == nil or itemdata[g.id].id == 0 then
	elseif F3DUIManager.sTouchComp ~= g then
	--elseif topui() ~= ui and topui() ~= 装备提示UI.ui then
	else
		装备提示UI.initUI()
		装备提示UI.setItemData(itemdata[g.id], true)
		tipsui = 装备提示UI.ui
		tipsgrid = g
		if not tipsui:isInited() then
			tipsui:addEventListener(F3DObjEvent.OBJ_INITED, func_oe(checkTipsPos))
		else
			checkTipsPos()
		end
	end
end

function onGridOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid and tipsui then
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
end

function onTabChange(e)
	m_tabid = ui.tab:getSelectIndex()
	update()
	updateEquips()
end

function onUIInit()
	ui.close = ui:findComponent("关闭")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.rolename = ui:findComponent("rolename")
	ui.tab = tt(ui:findComponent("人物"), F3DTab)
	
	--=========================================================================装备
	ui.avtcont = ui:findComponent("人物,conts,装备,avtcont")
	ui.rolerect = ui:findComponent("人物,conts,装备,rolerect")
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
	
	ui.tab:setSelectIndex(m_tabid)
	ui.tab:addEventListener(F3DUIEvent.CHANGE, func_ue(onTabChange))
	ui.男 = ui:findComponent("人物,conts,装备,男")
	ui.女 = ui:findComponent("人物,conts,装备,女")
	ui.男发 = ui:findComponent("人物,conts,装备,男发")
	ui.女发 = ui:findComponent("人物,conts,装备,女发")
	ui.内观位置 = ui:findComponent("人物,conts,装备,内观位置")
	ui.衣服位置 = F3DImage:new()
	ui.内观位置:addChild(ui.衣服位置)
	ui.衣服背景 = F3DImage:new()
	--ui.衣服背景:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.衣服背景)
	ui.衣服特效 = F3DImageAnim:new()
	--ui.衣服特效:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.衣服特效)
	ui.武器位置 = F3DImage:new()
	ui.内观位置:addChild(ui.武器位置)
	ui.武器背景 = F3DImage:new()
	--ui.武器背景:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.武器背景)
	ui.武器特效 = F3DImageAnim:new()
	--ui.武器特效:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.武器特效)
	ui.头盔位置 = F3DImage:new()
	ui.内观位置:addChild(ui.头盔位置)
	ui.面巾位置 = F3DImage:new()
	ui.内观位置:addChild(ui.面巾位置)	
	
	ui.equips = {}
	ui.grids = {}
	for i=1,EQUIPMAX do
		local 分类 = ""
		
		if(i == 19 or i == 1 or i == 22 or i == 5 or i == 14 or i == 8 or i == 3 or i == 4 or i == 2 or i == 7 or i == 6 or i == 15) then
			分类 = "装备"
		else
			分类 = "外观"
		end
	
		local grid = ui:findComponent("人物,conts,"..分类..",equippos_"..i)
		tdisui(grid)
		grid.id = i
		grid:addEventListener(F3DMouseEvent.DOUBLE_CLICK, func_me(onGridDBClick))
		grid:addEventListener(F3DMouseEvent.RIGHT_CLICK, func_me(onGridDBClick))
		if g_mobileMode then
			grid:addEventListener(F3DMouseEvent.CLICK, func_me(onGridOver))
		else
			grid:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
			grid:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		end
		ui.grids[i] = grid
		local equip = F3DImage:new()
		
		equip:setPositionX(math.floor(grid:getWidth()/2))
		equip:setPositionY(math.floor(grid:getHeight()/2))
		equip:setPivot(0.5,0.5)
		ui.equips[i] = equip
		grid:addChild(equip)
		equip.grade = F3DImage:new()
		equip.grade:setPositionX(1)
		equip.grade:setPositionY(1)
		equip.grade:setWidth(grid:getWidth()-2)--36)
		equip.grade:setHeight(grid:getHeight()-2)--36)
		grid:addChild(equip.grade)
		equip.lock = F3DImage:new()
		equip.lock:setPositionX(g_mobileMode and 8 or 4)
		equip.lock:setPositionY(g_mobileMode and grid:getHeight()-8 or grid:getHeight()-4)
		equip.lock:setPivot(0,1)
		grid:addChild(equip.lock)
		equip.strengthen = F3DTextField:new()
		if g_mobileMode then
			equip.strengthen:setTextFont("宋体",16,false,false,false)
		end
		equip.strengthen:setPositionX(g_mobileMode and grid:getWidth()-8 or grid:getWidth()-4)--35)
		equip.strengthen:setPositionY(g_mobileMode and 8 or 4)--3)
		equip.strengthen:setPivot(1,0)
		grid:addChild(equip.strengthen)
	end
	
	ui.防御 = ui:findComponent("人物,conts,装备,防御")
	ui.魔御 = ui:findComponent("人物,conts,装备,魔御")
	ui.攻击 = ui:findComponent("人物,conts,装备,攻击")
	ui.魔法 = ui:findComponent("人物,conts,装备,魔法")	
	
	--=========================================================================属性
	ui.职业 = ui:findComponent("人物,conts,属性,职业")
	ui.等级 = ui:findComponent("人物,conts,属性,等级")
	ui.经验值 = ui:findComponent("人物,conts,属性,经验值")
	ui.生命值 = ui:findComponent("人物,conts,属性,生命值")
	ui.战斗力 = ui:findComponent("人物,conts,属性,战斗力")
	
	
	ui.剩余点数 = ui:findComponent("人物,conts,属性,剩余点数")	
	ui.addpoints = {}
	for i=1,5 do
		local addpoint = ui:findComponent("人物,conts,属性,btn_add_"..i)
		addpoint.id = i
		addpoint:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
			local g = e:getCurrentTarget()
			if g == nil or g.id == nil then
				
			else
				消息.CG_PROP_ADDPOINT(0, g.id)
			end
		end))
		
		addpoint:addEventListener(F3DUIEvent.MOUSE_OVER,func_ue(onMouseOver))
		addpoint:addEventListener(F3DUIEvent.MOUSE_OUT,func_ue(onMouseOut))
		ui.addpoints[#ui.addpoints+1] = addpoint
	end
	
	ui.力量 = ui:findComponent("人物,conts,属性,力量")
	ui.智力 = ui:findComponent("人物,conts,属性,智力")
	ui.敏捷 = ui:findComponent("人物,conts,属性,敏捷")
	ui.精神 = ui:findComponent("人物,conts,属性,精神")
	ui.体质 = ui:findComponent("人物,conts,属性,体质")
	
	ui.防御_属性 = ui:findComponent("人物,conts,属性,防御")
	ui.魔御_属性 = ui:findComponent("人物,conts,属性,魔御")
	ui.攻击_属性 = ui:findComponent("人物,conts,属性,攻击")
	ui.魔法_属性 = ui:findComponent("人物,conts,属性,魔法")	
	ui.重击 = ui:findComponent("人物,conts,属性,重击")
	--=========================================================================外观
	ui.显示时装 = tt(ui:findComponent("人物,conts,外观,显示时装"),F3DCheckBox)
	ui.显示时装:addEventListener(F3DUIEvent.CHANGE, func_ue(function (e)
		if m_tabid == 1 then
			角色逻辑.m_英雄显示时装 = ui.显示时装:isSelected() and 1 or 0
		else
			角色逻辑.m_显示时装 = ui.显示时装:isSelected() and 1 or 0
		end
		消息.CG_SHOW_FASHION(角色逻辑.m_显示时装, 角色逻辑.m_英雄显示时装, 角色逻辑.m_显示炫武, 角色逻辑.m_英雄显示炫武)
		更新内观()
	end))
	ui.显示炫武 = tt(ui:findComponent("人物,conts,外观,显示炫武"),F3DCheckBox)
	ui.显示炫武:addEventListener(F3DUIEvent.CHANGE, func_ue(function (e)
		if m_tabid == 1 then
			角色逻辑.m_英雄显示炫武 = ui.显示炫武:isSelected() and 1 or 0
		else
			角色逻辑.m_显示炫武 = ui.显示炫武:isSelected() and 1 or 0
		end
		消息.CG_SHOW_FASHION(角色逻辑.m_显示时装, 角色逻辑.m_英雄显示时装, 角色逻辑.m_显示炫武, 角色逻辑.m_英雄显示炫武)
		更新内观()
	end))	
	
	
	m_init = true
	update()
	updateEquips()
end

function onMouseOver(e)
	
	local g = e:getTarget()
	if g == nil then
		
	else
		if(g.id == 1) then
			g:setTitleText(txt("增加角色的物攻、物防、生命值。"))
		elseif(g.id == 2) then
			g:setTitleText(txt("增加角色的魔攻、魔防、魔法值。"))
		elseif(g.id == 3) then
			g:setTitleText(txt("增加角色的物防和魔防。"))
		elseif(g.id == 4) then
			g:setTitleText(txt("增加角色的魔法值和魔防、攻击速度（精神点数多于600点的部分对攻击速度没有加成）。"))
		elseif(g.id == 5) then
			g:setTitleText(txt("增加角色的生命值、物防、魔防、重击。"))
		end
		tipsgrid = g
	end
end

function onMouseOut(e)
	local g = e:getTarget()
	if g ~= nil and g == tipsgrid then
		g:setTitleText("")
		tipsgrid = nil
	end
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if tipsui then
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
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
	ui:setLayout(g_mobileMode and UIPATH.."角色UIm.layout" or UIPATH.."角色UI.layout")
end
