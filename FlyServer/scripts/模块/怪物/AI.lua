module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 计时器ID = require("公用.计时器ID")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 技能逻辑 = require("技能.技能逻辑")
local 公共定义 = require("公用.公共定义")
local 技能表 = require("配置.技能表").Config
local Buff表 = require("配置.Buff表").Config
local 怪物表 = require("配置.怪物表").Config
local 背包逻辑 = require("物品.背包逻辑")
local 物品表 = require("配置.物品表").Config
local 拾取物品逻辑 = require("怪物.拾取物品逻辑")
local 地图表 = require("配置.地图表").Config
local 广播 = require("公用.广播")
local 行会管理 = require("行会.行会管理")
local 城堡管理 = require("行会.城堡管理")

AI_STATIC = 0       -- 采集物
AI_NORMAL = 1       -- 普通怪
AI_ATTACK = 2       -- 主动怪
AI_JUMP_POINT = 3   -- 传送点

local AI={}

AI[AI_STATIC] = {}

function GetAttackRange(obj, conf)
	local skilltb = (obj.isrobot or obj.useskills) and obj.skills or conf.skill
	if skilltb[1] then
		local skconf = 技能表[skilltb[1][1]]
		return skconf.range[2]
	end
	return 0
end

function GetAttackRangeSq(obj, conf)
	local skilltb = (obj.isrobot or obj.useskills) and obj.skills or conf.skill
	if skilltb[1] then
		local skconf = 技能表[skilltb[1][1]]
		return skconf.range[2] * skconf.range[2]
	end
	return 0
end

function IsSelfSkill(skconf)
	if skconf.range[1] == 5 then
		return true
	elseif skconf.call[1] == 0 then
		return skconf.range[1] == 0
	elseif skconf.call[1] == 2 then
		local buffconf = Buff表[skconf.call[2]]
		return buffconf.debuff == 0
	end
	return false
end

function CheckCallSkill(skconf, x, y, tx, ty)
	if skconf.call[1] == 0 then
		local mx = tx - x
		local my = tx - y
		local dist = math.sqrt((tx - x) * (tx - x) + (ty - y) * (ty - y))
		return x + mx * skconf.range[2] / dist, y + my * skconf.range[2] / dist
	end
	return tx, ty
end

function CheckHasSkill(obj, conf)
	local skilltb = (obj.isrobot or obj.useskills) and obj.skills or conf.skill
	return #skilltb > 0
end

