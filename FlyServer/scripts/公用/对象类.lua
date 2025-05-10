local 公共定义 = require("公用.公共定义")
local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 实用工具 = require("公用.实用工具")
local 技能逻辑 = require("技能.技能逻辑")

local _GetObjType = _GetObjType
local _GetPosition = _GetPosition
local _GetDistance = _GetDistance
local _MoveTo = _MoveTo
local _StopMove = _StopMove
local _ScanRectObjs = _ScanRectObjs
local _ScanFanObjs = _ScanFanObjs
local _ScanHuman = _ScanHuman
local _ScanMonster = _ScanMonster
local _ScanItem = _ScanItem
local _ScanCircleObjs = _ScanCircleObjs
local _ObjEnterScene = _ObjEnterScene
local _ObjLeaveScene = _ObjLeaveScene
local _ChangePosition = _ChangePosition
local _UpdateCharCacheAttr = _UpdateCharCacheAttr
local _IsPosCanRun = _IsPosCanRun
local _IsPosWalkable = _IsPosWalkable
local _IsInSafeArea = _IsInSafeArea
local _IsInBuffArea = _IsInBuffArea
local _GetMonsterObserverNum = _GetMonsterObserverNum
local _SetForbidMove = _SetForbidMove
local _SetFreeMove = _SetFreeMove
local _SetMoveBreak = _SetMoveBreak

对象管理 = 对象管理 or {} 
对象类 = {}

SQRT_2 = math.sqrt(2)

function 对象类:RefreshOldObj()	--必须在require完所有obj类后调用
	for k,v in pairs(对象管理) do
		v:ReSetMetatable()
	end
end

function 对象类:New()	
	local obj = {id=-1}
	setmetatable(obj, self)
    self.__index = self
    return obj 
end

function 对象类:GetObj(nObjId)
	if nObjId ~= -1 then
		return 对象管理[nObjId]
	end
end

function 对象类:SetForbidMove()
	_SetForbidMove(self.id)
end

function 对象类:SetFreeMove()
	_SetFreeMove(self.id)
end

function 对象类:SetMoveBreak()
	_SetMoveBreak(self.id)
end

function 对象类:EnterScene(nSceneID, nX, nY)
	if self.m_nSceneID == -1 then
		self.m_nSceneID = nSceneID
		self:UpdateObjInfo()
		self.Is2DScene = 场景管理.GetIs2DScene(场景管理.GetMapId(nSceneID))
		self.MoveGrid = 场景管理.GetMoveGrid(场景管理.GetMapId(nSceneID))
		self.MoveGridRate = self.MoveGrid and self.MoveGrid[1]/self.MoveGrid[2] or 2
		local ret = _ObjEnterScene(self.id, nSceneID, nX, nY)
		if ret ~= 0 then
			local mapID = 场景管理.GetMapId(nSceneID)
			assert(nil, nSceneID .. " " .. mapID .. " " .. nX .. " " .. nY .. " " .. self.id .. " ret:" .. ret)
        else
			if self:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				HumanMoveGrid[self.id] = self
			elseif self:GetObjType() == 公共定义.OBJ_TYPE_HERO or self:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or self:GetObjType() == 公共定义.OBJ_TYPE_PET then
				MonsterAI[self.id] = self
				self.moveaitime = _CurrentTime() + 500
			end
            场景管理.AddSceneObjCount(nSceneID, self:GetObjType())
			副本管理.AddSceneObj(nSceneID, self)
			if self:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and 场景管理.GetSceneObjCount(nSceneID, 公共定义.OBJ_TYPE_HUMAN) == 1 and MonsterScene[nSceneID] then
				for k,v in pairs(MonsterScene[nSceneID]) do
					if v[2] == 0 and v[1].hp > 0 then
						v[1]:EnterScene(nSceneID, v[1].currx, v[1].curry)
						MonsterAI[v[1].id] = v[1]
						v[1].moveaitime = _CurrentTime() + 500
						v[2] = 1
					end
				end
			end
		end
		return true
	end
end

