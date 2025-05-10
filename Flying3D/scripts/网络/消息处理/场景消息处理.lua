module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 登录UI = require("登录.登录UI")
local 创建角色UI = require("登录.创建角色UI")
local 主逻辑 = require("主界面.主逻辑")
local 小地图UI = require("主界面.小地图UI")
local Npc对话UI = require("主界面.Npc对话UI")
local 主界面UI = require("主界面.主界面UI")
local 任务追踪UI = require("主界面.任务追踪UI")
local 角色逻辑 = require("主界面.角色逻辑")
local 宠物信息UI = require("宠物.宠物信息UI")
local 头像信息UI = require("主界面.头像信息UI")
local 英雄信息UI = require("主界面.英雄信息UI")
local 获得提示UI = require("主界面.获得提示UI")
local Boss信息UI = require("主界面.Boss信息UI")
local 队伍信息UI = require("主界面.队伍信息UI")
local 结算UI1 = require("结算.结算UI1")
local 结算UI2 = require("结算.结算UI2")
local 目标信息UI = require("主界面.目标信息UI")
local 个人副本UI = require("主界面.个人副本UI")
local Boss副本UI = require("主界面.Boss副本UI")
local 网络连接 = require("公用.网络连接")
local 角色UI = require("主界面.角色UI")
local 角色查看UI = require("主界面.角色查看UI")
local 技能逻辑 = require("技能.技能逻辑")
local 实用工具 = require("公用.实用工具")
local 辅助UI = require("主界面.辅助UI")
local 福利UI = require("主界面.福利UI")
local 采集进度UI = require("主界面.采集进度UI")
local 队伍UI = require("主界面.队伍UI")
local 锻造UI = require("主界面.锻造UI")

function GC_ASK_LOGIN(result,svrname,msvrip,msvrport)
	登录UI.removeUI()
	if result == 2 then
		创建角色UI.initUI()
	end
end

function GC_MOVE(objid,objtype,posx,posy,movex,movey)
	local role = g_roles[objid]
	if not role then return end
	if role and role ~= g_role then
		--role:setPositionX(posx)
		--role:setPositionY(g_is3D and posy or to3d(posy))
		role:startMove(movex, g_is3D and movey or to3d(movey),
			(not IS3G or (not role:isHitFly() and not role:getAnimName():find("attack_"))) and (role.status==1 and "walk" or "run") or "")
	end
	if role == g_role then
		role.querymove = false
	end
end

