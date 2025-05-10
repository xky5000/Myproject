module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 技能表 = require("配置.技能表").Config
local 技能信息表 = require("配置.技能信息表").Config
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local Buff表 = require("配置.Buff表").Config
local 怪物表 = require("配置.怪物表").Config
local 宠物表 = require("配置.宠物表").Config
local 宠物逻辑 = require("宠物.宠物逻辑")
local Buff逻辑 = require("技能.Buff逻辑")
local 聊天逻辑 = require("聊天.聊天逻辑")
local 背包DB = require("物品.背包DB")
local 背包逻辑 = require("物品.背包逻辑")
local 物品逻辑 = require("物品.物品逻辑")
local 地图表 = require("配置.地图表").Config
local 拾取物品逻辑 = require("怪物.拾取物品逻辑")
local 事件触发 = require("触发器.事件触发")
local 行会管理 = require("行会.行会管理")
local 城堡管理 = require("行会.城堡管理")

for k,v in pairs(技能信息表) do
	v._costlevel = loadstring("return function(lv) return " .. v.costlevel .. " end")()
	v._costitem = loadstring("return function(lv) return " .. v.costitem .. " end")()
end

if Config.IS3G then
	ATTACH_SKILLS = {
		[1105]=1,
		[1106]=2,
		[1107]=3,
		[1108]=4,
		[1109]=5,
		[1205]=1,
		[1206]=2,
		[1207]=3,
		[1208]=4,
		[1209]=5,
		[1305]=1,
		[1306]=2,
		[1307]=3,
		[1308]=4,
		[1309]=5,
		[1405]=1,
		[1406]=2,
		[1407]=3,
		[1408]=4,
		[1409]=5,
		[1505]=1,
		[1506]=2,
		[1507]=3,
		[1508]=4,
		[1509]=5,
		[1605]=1,
		[1606]=2,
		[1607]=3,
		[1608]=4,
		[1609]=5,
		[1705]=1,
		[1706]=2,
		[1707]=3,
		[1708]=4,
		[1709]=5,
	}
else
	ATTACH_SKILLS = {
		[1106]=1,
		[1115]=2,
		[1124]=3,
		[1132]=4,
		[1126]=5,
		[1109]=1,
		[1107]=2,
		[1121]=3,
		[1128]=4,
		[1127]=5,
		[1111]=1,
		[1102]=2,
		[1116]=3,
		[1104]=4,
		[1131]=5,
	}
end

itemdroppos = {
	{0,0},
	{-1,0},{-1,-1},{0,-1},{1,-1},{1,0},{1,1},{0,1},{-1,1},
	{-2,0},{-2,-1},{-2,-2},{-1,-2},{0,-2},{1,-2},{2,-2},{2,-1},{2,0},{2,1},{2,2},{1,2},{0,2},{-1,2},{-2,2},{-2,1},
	{-3,0},{-3,-1},{-3,-2},{-3,-3},{-2,-3},{-1,-3},{0,-3},{1,-3},{2,-3},{3,-3},{3,-2},{3,-1},{3,0},{3,1},{3,2},{3,3},{2,3},{1,3},{0,3},{-1,3},{-2,3},{-3,3},{-3,2},{-3,1},
	{-4,0},{-4,-1},{-4,-2},{-4,-3},{-4,-4},{-3,-4},{-2,-4},{-1,-4},{0,-4},{1,-4},{2,-4},{3,-4},{4,-4},{4,-3},{4,-2},{4,-1},{4,0},{4,1},{4,2},{4,3},{4,4},{3,4},{2,4},{1,4},{0,4},{-1,4},{-2,4},{-3,4},{-4,4},{-4,3},{-4,2},{-4,1},
	{-5,0},{-5,-1},{-5,-2},{-5,-3},{-5,-4},{-5,-5},{-4,-5},{-3,-5},{-2,-5},{-1,-5},{0,-5},{1,-5},{2,-5},{3,-5},{4,-5},{5,-5},{5,-4},{5,-3},{5,-2},{5,-1},{5,0},{5,1},{5,2},{5,3},{5,4},{5,5},{4,5},{3,5},{2,5},{1,5},{0,5},{-1,5},{-2,5},{-3,5},{-4,5},{-5,5},{-5,4},{-5,3},{-5,2},{-5,1},
}

--obj 玩家, atker 攻击对象, damage1 伤害系数 , damage2 , job 职业
function CalcDamage(obj, atker, damage1, damage2, job)
	if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atker:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		if atker:GetAttr(公共定义.额外属性_秒杀) > 0 then
			return obj.hpMax, 0
		end
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and obj:GetLevel() < 公共定义.新手无敌等级 then
		return 0, 0
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj:GetType() == 4 then
		return 0, 0
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		if obj:GetAttr(公共定义.额外属性_无敌) > 0 then
			return 0, 0
		end
		local 防御 = obj:GetAttr(公共定义.额外属性_防御)
		if 防御 > 0 and math.random(1,100) <= 防御 then
			return 0, 0
		end
	end
	local 值 = 0
	if job == 2 or (job == 0 and atker:获取职业() == 2) then
		local 魔法躲避 = obj:获取魔法躲避()
		local 魔法命中 = atker:获取魔法命中()
		if 魔法躲避 > 魔法命中 and math.random(1,100) <= 魔法躲避 - 魔法命中 then
			return 0, 0
		end
		local 魔御 = 实用工具.GetRandomVal(obj:获取魔御(), obj:获取魔御上限())
		if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
			local 忽视防御 = obj:GetAttr(公共定义.额外属性_忽视防御)
			if 忽视防御 > 0 then
				魔御 = 魔御*(1-忽视防御/100)
			end
		end
		--local 魔御 = obj:获取魔御()
		--魔御 = 实用工具.GetRandomVal(魔御, math.max(魔御, obj:获取魔御上限()))
		local 幸运 = atker:获取幸运()
		local 魔法 = atker:获取魔法()
		local 魔法上限 = math.max(魔法, atker:获取魔法上限())
		local 魔攻 = 0
		if 幸运 > 0 then
			local 魔法下限 = 魔法 + math.floor((魔法上限 - 魔法) * 幸运 / 9)
			魔攻 = 实用工具.GetRandomVal(魔法下限, 魔法上限)
		elseif 幸运 < 0 then
			local 魔法下限 = 魔法上限 - math.floor((魔法上限 - 魔法) * 幸运 / 10)
			魔攻 = 实用工具.GetRandomVal(魔法, 魔法下限)
		else
			魔攻 = 实用工具.GetRandomVal(魔法, 魔法上限)
		end
		值 = 魔攻 * (damage1 / 100) + damage2 - 魔御
	elseif job == 3 or (job == 0 and atker:获取职业() == 3) then
		local 魔法躲避 = obj:获取魔法躲避()
		local 魔法命中 = atker:获取魔法命中()
		if 魔法躲避 > 魔法命中 and math.random(1,100) <= 魔法躲避 - 魔法命中 then
			return 0, 0
		end
		local 魔御 = 实用工具.GetRandomVal(obj:获取魔御(), obj:获取魔御上限())
		if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
			local 忽视防御 = obj:GetAttr(公共定义.额外属性_忽视防御)
			if 忽视防御 > 0 then
				魔御 = 魔御*(1-忽视防御/100)
			end
		end
		--local 魔御 = obj:获取魔御()
		--魔御 = 实用工具.GetRandomVal(魔御, math.max(魔御, obj:获取魔御上限()))
		local 幸运 = atker:获取幸运()
		local 道术 = atker:获取道术()
		local 道术上限 = math.max(道术, atker:获取道术上限())
		local 魔攻 = 0
		if 幸运 > 0 then
			local 道术下限 = 道术 + math.floor((道术上限 - 道术) * 幸运 / 9)
			魔攻 = 实用工具.GetRandomVal(道术下限, 道术上限)
		elseif 幸运 < 0 then
			local 道术下限 = 道术上限 - math.floor((道术上限 - 道术) * 幸运 / 10)
			魔攻 = 实用工具.GetRandomVal(道术, 道术下限)
		else
			魔攻 = 实用工具.GetRandomVal(道术, 道术上限)
		end
		值 = 魔攻 * (damage1 / 100) + damage2 - 魔御
	else
		--战士玩法
		local 敏捷 = obj:获取敏捷()
		local 准确 = atker:获取准确()
		if 敏捷 > 准确 and math.random(1,100) <= 敏捷 - 准确 then
			return 0, 0
		end
		local 防御 = 实用工具.GetRandomVal(obj:获取防御(), obj:获取防御上限())
		if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
			local 忽视防御 = obj:GetAttr(公共定义.额外属性_忽视防御)
			if 忽视防御 > 0 then
				防御 = 防御*(1-忽视防御/100)
			end
		end
		--local 防御 = obj:获取防御()
		--防御 = 实用工具.GetRandomVal(防御, math.max(防御, obj:获取防御上限()))
		local 幸运 = atker:获取幸运()
		local 攻击 = atker:获取攻击()
		local 攻击上限 = math.max(攻击, atker:获取攻击上限())
		local 物攻 = 0
		if 幸运 > 0 then
			local 攻击下限 = 攻击 + math.floor((攻击上限 - 攻击) * 幸运 / 9)
			物攻 = 实用工具.GetRandomVal(攻击下限, 攻击上限)
		elseif 幸运 < 0 then
			local 攻击下限 = 攻击上限 - math.floor((攻击上限 - 攻击) * 幸运 / 10)
			物攻 = 实用工具.GetRandomVal(攻击, 攻击下限)
		else
			物攻 = 实用工具.GetRandomVal(攻击, 攻击上限)
		end
		值 = 物攻 * (damage1 / 100) + damage2 - 防御
	end
	if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and atker.攻击倍数 then
		值 = math.ceil(值 * atker.攻击倍数)
	end
	if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atker:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		值 = math.ceil(值 * (1+atker:GetAttr(公共定义.额外属性_攻击加成)/100))
		值 = 值 + atker:GetAttr(公共定义.额外属性_真实伤害)
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		值 = math.max(1, 值 - obj:GetAttr(公共定义.额外属性_伤害抵挡))
		值 = math.max(1, math.ceil(值 * (1-obj:GetAttr(公共定义.额外属性_抵抗)/100)))
		
		if atker:获取职业() == 1 then
			值 = math.max(1, math.ceil(值 * (1-obj:GetAttr(公共定义.额外属性_物理抵挡)/100)))
		else
			值 = math.max(1, math.ceil(值 * (1-obj:GetAttr(公共定义.额外属性_魔法抵挡)/100)))
		end
	end
	if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atker:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		local 暴击 = atker:GetAttr(公共定义.额外属性_暴击)
		if 暴击 > 0 and math.random(1,100) <= 暴击 then
			return math.max(1, 值*1.5), 1
		end
	end
	return math.max(1, 值), 0
end

function CalcDamage3G(obj, atker, damage1, damage2, normal)
	if obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj:GetType() == 4 then
		return 0, 0
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		local 防御 = obj:GetAttr(公共定义.额外属性_防御)
		if 防御 > 0 and math.random(1,100) <= 防御 then
			return 0, 0
		end
	end
	local 值 = 0
	if normal then
		local 敏捷 = obj:获取敏捷()
		local 准确 = atker:获取准确()
		if 敏捷 > 准确 and math.random(1,100) <= 敏捷 - 准确 then
			return 0, 0
		end
		local 防御 = 实用工具.GetRandomVal(obj:获取防御(), obj:获取防御上限())
		if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
			local 忽视防御 = obj:GetAttr(公共定义.额外属性_忽视防御)
			if 忽视防御 > 0 then
				防御 = 防御*(1-忽视防御/100)
			end
		end
		--local 防御 = obj:获取防御()
		--防御 = 实用工具.GetRandomVal(防御, math.max(防御, obj:获取防御上限()))
		local 幸运 = atker:获取幸运()
		local 攻击 = atker:获取攻击()
		local 攻击上限 = math.max(攻击, atker:获取攻击上限())
		local 物攻 = 0
		if 幸运 > 0 then
			local 攻击下限 = 攻击 + math.floor((攻击上限 - 攻击) * 幸运 / 9)
			物攻 = 实用工具.GetRandomVal(攻击下限, 攻击上限)
		elseif 幸运 < 0 then
			local 攻击下限 = 攻击上限 - math.floor((攻击上限 - 攻击) * 幸运 / 10)
			物攻 = 实用工具.GetRandomVal(攻击, 攻击下限)
		else
			物攻 = 实用工具.GetRandomVal(攻击, 攻击上限)
		end
		值 = 物攻 * (damage1 / 100) + damage2 - 防御
		local 道术 = atker:获取道术()
		local 道术上限 = math.max(道术, atker:获取道术上限())
		值 = 值 + 实用工具.GetRandomVal(道术, 道术上限)
	else
		local 魔法躲避 = obj:获取魔法躲避()
		local 魔法命中 = atker:获取魔法命中()
		if 魔法躲避 > 魔法命中 and math.random(1,100) <= 魔法躲避 - 魔法命中 then
			return 0, 0
		end
		local 魔御 = 实用工具.GetRandomVal(obj:获取魔御(), obj:获取魔御上限())
		if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
			local 忽视防御 = obj:GetAttr(公共定义.额外属性_忽视防御)
			if 忽视防御 > 0 then
				魔御 = 魔御*(1-忽视防御/100)
			end
		end
		--local 魔御 = obj:获取魔御()
		--魔御 = 实用工具.GetRandomVal(魔御, math.max(魔御, obj:获取魔御上限()))
		local 幸运 = atker:获取幸运()
		local 魔法 = atker:获取魔法()
		local 魔法上限 = math.max(魔法, atker:获取魔法上限())
		local 魔攻 = 0
		if 幸运 > 0 then
			local 魔法下限 = 魔法 + math.floor((魔法上限 - 魔法) * 幸运 / 9)
			魔攻 = 实用工具.GetRandomVal(魔法下限, 魔法上限)
		elseif 幸运 < 0 then
			local 魔法下限 = 魔法上限 - math.floor((魔法上限 - 魔法) * 幸运 / 10)
			魔攻 = 实用工具.GetRandomVal(魔法, 魔法下限)
		else
			魔攻 = 实用工具.GetRandomVal(魔法, 魔法上限)
		end
		值 = 魔攻 * (damage1 / 100) + damage2 - 魔御
		local 道术 = atker:获取道术()
		local 道术上限 = math.max(道术, atker:获取道术上限())
		值 = 值 + 实用工具.GetRandomVal(道术, 道术上限)
	end
	if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atker:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		值 = math.ceil(值 * (1+atker:GetAttr(公共定义.额外属性_攻击加成)/100))
		值 = 值 + atker:GetAttr(公共定义.额外属性_真实伤害)
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		值 = math.max(1, 值 - obj:GetAttr(公共定义.额外属性_伤害抵挡))
		值 = math.max(1, math.ceil(值 * (1-obj:GetAttr(公共定义.额外属性_抵抗)/100)))
	end
	if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atker:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		local 暴击 = atker:GetAttr(公共定义.额外属性_暴击)
		if 暴击 > 0 and math.random(1,100) <= 暴击 then
			return math.max(1, 值*1.5), 1
		end
	end
	return math.max(1, 值), 0