function GetSkillUsable(obj, conf, posx, posy)
	if obj.unattackable then
		return
	end
	local time=_CurrentTime()
	local skillconf={}
	local weight=0
	local skilltb = (obj.isrobot or obj.useskills) and obj.skills or conf.skill
	for _,skill in ipairs(skilltb) do
		if obj.cd[skill[1]] == nil or obj.cd[skill[1]] < time then
			local skconf = 技能表[skill[1]]
			if skconf.decmp > 0 and obj:GetObjType() == 公共定义.OBJ_TYPE_HERO and obj.mp < skconf.decmp then
			else
				local x,y = obj:GetPosition()
				if skconf.call[1] == 0 or skconf.range[1] == 5 or 实用工具.GetDistanceSq(x,y,posx,posy,obj.Is2DScene,obj.MoveGridRate) <= skconf.range[2] * skconf.range[2] then
					skillconf[#skillconf+1] = skill
					weight = weight + skill[2]
				end
			end
		end
	end
	if #skillconf == 0 then
		return
	end
	local wei = math.random(1,weight)
	weight=0
	for _,skill in ipairs(skillconf) do
		weight = weight + skill[2]
		if wei <= weight then
			return skill[1]
		end
	end
end

function DoAI(nObjID)
	local obj = 怪物对象类:GetObj(nObjID)
	if obj == nil then
		return
	end
	--跳转点逻辑
	if obj:GetObjType() == 公共定义.OBJ_TYPE_JUMP then
		if obj:GetMonsterObserverNum() > 0 then
			local conf = obj:GetNPCConfig()
			if conf and #conf.func > 0 and conf.func[1][2] == 2 then
				local x,y = obj:GetPosition()
				local humans = obj:ScanHuman(x,y,Config.IS3G and 60 or 30)
				if humans and #humans > 0 then
					local mapid = conf.func[1][3]
					local mapconf = 地图表[mapid]
					if mapconf then
						local nSceneID = 场景管理.GetSceneId(mapid, true)
						for _,v in ipairs(humans) do
							if v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and v:GetLevel() >= mapconf.level then
								if 城堡管理.ForbidMapID[mapid] == nil or v.m_db.guildname == 城堡管理.ForbidMapID[mapid] or
									行会管理.IsAllianceGuild(v.m_db.guildname, 城堡管理.ForbidMapID[mapid]) then
									v:JumpScene(nSceneID, conf.func[1][4], conf.func[1][5])
								end
							end
						end
					end
				end
			end
		end
		return
	end
	if obj.updateInfoTime and obj.updateInfoTime > _CurrentTime() then
		if obj.updateInfoCnt == nil then
			obj.updateInfoCnt = 1
		elseif obj.updateInfoCnt == 1 then
			obj:UpdateObjInfo()
			obj.updateInfoCnt = nil
		end
	elseif obj.updateInfoTime then
		obj.updateInfoTime = nil
	end
	--死亡复活逻辑
	if obj.deadtime and obj.deadtime > 0 and obj.deadtime < _CurrentTime() then
		obj.deadtime = 0
		obj:RecoverHP(-obj:获取生命值())
		obj:CheckDead()
		return
	end
	if obj.disappeartime and obj.disappeartime > 0 and obj.disappeartime < _CurrentTime() then
		if obj.callid or obj.relivetime == -1 then
			obj:Destroy()
		else
			obj:LeaveScene()
			obj.disappeartime = 0
		end
		return
	end
	if obj.relivetime and obj.relivetime > 0 and obj.relivetime < _CurrentTime() then
		if obj.m_nSceneID ~= -1 then
			obj:RecoverHP(obj:获取生命值())
		  if obj:GetObjType() == 公共定义.OBJ_TYPE_HERO and Config.ISLT then
			obj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, 1)
			obj.inrunbock = true
		  end
		end
		obj.relivetime = nil
		return
	end
	--没有任何玩家看到,30秒后回血
	if obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj:GetType() == 0 and obj.hp < obj:获取生命值() then
		if (obj.isrobot or obj:GetType() == 3) and not obj.istdmonster then --英雄或箭塔
			if not obj.recoverHP then
				obj.recoverHP = _CurrentTime() + 5000
			elseif obj.recoverHP < _CurrentTime() then
				obj:RecoverHP(50)
				obj.recoverHP = _CurrentTime() + 5000
			end
		elseif obj:GetMonsterObserverNum() == 0 and not obj.istdmonster then
			if not obj.recoverHP then
				obj.recoverHP = _CurrentTime() + 30000
			elseif obj.recoverHP < _CurrentTime() then
				obj.hp = obj:获取生命值()
				obj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, obj.hp)
				obj.recoverHP = nil
			end
		else
			obj.recoverHP = nil
		end
	end
	--DoMoveAI(obj)
end

