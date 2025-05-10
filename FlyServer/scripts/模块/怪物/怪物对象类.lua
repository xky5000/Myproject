local 怪物表 = require("配置.怪物表").Config
local 公共定义 = require("公用.公共定义")
local 公共定义 = require("公用.公共定义")
local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 计时器ID = require("公用.计时器ID")
local 实用工具 = require("公用.实用工具")
local 消息类 = require("公用.消息类")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 玩家属性表 = require("配置.玩家属性表").Config
local 技能逻辑 = require("技能.技能逻辑")
local Buff表 = require("配置.Buff表").Config

怪物对象类 = 对象类:New()
--MonsterPos = MonsterPos or {}
WorldBossManager = WorldBossManager or {}

function 怪物对象类:ReSetMetatable()
  怪物对象类.__index = 怪物对象类
  setmetatable(self, 怪物对象类)
end

function 怪物对象类:New(nObjId)
  if 对象管理[nObjId] then
	assert(nil, "lua newobj fail 怪物 already exist")
  end

  if 对象管理[nObjId] == nil then
    对象管理[nObjId] = {
      id = nObjId,
      m_nMonsterID = 0,
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
	  humanenmity = {},
	  hp = 0,
	  hpMax = 0,
	  mp = 0,
	  mpMax = 0,
	  属性值 = {},
	  iscaller = false,
	  isrobot = false,
	  是否练功师 = false,
	  buffhit = {},
	  buffend = {},
	  avatarid = 0,
	  monsterid = 0,
	  name = nil,
	  skills = {},
	  attr = {},
 	  attrlearn = {},
	  items = {},
	  equips = {},
	  exp = 0,
	  level = 1,
	  teamid = 0,
	  movepos = nil,
	  collecter = -1,
	  expire = 0,
    }
  end

  local obj = 对象管理[nObjId]
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function 怪物对象类:ChangeTeam(teamid)
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

function 怪物对象类:RemoveBuff()
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

function 怪物对象类:CheckDead()
	if self.hp > 0 then
		return
	end
	for k,v in pairs(self.humanenmity) do
		self.humanenmity[k] = nil
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
	self.lastdeadtime = _CurrentOSTime()
	self.disappeartime = _CurrentTime() + self:GetDisappear()
	
	if self.ownerid == -1 and self:GetRelive() > 0 and (not 场景管理.IsCopyscene(self.m_nSceneID) or 副本管理.CheckMonsterRespawn(self.m_nSceneID, self:GetType())) then
		--_AddTimer(self.id, 计时器ID.TIMER_MONSTER_RESPAWN,self:GetRelive(),1, 0, 0, 0)
		self.oldsceneid = self.m_nSceneID
		--self.relivetime = _CurrentTime() + self:GetRelive()
		MonsterRespawn[self.id] = self
		self.respawntime = _CurrentTime() + self:GetRelive()
	end
end

function 怪物对象类:ResetOwner(ownerid)
	if self.ownerid == ownerid then
		return
	end
  if self.ownerid ~= -1 and self.callid then
	local master = 对象类:GetObj(self.ownerid)
	if master and master.calllen then
		master.call[self.callid] = master.call[master.calllen]
		master.call[self.callid].callid = self.callid
		master.call[master.calllen] = nil
		master.calllen = master.calllen - 1
	end
	self.callid = nil
  end
  if ownerid ~= -1 then
	local master = 对象类:GetObj(ownerid)
	if master then
		self.relivetime = -1
		master.calllen = (master.calllen or 0) + 1
		self.callid = master.calllen
		master.call[master.calllen] = self
	end
  end
  self.ownerid = ownerid
end

function 怪物对象类:Destroy()
	for k,v in pairs(self.humanenmity) do
		self.humanenmity[k] = nil
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
  if self.ownerid ~= -1 and self.callid then
	local master = 对象类:GetObj(self.ownerid)
	if master and master.calllen then
		master.call[self.callid] = master.call[master.calllen]
		master.call[self.callid].callid = self.callid
		master.call[master.calllen] = nil
		master.calllen = master.calllen - 1
	end
	self.callid = nil
  end
  --复活timerId
  --if self.timerId then
  --  _DelTimer(self.timerId, self.id)
  --end
  --MonsterAI[self.id] = nil
  if self.monsterscene and MonsterScene[self.monsterscene] then
	  MonsterScene[self.monsterscene][self.id] = nil
  end
	DisplaceMove[self.id] = nil
	MonsterRespawn[self.id] = nil
  self:RemoveBuff()
  self:LeaveScene()
  self:ReleaseObj()
  对象管理[self.id] = nil
