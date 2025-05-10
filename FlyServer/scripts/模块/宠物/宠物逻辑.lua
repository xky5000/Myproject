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
local 怪物表 = require("配置.怪物表").Config
local 宠物表 = require("配置.宠物表").Config
local 宠物DB = require("宠物.宠物DB")
local 玩家属性表 = require("配置.玩家属性表").Config

function PutPetInfo(petinfo, index, db, pet)
	if db == nil then
		petinfo.index = index
		petinfo.level = 0
		petinfo.exp = 0
		petinfo.starlevel = 0
		petinfo.starexp = 0
		petinfo.icon = 0
		petinfo.name = ""
		petinfo.生命值 = 0
		petinfo.魔法值 = 0
		petinfo.防御 = 0
		petinfo.防御上限 = 0
		petinfo.魔御 = 0
		petinfo.魔御上限 = 0
		petinfo.攻击 = 0
		petinfo.攻击上限 = 0
		petinfo.魔法 = 0
		petinfo.魔法上限 = 0
		petinfo.道术 = 0
		petinfo.道术上限 = 0
		petinfo.准确 = 0
		petinfo.移动速度 = 0
		petinfo.power = 0
		petinfo.type = 0
		petinfo.grade = 0
		petinfo.bodyid = 0
		petinfo.effid = 0
		petinfo.expmax = 0
		petinfo.starexpmax = 0
		petinfo.技能图标 = 0
		petinfo.技能品质 = 0
		petinfo.技能名字 = ""
		petinfo.技能描述 = ""
		petinfo.剩余点数 = 0
	else
		local petid = pet and pet.m_nPetID or db.id
		local conf = 宠物表[petid] or 怪物表[petid]
		local humanconf = 玩家属性表[pet and pet.level or db.level]
		petinfo.index = index
		petinfo.level = pet and pet.level or db.level
		petinfo.exp = pet and pet.exp or db.exp
		petinfo.starlevel = pet and pet.starlevel or db.starlevel
		petinfo.starexp = pet and pet.starexp or db.starexp
		petinfo.icon = conf.bodyid[1] or 0
		petinfo.name = conf.name
		db.属性加点 = db.属性加点 or {}
		petinfo.生命值 = pet and pet.hpMax or ((db.wash[公共定义.属性_生命值] or conf["生命值"] or 0) + (humanconf["生命值"..conf.职业] or 0) + (db.属性加点[1] or 0)*(Config.ISWZ and 100 or 10))
		petinfo.魔法值 = pet and pet.mpMax or ((db.wash[公共定义.属性_魔法值] or conf["魔法值"] or 0) + (humanconf["魔法值"..conf.职业] or 0) + (db.属性加点[2] or 0)*(Config.ISWZ and 100 or 10))
		petinfo.防御 = pet and pet.属性值[公共定义.属性_防御] or ((db.wash[公共定义.属性_防御] or conf["防御"] or 0) + (humanconf["防御"..conf.职业] or 0) + (db.属性加点[3] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.防御上限 = pet and pet.属性值[公共定义.属性_防御上限] or ((db.wash[公共定义.属性_防御上限] or conf["防御上限"] or 0) + (humanconf["防御上限"..conf.职业] or 0) + (db.属性加点[3] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.魔御 = pet and pet.属性值[公共定义.属性_魔御] or ((db.wash[公共定义.属性_魔御] or conf["魔御"] or 0) + (humanconf["魔御"..conf.职业] or 0) + (db.属性加点[4] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.魔御上限 = pet and pet.属性值[公共定义.属性_魔御上限] or ((db.wash[公共定义.属性_魔御上限] or conf["魔御上限"] or 0) + (humanconf["魔御上限"..conf.职业] or 0) + (db.属性加点[4] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.攻击 = pet and pet.属性值[公共定义.属性_攻击] or ((db.wash[公共定义.属性_攻击] or conf["攻击"] or 0) + (humanconf["攻击"..conf.职业] or 0) + (db.属性加点[5] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.攻击上限 = pet and pet.属性值[公共定义.属性_攻击上限] or ((db.wash[公共定义.属性_攻击上限] or conf["攻击上限"] or 0) + (humanconf["攻击上限"..conf.职业] or 0) + (db.属性加点[5] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.魔法 = pet and pet.属性值[公共定义.属性_魔法] or ((db.wash[公共定义.属性_魔法] or conf["魔法"] or 0) + (humanconf["魔法"..conf.职业] or 0) + (db.属性加点[6] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.魔法上限 = pet and pet.属性值[公共定义.属性_魔法上限] or ((db.wash[公共定义.属性_魔法上限] or conf["魔法上限"] or 0) + (humanconf["魔法上限"..conf.职业] or 0) + (db.属性加点[6] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.道术 = pet and pet.属性值[公共定义.属性_道术] or ((db.wash[公共定义.属性_道术] or conf["道术"] or 0) + (humanconf["道术"..conf.职业] or 0) + (db.属性加点[7] or 0)*(Config.ISWZ and 10 or 1))
		petinfo.道术上限 = pet and pet.属性值[公共定义.属性_道术上限] or ((db.wash[公共定义.属性_道术上限] or conf["道术上限"] or 0) + (humanconf["道术上限"..conf.职业] or 0) + (db.属性加点[7] or 0)*(Config.ISWZ and 10 or 1))
		--[[petinfo.生命值 = pet and pet.hpMax or (conf.生命值 + (humanconf["生命值"..conf.职业] or 0))
		petinfo.魔法值 = pet and pet.mpMax or (conf.魔法值 + (humanconf["魔法值"..conf.职业] or 0))
		petinfo.防御 = pet and pet.属性值[公共定义.属性_防御] or (conf.防御 + (humanconf["防御"..conf.职业] or 0))
		petinfo.防御上限 = pet and pet.属性值[公共定义.属性_防御上限] or (humanconf["防御上限"..conf.职业] or 0)
		petinfo.魔御 = pet and pet.属性值[公共定义.属性_魔御] or (conf.魔御 + (humanconf["魔御"..conf.职业] or 0))
		petinfo.魔御上限 = pet and pet.属性值[公共定义.属性_魔御上限] or (humanconf["魔御"..conf.职业] or 0)
		petinfo.攻击 = pet and pet.属性值[公共定义.属性_攻击] or (conf.攻击 + (humanconf["攻击"..conf.职业] or 0))
		petinfo.攻击上限 = pet and pet.属性值[公共定义.属性_攻击上限] or (conf.攻击上限 + (humanconf["攻击上限"..conf.职业] or 0))
		petinfo.魔法 = pet and pet.属性值[公共定义.属性_魔法] or (conf.魔法 + (humanconf["魔法"..conf.职业] or 0))
		petinfo.魔法上限 = pet and pet.属性值[公共定义.属性_魔法上限] or (humanconf["魔法上限"..conf.职业] or 0)
		petinfo.道术 = pet and pet.属性值[公共定义.属性_道术] or (conf.道术 + (humanconf["道术"..conf.职业] or 0))
		petinfo.道术上限 = pet and pet.属性值[公共定义.属性_道术上限] or (humanconf["道术上限"..conf.职业] or 0)]]
		petinfo.准确 = pet and pet.属性值[公共定义.属性_准确] or conf.准确
		petinfo.移动速度 = pet and pet:获取移动速度() or conf.移动速度
		petinfo.power = petinfo.生命值/10+petinfo.魔法值/10+
			math.max(petinfo.防御,petinfo.防御上限)+
			math.max(petinfo.魔御,petinfo.魔御上限)+
			math.max(petinfo.攻击,petinfo.攻击上限)+
			math.max(petinfo.魔法,petinfo.魔法上限)+
			math.max(petinfo.道术,petinfo.道术上限)+
			petinfo.准确+petinfo.移动速度
		local 职业 = pet and pet:获取职业() or conf.职业
		petinfo.type = 职业 == 1 and 2 or 1--conf.type
		petinfo.grade = (pet and pet.grade or db.grade) or conf.grade or 1
		petinfo.bodyid = conf.bodyid[1] or 0
		petinfo.effid = conf.effid[1] or 0
		petinfo.expmax = 玩家属性表[petinfo.level].exp
		petinfo.starexpmax = petinfo.starlevel * 100
		if conf.skilldesc and #conf.skilldesc > 0 then
			petinfo.技能图标 = conf.skilldesc[1]
			petinfo.技能品质 = 1
			petinfo.技能名字 = conf.skilldesc[2]
			petinfo.技能描述 = conf.skilldesc[3]
		else
			petinfo.技能图标 = 0
			petinfo.技能品质 = 0
			petinfo.技能名字 = ""
			petinfo.技能描述 = ""
		end
		local 点数 = 0
		for k,v in pairs(db.属性加点) do
			点数 = 点数 + v
		end
		petinfo.剩余点数 = math.max(0, (petinfo.starlevel - 1) - 点数)
	end
end

function FindPet(tb, index)
	for i,v in ipairs(tb) do
		if v.index == index then
			return v
		end
	end
end

function SendPetInfo(human, indexs, callindexs)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_PET_INFO]
	oReturnMsg.petinfoLen = 0
	if indexs then
		for i,index in ipairs(indexs) do
			oReturnMsg.petinfoLen = oReturnMsg.petinfoLen + 1
			PutPetInfo(oReturnMsg.petinfo[oReturnMsg.petinfoLen], index, FindPet(human.m_db.petdb.db, index), human.pet[index])
		end
	else
		for i,v in ipairs(human.m_db.petdb.db) do
			oReturnMsg.petinfoLen = oReturnMsg.petinfoLen + 1
			PutPetInfo(oReturnMsg.petinfo[oReturnMsg.petinfoLen], v.index, v, human.pet[v.index])
		end
	end
	oReturnMsg.callinfoLen = 0
	if callindexs then
		for i,index in ipairs(callindexs) do
			local v = FindPet(human.m_db.petdb.call, index)
			oReturnMsg.callinfoLen = oReturnMsg.callinfoLen + 1
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].index = index
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].call = v and 1 or 0
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].merge = v and v.merge or 0
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].objid = human.pet[index] and human.pet[index].id or -1
		end
	else
		for i,v in ipairs(human.m_db.petdb.call) do
			oReturnMsg.callinfoLen = oReturnMsg.callinfoLen + 1
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].index = v.index
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].call = 1
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].merge = v.merge
			oReturnMsg.callinfo[oReturnMsg.callinfoLen].objid = human.pet[v.index] and human.pet[v.index].id or -1
		end
	end
	消息类.SendMsg(oReturnMsg, human.id)
end

function TrainPet(human, index1, index2)
	if human.hp <= 0 then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_TRAIN_PET]
	if index1 == index2 then
		human:SendTipsMsg(1,"主副宠不能为同一个")
		oReturnMsg.result = 1
		消息类.SendMsg(oReturnMsg, human.id)
		return
	end
	local pet1 = FindPet(human.m_db.petdb.db, index1)
	if not pet1 then
		human:SendTipsMsg(1,"找不到主宠")
		oReturnMsg.result = 2
		消息类.SendMsg(oReturnMsg, human.id)
		return
	end
	local pet2 = FindPet(human.m_db.petdb.db, index2)
	if not pet2 then
		human:SendTipsMsg(1,"找不到副宠")
		oReturnMsg.result = 3
		消息类.SendMsg(oReturnMsg, human.id)
		return
	end
	--if 宠物表[pet1.id].type == 0 then
	--	human:SendTipsMsg(1,"特殊宠物不能培养")
	--	oReturnMsg.result = 4
	--	消息类.SendMsg(oReturnMsg, human.id)
	--	return
	--end
	if 宠物DB.FindIndex(human.m_db.petdb.call, index2) then
		human:SendTipsMsg(1,"出战宠物不能作为副宠")
		oReturnMsg.result = 5
		消息类.SendMsg(oReturnMsg, human.id)
		return
	end
	local exp = pet2.exp + 100
	local level = pet2.level
	while level > 1 do
		exp = exp + 玩家属性表[level - 1].exp
		level = level - 1
	end
	exp = math.floor(exp * 0.8)
	if human.pet[index1] then
		human.pet[index1]:AddExp(exp)
	else
		pet1.exp = pet1.exp + exp
		while 1 do
			local expmax = 玩家属性表[pet1.level].exp
			if pet1.exp >= expmax then
				pet1.exp = pet1.exp - expmax
				pet1.level = pet1.level + 1
			else
				break
			end
		end
	end
	local starexp = pet2.starexp + (pet2.grade == 5 and 150 or pet2.grade == 4 and 100 or pet2.grade == 3 and 60 or pet2.grade == 2 and 30 or 10)
	local starlevel = pet2.starlevel
	while starlevel > 1 do
		starexp = starexp + (starlevel - 1) * 100
		starlevel = starlevel - 1
	end
	starexp = math.floor(starexp * 0.8)
	if human.pet[index1] then
		human.pet[index1]:AddStarExp(starexp)
	else
		pet1.starexp = pet1.starexp + starexp
		while 1 do
			local starexpmax = pet1.starlevel * 100
			if pet1.starexp >= starexpmax then
				pet1.starexp = pet1.starexp - starexpmax
				pet1.starlevel = pet1.starlevel + 1
			else
				break
			end
		end
	end
	SendPetInfo(human, {index1}, {index1})
	宠物DB.RemovePet(human, index2)
	oReturnMsg.result = 0
	消息类.SendMsg(oReturnMsg, human.id)
end

function AddPointPet(human, index, 类型)
	if human.hp <= 0 then
		return
	end
	if 类型 < 1 or 类型 > 7 then
		human:SendTipsMsg(1,"属性加点类型错误")
		return
	end
	local pet = FindPet(human.m_db.petdb.db, index)
	if not pet then
		human:SendTipsMsg(1,"找不到宠物")
		return
	end
	pet.属性加点 = pet.属性加点 or {}
	local 点数 = 0
	for k,v in pairs(pet.属性加点) do
		点数 = 点数 + v
	end
	local starlevel = human.pet[index] and human.pet[index].starlevel or pet.starlevel
	if starlevel - 1 <= 点数 then
		human:SendTipsMsg(1,"宠物属性加点数已满")
		return
	end
	pet.属性加点[类型] = (pet.属性加点[类型] or 0) + 1
	if human.pet[index] then
		human.pet[index]:CheckAttrLearn()
	end
	SendPetInfo(human, {index})
	human:SendTipsMsg(1,"#cffff00,宠物属性加点成功")
end