function 对象类:LeaveScene()
    if self.m_nSceneID ~= -1 then
        local nSceneID = self.m_nSceneID
        self.m_nSceneID = -1
		if self.movegridpos then
			self.movegridpos = nil
		end
        local leave_scene_result = _ObjLeaveScene(self.id, nSceneID)
        if (leave_scene_result) then
			if self:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				HumanMoveGrid[self.id].movegridpos = nil
				HumanMoveGrid[self.id].movegrids = nil
				HumanMoveGrid[self.id] = nil
			elseif self:GetObjType() == 公共定义.OBJ_TYPE_HERO or self:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or self:GetObjType() == 公共定义.OBJ_TYPE_PET then
				--MonsterAI[self.id].movegridpos = nil
				MonsterAI[self.id] = nil
			end
            场景管理.DecSceneObjCount(nSceneID, self:GetObjType())
			副本管理.DecSceneObj(nSceneID, self)
			if self:GetObjType() == 公共定义.OBJ_TYPE_HUMAN and 场景管理.GetSceneObjCount(nSceneID, 公共定义.OBJ_TYPE_HUMAN) == 0 and MonsterScene[nSceneID] then
				for k,v in pairs(MonsterScene[nSceneID]) do
					if v[2] == 1 then
						if v[1].movegridpos then
							v[1].currx, v[1].curry = v[1].movegridpos[1], v[1].movegridpos[2]
							v[1].movegridpos = nil
						else
							v[1].currx, v[1].curry = v[1]:GetPosition()
						end
						v[1]:LeaveScene()
						v[2] = 0
					end
				end
			end
        end
        return leave_scene_result
    end
    return false
end

function 对象类:SetLogined()
    return _SetObjLogined(self.id)
end

function 对象类:SetReady()
    return _SetObjReady(self.id)
end


function 对象类:GetObjType()
    return _GetObjType(self.id)
end

function 对象类:GetPosition()
    return _GetPosition(self.id)
end

function 对象类:ChangePosition(nX, nY)
    return _ChangePosition(self.id, nX, nY)    
end

function 对象类:SetEngineMoveSpeed(nSpeed)
    return _SetMoveSpeed(self.id, nSpeed)
end

function 对象类:UpdateCharCacheAttr(nAttr, nValue)
	return _UpdateCharCacheAttr(self.id, nAttr, nValue)
end

function 对象类:MoveTo(x, y,sendToSelf)
	if self.unmovable then
		return
	end
	if self.m_nSceneID == -1 then
		return
	end
	if self:获取移动速度() < 1 then
		return
	end
	if self.buffend[公共定义.隐身BUFF] then
		技能逻辑.DoRemoveBuff(self, 公共定义.隐身BUFF)
	end
	if self.MoveGrid then
		--local speed = self:获取移动速度() / (self.MoveGrid[1] * 2)
		--return self:MoveGridTo(x, y, self.MoveGrid[1] * speed, self.MoveGrid[2] * speed, self.MoveGrid[1] / self:获取移动速度())
		return self:MoveGridTo(x, y, self.MoveGrid[1], self.MoveGrid[2], self.MoveGrid[1] / self:获取移动速度())
	end
    if sendToSelf then
        return _MoveTo(self.id,x,y, 1)
    else
        return _MoveTo(self.id,x,y, 0)
    end
end

function 对象类:MoveGridTo(x, y, gx, gy, movetime)
	if self:获取移动速度() < 1 then
		return
	end
	local px,py = self:GetPosition()
	local mx = x - px
	local my = self.Is2DScene and (y - py) * self.MoveGridRate or y - py
	local dir = 实用工具.GetDirection(mx, my)
	if dir >= 22.5 and dir < 67.5 then
		self.movegridpos = {px+gx,py-gy}
		self.movegridtime = math.floor(movetime * 1000 * SQRT_2)
	elseif dir >= 67.5 and dir < 112.5 then
		self.movegridpos = {px+gx,py}
		self.movegridtime = math.floor(movetime * 1000)
	elseif dir >= 112.5 and dir < 157.5 then
		self.movegridpos = {px+gx,py+gy}
		self.movegridtime = math.floor(movetime * 1000 * SQRT_2)
	elseif dir >= 157.5 and dir < 202.5 then
		self.movegridpos = {px,py+gy}
		self.movegridtime = math.floor(movetime * 1000)
	elseif dir >= 202.5 and dir < 247.5 then
		self.movegridpos = {px-gx,py+gy}
		self.movegridtime = math.floor(movetime * 1000 * SQRT_2)
	elseif dir >= 247.5 and dir < 292.5 then
		self.movegridpos = {px-gx,py}
		self.movegridtime = math.floor(movetime * 1000)
	elseif dir >= 292.5 and dir < 337.5 then
		self.movegridpos = {px-gx,py-gy}
		self.movegridtime = math.floor(movetime * 1000 * SQRT_2)
	else
		self.movegridpos = {px,py-gy}
		self.movegridtime = movetime * 1000
	end
	if not self:IsPosWalkable(self.movegridpos[1], self.movegridpos[2], true) then
		self.movegridpos = nil
		self.movegridtime = nil
		return
	end
	local oMsg = 派发器.ProtoContainer[协议ID.GC_MOVE]
	oMsg.objid = self.id
	oMsg.objtype = self:GetObjType()
	oMsg.posx = px
	oMsg.posy = py
	oMsg.movex = self.movegridpos[1]
	oMsg.movey = self.movegridpos[2]
	消息类.ZoneBroadCast(oMsg, self.id)
	return true
