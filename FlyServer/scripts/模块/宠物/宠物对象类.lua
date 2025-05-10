local 公共定义 = require("公用.公共定义")
local 公共定义 = require("公用.公共定义")
local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 计时器ID = require("公用.计时器ID")
local 实用工具 = require("公用.实用工具")
local 消息类 = require("公用.消息类")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 怪物表 = require("配置.怪物表").Config
local 宠物表 = require("配置.宠物表").Config
local 玩家属性表 = require("配置.玩家属性表").Config
local Buff表 = require("配置.Buff表").Config
local 技能逻辑 = require("技能.技能逻辑")

宠物对象类 = 对象类:New()
--PetPos = PetPos or {}
--WorldBossManager = WorldBossManager or {}

function 宠物对象类:ReSetMetatable()
  宠物对象类.__index = 宠物对象类;
  setmetatable(self, 宠物对象类);
end

function 宠物对象类:New(nObjId)
  if 对象管理[nObjId] then
	assert(nil, "lua newobj fail 怪物 already exist")
  end

  if 对象管理[nObjId] == nil then
    对象管理[nObjId] = {
      id = nObjId,
      m_nPetID = 0,
      m_nSceneID = -1,
	  x = 0,
	  y = 0,
	  m_status = 0,
	  call = {},
	  cd = {},
	  ownerid = -1,
	  deadtime = 0,
	  disappeartime = 0,
	  relivetime = 0,
	  respawntime = nil,
	  enmity = {},
	  enemy = {},
	  hp = 0,
	  hpMax = 0,
	  mp = 0,
	  mpMax = 0,
	  属性值 = {},
	  iscaller = false,
	  buffhit = {},
	  buffend = {},
	  level = 1,
	  exp = 0,
	  starlevel = 1,
	  starexp = 0,
	  avatarid = 0,
	  attr = {},
 	  attrlearn = {},
	  teamid = 0,
	  grade = nil,
	  db = nil,
	  ringsoul = nil,
    }
  end

  local obj = 对象管理[nObjId]
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function 宠物对象类:CheckAttrLearn()
	self.attrlearn = {}
	if self.db and self.db.属性加点 then
		for k,v in pairs(self.db.属性加点) do
			if k == 1 then
				self.attrlearn[公共定义.属性_生命值] = (self.attrlearn[公共定义.属性_生命值] or 0) + v*(Config.ISWZ and 100 or 10)
			elseif k == 2 then
				self.attrlearn[公共定义.属性_魔法值] = (self.attrlearn[公共定义.属性_魔法值] or 0) + v*(Config.ISWZ and 100 or 10)
			elseif k == 3 then
				self.attrlearn[公共定义.属性_防御] = (self.attrlearn[公共定义.属性_防御] or 0) + v*(Config.ISWZ and 10 or 1)
				self.attrlearn[公共定义.属性_防御上限] = (self.attrlearn[公共定义.属性_防御上限] or 0) + v*(Config.ISWZ and 10 or 1)
			elseif k == 4 then
				self.attrlearn[公共定义.属性_魔御] = (self.attrlearn[公共定义.属性_魔御] or 0) + v*(Config.ISWZ and 10 or 1)
				self.attrlearn[公共定义.属性_魔御上限] = (self.attrlearn[公共定义.属性_魔御上限] or 0) + v*(Config.ISWZ and 10 or 1)
			elseif k == 5 then
				self.attrlearn[公共定义.属性_攻击] = (self.attrlearn[公共定义.属性_攻击] or 0) + v*(Config.ISWZ and 10 or 1)
				self.attrlearn[公共定义.属性_攻击上限] = (self.attrlearn[公共定义.属性_攻击上限] or 0) + v*(Config.ISWZ and 10 or 1)
			elseif k == 6 then
				self.attrlearn[公共定义.属性_魔法] = (self.attrlearn[公共定义.属性_魔法] or 0) + v*(Config.ISWZ and 10 or 1)
				self.attrlearn[公共定义.属性_魔法上限] = (self.attrlearn[公共定义.属性_魔法上限] or 0) + v*(Config.ISWZ and 10 or 1)
			elseif k == 7 then
				self.attrlearn[公共定义.属性_道术] = (self.attrlearn[公共定义.属性_道术] or 0) + v*(Config.ISWZ and 10 or 1)
				self.attrlearn[公共定义.属性_道术上限] = (self.attrlearn[公共定义.属性_道术上限] or 0) + v*(Config.ISWZ and 10 or 1)
			end
		end
	end
	self:CalcDynamicAttr()
