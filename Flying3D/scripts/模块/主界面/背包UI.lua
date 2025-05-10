module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 装备分解UI = require("主界面.装备分解UI")
local 商店UI = require("主界面.商店UI")
local 仓库UI = require("主界面.仓库UI")
local 消息框UI1 = require("主界面.消息框UI1")
local 消息框UI2 = require("主界面.消息框UI2")
local 消息框UI3 = require("主界面.消息框UI3")
local 主界面UI = require("主界面.主界面UI")
local 角色逻辑 = require("主界面.角色逻辑")
local 角色UI = require("主界面.角色UI")
local 物品提示UI = require("主界面.物品提示UI")
local 装备提示UI = require("主界面.装备提示UI")
local 装备对比提示UI = require("主界面.装备对比提示UI")
local 锻造UI = require("主界面.锻造UI")
local 宠物蛋提示UI = require("主界面.宠物蛋提示UI")
local 简单提示UI = require("主界面.简单提示UI")

function onClose(e)
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		装备对比提示UI.hideUI()
		宠物蛋提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	ui:setVisible(false)
	if otherui then otherui:hideUI() end
	ui.关闭:releaseMouse()
	e:stopPropagation()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	if otherui and otherui.ui:isVisible() then
		uiLayer:removeChild(otherui.ui)
		uiLayer:addChild(otherui.ui)
	end
	e:stopPropagation()
end

function onMouseMove(e)
	if not otherui or not otherui.ui:isVisible() or not otherui.ui:isInited() then
		return
	end
	otherui.ui:setPositionX(ui:getPositionX()-ui:getWidth())
	otherui.ui:setPositionY(ui:getPositionY())
end

m_init = false
m_itemdata = {}
m_selectitem = nil
m_tabid = 0
otherui = nil
tipsui = nil
tipsgrid = nil
movegrid = nil
BAG_CAP = ISZY and 96 or 42
ITEMCOUNT = 42
m_curpage = 1

function getLeftCount()
	local cnt = 0
	for i=1,BAG_CAP do
		if not m_itemdata[i] or m_itemdata[i].id == 0 or m_itemdata[i].count == 0 then
			cnt = cnt + 1
		end
	end
	return cnt
end

function updateMoney()
	if not m_init then
		return
	end
	--ui.bindmoney:setTitleText(角色逻辑.m_bindmoney)
	ui.money:setTitleText(toshuzhi(角色逻辑.m_money))
	
	--ui.bindrmb:setTitleText(角色逻辑.m_bindrmb)
	ui.rmb:setTitleText(toshuzhi(角色逻辑.m_rmb))
	
end

function setItemData(op, itemdata)
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
			gray=false,
		}
	end
	update()
	主界面UI.updateQuickItem()
	锻造UI.update()
	装备分解UI.update()
end

function getItemIcon(itemid)
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			return v.icon
		end
	end
	return 0
end

function getItemGrade(itemid)
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			return v.grade
		end
	end
	return 1
end

function getItemName(itemid)
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			return v.name
		end
	end
	return ""
end

function getItemDesc(itemid)
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			return v.desc
		end
	end
	return ""
end

function getItemCount(itemid)
	local cnt = 0
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			cnt = cnt + v.count
		end
	end
	return cnt
end

function getItemCD(itemid)
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			return v.cd
		end
	end
	return 0
end

function getItemCDMax(itemid)
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			return v.cdmax
		end
	end
	return 0
end

function GetEquipPos(item, 是否英雄)
	local itemdata = 是否英雄 and 角色UI.英雄物品数据 or 角色UI.m_itemdata
	if item.type ~= 3 or not itemdata then
		return 0
	end
	if item.equippos == 14 then--宠物蛋
		return 0
	elseif item.equippos == 5 then--手镯
		if not itemdata[5] or itemdata[5].count == 0 then
			return 5
		elseif not itemdata[14] or itemdata[14].count == 0 then
			return 14
		elseif itemdata[5].power < itemdata[14].power then
			return 5
		else
			return 14
		end
	elseif item.equippos == 6 then--戒指
		if not itemdata[6] or itemdata[6].count == 0 then
			return 6
		elseif not itemdata[15] or itemdata[15].count == 0 then
			return 15
		elseif itemdata[6].power < itemdata[15].power then
			return 6
		else
			return 15
		end
	elseif item.equippos == 13 then--特戒
		if not itemdata[13] or itemdata[13].count == 0 then
			return 13
		elseif not itemdata[16] or itemdata[16].count == 0 then
			return 16
		elseif not itemdata[17] or itemdata[17].count == 0 then
			return 17
		elseif itemdata[13].power < itemdata[16].power and
			itemdata[13].power < itemdata[17].power then
			return 13
		elseif itemdata[16].power < itemdata[13].power and
			itemdata[16].power < itemdata[17].power then
			return 16
		else
			return 17
		end
	else
		return item.equippos
	end
end