end

--生成怪物，并加入9宫格
function 怪物对象类:CreateMonster(nSceneID, nMonsterId, nX, nY, ownerid, name, hp)
  local conf = 怪物表[nMonsterId]
  if conf == nil then
    print("error: CreateMonster id no exist:", nMonsterId)
	print(debug.traceback())
    return
  end

  --local nType = math.floor(nMonsterId/1000)%10
  local nType = conf.type == 5 and 公共定义.OBJ_TYPE_COLLECT or 公共定义.OBJ_TYPE_MONSTER
  local nObjId = self:CreateObj(nType, -1)
  if nObjId == -1 then
	assert(nObjId ~= -1, "怪物对象类:CreateObj fail")
    return
  end

  local oObj = 怪物对象类:New(nObjId)
  oObj.m_nMonsterID = nMonsterId
  oObj.ownerid = ownerid or -1
  oObj.name = name
  oObj.bornx = nX
  oObj.borny = nY
  oObj.currx = nX
  oObj.curry = nY
  oObj.mp = conf.mp
  oObj.iscaller = (conf.bodyid[1] or 0) == 0
  oObj.是否练功师 = conf.type == 6
  --oObj.isrobot = conf.bodyid > 0 and conf.bodyid < 100
  oObj.level = conf.level
  if oObj.isrobot then
	oObj:CalcDynamicAttr()
	技能逻辑.CheckSkillLearn(oObj)
  else
	for i,v in ipairs(公共定义.属性文字) do
		oObj.属性值[i] = conf[v] or 0
	end
	oObj.属性值[公共定义.属性_生命值] = math.max(1, oObj.属性值[公共定义.属性_生命值])
	oObj.hpMax = oObj.属性值[公共定义.属性_生命值]
  end
  oObj.hp = hp or oObj.hpMax
  
  oObj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, oObj.hp)
  oObj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, oObj.hpMax)
  oObj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, conf.radius)
  oObj:SetEngineMoveSpeed(oObj:获取移动速度()) -- 设置c++层速度
  if nSceneID ~= -1 then
	if oObj.ownerid ~= -1 or 场景管理.IsCopyscene(nSceneID) or 场景管理.GetSceneObjCount(nSceneID, 公共定义.OBJ_TYPE_HUMAN) > 0 then
		oObj:EnterScene(nSceneID, nX, nY)
	end
	if oObj.ownerid == -1 and not 场景管理.IsCopyscene(nSceneID) then
		oObj.monsterscene = nSceneID
		MonsterScene[nSceneID] = MonsterScene[nSceneID] or {}
		MonsterScene[nSceneID][nObjId] = {oObj,oObj.m_nSceneID ~= -1 and 1 or 0}
	end
  end
  --_AddTimer(oObj.id, 计时器ID.TIMER_MONSTER_MOVEAI,500,-1, 0, 0, 0)
  if nSceneID ~= -1 and (conf.type == 2 or conf.type == 3) and not 场景管理.IsCopyscene(nSceneID) then
	oObj.bornmapid = 场景管理.GetMapId(nSceneID)
	if oObj.bornmapid ~= 公共定义.庄园地图ID and oObj.bornmapid ~= 公共定义.寻宝阁地图 then
		WorldBossManager[#WorldBossManager+1] = oObj
	end
  end
  --if MonsterPos[nMonsterId] == nil then
  --  MonsterPos[nMonsterId] = { x = nX, y = nY }
  --end
  --MonsterAI.InitMonsterAIData(oObj)
	if not name then
		oObj.name = conf.name
		while true do
			if oObj.name:len() > 0 and oObj.name:byte(-1) >= string.byte("0") and oObj.name:byte(-1) <= string.byte("9") then
				oObj.name = oObj.name:sub(1,-2)
			else
				break
			end
		end
	end
  
  return oObj
end

function 怪物对象类:GetLevel()
	return self.level
end

function 怪物对象类:SetMonsterId(nMonsterId)
  if self.m_nMonsterID == nMonsterId then
    return
  end
  local conf = 怪物表[nMonsterId]
  if conf == nil then
    return
  end
  self.m_nMonsterID = nMonsterId
  if self.isrobot then
	self:CalcDynamicAttr()
  else
	for i,v in ipairs(公共定义.属性文字) do
		self.属性值[i] = conf[v] or 0
	end
	self.属性值[公共定义.属性_生命值] = math.max(1, self.属性值[公共定义.属性_生命值])
	self.hpMax = self.属性值[公共定义.属性_生命值]
	self.hp = self.hpMax
	--self.hp = conf.hp
	--self.mp = conf.mp

	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, conf.hp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MP, conf.mp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, conf.hp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXMP, conf.mp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, conf.radius)
	self:SetEngineMoveSpeed(self:获取移动速度()) -- 设置c++层速度
  end
	self.iscaller = (conf.bodyid[1] or 0) == 0
	--self.isrobot = conf.bodyid > 0 and conf.bodyid < 100
	self.deadtime = 0
	self:UpdateObjInfo()
