module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 装备提示UI = require("主界面.装备提示UI")
local 物品内观表 = require("配置.物品内观表").Config

m_init = false
m_downposx = 0
m_avt = nil
m_rolejob = 0
m_bodyid = 0
m_weaponid = 0
m_bodyeff = 0
m_weaponeff = 0
m_itemdata = nil
tipsui = nil
tipsgrid = nil
角色逻辑 = nil
显示内观 = not IS3G and not ISWZ
EQUIPMAX = ISZY and 27 or ISLT and 25 or ISWZ and 23 or 17

function setEquipData(rolename,objid,level,job,sex,expmax,exp,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,hpmax,mpmax,speed,power,转生等级,防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,itemdata,显示时装,显示炫武,力量,智力,精神,体质,重击)
	角色逻辑 = {
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
		m_显示时装 = 显示时装,
		m_显示炫武 = 显示炫武,
		m_力量 = 力量,
		m_智力 = 智力,
		m_精神 = 精神,
		m_体质 = 体质,
		m_重击 = 重击,
	}
	m_itemdata = {}
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
	update()
	updateEquips()
end

function updateEquips()
	if not m_init or m_itemdata == nil then
		return
	end
	for i=1,EQUIPMAX do
		local v = m_itemdata[i]
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

function 更新内观()
	if not m_init or m_itemdata == nil then
		return
	end
	if 显示内观 then
		m_avt:setVisible(false)
		ui.男:setVisible(角色逻辑.m_rolesex == 1)
		ui.女:setVisible(角色逻辑.m_rolesex == 2)
		ui.内观位置:setVisible(true)
		if 角色逻辑.m_显示炫武 == 1 and m_itemdata[27] and m_itemdata[27].count > 0 and 物品内观表[m_itemdata[27].icon] then
			ui.武器位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[27].icon].图标ID))
			ui.武器位置:setPositionX(物品内观表[m_itemdata[27].icon].偏移X)
			ui.武器位置:setPositionY(物品内观表[m_itemdata[27].icon].偏移Y)
			ui.武器背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[27].icon].背景图片))
			ui.武器背景:setPositionX(物品内观表[m_itemdata[27].icon].背景偏移X)
			ui.武器背景:setPositionY(物品内观表[m_itemdata[27].icon].背景偏移Y)
			if 物品内观表[m_itemdata[27].icon].特效ID ~= 0 then
				ui.武器特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[m_itemdata[27].icon].特效ID))
			else
				ui.武器特效:reset()
			end
		elseif m_itemdata[1] and m_itemdata[1].count > 0 and 物品内观表[m_itemdata[1].icon] then
			ui.武器位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[1].icon].图标ID))
			ui.武器位置:setPositionX(物品内观表[m_itemdata[1].icon].偏移X)
			ui.武器位置:setPositionY(物品内观表[m_itemdata[1].icon].偏移Y)
			ui.武器背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[1].icon].背景图片))
			ui.武器背景:setPositionX(物品内观表[m_itemdata[1].icon].背景偏移X)
			ui.武器背景:setPositionY(物品内观表[m_itemdata[1].icon].背景偏移Y)
			if 物品内观表[m_itemdata[1].icon].特效ID ~= 0 then
				ui.武器特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[m_itemdata[1].icon].特效ID))
			else
				ui.武器特效:reset()
			end
		else
			ui.武器位置:setTextureFile("")
			ui.武器背景:setTextureFile("")
			ui.武器特效:reset()
		end
		if 角色逻辑.m_显示时装 == 1 and m_itemdata[23] and m_itemdata[23].count > 0 and 物品内观表[m_itemdata[23].icon] then
			ui.衣服位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[23].icon].图标ID))
			ui.衣服位置:setPositionX(物品内观表[m_itemdata[23].icon].偏移X)
			ui.衣服位置:setPositionY(物品内观表[m_itemdata[23].icon].偏移Y)
			ui.衣服背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[23].icon].背景图片))
			ui.衣服背景:setPositionX(物品内观表[m_itemdata[23].icon].背景偏移X)
			ui.衣服背景:setPositionY(物品内观表[m_itemdata[23].icon].背景偏移Y)
			if 物品内观表[m_itemdata[23].icon].特效ID ~= 0 then
				ui.衣服特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[m_itemdata[23].icon].特效ID))
			else
				ui.衣服特效:reset()
			end
		elseif m_itemdata[2] and m_itemdata[2].count > 0 and 物品内观表[m_itemdata[2].icon] then
			ui.衣服位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[2].icon].图标ID))
			ui.衣服位置:setPositionX(物品内观表[m_itemdata[2].icon].偏移X)
			ui.衣服位置:setPositionY(物品内观表[m_itemdata[2].icon].偏移Y)
			ui.衣服背景:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[2].icon].背景图片))
			ui.衣服背景:setPositionX(物品内观表[m_itemdata[2].icon].背景偏移X)
			ui.衣服背景:setPositionY(物品内观表[m_itemdata[2].icon].背景偏移Y)
			if 物品内观表[m_itemdata[2].icon].特效ID ~= 0 then
				ui.衣服特效:setAnimPack(全局设置.getAnimPackUrl(物品内观表[m_itemdata[2].icon].特效ID))
			else
				ui.衣服特效:reset()
			end
		else
			ui.衣服位置:setTextureFile("")
			ui.衣服背景:setTextureFile("")
			ui.衣服特效:reset()
		end
		if m_itemdata[11] and m_itemdata[11].count > 0 and 物品内观表[m_itemdata[11].icon] then
			ui.头盔位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[11].icon].图标ID))
			ui.头盔位置:setPositionX(物品内观表[m_itemdata[11].icon].偏移X)
			ui.头盔位置:setPositionY(物品内观表[m_itemdata[11].icon].偏移Y)
		elseif m_itemdata[3] and m_itemdata[3].count > 0 and 物品内观表[m_itemdata[3].icon] then
			ui.头盔位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[3].icon].图标ID))
			ui.头盔位置:setPositionX(物品内观表[m_itemdata[3].icon].偏移X)
			ui.头盔位置:setPositionY(物品内观表[m_itemdata[3].icon].偏移Y)
		else
			ui.头盔位置:setTextureFile("")
		end
		if m_itemdata[12] and m_itemdata[12].count > 0 and 物品内观表[m_itemdata[12].icon] then
			ui.面巾位置:setTextureFile(全局设置.getStateItemIconUrl(物品内观表[m_itemdata[12].icon].图标ID))
			ui.面巾位置:setPositionX(物品内观表[m_itemdata[12].icon].偏移X)
			ui.面巾位置:setPositionY(物品内观表[m_itemdata[12].icon].偏移Y)
		else
			ui.面巾位置:setTextureFile("")
		end
	end