end

function 对象类:StopMove()
	if self.movegridpos then
		self:ChangePosition(self.movegridpos[1], self.movegridpos[2])
		self.movegridpos = nil
		self.movegrids = nil
		local oMsg = 派发器.ProtoContainer[协议ID.GC_STOP_MOVE]
		oMsg.objid = self.id
		oMsg.x, oMsg.y = self:GetPosition()
		消息类.ZoneBroadCast(oMsg, self.id)
	end
	_StopMove(self.id)
end

function 对象类:IsMoving()
	return _IsMoving(self.id)
end

function 对象类:GetDistance(nTargetId)
	return _GetDistance(self.id, nTargetId)
end

function 对象类:ScanRectObjs(nX, nY, nTX, nTY, nLength, nWidth, exceptself)
	local oTargetList = _ScanRectObjs(self.id, nX, nY, nTX, nTY, nLength, nWidth)
	if oTargetList == nil then
		return nil
	end
	
	local oRetList = {}
	for k, v in pairs(oTargetList) do
		local oTarget = 对象类:GetObj(v)
		if oTarget ~= nil and (not exceptself or oTarget ~= self) then
			if oTarget:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or oTarget:GetObjType() == 公共定义.OBJ_TYPE_HERO then
				oRetList[#oRetList + 1] = oTarget
			elseif oTarget:GetObjType() == 公共定义.OBJ_TYPE_MONSTER then
				oRetList[#oRetList + 1] = oTarget
			elseif oTarget:GetObjType() == 公共定义.OBJ_TYPE_PET then
				oRetList[#oRetList + 1] = oTarget
			end
		end
	end
	
	return oRetList
end

function 对象类:ScanFanObjs(nX, nY, nTX, nTY, nRadius, nAngle, exceptself)
	local oTargetList = _ScanFanObjs(self.id, nX, nY, nTX, nTY, nRadius, nAngle)
	if oTargetList == nil then
		return nil
	end
	
	local oRetList = {}
	for k, v in pairs(oTargetList) do
		local oTarget = 对象类:GetObj(v)
		if oTarget ~= nil and (not exceptself or oTarget ~= self) then
			if oTarget:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or oTarget:GetObjType() == 公共定义.OBJ_TYPE_HERO then
				oRetList[#oRetList + 1] = oTarget
			elseif oTarget:GetObjType() == 公共定义.OBJ_TYPE_MONSTER then
				oRetList[#oRetList + 1] = oTarget
			elseif oTarget:GetObjType() == 公共定义.OBJ_TYPE_PET then
				oRetList[#oRetList + 1] = oTarget
			end
		end
	end
	
	return oRetList
end

function 对象类:ScanHuman(nX, nY, nRadius, maxCount)
	local count = 10
	if maxCount then count = maxCount end
	local oTargetList = _ScanHuman(self.id, nX, nY, nRadius, count)
	if oTargetList == nil then
		return nil
	end
	
	local oRetList = {}
	for k, v in pairs(oTargetList) do
		local oTarget = 对象类:GetObj(v)
		if oTarget ~= nil then
			if oTarget:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
				oRetList[#oRetList + 1] = oTarget
			end
		end
	end
	
	return oRetList
end

function 对象类:ScanMonster(nX, nY, nRadius)
	local oTargetList = _ScanMonster(self.id, nX, nY, nRadius)
	if oTargetList == nil then
		return nil
	end
	
	local oRetList = {}
	for k, v in pairs(oTargetList) do
		local oTarget = 对象类:GetObj(v)
		if oTarget ~= nil then
			if oTarget:GetObjType() == 公共定义.OBJ_TYPE_MONSTER then
				oRetList[#oRetList + 1] = oTarget
			end
		end
	end
	
	return oRetList
end

function 对象类:ScanItem(nX, nY, nRadius)
	local oTargetList = _ScanItem(self.id, nX, nY, nRadius)
	if oTargetList == nil then
		return nil
	end
	
	local oRetList = {}
	for k, v in pairs(oTargetList) do
		local oTarget = 对象类:GetObj(v)
		if oTarget ~= nil then
			if oTarget:GetObjType() == 公共定义.OBJ_TYPE_ITEM then
				oRetList[#oRetList + 1] = oTarget
			end
		end
	end
	
	return oRetList
end

function 对象类:ScanCircleObjs(nX, nY, nRadius, exceptself)
	local oTargetList = _ScanCircleObjs(self.id, nX, nY, nRadius)
	if oTargetList == nil then
		return nil
	end
	
	local oRetList = {}
	for k, v in pairs(oTargetList) do
		local oTarget = 对象类:GetObj(v)
		if oTarget ~= nil and (not exceptself or oTarget ~= self) then
			if oTarget:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or oTarget:GetObjType() == 公共定义.OBJ_TYPE_HERO then
				oRetList[#oRetList + 1] = oTarget
			elseif oTarget:GetObjType() == 公共定义.OBJ_TYPE_MONSTER then
				oRetList[#oRetList + 1] = oTarget
			elseif oTarget:GetObjType() == 公共定义.OBJ_TYPE_PET then
				oRetList[#oRetList + 1] = oTarget
			end
		end
	end
	
	return oRetList
end

function 对象类:IsInValidRadius(nX, nY, iRadius)
	local iSelfX, iSelfY = _GetPosition(self.id)
	
	local iDistX = nX - iSelfX
	local iDistY = nY - iSelfY
	
	return iRadius * iRadius >= iDistX * iDistX + iDistY * iDistY
end

function 对象类:ReleaseObj()
	-- 干掉这个obj对应的所有的timer
    for i = #TimeEvents, 1, -1 do
		local node = TimeEvents[i]
		if node.objID == self.id then
			node.maxTimes = 0
		end
    end

	_ReleaseObj(self.id)
end

function 对象类:CreateObj(nObjType, nFD)
	return _CreateObj(nObjType, nFD)
end

function 对象类:CleanFD()
	_CleanFD(self.id)
end

function 对象类:IsInSafeArea()
    return _IsInSafeArea(self.id)
end

function 对象类:IsInBuffArea()
	return _IsInBuffArea(self.id)
end

function 对象类:IsPosWalkable(x, y, moveobj)
	return _IsPosWalkable(self.id, x, y, moveobj and 1 or 0)
end

function 对象类:IsPosCanRun(x, y)
	return _IsPosCanRun(self.m_nSceneID, x, y)
end

function 对象类:IsObjInSameZone(nObjID)
	return _IsObjInSameZone(self.id, nObjID)
end

function 对象类:SendDieMsg(oKiller, params)
	if self:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN and
       self:GetObjType() ~= 公共定义.OBJ_TYPE_MONSTER and
       self:GetObjType() ~= 公共定义.OBJ_TYPE_PET then
		return
	end
	
	local oObjDieMsg = 派发器.ProtoContainer[协议ID.GC_OBJ_DIE]
	oObjDieMsg.objId = self.id
	oObjDieMsg.objType = self:GetObjType()
	if oKiller then
		oObjDieMsg.objKillerId = oKiller.id
		oObjDieMsg.objKillerType = oKiller:GetObjType()
	else
		oObjDieMsg.objKillerId = 0
		oObjDieMsg.objKillerType = 0
	end
	
	if params and #params > 0 then
		for i,v in ipairs(params) do
			oObjDieMsg.params[i] = v
		end
		oObjDieMsg.paramsLen = #params
	else
		oObjDieMsg.paramsLen = 0
	end
	
	消息类.ZoneBroadCast(oObjDieMsg, self.id)
end

function 对象类:IncTimerID(nTimerID, nCount)
	self.m_oTimerIDs[nTimerID] = nCount
end


function 对象类:GetSceneId()
    return self.m_nSceneID
end

function 对象类:GetMonsterObserverNum()
	return _GetMonsterObserverNum(self.id)
end

local Dir = {
  45, 45, -45, -45, -45, 0, 0, 45,
  45, 0, -45, 0, 45, -45, 45, -45
}
function 对象类:GetNearPoint(sceneID, x, y)
	local newX = 0
	local newY = 0
	local i = 0
	for i = 1, 8 do
		newX = x + Dir[i]
		newY = y + Dir[i + 8]
		if _IsPosCanRun(sceneID, newX, newY) then
			return newX, newY
		end
	end
	
	return x, y
end

table.length = function(tb) local length = 0 for i,v in pairs(tb) do length = length+1 end return length end