function GC_ADD_PLAYER(rolename,guildname,color,title,level,job,sex,status,buffinfo,mergehp,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,ownerid,teamid,斗笠外观,objid,posx,posy,movex,movey,targetdirection,maxhp,maxmp,hp,mp,speed)
	local role = g_roles[objid]
	if not role then
		role = addMainRole(bodyid,weaponid,wingid,horseid,job,sex,objid,全局设置.OBJTYPE_PLAYER,posx,posy,speed,斗笠外观)
		role:setAnimName("idle")
		role.status = status
		--role:setVisible(status == 0)
		if ISMIR2D then
			if bodyeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(bodyeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
			if weaponeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl(weaponeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
			if wingeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_WING_EFFECT, 全局设置.getAnimPackUrl(wingeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
			if horseeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_HORSE_EFFECT, 全局设置.getAnimPackUrl(horseeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
		else
			if bodyeff ~= 0 then
				role:getBody():setEffectSystem(全局设置.getEffectUrl(bodyeff), true)
			end
			if weaponeff ~= 0 then
				role:getBody():setEffectSystem(全局设置.getEffectUrl(weaponeff), true)
			end
			if wingeff ~= 0 and role:getWing() then
				role:getWing():setEffectSystem(全局设置.getEffectUrl(wingeff), true)
			end
			if horseeff ~= 0 and role:getHorse() then
				role:getHorse():setEffectSystem(全局设置.getEffectUrl(horseeff), true)
			end
		end
	end
	for i,v in ipairs(buffinfo) do
		技能逻辑.setSkillBuff(objid,v[1],v[3],v[2])
	end
	role.level = level
	role.job = job
	role.sex = sex
	role.hp = hp
	role.maxhp = maxhp
	role.name = rolename
	role.ownerid = ownerid
	role.teamid = teamid
	if mergehp and #mergehp > 0 then
		role.mergehp = {}
		for i,v in ipairs(mergehp) do
			role.mergehp[i] = {hpmax=v[1],hp=v[2],color=全局设置.getColorRgbVal(v[3])}
		end
	else
		role.mergehp = nil
	end
	role.showname = true--rolename:find("的英雄") == nil
	role.guildname = guildname
	role.color = color
	if 角色逻辑.m_alliance[guildname] then
		role.namecolor = 全局设置.NAMECOLOR[6]
	elseif 角色逻辑.m_challenge[guildname] then
		role.namecolor = 全局设置.NAMECOLOR[7]
	else
		role.namecolor = 全局设置.NAMECOLOR[color]
	end
	主逻辑.setHPBar(role, hp, maxhp, 全局设置.getHPColor(role.objtype), rolename, role.mergehp, role.showname, role.guildname, role.namecolor)
	
	if role.hpbar and #title > 0 then
		role.hpbar.titles = role.hpbar.titles or {}
		for i=1,#title,4 do
			local img = role.hpbar.titles[math.ceil(i/4)] or F3DImage:new()
			img:setTextureFile(全局设置.getIconIconUrl(title[i+1]))
			img:setPositionX(title[i+2]-15)
			img:setPositionY(title[i+3]-30)
			role.hpbar:addChild(img)
			role.hpbar.titles[math.ceil(i/4)] = img
		end
	end
	if role.objid == 英雄信息UI.m_objid then
		英雄信息UI.setHPBar(hp,maxhp)
	end
	if hp <= 0 then
		role:setAnimName("dead","",true,true,true)
	elseif movex == -1 or movey == -1 then
	else
		role:startMove(movex, g_is3D and movey or to3d(movey), role.status==1 and "walk" or "run")
	end
end

function GC_CHANGE_INFO(objid,maxhp,hp,mergehp)
	local role = g_roles[objid]
	if role then
		local tmaxhp = maxhp
		local thp = hp
		if mergehp and #mergehp > 0 then
			role.mergehp = {}
			for i,v in ipairs(mergehp) do
				tmaxhp = tmaxhp + v[1]
				thp = thp + v[2]
				role.mergehp[i] = {hpmax=v[1],hp=v[2],color=全局设置.getColorRgbVal(v[3])}
			end
		else
			role.mergehp = nil
		end
		role.hp = hp
		role.maxhp = maxhp
		if not role.iscaller then
			主逻辑.setHPBar(role, role.hp, role.maxhp, 全局设置.getHPColor(role.objtype,role.ownerid~=-1,role.isboss), role.name, role.mergehp, role.showname, role.guildname, role.namecolor)
		end
		if role.objtype == 全局设置.OBJTYPE_PET then
			宠物信息UI.setHPBar(objid, thp, tmaxhp, 0, 0)
		end
		if role == g_role then
			头像信息UI.setHPBar(thp,tmaxhp)
		end
		if role.objid == 英雄信息UI.m_objid then
			英雄信息UI.setHPBar(thp,tmaxhp)
		end
		if role.objtype == 全局设置.OBJTYPE_MONSTER and role.isboss then
			Boss信息UI.setBossInfo(objid,role.name,role.level,"",role.bodyid,thp,tmaxhp)
		end
		if 目标信息UI.m_goalinfo and 目标信息UI.m_goalinfo.objid == role.objid then
			目标信息UI.setGoalInfo(role.objid,0,role.name,role.level,role.hp,role.maxhp)
		end
	end
end

function GC_STOP_MOVE(objid,x,y)
	local role = g_roles[objid]
	if not role then return end
	if role == g_role and (role:getAnimName() == "run" or role:getAnimName() == "walk") then
		resetPickItemTime()
	end
	if role then
		stopRoleMove(role)
	end
	if IS3G then
		role:startHitBack(x, g_is3D and y or to3d(y), 0.1)
	else --实用工具.GetDistanceSq(role:getPositionX(), role:getPositionY(), x, g_is3D and y or to3d(y)) > 10000 then 
		role:setPositionX(x)
		role:setPositionY(g_is3D and y or to3d(y))
	end
	if role == g_role then
		role.querymove = false
		resetMovePoint()
	end
end

function GC_ENTER_SCENE(result,objid,mapid,maptype,scenex,sceney,mode,mapwidth,mapheight,isstatshurt)
	local role = g_roles[objid]
	if role and role == g_role then
		个人副本UI.hideUI()
		Boss副本UI.hideUI()
		stopRoleMove(role, true)
		enterScene(mapid,scenex,sceney)
	end
end

function GC_HUMAN_INFO(rolename,guildname,challenge,alliance,color,title,objid,level,job,sex,status,pkmode,mapid,scenex,sceney,speed,maxhp,maxmp,hp,mp,tp,buffinfo,mergehp,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,teamid,斗笠外观,总充值,每日充值,特戒抽取次数,刷新BOSS次数,开区活动倒计时,vip等级,HP保护,MP保护,英雄HP保护,英雄MP保护,自动分解白,自动分解绿,自动分解蓝,自动分解紫,自动分解橙,自动分解等级,使用生命药,使用魔法药,英雄使用生命药,英雄使用魔法药,使用物品HP,使用物品ID,自动使用合击,自动分解宠物白,自动分解宠物绿,自动分解宠物蓝,自动分解宠物紫,自动分解宠物橙,自动孵化宠物蛋,物品自动拾取,显示时装,英雄显示时装,显示炫武,英雄显示炫武,副本刷怪数量,队伍拒绝邀请,队伍拒绝申请)
	创建角色UI.removeUI()
	F3DSoundManager:instance():playSound("/res/sound/106.mp3")
	startGame(job,sex,objid,mapid,scenex,sceney,speed,bodyid,weaponid,wingid,horseid,斗笠外观)
	g_role:setAnimName("idle")
	g_role.status = status
	--g_role:setVisible(status == 0)
	if ISMIR2D then
		if bodyeff ~= 0 then
			g_role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(bodyeff)):setBlendType(F3DRenderContext.BLEND_ADD)
		end
		if weaponeff ~= 0 then
			g_role:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl(weaponeff)):setBlendType(F3DRenderContext.BLEND_ADD)
		end
		if wingeff ~= 0 then
			g_role:setEntity(F3DImageAnim3D.PART_WING_EFFECT, 全局设置.getAnimPackUrl(wingeff)):setBlendType(F3DRenderContext.BLEND_ADD)
		end
		if horseeff ~= 0 then
			g_role:setEntity(F3DImageAnim3D.PART_HORSE_EFFECT, 全局设置.getAnimPackUrl(horseeff)):setBlendType(F3DRenderContext.BLEND_ADD)
		end
	else
		if bodyeff ~= 0 then
			g_role:getBody():setEffectSystem(全局设置.getEffectUrl(bodyeff), true)
		end
		if weaponeff ~= 0 then
			g_role:getBody():setEffectSystem(全局设置.getEffectUrl(weaponeff), true)
		end
		if wingeff ~= 0 and g_role:getWing() then
			g_role:getWing():setEffectSystem(全局设置.getEffectUrl(wingeff), true)
		end
		if horseeff ~= 0 and g_role:getHorse() then
			g_role:getHorse():setEffectSystem(全局设置.getEffectUrl(horseeff), true)
		end
	end
	for i,v in ipairs(buffinfo) do
		技能逻辑.setSkillBuff(objid,v[1],v[3],v[2])
	end
	g_role.level = level
	g_role.job = job
	g_role.sex = sex
	g_role.hp = hp
	g_role.maxhp = maxhp
	g_role.name = rolename
	g_role.teamid = teamid
	角色逻辑.m_rolename = rolename
	角色逻辑.m_rolejob = job
	角色逻辑.m_rolesex = sex
	角色逻辑.m_teamid = teamid
	角色逻辑.m_显示时装 = 显示时装
	角色逻辑.m_英雄显示时装 = 英雄显示时装
	角色逻辑.m_显示炫武 = 显示炫武
	角色逻辑.m_英雄显示炫武 = 英雄显示炫武
	角色逻辑.setLevel(level)
	角色逻辑.setFacade(bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff)
	角色逻辑.setOtherAttr(vip等级, 总充值, 每日充值, 特戒抽取次数, 刷新BOSS次数, 开区活动倒计时)
	角色逻辑.m_mpmax = mpmax
	角色逻辑.m_mp = mp
	if mergehp and #mergehp > 0 then
		g_role.mergehp = {}
		for i,v in ipairs(mergehp) do
			g_role.mergehp[i] = {hpmax=v[1],hp=v[2],color=全局设置.getColorRgbVal(v[3])}
		end
	else
		g_role.mergehp = nil
	end
	g_role.showname = true
	g_role.guildname = guildname
	g_role.color = color
	角色逻辑.m_guildname = guildname
	角色逻辑.setAttackGuild(challenge,alliance)
	if 角色逻辑.m_alliance[guildname] then
		g_role.namecolor = 全局设置.NAMECOLOR[6]
	else
		g_role.namecolor = 全局设置.NAMECOLOR[color]
	end
	主逻辑.setHPBar(g_role, hp, maxhp, 全局设置.getHPColor(g_role.objtype), rolename, g_role.mergehp, g_role.showname, g_role.guildname, g_role.namecolor)
	
	if g_role.hpbar and #title > 0 then
		g_role.hpbar.titles = g_role.hpbar.titles or {}
		
		for i=1,#title,4 do
			local img = g_role.hpbar.titles[math.ceil(i/4)] or F3DImage:new()
			img:setTextureFile(全局设置.getIconIconUrl(title[i+1]))
			img:setPositionX(title[i+2]-15)
			img:setPositionY(title[i+3]-30)
			g_role.hpbar:addChild(img)
			g_role.hpbar.titles[math.ceil(i/4)] = img
		end
	end
	头像信息UI.setHPBar(hp,maxhp)
	头像信息UI.setMPBar(mp,maxmp)
	个人副本UI.setKeduBar(副本刷怪数量)
	个人副本UI.setTP(tp)
	Boss副本UI.setTP(tp)
	if hp <= 0 then
		g_role:setAnimName("dead","",true,true,true)
		if __PLATFORM__ ~= "IOS" then
			grabimage:setShaderType(F3DImage.SHADER_GRAY)
		end
	else
		grabimage:setShaderType(F3DImage.SHADER_WARP)
	end
	头像信息UI.setAutoTakeDrug(HP保护/100, MP保护/100)
	英雄信息UI.setAutoTakeDrug(英雄HP保护/100, 英雄MP保护/100)
	辅助UI.setSetup(自动分解白,自动分解绿,自动分解蓝,自动分解紫,自动分解橙,自动分解等级,使用生命药,使用魔法药,英雄使用生命药,英雄使用魔法药,使用物品HP,使用物品ID,自动使用合击,自动分解宠物白,自动分解宠物绿,自动分解宠物蓝,自动分解宠物紫,自动分解宠物橙,自动孵化宠物蛋,物品自动拾取)
	队伍UI.设置队伍拒绝(队伍拒绝邀请, 队伍拒绝申请)
	头像信息UI.m_pkmode = pkmode
end

function GC_TIPS_MSG(postype,msg)
	if postype == 2 then
		获得提示UI.addTips(txt(msg))
	else
		if msg == "距离太远" and g_target then
			startAStar(g_target:getPositionX(), g_is3D and g_target:getPositionY() or to2d(g_target:getPositionY()))
		else
			主界面UI.showTipsMsg(postype, txt(msg))
		end
	end
end

function GC_DEL_ROLE(objid,objtype)
	local role = g_roles[objid]
	if role then
		if g_target == role then
			setMainRoleTarget(nil)
		end
		if g_attackObj == role then
			resetAttackObj(nil)
		end
		if g_hoverObj == role then
			setHoverObj(nil)
		end
		if role.objtype == 全局设置.OBJTYPE_PET then
			宠物信息UI.m_hpbar[objid] = nil
		end
		if role.objtype == 全局设置.OBJTYPE_MONSTER and role.isboss then
			Boss信息UI.delBossInfo(objid)
		end
		主逻辑.delHPBar(role)
		if g_UsePool then
			pushRole(role)
		else
			role:removeFromParent(true)
		end
		g_roles[objid] = nil
		return
	end
	local item = g_items[objid]
	if item then
		if g_UsePool then
			pushItem(item)
		else
			item.tfcont:removeFromParent(true)
			item:removeFromParent(true)
		end
		g_items[objid] = nil
		return
	end
end

function GC_DISCONNECT_NOTIFY(reason)
	网络连接.closeConnect()
	if reason == 1 then
		doReconnect(txt("被顶号下线，顶号下线不会自动重连！"), false)
	elseif reason == 10 then
		doReconnect(txt("服务器关闭连接，请稍后刷新重试！"), false)
	else
		doReconnect(txt("服务器断开连接,原因:"..reason), true)
	end
end

function GC_ADD_ITEM(name,icon,itemid,cnt,ownerid,grade,teamid,color,objid,posx,posy)
	local item = g_items[objid]
	if not item then--and (ISLT or ownerid == -1 or ownerid == g_role.objid) then
		item = addItem(全局设置.getDropItemIconUrl(icon),objid,全局设置.OBJTYPE_ITEM,posx,posy)
		item.itemid = itemid
		item.ownerid = ownerid
		item.teamid = teamid
		item:setPivot(0.5,0.5)
		if not item.tf then
			item.tf = F3DTextField:new()
			item.tfcont:addChild(item.tf)
		end
		if g_mobileMode then
			item.tf:setTextFont("宋体",16,false,false,false)
		end
		if name == "金币" or name == "元宝" then
			item.tf:setTextColor(0xEFEF00, 0)
			item.tf:setText(cnt..txt(name))
		else
			item.tf:setTextColor(color > 0 and color or 全局设置.getColorRgbVal(grade) or 0xffffff, 0)
			item.tf:setText(txt(name..(cnt > 1 and "("..cnt..")" or "")))
		end
		item.tf:setPivot(0.5,0.5)
		item.tf:setPositionX(0)
		item.tf:setPositionY(-20)
	end
end

function GC_PICK_ITEM(objid)
end

function GC_ADD_NPC(name,level,confid,bodyid,effid,objid,posx,posy)
	local role = g_roles[objid]
	if not role then
		role = addRole(bodyid,objid,全局设置.OBJTYPE_NPC,posx,posy,0)
		role:setAnimName("idle")
		role.bodyid = bodyid
		if ISMIR2D then
			if effid ~= 0 then
				if bodyid == 0 then
					role:setEffectSystem(全局设置.getAnimPackUrl(effid,true), true, nil, nil, 0, -1)
				else
					role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(effid)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			end
		else
			if effid ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid), true)
			end
		end
	end
	role.hp = 0
	role.maxhp = 100
	role.name = name
	role.showname = true
	role.guildname = nil
	role.color = nil
	role.namecolor = 全局设置.NAMECOLOR[5]
	主逻辑.setHPBar(role, 0, 100, 全局设置.getHPColor(role.objtype), name, role.mergehp, role.showname, nil, role.namecolor)
