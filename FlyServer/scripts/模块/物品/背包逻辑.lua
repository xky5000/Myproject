module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 日志 = require("公用.日志")
local 日志 = require("公用.日志")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 技能表 = require("配置.技能表").Config
local 技能信息表 = require("配置.技能信息表").Config
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local Buff表 = require("配置.Buff表").Config
local 怪物表 = require("配置.怪物表").Config
local 宠物表 = require("配置.宠物表").Config
local 物品表 = require("配置.物品表").Config
local 技能逻辑 = require("技能.技能逻辑")
local 商城表 = require("配置.商城表").Config
local 物品逻辑 = require("物品.物品逻辑")
local 玩家属性表 = require("配置.玩家属性表").Config
local 背包DB =  require("物品.背包DB")
local 事件触发 = require("触发器.事件触发")
local 行会管理 = require("行会.行会管理")
local 套装表 = require("配置.套装表").Config
local 地图表 = require("配置.地图表").Config

GRID_COUNT_MAX = 1000
EQUIP_POS_MAX = 27

for k,v in pairs(物品表) do
	if v.type1 == 2 then
		v._func = loadstring("return function(human) return " .. v.func .. " end")()
	end
	if v.resolve ~= "" then--v.type1 == 3 then
		v._resolve = loadstring("return function(lv,s,g,w) return {" .. v.resolve .. "} end")()
	end
end