function DoUseItem(itemid, 是否英雄)
	for k,v in pairs(m_itemdata) do
		if v.id == itemid then
			--if v.id == 10014 or v.id == 10015 then
			--	resetMovePoint()
			--end
			if v.type == 3 then
				消息.CG_EQUIP_ENDUE(v.pos, GetEquipPos(v, 角色UI.m_tabid == 1), 角色UI.m_tabid == 1 and 1 or 0)
			else
				消息.CG_ITEM_USE(v.pos, 1, 是否英雄 and 1 or 0)
			end
			break
		end
	end
end

function update()
	if not m_init then
		return
	end
	local tb = m_itemdata
	if m_tabid ~= 0 then
		tb = {}
		for k,v in pairs(m_itemdata) do
			if v.type == m_tabid then
				tb[#tb+1] = v
			end
		end
	end
	for i=1,ITEMCOUNT do
		local v = tb[(m_curpage-1)*ITEMCOUNT+i]
		if v then
			ui.grids[i].id = v.pos
			ui.gridimgs[i].pic:setTextureFile(全局设置.getItemIconUrl(v.icon))
			ui.gridgrades[i]:setTextureFile(全局设置.getGradeUrl(v.grade))
			ui.gridlocks[i]:setTextureFile(v.bind == 1 and (g_mobileMode and UIPATH.."公用/grid/image_lock.png" or UIPATH.."公用/grid/img_bind.png") or "")
			ui.gridcounts[i]:setText(v.count > 1 and v.count or "")
			ui.gridstrengthens[i]:setText(v.strengthen > 0 and "+"..v.strengthen or "")
			if ui.grids[i] ~= movegrid then
				ui.格子容器:addChild(ui.gridimgs[i])
				ui.gridimgs[i]:setPositionX(ui.grids[i]:getPositionX() + 2)
				ui.gridimgs[i]:setPositionY(ui.grids[i]:getPositionY() + 2)
			end
			if v.cd > rtime() and v.cdmax > 0 then
				local frameid = math.floor((1 - (v.cd - rtime()) / v.cdmax) * 32)
				ui.gridcdimgs[i]:setVisible(true)
				ui.gridcdimgs[i]:setFrameRate(1000*(32-frameid)/(v.cd - rtime()), frameid)
			else
				ui.gridcdimgs[i]:setFrameRate(0)
				ui.gridcdimgs[i]:setVisible(false)
			end
			ui.gridimgs[i].pic:setShaderType(v.gray and F3DImage.SHADER_GRAY or F3DImage.SHADER_NULL)
		else
			ui.grids[i].id = 0
			ui.gridimgs[i].pic:setTextureFile("")
			ui.gridgrades[i]:setTextureFile("")
			ui.gridlocks[i]:setTextureFile("")
			ui.gridcounts[i]:setText("")
			ui.gridstrengthens[i]:setText("")
			ui.gridcdimgs[i]:setFrameRate(0)
			ui.gridcdimgs[i]:setVisible(false)
			ui.gridimgs[i].pic:setShaderType(F3DImage.SHADER_NULL)
		end
	end
	local totalpage = math.ceil(BAG_CAP / ITEMCOUNT)
	--ui.page:setTitleText(m_curpage.." / "..totalpage)
end

function onPagePre(e)
	local totalpage = math.ceil(BAG_CAP / ITEMCOUNT)
	m_curpage = math.max(1, m_curpage - 1)
	update()
	e:stopPropagation()
end

function onPageNext(e)
	local totalpage = math.ceil(BAG_CAP / ITEMCOUNT)
	m_curpage = math.min(totalpage, m_curpage + 1)
	update()
	e:stopPropagation()
end

function onRebuild(e)
	消息.CG_BAG_REBUILD()
	e:stopPropagation()
end

function checkResize()
	if not ui then
		return
	end
	if g_mobileMode then
		if not otherui or not otherui.ui:isVisible() or not otherui.ui:isInited() then
			ui:setPositionX(stage:getWidth()/2-ui:getWidth()/2)
			ui.returncont:setVisible(false)
		else
			otherui.ui:setPositionX(0)
			ui:setPositionX(otherui.ui:getPositionX()+otherui.ui:getWidth())
			uiLayer:removeChild(ui)
			uiLayer:addChild(ui)
			otherui.ui.returncont:setVisible(false)
			ui.returncont:setVisible(true)
		end
	else
		if not otherui or not otherui.ui:isVisible() or not otherui.ui:isInited() then
			ui:setPositionX(stage:getWidth()/2-ui:getWidth()/2)
			ui:setPositionY(stage:getHeight()/2-ui:getHeight()/2)
		else
			otherui.ui:setPositionX(stage:getWidth()/2-ui:getWidth())
			otherui.ui:setPositionY(stage:getHeight()/2-ui:getHeight()/2)
			ui:setPositionX(stage:getWidth()/2)
			ui:setPositionY(stage:getHeight()/2-ui:getHeight()/2)
			uiLayer:removeChild(ui)
			uiLayer:addChild(ui)
		end
	end
end

function onResolve(e)
	--主界面UI.showTipsMsg(1,txt("暂未开放"))
	装备分解UI.initUI()
	商店UI.hideUI()
	仓库UI.hideUI()
	otherui = 装备分解UI
	checkResize()
	e:stopPropagation()
end

function onShop(e)
	--主界面UI.showTipsMsg(1,txt("暂未开放"))
	商店UI.setTalkID(0)
	商店UI.initUI()
	装备分解UI.hideUI()
	仓库UI.hideUI()
	otherui = 商店UI
	checkResize()
	e:stopPropagation()
end

function onStore(e)
	--主界面UI.showTipsMsg(1,txt("暂未开放"))
	消息.CG_STORE_QUERY(0)
	仓库UI.initUI()
	装备分解UI.hideUI()
	商店UI.hideUI()
	otherui = 仓库UI
	checkResize()
	e:stopPropagation()
end

function onGridDown(e)
	if m_tabid ~= 0 then
		return
	end
	local g = e:getCurrentTarget()
	if g == nil or m_itemdata[g.id] == nil or m_itemdata[g.id].id == 0 then
		return
	end
	local p = e:getLocalPos()
	if g then
		local id = g.id-(m_curpage-1)*ITEMCOUNT
		ui.格子容器:removeChild(ui.gridimgs[id])
		ui:addChild(ui.gridimgs[id])
		ui.gridimgs[id]:setPositionX(ui.格子容器:getPositionX() + g:getPositionX() + 2)
		ui.gridimgs[id]:setPositionY(ui.格子容器:getPositionY() + g:getPositionY() + 2)
	end
	ui.griddownpos = {x=p.x,y=p.y}
	movegrid = g
end

function onGridMove(e)
	if ui.griddownpos == nil then
		return
	end
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g then
		local gridsize = ui.grids[2]:getPositionX()-ui.grids[1]:getPositionX()
		local id = g.id-(m_curpage-1)*ITEMCOUNT
		ui.gridimgs[id]:setPositionX(p.x - ui.griddownpos.x + ui.格子容器:getPositionX() + g:getPositionX() + 2)
		ui.gridimgs[id]:setPositionY(p.y - ui.griddownpos.y + ui.格子容器:getPositionY() + g:getPositionY() + 2)
		if p.x < 0 or p.x > g:getWidth() or p.y < 0 or p.y > g:getHeight() then
			m_selectitem = nil
			ui.menutips:setVisible(false)
		end
		if g_mobileMode then
			local px = p.x + ui.格子容器:getPositionX() + g:getPositionX()
			local py = p.y + ui.格子容器:getPositionY() + g:getPositionY()
			if px < 0 or px > ui:getWidth() or py < 0 or py > ui:getHeight()-(g_mobileMode and gridsize or 0) then--105
				px = px + ui:getPositionX()
				py = py + ui:getPositionY()
				local qid = 主界面UI.checkQuickPos(px, py)
				if qid and m_itemdata[g.id].type == 2 then
					ui:setAlpha(0.2)
					主界面UI.updateFightMode(2)
				end
			end
		end
	end
end

function setGridGray(pos, gray)
	if not m_init then
		return
	end
	if not m_itemdata[pos] then
		return
	end
	m_itemdata[pos].gray = gray
	local id = pos-(m_curpage-1)*ITEMCOUNT
	if id < 1 or id > ITEMCOUNT then
		return
	end
	ui.gridimgs[id].pic:setShaderType(gray and F3DImage.SHADER_GRAY or F3DImage.SHADER_NULL)
end

function onGridUp(e)
	if ui.griddownpos == nil then
		return
	end
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g then
		local gridsize = ui.grids[2]:getPositionX()-ui.grids[1]:getPositionX()
		local id = g.id-(m_curpage-1)*ITEMCOUNT
		local ix = math.floor((p.x + g:getPositionX() - 6) / gridsize)--(g_mobileMode and 105 or 38))
		local iy = math.floor((p.y + g:getPositionY() - 6) / gridsize)--(g_mobileMode and 105 or 38))
		if ix >= 0 and ix < 7 and iy >= 0 and iy < (g_mobileMode and 3 or 6) then
			local gid = iy*7+ix+1+(m_curpage-1)*ITEMCOUNT
			if gid ~= g.id then
				消息.CG_BAG_SWAP(g.id, gid)
			else
				ui.格子容器:addChild(ui.gridimgs[id])
				ui.gridimgs[id]:setPositionX(g:getPositionX() + 2)
				ui.gridimgs[id]:setPositionY(g:getPositionY() + 2)
			end
		else
			local px = p.x + ui.格子容器:getPositionX() + g:getPositionX()
			local py = p.y + ui.格子容器:getPositionY() + g:getPositionY()
			if px < 0 or px > ui:getWidth() or py < 0 or py > ui:getHeight()-(g_mobileMode and gridsize or 0) then--105
				px = px + ui:getPositionX()
				py = py + ui:getPositionY()
				local eid = 角色UI.checkEquipPos(px, py)
				if eid and m_itemdata[g.id].type == 3 then
					消息.CG_EQUIP_ENDUE(g.id, eid, 角色UI.m_tabid == 1 and 1 or 0)--m_itemdata[g.id].equippos
				elseif not 装备分解UI.isHided() and 装备分解UI.checkGridContPos(px, py) then
					装备分解UI.pushItemData(m_itemdata[g.id])
					ui.格子容器:addChild(ui.gridimgs[id])
					ui.gridimgs[id]:setPositionX(g:getPositionX() + 2)
					ui.gridimgs[id]:setPositionY(g:getPositionY() + 2)
				elseif not 仓库UI.isHided() and 仓库UI.checkGridContPos(px, py) then
					消息.CG_ITEM_STORE(g.id, 仓库UI.m_vip)
					ui.格子容器:addChild(ui.gridimgs[id])
					ui.gridimgs[id]:setPositionX(g:getPositionX() + 2)
					ui.gridimgs[id]:setPositionY(g:getPositionY() + 2)
				else
					local qid = 主界面UI.checkQuickPos(px, py)
					if qid and m_itemdata[g.id].type == 2 then
						主界面UI.setQuickItem(qid, m_itemdata[g.id].id)
						ui.格子容器:addChild(ui.gridimgs[id])
						ui.gridimgs[id]:setPositionX(g:getPositionX() + 2)
						ui.gridimgs[id]:setPositionY(g:getPositionY() + 2)
					elseif m_itemdata[g.id].bind == 1 then
						m_selectitem = m_itemdata[g.id]
						消息框UI2.hideUI()
						消息框UI3.hideUI()
						消息框UI1.initUI()
						消息框UI1.setData(txt("绑定物品丢弃后会消失，是否丢弃？"),onDiscardOK)
						ui.格子容器:addChild(ui.gridimgs[id])
						ui.gridimgs[id]:setPositionX(g:getPositionX() + 2)
						ui.gridimgs[id]:setPositionY(g:getPositionY() + 2)
					else
						消息.CG_BAG_DISCARD(g.id)
					end
				end
			else
				ui.格子容器:addChild(ui.gridimgs[id])
				ui.gridimgs[id]:setPositionX(g:getPositionX() + 2)
				ui.gridimgs[id]:setPositionY(g:getPositionY() + 2)
			end
		end
	end
	ui.griddownpos = nil
	movegrid = nil
	ui:setAlpha(1)
	主界面UI.updateFightMode()