end

function GC_ADD_MONSTER(name,level,status,buffinfo,confid,bodyid,effid,type,ownerid,teamid,objid,posx,posy,movex,movey,maxhp,maxmp,hp,mp,speed)
	local role = g_roles[objid]
	if not role then
		role = addRole((bodyid[1] or 0),objid,全局设置.OBJTYPE_MONSTER,posx,posy,speed)
		role:setAnimName("idle")
		role.status = status
		--role:setVisible(status == 0)
		role.bodyid = (bodyid[1] or 0)
		role.iscaller = (bodyid[1] or 0) == 0
		role.isboss = type == 1 or type == 2 or type == 3
		role.istower = type == 3
		role.是否练功师 = type == 6
		role.是否采集物 = type == 5
		role.level = level
		if ISMIR2D then
			if (bodyid[1] or 0) > 0 and (bodyid[1] or 0) < 1000 then
				role:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getMirHairUrl(全局设置.武神外观[(bodyid[1] or 0)][1]))
				role:setEntity(F3DImageAnim3D.PART_WEAPON, 全局设置.getAnimPackUrl(全局设置.武神外观[(bodyid[1] or 0)][4]))
				if 全局设置.武神外观[(bodyid[1] or 0)][3] ~= 0 then
					role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(全局设置.武神外观[(bodyid[1] or 0)][3])):setBlendType(F3DRenderContext.BLEND_ADD)
				end
				if 全局设置.武神外观[(bodyid[1] or 0)][5] ~= 0 then
					role:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl(全局设置.武神外观[(bodyid[1] or 0)][5])):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			else
				if (effid[1] or 0) ~= 0 then
					if (bodyid[1] or 0) == 0 then
						role:setEffectSystem(全局设置.getAnimPackUrl((effid[1] or 0),true), true, nil, nil, 0, -1)
					else
						role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl((effid[1] or 0))):setBlendType(F3DRenderContext.BLEND_ADD)
					end
				end
				if (bodyid[2] or 0) ~= 0 then
					role:setEntity(F3DImageAnim3D.PART_WEAPON, 全局设置.getAnimPackUrl((bodyid[2] or 0)))
					role:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getMirHairUrl((bodyid[1] or 0)%2==0 and 2 or 1))
				end
				if (effid[2] or 0) ~= 0 then
					if (bodyid[2] or 0) == 0 then
						role:setEffectSystem(全局设置.getAnimPackUrl((effid[2] or 0),true), true, nil, nil, 0, -1)
					else
						role:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl((effid[2] or 0))):setBlendType(F3DRenderContext.BLEND_ADD)
					end
				end
			end
		else
			if (effid[1] or 0) ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl((effid[1] or 0)), true)
			end
		end
		if role.objtype == 全局设置.OBJTYPE_MONSTER and role.isboss then
			Boss信息UI.setBossInfo(objid,name,level,"",(bodyid[1] or 0),hp,maxhp)
		end
	end
	for i,v in ipairs(buffinfo) do
		技能逻辑.setSkillBuff(objid,v[1],v[3],v[2])
	end
	role.hp = hp
	role.maxhp = maxhp
	role.name = name
	role.ownerid = ownerid
	role.teamid = teamid
	role.showname = nil
	role.guildname = nil
	role.color = nil
	role.namecolor = nil
	if not role.iscaller then
		主逻辑.setHPBar(role, hp, maxhp, 全局设置.getHPColor(role.objtype,role.ownerid~=-1,role.isboss), name)
	end
	if hp <= 0 and type ~= 5 then
		role:setAnimName("dead","",true,true,true)
	elseif movex == -1 or movey == -1 then
	else
		role:startMove(movex, g_is3D and movey or to3d(movey), role.status==1 and "walk" or "run")
	end
