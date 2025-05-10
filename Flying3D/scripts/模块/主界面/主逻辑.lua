module(..., package.seeall)

local 实用工具 = require("公用.实用工具")

m_FlytextPool = {}
m_Flytexts = {}

function pushFlytext(flytext)
	if flytext.minus then
		flytext.minus:setVisible(false)
	end
	flytext:setAlpha(1)
	flytext:reset()
	flytext:removeFromParent()
	m_Flytexts[flytext] = nil
	m_FlytextPool[#m_FlytextPool+1] = flytext
end

function popFlytext()
	if #m_FlytextPool > 0 then
		local flytext = m_FlytextPool[#m_FlytextPool]
		table.remove(m_FlytextPool, #m_FlytextPool)
		return flytext
	end
end

--显示特效 攻击伤害 role,角色 dechp,伤害 crit 是否暴击  掉血特效
function showFlytext(role, dechp, crit)
	--图片创建
	local flytext = popFlytext() or F3DImage3D:new()
	if dechp == 0 then
		flytext:setWidth(0)
		--失败
		flytext:setTextureFile(UIPATH.."公用/fight/miss.png")
		flytext:setOffset(-52, -35)
	elseif dechp < 0 then
		dechp = -dechp
		--创建数字 增溢效果
		flytext:setTextureFile(UIPATH.."公用/fight/addHit.png")
		flytext:setWidth(22)
		if not flytext.clips then
			flytext.clips = F3DPointVector:new()
		end
		flytext.clips:clear()
		while dechp >= 1 do
			flytext.clips:push(math.floor(dechp%10), -flytext.clips:size()*22)
			dechp = dechp / 10
		end
		flytext:setBatchClips(10, flytext.clips)
		flytext:setOffset(-22+flytext.clips:size()*11, -50)
		if not flytext.minus then
			flytext.minus = F3DImage:new()
			flytext:addChild(flytext.minus)
		end
		--加号显示
		flytext.minus:setTextureFile(UIPATH.."公用/fight/addFlag.png")
		flytext.minus:setPositionX(-(flytext.clips:size()-1)*22-27)
		flytext.minus:setPositionY(4)
		flytext.minus:setVisible(true)
	elseif crit == 1 then
		--暴击 文字显示
		flytext:setTextureFile(UIPATH.."公用/fight/criticalHit.png")
		flytext:setWidth(28)
		if not flytext.clips then
			flytext.clips = F3DPointVector:new()
		end
		flytext.clips:clear()
		while dechp >= 1 do
			flytext.clips:push(math.floor(dechp%10), -flytext.clips:size()*28)
			dechp = dechp / 10
		end
		flytext:setBatchClips(10, flytext.clips)
		flytext:setOffset(-28+flytext.clips:size()*14, -50)
		if not flytext.minus then
			flytext.minus = F3DImage:new()
			flytext:addChild(flytext.minus)
		end
		--暴击 文字显示
		flytext.minus:setTextureFile(UIPATH.."公用/fight/criticalHit.png")
		flytext.minus:setPositionX(-(flytext.clips:size()-1)*28-55)
		flytext.minus:setPositionY(-5)
		flytext.minus:setVisible(true)
	else
		--普通攻击技能文字
		flytext:setTextureFile(UIPATH.."公用/fight/otherHit.png")
		flytext:setWidth(22)
		if not flytext.clips then
			flytext.clips = F3DPointVector:new()
		end
		flytext.clips:clear()
		while dechp >= 1 do
			flytext.clips:push(math.floor(dechp%10), -flytext.clips:size()*22)
			dechp = dechp / 10
		end
		flytext:setBatchClips(10, flytext.clips)
		flytext:setOffset(-22+flytext.clips:size()*11, -50)
		if not flytext.minus then
			flytext.minus = F3DImage:new()
			flytext:addChild(flytext.minus)
		end
		--咸号显示
		flytext.minus:setTextureFile(UIPATH.."公用/fight/otherFlag.png")
		flytext.minus:setPositionX(-(flytext.clips:size()-1)*22-17)
		flytext.minus:setPositionY(12)
		flytext.minus:setVisible(true)
	end
	--设置显示坐标
	flytext:setPosition(role:getPositionX(), role:getPositionY(), role:getPositionZ() + 100)--role:getBoxHeight() + 10)
	dechpcont:addChild(flytext)
	m_Flytexts[flytext] = 1
	local prop = F3DTweenProp:new()
	prop:push("offsetY", -100, F3DTween.TYPE_SPEEDDOWN)
	prop:push("alpha", 0, F3DTween.TYPE_LINEAR)
	F3DTween:fromPool():start(flytext, prop, 1, func_n(function()
		pushFlytext(flytext)--flytext:removeFromParent(true)
	end))
end

hpbarpool = {}

function removeMergeHP(hpbar)
	if hpbar.mergehp then
		for i,v in ipairs(hpbar.mergehp) do
			v:removeFromParent(true)
		end
		hpbar.mergehp = nil
	end
end

function createMergeHP(hpbar, hp, hpmax, mergehp)
	hpmax = hp
	for i,v in ipairs(mergehp) do
		hpmax = hpmax + (i == #mergehp and v.hpmax or v.hp)
	end
	local perc = hp / hpmax
	hpbar.hpimg:setWidth(hpbar.track:getWidth()*perc)
	hpbar.mergehp = {}
	for i,v in ipairs(mergehp) do
		local hpimg = F3DImage:new()
		local pc = (i == #mergehp and v.hpmax or v.hp) / hpmax
		hpimg:setTextureFile("tex_white")
		hpimg:setWidth(hpbar.track:getWidth()*pc-1)
		hpimg:setHeight(hpbar.track:getHeight())
		hpimg:setPositionX(hpbar.track:getWidth()*perc+1)
		hpimg:getColor():setRGB(v.color)
		hpbar.track:addChild(hpimg)
		hpbar.mergehp[#hpbar.mergehp+1] = hpimg
		perc = perc + pc
		hp = hp + v.hp
	end
	return hp, hpmax
end

function onHpBarInit(e)
	local hpbar = e:getTarget()
	hpbar.name = hpbar:findComponent("name")
	local ss = 实用工具.SplitString(hpbar.v.name,"\\")
	
	local name = string.gsub(txt(ss[1]),"s0.","")
	hpbar.name:setTitleText(name)
	--hpbar.name:setTitleText(txt(ss[1]))
	if #ss > 1 then
		hpbar.nameexs = hpbar.nameexs or {}
		for i=2,#ss do
			local tf = hpbar.nameexs[i-1] or F3DTextField:new()
			if g_mobileMode then
				tf:setTextFont("宋体",16,false,false,false)
			end
			tf:setText(txt(ss[i]))
			tf:setTextColor(hpbar.namecolor or 0xffffff,0)
			tf:setPivot(0.5,0.5)
			tf:setPositionX(0)
			tf:setPositionY(50+(i-1)*14)
			hpbar:addChild(tf)
			hpbar.nameexs[i-1] = tf
		end
	end
	hpbar.name:setVisible(hpbar.showname)
	hpbar.name:setTextColor(hpbar.namecolor or 0xffffff)
	hpbar.guildname = hpbar:findComponent("guildname")
	hpbar.guildname:setTitleText(txt(hpbar.v.guildname or ""))
	hpbar.guildname:setVisible(hpbar.showname)
	hpbar.guildname:setTextColor(hpbar.namecolor or 0xffffff)
	hpbar.pro = tt(hpbar:findComponent("hpbar"),F3DProgress)
	hpbar.track = hpbar.pro:getTrack()
	hpbar.hpimg = F3DImage:new()
	hpbar.hpimg:setTextureFile("tex_white")
	hpbar.hpimg:setWidth(hpbar.track:getWidth())
	hpbar.hpimg:setHeight(hpbar.track:getHeight())
	hpbar.hpimg:getColor():setRGB(hpbar.v.color)
	hpbar.track:addChild(hpbar.hpimg)
	if not hpbar.v.mergehp then
		hpbar.mergehp = nil
		hpbar.pro:setMaxVal(hpbar.v.hpmax)
		hpbar.pro:setCurrVal(hpbar.v.hp)
		hpbar.pro:setVisible(hpbar.v.hp > 0)
	else
		local hp, hpmax = createMergeHP(hpbar, hpbar.v.hp, hpbar.v.hpmax, hpbar.v.mergehp)
		hpbar.pro:setMaxVal(hpmax)
		hpbar.pro:setCurrVal(hp)
		hpbar.pro:setVisible(hp > 0)
	end
end

function setHPBar(role, hp, hpmax, color, name, mergehp, showname, guildname, namecolor)
	local newcreate
	local hpbar
	showname = showname or 显示名字 == 1
	if role.hpbar then
		hpbar = role.hpbar
		hpbar.showname = showname
		hpbar.namecolor = namecolor
	else
		if #hpbarpool == 0 then
			hpbar = F3DLayout:new()
			hpbar.showname = showname
			hpbar.namecolor = namecolor
			hpbar:setLoadPriority(g_uiFastPriority)
			hpbar.v = {hp = hp,hpmax = hpmax,color = color,name = name,mergehp = mergehp,guildname = guildname}
			hpbar:addEventListener(F3DObjEvent.OBJ_INITED, func_oe(onHpBarInit))
			hpbar:setLayout(g_mobileMode and UIPATH.."血条UIm.layout" or UIPATH.."血条UI.layout")--IS3G and UIPATH.."血条UIn.layout" or 
			newcreate = true
		else
			hpbar = hpbarpool[#hpbarpool]
			hpbar.showname = showname
			hpbar.namecolor = namecolor
			table.remove(hpbarpool)
		end
		role.hpbar = hpbar
		hpbar:setZOrder(-role:getPositionY())
		hpcont:addChild(hpbar)
	end
	if newcreate then
	elseif hpbar:isInited() then
		local ss = 实用工具.SplitString(name,"\\")
		
		local name = string.gsub(txt(ss[1]),"s0.","")
		hpbar.name:setTitleText(name)		
		--hpbar.name:setTitleText(txt(ss[1]))
		if #ss > 1 then
			hpbar.nameexs = hpbar.nameexs or {}
			for i=2,#ss do
				local tf = hpbar.nameexs[i-1] or F3DTextField:new()
				if g_mobileMode then
					tf:setTextFont("宋体",16,false,false,false)
				end
				tf:setText(txt(ss[i]))
				tf:setTextColor(hpbar.namecolor or 0xffffff,0)
				tf:setPivot(0.5,0.5)
				tf:setPositionX(0)
				tf:setPositionY(50+(i-1)*14)
				hpbar:addChild(tf)
				hpbar.nameexs[i-1] = tf
			end
		end
		hpbar.guildname:setTitleText(txt(guildname or ""))
		hpbar.name:setVisible(hpbar.showname or role == g_hoverObj)
		hpbar.name:setTextColor(hpbar.namecolor or 0xffffff)
		hpbar.guildname:setVisible(hpbar.showname or role == g_hoverObj)
		hpbar.guildname:setTextColor(hpbar.namecolor or 0xffffff)
		if not mergehp then
			removeMergeHP(hpbar)
			hpbar.hpimg:setWidth(hpbar.track:getWidth())
			hpbar.hpimg:getColor():setRGB(color)
			hpbar.pro:setMaxVal(hpmax)
			hpbar.pro:setCurrVal(hp)
			hpbar.pro:setVisible(hp > 0)
		else
			removeMergeHP(hpbar)
			hpbar.hpimg:setWidth(hpbar.track:getWidth())
			hpbar.hpimg:getColor():setRGB(color)
			hp, hpmax = createMergeHP(hpbar, hp, hpmax, mergehp)
			hpbar.pro:setMaxVal(hpmax)
			hpbar.pro:setCurrVal(hp)
			hpbar.pro:setVisible(hp > 0)
		end
	else
		hpbar.v = {hp = hp,hpmax = hpmax,color = color,name = name,mergehp = mergehp,guildname = guildname}
	end
	if not role:isVisible() or (hp == hpmax and not mergehp) then
		hpbar:setVisible(true)--false)
	else
		hpbar:setVisible(true)
	end
end

function delHPBar(role)
	local hpbar = role.hpbar
	if hpbar then
		hpbar.showname = nil
		hpbar.namecolor = nil
		if hpbar.titles then
			for i,v in ipairs(hpbar.titles) do
				v:removeFromParent(true)
			end
			实用工具.DeleteTable(hpbar.titles)
		end
		if hpbar.nameexs then
			for i,v in ipairs(hpbar.nameexs) do
				v:removeFromParent(true)
			end
			实用工具.DeleteTable(hpbar.nameexs)
		end
		hpbar:removeFromParent()
		hpbarpool[#hpbarpool] = hpbar
		role.hpbar = nil
	end
end

function updateHPBar(role)
	local hpbar = role.hpbar
	if hpbar then
		hpbar:setVisible(role:isVisible())
	end
	if hpbar and hpbar:isVisible() then
		hpbar:setZOrder(-role:getPositionY())
		local pt = F3DUtils:getScreenPosition(role:getPositionX(), role:getPositionY(), role:getPositionZ() + 100)--role:getBoxHeight() + 20)
		if pt then
			hpbar:setPositionX(pt.x)
			hpbar:setPositionY(pt.y)
		end
	end
end