end

function onGridClick(e)
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g == nil or m_itemdata[g.id] == nil or m_itemdata[g.id].id == 0 then
		m_selectitem = nil
		ui.menutips:setVisible(false)
	else
		m_selectitem = m_itemdata[g.id]
		ui.menutips:setPositionX(p.x + g:getPositionX() + ui.格子容器:getPositionX() + 2)
		ui.menutips:setPositionY(p.y + g:getPositionY() + ui.格子容器:getPositionY() + 2)
		ui.menutips:setVisible(true)
	end
end

function onFuhuaOK(count)
	if m_selectitem then
		消息.CG_EQUIP_ENDUE(m_selectitem.pos, GetEquipPos(m_selectitem, 角色UI.m_tabid == 1), 1)
		m_selectitem = nil
	end
end

function onGridDBClick(e)
	local g = e:getCurrentTarget()
	local p = e:getLocalPos()
	if g == nil or m_itemdata[g.id] == nil or m_itemdata[g.id].id == 0 then
		m_selectitem = nil
		ui.menutips:setVisible(false)
	elseif not 装备分解UI.isHided() then
		装备分解UI.pushItemData(m_itemdata[g.id])
		ui.menutips:setVisible(false)
		hideAllTipsUI()
	elseif not 仓库UI.isHided() then
		消息.CG_ITEM_STORE(g.id, 仓库UI.m_vip)
		ui.menutips:setVisible(false)
		hideAllTipsUI()
	else
		--if m_itemdata[g.id].id == 10014 or m_itemdata[g.id].id == 10015 then
		--	resetMovePoint()
		--end
		if m_itemdata[g.id].type == 3 and m_itemdata[g.id].equippos == 14 then
			if rtime() < m_itemdata[g.id].cd then
				m_selectitem = m_itemdata[g.id]
				消息框UI2.hideUI()
				消息框UI3.hideUI()
				消息框UI1.initUI()
				local mintime = math.ceil((m_itemdata[g.id].cd-rtime())/60000)
				消息框UI1.setData(txt("剩余孵化时间为#cff0000,"..mintime.."分#C，是否花费#cffff00,"..mintime.."元宝#C立即清除？"),onFuhuaOK)
			else
				消息.CG_EQUIP_ENDUE(g.id, GetEquipPos(m_itemdata[g.id], 角色UI.m_tabid == 1), 0)
			end
		elseif m_itemdata[g.id].type == 3 then
			消息.CG_EQUIP_ENDUE(g.id, GetEquipPos(m_itemdata[g.id], 角色UI.m_tabid == 1), 角色UI.m_tabid == 1 and 1 or 0)
		else
			消息.CG_ITEM_USE(g.id, 1, (角色UI.m_tabid == 1 and m_itemdata[g.id].equippos == 11) and 1 or 0)
		end
		ui.menutips:setVisible(false)
		hideAllTipsUI()
	end
