module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 技能表 = require("配置.技能表").Config
local 技能信息表 = require("配置.技能信息表").Config
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local Buff表 = require("配置.Buff表").Config
local 怪物表 = require("配置.怪物表").Config
local 物品表 = require("配置.物品表").Config
local 技能逻辑 = require("技能.技能逻辑")
local 背包逻辑 = require("物品.背包逻辑")
local 背包DB = require("物品.背包DB")
local 拾取物品逻辑 = require("怪物.拾取物品逻辑")
local 物品逻辑 = require("物品.物品逻辑")
local 玩家属性表 = require("配置.玩家属性表").Config

function DoStrengthen(human, cont, pos)
	local bagdb = human.m_db.bagdb
	local baggrids = cont == 1 and bagdb.equips or bagdb.baggrids
	local grid = baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	if conf.type1 ~= 3 then
		return
	end
	if grid.strengthen == 12 then
		human:SendTipsMsg(1,"装备强化等级已满")
		return
	end
	if 背包DB.CheckCount(human, 20014) < 1 then
		human:SendTipsMsg(1,"装备强化石不足")
		return
	end
	背包DB.RemoveCount(human, 20014, 1)
	local fail = false
	if math.random(1,100) > math.ceil(100/((grid.strengthen or 0) + 1)) then
		human:SendTipsMsg(1,"装备强化失败")
		if (grid.strengthen or 0) >= 10 then
			fail = true
		else
			return
		end
	end
	grid.strengthen = (grid.strengthen or 0) + (fail and -1 or 1)
	if cont == 1 then
		human:CalcDynamicAttr()
		背包逻辑.SendEquipQuery(human, {pos})
	else
		背包逻辑.SendBagQuery(human, {pos})
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_STRENGTHEN]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoStrengthenTransfer(human, cont, pos, contposdst, posdst)
	local bagdb = human.m_db.bagdb
	local baggrids = cont == 1 and bagdb.equips or bagdb.baggrids
	local grid = baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	if conf.type1 ~= 3 then
		return
	end
	local baggridsdst = contposdst == 1 and bagdb.equips or bagdb.baggrids
	local griddst = baggridsdst[posdst]
	if griddst == nil or griddst.count == 0 then
		return
	end
	local confdst = 物品表[griddst.id]
	if confdst == nil then
		return
	end
	if confdst.type1 ~= 3 then
		return
	end
	if grid == griddst then
		human:SendTipsMsg(1,"同一装备不能转移")
		return
	end
	if conf.job ~= confdst.job then
		human:SendTipsMsg(1,"装备职业不同无法转移")
		return
	end
	if conf.type2 ~= confdst.type2 then
		human:SendTipsMsg(1,"装备类型不同无法转移")
		return
	end
	if (grid.strengthen or 0) <= (griddst.strengthen or 0) then
		human:SendTipsMsg(1,"原装备强化等级必须大于目标装备")
		return
	end
	if 背包DB.CheckCount(human, 20015) < 1 then
		human:SendTipsMsg(1,"装备转移石不足")
		return
	end
	背包DB.RemoveCount(human, 20015, 1)
	griddst.strengthen = grid.strengthen
	grid.strengthen = nil
	if cont == 1 and contposdst == 1 then
		human:CalcDynamicAttr()
		背包逻辑.SendEquipQuery(human, {pos, posdst})
	elseif cont ~= 1 and contposdst ~= 1 then
		背包逻辑.SendBagQuery(human, {pos, posdst})
	else
		human:CalcDynamicAttr()
		背包逻辑.SendEquipQuery(human, {cont == 1 and pos or posdst})
		背包逻辑.SendBagQuery(human, {cont ~= 1 and pos or posdst})
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_STRENGTHEN_TRANSFER]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoRefineWash(human, cont, pos, lock)
	local bagdb = human.m_db.bagdb
	local baggrids = cont == 1 and bagdb.equips or bagdb.baggrids
	local grid = baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	if conf.type1 ~= 3 then
		return
	end
	local maxcnt = (grid.grade or 1) - 1
	if maxcnt == 0 then
		human:SendTipsMsg(1,"白色品阶装备无法洗练")
		return
	end
	if 背包DB.CheckCount(human, 20012) < 1 then
		human:SendTipsMsg(1,"装备洗练石不足")
		return
	end
	local lockcnt = 0
	for i=1,4 do
		if lock[i] == 1 then
			lockcnt = lockcnt + 1
		end
	end
	if lockcnt > 0 and 背包DB.CheckCount(human, 20082) < lockcnt then
		human:SendTipsMsg(1,"装备洗练锁不足")
		return
	end
	背包DB.RemoveCount(human, 20012, 1)
	背包DB.RemoveCount(human, 20082, lockcnt)
	grid.wash = grid.wash or {}
	local propval = conf.prop[1][1] == 1 and conf.prop[1][2] / 10 or conf.prop[1][1] == 2 and conf.prop[1][2] / 2 or conf.prop[1][2]
	propval = propval * (1 + ((grid.grade or 1) - 1) / 5)
	local keys = {1,2,3,4,5,6,7}
	for i=1,maxcnt do
		grid.wash[i] = grid.wash[i] or {}
		if lock[i] == 1 and grid.wash[i][1] then
			grid.wash[i][2] = math.max(grid.wash[i][2] or 1, math.random(1,grid.wash[i][1] == 1 and propval * 10 or grid.wash[i][1] == 2 and propval * 2 or propval))
			for ii,vv in ipairs(keys) do
				if vv == grid.wash[i][1] then
					table.remove(keys,ii)
					break
				end
			end
		end
	end
	for i=1,maxcnt do
		grid.wash[i] = grid.wash[i] or {}
		if lock[i] == 1 and grid.wash[i][1] then
		else
			local key = math.random(1,#keys)
			grid.wash[i][1] = keys[key]
			table.remove(keys,key)
			grid.wash[i][2] = math.random(1,grid.wash[i][1] == 1 and propval * 10 or grid.wash[i][1] == 2 and propval * 2 or propval)
		end
	end
	if cont == 1 then
		human:CalcDynamicAttr()
		背包逻辑.SendEquipQuery(human, {pos})
	else
		背包逻辑.SendBagQuery(human, {pos})
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_REFINE_WASH]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoRefineUpgrade(human, cont, pos)
	local bagdb = human.m_db.bagdb
	local baggrids = cont == 1 and bagdb.equips or bagdb.baggrids
	local grid = baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	if conf.type1 ~= 3 then
		return
	end
	if grid.grade == 5 then
		human:SendTipsMsg(1,"装备品阶等级已满")
		return
	end
	if 背包DB.CheckCount(human, 20016) < 10 then
		human:SendTipsMsg(1,"装备提品石不足")
		return
	end
	背包DB.RemoveCount(human, 20016, 10)
	grid.grade = (grid.grade or 1) + 1
	if cont == 1 then
		human:CalcDynamicAttr()
		背包逻辑.SendEquipQuery(human, {pos})
	else
		背包逻辑.SendBagQuery(human, {pos})
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_REFINE_UPGRADE]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoPerfectReview(human, cont, pos)
	local bagdb = human.m_db.bagdb
	local baggrids = cont == 1 and bagdb.equips or bagdb.baggrids
	local grid = baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	if conf.type1 ~= 3 then
		return
	end
	local propval = conf.prop[1][1] == 1 and conf.prop[1][2] / 10 or conf.prop[1][1] == 2 and conf.prop[1][2] / 2 or conf.prop[1][2]
	propval = propval * (1 + (5 - 1) / 5)
	local wash = {}
	local keys = {1,2,3,4,5,6,7}
	for i=1,4 do
		wash[i] = {}
		local key = math.random(1,#keys)
		wash[i][1] = keys[key]
		table.remove(keys,key)
		wash[i][2] = wash[i][1] == 1 and propval * 10 or wash[i][1] == 2 and propval * 2 or propval
	end
	local g = {id=grid.id,count=1,bind=1,cd=0,grade=5,strengthen=12,wash=wash}
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_PERFECT_PREVIEW]
	oReturnMsg.itemdataLen = 1
	背包逻辑.PutItemData(oReturnMsg.itemdata[1], 0, g, 0)
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoStrengthenAll(human, cont, pos, contposdst, posdst, contposnxt, posnxt)
	if cont == contposdst and pos == posdst then
		return
	end
	if (cont == 2 or contposdst == 2) and not human.英雄 then
		human:SendTipsMsg(1,"请先召唤英雄")
		return
	end
	local bagdb = human.m_db.bagdb
	local baggrids = cont == 1 and bagdb.equips or cont == 2 and human.m_db.英雄装备 or bagdb.baggrids
	local grid = baggrids[pos]
	if grid == nil or grid.count == 0 then
		return
	end
	local conf = 物品表[grid.id]
	if conf == nil then
		return
	end
	local baggridsdst = contposdst == 1 and bagdb.equips or contposdst == 2 and human.m_db.英雄装备 or bagdb.baggrids
	local griddst = baggridsdst[posdst]
	if griddst == nil or griddst.count == 0 then
		return
	end
	local confdst = 物品表[griddst.id]
	if confdst == nil then
		return
	end
	local baggridsnxt = contposnxt == 1 and bagdb.equips or contposnxt == 2 and human.m_db.英雄装备 or bagdb.baggrids
	local gridnxt = posnxt > 0 and baggridsnxt[posnxt]
	local confnxt = gridnxt and 物品表[gridnxt.id]
	if conf.type1 == 3 and griddst.id == 10145 then
		if conf.type2 ~= 14 and (grid.grade == nil or grid.grade == 1) then
			human:SendTipsMsg(1,"白色品阶装备无法洗练")
			return
		end
		if conf.type2 == 15 then
			human:SendTipsMsg(1,"进阶石无法洗练")
			return
		end
		if conf.type2 == 16 then
			human:SendTipsMsg(1,"聚灵珠无法洗练")
			return
		end
		if conf.type2 == 17 then
			human:SendTipsMsg(1,"图纸无法洗练")
			return
		end
		local wash = nil
		if conf.type2 == 14 then
			grid.wash = 拾取物品逻辑.宠物蛋极品属性(grid.strengthen,grid.grade or 1)
		else
			local 幸运 = 0
			if grid.wash then
				for i,v in ipairs(grid.wash) do
					if v[1] == 公共定义.属性_幸运 then
						幸运 = v[2]
						break
					end
				end
			end
			grid.wash = 拾取物品逻辑.自动极品属性(grid.grade-1,grid.grade-1,conf.job ~= 0 and conf.job or cont == 2 and human.英雄.m_db.job or human.m_db.job)
			if 幸运 > 0 then
				grid.wash[#grid.wash+1] = {公共定义.属性_幸运,幸运}
			end
		end
		human:SendTipsMsg(1,"#cffff00,装备洗练成功")
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and griddst.id == 10147 then
		if conf.type2 == 14 then
			human:SendTipsMsg(1,"宠物蛋无法强化")
			return
		end
		if conf.type2 == 15 then
			human:SendTipsMsg(1,"进阶石无法强化")
			return
		end
		if conf.type2 == 16 then
			human:SendTipsMsg(1,"聚灵珠无法强化")
			return
		end
		if conf.type2 == 17 then
			human:SendTipsMsg(1,"图纸无法强化")
			return
		end
		if grid.strengthen == 12 then
			human:SendTipsMsg(1,"装备强化等级已满")
			return
		end
		grid.strengthen = grid.strengthen or 0
		local strengthen = grid.strengthen
		if grid.strengthen == 0 then
			strengthen = grid.strengthen + 1
		elseif grid.strengthen == 1 then
			if math.random(1,100) <= 50 then
				strengthen = grid.strengthen + 1
			end
		elseif grid.strengthen == 2 then
			if math.random(1,100) <= 50 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 10 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 3 then
			if math.random(1,100) <= 20 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 20 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 4 then
			if math.random(1,100) <= 20 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 30 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 5 then
			if math.random(1,100) <= 10 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 40 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 6 then
			if math.random(1,100) <= 10 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 50 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 7 then
			if math.random(1,100) <= 5 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 60 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 8 then
			if math.random(1,100) <= 5 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 70 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 9 then
			if math.random(1,100) <= 2 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 80 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 10 then
			if math.random(1,100) <= 2 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 90 then
				strengthen = grid.strengthen - 1
			end
		elseif grid.strengthen == 11 then
			if math.random(1,100) <= 1 then
				strengthen = grid.strengthen + 1
			elseif math.random(1,100) <= 100 then
				strengthen = grid.strengthen - 1
			end
		end
		if strengthen > grid.strengthen then
			human:SendTipsMsg(1, "#cff00,恭喜你,装备强化成功")
		elseif strengthen < grid.strengthen then
			human:SendTipsMsg(1, "很遗憾,装备强化失败,强化-1")
		else
			human:SendTipsMsg(1, "装备强化无效")
		end
		grid.strengthen = strengthen
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and griddst.id == 10148 then
		if conf.type2 == 14 then
			human:SendTipsMsg(1,"宠物蛋无法附魔")
			return
		end
		if conf.type2 == 15 then
			human:SendTipsMsg(1,"进阶石无法附魔")
			return
		end
		if conf.type2 == 16 then
			human:SendTipsMsg(1,"聚灵珠无法附魔")
			return
		end
		if conf.type2 == 17 then
			human:SendTipsMsg(1,"图纸无法附魔")
			return
		end
		if conf.job == 0 then
			grid.attach = {math.random(6,10), 3}
		else
			grid.attach = {math.random(1,10), 3}
		end
		if grid.attach[1] == 10 and conf.job == 2 then
			grid.attach[1] = 11
		elseif grid.attach[1] == 10 and conf.job == 3 then
			grid.attach[1] = 12
		end
		human:SendTipsMsg(1,"#cffff00,装备附魔成功")
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and confdst.type1 == 1 and confdst.type2 == 4 then
		if conf.type2 == 14 then
			human:SendTipsMsg(1,"宠物蛋无法镶嵌宝石")
			return
		end
		if conf.type2 == 15 then
			human:SendTipsMsg(1,"进阶石无法镶嵌宝石")
			return
		end
		if conf.type2 == 16 then
			human:SendTipsMsg(1,"聚灵珠无法镶嵌宝石")
			return
		end
		if conf.type2 == 17 then
			human:SendTipsMsg(1,"图纸无法镶嵌宝石")
			return
		end
		if grid.grade == nil or grid.grade == 1 then
			human:SendTipsMsg(1,"白色装备无法镶嵌宝石")
			return
		end
		grid.gem = grid.gem or {}
		local key = nil
		local val = 0
		for i,v in ipairs(grid.gem) do
			if v[1] == confdst.bodyid or (v[1] >= 4 and v[1] <= 6 and confdst.bodyid >= 4 and confdst.bodyid <= 6) then
				key = i
				val = v[1] == confdst.bodyid and v[2] or 0
				break
			end
		end
		if key == nil and #grid.gem >= grid.grade - 1 then
			human:SendTipsMsg(1,"装备镶嵌宝石数量已满")
			return
		end
		local newval = val
		if val <= 0 then
			newval = val + 1
		elseif val == 1 then
			if math.random(1,100) <= 50 then
				newval = val + 1
			end
		elseif val == 2 then
			if math.random(1,100) <= 20 then
				newval = val + 1
			elseif math.random(1,100) <= 20 then
				newval = val - 1
			end
		elseif val == 3 then
			if math.random(1,100) <= 10 then
				newval = val + 1
			elseif math.random(1,100) <= 40 then
				newval = val - 1
			end
		elseif val == 4 then
			if math.random(1,100) <= 5 then
				newval = val + 1
			elseif math.random(1,100) <= 60 then
				newval = val - 1
			end
		elseif val == 5 then
			if math.random(1,100) <= 2 then
				newval = val + 1
			elseif math.random(1,100) <= 80 then
				newval = val - 1
			end
		elseif val == 6 then
			if math.random(1,100) <= 1 then
				newval = val + 1
			elseif math.random(1,100) <= 100 then
				newval = val - 1
			end
		end
		if key == nil then
			grid.gem[#grid.gem+1] = {confdst.bodyid, newval}
		else
			grid.gem[key][2] = newval
		end
		if newval > val then
			human:SendTipsMsg(1, "#cffff00,宝石镶嵌成功")
		elseif newval < val and newval >= 0 then
			human:SendTipsMsg(1, "宝石镶嵌失败,品质降低")
		elseif newval < val and newval < 0 then
			human:SendTipsMsg(1, "宝石镶嵌失败,品质降低")
		else
			human:SendTipsMsg(1, "#cff00,宝石镶嵌无效")
		end
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and conf.type2 == 13 and confdst.type1 == 3 and confdst.type2 == 13 and grid.id ~= griddst.id then
		if (conf.bodyid ~= 0 and conf.effid ~= 0) or (confdst.bodyid ~= 0 and confdst.effid ~= 0) then
			human:SendTipsMsg(1,"已经融合过的特戒无法再融合")
			return
		end
		if conf.bodyid == confdst.bodyid then
			human:SendTipsMsg(1,"同类型的特戒无法融合")
			return
		end
		if (grid.grade or 1) ~= (griddst.grade or 1) then
			human:SendTipsMsg(1,"只有相同品质的特戒可以融合")
			return
		end
		local 融合id = 0
		for i=13116, 13151 do
			local newconf = 物品表[i]
			if newconf and ((newconf.bodyid == conf.bodyid and newconf.effid == confdst.bodyid) or (newconf.effid == conf.bodyid and newconf.bodyid == confdst.bodyid)) then
				融合id = i
				break
			end
		end
		if 融合id == 0 then
			human:SendTipsMsg(1,"找不到可以融合的特戒物品")
			return
		end
		grid.id = 融合id
		human:SendTipsMsg(1,"#cffff00,特戒融合成功")
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and conf.type2 == 13 and confdst.type1 == 3 and confdst.type2 == 14 then
		local grade = griddst.grade or confdst.grade
		if (grid.grade or 1) < grade then
			human:SendTipsMsg(1,"戒灵宠物品质不能高于特戒品质")
			return
		end
		if grade > 0 and (griddst.cd == 0 or griddst.cd > _CurrentOSTime()) then
			human:SendTipsMsg(1,"戒灵宠物必须是可孵化状态")
			return
		end
		if grid.ringsoul == nil then
			grid.ringsoul = {id=griddst.strengthen or confdst.bodyid, grade=math.max(1,grade), level=1, exp=0, starlevel=1, starexp=0, wash=griddst.wash}
		else
			grid.ringsoul.id = griddst.strengthen or confdst.bodyid
			grid.ringsoul.grade = math.max(1,grade)
			grid.ringsoul.wash = griddst.wash
			local exp = grid.ringsoul.exp + 100
			local level = grid.ringsoul.level
			while level > 1 do
				exp = exp + 玩家属性表[level - 1].exp
				level = level - 1
			end
			grid.ringsoul.exp = math.floor(exp * 0.8)
			grid.ringsoul.level = 1
			while 1 do
				local expmax = 玩家属性表[grid.ringsoul.level].exp
				if grid.ringsoul.exp >= expmax then
					grid.ringsoul.exp = grid.ringsoul.exp - expmax
					grid.ringsoul.level = grid.ringsoul.level + 1
				else
					break
				end
			end
			local starexp = grid.ringsoul.starexp + (grade == 5 and 150 or grade == 4 and 100 or grade == 3 and 60 or grade == 2 and 30 or 10)
			local starlevel = grid.ringsoul.starlevel
			while starlevel > 1 do
				starexp = starexp + (starlevel - 1) * 100
				starlevel = starlevel - 1
			end
			grid.ringsoul.starexp = math.floor(starexp * 0.8)
			grid.ringsoul.starlevel = 1
			while 1 do
				local starexpmax = grid.ringsoul.starlevel * 100
				if grid.ringsoul.starexp >= starexpmax then
					grid.ringsoul.starexp = grid.ringsoul.starexp - starexpmax
					grid.ringsoul.starlevel = grid.ringsoul.starlevel + 1
				else
					break
				end
			end
		end
		human:SendTipsMsg(1,"#cffff00,戒灵封印成功")
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and conf.type2 == 13 and griddst.id >= 10149 and griddst.id <= 10163 then
		if grid.ringsoul == nil then
			human:SendTipsMsg(1,"只有封印了戒灵的特戒可以吸收碎片")
			return
		end
		grid.ringsoul.starexp = grid.ringsoul.starexp + 10
		while 1 do
			local starexpmax = grid.ringsoul.starlevel * 100
			if grid.ringsoul.starexp >= starexpmax then
				grid.ringsoul.starexp = grid.ringsoul.starexp - starexpmax
				grid.ringsoul.starlevel = grid.ringsoul.starlevel + 1
			else
				break
			end
		end
		human:SendTipsMsg(1,"#cffff00,戒灵吸收碎片成功")
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and conf.type2 == 17 and (confdst.type1 ~= 3 or confdst.type2 ~= 17) then
		if conf.bodyid == 0 or conf.effid == 0 or conf.upgradeid == 0 then
			human:SendTipsMsg(1,"该图纸无法合成物品")
			return
		end
		if not griddst or (grid.grade or 1) ~= (griddst.grade or 1) then
			human:SendTipsMsg(1,"图纸合成需要放入三个相同品质的物品")
			return
		end
		if not gridnxt or (grid.grade or 1) ~= (gridnxt.grade or 1) then
			human:SendTipsMsg(1,"图纸合成需要放入三个相同品质的物品")
			return
		end
		if griddst.id == conf.bodyid and gridnxt.id == conf.effid then
			griddst.id = conf.upgradeid
		elseif griddst.id == conf.effid and gridnxt.id == conf.bodyid then
			griddst.id = conf.upgradeid
		else
			human:SendTipsMsg(1,"请按图纸要求在下两格放入物品")
			return
		end
		grid.count = grid.count - 1
		griddst.bind = 1
		gridnxt.count = gridnxt.count - 1
		if grid.count == 0 then
			baggrids[pos] = nil
		end
		if gridnxt.count == 0 then
			baggridsnxt[posnxt] = nil
		end
	elseif conf.type1 == 3 and confdst.type1 == 3 and confdst.type2 == 15 then
		if conf.type2 == 14 then
			human:SendTipsMsg(1,"宠物蛋无法进阶")
			return
		end
		if conf.type2 == 16 then
			human:SendTipsMsg(1,"聚灵珠无法进阶")
			return
		end
		if conf.type2 == 17 then
			human:SendTipsMsg(1,"图纸无法进阶")
			return
		end
		if conf.level < 100 or confdst.level < 100 then
			human:SendTipsMsg(1,"只有转生装备可以进阶")
			return
		end
		if conf.type2 == 15 and (grid.id ~= griddst.id or ((grid.grade or 1) ~= (griddst.grade or 1) and (griddst.grade or 1) < 5)) then
			human:SendTipsMsg(1,"只有相同类型品质的进阶石可以进阶")
			return
		end
		if conf.type2 == 15 and (not gridnxt or grid.id ~= gridnxt.id or (grid.grade or 1) ~= (gridnxt.grade or 1)) then
			human:SendTipsMsg(1,"合成需要放入三个相同类型品质的装备")
			return
		end
		if conf.type2 ~= 15 and (conf.level ~= confdst.level or (grid.grade or 1) ~= (griddst.grade or 1)) then
			human:SendTipsMsg(1,"只有相同等级品质的装备可以进阶")
			return
		end
		if conf.type2 == 15 and conf.upgradeid == 0 and grid.grade == 5 then
			human:SendTipsMsg(1,"该进阶石无法进阶")
			return
		end
		if conf.type2 ~= 15 and conf.upgradeid == 0 then
			human:SendTipsMsg(1,"该装备无法进阶")
			return
		end
		local r = 500--math.floor(1000 * math.pow(0.33, grid.grade - griddst.grade + 1))
		if conf.type2 == 15 and (grid.grade or 1) < 5 and (griddst.grade or 1) < 5 then--and math.random(1,1000) <= r then
			human:SendTipsMsg(1,"#cff00,恭喜你,进阶石进阶成功")
			grid.grade = (grid.grade or 1) + 1
		elseif conf.type2 == 15 and conf.upgradeid ~= 0 and (griddst.grade or 1) == 5 then--and math.random(1,1000) <= r then
			human:SendTipsMsg(1,"#cff00,恭喜你,进阶石进阶为高级进阶石")
			grid.id = conf.upgradeid
			--grid.grade = (grid.grade or 1) - 1
		elseif conf.type2 ~= 15 and conf.upgradeid ~= 0 then
			human:SendTipsMsg(1,"#cff00,恭喜你,装备进阶为高级装备")
			grid.id = conf.upgradeid
			grid.grade = (grid.grade or 1)-- - 1
			local 幸运 = 0
			if grid.wash then
				for i,v in ipairs(grid.wash) do
					if v[1] == 公共定义.属性_幸运 then
						幸运 = v[2]
						break
					end
				end
			end
			grid.wash = 拾取物品逻辑.自动极品属性(grid.grade-1,grid.grade-1)
			if 幸运 > 0 then
				grid.wash[#grid.wash+1] = {公共定义.属性_幸运,幸运}
			end
		else
			human:SendTipsMsg(1,"很遗憾,进阶石进阶失败")
		end
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
		if conf.type2 == 15 then
			gridnxt.count = gridnxt.count - 1
			if gridnxt.count == 0 then
				baggridsnxt[posnxt] = nil
			end
		end
	elseif conf.type1 == 3 and confdst.type1 == 3 and not gridnxt and posnxt == 0 then
		if conf.type2 == 14 then
			human:SendTipsMsg(1,"宠物蛋无法继承")
			return
		end
		if conf.type2 == 15 then
			human:SendTipsMsg(1,"进阶石无法继承")
			return
		end
		if conf.type2 == 16 then
			human:SendTipsMsg(1,"聚灵珠无法继承")
			return
		end
		if conf.type2 == 17 then
			human:SendTipsMsg(1,"图纸无法继承")
			return
		end
		if conf.type2 ~= confdst.type2 or (grid.grade or 1) ~= (griddst.grade or 1) then
			human:SendTipsMsg(1,"只有相同类型品质的装备可以继承")
			return
		end
		if conf.level >= confdst.level then
			human:SendTipsMsg(1,"只能继承至更高级装备")
			return
		end
		grid.id = griddst.id
		grid.bind = 1
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	elseif conf.type1 == 3 and confdst.type1 == 3 then
		if (conf.level < 30 or confdst.level < 30) and (conf.type2 ~= 13 or confdst.type2 ~= 13) then
			human:SendTipsMsg(1,"只有30级以上装备或特戒可以合成")
			return
		end
		if grid.id ~= griddst.id or (grid.grade or 1) ~= (griddst.grade or 1) then
			human:SendTipsMsg(1,"只有相同类型品质的装备可以进阶")
			return
		end
		if not gridnxt or grid.id ~= gridnxt.id or (grid.grade or 1) ~= (gridnxt.grade or 1) then
			human:SendTipsMsg(1,"合成需要放入三个相同类型品质的装备")
			return
		end
		if grid.grade == 5 then
			human:SendTipsMsg(1,"已经是最高品质装备不需要进阶")
			return
		end
		local r = 500--math.floor(1000 * math.pow(0.33, grid.grade - griddst.grade + 1))
		if conf.type2 == 17 then
			human:SendTipsMsg(1,"#cff00,恭喜你,图纸进阶成功")
			grid.grade = (grid.grade or 1) + 1
		elseif 1 then--math.random(1,1000) <= r then
			human:SendTipsMsg(1,"#cff00,恭喜你,装备进阶成功")
			grid.grade = (grid.grade or 1) + 1
			local 幸运 = 0
			if grid.wash then
				for i,v in ipairs(grid.wash) do
					if v[1] == 公共定义.属性_幸运 then
						幸运 = v[2]
						break
					end
				end
			end
			grid.wash = 拾取物品逻辑.自动极品属性(grid.grade-1,grid.grade-1)
			if 幸运 > 0 then
				grid.wash[#grid.wash+1] = {公共定义.属性_幸运,幸运}
			end
		else
			human:SendTipsMsg(1,"很遗憾,装备进阶失败")
		end
		grid.bind = 1
		griddst.count = griddst.count - 1
		gridnxt.count = gridnxt.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
		if gridnxt.count == 0 then
			baggridsnxt[posnxt] = nil
		end
	elseif conf.type1 == 1 and conf.type2 == 1 and griddst.id == 10146 then
		if grid.count < 10 then
			human:SendTipsMsg(1,"需要10个碎片才可以合成")
			return
		end
		local grade = 物品逻辑.IsEquip(conf.bodyid) and 1 or 物品逻辑.GetItemGrade(conf.bodyid)
		local wash = 物品逻辑.IsEquip(conf.bodyid) and 拾取物品逻辑.自动极品属性(grade-1,grade-1) or nil
		local indexs = human:PutItemGrids(conf.bodyid, 1, 1, true, grade, nil, wash) or {}
		if #indexs == 0 then
			human:SendTipsMsg(1,"背包不足")
			return
		end
		human:SendTipsMsg(1,"#cffff00,装备合成成功")
		human:SendTipsMsg(2, "获得物品"..广播.colorRgb[grade]..物品逻辑.GetItemName(conf.bodyid))
		背包逻辑.SendBagQuery(human, indexs)
		grid.count = grid.count - 10
		if grid.count == 0 then
			baggrids[pos] = nil
		end
		griddst.count = griddst.count - 1
		if griddst.count == 0 then
			baggridsdst[posdst] = nil
		end
	else
		human:SendTipsMsg(1,"请检查两侧装备是否符合条件")
		return
	end
	if cont == 1 or contposdst == 1 or (griddst and contposnxt == 1) then
		human:CalcDynamicAttr()
		human:SendActualAttr()
		human:ChangeInfo()
	end
	if cont == 2 or contposdst == 2 or (griddst and contposnxt == 2) then
		human.英雄:CalcDynamicAttr()
		human.英雄:SendActualAttr()
		human.英雄:ChangeInfo()
		human:SendEquipView(human.英雄, true)
	end
	local equipindexs = {}
	local bagindexs = {}
	if cont == 1 then
		equipindexs[#equipindexs+1] = pos
	elseif cont == 3 then
		bagindexs[#bagindexs+1] = pos
	end
	if contposdst == 1 then
		equipindexs[#equipindexs+1] = posdst
	elseif contposdst == 3 then
		bagindexs[#bagindexs+1] = posdst
	end
	if griddst then
		if contposnxt == 1 then
			equipindexs[#equipindexs+1] = posnxt
		elseif contposdst == 3 then
			bagindexs[#bagindexs+1] = posnxt
		end
	end
	if #equipindexs > 0 then
		背包逻辑.SendEquipQuery(human, equipindexs)
	end
	if #bagindexs > 0 then
		背包逻辑.SendBagQuery(human, bagindexs)
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_STRENGTHEN_ALL]
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end