end

function 怪物对象类:LevelUp()
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
	技能逻辑.CheckSkillLearn(self)
end

function 怪物对象类:AddExp(cnt)
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

function 怪物对象类:CalcDynamicAttr()
	local conf = 玩家属性表[self.level]
	if not conf then
		return
	end
	local hppercent = self.hpMax > 0 and self.hp / self.hpMax or 1
	for i,v in ipairs(公共定义.属性文字) do
		self.属性值[i] = conf[v..self:获取职业()] or conf[v] or 0
	end
	for k,v in pairs(self.equips) do
		local cf = 物品表[v.id]
		for i,prop in ipairs(cf.prop) do
			self.属性值[prop[1]] = self.属性值[prop[1]] + prop[2] * (1 + ((v.grade or 1) - 1) / 5) + (prop[2] * (v.strengthen or 0) / 10)
		end
		if v.wash then
			for i,prop in ipairs(v.wash) do
				self.属性值[prop[1]] = self.属性值[prop[1]] + prop[2]
			end
		end
	end
	for i,v in pairs(self.attrlearn) do
		self.属性值[i] = self.属性值[i] + v
	end
	self.属性值[公共定义.属性_生命值] = math.max(1, self.属性值[公共定义.属性_生命值])
	self.hpMax = self.属性值[公共定义.属性_生命值]
	self.hp = self.hpMax * hppercent
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, self.hp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, self.hpMax)
	self:SetEngineMoveSpeed(self:获取移动速度())
	self:ChangeInfo()
end

function 怪物对象类:GetAttr(attrtype)
	local val = 0
	if self.attrlearn[attrtype] then
		val = val + self.attrlearn[attrtype]
	end
	if self.attr[attrtype] then
		val = val + self.attr[attrtype][1] - self.attr[attrtype][2]
	end
	return val
end

function 怪物对象类:IsDead()
	return self.hp <= 0
end

function 怪物对象类:GetName(无后缀)
	local master = 对象类:GetObj(self.ownerid)
	local conf = self:GetConfig()
	return (self.name and self.name or conf and conf.name or "")..((not 无后缀 and master) and "["..master:GetName().."]" or "")
end

function 怪物对象类:GetDeadEff()
	local conf = self:GetConfig()
	return conf and conf.deadeff or 0
end

function 怪物对象类:GetUndead()
	local conf = self:GetConfig()
	return conf and conf.undead or 0
end

function 怪物对象类:GetRelive()
	if self.relivetime == -1 then
		return 0
	end
	if self.expire and self.expire > 0 then
		return self.expire * 60000
	end
	local conf = self:GetConfig()
	return conf and conf.relive or 0
end

function 怪物对象类:GetDisappear()
	local conf = self:GetConfig()
	return conf and conf.disappear or 0
end

function 怪物对象类:GetType()
	local conf = self:GetConfig()
	return conf and conf.type or 0
end