end

function hideAllTipsUI()
	物品提示UI.hideUI()
	装备提示UI.hideUI()
	装备对比提示UI.hideUI()
	宠物蛋提示UI.hideUI()
	简单提示UI.hideUI()
end

function onUse(e)
	if m_selectitem then
		if m_selectitem.id == 10014 or m_selectitem.id == 10015 then
			resetMovePoint()
		end
		if m_selectitem.type == 3 and m_selectitem.equippos == 14 then
			if rtime() < m_selectitem.cd then
				消息框UI2.hideUI()
				消息框UI3.hideUI()
				消息框UI1.initUI()
				local mintime = math.ceil((m_selectitem.cd-rtime())/60000)
				消息框UI1.setData(txt("剩余孵化时间为#cff0000,"..mintime.."分#C，是否花费#cffff00,"..mintime.."元宝#C立即孵化？"),onFuhuaOK)
			else
				消息.CG_EQUIP_ENDUE(m_selectitem.pos, GetEquipPos(m_selectitem, 角色UI.m_tabid == 1), 0)
				m_selectitem = nil
			end
		elseif m_selectitem.type == 3 then
			消息.CG_EQUIP_ENDUE(m_selectitem.pos, GetEquipPos(m_selectitem, 角色UI.m_tabid == 1), 角色UI.m_tabid == 1 and 1 or 0)
			m_selectitem = nil
		else
			消息.CG_ITEM_USE(m_selectitem.pos, 1, (角色UI.m_tabid == 1 and m_selectitem.equippos == 11) and 1 or 0)
			m_selectitem = nil
		end
	end
	ui.menutips:setVisible(false)
	ui.use:releaseMouse()
	e:stopPropagation()