end

function GC_ADD_PET(name,level,status,buffinfo,confid,bodyid,effid,masterid,grade,starlevel,teamid,objid,posx,posy,movex,movey,maxhp,maxmp,hp,mp,speed)
	local role = g_roles[objid]
	if not role then
		role = addRole(bodyid,objid,全局设置.OBJTYPE_PET,posx,posy,speed)
		role:setAnimName("idle")
		role.status = status
		--role:setVisible(status == 0)
		role.bodyid = bodyid
		if ISMIR2D then
			if effid ~= 0 then
				if bodyid == 0 then
					role:setEffectSystem(全局设置.getAnimPackUrl(effid,true), true, nil, nil, 0, -1)
				else
					role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(effid)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			end
		else
			if effid ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid), true)
			end
		end
	end
	for i,v in ipairs(buffinfo) do
		技能逻辑.setSkillBuff(objid,v[1],v[3],v[2])
	end
	role.level = level
	role.hp = hp
	role.maxhp = maxhp
	role.name = name
	role.ownerid = masterid
	role.teamid = teamid
	role.showname = nil
	role.guildname = nil
	role.color = nil
	role.namecolor = nil
	主逻辑.setHPBar(role, hp, maxhp, 全局设置.getHPColor(role.objtype), name)
	宠物信息UI.setHPBar(objid, hp, maxhp, mp, maxmp)
	if hp <= 0 then
		role:setAnimName("dead","",true,true,true)
	elseif movex == -1 or movey == -1 then
	else
		role:startMove(movex, g_is3D and movey or to3d(movey), role.status==1 and "walk" or "run")
	end