end

function 宠物对象类:GetAttr(attrtype)
	local val = 0
	if self.attrlearn[attrtype] then
		val = val + self.attrlearn[attrtype]
	end
	if self.attr[attrtype] then
		val = val + self.attr[attrtype][1] - self.attr[attrtype][2]
	end
	return val
end

function 宠物对象类:ChangeTeam(teamid)
	self.teamid = teamid
	self:UpdateObjInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_TEAM]
	oReturnMsg.objid = self.id
	oReturnMsg.teamid = self.teamid
	消息类.ZoneBroadCast(oReturnMsg, self.id)
  for k,v in pairs(self.call) do
	v:ChangeTeam(teamid)
  end
end

function 宠物对象类:RemoveBuff()
	for k,v in pairs(self.buffhit) do
		_DelTimer(v, self.id)
		self.buffhit[k] = nil
	end
	for k,v in pairs(self.buffend) do
		_DelTimer(v, self.id)
		local buffconf = Buff表[k]
		self.buffend[k] = nil
		技能逻辑.DoHitBuffEnd(self, buffconf)
	end
	if self.updateInfoTime then
		self:UpdateObjInfo()
		self.updateInfoTime = nil
	end
end

function 宠物对象类:CheckDead()
	if self.hp > 0 then
		return
	end
	for k,v in pairs(self.enemy) do
		if k.enmity then
			k.enmity[self] = nil
		end
		self.enemy[k] = nil
	end
	for k,v in pairs(self.enmity) do
		if k.enemy then
			k.enemy[self] = nil
		end
		self.enmity[k] = nil
	end
	for k,v in pairs(self.call) do
		v:Destroy()
	end
	self.call = {}
  if self.ringsoul then
	self.ringsoul.level = self.level
	self.ringsoul.exp = self.exp
  end
	self:RemoveBuff()
	self:StopMove()
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, 0)
	if self.displace then
		_DelTimer(self.displace, self.id)
		DisplaceMove[self.id] = nil
		self.displace = nil
	end
	if self.hitpoint then
		_DelTimer(self.hitpoint, self.id)
		self.hitpoint = nil
	end
	if not self.ringsoul then
		self.avatarid = 公共定义.宠物死亡ID
		self:ChangeBody()
		--_AddTimer(self.id, 计时器ID.TIMER_MONSTER_RESPAWN,20000,1, 0, 0, 0)
		self.oldsceneid = self.m_nSceneID
		--self.relivetime = _CurrentTime() + 20000
		MonsterRespawn[self.id] = self
		self.respawntime = _CurrentTime() + 20000
	end
end

function 宠物对象类:Destroy()
	for k,v in pairs(self.enemy) do
		if k.enmity then
			k.enmity[self] = nil
		end
		self.enemy[k] = nil
	end
	for k,v in pairs(self.enmity) do
		if k.enemy then
			k.enemy[self] = nil
		end
		self.enmity[k] = nil
	end
  for k,v in pairs(self.call) do
	v:Destroy()
  end
  self.call = {}
  --复活timerId
  --if self.timerId then
  --  _DelTimer(self.timerId, self.id)
  --end
  if self.ringsoul then
	self.ringsoul.level = self.level
	self.ringsoul.exp = self.exp
  end
	DisplaceMove[self.id] = nil
	MonsterRespawn[self.id] = nil
  self:RemoveBuff()
  self:LeaveScene()
  self:ReleaseObj()
  对象管理[self.id] = nil
end

