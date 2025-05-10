module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 背包逻辑 = require("物品.背包逻辑")
local 宠物逻辑 = require("宠物.宠物逻辑")
local 物品逻辑 = require("物品.物品逻辑")
local 怪物表 = require("配置.怪物表").Config

function AddExpItem(human, dropexp)
	local indexs = {}
	for k,pet in pairs(human.pet) do
		indexs[#indexs+1] = k
	end
	local addexp = dropexp--math.floor(dropexp/(#indexs+1))
	if human:GetAttr(公共定义.额外属性_双倍经验) > 0 then
		addexp = addexp * 2
	end
	if human:AddExp(addexp) then
		human:SendTipsMsg(2, "获得#cffff00,"..addexp.."经验")
	end
	if human.英雄 and human.英雄:AddExp(addexp) then
		human:SendTipsMsg(2, "英雄获得#cffff00,"..addexp.."经验")
	end
	for k,pet in pairs(human.pet) do
		if pet:AddExp(addexp) then
			human:SendTipsMsg(2, 广播.colorRgb[pet:GetGrade()]..pet:GetName().."#C获得#cffff00,"..addexp.."经验")
		end
	end
	if #indexs > 0 then
		宠物逻辑.SendPetInfo(human, indexs)
	end
end

function 宠物蛋极品属性(strengthen,grade)
	local wash = {}
	local monconf = 怪物表[strengthen]
	if monconf then
		for i,v in ipairs(公共定义.属性文字) do
			if i < 公共定义.属性_幸运 and monconf[v] and monconf[v] > 0 then
				local val = math.ceil(monconf[v] * grade * 0.2)
				wash[#wash+1] = {i,math.random(1,val)}
			end
		end
	end
	return wash
end

function 自动升级属性(job)
	local wash = {}
	local keys = nil
	if job == 1 then
		keys = {3,4,5,6,7,8}
	elseif job == 2 then
		keys = {3,4,5,6,9,10}
	elseif job == 3 then
		keys = {3,4,5,6,11,12}
	else
		keys = {3,4,5,6,7,8,9,10,11,12}
	end
	local cnt = math.random(1,公共定义.装备掉落属性)
	for i=1,cnt do
		local key = math.random(1,#keys)
		local index = nil
		for ii,vv in ipairs(wash) do
			if vv[1] == keys[key] then
				vv[2] = vv[2] + 1
				index = ii
				break
			end
		end
		if not index then
			wash[#wash+1] = {keys[key],1}
		end
	end
	return wash
end

function 自动极品属性(maxcnt,propval,job)
	local wash = {}
	local keys = nil
	if job == 1 then
		keys = {3,4,5,6,7,8}
	elseif job == 2 then
		keys = {3,4,5,6,9,10}
	elseif job == 3 then
		keys = {3,4,5,6,11,12}
	else
		keys = {3,4,5,6,7,8,9,10,11,12}
	end
	for i=1,maxcnt do
		wash[i] = wash[i] or {}
		local key = math.random(1,#keys)
		wash[i][1] = keys[key]
		table.remove(keys,key)
		wash[i][2] = math.random(1,Config.ISWZ and propval*10 or propval)
	end
	return wash
end

function SendPickItem(human, itemobjid)
	if not human.hp or human.hp <= 0 then
		return
	end
	local 物品 = 对象类:GetObj(itemobjid)
	if 物品 == nil then
		return
	end
	if 物品:GetObjType() ~= 公共定义.OBJ_TYPE_ITEM then
		return
	end
	local conf = 物品:GetItemConfig()
	if conf == nil then
		return
	end
	if 物品.m_nSceneID == -1 or human.m_nSceneID ~= 物品.m_nSceneID then
		return
	end
	local x,y = human:GetPosition()
	local ix,iy = 物品:GetPosition()
	if human.m_db.物品自动拾取 == 0 and 实用工具.GetDistanceSq(x,y,ix,iy,human.Is2DScene,human.MoveGridRate) > 90000 then
		human:SendTipsMsg(1,"距离太远")
		return
	end
	if 物品.m_nOwnerId ~= -1 and 物品.m_nOwnerId ~= human.id and (物品.teamid == 0 or 物品.teamid ~= human.teamid) then
		human:SendTipsMsg(1,"该物品不属于你")
		return
	end
	if 物品.m_nItemId == 公共定义.经验物品ID then
		AddExpItem(human, 物品.m_nCount)
		物品:Destroy()
		return
	end
	if 物品逻辑.GetItemType1(物品.m_nItemId) == 3 and 物品逻辑.GetItemType2(物品.m_nItemId) == 14 and not 物品.wash then
		物品.wash = 宠物蛋极品属性(物品.strengthen,物品.grade or 1)
	elseif 物品逻辑.GetItemType1(物品.m_nItemId) == 3 and not 物品.wash and 公共定义.装备掉落属性 > 0 then
		物品.wash = 自动升级属性()
	elseif 物品逻辑.GetItemType1(物品.m_nItemId) == 3 and not 物品.wash and 物品.grade and 物品.grade > 1 then
		物品.wash = 自动极品属性(物品.grade-1,物品.grade-1)
	end
	local indexs = human:PutItemGrids(物品.m_nItemId, 物品.m_nCount, (物品.m_nItemId == 公共定义.金币物品ID or 物品.m_nItemId == 公共定义.元宝物品ID) and 1 or 0, true, 物品.grade, 物品.strengthen, 物品.wash, 物品.attach, 物品.gem, 物品.ringsoul) or {}
	if 物品.m_nItemId ~= 公共定义.金币物品ID and 物品.m_nItemId ~= 公共定义.元宝物品ID and #indexs == 0 then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	if #indexs > 0 then
		背包逻辑.SendBagQuery(human, indexs)
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_PICK_ITEM]
	oReturnMsg.objid = itemobjid
	消息类.SendMsg(oReturnMsg, human.id)
	if 物品逻辑.GetItemType1(物品.m_nItemId) == 3 and 物品逻辑.GetItemType2(物品.m_nItemId) ~= 14 and 物品逻辑.GetItemLevel(物品.m_nItemId) < human.m_db.自动分解等级 and 物品.grade and
		((物品.grade == 1 and human.m_db.自动分解白 == 1) or
		(物品.grade == 2 and human.m_db.自动分解绿 == 1) or
		(物品.grade == 3 and human.m_db.自动分解蓝 == 1) or
		(物品.grade == 4 and human.m_db.自动分解紫 == 1) or
		(物品.grade == 5 and human.m_db.自动分解橙 == 1)) then
		背包逻辑.DoResolveItem(human, indexs)
	elseif 物品逻辑.GetItemType1(物品.m_nItemId) == 3 and 物品逻辑.GetItemType2(物品.m_nItemId) == 14 and 物品.grade and
		((物品.grade == 1 and human.m_db.自动分解宠物白 == 1) or
		(物品.grade == 2 and human.m_db.自动分解宠物绿 == 1) or
		(物品.grade == 3 and human.m_db.自动分解宠物蓝 == 1) or
		(物品.grade == 4 and human.m_db.自动分解宠物紫 == 1) or
		(物品.grade == 5 and human.m_db.自动分解宠物橙 == 1)) then
		背包逻辑.DoResolveItem(human, indexs)
	elseif 物品逻辑.GetItemType1(物品.m_nItemId) == 3 and 物品逻辑.GetItemType2(物品.m_nItemId) == 14 and human.m_db.自动孵化宠物蛋 == 1 then
		背包逻辑.DoEquipEndue(human, indexs[1], 0, 0)
	else
		if 物品.m_nItemId == 公共定义.金币物品ID then
			human:SendTipsMsg(2, "获得绑定金币#cffff00,"..物品:GetCount())
		elseif 物品.m_nItemId == 公共定义.元宝物品ID then
			human:SendTipsMsg(2, "获得绑定元宝#cffff00,"..物品:GetCount())
		else
			human:SendTipsMsg(2, "获得物品"..(广播.colorRgb[物品:GetGrade()] or "")..物品:GetName()..(物品:GetCount() > 1 and "x"..物品:GetCount() or ""))
		end
		human:AddQuickItem(物品.m_nItemId)
	end
	物品:Destroy()
	return true
end