function 怪物对象类:GetBodyID()
	local conf = self:GetConfig()
	return conf and conf.bodyid[1] or 0
end

function 怪物对象类:GetCallID()
	local conf = self:GetConfig()
	return (conf and conf.callid) and conf.callid[1] or 0
end

function 怪物对象类:GetCallRate()
	local conf = self:GetConfig()
	return (conf and conf.callid) and conf.callid[2] or 1
end

function 怪物对象类:GetRadius()
	local conf = self:GetConfig()
	return conf and conf.radius or 0
end

function 怪物对象类:HasSkill()
	local conf = self:GetConfig()
	return conf and #conf.skill > 0
end

function 怪物对象类:GetConfig()
  local ret = 怪物表[self.m_nMonsterID]
  if ret == nil then
    print("invalid 怪物 id: ", self.m_nMonsterID)
  end
  return ret
end

function 怪物对象类:GetBornPos()
	local master = 对象类:GetObj(self.ownerid)
	if master then
		return master:GetPosition()
	else
		return self.bornx, self.borny
	end
end

function 怪物对象类:ChangeName()
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_NAME]
	oHumanInfoMsg.rolename = self:GetName()
	oHumanInfoMsg.guildname = ""
	oHumanInfoMsg.color = 0
	oHumanInfoMsg.titleLen = 0
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.ownerid = self.ownerid
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 怪物对象类:UpdateObjInfo()
	local conf = self:GetConfig()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or self.monsterid ~= 0 and 怪物表[self.monsterid] or nil
	
	local oMsgCacheData = 派发器.ProtoContainer[协议ID.GG_ADD_MONSTER_CACHE_DATA]
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
	oMsgCacheData.confid = self.m_nMonsterID
	oMsgCacheData.bodyidLen = confnew and #confnew.bodyid or #conf.bodyid
	oMsgCacheData.bodyid[1] = confnew and confnew.bodyid[1] or conf.bodyid[1] or 0
	oMsgCacheData.bodyid[2] = confnew and confnew.bodyid[2] or conf.bodyid[2] or 0
	oMsgCacheData.effidLen = confnew and #confnew.effid or #conf.effid
	oMsgCacheData.effid[1] = confnew and confnew.effid[1] or conf.effid[1] or 0
	oMsgCacheData.effid[2] = confnew and confnew.effid[2] or conf.effid[2] or 0
	oMsgCacheData.type = self:GetType()
	oMsgCacheData.ownerid = self.ownerid
	oMsgCacheData.teamid = self.teamid
	
	消息类.SendMsg(oMsgCacheData, self.id)
end

function 怪物对象类:ChangeInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_INFO]
	oReturnMsg.objid = self.id
	oReturnMsg.maxhp = self:获取生命值()
	oReturnMsg.hp = self.hp
	oReturnMsg.mergehpLen = 0
	消息类.ZoneBroadCast(oReturnMsg, self.id)
end