end

function onBatchUseOK(count)
	if m_selectitem then
		--if m_selectitem.id == 10014 or m_selectitem.id == 10015 then
		--	resetMovePoint()
		--end
		消息.CG_ITEM_USE(m_selectitem.pos, count, (角色UI.m_tabid == 1 and m_selectitem.equippos == 11) and 1 or 0)
		m_selectitem = nil
	end
end

function onBatchUse(e)
	if m_selectitem then
		消息框UI1.hideUI()
		消息框UI3.hideUI()
		消息框UI2.initUI()
		消息框UI2.setData(2,m_selectitem.count,m_selectitem.count,onBatchUseOK)
	end
	ui.menutips:setVisible(false)
	ui.batchuse:releaseMouse()
	e:stopPropagation()
end

function onDivideOK(count)
	if m_selectitem then
		消息.CG_BAG_DIVIDE(m_selectitem.pos, count)
		m_selectitem = nil
	end
end

function onDivide(e)
	if m_selectitem then
		消息框UI1.hideUI()
		消息框UI3.hideUI()
		消息框UI2.initUI()
		消息框UI2.setData(3,1,m_selectitem.count-1,onDivideOK)
	end
	ui.menutips:setVisible(false)
	ui.divide:releaseMouse()
	e:stopPropagation()
end

function onDiscardOK(count)
	if m_selectitem then
		消息.CG_BAG_DISCARD(m_selectitem.pos)
		m_selectitem = nil
	end
end

function onDiscard(e)
	if m_selectitem and m_selectitem.bind == 1 then
		消息框UI2.hideUI()
		消息框UI3.hideUI()
		消息框UI1.initUI()
		消息框UI1.setData(txt("绑定物品丢弃后会消失，是否丢弃？"),onDiscardOK)
	elseif m_selectitem then
		消息.CG_BAG_DISCARD(m_selectitem.pos)
		m_selectitem = nil
	end
	ui.menutips:setVisible(false)
	ui.discard:releaseMouse()
	e:stopPropagation()
end

function onSellOK(rmb, price)
	if m_selectitem then
		消息.CG_SELL_ITEM(m_selectitem.pos, rmb, price)
		m_selectitem = nil
	end
end

function onSell(e)
	if m_selectitem and m_selectitem.bind == 1 then
		主界面UI.showTipsMsg(1,txt("绑定物品不允许寄售"))
		m_selectitem = nil
	elseif m_selectitem then
		消息框UI1.hideUI()
		消息框UI2.hideUI()
		消息框UI3.initUI()
		消息框UI3.setData(1,100,onSellOK)
	end
	ui.menutips:setVisible(false)
	ui.discard:releaseMouse()
	e:stopPropagation()
