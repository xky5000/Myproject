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
local 宠物逻辑 = require("宠物.宠物逻辑")
local 宠物表 = require("配置.宠物表").Config
local 背包逻辑 = require("物品.背包逻辑")
local 物品表 = require("配置.物品表").Config
实用工具.IncludeClassHeader(...)

function Init(self)
	self.baggrids = {}
	self.bagcap = 48
	self.storegrids = {}
	self.storecap = 48
	self.vipstoregrids = {}
	self.vipstorecap = 48
	self.equips = {}
 	self.quicks = {}
	setmetatable(self, _M)
end

function PutEquip(human, pos, id, grade, strengthen, wash, attach, gem, ringsoul, ishero, isbind)
	local conf = 物品表[id]
	if id ~= 0 and (conf == nil or conf.type1 ~= 3) then
		return
	end
	local bagdb = ishero and human.英雄.m_db.bagdb or human.m_db.bagdb
	local posnew = 0
	if pos < 1 or pos > 背包逻辑.EQUIP_POS_MAX then
		return
	end
	if bagdb.equips[pos] then
		local indexs = PutItemGrids(human, bagdb.equips[pos].id, bagdb.equips[pos].count, bagdb.equips[pos].bind, false, bagdb.equips[pos].grade, bagdb.equips[pos].strengthen, bagdb.equips[pos].wash, bagdb.equips[pos].attach, bagdb.equips[pos].gem, bagdb.equips[pos].ringsoul) or {}
		if #indexs < 1 then
			return
		end
		posnew = indexs[1]
		human.takeoffid = bagdb.equips[pos].id
	end
	if id ~= 0 then
		bagdb.equips[pos] = {id=id,count=1,bind=isbind==1 and 1 or 公共定义.装备穿戴绑定,cd=0,grade=grade,strengthen=strengthen,wash=wash,attach=attach,gem=gem,ringsoul=ringsoul}
	else
		bagdb.equips[pos] = nil
	end
	if ishero then
		if pos == 1 or pos == 2 or pos == 11 or pos == 23 or pos == 27 then
			human.英雄:ChangeBody()
		end
		human.英雄:CalcDynamicAttr()
		human.英雄:SendActualAttr()
		human.英雄:ChangeInfo()
	else
		if pos == 1 or pos == 2 or pos == 11 or pos == 23 or pos == 27 then
			human:ChangeBody()
		end
		human:CalcDynamicAttr()
		human:SendActualAttr()
		human:ChangeInfo()
	end
	if pos == 1 or pos == 2 then
		human:CheckXPSkill()
	end
	return posnew
end

function PutItemGrids(human, id, count, bind, merge, grade, strengthen, wash, attach, gem, ringsoul)
	if count <= 0 then
		return
	end
	local conf = 物品表[id]
	if conf == nil then
		return
	end
	local bagdb = human.m_db.bagdb
	local indexs = {}
	if merge and conf.type1 ~= 3 then
		for k,v in pairs(bagdb.baggrids) do
			if v.id == id and v.bind == bind and (v.grade or 1) == (grade or 1) then
				if v.count + count <= 背包逻辑.GRID_COUNT_MAX then
					v.count = v.count + count
					indexs[#indexs+1] = k
					count = 0
					break
				elseif v.count < 背包逻辑.GRID_COUNT_MAX then
					count = v.count + count - 背包逻辑.GRID_COUNT_MAX
					v.count = 背包逻辑.GRID_COUNT_MAX
					indexs[#indexs+1] = k
				end
			end
		end
	end
	if count > 0 then
		for i=1,bagdb.bagcap do
			if not bagdb.baggrids[i] then
				if conf.type1 ~= 3 and count <= 背包逻辑.GRID_COUNT_MAX then
					bagdb.baggrids[i] = {id=id,count=count,bind=bind,cd=0,grade=grade,strengthen=strengthen,wash=wash,attach=attach,gem=gem,ringsoul=ringsoul}
					indexs[#indexs+1] = i
					count = 0
				elseif conf.type1 ~= 3 then
					count = count - 背包逻辑.GRID_COUNT_MAX
					bagdb.baggrids[i] = {id=id,count=背包逻辑.GRID_COUNT_MAX,bind=bind,cd=0,grade=grade,strengthen=strengthen,wash=wash,attach=attach,gem=gem,ringsoul=ringsoul}
					indexs[#indexs+1] = i
				else
					count = count - 1
					bagdb.baggrids[i] = {id=id,count=1,bind=bind,cd=0,grade=grade,strengthen=strengthen,wash=wash,attach=attach,gem=gem,ringsoul=ringsoul}
					indexs[#indexs+1] = i
				end
				if count == 0 then
					break
				end
			end
		end
	end
	return indexs
end

function FindItemIndex(human, itemid, bind)
	if itemid == 0 then
		return
	end
	local bagdb = human.m_db.bagdb
	for k,v in pairs(bagdb.baggrids) do
		if v.id == itemid and (not bind or v.bind == bind) then
			return k
		end
	end
end

function CheckCount(human, itemid)
	if itemid == 0 then
		return 0
	end
	local bagdb = human.m_db.bagdb
	local cnt = 0
	for k,v in pairs(bagdb.baggrids) do
		if v.id == itemid then
			cnt = cnt + v.count
		end
	end
	return cnt
end

function RemoveCount(human, itemid, cnt)
	if itemid == 0 or cnt <= 0 then
		return
	end
	local bagdb = human.m_db.bagdb
	local indexs = {}
	for k,v in pairs(bagdb.baggrids) do
		if v.id == itemid then
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
			if cnt == 0 then
				break
			end
		end
	end
	背包逻辑.SendBagQuery(human, indexs)
end