--生成怪物，并加入9宫格
function 宠物对象类:CreatePet(nSceneId, nPetId, nX, nY, ownerid, level, exp, starlevel, starexp, grade, wash, db, ringsoul)
  local conf = 宠物表[nPetId] or 怪物表[nPetId]
  if conf == nil then
    print("error: CreatePet id no exist:", nPetId)
    return
  end

  --local nType = math.floor(nPetId/1000)%10
  local nType = 公共定义.OBJ_TYPE_PET
  local nObjId = self:CreateObj(nType, -1)
  if nObjId == -1 then
	assert(nObjId ~= -1, "宠物对象类:CreateObj fail")
    return
  end

  local oObj = 宠物对象类:New(nObjId)
  oObj.m_nPetID = nPetId
  oObj.grade = grade
  oObj.wash = wash or {}
  oObj.bornx = nX
  oObj.borny = nY
  oObj.iscaller = (conf.bodyid[1] or 0) == 0
  oObj.ownerid = ownerid or -1
  oObj.level = level or 1
  oObj.exp = exp or 0
  oObj.starlevel = starlevel or 1
  oObj.starexp = starexp or 0
  oObj.db = db
  oObj.ringsoul = ringsoul
  oObj:CheckAttrLearn()
  --oObj:CalcDynamicAttr()
  oObj.属性值[公共定义.属性_防御上限] = oObj.属性值[公共定义.属性_防御]
  oObj.属性值[公共定义.属性_魔御上限] = oObj.属性值[公共定义.属性_魔御]
  
  oObj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, conf.radius)
  oObj:SetEngineMoveSpeed(oObj:获取移动速度()) -- 设置c++层速度
  if nSceneId ~= -1 then
    oObj:EnterScene(nSceneId, nX, nY)
  end
	--_AddTimer(oObj.id, 计时器ID.TIMER_MONSTER_MOVEAI,500,-1, 0, 0, 0)
  --if PetPos[nPetId] == nil then
  --  PetPos[nPetId] = { x = nX, y = nY }
  --end
  --PetAI.InitPetAIData(oObj)
  
  return oObj
end

function 宠物对象类:CalcDynamicAttr()
	local conf = 宠物表[self.m_nPetID] or 怪物表[self.m_nPetID]
	if conf == nil then
		return
	end
	local hppercent = self.hpMax > 0 and self.hp / self.hpMax or 1
	--local mppercent = self.mpMax > 0 and self.mp / self.mpMax or 1
	local humanconf = 玩家属性表[self.level]
	for i,v in ipairs(公共定义.属性文字) do
		self.属性值[i] = (self.wash[i] or conf[v] or 0) + (humanconf[v..conf.职业] or 0)
	end
	for i,v in pairs(self.attrlearn) do
		self.属性值[i] = self.属性值[i] + v
	end
	self.属性值[公共定义.属性_生命值] = math.max(1, self.属性值[公共定义.属性_生命值])
	self.hpMax = self.属性值[公共定义.属性_生命值]
	self.hp = self.hpMax * hppercent
	self.mpMax = self.属性值[公共定义.属性_魔法值]
	--self.mp = self.mpMax * mppercent
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, self.hp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, self.hpMax)
	--self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MP, self.mp)
	--self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXMP, self.mpMax)
	self:SetEngineMoveSpeed(self:获取移动速度())
	self:ChangeInfo()
end

function 宠物对象类:SetPetId(nPetId)
  if self.m_nPetID == nPetId then
    return
  end
  local conf = 宠物表[nPetId] or 怪物表[nPetId]
  if conf == nil then
    return
  end
  self.m_nPetID = nPetId
  --self.hp = conf.hp
  --self.mp = conf.mp
  self.iscaller = (conf.bodyid[1] or 0) == 0
  self.deadtime = 0
  self:CalcDynamicAttr()
  self:UpdateObjInfo()
  
  --self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, conf.hp)
  --self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MP, conf.mp)
  --self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, conf.hp)
  --self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXMP, conf.mp)
  --self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, conf.radius)
  --self:SetEngineMoveSpeed(self:获取移动速度()) -- 设置c++层速度
end

function 宠物对象类:LevelUp()
	副本管理.LevelUpSceneObj(self.m_nSceneID, self)
	if self.hp > 0 then
		self.hp = self.hpMax
	end
	self:CalcDynamicAttr()
	self:UpdateObjInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_LEVEL_UP]
	oReturnMsg.objid = self.id
	oReturnMsg.level = self.level
	消息类.ZoneBroadCast(oReturnMsg, self.id)