end

function onOtherReturn(e)
	if not otherui or not otherui.ui:isVisible() or not otherui.ui:isInited() then
		ui:setPositionX(stage:getWidth()/2-ui:getWidth()/2)
	else
		otherui.ui:setPositionX(0)
		ui:setPositionX(otherui.ui:getPositionX()+otherui.ui:getWidth())
		uiLayer:removeChild(ui)
		uiLayer:addChild(ui)
	end
	if otherui and otherui.m_init then
		otherui.ui.returnui:releaseMouse()
		otherui.ui.returncont:setVisible(false)
	end
	ui.returncont:setVisible(true)
	e:stopPropagation()
end

function onReturn(e)
	if not otherui or not otherui.ui:isVisible() or not otherui.ui:isInited() then
		ui:setPositionX(stage:getWidth()/2-ui:getWidth()/2)
	else
		otherui.ui:setPositionX(stage:getWidth()-ui:getWidth()-otherui.ui:getWidth())
		ui:setPositionX(stage:getWidth()-ui:getWidth())
		uiLayer:removeChild(ui)
		uiLayer:addChild(ui)
	end
	ui.returnui:releaseMouse()
	ui.returncont:setVisible(false)
	if otherui and otherui.m_init then
		otherui.ui.returncont:setVisible(true)
	end
	e:stopPropagation()
end

function onTabChange(e)
	m_tabid = ui.标签栏:getSelectIndex()
	m_selectitem = nil
	ui.menutips:setVisible(false)
	update()
end

function onCDPlayOut(e)
	e:getTarget():setFrameRate(0)
	e:getTarget():setVisible(false)
end

function checkTipsPos()
	if not ui or not tipsgrid then
		return
	end
	if not tipsui or not tipsui:isVisible() or not tipsui:isInited() then
	else
		local x = ui:getPositionX()+ui.格子容器:getPositionX()+tipsgrid:getPositionX()+tipsgrid:getWidth()
		local y = ui:getPositionY()+ui.格子容器:getPositionY()+tipsgrid:getPositionY()
		if not 装备对比提示UI.isHided() and x + tipsui:getWidth() + 装备对比提示UI.ui:getWidth() > stage:getWidth() then
			tipsui:setPositionX(math.max(装备对比提示UI.ui:getWidth(), x - tipsui:getWidth() - tipsgrid:getWidth()))
			if not 装备对比提示UI.isHided() then
				装备对比提示UI.ui:setPositionX(math.max(0,x - tipsui:getWidth() - tipsgrid:getWidth()-tipsui:getWidth()))
			end
		elseif 装备对比提示UI.isHided() and x + tipsui:getWidth() > stage:getWidth() then
			tipsui:setPositionX(x - tipsui:getWidth() - tipsgrid:getWidth())
			if not 装备对比提示UI.isHided() then
				装备对比提示UI.ui:setPositionX(x - tipsui:getWidth() - tipsgrid:getWidth()-tipsui:getWidth())
			end
		elseif not 装备对比提示UI.isHided() then
			tipsui:setPositionX(math.min(stage:getWidth()-装备对比提示UI.ui:getWidth()-tipsui:getWidth(),x))
			if not 装备对比提示UI.isHided() then
				装备对比提示UI.ui:setPositionX(math.min(stage:getWidth()-装备对比提示UI.ui:getWidth(),x+tipsui:getWidth()))
			end
		else
			tipsui:setPositionX(x)
			if not 装备对比提示UI.isHided() then
				装备对比提示UI.ui:setPositionX(x+tipsui:getWidth())
			end
		end
		if y + tipsui:getHeight() > stage:getHeight() then
			tipsui:setPositionY(stage:getHeight() - tipsui:getHeight())
		else
			tipsui:setPositionY(y)
		end
		if not 装备对比提示UI.isHided() then
			if y + 装备对比提示UI.ui:getHeight() > stage:getHeight() then
				装备对比提示UI.ui:setPositionY(stage:getHeight() - 装备对比提示UI.ui:getHeight())
			else
				装备对比提示UI.ui:setPositionY(y)
			end
		end
	end
end