end

function GC_TASK_INFO(info,query)
	任务追踪UI.setTaskInfo(info,query)
end

function GC_NPC_TALK(objid,bodyid,effid,desc,taskid,state,talk,prize)
	if objid == -1 and desc == "" then
		Npc对话UI.onCloseUI()
	else
		Npc对话UI.initUI()
		Npc对话UI.setNpcBody(objid, bodyid, effid, desc, talk, taskid, state, prize)
	end
end

function GC_JUMP_SCENE(objid,mapid,x,y)
	local role = g_roles[objid]
	if role and g_mapid == mapid then
		stopRoleMove(role, true)
		jumpScene(role, x, y)
	end
end

function GC_CHANGE_STATUS(objid,status,pkmode)
	local role = g_roles[objid]
	if role then
		if status == 101 then
			if role ~= g_role then
				role:startHitFly(0.6, 200, 0.3, 0.3, 0)
				role:setAnimName("jump","",true,true)
				role.isjump = true
			end
		elseif status == 102 then
			--role:setAnimName("block","",true,true)
		elseif role.status ~= status then
			role.status = status
			if role:getAnimName() == "run" and status == 1 then
				role:setAnimName("walk")
			elseif role:getAnimName() == "walk" and status ~= 1 then
				role:setAnimName("run")
			end
		end
		if role == g_role then
			头像信息UI.m_pkmode = pkmode
			if ISMIRUI then
				主界面UI.update()
			else
				头像信息UI.update()
			end
		end
		--role:setVisible(status == 0)
		--if role.hpbar and not role:isVisible() then
		--	role.hpbar:setVisible(false)
		--end
	end
end