end

function CheckObjDead(obj, atker, damage)
	local deadeff = 0
	if obj == nil or atker == nil then
		return deadeff
	end
	if obj.hp == 0 then
		if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
			local ownerid = atker.id
			local owner = atker
			if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
				ownerid = atker.ownerid
				owner = 对象类:GetObj(ownerid)
				while owner.ownerid ~= -1 do
					ownerid = owner.ownerid
					owner = 对象类:GetObj(ownerid)
				end
			end
			if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				local mapid = 场景管理.SceneId2ConfigMapId[obj.m_nSceneID]
				local mapConfig = 地图表[mapid]
				if mapConfig and (mapConfig.deaddrop == 0 or mapConfig.deaddrop == 1) then
					local indexs = {}
					local x,y = obj:GetPosition()
					local posindex = math.random(2,9)
					local posindexstart = posindex
					local posloop = false
					local itemx, itemy
					for k,v in pairs(obj.m_db.bagdb.baggrids) do
						if v.count > 0 and v.bind ~= 1 and math.random(1,1000) <= obj.m_db.PK值+50 then
							while 1 do
								itemx = x+itemdroppos[posindex][1]*(obj.MoveGrid and obj.MoveGrid[1] or 50)
								itemy = y+itemdroppos[posindex][2]*(obj.MoveGrid and obj.MoveGrid[1] or 50)*(obj.Is2DScene and 1/obj.MoveGridRate or 1)
								posindex = posindex + 1
								if posindex > 9 then
									posindex = 2
								end
								if posindex == posindexstart then
									posloop = true
								end
								if posloop or obj:IsPosWalkable(itemx, itemy) then
									物品对象类:CreateItem(obj.m_nSceneID, -1, v.id, v.count, posloop and x or itemx, posloop and y or itemy, v.grade, v.strengthen, v.wash, v.attach, v.gem, v.ringsoul)
									break
								end
							end
							obj.m_db.bagdb.baggrids[k] = nil
							indexs[#indexs+1] = k
						end
					end
					if #indexs > 0 then
						背包逻辑.SendBagQuery(obj, indexs)
					end
				end
				if mapConfig and (mapConfig.deaddrop == 0 or mapConfig.deaddrop == 2) and 公共定义.装备穿戴绑定 == 0 then
					local indexs = {}
					local x,y = obj:GetPosition()
					local posindex = math.random(2,9)
					local posindexstart = posindex
					local posloop = false
					local itemx, itemy
					for k,v in pairs(obj.m_db.bagdb.equips) do
						if v.count > 0 and v.bind ~= 1 and math.random(1,1000) <= obj.m_db.PK值+50 then
							while 1 do
								itemx = x+itemdroppos[posindex][1]*(obj.MoveGrid and obj.MoveGrid[1] or 50)
								itemy = y+itemdroppos[posindex][2]*(obj.MoveGrid and obj.MoveGrid[1] or 50)*(obj.Is2DScene and 1/obj.MoveGridRate or 1)
								posindex = posindex + 1
								if posindex > 9 then
									posindex = 2
								end
								if posindex == posindexstart then
									posloop = true
								end
								if posloop or obj:IsPosWalkable(itemx, itemy) then
									物品对象类:CreateItem(obj.m_nSceneID, -1, v.id, v.count, posloop and x or itemx, posloop and y or itemy, v.grade, v.strengthen, v.wash, v.attach, v.gem, v.ringsoul)
									break
								end
							end
							obj.m_db.bagdb.equips[k] = nil
							indexs[#indexs+1] = k
							if k == 1 or k == 2 or k == 11 or k == 23 then
								obj:ChangeBody()
							end
						end
					end
					if #indexs > 0 then
						背包逻辑.SendEquipQuery(obj, indexs)
					end
				end
			end
			obj.killerid = owner.id
			if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				if obj.m_db.PK值 <= 100 and obj.graynametime == 0 and 场景管理.IsSafeMap(obj.m_nSceneID) ~= 3 and not 行会管理.IsChallengeGuild(owner.m_db.guildname, obj.m_db.guildname) then
					owner.m_db.PK值 = owner.m_db.PK值 + 100
					owner.graynametime = 0
					owner:ChangeName()
					owner:UpdateObjInfo()
				end
				local call = 事件触发._M["call_击杀玩家"]
				if call then
					owner:显示对话(-2,call(owner))
				end
			end
		elseif obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER then
			local monconf = obj:GetConfig()
			if monconf and #monconf.drop > 0 then--and 副本管理.CheckMonsterDropitem(obj.m_nSceneID) then
				local ownerid = atker.id
				local owner = atker
				if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
					ownerid = atker.ownerid
					owner = 对象类:GetObj(ownerid)
					while owner.ownerid ~= -1 do
						ownerid = owner.ownerid
						owner = 对象类:GetObj(ownerid)
					end
				end
				local mapid = 场景管理.SceneId2ConfigMapId[obj.m_nSceneID]
				local mapconf = 地图表[mapid]
				local x,y = obj:GetPosition()
				local posindex = 1
				local posloop = false
				local itemx, itemy
				local drop = (obj.isrobot or obj.useitems) and obj.items or monconf.drop
				local totaldamage = 0
				local damagetb = {}
				local 生命阈值 = obj:获取生命值() / 100
				for k,v in pairs(obj.humanenmity) do
					if v >= 生命阈值 and 在线玩家管理[k] then
						damagetb[#damagetb+1] = {math.floor(v/生命阈值), 在线玩家管理[k]}
					end
				end
				local damagemax = 0
				for i,v in ipairs(damagetb) do
					totaldamage = totaldamage + v[1]
					if v[1] > damagemax then
						damagemax = v[1]
						atker = v[2]
					end
				end
				for i,v in ipairs(drop) do
					local 物品掉率 = (mapconf and mapconf.maptype == 1 and owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN) and v[3]*(1+owner.m_db.vip等级/10) or v[3]
					if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atker:GetObjType() == 公共定义.OBJ_TYPE_HERO then
						if atker.额外属性[公共定义.额外属性_物品掉率] then
							物品掉率 = 物品掉率*(100+atker.额外属性[公共定义.额外属性_物品掉率])/100
						end
					end
					--if Config.IS3G and obj:GetType() == 0 then
					--	物品掉率 = math.floor(物品掉率 / 5)
					--end
					if math.random(1,10000) <= 物品掉率 then
						while 1 do
							itemx = x+itemdroppos[posindex][1]*(obj.MoveGrid and obj.MoveGrid[1] or 50)
							itemy = y+itemdroppos[posindex][2]*(obj.MoveGrid and obj.MoveGrid[1] or 50)*(obj.Is2DScene and 1/obj.MoveGridRate or 1)
							if not posloop then
								posindex = posindex + 1
							end
							if posindex > #itemdroppos then
								posindex = 1
								posloop = true
							end
							if obj.m_nSceneID == -1 then
								break
							end
							if posloop or obj:IsPosWalkable(itemx, itemy) then
								local wei = totaldamage > 1 and math.random(1,totaldamage) or 0
								local weight = 0
								for ii,vv in ipairs(damagetb) do
									weight = weight + vv[1]
									if wei <= weight then
										ownerid = vv[2].id
										owner = vv[2]
										break
									end
								end
								local grade = nil
								if 物品逻辑.GetItemType1(v[1]) == 3 and obj:GetType() <= 2 then
									grade = math.random(1,10000)-- mapconf and mapconf.maptype == 3
									local 极品爆率 = 100
									if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
										极品爆率 = 100*(1+owner.m_db.vip等级/10)*城堡管理.城堡经验极品率(owner)
										if owner.额外属性[公共定义.额外属性_极品爆率] then
											极品爆率 = 极品爆率 + owner.额外属性[公共定义.额外属性_极品爆率]
										end
										if owner.英雄 and owner.英雄.额外属性[公共定义.额外属性_极品爆率] then
											极品爆率 = 极品爆率 + owner.英雄.额外属性[公共定义.额外属性_极品爆率]
										end
										--if owner.m_db.bagdb.equips[10] and owner.m_db.bagdb.equips[10].count > 0 then
										--	极品爆率 = 极品爆率 + 物品逻辑.GetItemBodyID(owner.m_db.bagdb.equips[10].id)
										--end
										--if owner.英雄 and owner.英雄.m_db.bagdb.equips[10] and owner.英雄.m_db.bagdb.equips[10].count > 0 then
										--	极品爆率 = 极品爆率 + 物品逻辑.GetItemBodyID(owner.英雄.m_db.bagdb.equips[10].id)
										--end
									end
									if obj:GetType() == 2 and obj:GetLevel() < 100 then
										grade = grade <= 极品爆率 and 5 or grade <= 1000 and 4 or grade <= 3000 and 3 or grade <= 6000 and 2 or 1
									elseif obj:GetType() == 1 and obj:GetLevel() < 100 then
										grade = grade <= 极品爆率 and 4 or grade <= 1000 and 3 or grade <= 4000 and 2 or 1
									else
										grade = grade <= 极品爆率 and 3 or grade <= 1000 and 2 or 1
									end
									grade = math.min(grade, 公共定义.装备掉落品质)
								end
								local 物品 = 物品对象类:CreateItem(-1, ownerid, v[1], v[2], posloop and x or itemx, posloop and y or itemy, grade)--v[4], v[5])
								if 物品==nil then
									print("null itemid: ",v[1])
									break
								end
								物品.teamid = owner.teamid
								物品:EnterScene(obj.m_nSceneID, itemx, itemy)
								if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and owner.m_db.物品自动拾取 == 1 then
									拾取物品逻辑.SendPickItem(owner, 物品.id)
								end
								break
							end
						end
					end
					local 宠物蛋掉率 = 5--Config.IS3G and 2 or 5
					if i == #drop and 公共定义.宠物蛋ID ~= 0 and obj:GetType() == 0 and obj:获取移动速度() > 0 and obj:GetLevel() < 公共定义.宠物蛋等级 and math.random(1,1000) <= 宠物蛋掉率 then --and not 场景管理.IsCopyscene(obj.m_nSceneID)
						local itemid = 公共定义.宠物蛋ID
						local cnt = 1
						while 1 do
							itemx = x+itemdroppos[posindex][1]*(obj.MoveGrid and obj.MoveGrid[1] or 50)
							itemy = y+itemdroppos[posindex][2]*(obj.MoveGrid and obj.MoveGrid[1] or 50)*(obj.Is2DScene and 1/obj.MoveGridRate or 1)
							if not posloop then
								posindex = posindex + 1
							end
							if posindex > #itemdroppos then
								posindex = 1
								posloop = true
							end
							if obj.m_nSceneID == -1 then
								break
							end
							if posloop or obj:IsPosWalkable(itemx, itemy) then
								local grade = nil
								if 物品逻辑.GetItemType1(itemid) == 3 and obj:GetType() == 0 and obj:获取移动速度() > 0 then
									grade = math.random(1,100)
									grade = grade == 1 and 5 or grade <= 5 and 4 or grade <= 15 and 3 or grade <= 30 and 2 or 1
								end
								local 物品 = 物品对象类:CreateItem(-1, ownerid, itemid, cnt, posloop and x or itemx, posloop and y or itemy, grade, obj.m_nMonsterID)
								物品.teamid = owner.teamid
								物品:EnterScene(obj.m_nSceneID, itemx, itemy)
								if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and owner.m_db.物品自动拾取 == 1 then
									拾取物品逻辑.SendPickItem(owner, 物品.id)
								end
								break
							end
						end
					end
				end
			end
			if monconf and monconf.dropexp > 0 then
				local ownerid = atker.id
				local owner = atker
				if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
					ownerid = atker.ownerid
					owner = 对象类:GetObj(ownerid)
					while owner.ownerid ~= -1 do
						ownerid = owner.ownerid
						owner = 对象类:GetObj(ownerid)
					end
				end
				local x,y = obj:GetPosition()
				if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or (owner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and owner.isrobot) then
					local humanids = {owner}
					if owner.teamid ~= 0 then
						local monids = obj:ScanCircleObjs(x, y, 1000)
						if monids then
							for _,v in ipairs(monids) do
								if v ~= owner and v.hp > 0 and (v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or (v:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and v.isrobot)) and v.teamid == owner.teamid then
									humanids[#humanids+1] = v
								end
							end
						end
					end
					local dropexp = math.floor(monconf.dropexp / #humanids) * 公共定义.经验倍率
					for _,v in ipairs(humanids) do
						if v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
							local indexs = {}
							for k,pet in pairs(v.pet) do
								indexs[#indexs+1] = k
							end
							local addexp = dropexp*(1+v.m_db.vip等级/10)*(v.经验倍数 or 1)*城堡管理.城堡经验极品率(v)--math.floor(dropexp/(#indexs+1))
							if v:GetAttr(公共定义.额外属性_双倍经验) > 0 then
								addexp = addexp + dropexp
							end
							if v:GetAttr(公共定义.额外属性_三倍经验) > 0 then
								addexp = addexp + dropexp*2
							end
							if v.额外属性[公共定义.额外属性_经验加成] then
								addexp = addexp + dropexp*(v.额外属性[公共定义.额外属性_经验加成]/100)
							end
							if v.英雄 and v.英雄.额外属性[公共定义.额外属性_经验加成] then
								addexp = addexp + dropexp*(v.英雄.额外属性[公共定义.额外属性_经验加成]/100)
							end
							--if v.m_db.bagdb.equips[9] and v.m_db.bagdb.equips[9].count > 0 then
							--	addexp = addexp + dropexp*(物品逻辑.GetItemBodyID(v.m_db.bagdb.equips[9].id)/100)
							--end
							--if v.英雄 and v.英雄.m_db.bagdb.equips[9] and v.英雄.m_db.bagdb.equips[9].count > 0 then
							--	addexp = addexp + dropexp*(物品逻辑.GetItemBodyID(v.英雄.m_db.bagdb.equips[9].id)/100)
							--end
							addexp = math.floor(addexp)
							if v:AddExp(addexp) then
								v:SendTipsMsg(2, "获得经验#cff00,"..addexp..(addexp>dropexp and "(+"..(addexp-dropexp)..")" or ""))
							end
							for k,pet in pairs(v.call) do
								if pet:GetObjType() == 公共定义.OBJ_TYPE_PET and pet:AddExp(addexp) then
									v:SendTipsMsg(2, 广播.colorRgb[pet:GetGrade()]..pet:GetName().."(戒灵)获得经验#cff00,"..addexp..(addexp>dropexp and "(+"..(addexp-dropexp)..")" or ""))
								end
							end
							if v.英雄 and v.英雄:AddExp(addexp) then
								v:SendTipsMsg(2, "英雄获得经验#cff00,"..addexp..(addexp>dropexp and "(+"..(addexp-dropexp)..")" or ""))
							end
							if v.英雄 then
								for k,pet in pairs(v.英雄.call) do
									if pet:GetObjType() == 公共定义.OBJ_TYPE_PET and pet:AddExp(addexp) then
										v:SendTipsMsg(2, 广播.colorRgb[pet:GetGrade()]..pet:GetName().."(戒灵)获得经验#cff00,"..addexp..(addexp>dropexp and "(+"..(addexp-dropexp)..")" or ""))
									end
								end
							end
							for k,pet in pairs(v.pet) do
								if pet:AddExp(addexp) then
									v:SendTipsMsg(2, 广播.colorRgb[pet:GetGrade()]..pet:GetName().."#C获得经验#cff00,"..addexp..(addexp>dropexp and "(+"..(addexp-dropexp)..")" or ""))
								end
							end
							if #indexs > 0 then
								宠物逻辑.SendPetInfo(v, indexs)
							end
							if 公共定义.聚灵珠ID ~= 0 then
								local index = 背包DB.FindItemIndex(v, 公共定义.聚灵珠ID, 1)
								if index then
									v:SendTipsMsg(2, "#cffff00,聚灵珠#C获得经验#cff00,"..math.floor(addexp/10))
									local g = v.m_db.bagdb.baggrids[index]
									g.wash = g.wash or {}
									if g.wash[1] == nil then
										g.wash[1] = {46, math.floor(addexp/10)}
									else
										g.wash[1][2] = g.wash[1][2] + math.floor(addexp/10)
									end
									local texp = 1000000+v:GetLevel()*100000
									if g.wash[1][2] >= texp then
										g.wash[1][2] = texp
										g.bind = 0
									end
									g.grade = math.ceil(g.wash[1][2]/(texp/5))
									背包逻辑.SendBagQuery(v, {index})
								end
							end
						else
							v:AddExp(dropexp)
						end
					end
				end
			end
			if obj:GetCallID() ~= 0 and not 场景管理.IsCopyscene(obj.m_nSceneID) and math.random(1,obj:GetCallRate()) == 1 then
				local ownerid = atker.id
				local owner = atker
				if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
					ownerid = atker.ownerid
					owner = 对象类:GetObj(ownerid)
					while owner.ownerid ~= -1 do
						ownerid = owner.ownerid
						owner = 对象类:GetObj(ownerid)
					end
				end
				local x,y = obj:GetPosition()
				local m = 怪物对象类:CreateMonster(obj.m_nSceneID, obj:GetCallID(), x, y, -1)
				m.callid = -1
				if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
					聊天逻辑.SendSystemChat("#cffff00,"..owner:GetName().."#C在#cff0000,"..
					场景管理.GetMapName(场景管理.GetMapId(owner.m_nSceneID)).."#C作乱,#cffff00,"..
					m:GetName().."#C被唤醒")
				end
			end
			local ownerid = atker.id
			local owner = atker
			if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
				ownerid = atker.ownerid
				owner = 对象类:GetObj(ownerid)
				while owner.ownerid ~= -1 do
					ownerid = owner.ownerid
					owner = 对象类:GetObj(ownerid)
				end
			end
			local objowner = obj
			while objowner.ownerid ~= -1 do
				objowner = 对象类:GetObj(objowner.ownerid)
			end
			if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				owner.killmonid = obj.m_nMonsterID
				local call = 事件触发._M["call_击杀宝宝"]
				if call then
					owner:显示对话(-2,call(owner))
				end
			end
			if owner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				owner.killmonid = obj.m_nMonsterID
				local call = 事件触发._M["call_击杀怪物"]
				if call then
					owner:显示对话(-2,call(owner))
				end
			end
			Npc对话逻辑.OnMonsterDead(obj, atker)
			deadeff = obj:GetDeadEff()
		end
		if (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) and obj:GetAttr(公共定义.额外属性_复活) > 0 and (obj.canrelivetime or 0) < _CurrentTime() then
			obj:RecoverHP(obj.hpMax)
			obj.canrelivetime = _CurrentTime() + 60000
		else
			obj:CheckDead()
			副本管理.KillSceneObj(obj.m_nSceneID, obj, atker)
		end
	elseif damage > 0 then
		local atkerowner = atker
		if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
			atkerowner = 对象类:GetObj(atker.ownerid) or atker
			while atkerowner.ownerid ~= -1 do
				atkerowner = 对象类:GetObj(atkerowner.ownerid)
			end
		end
		if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.ownerid == -1 then
			atker.hitmonid = obj.m_nMonsterID
			local call = 事件触发._M["call_攻击怪物_"..atker.m_db.mapid]
			if call then
				atker:显示对话(-2,call(atker))
			end
		end
		if obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and (obj:GetType() == 1 or obj:GetType() == 2 or obj:GetType() == 3) and not 场景管理.IsCopyscene(obj.m_nSceneID) and atkerowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
			local oenmity = obj.humanenmity[atkerowner:GetName()] or 0
			local monconf = obj:GetConfig()
			obj.humanenmity[atkerowner:GetName()] = (obj.humanenmity[atkerowner:GetName()] or 0) + damage
			for i,v in ipairs(monconf.damageprize) do
				if oenmity < v[1] and oenmity + damage >= v[1] then
					local weight=0
					for ii=2,#v do
						weight = weight + v[ii][3]
					end
					local wei = math.random(1,weight)
					weight=0
					for ii=2,#v do
						weight = weight + v[ii][3]
						if wei <= weight then
							local indexs = atkerowner:PutItemGrids(v[ii][1], v[ii][2], (v[ii][1] == 公共定义.金币物品ID or v[ii][1] == 公共定义.元宝物品ID) and 1 or 0, true) or {}
							local 获得提示 = ""
							if v[ii][1] == 公共定义.经验物品ID then
								获得提示 = "获得经验#c00ff00,"..v[ii][2]
							elseif v[ii][1] == 公共定义.金币物品ID then
								获得提示 = "获得绑定金币#cffff00,"..v[ii][2]
							elseif v[ii][1] == 公共定义.元宝物品ID then
								获得提示 = "获得绑定元宝#cffff00,"..v[ii][2]
							else
								获得提示 = "获得"..广播.colorRgb[物品逻辑.GetItemGrade(v[ii][1])]..物品逻辑.GetItemName(v[ii][1])..(v[ii][2] > 1 and "x"..v[ii][2] or "")
							end
							if v[ii][1] ~= 公共定义.经验物品ID and v[ii][1] ~= 公共定义.金币物品ID and v[ii][1] ~= 公共定义.元宝物品ID and #indexs == 0 then
								human:SendTipsMsg(1,"背包不足")
								local x,y = obj:GetPosition()
								local 物品 = 物品对象类:CreateItem(-1, atkerowner.id, v[ii][1], v[ii][2], x, y)
								物品.teamid = atkerowner.teamid
								物品:EnterScene(obj.m_nSceneID, v[ii][1], v[ii][2])
							else
								背包逻辑.SendBagQuery(atkerowner, indexs)
								atkerowner:SendTipsMsg(2, 获得提示)
								--if v[ii][1] == 公共定义.金币物品ID then
								--	atkerowner:SendTipsMsg(2, "获得绑定金币#cffff00,"..v[ii][2])
								--elseif v[ii][1] == 公共定义.元宝物品ID then
								--	atkerowner:SendTipsMsg(2, "获得绑定元宝#cffff00,"..v[ii][2])
								--else
								--	atkerowner:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(v[ii][1])]..物品逻辑.GetItemName(v[ii][1])..(v[ii][2] > 1 and "x"..v[ii][2] or ""))
								--end
							end
							聊天逻辑.SendSystemChat("玩家#cffff00,"..atkerowner:GetName().."#C对#cffff00,"..obj:GetName().."#C造成巨额伤害,"..获得提示)--获得系统随机奖励
							break
						end
					end
					break
				end
			end
		end
		if atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and atker:GetType() == 4 then
		elseif obj.是否练功师 and not obj:HasSkill() then
		elseif obj:GetObjType() == 公共定义.OBJ_TYPE_HERO or obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or obj:GetObjType() == 公共定义.OBJ_TYPE_PET then
			obj.enmity[atker] = (obj.enmity[atker] or 0) + damage
			if atker.enemy then
				atker.enemy[obj] = true
			end
		elseif obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
			for k,v in pairs(obj.call) do
				v.enmity[atker] = (v.enmity[atker] or 0) + damage
				if atker.enemy then
					atker.enemy[v] = true
				end
			end
			for k,v in pairs(obj.pet) do
				v.enmity[atker] = (v.enmity[atker] or 0) + damage
				if atker.enemy then
					atker.enemy[v] = true
				end
			end
			if obj.英雄 then
				obj.英雄.enmity[atker] = (obj.英雄.enmity[atker] or 0) + damage
				if atker.enemy then
					atker.enemy[obj.英雄] = true
				end
			end
		end
		if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and (not obj.是否练功师 or obj:HasSkill()) then
			for k,v in pairs(atker.call) do
				v.enmity[obj] = (v.enmity[obj] or 0) + damage
				obj.enemy[v] = true
			end
			for k,v in pairs(atker.pet) do
				v.enmity[obj] = (v.enmity[obj] or 0) + damage
				obj.enemy[v] = true
			end
			if atker.英雄 then
				atker.英雄.enmity[obj] = (atker.英雄.enmity[obj] or 0) + damage
				obj.enemy[atker.英雄] = true
			end
		end
	end
	if obj.hp == 0 and obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and obj.mountid ~= 0 then
		obj.mountid = 0
		obj:ChangeBody()
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		obj:CheckMergePet()
	end
	return deadeff
end

function DoCallRingSoul(obj, beattack)
	local 特戒位置 = {13,16,17}
	for i,v in ipairs(特戒位置) do
		if obj.m_db.bagdb.equips[v] and obj.m_db.bagdb.equips[v].count > 0 and obj.m_db.bagdb.equips[v].ringsoul then
			local ringsoul = obj.m_db.bagdb.equips[v].ringsoul
			local monconf = 宠物表[ringsoul.id] or 怪物表[ringsoul.id]
			if monconf and ((beattack and monconf.职业 == 1) or (not beattack and monconf.职业 ~= 1)) and math.random(1,100) <= 5 then
				local x,y = obj:GetPosition()
				local m
				if obj.call[v] then
					m = obj.call[v]
				end
				if m then
					m:LeaveScene()
					m:ChangeStatus(公共定义.STATUS_NORMAL)
					m.hp = m:获取生命值()
					m:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, m.hp)
					m.teamid = obj.teamid
					m:JumpScene(obj.m_nSceneID, x, y)
					m.bornx = x
					m.borny = y
					m.avatarid = 0
					m:ChangeBody()
					m.changebodyid = nil
					m.movegridpos = nil
				else
					local wash = {}
					if ringsoul.wash then
						for i,v in ipairs(ringsoul.wash) do
							wash[v[1]] = v[2]
						end
					end
					local key = monconf.职业 == 1 and 5 or monconf.职业 == 2 and 6 or 7
					local db = {属性加点={[key] = ringsoul.starlevel}}
					m = 宠物对象类:CreatePet(-1, ringsoul.id, x, y, obj.id, ringsoul.level, ringsoul.exp, 1, 0, ringsoul.grade, wash, db, ringsoul)
					m.teamid = obj.teamid
					m:EnterScene(obj.m_nSceneID, m.bornx, m.borny)
					obj.call[v] = m
				end
				m.disappeartime = _CurrentTime() + 5000 + ringsoul.starlevel*1000
				local nX, nY = 实用工具.GetRandPos(x, y, 200,m.Is2DScene,m.MoveGridRate)
				m:MoveTo(nX, nY)
				break
			end
		end
	end
end

--技能攻击受伤
function DoAttackHurt(obj, atker, skillid, buffdamage, buffeff4, hittype)
	local deadeff = 0
	local conf
	local damage, crit
	if skillid then
		conf = 技能表[skillid]
		if not conf then
			return 0
		end
		if conf.damage1 == 0 and conf.damage2 == 0 then
			damage, crit = 0, 2
		else
			local damage1 = conf.damage1
			local damage2 = conf.damage2
			if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				for i,v in ipairs(atker.m_db.skills) do
					local infoconf = 技能信息表[v[1]]
					if infoconf and infoconf.passive == 0 and 实用工具.FindIndex(infoconf.skill,skillid) then
						damage1 = damage1 + (v[2]-1)*infoconf.damage1
						damage2 = damage2 + (v[2]-1)*infoconf.damage2
						break
					end
				end
				if ATTACH_SKILLS[skillid] and atker.attrattach[ATTACH_SKILLS[skillid]] then
					damage1 = damage1 + atker.attrattach[ATTACH_SKILLS[skillid]]
				end
			end
			if conf.benefit == 1 then
				if conf.job == 2 or (conf.job == 0 and atker:获取职业() == 2) then
					damage, crit = math.ceil(((atker:获取魔法()+atker:获取魔法上限())/2) * (damage1/100) + damage2), 0
				elseif conf.job == 3 or (conf.job == 0 and atker:获取职业() == 3) then
					damage, crit = math.ceil(((atker:获取道术()+atker:获取道术上限())/2) * (damage1/100) + damage2), 0
				else
					damage, crit = math.ceil(((atker:获取攻击()+atker:获取攻击上限())/2) * (damage1/100) + damage2), 0
				end
				
			elseif Config.IS3G then
				damage, crit = CalcDamage3G(obj, atker, damage1, damage2, conf.normal == 1)
			else
				damage, crit = CalcDamage(obj, atker, damage1, damage2, conf.job)
				if (skillid == 1140 or skillid == 1142 or skillid == 1141 or skillid == 1145 or skillid == 1144 or skillid == 1143 or skillid == 1153) and atker.英雄 then
					local damageex, critex = CalcDamage(obj, atker.英雄, damage1, damage2, conf.job)
					damage = damage + damageex
					crit = (crit == 1 or critex == 1) and 1 or 0
				end
			end
		end
	else
		damage = buffdamage
		crit = 0
	end
	if conf and conf.benefit == 1 and damage > 0 then
		if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and #obj.petmerge > 0 then
			obj.petmerge[#obj.petmerge].hp = math.min(obj.petmerge[#obj.petmerge].hpmax, obj.petmerge[#obj.petmerge].hp + damage)
		else
			obj.hp = math.min(obj:获取生命值(), obj.hp + damage)
			obj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, obj.hp)
		end
		obj:ChangeInfo()
		damage = -damage
	elseif damage > 0 then
		if (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) and obj:GetAttr(公共定义.额外属性_护身) > 0 and obj:获取职业() ~= 1 then
			if obj.mp >= damage then
				obj.mp = math.max(0, obj.mp - damage)
				damage = 0
			else
				damage = damage - obj.mp
				obj.mp = 0
			end
			obj:SendActualAttr()
		end
		if atker:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atker:GetObjType() == 公共定义.OBJ_TYPE_HERO then
			local hasbuff = false
			if obj:GetAttr(公共定义.额外属性_免疫) == 0 then
				local 麻痹 = atker:获取职业() == 1 and atker:GetAttr(公共定义.额外属性_麻痹) or 0
				if not hasbuff and 麻痹 > 0 and math.random(1,100) <= 麻痹 then
					DoAddBuff(obj, atker.id, 2004, 2000)
					hasbuff = true
				end
				local 火焰 = atker:GetAttr(公共定义.额外属性_火焰)
				if not hasbuff and 火焰 > 0 and math.random(1,100) <= 火焰 then
					DoAddBuff(obj, atker.id, 2009, 5000)
					hasbuff = true
				end
				local 寒冰 = atker:GetAttr(公共定义.额外属性_寒冰)
				if not hasbuff and 寒冰 > 0 and math.random(1,100) <= 寒冰 then
					DoAddBuff(obj, atker.id, 2007, 5000)
					hasbuff = true
				end
				local 红毒 = atker:GetAttr(公共定义.额外属性_红毒)
				if not hasbuff and 红毒 > 0 and math.random(1,100) <= 红毒 then
					DoAddBuff(obj, atker.id, 2002, 5000)
					hasbuff = true
				end
				local 绿毒 = atker:GetAttr(公共定义.额外属性_绿毒)
				if not hasbuff and 绿毒 > 0 and math.random(1,100) <= 绿毒 then
					DoAddBuff(obj, atker.id, 2003, 5000)
					hasbuff = true
				end
			end
			DoCallRingSoul(atker, false)
		end
		if damage > 0 then
			if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and #obj.petmerge > 0 then
				obj.petmerge[#obj.petmerge].hp = math.max(0, obj.petmerge[#obj.petmerge].hp - damage)
			else
				obj.hp = math.max(0, obj.hp - damage)
				obj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, obj.hp)
			end
			deadeff = CheckObjDead(obj, atker, damage)
			obj:ChangeInfo()
			local atkerowner = atker.ownerid ~= -1 and 对象类:GetObj(atker.ownerid) or atker
			if atkerowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or atkerowner:GetObjType() == 公共定义.OBJ_TYPE_HERO then
				atkerowner:RecoverMP(1)
			end
		end
		if damage > 0 and (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) then
			obj:RecoverMP(1)
			local rebound = obj:GetAttr(公共定义.额外属性_伤害反弹)
			if rebound > 0 and atker.hp > 0 then
				atker:RecoverHP(-damage*rebound/100)
				CheckObjDead(atker, obj, damage*rebound/100)
			end
			DoCallRingSoul(obj, true)
		end
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_PET and obj.avatarid == 公共定义.宠物死亡ID then
		return damage
	end
	if (not obj.unattackable or obj.unattackable == 0) and (not obj.unmovable or obj.unmovable == 0) then
		--SendControlled(obj, 1, 500)
		--SendControlled(obj, 0, 500)
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		obj:StopCollect()
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_HURT]
	oReturnMsg.objid = obj.id
	oReturnMsg.effid1 = conf and conf.eff4 or buffeff4
	oReturnMsg.effid2 = deadeff ~= 0 and deadeff or 0
	oReturnMsg.dechp = damage
	oReturnMsg.crit = crit
	oReturnMsg.status = obj.hp == 0 and 1 or 0
	oReturnMsg.hittype = hittype or 0
	消息类.ZoneBroadCast(oReturnMsg, obj.id)
	
	return damage
end

function SendSkillErr(obj, err)
	if obj:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_ERR]
	oReturnMsg.err = err or ""
	消息类.SendMsg(oReturnMsg, obj.id)
end

--释放技能 obj 被攻击对象, skillid 技能id, targetid 攻击对象 , posx 坐标x , posy 坐标y
function DoUseSkill(obj, skillid, targetid, posx, posy)
	if not obj.IsDead or obj:IsDead() or obj.m_nSceneID == -1 then
		SendSkillErr(obj)
		return
	end
	if (skillid == 1140 or skillid == 1142 or skillid == 1141 or skillid == 1145 or skillid == 1144 or skillid == 1143 or skillid == 1153) and obj.xpstatus == 1 then
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		local canuseskill = false
		if obj.avatarid ~= 0 then
			local monconf = 怪物表[obj.avatarid]
			if monconf then
				for i,skill in ipairs(monconf.skill) do
					if skill[1] == skillid then
						canuseskill = true
						break
					end
				end
			end
		else
			local mapid = 场景管理.SceneId2ConfigMapId[obj.m_nSceneID]
			local mapConfig = 地图表[mapid]
			for i,v in ipairs(obj.m_db.skills) do
				local skconf = 技能信息表[v[1]]
				if skconf and 实用工具.FindIndex(skconf.skill, skillid) then
					if mapConfig and 实用工具.FindIndex(mapConfig.banskill, v[1]) then
						SendSkillErr(obj,"该技能禁止在该地图使用")
						return
					end
					canuseskill = true
					break
				end
			end
		end
		if not canuseskill then
			SendSkillErr(obj)
			return
		end
	end
	if not Config.IS3G and (skillid == 1140 or skillid == 1142 or skillid == 1141 or skillid == 1145 or skillid == 1144 or skillid == 1143 or skillid == 1153) then
	elseif obj.unattackable then
		SendSkillErr(obj)
		return
	end
	local conf = 技能表[skillid]
	if conf == nil then
		SendSkillErr(obj)
		return
	end
	local mapheight, mapwidth = _GetHeightAndWidth(obj.m_nSceneID)
	if posx <= 0 or posy <= 0 or posx >= mapwidth or posy >= mapheight then
		--SendSkillErr(obj)
		--return
		posx = math.max(1, math.min(mapwidth-1, posx))
		posy = math.max(1, math.min(mapheight-1, posy))
	end
	
	--计算魔法值是否够
	if conf.decmp > 0 and (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) and obj.mp < conf.decmp then
		SendSkillErr(obj,Config.IS3G and "怒气值不足" or "魔法值不足")
		return
	end
	if obj.cd[skillid] and obj.cd[skillid] > _CurrentTime() then
		SendSkillErr(obj,"技能冷却中")
		return
	end
	local x,y
	if obj.movegridpos then
		x,y = obj.movegridpos[1], obj.movegridpos[2]
	else
		x,y = obj:GetPosition()
	end
	if conf.range[1] == 5 then
		local target = targetid ~= -1 and 对象类:GetObj(targetid) or nil
		if target == nil then
			targetid = obj.id
		else
			local targetowner = target.ownerid ~= -1 and 对象类:GetObj(target.ownerid) or target
			local objowner = obj.ownerid ~= -1 and 对象类:GetObj(obj.ownerid) or obj
			local isenemy = (objowner ~= targetowner and ((objowner.teamid == 0 and targetowner.teamid == 0) or objowner.teamid ~= targetowner.teamid))
			if isenemy then
				targetid = obj.id
			else
				local tx,ty = target:GetPosition()
				if 实用工具.GetDistanceSq(x,y,tx,ty,obj.Is2DScene,obj.MoveGridRate) > conf.range[2] * conf.range[2] then
					SendSkillErr(obj,"距离太远")
					return
				end
			end
		end
	end
	if conf.range[1] == 0 then
		local target = 对象类:GetObj(targetid)
		if target == nil then
			SendSkillErr(obj,"请选择一个目标")
			return
		end
		if target:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN and target:GetObjType() ~= 公共定义.OBJ_TYPE_HERO and
			target:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER and target:GetObjType() ~= 公共定义.OBJ_TYPE_PET then
			SendSkillErr(obj,"目标类型错误")
			return
		end
		local tx,ty = target:GetPosition()
		if 实用工具.GetDistanceSq(x,y,tx,ty,obj.Is2DScene,obj.MoveGridRate) > conf.range[2] * conf.range[2] then
			SendSkillErr(obj,"距离太远")
			return
		end
	elseif conf.range[1] == 4 then
		if 实用工具.GetDistanceSq(x,y,posx,posy,obj.Is2DScene,obj.MoveGridRate) > conf.range[2] * conf.range[2] then
			SendSkillErr(obj,"距离太远")
			return
		end
	end
	if obj.MoveGrid then
		posx = math.floor(posx / obj.MoveGrid[1]) * obj.MoveGrid[1] + obj.MoveGrid[1]/2
		posy = math.floor(posy / obj.MoveGrid[2]) * obj.MoveGrid[2] + obj.MoveGrid[2]/2
	end
	local cdreduce = nil
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		cdreduce = obj:GetAttr(公共定义.额外属性_技能冷却)
	end
	obj.cd[skillid] = _CurrentTime() + (cdreduce and math.ceil(conf.cd * (1-cdreduce/100)) or conf.cd)
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and (conf.special == 1 or conf.special == 2) then
		obj:ChangeStatus(公共定义.STATUS_WALK)
	end
	if conf.special == 0 or conf.special == 3 then
		obj:StopMove()
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and obj.mountid ~= 0 then
		obj.mountid = 0
		obj:ChangeBody()
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		obj:StopCollect()
	end
	if conf.decmp > 0 and (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) then
		obj:RecoverMP(-conf.decmp)
	end
	if obj.buffend[公共定义.隐身BUFF] then
		DoRemoveBuff(obj, 公共定义.隐身BUFF)
	end
	local useitem = true
	if (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) then
		local human = obj:GetObjType() == 公共定义.OBJ_TYPE_HERO and 对象类:GetObj(obj.ownerid) or obj
		if conf.useitem ~= 0 then
			if 背包DB.CheckCount(human, conf.useitem) < 1 then
				human:SendTipsMsg(1,物品逻辑.GetItemName(conf.useitem).."不足")
				useitem = false
			else
				背包DB.RemoveCount(human, conf.useitem, 1)
			end
		end
	end
	
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_USE_SKILL]
	oReturnMsg.objid = obj.id
	oReturnMsg.targetid = (conf.range[1] == 0 or conf.range[1] == 5) and targetid or -1
	oReturnMsg.skillid = skillid
	oReturnMsg.action = conf.act
	oReturnMsg.sound = conf.sound
	oReturnMsg.effid1 = useitem and conf.eff1 or 0
	oReturnMsg.effid2 = useitem and conf.eff2 or 0
	oReturnMsg.effid3 = useitem and conf.eff3 or 0
	oReturnMsg.posx = posx
	oReturnMsg.posy = posy
	if conf.eff3 ~= 0 and #conf.hitpoint > 0 then
		oReturnMsg.flytime = math.max(0,conf.hitpoint[1] - 200)
	else
		oReturnMsg.flytime = 0
	end
	if conf.special == 2 or conf.special == 3 then
		oReturnMsg.follow = -1
	elseif conf.special == 1 or #conf.displace > 0 then
		oReturnMsg.follow = math.max(0,(conf.endtime[1] or (conf.hitpoint[#conf.hitpoint]+200))-50)
	else
		oReturnMsg.follow = 0
	end
	消息类.ZoneBroadCast(oReturnMsg, obj.id)
	
	if not useitem then
		return
	end
	obj.useskilltime = _CurrentTime()
	--有位移
	if #conf.displace > 0 and not obj.unmovable then
		if obj.displace then
			_DelTimer(obj.displace, obj.id)
			DisplaceMove[obj.id] = nil
		end
		obj.displace = _AddTimer(obj.id, 计时器ID.TIMER_DISPLACE_BEGIN, conf.displace[2], 1, {skillid=skillid, targetid=targetid, posx=posx, posy=posy})
	end
	--有受击点
	if #conf.hitpoint > 0 then
		if obj.hitpoint then
			_DelTimer(obj.hitpoint, obj.id)
		end
		obj.hitpoint = _AddTimer(obj.id, 计时器ID.TIMER_ATTACK_HIT, conf.hitpoint[1], 1, {skillid=skillid, targetid=targetid, hitindex=1, posx=posx, posy=posy})
		local 攻击速度 = obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and math.max(0, 1-obj.属性值[公共定义.属性_攻击速度]/100) or 1
		if #conf.endtime > 0 then
			SendControlled(obj, 1, conf.endtime[1]*攻击速度)
			if conf.special == 0 or conf.special == 3 then
				SendControlled(obj, 0, conf.endtime[2] or (conf.endtime[1]*攻击速度))
			end
		else
			SendControlled(obj, 1, (conf.hitpoint[#conf.hitpoint]+200)*攻击速度)
			if conf.special == 0 or conf.special == 3 then
				SendControlled(obj, 0, (conf.hitpoint[#conf.hitpoint]+200)*攻击速度)
			end
		end
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		local call = 事件触发._M["call_技能自身_"..skillid]
		if call then
			obj:显示对话(-2,call(obj))
		end
	end
	return true
end

function SendDisplace(objid,hitfly,posx,posy,time,passive)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_DISPLACE]
	oReturnMsg.objid = objid
	oReturnMsg.hitfly = hitfly
	oReturnMsg.posx = posx
	oReturnMsg.posy = posy
	oReturnMsg.time = time
	oReturnMsg.passive = passive
	
	消息类.ZoneBroadCast(oReturnMsg, objid)
end

function CheckEffLimit(skillid, obj, target)
	local conf = 技能表[skillid]
	if not conf then
		return false
	elseif conf.efflimit == 1 then
		return target:GetLevel() < obj:GetLevel()
	elseif conf.efflimit == 2 then
		return target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER
	elseif conf.efflimit == 3 then
		return target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and target:GetLevel() < obj:GetLevel()
	elseif conf.efflimit == 4 then
		return target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and target:GetUndead() == 1
	elseif conf.efflimit == 5 then
		return target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and target:GetUndead() == 1 and target:GetLevel() < obj:GetLevel()
	elseif conf.efflimit == 6 then
		return target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and target:GetUndead() == 0
	elseif conf.efflimit == 7 then
		return target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and target:GetUndead() == 0 and target:GetLevel() < obj:GetLevel()
	else
		return true
	end
end

function DoDisplaceBegin(obj, skillid, targetid, posx, posy)
	local conf = 技能表[skillid]
	if #conf.displace > 0 then
		local x,y = obj:GetPosition()
		local time = conf.displace[3]-conf.displace[2]
		local mx,my = 0,0
		local dist = conf.displace[4]
		if conf.displace[5] == 1 then
			if conf.displace[1] == 0 or conf.displace[1] == 1 then
				mx,my=posx-x<0 and -dist or dist,0
			elseif conf.displace[1] == 2 or conf.displace[1] == 3 then
				dist = math.max(0, 实用工具.GetDistance(x,y,posx,posy,obj.Is2DScene,obj.MoveGridRate) - dist)
				mx,my=posx-x<0 and -dist or dist,0
			end
		else
			if conf.displace[1] == 0 or conf.displace[1] == 1 then
				mx,my=实用工具.GetNormalize(dist,x,y,posx,posy,obj.Is2DScene,obj.MoveGridRate)
			elseif conf.displace[1] == 2 or conf.displace[1] == 3 then
				dist = math.max(0, 实用工具.GetDistance(x,y,posx,posy,obj.Is2DScene,obj.MoveGridRate) - dist)
				mx,my=实用工具.GetNormalize(dist,x,y,posx,posy,obj.Is2DScene,obj.MoveGridRate)
			end
		end
		if mx == 0 and my == 0 then
			my = dist
		end
		obj.dismovex = mx
		obj.dismovey = my
		local disposx,disposy=x+mx,y+my
		if obj.MoveGrid then
			disposx = math.floor(disposx / obj.MoveGrid[1]) * obj.MoveGrid[1] + obj.MoveGrid[1]/2
			disposy = math.floor(disposy / obj.MoveGrid[2]) * obj.MoveGrid[2] + obj.MoveGrid[2]/2
		end
		local ddist = math.ceil(dist / 50)
		local dmx,dmy = mx/ddist, my/ddist
		while not obj:IsPosCanRun(disposx, disposy) and ddist > 1 do
			mx = mx - dmx
			my = my - dmy
			ddist = ddist - 1
			obj.dismovex = mx
			obj.dismovey = my
			disposx,disposy=x+mx,y+my
			if obj.MoveGrid then
				disposx = math.floor(disposx / obj.MoveGrid[1]) * obj.MoveGrid[1] + obj.MoveGrid[1]/2
				disposy = math.floor(disposy / obj.MoveGrid[2]) * obj.MoveGrid[2] + obj.MoveGrid[2]/2
			end
		end
		if obj:IsPosCanRun(disposx, disposy) then
			if obj.displace then
				_DelTimer(obj.displace, obj.id)
				DisplaceMove[obj.id] = nil
			end
			obj.displace = _AddTimer(obj.id, 计时器ID.TIMER_DISPLACE_END, time, 1, {posx=disposx,posy=disposy})
			SendControlled(obj, 1, time)
			if conf.special == 0 or conf.special == 3 then
				SendControlled(obj, 0, time)
			end
			SendDisplace(obj.id, 0, disposx, disposy, time, 0)
			obj.disstarttime = _CurrentTime()
			obj.disstartx = x
			obj.disstarty = y
			obj.displacex = disposx
			obj.displacey = disposy
			obj.displacetime = _CurrentTime() + time
			DisplaceMove[obj.id] = obj
			--local speed = math.sqrt((disposx-x)*(disposx-x)+(disposy-y)*(disposy-y)) * 1000/time
			--if speed > 0 then
			--	obj:SetEngineMoveSpeed(speed)
			--	_MoveTo(obj.id, disposx, disposy, -1)
			--end
		end
		local objowner = obj.ownerid ~= -1 and 对象类:GetObj(obj.ownerid) or obj
		while objowner.ownerid ~= -1 do
			objowner = 对象类:GetObj(objowner.ownerid)
		end
		if conf.displace[1] == 1 or conf.displace[1] == 3 then
			local monids = GetHitMonIDs(obj, skillid, targetid, x, y, posx, posy)
			if monids then
				for _,v in ipairs(monids) do
					if v.hp > 0 and not v.iscaller and ((v:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and v:GetType()==0) or (not v.hitfalltime or _CurrentTime() > v.hitfalltime)) then
						if (v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or v:GetObjType() == 公共定义.OBJ_TYPE_HERO) and v:GetAttr(公共定义.额外属性_霸体) > 0 then
						elseif (v:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER or v:GetType() ~= 3) and CheckEffLimit(skillid, obj, v) then
							local targetowner = v.ownerid ~= -1 and 对象类:GetObj(v.ownerid) or v
							while targetowner.ownerid ~= -1 do
								targetowner = 对象类:GetObj(targetowner.ownerid)
							end
							if conf.benefit == 0 and objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and targetowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and
							(objowner.m_db.pkmode == 0 or objowner:GetLevel() < 公共定义.PK等级限制 or targetowner:GetLevel() < 公共定义.PK等级限制 or 场景管理.IsSafeMap(obj.m_nSceneID) == 1 or objowner.insafearea or targetowner.insafearea) then
							elseif conf.benefit == 0 and 场景管理.IsSafeMap(obj.m_nSceneID) == 2 then
							elseif objowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and targetowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and
								objowner.teamid == 0 and targetowner.teamid == 0 then
							elseif objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and targetowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and
								objowner.m_db.pkmode == 2 and objowner.m_db.guildname ~= "" and (objowner.m_db.guildname == targetowner.m_db.guildname or 行会管理.IsAllianceGuild(objowner.m_db.guildname, targetowner.m_db.guildname)) then
							elseif objowner ~= targetowner and ((objowner.teamid == 0 and targetowner.teamid == 0) or objowner.teamid ~= targetowner.teamid) then
								local rx,ry = v:GetPosition()
								v:StopMove()
								disposx,disposy=rx+mx,ry+my
								if v.MoveGrid then
									disposx = math.floor(disposx / v.MoveGrid[1]) * v.MoveGrid[1] + v.MoveGrid[1]/2
									disposy = math.floor(disposy / v.MoveGrid[2]) * v.MoveGrid[2] + v.MoveGrid[2]/2
								end
								if v:IsPosCanRun(disposx, disposy) then
									if v.displace then
										_DelTimer(v.displace, v.id)
										DisplaceMove[v.id] = nil
									end
									v.displace = _AddTimer(v.id, 计时器ID.TIMER_DISPLACE_END, time, 1, {posx=disposx,posy=disposy})
									SendControlled(v, 1, time)
									SendControlled(v, 0, time)
									SendDisplace(v.id, 0, disposx, disposy, time, 1)
									v.disstarttime = _CurrentTime()
									v.disstartx = rx
									v.disstarty = ry
									v.displacex = disposx
									v.displacey = disposy
									v.displacetime = _CurrentTime() + time
									DisplaceMove[v.id] = v
									--local speed = math.sqrt((disposx-x)*(disposx-x)+(disposy-y)*(disposy-y)) * 1000/time
									--if speed > 0 then
									--	v:SetEngineMoveSpeed(speed)
									--	_MoveTo(v.id, disposx, disposy, -1)
									--end
								end
							end
						end
					end
				end
			end
		end
	end
end

function SendControlled(obj, type, time)
	if type == 1 then
		obj.unattackable = (obj.unattackable or 0) + 1
		_AddTimer(obj.id, 计时器ID.TIMER_UNATTACKABLE_OUT, time, 1)
	else
		obj.unmovable = (obj.unmovable or 0) + 1
		_AddTimer(obj.id, 计时器ID.TIMER_UNMOVABLE_OUT, time, 1)
		obj:StopMove()
		obj:SetForbidMove()
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_CONTROLLED]
		oReturnMsg.objid = obj.id
		oReturnMsg.type = type
		oReturnMsg.controlled = 1
		消息类.SendMsg(oReturnMsg, obj.id)
	end
end

function SendControlledOut(obj, type)
	local controlledout = false
	if type == 1 then
		if obj.unattackable and obj.unattackable > 1 then
			obj.unattackable = obj.unattackable - 1
		else
			obj.unattackable = nil
		end
		controlledout = obj.unattackable == nil
	else
		if obj.unmovable and obj.unmovable > 1 then
			obj.unmovable = obj.unmovable - 1
		else
			obj.unmovable = nil
			obj:SetFreeMove()
		end
		controlledout = obj.unmovable == nil
	end
	if controlledout and obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_CONTROLLED]
		oReturnMsg.objid = obj.id
		oReturnMsg.type = type
		oReturnMsg.controlled = 0
		消息类.SendMsg(oReturnMsg, obj.id)
	end
end

function GetHitMonIDs(obj, skillid, targetid, x, y, posx, posy)
	local conf = 技能表[skillid]
	local monids
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO or obj:GetObjType() == 公共定义.OBJ_TYPE_PET or obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER then
		if conf.range[1] == 0 or conf.range[1] == 5 then
			local target = 对象类:GetObj(targetid)
			if target == nil or (target == obj and conf.range[1] == 0) then
				return
			end
			local tx,ty = target:GetPosition()
			if 实用工具.GetDistanceSq(x,y,tx,ty,obj.Is2DScene,obj.MoveGridRate) > conf.range[2] * conf.range[2] then
				return
			end
			monids = {target}
		elseif conf.range[1] == 1 then
			monids = obj:ScanRectObjs(x,y, posx, posy, conf.range[2], conf.range[3])
		elseif conf.range[1] == 2 then
			monids = obj:ScanFanObjs(x,y, posx, posy, conf.range[2], conf.range[3])
		elseif conf.range[1] == 3 then
			monids = obj:ScanCircleObjs(x,y, conf.range[2])
		elseif conf.range[1] == 4 and conf.range[3] > 0 then
			monids = obj:ScanCircleObjs(posx, posy, conf.range[3])
		end
	end
	return monids
end

function CheckHitBuff(buffconf)
	for i,v in ipairs(buffconf.buff) do
		if v[1] == 公共定义.额外属性_每秒回血 or v[1] == 公共定义.额外属性_每秒回血+100 or v[1] == 公共定义.额外属性_随机移动 or v[1] == 公共定义.额外属性_范围伤害 then
			return v[1]
		end
	end
end

function DoBuffAttack(obj, damage, range)
	local x,y = obj:GetPosition()
	local monids = obj:ScanCircleObjs(x, y, range)
	local objowner = obj.ownerid ~= -1 and 对象类:GetObj(obj.ownerid) or obj
	if monids then
		for _,v in ipairs(monids) do
			--生命值大于0才受击
			if v.hp > 0 and not v.iscaller then
				local targetowner = v.ownerid ~= -1 and 对象类:GetObj(v.ownerid) or v
				if objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and targetowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and
					(objowner.m_db.pkmode == 0 or objowner:GetLevel() < 公共定义.PK等级限制 or targetowner:GetLevel() < 公共定义.PK等级限制 or 场景管理.IsSafeMap(obj.m_nSceneID) == 1 or objowner.insafearea or targetowner.insafearea) then
				elseif 场景管理.IsSafeMap(obj.m_nSceneID) == 2 then
				elseif objowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and targetowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and
					objowner.teamid == 0 and targetowner.teamid == 0 then
				elseif objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and targetowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and
					objowner.m_db.pkmode == 2 and objowner.m_db.guildname ~= "" and (objowner.m_db.guildname == targetowner.m_db.guildname or 行会管理.IsAllianceGuild(objowner.m_db.guildname, targetowner.m_db.guildname)) then
				elseif objowner ~= targetowner and ((objowner.teamid == 0 and targetowner.teamid == 0) or objowner.teamid ~= targetowner.teamid) then
					DoAttackHurt(v, obj, nil, damage, 0)
				end
			end
		end
	end
end

function DoHitBuff(target, buffconf, time)
	for i,v in ipairs(buffconf.buff) do
		if v[1] == 公共定义.额外属性_每秒回血 or v[1] == 公共定义.额外属性_每秒回血+100 or
			v[1] == 公共定义.额外属性_每秒回魔 or v[1] == 公共定义.额外属性_每秒回魔+100 then
		elseif v[1] == 公共定义.额外属性_随机移动 then
			target:StopMove()
			SendControlled(target, 1, time)
			SendControlled(target, 0, time)
		elseif v[1] == 公共定义.额外属性_无法移动 then
			target:StopMove()
			SendControlled(target, 0, time)
		elseif v[1] == 公共定义.额外属性_无法攻击 then
			SendControlled(target, 1, time)
		else
			Buff逻辑.DoBuff(target, v[1], v[2], buffconf.debuff)
		end
	end
end

function DoHitBuffEnd(target, buffconf)
	for i,v in ipairs(buffconf.buff) do
		if v[1] == 公共定义.额外属性_每秒回血 or v[1] == 公共定义.额外属性_每秒回血+100 or
			v[1] == 公共定义.额外属性_每秒回魔 or v[1] == 公共定义.额外属性_每秒回魔+100 then
		elseif v[1] == 公共定义.额外属性_随机移动 or v[1] == 公共定义.额外属性_无法移动 or v[1] == 公共定义.额外属性_无法攻击 then
		else
			Buff逻辑.DoBuffEnd(target, v[1], v[2], buffconf.debuff)
		end
	end
	if target:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and buffconf.last == 1 then
		target:SendTipsMsg(2,广播.colorRgb[5]..buffconf.name.."恢复正常")
	end
end

function SendBuff(objid,buffconf,time)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_BUFF]
	oReturnMsg.objid = objid
	oReturnMsg.effid = buffconf.effid
	oReturnMsg.time = time
	oReturnMsg.icon = buffconf.icon
	oReturnMsg.infoLen = 0
	for i,v in ipairs(buffconf.buff) do
		oReturnMsg.infoLen = oReturnMsg.infoLen + 1
		oReturnMsg.info[oReturnMsg.infoLen].type = v[1]
		oReturnMsg.info[oReturnMsg.infoLen].val = v[2] or 0
	end
	
	消息类.ZoneBroadCast(oReturnMsg, objid)
end

function DoAddBuff(target, atkerid, buffid, time)
	local buffconf = Buff表[buffid]
	if not buffconf then
		return
	end
	time = time>0 and time or 9999999
	if buffconf.mutex ~= 0 then
		for k,v in pairs(target.buffhit) do
			local conf = Buff表[k]
			if k ~= buffid and conf.mutex == buffconf.mutex then
				_DelTimer(v, target.id)
				target.buffhit[k] = nil
			end
		end
		for k,v in pairs(target.buffend) do
			local conf = Buff表[k]
			if k ~= buffid and conf.mutex == buffconf.mutex then
				_DelTimer(v, target.id)
				target.buffend[k] = nil
				DoHitBuffEnd(target, conf)
			end
		end
	end
	local buffhit = CheckHitBuff(buffconf)
	if buffhit then
		if target.buffhit[buffid] then
			_DelTimer(target.buffhit[buffid], target.id)
		end
		target.buffhit[buffid] = _AddTimer(target.id, 计时器ID.TIMER_BUFF_HIT, 1000, 1, {atkerid=atkerid,buffid=buffid,hitindex=1,time=time})
	end
	if target.buffend[buffid] then
		_DelTimer(target.buffend[buffid], target.id)
		DoHitBuffEnd(target, buffconf)
	end
	DoHitBuff(target, buffconf, time)
	target.buffend[buffid] = _AddTimer(target.id, 计时器ID.TIMER_BUFF_END, time, 1, {buffid=buffid})
	SendBuff(target.id, buffconf, time)
	if target:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and buffconf.debuff == 0 then
		for i,v in ipairs(buffconf.buff) do
			local 属性 = v[1] > 100 and v[1] - 100 or v[1]
			if 公共定义.属性文字[属性] then
				target:SendTipsMsg(2,广播.colorRgb[3]..公共定义.属性文字[属性].."增加"..math.floor(time/1000).."秒")
			end
		end
	end
	target:UpdateObjInfo()
	target.updateInfoTime = math.max(target.updateInfoTime or 0, _CurrentTime() + time + 1000)
end

function DoRemoveBuff(target, buffid)
	local buffconf = Buff表[buffid]
	if not buffconf then
		return
	end
	local buffhit = CheckHitBuff(buffconf)
	if buffhit then
		if target.buffhit[buffid] then
			_DelTimer(target.buffhit[buffid], target.id)
		end
		target.buffhit[buffid] = nil
	end
	if target.buffend[buffid] then
		_DelTimer(target.buffend[buffid], target.id)
		DoHitBuffEnd(target, buffconf)
	end
	target.buffend[buffid] = nil
	SendBuff(target.id, buffconf, 0)
	target:UpdateObjInfo()
end

function DoCall(obj, target, skillid, type, callid, time, isenemy,jilv)
	
	if type == 1 then
		if not target then return end
		if not target.changebodyid then
			target.avatarid = callid
			target:ChangeBody()
			if time > 0 then
				target.changebodyid = _AddTimer(target.id, 计时器ID.TIMER_CHANGE_BODYID, time, 1, nil)
			end
			SendSkillInfo(target)
		end
	elseif type == 2 then
		
		if not target then return end
		if not CheckEffLimit(skillid, obj, target) then
			return
		end
		if target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and target:GetType() == 3 then
			return
		end
		local buffconf = Buff表[callid]
		if buffconf == nil then
			return
		end
		--if (target:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or target:GetObjType() == 公共定义.OBJ_TYPE_HERO) and
		if buffconf.debuff == 1 and target:GetAttr(公共定义.额外属性_免疫) > 0 then
			return
		end
		if (buffconf.debuff == 0 and isenemy) or (buffconf.debuff == 1 and not isenemy) then
			return
		end
		if buffconf.中毒 == 1 and target:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
			time = time*(1-target:GetAttr(公共定义.属性_中毒恢复)/100)
		end
		
		local j = math.random(1,100)
		
		if(j <= jilv) then
			DoAddBuff(target, obj.id, callid, time)
		end
	end
end

function CheckObjCallPos(obj, posx, posy)
	if not obj.calllen then
		return true
	end
	for i=1,obj.calllen do
		if obj.call[i].bornx == posx and obj.call[i].borny == posy then
			return false
		end
	end
	return true
end

function 设置召唤物属性(m, obj, skillid, damage1, damage2)
	local conf = 怪物表[m.m_nMonsterID]
	if not conf or damage1 == 0 and damage2 == 0 then
		return
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		for i,v in ipairs(obj.m_db.skills) do
			local infoconf = 技能信息表[v[1]]
			if infoconf and infoconf.passive == 0 and 实用工具.FindIndex(infoconf.skill,skillid) then
				damage1 = damage1 + (v[2]-1)*infoconf.damage1
				damage2 = damage2 + (v[2]-1)*infoconf.damage2
				break
			end
		end
		if ATTACH_SKILLS[skillid] and obj.attrattach[ATTACH_SKILLS[skillid]] then
			damage1 = damage1 + obj.attrattach[ATTACH_SKILLS[skillid]]
		end
	end
	m.属性值[公共定义.属性_防御上限] = m.属性值[公共定义.属性_防御]
	m.属性值[公共定义.属性_魔御上限] = m.属性值[公共定义.属性_魔御]
	if Config.IS3G then
		m.属性值[公共定义.属性_攻击] = (conf[公共定义.属性文字[公共定义.属性_攻击]] or 0) + obj:获取攻击()*damage1/100 + damage2
		m.属性值[公共定义.属性_攻击上限] = (conf[公共定义.属性文字[公共定义.属性_攻击上限]] or 0) + obj:获取攻击上限()*damage1/100 + damage2
		m.属性值[公共定义.属性_魔法] = (conf[公共定义.属性文字[公共定义.属性_魔法]] or 0) + obj:获取魔法()*damage1/100 + damage2
		m.属性值[公共定义.属性_魔法上限] = (conf[公共定义.属性文字[公共定义.属性_魔法上限]] or 0) + obj:获取魔法上限()*damage1/100 + damage2
		m.属性值[公共定义.属性_道术] = (conf[公共定义.属性文字[公共定义.属性_道术]] or 0) + obj:获取道术()*damage1/100 + damage2
		m.属性值[公共定义.属性_道术上限] = (conf[公共定义.属性文字[公共定义.属性_道术上限]] or 0) + obj:获取道术上限()*damage1/100 + damage2
	elseif m:获取职业() == 2 then
		if obj:获取职业() == 2 then
			m.属性值[公共定义.属性_魔法] = (conf[公共定义.属性文字[公共定义.属性_魔法]] or 0) + obj:获取魔法()*damage1/100 + damage2
			m.属性值[公共定义.属性_魔法上限] = (conf[公共定义.属性文字[公共定义.属性_魔法上限]] or 0) + obj:获取魔法上限()*damage1/100 + damage2
		elseif obj:获取职业() == 3 then
			m.属性值[公共定义.属性_魔法] = (conf[公共定义.属性文字[公共定义.属性_魔法]] or 0) + obj:获取道术()*damage1/100 + damage2
			m.属性值[公共定义.属性_魔法上限] = (conf[公共定义.属性文字[公共定义.属性_魔法上限]] or 0) + obj:获取道术上限()*damage1/100 + damage2
		else
			m.属性值[公共定义.属性_魔法] = (conf[公共定义.属性文字[公共定义.属性_魔法]] or 0) + obj:获取攻击()*damage1/100 + damage2
			m.属性值[公共定义.属性_魔法上限] = (conf[公共定义.属性文字[公共定义.属性_魔法上限]] or 0) + obj:获取攻击上限()*damage1/100 + damage2
		end
	elseif m:获取职业() == 3 then
		if obj:获取职业() == 2 then
			m.属性值[公共定义.属性_道术] = (conf[公共定义.属性文字[公共定义.属性_道术]] or 0) + obj:获取魔法()*damage1/100 + damage2
			m.属性值[公共定义.属性_道术上限] = (conf[公共定义.属性文字[公共定义.属性_道术上限]] or 0) + obj:获取魔法上限()*damage1/100 + damage2
		elseif obj:获取职业() == 3 then
			m.属性值[公共定义.属性_道术] = (conf[公共定义.属性文字[公共定义.属性_道术]] or 0) + obj:获取道术()*damage1/100 + damage2
			m.属性值[公共定义.属性_道术上限] = (conf[公共定义.属性文字[公共定义.属性_道术上限]] or 0) + obj:获取道术上限()*damage1/100 + damage2
		else
			m.属性值[公共定义.属性_道术] = (conf[公共定义.属性文字[公共定义.属性_道术]] or 0) + obj:获取攻击()*damage1/100 + damage2
			m.属性值[公共定义.属性_道术上限] = (conf[公共定义.属性文字[公共定义.属性_道术上限]] or 0) + obj:获取攻击上限()*damage1/100 + damage2
		end
	else
		if obj:获取职业() == 2 then
			m.属性值[公共定义.属性_攻击] = (conf[公共定义.属性文字[公共定义.属性_攻击]] or 0) + obj:获取魔法()*damage1/100 + damage2
			m.属性值[公共定义.属性_攻击上限] = (conf[公共定义.属性文字[公共定义.属性_攻击上限]] or 0) + obj:获取魔法上限()*damage1/100 + damage2
		elseif obj:获取职业() == 3 then
			m.属性值[公共定义.属性_攻击] = (conf[公共定义.属性文字[公共定义.属性_攻击]] or 0) + obj:获取道术()*damage1/100 + damage2
			m.属性值[公共定义.属性_攻击上限] = (conf[公共定义.属性文字[公共定义.属性_攻击上限]] or 0) + obj:获取道术上限()*damage1/100 + damage2
		else
			m.属性值[公共定义.属性_攻击] = (conf[公共定义.属性文字[公共定义.属性_攻击]] or 0) + obj:获取攻击()*damage1/100 + damage2
			m.属性值[公共定义.属性_攻击上限] = (conf[公共定义.属性文字[公共定义.属性_攻击上限]] or 0) + obj:获取攻击上限()*damage1/100 + damage2
		end
	end
end

function DoSkillEffEx(obj, target, skillid, damage)
	local conf = 技能表[skillid]
	if not conf then
		return
	end
	if #conf.effex == 0 then
		return
	end

	if conf.effex[1] == 1 and target and target:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and target.ownerid == -1 and CheckEffLimit(skillid, obj, target) then
		if math.random(1,100) <= conf.effex[2] then
			local m
			if conf.effex[2] > 0 then
				local cnt = 0
				for k,v in pairs(obj.call) do
					if v.callid and v.callskillid == skillid then
						cnt = cnt + 1
						if not m or (v.calltime or 0) < (m.calltime or 0) then
							m = v
						end
					end
				end
				if cnt >= conf.effex[3] then
					m:Destroy()
				end
			end
			m = target
			m.ownerid = obj.id
			m.teamid = obj.teamid
			obj.calllen = (obj.calllen or 0) + 1
			m.callid = obj.calllen
			m.calltime = os.time()
			m.callskillid = skillid
			obj.call[obj.calllen] = m
			m:ChangeName()
			m:UpdateObjInfo()
			if MonsterScene[m.m_nSceneID] then
				MonsterScene[m.m_nSceneID][m.id] = nil
			end
		end
	elseif conf.effex[1] == 2 and obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		if math.random(1,100) <= conf.effex[2] then
			obj:回城(true)
		end
	elseif conf.effex[1] == 3 and target and CheckEffLimit(skillid, obj, target) then
		if damage and damage > 0 then
			obj:RecoverHP(math.floor(damage * conf.effex[2] / 100))
		end
	end
end

function DoAttackHit(obj, skillid, targetid, posx, posy, hitindex)
	local monid
	if not obj or obj.m_nSceneID == -1 then
		return
	end
	local conf = 技能表[skillid]
	if not conf then
		return
	end
	local mapheight, mapwidth = _GetHeightAndWidth(obj.m_nSceneID)
	if posx <= 0 or posy <= 0 or posx >= mapwidth or posy >= mapheight then
		--return
		posx = math.max(1, math.min(mapwidth-1, posx))
		posy = math.max(1, math.min(mapheight-1, posy))
	end
	
	if #conf.call > 0 and #conf.hitpoint == hitindex then
		local callid = conf.call[2]
		if 公共定义.火墙怪物ID ~= 0 and conf.name == "火墙" then
			callid = 公共定义.火墙怪物ID
		elseif #公共定义.骷髅怪物ID > 0 and conf.name == "召唤骷髅" then
			callid = 公共定义.骷髅怪物ID[obj.GetSkillLevel and math.min(obj:GetSkillLevel(skillid),#公共定义.骷髅怪物ID) or 1]
		elseif #公共定义.神兽怪物ID > 0 and conf.name == "召唤神兽" then
			callid = 公共定义.神兽怪物ID[obj.GetSkillLevel and math.min(obj:GetSkillLevel(skillid),#公共定义.神兽怪物ID) or 1]
		elseif #公共定义.神兽变身ID > 0 and conf.name == "神兽变身" then
			callid = 公共定义.神兽变身ID[obj.GetSkillLevel and math.min(obj:GetSkillLevel(skillid),#公共定义.神兽变身ID) or 1]
		end
		if (conf.call[1] == 0 or conf.call[1] == 4) and conf.call[4] then
			local m
			local ox,oy = obj:GetPosition()
			for y=-conf.call[4],conf.call[4] do
				for x=-conf.call[4],conf.call[4] do
					if conf.call[4] > 1 or x == 0 or y == 0 then
						local callx = (conf.call[1] == 4 and ox or posx)+x*(obj.MoveGrid and obj.MoveGrid[1] or 50)
						local cally = (conf.call[1] == 4 and oy or posy)+y*(obj.MoveGrid and obj.MoveGrid[1] or 50)*(obj.Is2DScene and 1/obj.MoveGridRate or 1)
						if CheckObjCallPos(obj, callx, cally) then
							m = 怪物对象类:CreateMonster(-1, callid, callx, cally, obj.id)
							m.teamid = obj.teamid
							m:EnterScene(obj.m_nSceneID, m.bornx, m.borny)
							obj.calllen = (obj.calllen or 0) + 1
							m.callid = obj.calllen
							obj.call[obj.calllen] = m
							if conf.call[1] == 4 then
								if m.disappear then
									_DelTimer(m.disappear, m.id)
								end
								local skconf = 技能表[怪物表[m.m_nMonsterID].skill[1][1]]
								m.disappear = _AddTimer(m.id, 计时器ID.TIMER_MONSTER_DISAPPEAR, skconf.endtime[1] or (skconf.hitpoint[#skconf.hitpoint]+200), 1)
							elseif conf.call[3] > 0 then
								m.deadtime = _CurrentTime() + conf.call[3]
							end
							设置召唤物属性(m, obj, skillid, conf.damage1, conf.damage2)
							if conf.call[1] == 4 then
								DoUseSkill(m, 怪物表[m.m_nMonsterID].skill[1][1], -1, posx, posy)
							end
						end
					end
				end
			end
			return
		elseif conf.call[1] == 0 or conf.call[1] == 4 then
			local m
			if conf.mutex ~= 0 then
				for k,v in pairs(obj.call) do
					if k > 1000 and 技能表[k] and 技能表[k].mutex == conf.mutex then
						v:Destroy()
						obj.call[k] = nil
						break
					end
				end
			end
			if obj.call[skillid] then
				m = obj.call[skillid]
			end
			local ox,oy = obj:GetPosition()
			if m then
				m:LeaveScene()
				m:ChangeStatus(公共定义.STATUS_NORMAL)
				m.hp = m:获取生命值()
				m:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, m.hp)
				m.teamid = obj.teamid
				m:JumpScene(obj.m_nSceneID, conf.call[1] == 4 and ox or posx, conf.call[1] == 4 and oy or posy)
				m.bornx = conf.call[1] == 4 and ox or posx
				m.borny = conf.call[1] == 4 and oy or posy
				m.avatarid = 0
				m:ChangeBody()
				m.changebodyid = nil
				m.movegridpos = nil
				m.unattackable = nil
				m.unmovable = nil
				m.cd = {}
			else
				m = 怪物对象类:CreateMonster(-1, callid, conf.call[1] == 4 and ox or posx, conf.call[1] == 4 and oy or posy, obj.id)
				m.teamid = obj.teamid
				m:EnterScene(obj.m_nSceneID, m.bornx, m.borny)
				obj.call[skillid] = m
			end
			if conf.call[1] == 4 then
				if m.disappear then
					_DelTimer(m.disappear, m.id)
				end
				local skconf = 技能表[怪物表[m.m_nMonsterID].skill[1][1]]
				m.disappear = _AddTimer(m.id, 计时器ID.TIMER_MONSTER_DISAPPEAR, skconf.endtime[1] or (skconf.hitpoint[#skconf.hitpoint]+200), 1)
			elseif conf.call[3] > 0 then
				m.deadtime = _CurrentTime() + conf.call[3]
			end
			设置召唤物属性(m, obj, skillid, conf.damage1, conf.damage2)
			if conf.call[1] == 4 then
				DoUseSkill(m, 怪物表[m.m_nMonsterID].skill[1][1], -1, posx, posy)
			end
			
			obj.m_nMonsterID = m.m_nMonsterID
			return
		--elseif conf.call[1] == 2 and targetid == obj.id then
		--	DoCall(obj, obj, skillid, conf.call[1], conf.call[2], conf.call[3])
		end
	end
	
	if(skillid == 1125) then
		obj:增加药水属性(71,100,6)
	elseif(skillid == 1127) then
		--print(obj:获取魔法值(),"skillid="..skillid)
	elseif(skillid == 1128) then
		
	elseif(skillid == 1130) then
		obj:增加药水属性(1,68,60)
		obj:增加药水属性(2,16,60)
		obj:增加药水属性(4,29,60)
		obj:增加药水属性(6,33,60)
		obj:增加药水属性(7,4,60)
		obj:增加药水属性(8,4,60)
		obj:增加药水属性(9,4,60)
		obj:增加药水属性(10,4,60)
		obj:增加药水属性(21,2,60)
	end
	
	if obj.hp > 0 and conf.dechp > 0 then
		obj:RecoverHP(-conf.dechp)
		if obj.hp == 0 then
			if (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) and obj:GetAttr(公共定义.额外属性_复活) > 0 and (obj.canrelivetime or 0) < _CurrentTime() then
				obj:RecoverHP(obj.hpMax)
				obj.canrelivetime = _CurrentTime() + 60000
			else
				obj:CheckDead()
				副本管理.KillSceneObj(obj.m_nSceneID, obj, obj)
			end
		end
	end
	--if conf.damage1 == 0 and conf.damage2 == 0 then
	--	return
	--end
	local maxdamage = 0
	local x,y = obj:GetPosition()
	if #conf.displace > 0 and obj.dismovex and obj.dismovey and obj.disstartx and obj.disstarty then
		local rate = math.max(0, math.min(1, ((_CurrentTime() - obj.useskilltime - conf.displace[2]) / (conf.displace[3] - conf.displace[2]))))
		x = math.floor(obj.disstartx + rate * obj.dismovex)
		y = math.floor(obj.disstarty + rate * obj.dismovey)
	end
	local monids = GetHitMonIDs(obj, skillid, targetid, x, y, posx, posy)
	local Is2DScene = obj.Is2DScene
	local MoveGridRate = obj.MoveGridRate
	local objowner = obj.ownerid ~= -1 and 对象类:GetObj(obj.ownerid) or obj
	while objowner.ownerid ~= -1 do
		objowner = 对象类:GetObj(objowner.ownerid)
	end
	DoSkillEffEx(obj, nil, skillid)
	if monids then
		for _,v in ipairs(monids) do
			--生命值大于0才受击
			if v.hp > 0 and not v.iscaller then
				local useskill = false
				local targetowner = v.ownerid ~= -1 and 对象类:GetObj(v.ownerid) or v
				while targetowner.ownerid ~= -1 do
					targetowner = 对象类:GetObj(targetowner.ownerid)
				end
				if conf.benefit == 0 and objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and targetowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and
					(objowner.m_db.pkmode == 0 or objowner:GetLevel() < 公共定义.PK等级限制 or targetowner:GetLevel() < 公共定义.PK等级限制 or 场景管理.IsSafeMap(obj.m_nSceneID) == 1 or objowner.insafearea or targetowner.insafearea) then
				elseif conf.benefit == 0 and 场景管理.IsSafeMap(obj.m_nSceneID) == 2 then
				elseif objowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and targetowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and
					objowner.teamid == 0 and targetowner.teamid == 0 then
					if #conf.call > 0 then
						DoCall(obj, v, skillid, conf.call[1], conf.call[2], conf.call[3], false, conf.call[4])
					end
					if conf.benefit == 1 then
						DoAttackHurt(v, obj, skillid)
					end
					useskill = true
				elseif objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and targetowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and
					objowner.m_db.pkmode == 2 and objowner.m_db.guildname ~= "" and (objowner.m_db.guildname == targetowner.m_db.guildname or 行会管理.IsAllianceGuild(objowner.m_db.guildname, targetowner.m_db.guildname)) then
					if #conf.call > 0 then
						DoCall(obj, v, skillid, conf.call[1], conf.call[2], conf.call[3], false, conf.call[4])
					end
					if conf.benefit == 1 then
						DoAttackHurt(v, obj, skillid)
					end
					useskill = true
				elseif (objowner == targetowner or (objowner.teamid ~= 0 and objowner.teamid == targetowner.teamid)) then
					if #conf.call > 0 then
						DoCall(obj, v, skillid, conf.call[1], conf.call[2], conf.call[3], false, conf.call[4])
					end
					if conf.benefit == 1 then
						DoAttackHurt(v, obj, skillid)
					end
					useskill = true
				elseif (objowner ~= targetowner and ((objowner.teamid == 0 and targetowner.teamid == 0) or objowner.teamid ~= targetowner.teamid)) and
					((v:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and v:GetType()==0) or (not v.hitfalltime or _CurrentTime() > v.hitfalltime)) then
					if #conf.call > 0 then
						DoCall(obj, v, skillid, conf.call[1], conf.call[2], conf.call[3], true, conf.call[4])
					end
					local hitfly = 0
					local damage = 0
					if (v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or v:GetObjType() == 公共定义.OBJ_TYPE_HERO) and v:GetAttr(公共定义.额外属性_霸体) > 0 then
					elseif (v:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER or v:GetType() ~= 3) and CheckEffLimit(skillid, obj, v) and not v.displace then
						local rx,ry = v:GetPosition()
						local posx,posy
						local time
						if conf.displace[1] == 1 or conf.displace[1] == 3 then
							if obj.dismovex and obj.dismovey and conf.displace[3]-conf.hitpoint[hitindex] > 0 and not v.displace then
								v:StopMove()
								local rate = (conf.displace[3]-conf.hitpoint[hitindex])/(conf.displace[3]-conf.displace[2])
								local mx,my = obj.dismovex*rate, obj.dismovey*rate
								posx,posy=rx+mx,ry+my
								hitfly = 0
								time = conf.displace[3]-conf.hitpoint[hitindex]
							end
						elseif #conf.hitback > 0 then
							v:StopMove()
							local mx,my = 0,0
							local dist = conf.hitback[3]
							if conf.hitback[5] == 1 then
								if dist == 0 then
								elseif conf.hitback[1] == 0 then
									mx,my=rx-x<0 and -dist or dist,0
								elseif conf.hitback[1] == 1 then
									dist = math.max(0, math.min(dist, 实用工具.GetDistance(x,y,rx,ry,Is2DScene,MoveGridRate)-50))
									mx,my=x-rx<0 and -dist or dist,0
								elseif conf.hitback[1] == 2 then
									mx,my=posx-x<0 and -dist or dist,0
								elseif conf.hitback[1] == 3 then
									dist = math.max(0, math.min(dist, 实用工具.GetDistance(x,y,rx,ry,Is2DScene,MoveGridRate)-50))
									mx,my=x-posx<0 and -dist or dist,0
								elseif conf.hitback[1] == 4 then
									mx,my=rx-posx<0 and -dist or dist,0
								elseif conf.hitback[1] == 5 then
									dist = math.max(0, math.min(dist, 实用工具.GetDistance(rx,ry,posx,posy,Is2DScene,MoveGridRate)-50))
									mx,my=posx-rx<0 and -dist or dist,0
								end
							else
								if dist == 0 then
								elseif conf.hitback[1] == 0 then
									mx,my=实用工具.GetNormalize(dist,x,y,rx,ry,Is2DScene,MoveGridRate)
								elseif conf.hitback[1] == 1 then
									dist = math.max(0, math.min(dist, 实用工具.GetDistance(x,y,rx,ry,Is2DScene,MoveGridRate)-50))
									mx,my=实用工具.GetNormalize(dist,rx,ry,x,y,Is2DScene,MoveGridRate)
								elseif conf.hitback[1] == 2 then
									mx,my=实用工具.GetNormalize(dist,x,y,posx,posy,Is2DScene,MoveGridRate)
								elseif conf.hitback[1] == 3 then
									dist = math.max(0, math.min(dist, 实用工具.GetDistance(x,y,rx,ry,Is2DScene,MoveGridRate)-50))
									mx,my=实用工具.GetNormalize(dist,posx,posy,x,y,Is2DScene,MoveGridRate)
								elseif conf.hitback[1] == 4 then
									mx,my=实用工具.GetNormalize(dist,posx,posy,rx,ry,Is2DScene,MoveGridRate)
								elseif conf.hitback[1] == 5 then
									dist = math.max(0, math.min(dist, 实用工具.GetDistance(rx,ry,posx,posy,Is2DScene,MoveGridRate)-50))
									mx,my=实用工具.GetNormalize(dist,rx,ry,posx,posy,Is2DScene,MoveGridRate)
								end
							end
							if mx == 0 and my == 0 then
								my = dist
							end
							posx,posy=rx+mx,ry+my
							hitfly = conf.hitback[4]
							time = conf.hitback[2]
						end
						if posx and posy then
							if v.MoveGrid then
								posx = math.floor(posx / v.MoveGrid[1]) * v.MoveGrid[1] + v.MoveGrid[1]/2
								posy = math.floor(posy / v.MoveGrid[2]) * v.MoveGrid[2] + v.MoveGrid[2]/2
							end
							if v:IsPosCanRun(posx, posy) then
								if v.displace then
									_DelTimer(v.displace, v.id)
									DisplaceMove[v.id] = nil
								end
								v.displace = _AddTimer(v.id, 计时器ID.TIMER_DISPLACE_END, time, 1, {posx=posx,posy=posy})
								SendControlled(v, 1, time)
								SendControlled(v, 0, time)
								SendDisplace(v.id, hitfly, posx,posy,time, 1)
								v.disstarttime = _CurrentTime()
								v.disstartx = rx
								v.disstarty = ry
								v.displacex = posx
								v.displacey = posy
								v.displacetime = _CurrentTime() + time
								DisplaceMove[v.id] = v
								--local speed = math.sqrt((posx-x)*(posx-x)+(posy-y)*(posy-y)) * 1000/time
								--if speed > 0 then
								--	v:SetEngineMoveSpeed(speed)
								--	_MoveTo(v.id, posx, posy, -1)
								--end
							end
						end
					end
					local hitfall = false
					if (v:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER or v:GetType() ~= 3) and conf.benefit == 0 and #conf.hitpoint == hitindex and conf.hitfall == 1 then
						v.hitfalltime = _CurrentTime() + 3000
						SendControlled(v, 1, 2000)
						SendControlled(v, 0, 2000)
						hitfall = true
					end
					if conf.benefit == 0 then
						damage = DoAttackHurt(v, obj, skillid, 0, 0, hitfall and 2 or hitfly > 0 and 1 or 0)
						maxdamage = math.max(maxdamage, damage)
					end
					DoSkillEffEx(obj, v, skillid, damage)
					if conf.benefit == 0 and objowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and targetowner:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
						if objowner.m_db.PK值 <= 100 and targetowner.m_db.PK值 <= 100 and targetowner.graynametime == 0 and not 行会管理.IsChallengeGuild(objowner.m_db.guildname, targetowner.m_db.guildname) then
							if objowner.graynametime == 0 then
								objowner.graynametime = _CurrentTime() + 30000
								objowner:ChangeName()
								objowner:UpdateObjInfo()
							else
								objowner.graynametime = _CurrentTime() + 30000
							end
						end
					end
					useskill = true
				end
				if useskill and obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
					if v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
						local call = 事件触发._M["call_技能目标_"..skillid]
						if call then
							obj:显示对话(-2,call(obj))
						end
					elseif v:GetObjType() == 公共定义.OBJ_TYPE_MONSTER then
						local call = 事件触发._M["call_技能怪物_"..skillid]
						if call then
							obj:显示对话(-2,call(obj))
						end
					end
				end
			end
		end
	end
	if maxdamage > 0 and (obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO) then
		obj:RecoverHP(maxdamage*obj:GetAttr(公共定义.额外属性_攻击吸血)/100)
	end
end

--发送技能协议
function SendSkillInfo(human)
	if human:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_INFO]
	oReturnMsg.infoLen = 0
	if human.avatarid ~= 0 then
		local monconf = 怪物表[human.avatarid]
		if monconf then
			for i,skill in ipairs(monconf.skill) do
				oReturnMsg.infoLen = oReturnMsg.infoLen + 1
				local il = oReturnMsg.infoLen
				local skillconf = 技能表[skill[1]]
				oReturnMsg.info[il].infoid = 0
				oReturnMsg.info[il].lv = 1
				oReturnMsg.info[il].cd = skillconf.cd
				oReturnMsg.info[il].damage1 = skillconf.damage1
				oReturnMsg.info[il].damage2 = skillconf.damage2
				oReturnMsg.info[il].type = skillconf.range[1]
				oReturnMsg.info[il].range = skillconf.range[2]
				oReturnMsg.info[il].icon = monconf.bodyid
				oReturnMsg.info[il].desc = ""
				oReturnMsg.info[il].skillidLen = 1
				oReturnMsg.info[il].skillid[1] = skill[1]
				oReturnMsg.info[il].name = ""
				oReturnMsg.info[il].passive = 0
				oReturnMsg.info[il].hangup = 0
				oReturnMsg.info[il].grade = 1
				oReturnMsg.info[il].lvmax = 1
				oReturnMsg.info[il].updamage1 = 0
				oReturnMsg.info[il].updamage2 = 0
				oReturnMsg.info[il].costlevel = 0
				oReturnMsg.info[il].costitemLen = 0
				oReturnMsg.info[il].hero = 0
				oReturnMsg.info[il].decmp = 0
				oReturnMsg.info[il].special = 0
			end
		end
	else
		for _,v in ipairs(human.m_db.skills) do
			local infoid = v[1]
			local conf = 技能信息表[infoid]
			if conf then
				oReturnMsg.infoLen = oReturnMsg.infoLen + 1
				local il = oReturnMsg.infoLen
				local skillconf = 技能表[conf.skill[1]]
				oReturnMsg.info[il].infoid = infoid
				oReturnMsg.info[il].lv = v[2] or 0
				oReturnMsg.info[il].cd = skillconf and skillconf.cd or 0
				oReturnMsg.info[il].damage1 = skillconf and skillconf.damage1+(v[2]-1)*conf.damage1 or conf.damage1+(v[2]-1)*conf.damage2
				oReturnMsg.info[il].damage2 = skillconf and skillconf.damage2+(v[2]-1)*conf.damage2 or 0
				oReturnMsg.info[il].type = skillconf and skillconf.range[1] or 0
				oReturnMsg.info[il].range = skillconf and skillconf.range[2] or 0
				oReturnMsg.info[il].icon = conf.icon
				oReturnMsg.info[il].desc = conf.desc
				oReturnMsg.info[il].skillidLen = #conf.skill
				for ii,vv in ipairs(conf.skill) do
					oReturnMsg.info[il].skillid[ii] = vv
				end
				oReturnMsg.info[il].name = conf.name
				oReturnMsg.info[il].passive = conf.passive
				oReturnMsg.info[il].hangup = v[3] or 0
				oReturnMsg.info[il].grade = conf.grade
				oReturnMsg.info[il].lvmax = conf.levelmax
				oReturnMsg.info[il].updamage1 = conf.damage1
				oReturnMsg.info[il].updamage2 = conf.damage2
				oReturnMsg.info[il].costlevel = conf._costlevel(v[2]) or 0
				oReturnMsg.info[il].costitemLen = 0
				local costitem = conf._costitem(v[2])
				if costitem then
					oReturnMsg.info[il].costitemLen = 1
					oReturnMsg.info[il].costitem[1].name = 物品逻辑.GetItemName(costitem[1])
					oReturnMsg.info[il].costitem[1].count = costitem[2]
				end
				oReturnMsg.info[il].hero = 0
				oReturnMsg.info[il].decmp = skillconf and skillconf.decmp or 0
				oReturnMsg.info[il].special = conf.special
			end
		end
		for _,v in ipairs(human.m_db.英雄技能) do
			local infoid = v[1]
			local conf = 技能信息表[infoid]
			if conf then
				oReturnMsg.infoLen = oReturnMsg.infoLen + 1
				local il = oReturnMsg.infoLen
				local skillconf = 技能表[conf.skill[1]]
				oReturnMsg.info[il].infoid = infoid
				oReturnMsg.info[il].lv = v[2] or 0
				oReturnMsg.info[il].cd = skillconf and skillconf.cd or 0
				oReturnMsg.info[il].damage1 = skillconf and skillconf.damage1+(v[2]-1)*conf.damage1 or conf.damage1+(v[2]-1)*conf.damage2
				oReturnMsg.info[il].damage2 = skillconf and skillconf.damage2+(v[2]-1)*conf.damage2 or 0
				oReturnMsg.info[il].type = skillconf and skillconf.range[1] or 0
				oReturnMsg.info[il].range = skillconf and skillconf.range[2] or 0
				oReturnMsg.info[il].icon = conf.icon
				oReturnMsg.info[il].desc = conf.desc
				oReturnMsg.info[il].skillidLen = #conf.skill
				for ii,vv in ipairs(conf.skill) do
					oReturnMsg.info[il].skillid[ii] = vv
				end
				oReturnMsg.info[il].name = conf.name
				oReturnMsg.info[il].passive = conf.passive
				oReturnMsg.info[il].hangup = v[3] or 0
				oReturnMsg.info[il].grade = conf.grade
				oReturnMsg.info[il].lvmax = conf.levelmax
				oReturnMsg.info[il].updamage1 = conf.damage1
				oReturnMsg.info[il].updamage2 = conf.damage2
				oReturnMsg.info[il].costlevel = conf._costlevel(v[2]) or 0
				oReturnMsg.info[il].costitemLen = 0
				local costitem = conf._costitem(v[2])
				if costitem then
					oReturnMsg.info[il].costitemLen = 1
					oReturnMsg.info[il].costitem[1].name = 物品逻辑.GetItemName(costitem[1])
					oReturnMsg.info[il].costitem[1].count = costitem[2]
				end
				oReturnMsg.info[il].hero = 1
				oReturnMsg.info[il].decmp = skillconf and skillconf.decmp or 0
				oReturnMsg.info[il].special = conf.special
			end
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function SendSkillLearn(human, skilllearn)
	if not skilllearn or #skilllearn == 0 then
		return
	end
	while #skilllearn > 5 do
		table.remove(skilllearn, 1)
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_LEARNINFO]
	oReturnMsg.learnLen = 0
	for i,v in ipairs(skilllearn) do
		oReturnMsg.learnLen = oReturnMsg.learnLen + 1
		local il = oReturnMsg.learnLen
		local conf = 技能信息表[skilllearn[i]]
		oReturnMsg.learn[il].infoid = skilllearn[i]
		oReturnMsg.learn[il].icon = conf.icon
		oReturnMsg.learn[il].name = conf.name
		oReturnMsg.learn[il].grade = conf.grade
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function GetSkillLearn(human, 是否英雄)
	local tb = {}
	local skills = 是否英雄 and human.m_db.英雄技能 or human.m_db.skills
	if #skills >= 100 then
		return tb
	end
	for infoid,conf in ipairs(技能信息表) do
		if human.m_db.job ~= 0 and conf.autolearn == 1 and
			((not 是否英雄 and conf.hero == 0 and human.m_db.level >= conf.level and (conf.job == 0 or human.m_db.job == conf.job)) or
			(是否英雄 and conf.hero ~= 0 and human.m_db.英雄等级 >= conf.level and (conf.job == 0 or human.m_db.英雄职业 == conf.job))) then
			local learn = true
			for i,v in ipairs(skills) do
				if infoid == v[1] then
					learn = false
					break
				end
			end
			if learn then
				tb[#tb+1] = infoid
			end
		end
	end
	return tb
end

function CheckSkillLearn(human, 是否英雄)
	if human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		local skilllearn = GetSkillLearn(human, 是否英雄)
		for i,v in ipairs(skilllearn) do
			human:LearnSkill(v, 是否英雄)
		end
		SendSkillLearn(human, skilllearn)
		return #skilllearn > 0
	end
end

function DoLearnSkill(human, infoid)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_LEARN]
	oReturnMsg.result = 3
	if human:LearnSkill(infoid) then
		oReturnMsg.result = 0
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoUpgradeSkill(human, infoid)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_UPGRADE]
	oReturnMsg.result = 3
	local conf = 技能信息表[infoid]
	if not conf then
		return
	end
	if conf.hero ~= 0 and not human.英雄 then
		human:SendTipsMsg(1,"请先召唤英雄")
		return
	end
	local skills = conf.hero ~= 0 and human.m_db.英雄技能 or human.m_db.skills
	local findskill = nil
	for i,v in ipairs(skills) do
		if v[1] == infoid then
			findskill = v
			break
		end
	end
	if not findskill then
		--human:SendTipsMsg(1,"未学习该技能")
		return
	end
	if findskill[2] >= conf.levelmax then
		human:SendTipsMsg(1,"该技能已满级")
		return
	end
	local 需要等级 = conf._costlevel(findskill[2]) or 0
	if conf.hero ~= 0 then
		if 需要等级 >= 100 and human.m_db.英雄转生等级 < math.floor(需要等级/100) then
			human:SendTipsMsg(1,"英雄转生等级不足")
			return
		end
		if 需要等级 < 100 and human.英雄.m_db.level < 需要等级 then
			human:SendTipsMsg(1,"英雄等级不足")
			return
		end
	else
		if 需要等级 >= 100 and human.m_db.转生等级 < math.floor(需要等级/100) then
			human:SendTipsMsg(1,"转生等级不足")
			return
		end
		if 需要等级 < 100 and human.m_db.level < 需要等级 then
			human:SendTipsMsg(1,"等级不足")
			return
		end
	end
	local costitem = conf._costitem(findskill[2])
	if costitem then
		if 背包DB.CheckCount(human, costitem[1]) < costitem[2] then
			human:SendTipsMsg(1,物品逻辑.GetItemName(costitem[1]).."不足")
			return
		end
		背包DB.RemoveCount(human, costitem[1], costitem[2])
	end
	findskill[2] = findskill[2] + 1
	if conf.passive == 1 then
		human:CheckAttrLearn()
	end
	human:SendTipsMsg(1, "#s16,#cffff00,成功升级#cff00,"..conf.name)
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
	SendSkillInfo(human)
end

function DoDiscardSkill(human, infoid)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_DISCARD]
	oReturnMsg.result = 3
	local conf = 技能信息表[infoid]
	if not conf then
		return
	end
	local skills = conf.hero ~= 0 and human.m_db.英雄技能 or human.m_db.skills
	local findskillindex = nil
	for i,v in ipairs(skills) do
		if v[1] == infoid then
			findskillindex = i
			break
		end
	end
	if not findskillindex then
		--human:SendTipsMsg(1,"未学习该技能")
		return
	end
	table.remove(skills,findskillindex)
	local skillquicks = human.m_db.skillquicks
	for i=1,6 do
		if skillquicks[i] and skillquicks[i] == infoid then
			skillquicks[i] = 0
			SendQuickQuery(human)
			break
		end
	end
	if conf.passive == 1 then
		human:CheckAttrLearn()
	end
	human:SendTipsMsg(1, "#s16,#cffff00,丢弃技能#cff00,"..conf.name)
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
	SendSkillInfo(human)
end

function SendQuickQuery(human)
	local skillquicks = human.m_db.skillquicks
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_QUICK_LIST]
	oReturnMsg.idLen = 6
	for i=1,6 do
		if skillquicks[i] then
			oReturnMsg.id[i] = skillquicks[i]
		else
			oReturnMsg.id[i] = 0
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function DoQuickSetup(human, id)
	local skillquicks = human.m_db.skillquicks
	for i=1,6 do
		skillquicks[i] = id[i]
	end
	SendQuickQuery(human)
end

function DoSkillHangup(human, infoid, hangup)
	local conf = 技能信息表[infoid]
	if not conf then
		return
	end
	local skills = conf.hero ~= 0 and human.m_db.英雄技能 or human.m_db.skills
	local findskill = nil
	for i,v in ipairs(skills) do
		if v[1] == infoid then
			findskill = v
			break
		end
	end
	if not findskill then
		--human:SendTipsMsg(1,"未学习该技能")
		return
	end
	if conf.passive == 1 then
		human:SendTipsMsg(1,"无法设置被动技能")
		return
	end
	--if conf.skill[1] == 1101 or conf.skill[1] == 1106 then
	--	human:SendTipsMsg(1,"无法设置基础攻击技能")
	--	return
	--end
	findskill[3] = hangup == 1 and 1 or 0
	human:SendTipsMsg(1, (hangup == 1 and "#s16,#cffff00,开启" or "#s16,#cff0000,关闭").."挂机技能#cff00,"..conf.name)
	SendSkillInfo(human)
	if conf.hero ~= 0 then
		human.英雄.skills = {}--human.m_db.英雄技能
		for i,v in ipairs(human.m_db.英雄技能) do
			local skconf = 技能信息表[v[1]]
			if skconf then
				if skconf.passive == 0 and v[3] == 1 then
					human.英雄.skills[#human.英雄.skills+1] = {skconf.skill[1],100}
				end
			end
		end
	end
end