function PutItemData(itemdata, pos, grid, currentTime)
	if grid == nil then
		itemdata.pos = pos
		itemdata.id = 0
		itemdata.name = ""
		itemdata.desc = ""
		itemdata.type = 0
		itemdata.count = 0
		itemdata.icon = 0
		itemdata.cd = 0
		itemdata.cdmax = 0
		itemdata.bind = 0
		itemdata.grade = 0
		itemdata.job = 0
		itemdata.level = 0
		itemdata.strengthen = 0
		itemdata.propLen = 0
		itemdata.addpropLen = 0
		itemdata.attachpropLen = 0
		itemdata.gempropLen = 0
		itemdata.ringsoulLen = 0
		itemdata.power = 0
		itemdata.equippos = 0
		itemdata.color = 0
		itemdata.suitpropLen = 0
		itemdata.suitname = ""
	else
		local conf = 物品表[grid.id]
		itemdata.pos = pos
		itemdata.id = grid.id
		if conf.type1 == 3 and conf.type2 == 14 and (not grid.strengthen or grid.strengthen == 0) then
			grid.strengthen = conf.bodyid
		end
		local monconf = (conf.type1 == 3 and conf.type2 == 14) and (宠物表[grid.strengthen] or 怪物表[grid.strengthen])
		if monconf then
			itemdata.name = conf.name.."("..(monconf and monconf.name or "")..")"
			itemdata.cdmax = (grid.grade or conf.grade) * 3600000
			itemdata.job = monconf and monconf.职业 or conf.job
			itemdata.strengthen = 0
		else
			if grid.cd > 0 and currentTime > grid.cd then
				grid.cd = 0
				grid.cdmax = nil
			end
			if 公共定义.装备提示属性 == 1 and grid.wash and #grid.wash > 0 then
				local cnt = 0
				for i,v in ipairs(grid.wash) do
					cnt = cnt + v[2]
				end
				itemdata.name = conf.name..(cnt > 0 and "+"..cnt or "")
			else
				itemdata.name = conf.name
			end
			itemdata.cdmax = grid.cdmax or conf.cd
			itemdata.job = not Config.IS3G and conf.job or 0
			itemdata.strengthen = grid.strengthen or 0
		end
		itemdata.desc = conf.desc
		itemdata.type = conf.type1
		itemdata.count = grid.count
		itemdata.icon = conf.icon
		itemdata.cd = math.max(0, grid.cd - currentTime)
		--itemdata.cdmax = grid.cdmax or conf.cd
		itemdata.bind = grid.bind
		itemdata.grade = grid.grade or conf.grade
		--itemdata.job = conf.job
		itemdata.level = conf.level
		--itemdata.strengthen = grid.strengthen or 0
		itemdata.propLen = conf.type1 == 3 and #conf.prop or 0
		local power = 0
		local power2 = {}
		local 属性 = {}
		if conf.type1 == 3 and conf.type2 == 14 then
			itemdata.propLen = 1
			itemdata.prop[1].key = 0
			itemdata.prop[1].val = monconf and monconf.bodyid[1] or 0
			itemdata.prop[1].addval = monconf and monconf.effid[1] or 0
		end
		if monconf then
			local wash = {}
			if grid.wash then
				for i,v in ipairs(grid.wash) do
					wash[v[1]] = v[2]
				end
			end
			local humanconf = 玩家属性表[1]
			for i,v in ipairs(公共定义.属性文字) do
				local val = (not wash[i] and monconf[v] or 0) + (humanconf[v..monconf.职业] or 0)
				if val > 0 then
					itemdata.propLen = itemdata.propLen + 1
					itemdata.prop[itemdata.propLen].key = i
					itemdata.prop[itemdata.propLen].val = val
					itemdata.prop[itemdata.propLen].addval = 0
					if i == 1 or i == 2 then
						属性[i] = (itemdata.prop[itemdata.propLen].val + itemdata.prop[itemdata.propLen].addval) / 10
					else
						属性[i] = itemdata.prop[itemdata.propLen].val + itemdata.prop[itemdata.propLen].addval
					end
				end
			end
		elseif conf.type1 == 3 then
			for i,v in ipairs(conf.prop) do
				itemdata.prop[i].key = v[1]
				itemdata.prop[i].val = v[2] * (1 + ((grid.grade or 1) - 1) / 5)
				itemdata.prop[i].addval = ((grid.strengthen and grid.strengthen > 0) and v[2] * grid.strengthen / 10 or 0)-- * (1 + ((grid.grade or 1) - 1) / 5)
				--power = power + (
				--	v[1] == 1 and (itemdata.prop[i].val + itemdata.prop[i].addval) / 10 or
				--	v[1] == 2 and (itemdata.prop[i].val + itemdata.prop[i].addval) / 10 or
				--	itemdata.prop[i].val + itemdata.prop[i].addval)
				if v[1] == 1 or v[1] == 2 then
					属性[v[1]] = (itemdata.prop[i].val + itemdata.prop[i].addval) / 10
				else
					属性[v[1]] = itemdata.prop[i].val + itemdata.prop[i].addval
				end
			end
		end
		if grid.wash then
			--local propval = conf.prop[1][1] == 1 and conf.prop[1][2] / 10 or conf.prop[1][1] == 2 and conf.prop[1][2] / 10 or conf.prop[1][2]
			--propval = propval * (1 + ((grid.grade or 1) - 1) / 5)
			itemdata.addpropLen = #grid.wash
			for i,v in ipairs(grid.wash) do
				itemdata.addprop[i].key = v[1]
				itemdata.addprop[i].val = v[2]
				if monconf then
					itemdata.addprop[i].addval = math.ceil(v[2] * 5 / (monconf[公共定义.属性文字[v[1]]] or 1))
				else
					itemdata.addprop[i].addval = Config.ISWZ and math.ceil(v[2]/10)+1 or Config.ISZY and v[2]+1 or v[2]--math.ceil(v[2] * 5 / (v[1] == 1 and propval * 10 or v[1] == 2 and propval * 2 or propval))
				end
				--power = power + (v[1] == 1 and v[2] / 10 or v[1] == 2 and v[2] / 10 or v[2])
				if v[1] == 1 or v[1] == 2 then
					属性[v[1]] = (属性[v[1]] or 0) + v[2] / 10
				else
					属性[v[1]] = (属性[v[1]] or 0) + v[2]
				end
			end
			for k,v in pairs(power2) do
				power = power + v
			end
		else
			itemdata.addpropLen = 0
		end
		if grid.attach and #grid.attach > 0 then
			itemdata.attachpropLen = 1
			itemdata.attachprop[1].key = grid.attach[1]
			itemdata.attachprop[1].val = grid.attach[2] or 0
			itemdata.attachprop[1].addval = grid.attach[3] or 0
		else
			itemdata.attachpropLen = 0
		end
		for k,v in pairs(属性) do
			--if k == 1 or k == 2 then
			--	power = power + v / 10
			--else
			if k >= 3 or k <= 12 then
				ii = math.ceil(k/2)
				power2[ii] = math.max(power2[ii] or 0, v)
			else
				power = power + v
			end
		end
		for k,v in pairs(power2) do
			power = power + v
		end
		if grid.gem then
			itemdata.gempropLen = #grid.gem
			for i,v in ipairs(grid.gem) do
				itemdata.gemprop[i].key = v[1]
				itemdata.gemprop[i].val = v[2]
				itemdata.gemprop[i].addval = 0
				power = power + v[2]
			end
		else
			itemdata.gempropLen = 0
		end
		if grid.ringsoul then
			local ringsoulconf = 宠物表[grid.ringsoul.id] or 怪物表[grid.ringsoul.id]
			itemdata.ringsoulLen = 1
			itemdata.ringsoul[1].name = ringsoulconf and ringsoulconf.name or ""
			itemdata.ringsoul[1].level = grid.ringsoul.level
			itemdata.ringsoul[1].starlevel = grid.ringsoul.starlevel
			itemdata.ringsoul[1].grade = grid.ringsoul.grade
		else
			itemdata.ringsoulLen = 0
		end
		itemdata.power = power--math.floor(self.hpMax/10+self.atk/2+self.def+self.crit+self.firm+self.hit+self.dodge)
		itemdata.equippos = conf.type2
		itemdata.color = tonumber(conf.color) or 0
		if conf.type1 == 3 then
			for i,v in ipairs(conf.propex) do
				itemdata.propLen = itemdata.propLen + 1
				itemdata.prop[itemdata.propLen].key = v[1]
				itemdata.prop[itemdata.propLen].val = v[2] * (1 + ((grid.grade or 1) - 1) / 5)
				itemdata.prop[itemdata.propLen].addval = ((grid.strengthen and grid.strengthen > 0) and v[2] * grid.strengthen / 10 or 0)
			end
		end
		if conf.suitid ~= 0 and 套装表[conf.suitid] then
			local suitconf = 套装表[conf.suitid]
			itemdata.suitpropLen = #suitconf.prop+1
			itemdata.suitprop[1].key = conf.suitid
			itemdata.suitprop[1].val = suitconf.cnt
			itemdata.suitprop[1].addval = 0
			for i,v in ipairs(suitconf.prop) do
				itemdata.suitprop[i+1].key = v[1]
				itemdata.suitprop[i+1].val = v[2]
				itemdata.suitprop[i+1].addval = 0
			end
			for i,v in ipairs(suitconf.propex) do
				itemdata.suitpropLen = itemdata.suitpropLen + 1
				itemdata.suitprop[itemdata.suitpropLen].key = v[1]
				itemdata.suitprop[itemdata.suitpropLen].val = v[2]
				itemdata.suitprop[itemdata.suitpropLen].addval = 0
			end
			itemdata.suitname = suitconf.name
		else
			itemdata.suitpropLen = 0
			itemdata.suitname = ""
		end
	end
	--实用工具.PrintTable(itemdata, 0, 0)
end

function GetEmptyIndex(human)
	local bagdb = human.m_db.bagdb
	for i=1,bagdb.bagcap do
		if not bagdb.baggrids[i] then
			return i
		end
	end
end