function GC_DETAIL_ATTR(expmax,exp,hpmax,hp,mpmax,mp,money,bindmoney,rmb,bindrmb,speed,power,totalpower,suitcnts,PK值,总充值,每日充值,特戒抽取次数,刷新BOSS次数,开区活动倒计时,vip等级,转生等级,防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,力量,智力,精神,体质,重击)
	角色逻辑.setDetailAttr(expmax,exp,hpmax,hp,mpmax,mp,money,bindmoney,rmb,bindrmb,atk,def,crit,firm,hit,dodge,speed,power,totalpower,转生等级,PK值,suitcnts,liliang,zhili,jingshen,tizhi,zhongji)
	角色逻辑.setExtraAttr(防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,力量,智力,精神,体质,重击)
	角色逻辑.setOtherAttr(vip等级, 总充值, 每日充值, 特戒抽取次数, 刷新BOSS次数, 开区活动倒计时)
end

function GC_CHANGE_FACADE(objid,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,speed,斗笠外观)
	--if bodyid == 0 then return end
	local role = g_roles[objid]
	if role and (bodyid == 0 or (bodyid > 1000 and bodyid < 2000)) then
		role:reset()
		role:setMoveSpeed(speed)
		role.bodyid = bodyid
		if IS3G or ISWZ then
			role:setShowShadow(true)
		end
		if ISMIR2D then
			role:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(bodyid))
			if bodyeff ~= 0 then
				if bodyid == 0 then
					role:setEffectSystem(全局设置.getAnimPackUrl(bodyeff,true), true, nil, nil, 0, -1)
				else
					role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(bodyeff)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			end
		else
			role:setShowShadow(true)
			role:getBody():setEntity(F3DAvatar.PART_BODY, 全局设置.getModelUrl(bodyid))
			role:getBody():setAnimSet(F3DUtils:trimPostfix(全局设置.getModelUrl(bodyid))..".txt")
			role.changefacade = 1
			if bodyeff ~= 0 then
				role:getBody():setEffectSystem(全局设置.getEffectUrl(bodyeff), true)
			end
		end
		if role.hp <= 0 then
			role:setAnimName("dead","",true,true,true)
		elseif role:needMove() then
			role:setAnimName("run")
		else
			role:setAnimName("idle")
		end
		if role == g_role then
			角色逻辑.setFacade(bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff)
		end
	elseif role then
		role:reset()
		role:setMoveSpeed(speed)
		role.bodyid = bodyid
		if IS3G or ISWZ then
			role:setShowShadow(true)
		end
		if ISMIR2D then
			role:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(bodyid))
			if IS3G or ISWZ then
			elseif 斗笠外观 ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getAnimPackUrl(斗笠外观))
			else
				role:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getMirHairUrl(role.sex))
			end
			role.changefacade = nil
			if weaponid ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_WEAPON, 全局设置.getAnimPackUrl(weaponid))
			end
			if wingid ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_WING, 全局设置.getAnimPackUrl(wingid))
			end
			if horseid ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_HORSE, 全局设置.getAnimPackUrl(horseid))
			end
			if bodyeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(bodyeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
			if weaponeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl(weaponeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
			if wingeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_WING_EFFECT, 全局设置.getAnimPackUrl(wingeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
			if horseeff ~= 0 then
				role:setEntity(F3DImageAnim3D.PART_HORSE_EFFECT, 全局设置.getAnimPackUrl(horseeff)):setBlendType(F3DRenderContext.BLEND_ADD)
			end
		else
			role:setShowShadow(true)
			role:getBody():setEntity(F3DAvatar.PART_BODY, 全局设置.getBodyUrl(bodyid))
			role:getBody():setEntity(F3DAvatar.PART_FACE, 全局设置.getFaceUrl(role.job))
			role:getBody():setEntity(F3DAvatar.PART_HAIR, 全局设置.getHairUrl(role.job))
			role:getBody():setAnimSet(全局设置.getAnimsetUrl(role.job))
			role.changefacade = nil
			if weaponid ~= 0 then
				role:getBody():setEntity(F3DAvatar.PART_WEAPON, 全局设置.getWeaponUrl(weaponid))
			end
			if wingid ~= 0 then
				role:setWingUrl(全局设置.getWingUrl(wingid))
			end
			if horseid ~= 0 then
				role:setHorseUrl(全局设置.getPetUrl(horseid))
			end
			if bodyeff ~= 0 then
				role:getBody():setEffectSystem(全局设置.getEffectUrl(bodyeff), true)
			end
			if weaponeff ~= 0 then
				role:getBody():setEffectSystem(全局设置.getEffectUrl(weaponeff), true)
			end
			if wingeff ~= 0 and role:getWing() then
				role:getWing():setEffectSystem(全局设置.getEffectUrl(wingeff), true)
			end
			if horseeff ~= 0 and role:getHorse() then
				role:getHorse():setEffectSystem(全局设置.getEffectUrl(horseeff), true)
			end
		end
		if role.hp <= 0 then
			role:setAnimName("dead","",true,true,true)
		elseif role:needMove() then
			role:setAnimName("run")
		else
			role:setAnimName("idle")
		end
		if role == g_role then
			角色逻辑.setFacade(bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff)
		end
	end
end

function GC_CHANGE_BODY(objid,bodyid,effid,speed)
	local role = g_roles[objid]
	if role then--and bodyid ~= 0 then
		role:reset()
		role:setMoveSpeed(speed)
		role.bodyid = bodyid
		if IS3G or ISWZ then
			role:setShowShadow(true)
		end
		if ISMIR2D then
			role:setEntity(F3DImageAnim3D.PART_BODY, 全局设置.getAnimPackUrl(bodyid))
			if bodyid > 0 and bodyid < 1000 then
				if IS3G or ISWZ then
				else
					role:setEntity(F3DImageAnim3D.PART_HAIR, 全局设置.getMirHairUrl(全局设置.武神外观[bodyid][1]))
				end
				role:setEntity(F3DImageAnim3D.PART_WEAPON, 全局设置.getAnimPackUrl(全局设置.武神外观[bodyid][4]))
				if 全局设置.武神外观[bodyid][3] ~= 0 then
					role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(全局设置.武神外观[bodyid][3])):setBlendType(F3DRenderContext.BLEND_ADD)
				end
				if 全局设置.武神外观[bodyid][5] ~= 0 then
					role:setEntity(F3DImageAnim3D.PART_WEAPON_EFFECT, 全局设置.getAnimPackUrl(全局设置.武神外观[bodyid][5])):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			elseif effid ~= 0 then
				if bodyid == 0 then
					role:setEffectSystem(全局设置.getAnimPackUrl(effid,true), true, nil, nil, 0, -1)
				else
					role:setEntity(F3DImageAnim3D.PART_BODY_EFFECT, 全局设置.getAnimPackUrl(effid)):setBlendType(F3DRenderContext.BLEND_ADD)
				end
			end
		else
			role:setShowShadow(true)
			role:setEntity(F3DAvatar.PART_BODY, 全局设置.getModelUrl(bodyid))
			role:setAnimSet(F3DUtils:trimPostfix(全局设置.getModelUrl(bodyid))..".txt")
			if effid ~= 0 then
				role:setEffectSystem(全局设置.getEffectUrl(effid), true)
			end
		end
		if role.hp <= 0 then
			role:setAnimName("dead","",true,true,true)
		elseif role:needMove() then
			role:setAnimName("run")
		else
			role:setAnimName("idle")
		end
	end
end

function GC_XP_USE(objid,effid)
	local role = g_roles[objid]
	if role and effid ~= 0 then
		if not ISMIR2D then
			role:setEffectSystem(全局设置.getEffectUrl(effid), false)
		end
	end
end

function GC_XP_INFO(objid,status,cd,cdmax,icon)
	if g_role and g_role.objid == objid then
		主界面UI.setXPInfo(status,cd,cdmax,icon)
	end
end

function GC_LEVEL_UP(objid,level)
	local role = g_roles[objid]
	if role and (role.objtype == 全局设置.OBJTYPE_PLAYER or role.objtype == 全局设置.OBJTYPE_MONSTER) then
		if not ISMIR2D then
			role:setEffectSystem(全局设置.getEffectUrl(3648), false)
		end
	end
	if role and role.objtype == 全局设置.OBJTYPE_PET then
		if not ISMIR2D then
			role:setEffectSystem(全局设置.getEffectUrl(3659), false)
		end
	end
	if role == g_role then
		if role.level < 10 and level >= 10 then
			--消息.CG_USE_MOUNT(1)
		end
		if role.level < 20 and level == 20 then
			--消息.CG_USE_WING(1)
		end
		角色逻辑.setLevel(level)
		个人副本UI.update()
	end
	if role and objid == 英雄信息UI.m_objid then
		英雄信息UI.setLevel(level)
	end
	if role then
		role.level = level
	end
end

function GC_CHANGE_SPEED(objid,speed)
	local role = g_roles[objid]
	if role then
		role:setMoveSpeed(speed)
	end
end

function GC_COPYSCENE_INFO(time,leftcnt,totalcnt,info)
	任务追踪UI.setCopySceneInfo(info,time,leftcnt,totalcnt)
	小地图UI.showEnemyInfo(info)
end

function GC_CREATE_ROOM(result)
	主界面UI.showTipsMsg(3, "正在匹配中...(0秒)")
end

function GC_CHANGE_TEAM(objid,teamid)
	local role = g_roles[objid]
	if role then
		role.teamid = teamid
		if role == g_role then
			角色逻辑.m_teamid = teamid
		end
	end
end

function GC_ACTUAL_ATTR(objid,expmax,exp,mpmax,mp,tp)
	if g_role and objid == g_role.objid then
		角色逻辑.setActualAttr(expmax,exp,mpmax,mp)
		个人副本UI.setTP(tp)
		Boss副本UI.setTP(tp)
	end
	if objid == 英雄信息UI.m_objid then
		英雄信息UI.setMPBar(mp,mpmax)
	end
end

function GC_TEAM_INFO(info)
	队伍信息UI.setTeamInfo(info)
end

function GC_VIEWER(objid)
	g_role.viewerid = objid
	grabimage:setShaderType(F3DImage.SHADER_WARP)
end

function GC_COPYSCENE_FINISH(type,winteam,score1,score2,info)
	local finishui = type == 1 and 结算UI1 or 结算UI2
	finishui.m_winteam = winteam
	finishui.m_score1 = score1
	finishui.m_score2 = score2
	finishui.m_teaminfo = info
	finishui.initUI()
	finishui.update()
end

function GC_SINGLECOPY_INFO(info)
	个人副本UI.setCopyInfo(info)
end

function GC_ENTER_COPYSCENE(result)
	if result == 0 then
		个人副本UI.hideUI()
		Boss副本UI.hideUI()
	end
end

function GC_QUIT_COPYSCENE(result)
end

function GC_BOSSCOPY_INFO(info)
	Boss副本UI.setCopyInfo(info)
end

function GC_EQUIP_VIEW(rolename,objid,level,job,sex,expmax,exp,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,hpmax,mpmax,speed,power,转生等级,防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,itemdata,是否英雄,斗笠外观,显示时装,显示炫武,力量,智力,精神,体质,重击)
	if 是否英雄 == 1 then
		角色UI.setHeroEquipData(rolename,objid,level,job,sex,expmax,exp,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,hpmax,mpmax,speed,power,转生等级,防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,itemdata,力量,智力,精神,体质,重击)
	else
		角色查看UI.initUI()
		角色查看UI.setEquipData(rolename,objid,level,job,sex,expmax,exp,bodyid,weaponid,wingid,horseid,bodyeff,weaponeff,wingeff,horseeff,hpmax,mpmax,speed,power,转生等级,防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,itemdata,显示时装,显示炫武,力量,智力,精神,体质,重击)
	end
end

function GC_HERO_INFO(rolename,objid,level,job,sex,status,maxhp,maxmp,hp,mp)
	英雄信息UI.setInfo(rolename,objid,job,sex)
	英雄信息UI.setLevel(level)
	英雄信息UI.setHPBar(hp,maxhp)
	英雄信息UI.setMPBar(mp,maxmp)
end

function GC_VIP_SPREAD(rolename,成长经验,推广人数,推广有效人数,礼包领取,每日充值领取)
	福利UI.setVIPSpread(rolename,成长经验,推广人数,推广有效人数,礼包领取,每日充值领取)
end

function GC_PROP_ADDPOINT(剩余点数,英雄剩余点数)
	角色UI.setAddPointCnt(剩余点数, 英雄剩余点数)
end

function GC_CHANGE_JOB(objid,rolename,sex,job)
	local role = g_roles[objid]
	if role then
		role.name = rolename
		role.sex = sex
		role.job = job
		主逻辑.setHPBar(role, role.hp, role.maxhp, 全局设置.getHPColor(role.objtype), role.name, role.mergehp, role.showname, role.guildname, role.namecolor)
		if role == g_role then
			角色逻辑.m_rolename = rolename
			角色逻辑.m_rolesex = sex
			角色逻辑.setRoleJob(job)
		end
	end
end

function GC_COLLECT_START(objid)
	if objid == -1 then
		采集进度UI.stop()
	else
		采集进度UI.start()
	end
end

function GC_CHANGE_NAME(rolename,guildname,color,title,objid,ownerid)
	local role = g_roles[objid]
	if role then
		role.name = rolename
		role.guildname = guildname
		role.color = color
		if 角色逻辑.m_alliance[guildname] then
			role.namecolor = 全局设置.NAMECOLOR[6]
		elseif 角色逻辑.m_challenge[guildname] then
			role.namecolor = 全局设置.NAMECOLOR[7]
		else
			role.namecolor = 全局设置.NAMECOLOR[color]
		end
		role.ownerid = ownerid
		主逻辑.setHPBar(role, role.hp, role.maxhp, 全局设置.getHPColor(role.objtype,role.ownerid~=-1,role.isboss), role.name, role.mergehp, role.showname, role.guildname, role.namecolor)
		
		if role.hpbar and #title > 0 then
			role.hpbar.titles = role.hpbar.titles or {}
			for i=1,#title,4 do
				local img = role.hpbar.titles[math.ceil(i/4)] or F3DImage:new()
				img:setTextureFile(全局设置.getIconIconUrl(title[i+1]))
				img:setPositionX(title[i+2]-15)
				img:setPositionY(title[i+3]-30)
				role.hpbar:addChild(img)
				role.hpbar.titles[math.ceil(i/4)] = img
			end
		end
		if role == g_role then
			角色逻辑.m_rolename = rolename
			角色逻辑.m_guildname = guildname
		end
	end
end

function GC_ATTACK_GUILD(challenge,alliance)
	角色逻辑.setAttackGuild(challenge,alliance)
	for k,v in pairs(g_roles) do
		if v.guildname and 角色逻辑.m_alliance[v.guildname] then
			v.namecolor = 全局设置.NAMECOLOR[6]
		elseif v.guildname and 角色逻辑.m_challenge[v.guildname] then
			v.namecolor = 全局设置.NAMECOLOR[7]
		elseif v.color then
			v.namecolor = 全局设置.NAMECOLOR[v.color]
		end
		主逻辑.setHPBar(v, v.hp, v.maxhp, 全局设置.getHPColor(v.objtype), v.name, v.mergehp, v.showname, v.guildname, v.namecolor)
	end
end

function GC_COMMAND_MSG(type,msg)
	if type == 1 then
		F3DPlatform:instance():navigateToURL(msg)
	elseif type == 2 then
		F3DSoundManager:instance():playSound(msg:find("//") ~= nil and "http://"..msg or "/res/sound/"..msg)
	elseif type == 4 then
		锻造UI.setShowType(1, msg)
		锻造UI.initUI()
	elseif type == 5 then
		锻造UI.setShowType(2, msg)
		锻造UI.initUI()
	end
end