end

function 宠物对象类:AddExp(cnt)
	if cnt <= 0 then
		return
	end
	if 玩家属性表[self.level+1] == nil then
		--return
	end
	self.exp = self.exp + cnt
	local oldlevel = self.level
	while 1 do
		local conf = 玩家属性表[self.level]
		if not conf then
			break
		end
		if self.exp >= conf.exp and 玩家属性表[self.level + 1] then
			self.exp = self.exp - conf.exp
			self.level = self.level + 1
		else
			break
		end
	end
	if self.level > oldlevel then
		self:LevelUp()
	end
	return true
end

function 宠物对象类:AddStarExp(cnt)
	if cnt <= 0 then
		return
	end
	self.starexp = self.starexp + cnt
	local oldstarlevel = self.starlevel
	while 1 do
		local starexpmax = self.starlevel * 100
		if self.starexp >= starexpmax then
			self.starexp = self.starexp - starexpmax
			self.starlevel = self.starlevel + 1
		else
			break
		end
	end
	if self.starlevel > oldstarlevel then
		self.hp = self.hpMax
		self:CalcDynamicAttr()
		self:UpdateObjInfo()
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_STAR_UPGRADE]
		oReturnMsg.objid = self.id
		oReturnMsg.starlevel = self.starlevel
		消息类.ZoneBroadCast(oReturnMsg, self.id)
	end
end

function 宠物对象类:IsDead()
	return self.hp <= 0
end

function 宠物对象类:GetName(无后缀)
	local master = 对象类:GetObj(self.ownerid)
	local conf = self:GetConfig()
	return (conf and conf.name or "")..((not 无后缀 and master) and "["..master:GetName().."]" or "")
end

function 宠物对象类:GetDeadEff()
	local conf = self:GetConfig()
	return conf and conf.deadeff or 0
end

function 宠物对象类:GetRelive()
	local conf = self:GetConfig()
	return conf and conf.relive or 0
end

function 宠物对象类:GetDisappear()
	local conf = self:GetConfig()
	return conf and conf.disappear or 0
end

function 宠物对象类:GetType()
	local conf = self:GetConfig()
	return conf and conf.type or 0
end

function 宠物对象类:GetRadius()
	local conf = self:GetConfig()
	return conf and conf.radius or 0
end

function 宠物对象类:GetConfig()
  local ret = 宠物表[self.m_nPetID] or 怪物表[self.m_nPetID]
  if ret == nil then
    print("invalid 怪物 id: ", self.m_nPetID)
  end
  return ret
end

function 宠物对象类:GetBornPos()
	local master = 对象类:GetObj(self.ownerid)
	if master then
		return master:GetPosition()
	else
		return self.bornx, self.borny
	end
end

function 宠物对象类:UpdateObjInfo()
	local conf = self:GetConfig()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or nil
	
	local oMsgCacheData = 派发器.ProtoContainer[协议ID.GG_ADD_PET_CACHE_DATA]
	oMsgCacheData.name = self:GetName()
	oMsgCacheData.level = self.level
	oMsgCacheData.status = self.m_status
	oMsgCacheData.buffinfoLen = 0
	for k,v in pairs(self.buffend) do
		local timer = _GetTimer(v, self.id)
		local buffconf = Buff表[k]
		if buffconf and timer and timer.nextCallTime > _CurrentTime() then
			oMsgCacheData.buffinfoLen = oMsgCacheData.buffinfoLen + 1
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].effid = buffconf.effid
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].icon = buffconf.icon
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].time = timer.nextCallTime - _CurrentTime()
		end
	end
	oMsgCacheData.confid = self.m_nPetID
	oMsgCacheData.bodyid = confnew and confnew.bodyid[1] or conf.bodyid[1] or 0
	oMsgCacheData.effid = confnew and confnew.effid[1] or conf.effid[1] or 0
	oMsgCacheData.masterid = self.ownerid
	oMsgCacheData.grade = self:GetGrade()
	oMsgCacheData.starlevel = self.starlevel
	oMsgCacheData.teamid = self.teamid
	
	消息类.SendMsg(oMsgCacheData, self.id)
end