end

function update()
	if not m_init or 角色逻辑 == nil or 角色逻辑.m_rolejob == 0 then
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
	if IS3G or m_rolejob ~= 角色逻辑.m_rolejob or m_bodyid ~= 角色逻辑.m_bodyid or m_weaponid ~= 角色逻辑.m_weaponid then
		m_avt:reset()
		if 显示内观 then
		elseif IS3G then
			m_avt:setVisible(true)
			ui.男:setVisible(false)
			ui.女:setVisible(false)
			ui.内观位置:setVisible(false)
			m_avt:setScaleX(1)
			m_avt:setScaleY(1)
			m_avt:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(角色逻辑.m_bodyid))
			m_avt:setAnimName("idle")
		elseif ISMIR2D then
			m_avt:setVisible(true)
			ui.男:setVisible(false)
			ui.女:setVisible(false)
			ui.内观位置:setVisible(false)
			m_avt:setScaleX(1)
			m_avt:setScaleY(1)
			m_avt:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(角色逻辑.m_bodyid))
			if not ISWZ then
				m_avt:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getMirHairUrl(角色逻辑.m_rolesex))
			end
			if 角色逻辑.m_weaponid ~= 0 then
				m_avt:setEntity(F3DImageAnim3D.PART_WEAPON, 全局设置.getAnimPackUrl(角色逻辑.m_weaponid))
			end
		else
			m_avt:setVisible(true)
			ui.男:setVisible(false)
			ui.女:setVisible(false)
			ui.内观位置:setVisible(false)
			m_avt:setScale(1.5,1.5,1.5)
			m_avt:setShowShadow(true)
			m_avt:setLighting(true)
			m_avt:setEntity(F3DAvatar.PART_BODY, 全局设置.getBodyUrl(角色逻辑.m_bodyid))
			m_avt:setEntity(F3DAvatar.PART_FACE, 全局设置.getFaceUrl(角色逻辑.m_rolejob))
			m_avt:setEntity(F3DAvatar.PART_HAIR, 全局设置.getHairUrl(角色逻辑.m_rolejob))
			m_avt:setAnimSet(全局设置.getAnimsetUrl(角色逻辑.m_rolejob))
			if 角色逻辑.m_weaponid ~= 0 then
				m_avt:setEntity(F3DAvatar.PART_WEAPON, 全局设置.getWeaponUrl(角色逻辑.m_weaponid))
			end
		end
		m_rolejob = 角色逻辑.m_rolejob
		m_bodyid = 角色逻辑.m_bodyid
		m_weaponid = 角色逻辑.m_weaponid
	end
	if m_bodyeff ~= 角色逻辑.m_bodyeff or m_weaponeff ~= 角色逻辑.m_weaponeff then
		if ISMIR2D then
			if m_bodyeff ~= 0 then
				m_avt:removeEntity(F3DImageAnim3D.PART_BODY_EFFECT)
			end
			if m_weaponeff ~= 0 then
				m_avt:removeEntity(F3DImageAnim3D.PART_WEAPON_EFFECT)
			end
			if 角色逻辑.m_bodyeff ~= 0 then
				m_avt:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(角色逻辑.m_bodyeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
			if 角色逻辑.m_weaponeff ~= 0 then
				m_avt:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl(角色逻辑.m_weaponeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
		else
			if m_bodyeff ~= 0 then
				m_avt:removeEffectSystem(全局设置.getEffectUrl(m_bodyeff))
			end
			if m_weaponeff ~= 0 then
				m_avt:removeEffectSystem(全局设置.getEffectUrl(m_weaponeff))
			end
			if 角色逻辑.m_bodyeff ~= 0 then
				m_avt:setEffectSystem(全局设置.getEffectUrl(角色逻辑.m_bodyeff), true)
			end
			if 角色逻辑.m_weaponeff ~= 0 then
				m_avt:setEffectSystem(全局设置.getEffectUrl(角色逻辑.m_weaponeff), true)
			end
		end
		m_bodyeff = 角色逻辑.m_bodyeff
		m_weaponeff = 角色逻辑.m_weaponeff
	end
	local name = string.gsub(txt(逻辑.m_rolename),"s0.","")
	ui.rolename:setTitleText(name)
	--ui.rolename:setTitleText(txt(角色逻辑.m_rolename))
	ui.rolejob:setTitleText(txt(全局设置.获取职业类型(角色逻辑.m_rolejob)))
	ui.level:setTitleText(角色逻辑.m_level..(角色逻辑.m_转生等级 > 0 and txt(" ("..全局设置.转生[角色逻辑.m_转生等级]..")") or ""))
	ui.生命值:setTitleText(角色逻辑.m_hpmax)
	ui.魔法值:setTitleText(角色逻辑.m_mpmax)
	ui.防御:setTitleText(角色逻辑.m_防御.."-"..角色逻辑.m_防御上限)
	ui.魔御:setTitleText(角色逻辑.m_魔御.."-"..角色逻辑.m_魔御上限)
	ui.攻击:setTitleText(角色逻辑.m_攻击.."-"..角色逻辑.m_攻击上限)
	ui.魔法:setTitleText(角色逻辑.m_魔法.."-"..角色逻辑.m_魔法上限)
	ui.道术:setTitleText(角色逻辑.m_道术.."-"..角色逻辑.m_道术上限)
	ui.幸运:setTitleText("+ "..角色逻辑.m_幸运)
	ui.准确:setTitleText("+ "..角色逻辑.m_准确)
	ui.敏捷:setTitleText("+ "..角色逻辑.m_敏捷)
	ui.魔法命中:setTitleText("+ "..角色逻辑.m_魔法命中.."%")
	ui.魔法躲避:setTitleText("+ "..角色逻辑.m_魔法躲避.."%")
	ui.生命恢复:setTitleText("+ "..角色逻辑.m_生命恢复)
	ui.魔法恢复:setTitleText("+ "..角色逻辑.m_魔法恢复)
	ui.中毒恢复:setTitleText("+ "..角色逻辑.m_中毒恢复.."%")
	ui.攻击速度:setTitleText("+ "..角色逻辑.m_攻击速度.."%")
	ui.移动速度:setTitleText(角色逻辑.m_speed)
	ui.经验值:setTitleText(math.floor(角色逻辑.m_exp*100/角色逻辑.m_expmax).."%")
	实用工具.setClipNumber(角色逻辑.m_power,ui.zhanli,true)
end

function onClose(e)
	if tipsui then
		装备提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui:setVisible(false)
	ui.close:releaseMouse()
	e:stopPropagation()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
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
	local g = g_mobileMode and e:getCurrentTarget() or e:getTarget()
	if g == nil or m_itemdata[g.id] == nil or m_itemdata[g.id].id == 0 then
	elseif F3DUIManager.sTouchComp ~= g then
	--elseif topui() ~= ui and topui() ~= 装备提示UI.ui then
	else
		装备提示UI.initUI()
		装备提示UI.setItemData(m_itemdata[g.id], true)
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

function onUIInit()
	ui.close = ui:findComponent("titlebar,close")
	ui.close:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.avtcont = ui:findComponent("avtcont")
	ui.rolerect = ui:findComponent("rolerect")
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
	ui.rolename = ui:findComponent("rolename")
	ui.rolejob = ui:findComponent("rolejob")
	ui.level = ui:findComponent("level")
	ui.生命值 = ui:findComponent("生命值")
	ui.魔法值 = ui:findComponent("魔法值")
	ui.防御 = ui:findComponent("防御")
	ui.魔御 = ui:findComponent("魔御")
	ui.攻击 = ui:findComponent("攻击")
	ui.魔法 = ui:findComponent("魔法")
	ui.道术 = ui:findComponent("道术")
	ui.幸运 = ui:findComponent("幸运")
	ui.准确 = ui:findComponent("准确")
	ui.敏捷 = ui:findComponent("敏捷")
	ui.魔法命中 = ui:findComponent("魔法命中")
	ui.魔法躲避 = ui:findComponent("魔法躲避")
	ui.生命恢复 = ui:findComponent("生命恢复")
	ui.魔法恢复 = ui:findComponent("魔法恢复")
	ui.中毒恢复 = ui:findComponent("中毒恢复")
	ui.攻击速度 = ui:findComponent("攻击速度")
	ui.移动速度 = ui:findComponent("移动速度")
	ui.经验值 = ui:findComponent("经验值")
	ui.zhanli = ui:findComponent("zhan_shuzhi"):getBackground()
	ui.equips = {}
	ui.grids = {}
	for i=1,EQUIPMAX do
		local grid = ui:findComponent("equippos_"..i)
		tdisui(grid)
		grid.id = i
		if g_mobileMode then
			grid:addEventListener(F3DMouseEvent.CLICK, func_me(onGridOver))
		else
			grid:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
			grid:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		end
		ui.grids[i] = grid
		local equip = F3DImage:new()
		--equip:setPositionX(1)
		--equip:setPositionY(1)
		--equip:setWidth(34)
		--equip:setHeight(34)
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
	for i=1,7 do
		ui:findComponent("btn_add_"..i):setVisible(false)
	end
	if g_mobileMode then
		ui:findComponent("加点背景"):setVisible(false)
	end
	ui:findComponent("剩余点数"):setVisible(false)
	ui.tab = tt(ui:findComponent("tab_1"), F3DTab)
	ui.tab:setVisible(false)
	ui.男 = ui:findComponent("男")
	ui.女 = ui:findComponent("女")
	ui.内观位置 = ui:findComponent("内观位置")
	ui.衣服位置 = F3DImage:new()
	ui.内观位置:addChild(ui.衣服位置)
	ui.衣服背景 = F3DImage:new()
	ui.衣服背景:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.衣服背景)
	ui.衣服特效 = F3DImageAnim:new()
	ui.衣服特效:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.衣服特效)
	ui.武器位置 = F3DImage:new()
	ui.内观位置:addChild(ui.武器位置)
	ui.武器背景 = F3DImage:new()
	ui.武器背景:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.武器背景)
	ui.武器特效 = F3DImageAnim:new()
	ui.武器特效:setBlendType(F3DRenderContext.BLEND_ADD)
	ui.内观位置:addChild(ui.武器特效)
	ui.头盔位置 = F3DImage:new()
	ui.内观位置:addChild(ui.头盔位置)
	ui.面巾位置 = F3DImage:new()
	ui.内观位置:addChild(ui.面巾位置)
	ui.显示时装 = tt(ui:findComponent("显示时装"),F3DCheckBox)
	ui.显示时装:setVisible(false)
	ui.显示炫武 = tt(ui:findComponent("显示炫武"),F3DCheckBox)
	ui.显示炫武:setVisible(false)
	m_init = true
	update()
	updateEquips()
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