function GetEmptyIndexCount(human)
	local cnt = 0
	local bagdb = human.m_db.bagdb
	for i=1,bagdb.bagcap do
		if not bagdb.baggrids[i] then
			cnt = cnt + 1
		end
	end
	return cnt
end

function SendBagQuery(human, indexs)
	local bagdb = human.m_db.bagdb
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_BAG_LIST]
	oReturnMsg.op = indexs == nil and 0 or 1
	oReturnMsg.itemdataLen = 0
	local currentTime = _CurrentOSTime()
	if indexs then
		for i,pos in ipairs(indexs) do
			oReturnMsg.itemdataLen = oReturnMsg.itemdataLen + 1
			PutItemData(oReturnMsg.itemdata[oReturnMsg.itemdataLen], pos, bagdb.baggrids[pos], currentTime)
		end
	else
		for k,v in pairs(bagdb.baggrids) do
			oReturnMsg.itemdataLen = oReturnMsg.itemdataLen + 1
			PutItemData(oReturnMsg.itemdata[oReturnMsg.itemdataLen], k, v, currentTime)
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendStoreQuery(human, indexs, vip)
	local bagdb = human.m_db.bagdb
	local storegrids
	if vip and vip > 0 then
		storegrids = bagdb.vipstoregrids[vip]
	else
		storegrids = bagdb.storegrids
	end
	if not storegrids then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_STORE_LIST]
	oReturnMsg.op = indexs == nil and 0 or 1
	oReturnMsg.vip = vip or 0
	oReturnMsg.itemdataLen = 0
	local currentTime = _CurrentOSTime()
	if indexs then
		for i,pos in ipairs(indexs) do
			oReturnMsg.itemdataLen = oReturnMsg.itemdataLen + 1
			PutItemData(oReturnMsg.itemdata[oReturnMsg.itemdataLen], pos, storegrids[pos], currentTime)
		end
	else
		for k,v in pairs(storegrids) do
			oReturnMsg.itemdataLen = oReturnMsg.itemdataLen + 1
			PutItemData(oReturnMsg.itemdata[oReturnMsg.itemdataLen], k, v, currentTime)
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SortGrid(g1, g2)
	if g1.id ~= g2.id then
		return g1.id < g2.id
	elseif g1.bind ~= g2.bind then
		return g1.bind > g2.bind
	elseif (g1.grade or 1) ~= (g2.grade or 1) then
		return (g1.grade or 1) > (g2.grade or 1)
	else
		return false
	end
end