function 宠物对象类:ChangeInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_INFO]
	oReturnMsg.objid = self.id
	oReturnMsg.maxhp = self:获取生命值()
	oReturnMsg.hp = self.hp
	oReturnMsg.mergehpLen = 0
	消息类.ZoneBroadCast(oReturnMsg, self.id)
end

function 宠物对象类:ChangeSpeed()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or nil
	self:SetEngineMoveSpeed(confnew and confnew.speed or self:获取移动速度())
	self:UpdateObjInfo()
	
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_SPEED]
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.speed = confnew and confnew.speed or self:获取移动速度()
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 宠物对象类:ChangeBody()
	local conf = self:GetConfig()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or nil
	self:SetEngineMoveSpeed(confnew and confnew.speed or self:获取移动速度())
	self:UpdateObjInfo()
	
	local oMsgChangeBodyID = 派发器.ProtoContainer[协议ID.GC_CHANGE_BODY]
	oMsgChangeBodyID.objid = self.id
	oMsgChangeBodyID.bodyid = confnew and confnew.bodyid[1] or conf.bodyid[1] or 0
	oMsgChangeBodyID.effid = confnew and confnew.effid[1] or conf.effid[1] or 0
	oMsgChangeBodyID.speed = confnew and confnew.speed or self:获取移动速度()
	
	消息类.ZoneBroadCast(oMsgChangeBodyID, self.id)
end

function 宠物对象类:ChangeStatus(status)
	if self.m_status == status then
		return
	end
	self.m_status = status
	self:UpdateObjInfo()
	if self.m_nSceneID == -1 then
		return
	end
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_STATUS]
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.status = status
	
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 宠物对象类:JumpScene(nSceneID, nX, nY)
  if nSceneID == -1 then
    assert(false)
    return
  end
	if self.displace then
		_DelTimer(self.displace, self.id)
		DisplaceMove[self.id] = nil
		self.displace = nil
	end
	if self.hitpoint then
		_DelTimer(self.hitpoint, self.id)
		self.hitpoint = nil
	end
	self:StopMove()
	if self.MoveGrid then
		nX = math.floor(nX / self.MoveGrid[1]) * self.MoveGrid[1] + self.MoveGrid[1]/2
		nY = math.floor(nY / self.MoveGrid[2]) * self.MoveGrid[2] + self.MoveGrid[2]/2
	end
  if self.m_nSceneID == nSceneID then -- 同一场景
    -- 设置位置 刷新九宫格
    self.x = nX
    self.y = nY
    local oMsgJumpPoint = 派发器.ProtoContainer[协议ID.GC_JUMP_SCENE]
    oMsgJumpPoint.objid = self.id
    oMsgJumpPoint.mapid = 场景管理.GetMapId(nSceneID) or 0
    oMsgJumpPoint.x = nX
    oMsgJumpPoint.y = nY
    消息类.ZoneBroadCast(oMsgJumpPoint, self.id)
    self:ChangePosition(nX, nY)
  else
    self:LeaveScene()
    self.x = nX
    self.y = nY
	self:EnterScene(nSceneID, nX, nY)
  end
end

function 宠物对象类:CalcPower()
	local 战力 = 0
	local 战力2 = {}
	for k,v in pairs(self.属性值) do
		--战力 = 战力 + ((k == 1 or k == 2) and v/10 or v)
		if k == 1 or k == 2 then
			战力 = 战力 + v/10
		elseif k >= 3 or k <= 12 then
			ii = math.ceil(k/2)
			战力2[ii] = math.max(战力2[ii] or 0, v)
		else
			战力 = 战力 + v
		end
	end
	for k,v in pairs(战力2) do
		战力 = 战力 + v
	end
	return math.floor(战力)
end

function 宠物对象类:获取职业()
	local conf = 宠物表[self.m_nPetID] or 怪物表[self.m_nPetID]
	if conf == nil then
		return 1
	end
	return conf.职业
end

function 宠物对象类:当前生命()
	return self.hp
end

function 宠物对象类:当前魔法()
	return self.mp
end

function 宠物对象类:获取生命值()
	local 生命值 = self.属性值[公共定义.属性_生命值]
	if self.attr[公共定义.属性_生命值] then
		return 生命值 + self.attr[公共定义.属性_生命值][1] - self.attr[公共定义.属性_生命值][2]
	else
		return 生命值
	end