function onGridOver(e)
	local g = g_mobileMode and e:getCurrentTarget() or e:getTarget()
	if g == nil or m_itemdata[g.id] == nil or m_itemdata[g.id].id == 0 then
	elseif g_mobileMode and not 装备分解UI.isHided() then
		装备分解UI.pushItemData(m_itemdata[g.id])
		ui.menutips:setVisible(false)
	elseif g_mobileMode and not 仓库UI.isHided() then
		消息.CG_ITEM_STORE(g.id, 仓库UI.m_vip)
		ui.menutips:setVisible(false)
	elseif F3DUIManager.sTouchComp ~= g then
	--elseif topui() ~= ui and topui() ~= 物品提示UI.ui and topui() ~= 装备提示UI.ui then
	elseif ui.menutips:isVisible() or (not g_mobileMode and movegrid) then
	elseif m_itemdata[g.id].type == 3 and m_itemdata[g.id].equippos == 14 then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		装备对比提示UI.hideUI()
		宠物蛋提示UI.initUI()
		宠物蛋提示UI.setItemData(m_itemdata[g.id], false, true)
		tipsui = 宠物蛋提示UI.ui
		tipsgrid = g
		if not tipsui:isInited() then
			tipsui:addEventListener(F3DObjEvent.OBJ_INITED, func_oe(checkTipsPos))
		else
			checkTipsPos()
		end
	elseif m_itemdata[g.id].type == 3 then
		物品提示UI.hideUI()
		宠物蛋提示UI.hideUI()
		local equippos = GetEquipPos(m_itemdata[g.id], 角色UI.m_tabid == 1)
		local itemdata = 角色UI.m_tabid == 1 and 角色UI.英雄物品数据 or 角色UI.m_itemdata
		if itemdata and itemdata[equippos] and
			itemdata[equippos].id ~= 0 and
			itemdata[equippos].count > 0 then
			装备对比提示UI.initUI()
			装备对比提示UI.setItemData(itemdata[equippos], true)
		else
			装备对比提示UI.hideUI()
		end
		--[[if 角色UI.m_itemdata and 角色UI.m_itemdata[m_itemdata[g.id].equippos] and
			角色UI.m_itemdata[m_itemdata[g.id].equippos].id ~= 0 and
			角色UI.m_itemdata[m_itemdata[g.id].equippos].count > 0 then
			装备对比提示UI.initUI()
			装备对比提示UI.setItemData(角色UI.m_itemdata[m_itemdata[g.id].equippos], true)
		end]]
		装备提示UI.initUI()
		装备提示UI.setItemData(m_itemdata[g.id], false, true)
		tipsui = 装备提示UI.ui
		tipsgrid = g
		if not tipsui:isInited() then
			tipsui:addEventListener(F3DObjEvent.OBJ_INITED, func_oe(checkTipsPos))
		else
			checkTipsPos()
		end
	else
		装备提示UI.hideUI()
		装备对比提示UI.hideUI()
		宠物蛋提示UI.hideUI()
		物品提示UI.initUI()
		物品提示UI.setItemData(m_itemdata[g.id], true)
		tipsui = 物品提示UI.ui
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
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		装备对比提示UI.hideUI()
		宠物蛋提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
end

