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
local 怪物表 = require("配置.怪物表").Config
local 宠物表 = require("配置.宠物表").Config
local 玩家属性表 = require("配置.玩家属性表").Config
实用工具.IncludeClassHeader(...)

CALLMAX = 1

function Init(self)
	self.call = {}
	self.callmax = 1
	self.db = {}
	self.max = 20
	setmetatable(self, _M)
end

function FindIndex(tb, index)
	for k,v in pairs(tb) do
		if v.index == index then
			return k
		end
	end
end

--使用
function AddPet(human, petid, starlevel, grade, wash)
	if human.hp <= 0 then
		return
	end
	local petdb = human.m_db.petdb
	if #petdb.db >= petdb.max then
		return
	end
	local index = #petdb.db > 0 and petdb.db[#petdb.db].index + 1 or 1
	petdb.db[#petdb.db+1] = {
		index = index,
		id = petid,
		level = 1,
		exp = 0,
		starlevel = starlevel or 1,
		starexp = 0,
		grade = grade,-- or 1,
		wash = wash or {},
		cd = 0,
		属性加点 = {},
	}
	宠物逻辑.SendPetInfo(human, {index}, {})
	return index
end

--丢弃
function RemovePet(human, index)
	if human.hp <= 0 then
		return
	end
	local petdb = human.m_db.petdb
	local ind = FindIndex(petdb.db, index)
	if not ind then
		return
	end
	if FindIndex(petdb.call, index) then
		human:SendTipsMsg(1,"出战宠物无法丢弃")
		return
	end
	table.remove(petdb.db, ind)
	宠物逻辑.SendPetInfo(human, {index}, {})
end

--出战
function CallPet(human, index)
	if human.hp <= 0 then
		return
	end
	local petdb = human.m_db.petdb
	local ind = FindIndex(petdb.db, index)
	if not ind then
		return
	end
	local conf = 宠物表[petdb.db[ind].id] or 怪物表[petdb.db[ind].id]
	if not conf then
		return
	end
	local humanconf = 玩家属性表[petdb.db[ind].level]
	if not humanconf then
		return
	end
	if #petdb.call >= CALLMAX then--petdb.callmax
		human:SendTipsMsg(1,"出战列表已满")
		return
	end
	if FindIndex(petdb.call, index) then
		human:SendTipsMsg(1,"该宠物已出战")
		return
	end
	if petdb.db[ind].cd and petdb.db[ind].cd > _CurrentOSTime() then
		human:SendTipsMsg(1,"请等待"..math.ceil((petdb.db[ind].cd-_CurrentOSTime())/1000).."秒后才可出战")
		return
	end
	petdb.call[#petdb.call+1] = {
		index = index,
		merge = 0,
		hp = conf.生命值 + (humanconf["生命值"..conf.职业] or 0),
	}
	human:CallPet(index, petdb.db[ind].id, true)
	宠物逻辑.SendPetInfo(human, {}, {index})
end

--收回
function BackPet(human, index)
	if human.hp <= 0 then
		return
	end
	local petdb = human.m_db.petdb
	local dbind = FindIndex(petdb.db, index)
	if not dbind then
		return
	end
	local ind = FindIndex(petdb.call, index)
	if not ind then
		human:SendTipsMsg(1,"该宠物未出战")
		return
	end
	if petdb.call[ind].merge ~= 0 then
		human:SendTipsMsg(1,"合体宠物无法收回")
		return
	end
	table.remove(petdb.call, ind)
	宠物逻辑.SendPetInfo(human, {}, {index})
	if human.pet[index] then
		petdb.db[dbind].level = human.pet[index].level
		petdb.db[dbind].exp = human.pet[index].exp
		petdb.db[dbind].starlevel = human.pet[index].starlevel
		petdb.db[dbind].starexp = human.pet[index].starexp
		petdb.db[dbind].cd = _CurrentOSTime() + 20000
		human.pet[index]:Destroy()
		human.pet[index] = nil
	end
end

--合体
function MergePet(human, index)
	if human.hp <= 0 then
		return
	end
	local petdb = human.m_db.petdb
	local ind = FindIndex(petdb.call, index)
	if not ind then
		human:SendTipsMsg(1,"该宠物未出战")
		return
	end
	if petdb.call[ind].merge ~= 0 then
		human:SendTipsMsg(1,"该宠物已合体")
		return
	end
	local ind2 = FindIndex(petdb.db, index)
	if not ind2 then
		return
	end
	local conf = 宠物表[petdb.db[ind2].id] or 怪物表[petdb.db[ind2].id]
	if not conf then
		return
	end
	--if not ind2 or 宠物表[petdb.db[ind2].id].type ~= 2 then
	if conf.职业 ~= 1 then
		human:SendTipsMsg(1,"只有战士宠物可合体")
		return
	end
	if not human.pet[index] or human.pet[index].hp == 0 then
		human:SendTipsMsg(1,"宠物已死亡")
		return
	end
	local maxmerge = 0
	for i,v in ipairs(petdb.call) do
		if v.index ~= ind and v.merge > maxmerge then
			maxmerge = v.merge
		end
	end
	petdb.call[ind].merge = maxmerge + 1
	宠物逻辑.SendPetInfo(human, {}, {index})
	human:MergePet(index, true)
end

--解体
function BreakPet(human, index)
	if human.hp <= 0 then
		return
	end
	local petdb = human.m_db.petdb
	local ind = FindIndex(petdb.call, index)
	if not ind then
		human:SendTipsMsg(1,"该宠物未出战")
		return
	end
	if petdb.call[ind].merge == 0 then
		human:SendTipsMsg(1,"该宠物未合体")
		return
	end
	local maxmerge = petdb.call[ind].merge
	for i,v in ipairs(petdb.call) do
		if v.index ~= ind and v.merge > maxmerge then
			v.merge = v.merge - 1
		end
	end
	petdb.call[ind].merge = 0
	宠物逻辑.SendPetInfo(human, {}, {index})
	human:BreakPet(index)
end