end

function 宠物对象类:获取魔法值()
	if self.attr[公共定义.属性_魔法值] then
		return self.属性值[公共定义.属性_魔法值] + self.attr[公共定义.属性_魔法值][1] - self.attr[公共定义.属性_魔法值][2]
	else
		return self.属性值[公共定义.属性_魔法值]
	end
end

function 宠物对象类:获取防御()
	if self.attr[公共定义.属性_防御] then
		return self.属性值[公共定义.属性_防御] + self.attr[公共定义.属性_防御][1] - self.attr[公共定义.属性_防御][2]
	else
		return self.属性值[公共定义.属性_防御]
	end
end

function 宠物对象类:获取防御上限()
	if self.attr[公共定义.属性_防御上限] then
		return self.属性值[公共定义.属性_防御上限] + self.attr[公共定义.属性_防御上限][1] - self.attr[公共定义.属性_防御上限][2]
	else
		return self.属性值[公共定义.属性_防御上限]
	end
end

function 宠物对象类:获取魔御()
	if self.attr[公共定义.属性_魔御] then
		return self.属性值[公共定义.属性_魔御] + self.attr[公共定义.属性_魔御][1] - self.attr[公共定义.属性_魔御][2]
	else
		return self.属性值[公共定义.属性_魔御]
	end
end

function 宠物对象类:获取魔御上限()
	if self.attr[公共定义.属性_魔御上限] then
		return self.属性值[公共定义.属性_魔御上限] + self.attr[公共定义.属性_魔御上限][1] - self.attr[公共定义.属性_魔御上限][2]
	else
		return self.属性值[公共定义.属性_魔御上限]
	end
end

function 宠物对象类:获取攻击()
	if self.attr[公共定义.属性_攻击] then
		return self.属性值[公共定义.属性_攻击] + self.attr[公共定义.属性_攻击][1] - self.attr[公共定义.属性_攻击][2]
	else
		return self.属性值[公共定义.属性_攻击]
	end
end

function 宠物对象类:获取攻击上限()
	if self.attr[公共定义.属性_攻击上限] then
		return self.属性值[公共定义.属性_攻击上限] + self.attr[公共定义.属性_攻击上限][1] - self.attr[公共定义.属性_攻击上限][2]
	else
		return self.属性值[公共定义.属性_攻击上限]
	end
end

function 宠物对象类:获取魔法()
	if self.attr[公共定义.属性_魔法] then
		return self.属性值[公共定义.属性_魔法] + self.attr[公共定义.属性_魔法][1] - self.attr[公共定义.属性_魔法][2]
	else
		return self.属性值[公共定义.属性_魔法]
	end
end

function 宠物对象类:获取魔法上限()
	if self.attr[公共定义.属性_魔法上限] then
		return self.属性值[公共定义.属性_魔法上限] + self.attr[公共定义.属性_魔法上限][1] - self.attr[公共定义.属性_魔法上限][2]
	else
		return self.属性值[公共定义.属性_魔法上限]
	end
end

function 宠物对象类:获取道术()
	if self.attr[公共定义.属性_道术] then
		return self.属性值[公共定义.属性_道术] + self.attr[公共定义.属性_道术][1] - self.attr[公共定义.属性_道术][2]
	else
		return self.属性值[公共定义.属性_道术]
	end
end

function 宠物对象类:获取道术上限()
	if self.attr[公共定义.属性_道术上限] then
		return self.属性值[公共定义.属性_道术上限] + self.attr[公共定义.属性_道术上限][1] - self.attr[公共定义.属性_道术上限][2]
	else
		return self.属性值[公共定义.属性_道术上限]
	end
end

function 宠物对象类:获取幸运()
	if self.attr[公共定义.属性_幸运] then
		return self.属性值[公共定义.属性_幸运] + self.attr[公共定义.属性_幸运][1] - self.attr[公共定义.属性_幸运][2]
	else
		return self.属性值[公共定义.属性_幸运]
	end
end