function onUIInit()
	ui.关闭 = ui:findComponent("标题栏,关闭")
	ui.关闭:addEventListener(F3DMouseEvent.CLICK, func_me(onClose))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onMouseMove))
	ui.griddownpos = nil
	ui.gridimgs = {}
	ui.gridgrades = {}
	ui.gridlocks = {}
	ui.gridcounts = {}
	ui.gridstrengthens = {}
	ui.gridcdimgs = {}
	ui.grids = {}
	ui.格子容器 = ui:findComponent("格子容器")
	ui.格子容器:addEventListener(F3DMouseEvent.CLICK, func_me(function(e)
		m_selectitem = nil
		ui.menutips:setVisible(false)
	end))
	for i=1,ITEMCOUNT do
		local grid = ui:findComponent("格子容器,格子_"..(i-1))
		grid.id = 0
		grid:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onGridDown))
		grid:addEventListener(F3DMouseEvent.MOUSE_MOVE, func_me(onGridMove))
		grid:addEventListener(F3DMouseEvent.MOUSE_UP, func_me(onGridUp))
		grid:addEventListener(F3DMouseEvent.DOUBLE_CLICK, func_me(onGridDBClick))
		grid:addEventListener(F3DMouseEvent.RIGHT_CLICK, func_me(onGridDBClick))
		if g_mobileMode then
			grid:addEventListener(F3DMouseEvent.CLICK, func_me(onGridOver))
		else
			grid:addEventListener(F3DMouseEvent.CLICK, func_me(onGridClick))
			grid:addEventListener(F3DUIEvent.MOUSE_OVER, func_ue(onGridOver))
			grid:addEventListener(F3DUIEvent.MOUSE_OUT, func_ue(onGridOut))
		end
		ui.grids[i] = grid
		local img = F3DImage:new()
		img:setPositionX(grid:getPositionX() + 2)
		img:setPositionY(grid:getPositionY() + 2)
		img:setWidth(grid:getWidth()-4)--34)
		img:setHeight(grid:getHeight()-4)--34)
		ui.格子容器:addChild(img)
		ui.gridimgs[i] = img
		img.pic = F3DImage:new()
		img.pic:setPositionX(math.floor(img:getWidth()/2))
		img.pic:setPositionY(math.floor(img:getHeight()/2))
		img.pic:setPivot(0.5,0.5)
		img:addChild(img.pic)
		local grade = F3DImage:new()
		grade:setPositionX(-1)
		grade:setPositionY(-1)
		grade:setWidth(img:getWidth()+2)--36)
		grade:setHeight(img:getHeight()+2)--36)
		img:addChild(grade)
		ui.gridgrades[i] = grade
		local lock = F3DImage:new()
		lock:setPositionX(g_mobileMode and 6 or 2)--2)
		lock:setPositionY(img:getHeight()-(g_mobileMode and 8 or 2))--23)
		lock:setPivot(0,1)
		img:addChild(lock)
		ui.gridlocks[i] = lock
		local count = F3DTextField:new()
		if g_mobileMode then
			count:setTextFont("宋体",16,false,false,false)
		end
		count:setPositionX(img:getWidth()-(g_mobileMode and 8 or 2))--36)
		count:setPositionY(img:getHeight()-(g_mobileMode and 8 or 2))--36)
		count:setPivot(1,1)
		img:addChild(count)
		ui.gridcounts[i] = count
		local strengthen = F3DTextField:new()
		if g_mobileMode then
			strengthen:setTextFont("宋体",16,false,false,false)
		end
		strengthen:setPositionX(img:getWidth()-(g_mobileMode and 8 or 2))--34)
		strengthen:setPositionY(g_mobileMode and 8 or 2)--2)
		strengthen:setPivot(1,0)
		img:addChild(strengthen)
		ui.gridstrengthens[i] = strengthen
		local cd = F3DComponent:new()
		cd:setBackground(UIPATH.."主界面/cd.png")
		cd:setSizeClips("32,1,0,0")
		cd:setWidth(img:getWidth())--34)
		cd:setHeight(img:getWidth())--34)
		cd:addEventListener(F3DObjEvent.OBJ_PLAYOUT, func_oe(onCDPlayOut))
		cd:setVisible(false)
		img:addChild(cd)
		ui.gridcdimgs[i] = cd
	end
	ui.pagepre = ui:findComponent("格子容器,pagepre")
	ui.pagepre:addEventListener(F3DMouseEvent.CLICK, func_me(onPagePre))
	ui.pagenext = ui:findComponent("格子容器,pagenext")
	ui.pagenext:addEventListener(F3DMouseEvent.CLICK, func_me(onPageNext))
	ui.page = ui:findComponent("格子容器,page")
	ui.rebuild = ui:findComponent("btncont,rebuild")
	ui.rebuild:addEventListener(F3DMouseEvent.CLICK, func_me(onRebuild))
	ui.resolve = ui:findComponent("btncont,resolve")
	ui.resolve:addEventListener(F3DMouseEvent.CLICK, func_me(onResolve))
	ui.shop = ui:findComponent("btncont,shop")
	ui.shop:addEventListener(F3DMouseEvent.CLICK, func_me(onShop))
	ui.store = ui:findComponent("btncont,store")
	ui.store:addEventListener(F3DMouseEvent.CLICK, func_me(onStore))
	ui.bindmoney = ui:findComponent("btncont,bindmoney")
	ui.money = ui:findComponent("btncont,money")
	ui.bindrmb = ui:findComponent("btncont,bindrmb")
	ui.rmb = ui:findComponent("btncont,rmb")
	ui.menutips = ui:findComponent("menutips")
	ui.use = ui:findComponent("menutips,use")
	ui.use:addEventListener(F3DMouseEvent.CLICK, func_me(onUse))
	ui.batchuse = ui:findComponent("menutips,batchuse")
	ui.batchuse:addEventListener(F3DMouseEvent.CLICK, func_me(onBatchUse))
	ui.divide = ui:findComponent("menutips,divide")
	ui.divide:addEventListener(F3DMouseEvent.CLICK, func_me(onDivide))
	ui.discard = ui:findComponent("menutips,discard")
	ui.discard:addEventListener(F3DMouseEvent.CLICK, func_me(onDiscard))
	ui.sell = ui:findComponent("menutips,sell")
	ui.sell:addEventListener(F3DMouseEvent.CLICK, func_me(onSell))
	ui.标签栏 = tt(ui:findComponent("标签栏"), F3DTab)
	ui.标签栏:addEventListener(F3DUIEvent.CHANGE, func_me(onTabChange))
	ui.menutips:setVisible(false)
	if g_mobileMode then
		ui.returncont = ui:findComponent("returncont")
		ui.returnui = ui:findComponent("returncont,return")
		ui.returnui:addEventListener(F3DMouseEvent.CLICK, func_me(onReturn))
		ui.returncont:setVisible(false)
	end
	m_init = true
	update()
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if tipsui then
		物品提示UI.hideUI()
		装备提示UI.hideUI()
		装备对比提示UI.hideUI()
		宠物蛋提示UI.hideUI()
		tipsui = nil
		tipsgrid = nil
	end
	if ui then
		ui:setVisible(false)
	end
	if otherui then
		otherui:hideUI()
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
	ITEMCOUNT = g_mobileMode and 24 or 42
	ui:setLayout(g_mobileMode and UIPATH.."背包UIm.layout" or UIPATH.."背包UI.layout")
end