function DoMoveAI(obj)
	if obj.m_nSceneID == -1 then
		return
	end
	if obj.movegridpos then
		obj:ChangePosition(obj.movegridpos[1], obj.movegridpos[2])
		obj.movegridpos = nil
	end
	local conf
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HERO then
		conf = 怪物表[公共定义.英雄怪物ID]
	else
		conf = obj.avatarid ~= 0 and 怪物表[obj.avatarid] or obj:GetConfig()
	end
	if conf == nil then
		return
	end
	local bx,by = obj:GetBornPos()
	--死亡未退场景,不管他
	if obj.hp <= 0 and obj.avatarid ~= 公共定义.宠物死亡ID then
		if obj:IsMoving() then
			obj:StopMove()
		end
		return
	end
	local x,y = obj:GetPosition()
	--获取造成最大伤害的玩家
	local target = nil
	local demage = 0
	if obj.avatarid ~= 公共定义.宠物死亡ID then--and obj:获取移动速度() > 0 then
		for k,v in pairs(obj.enmity) do
			if not k.hp or k.iscaller or k.hp <= 0 or k.m_nSceneID ~= obj.m_nSceneID or (obj.teamid ~= 0 and obj.teamid == k.teamid) or (obj.ownerid ~= -1 and obj.ownerid == k.ownerid) then
				if k.enemy then
					k.enemy[obj] = nil
				end
				obj.enmity[k] = nil
			elseif v > demage then
				if obj:获取移动速度() == 0 then
					local nX, nY = k:GetPosition()
					if 实用工具.GetDistanceSq(x,y,nX,nY,obj.Is2DScene,obj.MoveGridRate) <= GetAttackRangeSq(obj, conf) then
						demage = v
						target = k
					end
				else
					demage = v
					target = k
				end
			end
		end
	end
	--寻找警戒区的玩家
	if not target and conf.guard > 0 and (obj:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER or obj:GetMonsterObserverNum() > 0) and CheckHasSkill(obj, conf) then
		local humans = obj:ScanCircleObjs(x,y,conf.guard)
		if humans and #humans > 0 then
			local objowner = obj.ownerid ~= -1 and 对象类:GetObj(obj.ownerid) or obj
			while objowner.ownerid ~= -1 do
				objowner = 对象类:GetObj(objowner.ownerid)
			end
			local dist
			for _,v in ipairs(humans) do
				local targetowner = v.ownerid ~= -1 and 对象类:GetObj(v.ownerid) or v
				while targetowner.ownerid ~= -1 do
					targetowner = 对象类:GetObj(targetowner.ownerid)
				end
				if v.hp > 0 and not v.iscaller and not v.是否练功师 and (not obj.是否练功师 or (v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and v.m_db.PK值 > 100)) then
					if (v:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or v:GetObjType() == 公共定义.OBJ_TYPE_HERO) and
						(v:GetAttr(公共定义.额外属性_潜行) > 0 or (v:GetAttr(公共定义.额外属性_隐身) > 0 and obj:GetLevel() < v:GetLevel())) then
					elseif objowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and targetowner:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and
						objowner.teamid == 0 and targetowner.teamid == 0 then
					elseif objowner ~= targetowner and (obj:获取移动速度() == 0 or objowner:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN or targetowner:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN) and
						((objowner.teamid == 0 and targetowner.teamid == 0) or objowner.teamid ~= targetowner.teamid) then
						--if obj.specialmonster then
							local nX, nY = v:GetPosition()
							local distsq = 实用工具.GetDistanceSq(x,y,nX,nY,obj.Is2DScene,obj.MoveGridRate)
							if not dist or distsq < dist then
								dist = distsq
								target = v
							end
						--else
						--	target = v
						--	break
						--end
					end
				end
			end
		end
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_PET or obj:GetObjType() == 公共定义.OBJ_TYPE_HERO or (obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and not obj.iscaller and obj.ownerid ~= -1) then
		local ownerobj = 对象类:GetObj(obj.ownerid)
		if not ownerobj or ownerobj.m_nSceneID == -1 then
			return
		elseif ownerobj.m_nSceneID ~= obj.m_nSceneID or 实用工具.GetDistanceSq(x,y,bx,by,obj.Is2DScene,obj.MoveGridRate) > conf.chase * conf.chase * 4 then
			for k,v in pairs(obj.enmity) do
				if k.enemy then
					k.enemy[obj] = nil
				end
				obj.enmity[k] = nil
			end
			if ownerobj.m_nSceneID ~= -1 then
				obj:JumpScene(ownerobj.m_nSceneID,bx,by)
			end
			if obj:获取移动速度() > 0 and not obj.unmovable then
				local nX, nY = 实用工具.GetRandPos(bx, by, conf.patrol,obj.Is2DScene,obj.MoveGridRate)
				obj:MoveTo(nX, nY)
			end
			return
		elseif target then
			if 实用工具.GetDistanceSq(x,y,bx,by,obj.Is2DScene,obj.MoveGridRate) > conf.chase * conf.chase then
				--超出追击范围
				if target.enemy then
					target.enemy[obj] = nil
				end
				obj.enmity[target] = nil
				if obj:获取移动速度() > 0 and not obj.unmovable then
					local nX, nY = 实用工具.GetRandPos(bx, by, conf.patrol,obj.Is2DScene,obj.MoveGridRate)
					obj:MoveTo(nX, nY)
				end
				return
			end
		elseif 实用工具.GetDistanceSq(x,y,bx,by,obj.Is2DScene,obj.MoveGridRate) > conf.patrol * conf.patrol then
			if obj:获取移动速度() > 0 and not obj.unmovable then
				local nX, nY = 实用工具.GetRandPos(bx, by, conf.patrol,obj.Is2DScene,obj.MoveGridRate)
				obj:MoveTo(nX, nY)
			end
			return
		end
	end
	--攻击或移动至目标
	if target and CheckHasSkill(obj, conf) then
		local tx,ty = target:GetPosition()
		local skillid = GetSkillUsable(obj, conf, tx, ty)
		local skconf = 技能表[skillid]
		if 实用工具.GetDistanceSq(x,y,tx,ty,obj.Is2DScene,obj.MoveGridRate) <= 400 and
			obj:MoveTo(实用工具.GetRandPos(x, y, 50,obj.Is2DScene,obj.MoveGridRate)) then--obj:MoveTo(x+x-tx, y+y-ty) then
		elseif skillid and IsSelfSkill(skconf) then
			--tx, ty = CheckCallSkill(技能表[skillid], x, y, tx, ty)
			if obj.ownerid ~= -1 and skconf.range[2] > 0 then
				local ox,oy = 对象类:GetObj(obj.ownerid):GetPosition()
				技能逻辑.DoUseSkill(obj, skillid, obj.ownerid, ox, oy)
			else
				技能逻辑.DoUseSkill(obj, skillid, obj.id, x, y)
			end
		elseif skillid and 技能逻辑.DoUseSkill(obj, skillid, target.id, tx, ty) then
			--攻击
		elseif 实用工具.GetDistanceSq(x,y,tx,ty,obj.Is2DScene,obj.MoveGridRate) <= GetAttackRangeSq(obj, conf) then
			--原地待命
		elseif 实用工具.GetDistanceSq(x,y,bx,by,obj.Is2DScene,obj.MoveGridRate) > conf.chase * conf.chase then
			--超出追击范围
			if target.enemy then
				target.enemy[obj] = nil
			end
			obj.enmity[target] = nil
			--if specialmonster then
			--	obj.bornx = x
			--	obj.borny = y
			--	local nX, nY = 实用工具.GetRandPos(bx, by, conf.patrol,obj.Is2DScene,obj.MoveGridRate)
			--	obj:MoveTo(nX, nY)
			--else
				obj:JumpScene(obj.m_nSceneID,bx,by)
			--end
		elseif obj:获取移动速度() == 0 then
			--可能是箭塔
		elseif obj.unmovable then
			--可能被束缚了
		elseif #conf.skill > 0 then
			--来回移动
			if not obj:MoveTo(tx, ty) then
				local nX, nY
				if obj.isaimove then
					local dir = math.random(1,2) == 1 and 1 or -1
					nX, nY = x+(ty-y)*dir,y-(tx-x)*dir
				else
					nX, nY = 实用工具.GetRandPos(bx, by, conf.patrol,obj.Is2DScene,obj.MoveGridRate)
				end
				obj:MoveTo(nX, nY)
			end
		end
		return
	end
	if petpickitem and (obj:GetObjType() == 公共定义.OBJ_TYPE_PET or obj.isrobot) and not obj.istdmonster then
		local picks = obj:ScanItem(x,y,50)
		if picks and #picks > 0 then
			local human = obj:GetObjType() == 公共定义.OBJ_TYPE_PET and 对象类:GetObj(obj.ownerid) or nil
			for _,v in ipairs(picks) do
				if v.m_nOwnerId == -1 or v.m_nOwnerId == obj.id or (v.teamid ~= 0 and v.teamid == obj.teamid) then
					if v.m_nItemId == 公共定义.经验物品ID then
						if human then
							拾取物品逻辑.AddExpItem(human, v.m_nCount)
						else
							obj:AddExp(v.m_nCount)
						end
					elseif human and 背包逻辑.GetEmptyIndex(human) then
						local indexs = human:PutItemGrids(v.m_nItemId, v.m_nCount, (v.m_nItemId == 公共定义.金币物品ID or v.m_nItemId == 公共定义.元宝物品ID) and 1 or 0, true) or {}
						if v.m_nItemId ~= 公共定义.金币物品ID and v.m_nItemId ~= 公共定义.元宝物品ID and #indexs == 0 then
							human:SendTipsMsg(1,"背包不足")
							return
						end
						if indexs then
							背包逻辑.SendBagQuery(human, indexs)
						end
						if v.m_nItemId == 公共定义.金币物品ID then
							human:SendTipsMsg(2, "获得绑定金币#cffff00,"..v.m_nCount)
						elseif v.m_nItemId == 公共定义.元宝物品ID then
							human:SendTipsMsg(2, "获得绑定元宝#cffff00,"..v.m_nCount)
						else
							human:SendTipsMsg(2, "获得物品"..广播.colorRgb[v:GetGrade()]..v:GetName()..(v.m_nCount > 1 and "x"..v.m_nCount or ""))
						end
						human:AddQuickItem(v.m_nItemId)
					elseif 物品表[v.m_nItemId].type1 == 3 then
						obj.items[#obj.items+1] = {v.m_nItemId,v.m_nCount,1000}
					else
						local leftcnt = v.m_nCount
						for _,物品 in ipairs(obj.items) do
							if 物品[1] == v.m_nItemId and 物品[2] < 背包逻辑.GRID_COUNT_MAX then
								if 物品[2] + leftcnt > 背包逻辑.GRID_COUNT_MAX then
									leftcnt = 物品[2] + leftcnt - 背包逻辑.GRID_COUNT_MAX
									物品[2] = 背包逻辑.GRID_COUNT_MAX
								else
									leftcnt = 0
									物品[2] = 物品[2] + leftcnt
									break
								end
							end
						end
						if leftcnt > 0 then
							obj.items[#obj.items+1] = {v.m_nItemId,leftcnt,1000}
						end
					end
					v:Destroy()
					return
				end
			end
		end
		if obj:获取移动速度() > 0 and not obj.unmovable then
			local items = conf.patrol > 0 and obj:ScanItem(x,y,conf.patrol)
			if items and #items > 0 then
				for _,v in ipairs(items) do
					if v.m_nOwnerId == -1 or v.m_nOwnerId == obj.id or (v.teamid ~= 0 and v.teamid == obj.teamid) then
						local nX, nY = v:GetPosition()
						if obj:MoveTo(nX, nY) then
							return
						end
					end
				end
			end
		end
	end
	if obj.movepos and obj.moveposindex <= #obj.movepos and obj:获取移动速度() > 0 and not obj.unmovable then
		if obj.movepos[obj.moveposindex][3] == 1 then
			local batmans = obj:ScanCircleObjs(x,y,300)
			local hasbatman = false
			for i,v in ipairs(batmans) do
				if v.movepos and not v.isrobot then
					hasbatman = true
					break
				end
			end
			if not hasbatman and obj.moveposindex-1 <= #obj.movepos then
				if 实用工具.GetDistanceSq(x,y,obj.movepos[obj.moveposindex-1][1],obj.movepos[obj.moveposindex-1][2],obj.Is2DScene,obj.MoveGridRate) < 40000 then
					obj.moveposindex = obj.moveposindex - 1
				end
				if obj.moveposindex-1 <= #obj.movepos and not obj:MoveTo(obj.movepos[obj.moveposindex-1][1], obj.movepos[obj.moveposindex-1][2]) then
					local dir = math.random(1,2) == 1 and 1 or -1
					local nX, nY = x+(obj.movepos[obj.moveposindex-1][2]-y)*dir,y-(obj.movepos[obj.moveposindex-1][1]-x)*dir
					obj:MoveTo(nX, nY)
				end
			elseif hasbatman then
				if 实用工具.GetDistanceSq(x,y,obj.movepos[obj.moveposindex][1],obj.movepos[obj.moveposindex][2],obj.Is2DScene,obj.MoveGridRate) < 40000 then
					obj.moveposindex = obj.moveposindex + 1
				end
				if obj.moveposindex <= #obj.movepos then
					if not obj:MoveTo(obj.movepos[obj.moveposindex][1], obj.movepos[obj.moveposindex][2]) then
						local dir = math.random(1,2) == 1 and 1 or -1
						local nX, nY = x+(obj.movepos[obj.moveposindex][2]-y)*dir,y-(obj.movepos[obj.moveposindex][1]-x)*dir
						obj:MoveTo(nX, nY)
					end
				end
			end
		else
			if 实用工具.GetDistanceSq(x,y,obj.movepos[obj.moveposindex][1],obj.movepos[obj.moveposindex][2],obj.Is2DScene,obj.MoveGridRate) < 40000 then
				obj.moveposindex = obj.moveposindex + 1
			end
			if obj.moveposindex <= #obj.movepos then
				local tx,ty = obj.movepos[obj.moveposindex][1], obj.movepos[obj.moveposindex][2]
				if not obj:MoveTo(tx, ty) then
					local nX, nY
					if obj.isaimove then
						local dir = math.random(1,2) == 1 and 1 or -1
						nX, nY = obj.isaimove and x+(ty-y)*dir,y-(tx-x)*dir
					else
						nX, nY = 实用工具.GetRandPos(bx, by, conf.patrol,obj.Is2DScene,obj.MoveGridRate)
					end
					obj:MoveTo(nX, nY)
				end
			end
		end
		if obj.istdmonster and obj.moveposindex > #obj.movepos then
			obj:LeaveScene()
		else
			obj.bornx = x
			obj.borny = y
		end
		return
	end
	--巡逻逻辑
	if not obj:IsMoving() and obj:获取移动速度() > 0 and not obj.unmovable and obj:GetMonsterObserverNum() > 0 then
		if math.random(1,100) <= conf.lively then
			local nX, nY = 实用工具.GetRandPos(bx, by, conf.patrol,obj.Is2DScene,obj.MoveGridRate)
			obj:MoveTo(nX, nY)
		end
	end
end