function 宠物对象类:获取准确()
	if self.attr[公共定义.属性_准确] then
		return self.属性值[公共定义.属性_准确] + self.attr[公共定义.属性_准确][1] - self.attr[公共定义.属性_准确][2]
	else
		return self.属性值[公共定义.属性_准确]
	end
end

function 宠物对象类:获取敏捷()
	if self.attr[公共定义.属性_敏捷] then
		return self.属性值[公共定义.属性_敏捷] + self.attr[公共定义.属性_敏捷][1] - self.attr[公共定义.属性_敏捷][2]
	else
		return self.属性值[公共定义.属性_敏捷]
	end
end

function 宠物对象类:获取魔法命中()
	if self.attr[公共定义.属性_魔法命中] then
		return self.属性值[公共定义.属性_魔法命中] + self.attr[公共定义.属性_魔法命中][1] - self.attr[公共定义.属性_魔法命中][2]
	else
		return self.属性值[公共定义.属性_魔法命中]
	end
end

function 宠物对象类:获取魔法躲避()
	if self.attr[公共定义.属性_魔法躲避] then
		return self.属性值[公共定义.属性_魔法躲避] + self.attr[公共定义.属性_魔法躲避][1] - self.attr[公共定义.属性_魔法躲避][2]
	else
		return self.属性值[公共定义.属性_魔法躲避]
	end
end

function 宠物对象类:获取生命恢复()
	if self.attr[公共定义.属性_生命恢复] then
		return self.属性值[公共定义.属性_生命恢复] + self.attr[公共定义.属性_生命恢复][1] - self.attr[公共定义.属性_生命恢复][2]
	else
		return self.属性值[公共定义.属性_生命恢复]
	end
end

function 宠物对象类:获取魔法恢复()
	if self.attr[公共定义.属性_魔法恢复] then
		return self.属性值[公共定义.属性_魔法恢复] + self.attr[公共定义.属性_魔法恢复][1] - self.attr[公共定义.属性_魔法恢复][2]
	else
		return self.属性值[公共定义.属性_魔法恢复]
	end
end

function 宠物对象类:获取中毒恢复()
	if self.attr[公共定义.属性_中毒恢复] then
		return self.属性值[公共定义.属性_中毒恢复] + self.attr[公共定义.属性_中毒恢复][1] - self.attr[公共定义.属性_中毒恢复][2]
	else
		return self.属性值[公共定义.属性_中毒恢复]
	end
end

function 宠物对象类:获取攻击速度()
	if self.attr[公共定义.属性_攻击速度] then
		return self.属性值[公共定义.属性_攻击速度] + self.attr[公共定义.属性_攻击速度][1] - self.attr[公共定义.属性_攻击速度][2]
	else
		return self.属性值[公共定义.属性_攻击速度]
	end
end

function 宠物对象类:获取移动速度()
	local 移动速度 = self.属性值[公共定义.属性_移动速度]
	if self.attr[公共定义.属性_移动速度] then
		return 移动速度 + self.attr[公共定义.属性_移动速度][1] - self.attr[公共定义.属性_移动速度][2]
	else
		return 移动速度
	end
end

function 宠物对象类:GetLevel()
	return self.level
end

function 宠物对象类:GetGrade()
	local conf = self:GetConfig()
	return self.grade or conf.grade
end

function 宠物对象类:GetPatrol()
	local conf = self:GetConfig()
	return conf.patrol
end

function 宠物对象类:RecoverHP(coverhp)
	if coverhp == 0 then return end
	if self.hp == 0 and coverhp < 0 then return end
	if self.hp == self:获取生命值() and coverhp > 0 then return end
	local oldhp = self.hp
	self.hp = math.max(0,math.min(self.hp + coverhp, self:获取生命值()))
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, self.hp)
	if self.hp == 0 then
		self:StopMove()
	end
	self:ChangeInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_HURT]
	oReturnMsg.objid = self.id
	oReturnMsg.effid1 = 0
	oReturnMsg.effid2 = oldhp == 0 and 3657 or 0
	oReturnMsg.dechp = oldhp - self.hp
	oReturnMsg.crit = 0
	oReturnMsg.status = self.hp == 0 and 1 or oldhp == 0 and 2 or 0
	消息类.ZoneBroadCast(oReturnMsg, self.id)
	return true
end