function InsertIndexes(indexs, pos)
	for i,v in ipairs(indexs) do
		if v == pos then
			return
		end
	end
	indexs[#indexs+1] = pos
end

function DoBagRebuild(human)
	local bagdb = human.m_db.bagdb
	local tb = {}
	for k,v in pairs(bagdb.baggrids) do
		tb[#tb+1] = v
	end
	if #tb > 1 then
		table.sort(tb, SortGrid)
	end
	i = 1
	while i < #tb do
		if tb[i].id == tb[i+1].id and tb[i].bind == tb[i+1].bind and (tb[i].grade or 1) == (tb[i+1].grade or 1) and 物品表[tb[i].id].type1 ~= 3 then
			if tb[i].count + tb[i+1].count <= GRID_COUNT_MAX then
				tb[i].count = tb[i].count + tb[i+1].count
				table.remove(tb,i+1)
			else
				tb[i+1].count = tb[i].count + tb[i+1].count - GRID_COUNT_MAX
				tb[i].count = GRID_COUNT_MAX
				i = i + 1
			end
		else
			i = i + 1
		end
	end
	local indexs = {}
	for k,v in pairs(bagdb.baggrids) do
		InsertIndexes(indexs, k)
		bagdb.baggrids[k] = nil
	end
	for i,v in ipairs(tb) do
		InsertIndexes(indexs, i)
		bagdb.baggrids[i] = v
	end
	SendBagQuery(human, indexs)
end

function DoStoreRebuild(human, vip)
	local bagdb = human.m_db.bagdb
	local storegrids
	if vip and vip > 0 then
		storegrids = bagdb.vipstoregrids[vip]
	else
		storegrids = bagdb.storegrids
	end
	if not storegrids then
		return
	end
	local tb = {}
	for k,v in pairs(storegrids) do
		tb[#tb+1] = v
	end
	if #tb > 1 then
		table.sort(tb, SortGrid)
	end
	i = 1
	while i < #tb do
		if tb[i].id == tb[i+1].id and tb[i].bind == tb[i+1].bind and (tb[i].grade or 1) == (tb[i+1].grade or 1) and 物品表[tb[i].id].type1 ~= 3 then
			if tb[i].count + tb[i+1].count <= GRID_COUNT_MAX then
				tb[i].count = tb[i].count + tb[i+1].count
				table.remove(tb,i+1)
			else
				tb[i+1].count = tb[i].count + tb[i+1].count - GRID_COUNT_MAX
				tb[i].count = GRID_COUNT_MAX
				i = i + 1
			end
		else
			i = i + 1
		end
	end
	local indexs = {}
	for k,v in pairs(storegrids) do
		InsertIndexes(indexs, k)
		storegrids[k] = nil
	end
	for i,v in ipairs(tb) do
		InsertIndexes(indexs, i)
		storegrids[i] = v
	end
	SendStoreQuery(human, indexs, vip)
end

function DoBagDiscard(human, pos)
	if human.hp <= 0 then
		return
	end
	if human.m_nSceneID == -1 then
		return
	end
	local bagdb = human.m_db.bagdb
	if pos <= 0 or pos > bagdb.bagcap then
		return
	end
	local grid = bagdb.baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	bagdb.baggrids[pos] = nil
	SendBagQuery(human, {pos})
	if grid.bind == 1 then
		return
	end
	local x,y = human:GetPosition()
	local posindex = math.random(2,9)
	local posindexstart = posindex
	local posloop = false
	local itemx, itemy
	while 1 do
		itemx = x+技能逻辑.itemdroppos[posindex][1]*(human.MoveGrid and human.MoveGrid[1] or 50)
		itemy = y+技能逻辑.itemdroppos[posindex][2]*(human.MoveGrid and human.MoveGrid[1] or 50)*(human.Is2DScene and 1/human.MoveGridRate or 1)
		posindex = posindex + 1
		if posindex > 9 then
			posindex = 2
		end
		if posindex == posindexstart then
			posloop = true
		end
		if posloop or human:IsPosWalkable(itemx, itemy) then
			物品对象类:CreateItem(human.m_nSceneID, -1, grid.id, grid.count, posloop and x or itemx, posloop and y or itemy, grid.grade, grid.strengthen, grid.wash, grid.attach, grid.gem, grid.ringsoul)
			break
		end
	end
end

function DoBagSwap(human, pos, posdst)
	local bagdb = human.m_db.bagdb
	if pos == posdst then
		return
	end
	if pos <= 0 or pos > bagdb.bagcap then
		return
	end
	if posdst <= 0 or posdst > bagdb.bagcap then
		return
	end
	local grid = bagdb.baggrids[pos]
	local griddst = bagdb.baggrids[posdst]
	if grid and griddst and grid.id == griddst.id and grid.bind == griddst.bind and (grid.grade or 1) == (griddst.grade or 1) and 物品逻辑.GetItemType1(grid.id) ~= 3 then
		if grid.count + griddst.count <= GRID_COUNT_MAX then
			griddst.count = grid.count + griddst.count
			bagdb.baggrids[pos] = nil
		else
			grid.count = grid.count + griddst.count - GRID_COUNT_MAX
			griddst.count = GRID_COUNT_MAX
		end
	else
		bagdb.baggrids[pos] = griddst
		bagdb.baggrids[posdst] = grid
	end
	SendBagQuery(human, {pos, posdst})
end

function DoBagDivide(human, pos, count)
	local bagdb = human.m_db.bagdb
	if pos <= 0 or pos > bagdb.bagcap then
		return
	end
	if count < 1 or count > GRID_COUNT_MAX then
		return
	end
	local grid = bagdb.baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then--or conf.type1 == 3 then
		return
	end
	if count >= grid.count then
		return
	end
	local indexs = human:PutItemGrids(grid.id, count, grid.bind) or {}
	if #indexs == 0 then
		return
	end
	grid.count = grid.count - count
	indexs[#indexs+1] = pos
	SendBagQuery(human, indexs)
end

function DoItemUse(human, pos, count, hero)
	if not human.hp or human.hp <= 0 then
		return
	end
	if hero == 1 and not human.英雄 then
		return
	end
	if hero == 1 and human.英雄.hp <= 0 then
		return
	end
	local bagdb = human.m_db.bagdb
	if pos <= 0 or pos > bagdb.bagcap then
		return
	end
	if count < 1 or count > GRID_COUNT_MAX then
		return
	end
	local grid = bagdb.baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	if hero == 1 then
		if conf.job ~= 0 and conf.job ~= human.m_db.英雄职业 then
			human:SendTipsMsg(1,"英雄职业不符")
			return
		end
		if conf.sex ~= 0 and conf.sex ~= human.m_db.英雄性别 then
			human:SendTipsMsg(1,"英雄性别不符")
			return
		end
		if conf.level > human.m_db.英雄等级 then
			human:SendTipsMsg(1,"英雄等级不足")
			return
		end
	else
		if conf.job ~= 0 and conf.job ~= human.m_db.job then
			human:SendTipsMsg(1,"职业不符")
			return
		end
		if conf.sex ~= 0 and conf.sex ~= human.m_db.sex then
			human:SendTipsMsg(1,"性别不符")
			return
		end
		if conf.level > human.m_db.level then
			human:SendTipsMsg(1,"等级不足")
			return
		end
	end
	if conf.type1 ~= 2 then
		human:SendTipsMsg(1,"该物品无法使用")
		return
	end
	local mapid = 场景管理.SceneId2ConfigMapId[human.m_nSceneID]
	local mapConfig = 地图表[mapid]
	if mapConfig and 实用工具.FindIndex(mapConfig.banitem, grid.id) then
		human:SendTipsMsg(1,"该物品禁止在该地图使用")
		return
	end
	if #conf.daycnt > 0 then
		local cnt = 0
		for i,v in ipairs(conf.daycnt) do
			if human.m_db.vip等级 >= v[1] then
				cnt = v[2]
			end
		end
		local usecnt = human.m_db.每日使用次数[grid.id] or 0
		if usecnt >= cnt then
			human:SendTipsMsg(1,"该物品每日使用次数达到上限")
			return
		end
		count = math.min(cnt - usecnt, count)
		human.m_db.每日使用次数[grid.id] = usecnt + count
	end
	local currentTime = _CurrentOSTime()
	local cd = 0
	local indexs = {pos}
	local posnew = nil
	for i=1,count do
		local ret = false
		if grid.count > 0 and grid.cd < currentTime then
			local call = 事件触发._M["call_物品使用_"..grid.id]
			if call then
				human:显示对话(-2,call(human))
				ret = true
			else
				_1,_2,_3,_4 = conf._func(hero == 1 and human.英雄 or human)
				ret = _1 or _2 or _3 or _4
			end
		end
		if ret then
			grid.count = grid.count - 1
			if conf.cd > 0 then
				grid.cd = currentTime + conf.cd
				grid.cdmax = nil
				cd = grid.cd
			end
		else
			break
		end
	end
	if grid.count == 0 then
		bagdb.baggrids[pos] = nil
	end
	if cd ~= 0 then
		for k,v in pairs(bagdb.baggrids) do
			local cf = 物品表[v.id]
			if k ~= pos and cf.type1 == conf.type1 and cf.type2 == conf.type2 then
				v.cd = cd
				v.cdmax = conf.cd
				indexs[#indexs+1] = k
			end
		end
	end
	SendBagQuery(human, indexs)
end

function DoItemStore(human, pos, vip)
	if human.hp <= 0 then
		return
	end
	local bagdb = human.m_db.bagdb
	local storegrids
	local storecap
	if vip and vip > 0 then
		storegrids = bagdb.vipstoregrids[vip]
		storecap = bagdb.vipstorecap
	else
		storegrids = bagdb.storegrids
		storecap = bagdb.storecap
	end
	if not storegrids then
		return
	end
	if pos <= 0 or pos > bagdb.bagcap then
		return
	end
	local grid = bagdb.baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	local newpos = nil
	for i=1,storecap do
		if storegrids[i] == nil or storegrids[i].count == 0 then
			newpos = i
			break
		end
	end
	if newpos == nil then
		human:SendTipsMsg(1,"仓库空间不足")
		return
	end
	storegrids[newpos] = grid
	bagdb.baggrids[pos] = nil
	SendStoreQuery(human, {newpos}, vip)
	SendBagQuery(human, {pos})
end

function DoStoreFetch(human, pos, vip)
	if human.hp <= 0 then
		return
	end
	local bagdb = human.m_db.bagdb
	local storegrids
	local storecap
	if vip and vip > 0 then
		storegrids = bagdb.vipstoregrids[vip]
		storecap = bagdb.vipstorecap
	else
		storegrids = bagdb.storegrids
		storecap = bagdb.storecap
	end
	if not storegrids then
		return
	end
	if pos <= 0 or pos > storecap then
		return
	end
	local grid = storegrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	local newpos = nil
	for i=1,bagdb.bagcap do
		if bagdb.baggrids[i] == nil or bagdb.baggrids[i].count == 0 then
			newpos = i
			break
		end
	end
	if newpos == nil then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	storegrids[pos] = nil
	bagdb.baggrids[newpos] = grid
	SendStoreQuery(human, {pos}, vip)
	SendBagQuery(human, {newpos})
end

function DoStoreFetchAll(human)
	if human.hp <= 0 then
		return
	end
	local bagdb = human.m_db.bagdb
	local storegrids
	local storecap
	if vip and vip > 0 then
		storegrids = bagdb.vipstoregrids[vip]
		storecap = bagdb.vipstorecap
	else
		storegrids = bagdb.storegrids
		storecap = bagdb.storecap
	end
	if not storegrids then
		return
	end
	local indexs = {}
	local bagindexs = {}
	for i=1,bagdb.bagcap do
		if bagdb.baggrids[i] == nil or bagdb.baggrids[i].count == 0 then
			bagindexs[#bagindexs+1] = i
		end
	end
	local newindexs = {}
	for i=1,storecap do
		if storegrids[i] and storegrids[i].id > 0 and storegrids[i].count > 0 then
			if #bagindexs > 0 then
				bagdb.baggrids[bagindexs[1]] = storegrids[i]
				indexs[#indexs+1] = bagindexs[1]
				table.remove(bagindexs, 1)
				newindexs[#newindexs+1] = i
				storegrids[i] = nil
			else
				break
			end
		end
	end
	if #newindexs > 0 then
		SendStoreQuery(human, newindexs, vip)
	end
	if #indexs > 0 then
		SendBagQuery(human, indexs)
	end
end

function SendEquipQuery(human, indexs)
	local bagdb = human.m_db.bagdb
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_EQUIP_LIST]
	oReturnMsg.op = indexs == nil and 0 or 1
	oReturnMsg.itemdataLen = 0
	if indexs then
		for i,pos in ipairs(indexs) do
			oReturnMsg.itemdataLen = oReturnMsg.itemdataLen + 1
			PutItemData(oReturnMsg.itemdata[oReturnMsg.itemdataLen], pos, bagdb.equips[pos], 0)
		end
	else
		for k,v in pairs(bagdb.equips) do
			oReturnMsg.itemdataLen = oReturnMsg.itemdataLen + 1
			PutItemData(oReturnMsg.itemdata[oReturnMsg.itemdataLen], k, v, 0)
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoEquipEndue(human, pos, equippos, hero)
	if human.hp <= 0 then
		return
	end
	if hero == 1 and not human.英雄 then
		return
	end
	local bagdb = human.m_db.bagdb
	if pos <= 0 or pos > bagdb.bagcap then
		return
	end
	local grid = bagdb.baggrids[pos]
	if grid == nil or grid.count ~= 1 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	if conf.type1 ~= 3 then
		human:SendTipsMsg(1,"该物品无法穿戴")
		return
	end
	if conf.type2 == 15 then
		human:SendTipsMsg(1,"该物品无法使用")
		return
	end
	if conf.type2 == 17 then
		human:SendTipsMsg(1,"该物品无法使用")
		return
	end
	if hero == 1 and conf.type2 ~= 14 then
		if not Config.IS3G and conf.job ~= 0 and conf.job ~= human.英雄.m_db.job then
			human:SendTipsMsg(1,"职业不符")
			return
		end
		if not Config.IS3G and conf.sex ~= 0 and conf.sex ~= human.英雄.m_db.sex then
			human:SendTipsMsg(1,"性别不符")
			return
		end
		if conf.level >= 100 and human.m_db.英雄转生等级 < math.floor(conf.level/100) then
			human:SendTipsMsg(1,"转生等级不足")
			return
		end
		if conf.level < 100 and conf.level > human.英雄.m_db.level then
			human:SendTipsMsg(1,"等级不足")
			return
		end
	else
		if not Config.IS3G and conf.job ~= 0 and conf.job ~= human.m_db.job then
			human:SendTipsMsg(1,"职业不符")
			return
		end
		if not Config.IS3G and conf.sex ~= 0 and conf.sex ~= human.m_db.sex then
			human:SendTipsMsg(1,"性别不符")
			return
		end
		if conf.level >= 100 and human.m_db.转生等级 < math.floor(conf.level/100) then
			human:SendTipsMsg(1,"转生等级不足")
			return
		end
		if conf.level < 100 and conf.level > human.m_db.level then
			human:SendTipsMsg(1,"等级不足")
			return
		end
	end
	if conf.type2 == 16 then
		if grid.bind == 1 then
			human:SendTipsMsg(1,"经验值未满无法使用")
			return
		end
		if not human.英雄 then
			human:SendTipsMsg(1,"英雄不在线无法使用")
			return
		end
		if #conf.daycnt > 0 then
			local cnt = 0
			for i,v in ipairs(conf.daycnt) do
				if human.m_db.vip等级 >= v[1] then
					cnt = v[2]
				end
			end
			local usecnt = human.m_db.每日使用次数[grid.id] or 0
			if usecnt >= cnt then
				human:SendTipsMsg(1,"该物品每日使用次数达到上限")
				return
			end
			human.m_db.每日使用次数[grid.id] = usecnt + 1
		end
		local addexp = (grid.wash and grid.wash[1]) and grid.wash[1][2] or 1
		if human:AddExp(addexp) then
			human:SendTipsMsg(2, "获得经验#cff00,"..addexp)
		end
		if human.英雄 and human.英雄:AddExp(addexp) then
			human:SendTipsMsg(2, "英雄获得经验#cff00,"..addexp)
		end
		human:SendTipsMsg(1,"#cff00,成功使用聚灵珠")
		bagdb.baggrids[pos] = nil
		SendBagQuery(human, {pos})
		return
	elseif conf.type2 == 14 then
		local currentTime = _CurrentOSTime()
		if not grid.strengthen or grid.strengthen == 0 then
			grid.strengthen = conf.bodyid
		end
		if (grid.grade or conf.grade) == 0 then
			local wash = {}
			if grid.wash then
				for i,v in ipairs(grid.wash) do
					wash[v[1]] = v[2]
				end
			end
			if human:AddPet(grid.strengthen, 1, grid.grade, wash) then
				human:SendTipsMsg(1,"#cff00,孵化成功,请打开宠物界面查看")
				bagdb.baggrids[pos] = nil
				SendBagQuery(human, {pos})
			else
				human:SendTipsMsg(1,"孵化失败,请检查宠物列表是否已满")
			end
		elseif grid.cd == 0 then
			human:SendTipsMsg(1,"#cffff00,宠物蛋开始孵化,请耐心等待")
			grid.cd = currentTime + (grid.grade or conf.grade) * 3600000
			grid.bind = 1
			SendBagQuery(human, {pos})
		elseif grid.cd > currentTime and hero == 1 then
			local rmb = math.ceil((grid.cd - currentTime)/60000)
			if rmb > human.m_db.rmb then
				human:SendTipsMsg(1,"元宝不足")
			else
				human:DecRmb(rmb, false)
				grid.cd = currentTime
				SendBagQuery(human, {pos})
				human:SendTipsMsg(1,"#cff00,孵化时间成功清除")
			end
		elseif grid.cd > currentTime then
			human:SendTipsMsg(1,"宠物蛋正在孵化,请耐心等待")
		else
			local wash = {}
			if grid.wash then
				for i,v in ipairs(grid.wash) do
					wash[v[1]] = v[2]
				end
			end
			if human:AddPet(grid.strengthen, 1, grid.grade, wash) then
				human:SendTipsMsg(1,"#cff00,孵化成功,请打开宠物界面查看")
				bagdb.baggrids[pos] = nil
				SendBagQuery(human, {pos})
			else
				human:SendTipsMsg(1,"孵化失败,请检查宠物列表是否已满")
			end
		end
		return
	end
	if conf.type2 == 5 and (equippos == 5 or equippos == 14) then--手镯
	elseif conf.type2 == 6 and (equippos == 6 or equippos == 15) then--戒指
	elseif conf.type2 == 13 and (equippos == 13 or equippos == 16 or equippos == 17) then--特戒
	else
		equippos = conf.type2
	end
	local indexs = {pos}
	local posnew = nil
	bagdb.baggrids[pos] = nil
	posnew = human:PutEquip(equippos, grid.id, grid.grade, grid.strengthen, grid.wash, grid.attach, grid.gem, grid.ringsoul, hero == 1, grid.bind)
	if posnew ~= nil then
		if hero == 1 then
			human:SendEquipView(human.英雄, true)
		else
			SendEquipQuery(human, {equippos})
		end
	else
		bagdb.baggrids[pos] = grid
	end
	if posnew ~= nil and posnew ~= 0 then
		--indexs[#indexs+1] = posnew
		InsertIndexes(indexs, posnew)
	end
	SendBagQuery(human, indexs)
end

function DoEquipUnfix(human, pos, hero)
	if human.hp <= 0 then
		return
	end
	if hero == 1 and not human.英雄 then
		return
	end
	local posnew = human:PutEquip(pos, 0, nil, nil, nil, nil, nil, nil, hero == 1)
	if posnew == nil or posnew == 0 then
		return
	end
	if hero == 1 then
		human:SendEquipView(human.英雄, true)
	else
		SendEquipQuery(human, {pos})
	end
	SendBagQuery(human, {posnew})
end

function SendQuickQuery(human)
	local bagdb = human.m_db.bagdb
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_QUICK_LIST]
	oReturnMsg.idLen = 6
	for i=1,6 do
		if bagdb.quicks[i] then
			oReturnMsg.id[i] = bagdb.quicks[i]
		else
			oReturnMsg.id[i] = 0
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoQuickSetup(human, id)
	local bagdb = human.m_db.bagdb
	for i=1,6 do
		bagdb.quicks[i] = id[i]
	end
	SendQuickQuery(human)
end

function DoBuyItem(human, type, id, count)
	if id == 0 or count <= 0 then
		return
	end
	local 物品 = nil
	for i,v in ipairs(商城表) do
		if (v.type == type or (type > 0 and v.talkid == type)) and v.itemid == id then
			物品 = v
			break
		end
	end
	if not 物品 then
		human:SendTipsMsg(1,"找不到指定商品")
		return
	end
	if 物品.price == 0 then
		human:SendTipsMsg(1,"该物品无法购买")
		return
	end
	if #物品.limit > 2 and 物品.limit[3] > 0 then
		local guild = human.m_db.guildname ~= "" and 行会管理.GuildList[human.m_db.guildname]
		if not guild or guild.level < 物品.limit[3] then
			human:SendTipsMsg(1,"行会等级不足")
			return
		end
	end
	if #物品.limit > 1 and human.m_db.vip等级 < 物品.limit[2] then
		human:SendTipsMsg(1,"VIP等级不足")
		return
	end
	if #物品.limit > 0 and (human.m_db.日限商品购买[id] or 0) + count > 物品.limit[1] then
		human:SendTipsMsg(1,"每日购买次数达到上限")
		return
	end
	if 物品.type == 0 and 物品.price * count > human.m_db.rmb then
		human:SendTipsMsg(1,"元宝不足")
		return
	end
	if 物品.type == 1 and 物品.price * count > human.m_db.bindrmb then
		human:SendTipsMsg(1,"绑定元宝不足")
		return
	end
	if 物品.type == 2 and 物品.price * count > human.m_db.money then
		human:SendTipsMsg(1,"金币不足")
		return
	end
	if 物品.type == 3 and 物品.price * count > human.m_db.bindmoney then
		human:SendTipsMsg(1,"绑定金币不足")
		return
	end
	if 物品.type == 5 and 物品.price * count > 0 then
		local guild = human.m_db.guildname ~= "" and 行会管理.GuildList[human.m_db.guildname]
		if not guild or not guild.member[human:GetName()] or guild.member[human:GetName()][2] < 物品.price * count then
			human:SendTipsMsg(1,"行会贡献不足")
			return
		end
	end
	if 物品.type > 10000 and 物品.price * count > 背包DB.CheckCount(human, 物品.type) then
		human:SendTipsMsg(1,"材料物品不足")
		return
	end
	if 物品.type == 6 and 物品.price * count > human.m_db.战魂值 then
		human:SendTipsMsg(1,"战魂点数不足")
		return
	end
	if 物品.type == 7 and 物品.price * count > human.m_db.神石结晶 then
		human:SendTipsMsg(1,"神石结晶不足")
		return
	end
	if 物品.type == 8 and 物品.price * count > human.m_db.魂珠碎片 then
		human:SendTipsMsg(1,"魂珠碎片不足")
		return
	end
	if 物品.type == 9 and 物品.price * count > human.m_db.灵韵值 then
		human:SendTipsMsg(1,"灵韵值不足")
		return
	end
	local bagdb = human.m_db.bagdb
	local cnt = 0
	if 物品.type == 4 then
		for k,v in pairs(bagdb.baggrids) do
			for ii,vv in ipairs(物品.材料) do
				if v.id == vv then
					cnt = cnt + v.count
					break
				end
			end
		end
		if 物品.price * count > cnt then
			human:SendTipsMsg(1,"#s16,材料不足, 当前拥有: #cff00,"..cnt)
			return
		end
	end
	local conf = 物品表[id]
	local addcount = count
	if conf and conf.usecnt > 1 then
		addcount = conf.usecnt*count
	end
	local indexs = human:PutItemGrids(物品.itemid, addcount, 1, true) or {}
	if #indexs == 0 then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	if 物品.type == 0 then
		human:DecRmb(物品.price * count, false)
	elseif 物品.type == 1 then
		human:DecRmb(物品.price * count, true)
	elseif 物品.type == 2 then
		human:DecMoney(物品.price * count, false)
	elseif 物品.type == 3 then
		human:DecMoney(物品.price * count, true)
	elseif 物品.type == 5 and 物品.price * count > 0 then
		local guild = human.m_db.guildname ~= "" and 行会管理.GuildList[human.m_db.guildname]
		if guild and guild.member[human:GetName()] then
			guild.member[human:GetName()][2] = math.max(0, guild.member[human:GetName()][2] - 物品.price * count)
			guild:Save()
		end
	elseif 物品.type > 10000 then
		背包DB.RemoveCount(human, 物品.type, 物品.price * count)
	elseif 物品.type == 6 then
		human.m_db.战魂值 = human.m_db.战魂值 - 物品.price * count
	elseif 物品.type == 7 then
		human.m_db.神石结晶 = human.m_db.神石结晶 - 物品.price * count
	elseif 物品.type == 8 then
		human.m_db.魂珠碎片 = human.m_db.魂珠碎片 - 物品.price * count
	elseif 物品.type == 9 then
		human.m_db.灵韵值 = human.m_db.灵韵值 - 物品.price * count
	elseif 物品.type == 4 then
		cnt = 物品.price * count
		for k,v in pairs(bagdb.baggrids) do
			for ii,vv in ipairs(物品.材料) do
				if v.id == vv then
					indexs[#indexs+1] = k
					if v.count >= cnt then
						v.count = v.count - cnt
						cnt = 0
					else
						cnt = cnt - v.count
						v.count = 0
					end
					if v.count == 0 then
						bagdb.baggrids[k] = nil
					end
					break
				end
			end
			if cnt == 0 then
				break
			end
		end
	end
	SendBagQuery(human, indexs)
	if #物品.limit > 0 and 物品.limit[1] > 0 then
		human.m_db.日限商品购买[id] = (human.m_db.日限商品购买[id] or 0) + count
	end
	human:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品.grade]..物品.name..(count > 1 and "x"..count or ""))
	human:AddQuickItem(物品.itemid)
	human:SendTipsMsg(0,"购买成功")
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_ITEM_BUY]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
	if 物品.type == 0 or 物品.type == 1 then
		local call = 事件触发._M["call_商城购买"]
		if call then
			human.私人变量.S0 = 物品.name
			human.私人变量.M0 = 物品.price * count
			human:显示对话(-2,call(human))
		end
	end
end

function DoQueryItem(human, id, query)
	if 物品表[id] == nil then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_ITEM_QUERY]
	oReturnMsg.query = query
	local g = {id=id,count=1,bind=0,cd=0,grade=((query==3 and 物品逻辑.IsEquip(id)) and 5 or nil)}
	oReturnMsg.itemdataLen = 1
	PutItemData(oReturnMsg.itemdata[1], 0, g, 0)
	消息类.SendMsg(oReturnMsg, human.id)
end

function PushResolveGrids(grids, itemid, count, bind)
	for i,v in ipairs(grids) do
		if v.id == itemid and v.bind == bind then
			if itemid == 公共定义.金币物品ID or itemid == 公共定义.元宝物品ID or itemid == 公共定义.经验物品ID then
				v.count = v.count + count
				return
			elseif v.count + count <= GRID_COUNT_MAX then
				v.count = v.count + count
				return
			else
				count = count - (GRID_COUNT_MAX - v.count)
				v.count = GRID_COUNT_MAX
				break
			end
		end
	end
	grids[#grids+1]={id=itemid,count=count,bind=bind,cd=0}
end

function DoQueryResolveItem(human, pos)
	local bagdb = human.m_db.bagdb
	local gs = {}
	for i,v in ipairs(pos) do
		if v <= 0 or v > bagdb.bagcap then
			break
		end
		local grid = bagdb.baggrids[v]
		if grid == nil or grid.count == 0 then
			break
		end
		local conf = 物品表[grid.id]
		if conf == nil then
			break
		end
		if conf.type1 ~= 3 then
			--break
		end
		if conf._resolve then
			local rg = conf._resolve(conf.level,grid.strengthen or 0,grid.grade or 1,(grid.wash and #grid.wash > 0) and 1 or 0)
			for ii,vv in ipairs(rg) do
				if vv[2] > 0 then
					PushResolveGrids(gs, vv[1], vv[2] * grid.count, vv[1] == 公共定义.经验物品ID and 0 or 公共定义.物品获得绑定)--grid.bind)
				end
			end
		end
	end
	if #gs > 1 then
		table.sort(gs, SortGrid)
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_ITEM_RESOLVE_QUERY]
	oReturnMsg.itemdataLen = #gs
	for i,v in ipairs(gs) do
		PutItemData(oReturnMsg.itemdata[i], 0, v, 0)
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoResolveItem(human, pos)
	local bagdb = human.m_db.bagdb
	local gs = {}
	local rindexs = {}
	for i,v in ipairs(pos) do
		if v <= 0 or v > bagdb.bagcap then
			break
		end
		local grid = bagdb.baggrids[v]
		if grid == nil or grid.count == 0 then
			break
		end
		local conf = 物品表[grid.id]
		if conf == nil then
			break
		end
		if conf.type1 ~= 3 then
			--break
		end
		if conf._resolve then
			rindexs[#rindexs+1] = v
			local rg = conf._resolve(conf.level,grid.strengthen or 0,grid.grade or 1,(grid.wash and #grid.wash > 0) and 1 or 0)
			for ii,vv in ipairs(rg) do
				if vv[2] > 0 then
					PushResolveGrids(gs, vv[1], vv[2] * grid.count, vv[1] == 公共定义.经验物品ID and 0 or 公共定义.物品获得绑定)--grid.bind)
				end
			end
		end
	end
	local cnt = #gs
	for i,v in ipairs(gs) do
		if v == 公共定义.金币物品ID or v == 公共定义.元宝物品ID or v == 公共定义.经验物品ID then
			cnt = cnt - 1
		end
	end
	local bagcnt = 0
	for k,v in pairs(bagdb.baggrids) do
		if v.id ~= 0 and v.count > 0 then
			bagcnt = bagcnt + 1
		end
	end
	if bagdb.bagcap - bagcnt + #rindexs < cnt then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	for i,v in ipairs(rindexs) do
		bagdb.baggrids[v] = nil
	end
	for i,v in ipairs(gs) do
		local indexs = human:PutItemGrids(v.id, v.count, v.bind, true)
		if v.id == 公共定义.经验物品ID then
			human:SendTipsMsg(2, "分解获得经验#cffff00,"..v.count)
		elseif v.id == 公共定义.金币物品ID then
			human:SendTipsMsg(2, "分解获得"..(v.bind == 1 and "绑定金币" or "金币").."#cffff00,"..v.count)
		elseif v.id == 公共定义.元宝物品ID then
			human:SendTipsMsg(2, "分解获得"..(v.bind == 1 and "绑定元宝" or "元宝").."#cffff00,"..v.count)
		else
			human:SendTipsMsg(2, "分解获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(v.id)]..物品逻辑.GetItemName(v.id)..(v.count > 1 and "x"..v.count or ""))
		end
		if indexs then
			for ii,vv in ipairs(indexs) do
				InsertIndexes(rindexs, vv)
			end
		end
	end
	SendBagQuery(human, rindexs)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_ITEM_RESOLVE]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end