function 怪物对象类:ChangeSpeed()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or self.monsterid ~= 0 and 怪物表[self.monsterid] or nil
	self:SetEngineMoveSpeed((confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度())
	self:UpdateObjInfo()
	
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_SPEED]
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.speed = (confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度()
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 怪物对象类:ChangeBody()
	local conf = self:GetConfig()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or self.monsterid ~= 0 and 怪物表[self.monsterid] or nil
	self:SetEngineMoveSpeed((confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度())
	self:UpdateObjInfo()
	
	local oMsgChangeBodyID = 派发器.ProtoContainer[协议ID.GC_CHANGE_BODY]
	oMsgChangeBodyID.objid = self.id
	oMsgChangeBodyID.bodyid = confnew and confnew.bodyid[1] or conf.bodyid[1] or 0
	oMsgChangeBodyID.effid = confnew and confnew.effid[1] or conf.effid[1] or 0
	oMsgChangeBodyID.speed = (confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度()
	
	消息类.ZoneBroadCast(oMsgChangeBodyID, self.id)
end

function 怪物对象类:ChangeStatus(status)
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

function 怪物对象类:JumpScene(nSceneID, nX, nY)
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
	if self.ownerid ~= -1 or 场景管理.GetSceneObjCount(nSceneID, 公共定义.OBJ_TYPE_HUMAN) > 0 then
		self:EnterScene(nSceneID, nX, nY)
	end
  end
end

function 怪物对象类:CalcPower()
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

function 怪物对象类:获取职业()
	local conf = self:GetConfig()
	return conf and conf.职业 or 1
end

function 怪物对象类:当前生命()
	return self.hp
end

function 怪物对象类:当前魔法()
	return self.mp
end

function 怪物对象类:获取生命值()
	local 生命值 = self.属性值[公共定义.属性_生命值]
	if self.attr[公共定义.属性_生命值] then
		return 生命值 + self.attr[公共定义.属性_生命值][1] - self.attr[公共定义.属性_生命值][2]
	else
		return 生命值
	end
end

function 怪物对象类:获取魔法值()
	if self.attr[公共定义.属性_魔法值] then
		return self.属性值[公共定义.属性_魔法值] + self.attr[公共定义.属性_魔法值][1] - self.attr[公共定义.属性_魔法值][2]
	else
		return self.属性值[公共定义.属性_魔法值]
	end
end

function 怪物对象类:获取防御()
	if self.attr[公共定义.属性_防御] then
		return self.属性值[公共定义.属性_防御] + self.attr[公共定义.属性_防御][1] - self.attr[公共定义.属性_防御][2]
	else
		return self.属性值[公共定义.属性_防御]
	end
end

function 怪物对象类:获取防御上限()
	if self.attr[公共定义.属性_防御上限] then
		return self.属性值[公共定义.属性_防御上限] + self.attr[公共定义.属性_防御上限][1] - self.attr[公共定义.属性_防御上限][2]
	else
		return self.属性值[公共定义.属性_防御上限]
	end
end

function 怪物对象类:获取魔御()
	if self.attr[公共定义.属性_魔御] then
		return self.属性值[公共定义.属性_魔御] + self.attr[公共定义.属性_魔御][1] - self.attr[公共定义.属性_魔御][2]
	else
		return self.属性值[公共定义.属性_魔御]
	end
end

function 怪物对象类:获取魔御上限()
	if self.attr[公共定义.属性_魔御上限] then
		return self.属性值[公共定义.属性_魔御上限] + self.attr[公共定义.属性_魔御上限][1] - self.attr[公共定义.属性_魔御上限][2]
	else
		return self.属性值[公共定义.属性_魔御上限]
	end
end

function 怪物对象类:获取攻击()
	if self.attr[公共定义.属性_攻击] then
		return self.属性值[公共定义.属性_攻击] + self.attr[公共定义.属性_攻击][1] - self.attr[公共定义.属性_攻击][2]
	else
		return self.属性值[公共定义.属性_攻击]
	end
end

function 怪物对象类:获取攻击上限()
	if self.attr[公共定义.属性_攻击上限] then
		return self.属性值[公共定义.属性_攻击上限] + self.attr[公共定义.属性_攻击上限][1] - self.attr[公共定义.属性_攻击上限][2]
	else
		return self.属性值[公共定义.属性_攻击上限]
	end
end

function 怪物对象类:获取魔法()
	if self.attr[公共定义.属性_魔法] then
		return self.属性值[公共定义.属性_魔法] + self.attr[公共定义.属性_魔法][1] - self.attr[公共定义.属性_魔法][2]
	else
		return self.属性值[公共定义.属性_魔法]
	end
end

function 怪物对象类:获取魔法上限()
	if self.attr[公共定义.属性_魔法上限] then
		return self.属性值[公共定义.属性_魔法上限] + self.attr[公共定义.属性_魔法上限][1] - self.attr[公共定义.属性_魔法上限][2]
	else
		return self.属性值[公共定义.属性_魔法上限]
	end
end

function 怪物对象类:获取道术()
	if self.attr[公共定义.属性_道术] then
		return self.属性值[公共定义.属性_道术] + self.attr[公共定义.属性_道术][1] - self.attr[公共定义.属性_道术][2]
	else
		return self.属性值[公共定义.属性_道术]
	end
end

function 怪物对象类:获取道术上限()
	if self.attr[公共定义.属性_道术上限] then
		return self.属性值[公共定义.属性_道术上限] + self.attr[公共定义.属性_道术上限][1] - self.attr[公共定义.属性_道术上限][2]
	else
		return self.属性值[公共定义.属性_道术上限]
	end
end

function 怪物对象类:获取幸运()
	if self.attr[公共定义.属性_幸运] then
		return self.属性值[公共定义.属性_幸运] + self.attr[公共定义.属性_幸运][1] - self.attr[公共定义.属性_幸运][2]
	else
		return self.属性值[公共定义.属性_幸运]
	end
end

function 怪物对象类:获取准确()
	if self.attr[公共定义.属性_准确] then
		return self.属性值[公共定义.属性_准确] + self.attr[公共定义.属性_准确][1] - self.attr[公共定义.属性_准确][2]
	else
		return self.属性值[公共定义.属性_准确]
	end
end

function 怪物对象类:获取敏捷()
	if self.attr[公共定义.属性_敏捷] then
		return self.属性值[公共定义.属性_敏捷] + self.attr[公共定义.属性_敏捷][1] - self.attr[公共定义.属性_敏捷][2]
	else
		return self.属性值[公共定义.属性_敏捷]
	end
end

function 怪物对象类:获取魔法命中()
	if self.attr[公共定义.属性_魔法命中] then
		return self.属性值[公共定义.属性_魔法命中] + self.attr[公共定义.属性_魔法命中][1] - self.attr[公共定义.属性_魔法命中][2]
	else
		return self.属性值[公共定义.属性_魔法命中]
	end
end

function 怪物对象类:获取魔法躲避()
	if self.attr[公共定义.属性_魔法躲避] then
		return self.属性值[公共定义.属性_魔法躲避] + self.attr[公共定义.属性_魔法躲避][1] - self.attr[公共定义.属性_魔法躲避][2]
	else
		return self.属性值[公共定义.属性_魔法躲避]
	end
end

function 怪物对象类:获取生命恢复()
	if self.attr[公共定义.属性_生命恢复] then
		return self.属性值[公共定义.属性_生命恢复] + self.attr[公共定义.属性_生命恢复][1] - self.attr[公共定义.属性_生命恢复][2]
	else
		return self.属性值[公共定义.属性_生命恢复]
	end
end

function 怪物对象类:获取魔法恢复()
	if self.attr[公共定义.属性_魔法恢复] then
		return self.属性值[公共定义.属性_魔法恢复] + self.attr[公共定义.属性_魔法恢复][1] - self.attr[公共定义.属性_魔法恢复][2]
	else
		return self.属性值[公共定义.属性_魔法恢复]
	end
end

function 怪物对象类:获取中毒恢复()
	if self.attr[公共定义.属性_中毒恢复] then
		return self.属性值[公共定义.属性_中毒恢复] + self.attr[公共定义.属性_中毒恢复][1] - self.attr[公共定义.属性_中毒恢复][2]
	else
		return self.属性值[公共定义.属性_中毒恢复]
	end
end

function 怪物对象类:获取攻击速度()
	if self.attr[公共定义.属性_攻击速度] then
		return self.属性值[公共定义.属性_攻击速度] + self.attr[公共定义.属性_攻击速度][1] - self.attr[公共定义.属性_攻击速度][2]
	else
		return self.属性值[公共定义.属性_攻击速度]
	end
end

function 怪物对象类:获取移动速度()
	local 移动速度 = self.属性值[公共定义.属性_移动速度]
	if self.attr[公共定义.属性_移动速度] then
		return 移动速度 + self.attr[公共定义.属性_移动速度][1] - self.attr[公共定义.属性_移动速度][2]
	else
		return 移动速度
	end
end

function 怪物对象类:RecoverHP(coverhp)
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
	oReturnMsg.effid2 = (oldhp == 0 and self.isrobot) and 3657 or self.hp == 0 and self:GetDeadEff() or 0
	oReturnMsg.dechp = oldhp - self.hp
	oReturnMsg.crit = 0
	oReturnMsg.status = self.hp == 0 and 1 or oldhp == 0 and 2 or 0
	消息类.ZoneBroadCast(oReturnMsg, self.id)
	return true
end
