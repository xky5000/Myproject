local 公共定义 = require("公用.公共定义")
local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 计时器ID = require("公用.计时器ID")
local NewEnum = require("公用.实用工具").NewEnum
local 日志 = require("公用.日志")
local 广播 = require("公用.广播")
local 地图表 = require("配置.地图表").Config
local 玩家DB = require("玩家.玩家DB").玩家DB
local 怪物表 = require("配置.怪物表").Config
local 玩家属性表 = require("配置.玩家属性表").Config
local 背包逻辑 = require("物品.背包逻辑")
local 物品表 = require("配置.物品表").Config
local 宠物表 = require("配置.宠物表").Config
local 宠物DB = require("宠物.宠物DB")
local 宠物逻辑 = require("宠物.宠物逻辑")
local 背包DB = require("物品.背包DB")
local 技能信息表 = require("配置.技能信息表").Config
local 技能逻辑 = require("技能.技能逻辑")
local Buff表 = require("配置.Buff表").Config
local 排行榜管理 = require("排行榜.排行榜管理")
local 英雄排行管理 = require("排行榜.英雄排行管理")
local 宠物排行管理 = require("排行榜.宠物排行管理")
local VIP推广排行管理 = require("排行榜.VIP推广排行管理")
local 物品逻辑 = require("物品.物品逻辑")
local 聊天逻辑 = require("聊天.聊天逻辑")
local 拾取物品逻辑 = require("怪物.拾取物品逻辑")
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local 充值礼包表 = require("配置.充值礼包表").Config
local 任务表 = require("配置.任务表").Config
local 玩家事件处理 = require("玩家.事件处理")
local 事件触发 = require("触发器.事件触发")
local 登录触发 = require("触发器.登录触发")
local Npc触发 = require("触发器.Npc触发")
local 全局变量 = require("触发器.全局变量")
local 队伍管理 = require("队伍.队伍管理")
local 行会管理 = require("行会.行会管理")
local 行会定义 = require("行会.行会定义")
local 城堡管理 = require("行会.城堡管理")
local 套装表 = require("配置.套装表").Config
local Npc表 = require("配置.Npc表").Config
local 后台事件处理 = require("后台管理.事件处理")

VIP礼包表 = {}
每日充值表 = {}
for i,v in ipairs(充值礼包表) do
	if v.类型 == 0 then
		VIP礼包表[#VIP礼包表+1] = v
	else
		每日充值表[#每日充值表+1] = v
	end
end

--ObjHuman继承Obj的操作
玩家对象类 = 对象类:New()
在线玩家管理 = 在线玩家管理 or {}
在线账号管理 = 在线账号管理 or {}

物品名字表 = 物品名字表 or {}
地图名字表 = 地图名字表 or {}
怪物名字表 = 怪物名字表 or {}
Npc名字表 = Npc名字表 or {}

function 获取物品名字ID(id)
	if id == 0 or id == "" then
		return 0
	end
	if type(id) == "string" then
		if 物品名字表[id] then
			return 物品名字表[id]
		else
			for k,v in pairs(物品表) do
				if v.name == id then
					物品名字表[v.name] = k
					return k
				end
			end
		end
		return 0
	end
	return id
end

function 获取地图名字ID(id)
	if id == 0 or id == "" then
		return 0
	end
	if type(id) == "string" then
		if 地图名字表[id] then
			return 地图名字表[id]
		else
			for k,v in pairs(地图表) do
				if v.name == id then
					地图名字表[v.name] = k
					return k
				end
			end
		end
		return 0
	end
	return id
end

function 获取怪物名字ID(id)
	if id == 0 or id == "" then
		return 0
	end
	if type(id) == "string" then
		if 怪物名字表[id] then
			return 怪物名字表[id]
		else
			for k,v in pairs(怪物表) do
				if v.name == id then
					怪物名字表[v.name] = k
					return k
				end
			end
		end
		return 0
	end
	return id
end

function 获取Npc名字ID(id)
	if id == 0 or id == "" then
		return 0
	end
	if type(id) == "string" then
		if Npc名字表[id] then
			return Npc名字表[id]
		else
			for k,v in pairs(Npc表) do
				if v.name == id then
					Npc名字表[v.name] = k
					return k
				end
			end
		end
		return 0
	end
	return id
end

function 玩家对象类:SendTipsMsg(postype, msg)
	local oOffLineMsg = 派发器.ProtoContainer[协议ID.GC_TIPS_MSG]
	oOffLineMsg.postype = postype
	if 公共定义.使用绑定货币 == 1 then
		oOffLineMsg.msg = msg
	else
		oOffLineMsg.msg = msg:gsub("绑定","")
	end
	消息类.SendMsg(oOffLineMsg, self.id)
end

function 玩家对象类:SendVIPSpread()
	local oOffLineMsg = 派发器.ProtoContainer[协议ID.GC_VIP_SPREAD]
	oOffLineMsg.rolename = self.m_db.VIP推广人
	oOffLineMsg.成长经验 = self.m_db.VIP成长经验
	oOffLineMsg.推广人数 = self.m_db.VIP推广人数
	oOffLineMsg.推广有效人数 = self.m_db.VIP推广有效人数
	oOffLineMsg.礼包领取Len = #VIP礼包表
	for i,v in ipairs(VIP礼包表) do
		oOffLineMsg.礼包领取[i] = self.m_db.VIP礼包领取[i] or 0
	end
	oOffLineMsg.每日充值领取Len = #每日充值表
	for i,v in ipairs(每日充值表) do
		oOffLineMsg.每日充值领取[i] = self.m_db.每日充值领取[i] or 0
	end
	消息类.SendMsg(oOffLineMsg, self.id)
end

function 玩家对象类:DoDisconnect(nReason)
	self.m_db.lastLogout = os.time()
	日志.WriteLog(日志.LOGID_USER_OUTLIFE, self:GetAccount() .. " Logout reason:" .. nReason)
	日志.Write(日志.LOGID_OSS_LOGOUT, os.time(), self:GetAccount(), self:GetName(), self.m_db.level, os.time() - self.m_db.lastLogin, self.m_db.ip, nReason, self.m_db.mapid, self:GetPosition())
	if not self.是否英雄 and not self.fake and not self.是否离线挂机 and nReason ~= 公共定义.DISCONNECT_REASON_ANOTHER_CHAR_LOGIN then
		local call1 = 事件触发._M["call_退出游戏"]
		if call1 then
			self:显示对话(-2,call1(self))
		end
		local call2 = 事件触发._M["call_关闭游戏"]
		if call2 then
			self:显示对话(-2,call2(self))
		end
	end
	local fd = _GetFD(self.id)
	if not self.fake and not self.是否离线挂机 then
		self:Destroy()
	end
	if self.是否离线挂机 then
		self:Save()
		self:CleanFD()
	end
	local oOffLineMsg = 派发器.ProtoContainer[协议ID.GC_DISCONNECT_NOTIFY]
	oOffLineMsg.reason = nReason
	消息类.SendMsgByFD(oOffLineMsg, fd)
end

function 玩家对象类:ReSetMetatable()
  玩家对象类.__index = 玩家对象类
  setmetatable(self, 玩家对象类)
end

function 玩家对象类:New(nFD)

  local nObjID = self:CreateObj(nFD == -1 and 公共定义.OBJ_TYPE_HERO or 公共定义.OBJ_TYPE_HUMAN, nFD)
  assert(nObjID ~= -1, "玩家对象类:CreateObj fail")
  if 对象管理[nObjID] then
	assert(nil, "lua newobj fail human already exist")
  end

    对象管理[nObjID] = {
      id = nObjID,
	  是否英雄 = nFD == -1,
      m_nSceneID = -1,
	  m_status = 0,
	  call = {},
	  cd = {},
	  ownerid = -1,
	  enmity = {},
	  enemy = {},
	  hp = 0,
	  hpMax = 0,
	  mp = 0,
	  mpMax = 0,
	  buffhit = {},
	  buffend = {},
	  equips = {},
	  属性值 = {},
	  额外属性 = {},
	  xpstatus = 0,
	  xpcd = 0,
	  xpcdmax = 0,
	  mountid = 0,
	  wingid = 0,
	  avatarid = 0,
	  monsterid = 0,
	  pet = {},
	  petmerge = {},
	  attr = {},
 	  attrlearn = {},
	  attrattach = {},
	  teamid = 0,
	  viewid = -1,
	  entersceneid = nil,
	  relivetime = nil,
	  collectid = -1,
	  私人变量 = {},
	  在线属性 = {},
	  管理属性 = {},
	  suitcnts = {},
	  costtime = {},
	  graynametime = 0,
	  titles = {},
	  nametitle = nil,
	  namecolor = nil,
  }

  local obj = 对象管理[nObjID]

  setmetatable(obj, self)
  self.__index = self

  return obj
end

function 玩家对象类:StopCollect()
	if self.collectid ~= -1 then
		local 采集物 = 对象类:GetObj(self.collectid)
		if 采集物 and 采集物.collecttimer then
			_DelTimer(采集物.collecttimer, 采集物.id)
			采集物.collecter = -1
		end
		self.collectid = -1
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_COLLECT_START]
		oReturnMsg.objid = -1
		消息类.SendMsg(oReturnMsg, self.id)
	end
end

function 玩家对象类:CheckAttrLearn(是否英雄)
	--[[
	local skills = 是否英雄 and self.m_db.英雄技能 or self.m_db.skills
	local human = 是否英雄 and self.英雄 or self
	local 转生加点 = 是否英雄 and self.m_db.英雄转生加点 or self.m_db.转生加点
	human.attrlearn = {}
	human.attrlearn[公共定义.属性_生命值] = human.m_db.转生等级 * 100
	human.attrlearn[公共定义.属性_魔法值] = human.m_db.转生等级 * 100
	for k,v in pairs(转生加点) do
		if k == 1 then
			human.attrlearn[公共定义.属性_生命值] = human.attrlearn[公共定义.属性_生命值] + v*(Config.ISWZ and 100 or 10)
		elseif k == 2 then
			human.attrlearn[公共定义.属性_魔法值] = human.attrlearn[公共定义.属性_魔法值] + v*(Config.ISWZ and 100 or 10)
		elseif k == 3 then
			human.attrlearn[公共定义.属性_防御] = (human.attrlearn[公共定义.属性_防御] or 0) + v*(Config.ISWZ and 10 or 1)
			human.attrlearn[公共定义.属性_防御上限] = (human.attrlearn[公共定义.属性_防御上限] or 0) + v*(Config.ISWZ and 10 or 1)
		elseif k == 4 then
			human.attrlearn[公共定义.属性_魔御] = (human.attrlearn[公共定义.属性_魔御] or 0) + v*(Config.ISWZ and 10 or 1)
			human.attrlearn[公共定义.属性_魔御上限] = (human.attrlearn[公共定义.属性_魔御上限] or 0) + v*(Config.ISWZ and 10 or 1)
		elseif k == 5 then
			human.attrlearn[公共定义.属性_攻击] = (human.attrlearn[公共定义.属性_攻击] or 0) + v*(Config.ISWZ and 10 or 1)
			human.attrlearn[公共定义.属性_攻击上限] = (human.attrlearn[公共定义.属性_攻击上限] or 0) + v*(Config.ISWZ and 10 or 1)
		elseif k == 6 then
			human.attrlearn[公共定义.属性_魔法] = (human.attrlearn[公共定义.属性_魔法] or 0) + v*(Config.ISWZ and 10 or 1)
			human.attrlearn[公共定义.属性_魔法上限] = (human.attrlearn[公共定义.属性_魔法上限] or 0) + v*(Config.ISWZ and 10 or 1)
		elseif k == 7 then
			human.attrlearn[公共定义.属性_道术] = (human.attrlearn[公共定义.属性_道术] or 0) + v*(Config.ISWZ and 10 or 1)
			human.attrlearn[公共定义.属性_道术上限] = (human.attrlearn[公共定义.属性_道术上限] or 0) + v*(Config.ISWZ and 10 or 1)
		end
	end
	
	for i,v in ipairs(skills) do
	]]
	--	local conf = 技能信息表[v[1]]
	--[[
		if conf then
			if conf.passive == 1 then
				for ii,vv in ipairs(conf.prop) do
					human.attrlearn[vv] = (human.attrlearn[vv] or 0) + conf.damage1 + (v[2]-1)*conf.damage2
				end
			end
		end
	end
	
	human:CalcDynamicAttr()
	]]
end

function 玩家对象类:ChangeJob(job, 是否英雄)
	if 是否英雄 and not self.英雄 then
		return
	end
	local human = 是否英雄 and self.英雄 or self
	if not human or human.hp <= 0 then
		return
	end
	if human.m_db.job == job then
		return
	end
	if 是否英雄 then
		self.m_db.英雄职业 = job
		self.m_db.英雄技能 = {}
	end
	human.m_db.job = job
	human.m_db.skills = {}
	if not 是否英雄 then
		self.m_db.skillquicks = {}
	end
	if 技能逻辑.CheckSkillLearn(self, 是否英雄) and 是否英雄 then
		self.英雄.skills = {}
		for i,v in ipairs(self.m_db.英雄技能) do
			local conf = 技能信息表[v[1]]
			if conf then
				if conf.passive == 0 and v[3] == 1 then
					self.英雄.skills[#self.英雄.skills+1] = {conf.skill[1],100}
				end
			end
		end
	end
	self:CheckAttrLearn(是否英雄)
	human:ChangeBody()
	human:SendActualAttr()
	if 是否英雄 then
		self:SendEquipView(self.英雄, true)
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_JOB]
	oReturnMsg.objid = human.id
	oReturnMsg.rolename = human.nametitle or human:GetName()
	oReturnMsg.sex = human.m_db.sex
	oReturnMsg.job = human.m_db.job
	消息类.ZoneBroadCast(oReturnMsg, human.id)
	return true
end

function 玩家对象类:ChangeAvatar(avatarids, time)
	if self.hp <= 0 then
		return
	end
	local avatarid = 0
	if type(avatarids) == "table" then
		avatarid = avatarids[math.random(1,#avatarids)]
	else
		avatarid = avatarids
	end
	if avatarid == 0 then
		return
	end
	self.avatarid = avatarid
	self:ChangeBody()
	技能逻辑.SendSkillInfo(self)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_XP_USE]
	oReturnMsg.objid = self.id
	oReturnMsg.effid = 3649
	消息类.ZoneBroadCast(oReturnMsg, self.id)
	self.xpUseDownTimer = _AddTimer(self.id, 计时器ID.TIMER_XP_FINISH, time, 1)
	return true
end

function 玩家对象类:ChangeTeam(teamid)
	self.teamid = teamid
	self:UpdateObjInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_TEAM]
	oReturnMsg.objid = self.id
	oReturnMsg.teamid = self.teamid
	消息类.ZoneBroadCast(oReturnMsg, self.id)
	for k,v in pairs(self.call) do
		v:ChangeTeam(teamid)
	end
	for k,v in pairs(self.pet) do
		v:ChangeTeam(teamid)
	end
	if self.英雄 then
		self.英雄:ChangeTeam(teamid)
	end
end

function 玩家对象类:SendActualAttr()
	local conf = 玩家属性表[self.m_db.level]
	if not conf then
		return
	end
	local human = self
	if self.是否英雄 then
		human = 对象类:GetObj(self.ownerid)
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_ACTUAL_ATTR]
	oReturnMsg.objid = self.id
	oReturnMsg.expmax = conf.exp
	oReturnMsg.exp = self.m_db.exp
	oReturnMsg.mpmax = self.mpMax
	oReturnMsg.mp = self.mp
	oReturnMsg.tp = self.m_db.tp
	
	消息类.SendMsg(oReturnMsg, human.id)
end

function 玩家对象类:AddQuickItem(itemid)
	local conf = 物品表[itemid]
	if conf == nil or conf.type1 ~= 2 or (conf.type2 ~= 3 and conf.type2 ~= 9 and conf.type2 ~= 10) then
		return
	end
	local bagdb = self.m_db.bagdb
	local exist = false
	for i=1,6 do
		if bagdb.quicks[i] and bagdb.quicks[i] == itemid then
			exist = true
			break
		end
	end
	if not exist then
		for i=1,6 do
			if not bagdb.quicks[i] or bagdb.quicks[i] == 0 then
				bagdb.quicks[i] = itemid
				背包逻辑.SendQuickQuery(self)
				break
			end
		end
	end
end

function 玩家对象类:AddSkillQuickItem(skillinfoid)
	local conf = 技能信息表[skillinfoid]
	if conf == nil or conf.passive == 1 or conf.special ~= 0 then
		return
	end
	local skillquicks = self.m_db.skillquicks
	local exist = false
	for i=1,6 do
		if skillquicks[i] and skillquicks[i] == skillinfoid then
			exist = true
			break
		end
	end
	if not exist then
		for i=1,6 do
			if not skillquicks[i] or skillquicks[i] == 0 then
				skillquicks[i] = skillinfoid
				技能逻辑.SendQuickQuery(self)
				break
			end
		end
	end
end

function 玩家对象类:GetBornPos()
	local master = 对象类:GetObj(self.ownerid)
	if master then
		return master:GetPosition()
	else
		return self:GetPosition()
	end
end

function 玩家对象类:召唤英雄()
	if self.m_db.英雄职业 == 0 then
		return
	end
	local x,y = self:GetPosition()
	if self.英雄 then
		self.英雄:RecoverHP(self.英雄.hpMax)
		self.英雄.relivetime = nil
		return
	end
	self.英雄 = 玩家对象类:New(-1)
	self.英雄.m_status = self.m_status
	self.英雄.m_db = {
		name = self:GetName().."的英雄",
		account = "",
		job = self.m_db.英雄职业,
		sex = self.m_db.英雄性别,
		level = self.m_db.英雄等级,
		exp = self.m_db.英雄经验,
		bagdb = {baggrids={},equips=self.m_db.英雄装备},--[1]={id=10320},[2]={id=10319}
		petdb = {call={}},
		转生等级 = self.m_db.英雄转生等级,
		tp = 0,
		skills = self.m_db.英雄技能,
		显示时装 = self.m_db.英雄显示时装,
		显示炫武 = self.m_db.英雄显示炫武,
		PK值 = 0,
		药水属性 = {},
	}
	技能逻辑.CheckSkillLearn(self, true)
	self.英雄.skills = {}--self.m_db.英雄技能
	for i,v in ipairs(self.m_db.英雄技能) do
		local conf = 技能信息表[v[1]]
		if conf then
			if conf.passive == 0 and v[3] == 1 then
				self.英雄.skills[#self.英雄.skills+1] = {conf.skill[1],100}
			end
		end
	end
	self.英雄.useskills = true
	self.英雄.ownerid = self.id
	self.英雄.teamid = self.teamid
	self:CheckAttrLearn(true)
	self.英雄:CalcDynamicAttrImpl()
	--self.英雄.hpMax = self.英雄:获取生命值()
	--self.英雄.mpMax = self.英雄:获取魔法值()
	if self.m_db.英雄复活 > 0 then
		self.英雄.hp = 0
		self.英雄.relivetime = _CurrentTime() + self.m_db.英雄复活
		self.m_db.英雄复活 = 0
	else
		self.英雄.hp = self.m_db.英雄生命 > 0 and self.m_db.英雄生命 or self.英雄.hpMax
	end
	self.英雄.mp = self.m_db.英雄魔法 > 0 and self.m_db.英雄魔法 or self.英雄.mpMax
	self.英雄:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, self.英雄.hp)
	--self.英雄:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, self.英雄.hpMax)
	self.英雄:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MP, self.英雄.hp)
	--self.英雄:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXMP, self.英雄.mpMax)
	if Config.ISLT then
		self.英雄:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, 1)
		self.英雄.inrunbock = true
	end
	self.英雄:SetEngineMoveSpeed(self.英雄:获取移动速度())
	self.英雄:UpdateObjInfo()
	self.英雄:ChangeInfo()
	self.英雄:CheckDead()
	if self.m_nSceneID ~= -1 then
		self.英雄:EnterScene(self.m_nSceneID, x, y)
		if self.英雄.hp > 0 then
			local nX, nY = 实用工具.GetRandPos(x, y, 200,self.英雄.Is2DScene,self.英雄.MoveGridRate)
			self.英雄:MoveTo(nX, nY)
		end
	end
	--_AddTimer(self.英雄.id, 计时器ID.TIMER_MONSTER_MOVEAI,500,-1, 0, 0, 0)
	self:SendHeroInfoMsg()
	self:SendEquipView(self.英雄, true)
	local call = 事件触发._M["call_英雄上线"]
	if call then
		self:显示对话(-2,call(self))
	end
end

function 玩家对象类:ReCallPet()
	for i,v in ipairs(self.m_db.petdb.call) do
		local ind = 宠物DB.FindIndex(self.m_db.petdb.db, v.index)
		self:CallPet(v.index, self.m_db.petdb.db[ind].id, v.merge == 0)
	end
	local maxmerge = 1
	while 1 do
		local findmerge = false
		for i,v in ipairs(self.m_db.petdb.call) do
			if maxmerge == v.merge then
				self:MergePet(v.index, false)
				findmerge = true
				maxmerge = maxmerge + 1
				break
			end
		end
		if not findmerge then
			break
		end
	end
	local escortId = Npc对话逻辑.CheckEscortTask(self)
	if escortId and self.m_db.task[escortId].state ~= 0 then
		local conf = 任务表[escortId]
		if conf and conf.escortid ~= 0 and self.m_db.镖车血量 > 0 then
			local ox,oy = self:GetPosition()
			local m = 怪物对象类:CreateMonster(-1, conf.escortid, ox, oy, self.id, nil, self.m_db.镖车血量)
			for kk,vv in pairs(self.m_db.镖车玩家伤害) do
				m.humanenmity[tostring(kk)] = vv
			end
			m.teamid = self.teamid
			m:EnterScene(self.m_nSceneID, m.bornx, m.borny)
			self.call[-1] = m
			local nX, nY = 实用工具.GetRandPos(ox, oy, 200, m.Is2DScene, m.MoveGridRate)
			m:MoveTo(nX, nY)
		end
	end
	local spiritId = Npc对话逻辑.CheckSpiritTask(self)
	if spiritId and self.m_db.task[spiritId].state ~= 0 then
		local conf = 任务表[spiritId]
		if conf and conf.escortid ~= 0 and self.m_db.镖车血量 > 0 then
			local ox,oy = self:GetPosition()
			local m = 怪物对象类:CreateMonster(-1, conf.escortid, ox, oy, self.id, nil, self.m_db.镖车血量)
			for kk,vv in pairs(self.m_db.镖车玩家伤害) do
				m.humanenmity[tostring(kk)] = vv
			end
			m.teamid = self.teamid
			m:EnterScene(self.m_nSceneID, m.bornx, m.borny)
			self.call[-1] = m
			local nX, nY = 实用工具.GetRandPos(ox, oy, 200, m.Is2DScene, m.MoveGridRate)
			m:MoveTo(nX, nY)
		end
	end
end

function 玩家对象类:ReAddBuff()
	for k,v in pairs(self.m_db.bufftime) do
		self:AddBuff(k,v)
	end
	
	
end

function 玩家对象类:GetSkillLevel(skillid)
	for i,v in ipairs(self.m_db.skills) do
		local conf = 技能信息表[v[1]]
		if conf and 实用工具.FindIndex(conf.skill,skillid) then
			return v[2]
		end
	end
	return 0
end

function 玩家对象类:LearnSkill(skillinfoid, 是否英雄)
	if 是否英雄 and not self.英雄 then
		self:SendTipsMsg(1,"请先召唤英雄")
		return
	end
	local skills = 是否英雄 and self.m_db.英雄技能 or self.m_db.skills
	if #skills >= 100 then
		self:SendTipsMsg(1,"技能已满")
		return
	end
	for i,v in ipairs(skills) do
		if v[1] == skillinfoid then
			self:SendTipsMsg(1,"该技能已学习")
			return
		end
	end
	local conf = 技能信息表[skillinfoid]
	if conf == nil then
		return
	end
	if not 是否英雄 and (self.m_db.job == 0 or (conf.job ~= 0 and self.m_db.job ~= conf.job)) then
		self:SendTipsMsg(1,"职业不符")
		return
	end
	if 是否英雄 and (self.m_db.英雄职业 == 0 or (conf.job ~= 0 and self.m_db.英雄职业 ~= conf.job)) then
		self:SendTipsMsg(1,"职业不符")
		return
	end
	skills[#skills+1] = {skillinfoid,1,(conf.passive==0 and conf.hangup==1) and 1 or 0}
	if conf.passive == 1 then
		self:CheckAttrLearn(是否英雄)
	end
	if not 是否英雄 then
		self:AddSkillQuickItem(skillinfoid)
	end
	if not Config.IS3G then
		self:SendTipsMsg(1, "#s16,#cffff00,成功学习#cff00,"..conf.name)
	end
	技能逻辑.SendSkillInfo(self)
	
	self:增加状态技能()
	
	return true
end

function 玩家对象类:AddPet(petid, starlevel, grade, wash)
	if not petid or petid == 0 then
		return
	end
	local conf = 宠物表[petid] or 怪物表[petid]
	if not conf then
		return
	end
	if #self.m_db.petdb.db >= self.m_db.petdb.max then
		return
	end
	return 宠物DB.AddPet(self, petid, starlevel, grade, wash)
end

function 玩家对象类:CallPet(index, petid, enterscene)
	if self.hp <= 0 then
		return
	end
	local conf = 宠物表[petid] or 怪物表[petid]
	if not conf then
		return
	end
	local ind = 宠物DB.FindIndex(self.m_db.petdb.call, index)
	if not ind then
		return
	end
	local dbind = 宠物DB.FindIndex(self.m_db.petdb.db, index)
	if not dbind then
		return
	end
	if self.pet[index] then
		self.pet[index]:Destroy()
		self.pet[index] = nil
	end
	local x,y = self:GetPosition()
	local pet = 宠物对象类:CreatePet(-1, petid, x, y, self.id,
		self.m_db.petdb.db[dbind].level, self.m_db.petdb.db[dbind].exp, self.m_db.petdb.db[dbind].starlevel, self.m_db.petdb.db[dbind].starexp,
		self.m_db.petdb.db[dbind].grade, self.m_db.petdb.db[dbind].wash, self.m_db.petdb.db[dbind])
	pet.teamid = self.teamid
	pet.hp = self.m_db.petdb.call[ind].hp or 0
	pet:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, pet.hp)
	pet:ChangeInfo()
	pet:CheckDead()
	self.pet[index] = pet
	if enterscene and self.m_nSceneID ~= -1 then
		pet:EnterScene(self.m_nSceneID, x, y)
		local nX, nY = 实用工具.GetRandPos(x, y, conf.patrol,pet.Is2DScene,pet.MoveGridRate)
		pet:MoveTo(nX, nY)
	end
	return true
end

function 玩家对象类:ChangeInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_INFO]
	oReturnMsg.objid = self.id
	oReturnMsg.maxhp = self.hpMax
	oReturnMsg.hp = self.hp
	oReturnMsg.mergehpLen = #self.petmerge
	for i,v in ipairs(self.petmerge) do
		oReturnMsg.mergehp[i].maxhp = v.hpmax
		oReturnMsg.mergehp[i].hp = v.hp
		oReturnMsg.mergehp[i].grade = v.grade
	end
	消息类.ZoneBroadCast(oReturnMsg, self.id)
end

function 玩家对象类:MergePet(index, broadcast)
	if self.hp <= 0 then
		return
	end
	local pet = self.pet[index]
	if not pet then
		return
	end
	for i,v in ipairs(self.petmerge) do
		if v.index == index then
			return
		end
	end
	self.petmerge[#self.petmerge + 1] = {hp=pet.hp,hpmax=pet:获取生命值(),grade=pet:GetGrade(),index=index}
	self:ChangeInfo()
	if broadcast then
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_MERGE_PET]
		oReturnMsg.objid = self.id
		oReturnMsg.petobjid = pet.id
		消息类.ZoneBroadCast(oReturnMsg, self.id)
	end
	pet:LeaveScene()
end

function 玩家对象类:BreakPet(index)
	if self.hp <= 0 then
		return
	end
	local pet = self.pet[index]
	if not pet then
		return
	end
	local mergeindex
	for i,v in ipairs(self.petmerge) do
		if v.index == index then
			mergeindex = i
		end
	end
	if not mergeindex then
		return
	end
	pet.hp = self.petmerge[mergeindex].hp
	pet:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, pet.hp)
	pet:CheckDead()
	table.remove(self.petmerge, mergeindex)
	self:ChangeInfo()
	if self.m_nSceneID ~= -1 then
		local x,y = self:GetPosition()
		pet:EnterScene(self.m_nSceneID, x, y)
		local nX, nY = 实用工具.GetRandPos(x, y, pet:GetPatrol(),pet.Is2DScene,pet.MoveGridRate)
		pet:MoveTo(nX, nY)
	end
end

function 玩家对象类:CheckMergePet()
	if #self.petmerge == 0 then
		return
	end
	if self.petmerge[#self.petmerge].hp > 0 then
		return
	end
	local index = self.petmerge[#self.petmerge].index
	宠物DB.BreakPet(self, index)
end

function 玩家对象类:CheckXPSkill()
	self.xpskill = nil
	if not self.英雄 then
		return
	end
	if self.m_db.bagdb.equips[1] == nil then
		return
	end
	if self.m_db.bagdb.equips[2] == nil then
		return
	end
	if self.英雄.m_db.bagdb.equips[1] == nil then
		return
	end
	if self.英雄.m_db.bagdb.equips[2] == nil then
		return
	end
	if self.m_db.bagdb.equips[1].id < 14062 or self.m_db.bagdb.equips[1].id > 14064 then
		return
	end
	if self.m_db.bagdb.equips[2].id < 14056 or self.m_db.bagdb.equips[2].id > 14061 then
		return
	end
	if self.英雄.m_db.bagdb.equips[1].id < 14062 or self.英雄.m_db.bagdb.equips[1].id > 14064 then
		return
	end
	if self.英雄.m_db.bagdb.equips[2].id < 14056 or self.英雄.m_db.bagdb.equips[2].id > 14061 then
		return
	end
	self.xpskill = 0
	self:SendTipsMsg(1,"#s16,#cff00,成功激活王者之怒")
end

function 玩家对象类:SendXPInfo(icon)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_XP_INFO]
	oReturnMsg.objid = self.id
	oReturnMsg.status = self.xpstatus
	oReturnMsg.cd = self.xpcd
	oReturnMsg.cdmax = self.xpcdmax
	oReturnMsg.icon = icon or 0
	消息类.SendMsg(oReturnMsg, self.id)
end

function 玩家对象类:LevelUp()
	副本管理.LevelUpSceneObj(self.m_nSceneID, self)
	if self.hp > 0 then
		self.hp = self.hpMax
	end
	self:CalcDynamicAttr()
	self:UpdateObjInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_LEVEL_UP]
	oReturnMsg.objid = self.id
	oReturnMsg.level = self.m_db.level
	消息类.ZoneBroadCast(oReturnMsg, self.id)
	local human = self
	if self.是否英雄 then
		human = 对象类:GetObj(self.ownerid)
		human.m_db.英雄等级 = self.m_db.level
		human:SendEquipView(human.英雄, true)
	else
		Npc对话逻辑.CheckHumanTaskAccept(self)
	end
	if 技能逻辑.CheckSkillLearn(human, self.是否英雄) and self.是否英雄 then
		human.英雄.skills = {}
		for i,v in ipairs(human.m_db.英雄技能) do
			local conf = 技能信息表[v[1]]
			if conf then
				if conf.passive == 0 and v[3] == 1 then
					human.英雄.skills[#human.英雄.skills+1] = {conf.skill[1],100}
				end
			end
		end
	end
	if self.是否英雄 then
		local call = 事件触发._M["call_英雄升级"]
		if call then
			human:显示对话(-2,call(human))
		end
	else
		local call = 事件触发._M["call_玩家升级"]
		if call then
			human:显示对话(-2,call(human))
		end
	end
end

function 玩家对象类:AddExp(cnt)
	if cnt <= 0 then
		return
	end
	if 玩家属性表[self.m_db.level+1] == nil then
		--return
	end
	self.m_db.exp = self.m_db.exp + cnt
	self.addexp = cnt
	local call = 事件触发._M["call_获得经验"]
	if call then
		self:显示对话(-2,call(self))
	end
	local oldlevel = self.m_db.level
	while 1 do
		local conf = 玩家属性表[self.m_db.level]
		if not conf then
			break
		end
		if self.m_db.exp >= conf.exp and 玩家属性表[self.m_db.level + 1] then
			self.m_db.exp = self.m_db.exp - conf.exp
			self.m_db.level = self.m_db.level + 1
		else
			break
		end
	end
	if self.m_db.level > oldlevel then
		self:LevelUp()
	end
	self:SendActualAttr()
	return true
end

function 玩家对象类:CheckCostTime(mapid)
	local conf = 地图表[mapid]
	if conf then
		实用工具.DeleteTable(self.costtime)
		if #conf.costtp > 0 then
			self:RecoverTP(-conf.costtp[1])
			self.costtime[0] = 玩家事件处理.g_nSecTimerCounter + conf.costtp[2]*60
		end
		for i,v in ipairs(conf.costex) do
			if v[1] == 1 and v[2] ~= 0 then
				if v[2] > 0 then
					self:DecMoney(v[2], true)
				else
					self:AddMoney(v[2], true)
				end
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif v[1] == 2 and v[2] ~= 0 then
				if v[2] > 0 then
					self:DecRmb(v[2], true)
				else
					self:AddRmb(v[2], true)
				end
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif v[1] == 3 and v[2] ~= 0 then
				self.m_db.泡点数 = math.max(0, self.m_db.泡点数 - v[2])
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif (v[1] == 4 or v[1] == 5) and v[2] ~= 0 then
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif v[1] > 10000 and v[2] ~= 0 then
				if v[2] > 0 then
					背包DB.RemoveCount(self, v[1], v[2])
				else
					local inds = self:PutItemGrids(v[1], v[2], 1, true)
					if inds and #inds > 0 then
						背包逻辑.SendBagQuery(self, inds)
						self:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(v[1])]..物品逻辑.GetItemName(v[1])..(v[2] > 1 and "x"..v[2] or ""))
					end
				end
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			end
		end
	end
end

function 玩家对象类:Transport(mapid, mapx, mapy)
	if self.m_nSceneID == -1 then
		return
	end
	local escortId = Npc对话逻辑.CheckEscortTask(self)
	if escortId and self.m_db.task[escortId].state ~= 0 then
		self:SendTipsMsg(1, "正在押镖中,无法传送")
		return
	end
	local spiritId = Npc对话逻辑.CheckSpiritTask(self)
	if spiritId and self.m_db.task[spiritId].state ~= 0 then
		self:SendTipsMsg(1, "正在护送中,无法传送")
		return
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if nSceneID == -1 then
		return
	end
	local mapheight, mapwidth = _GetHeightAndWidth(nSceneID)
	if mapx <= 0 or mapy <= 0 or mapx >= mapwidth or mapy >= mapheight then
		return
	end
	if nSceneID ~= self.m_nSceneID then
		local conf = 地图表[mapid]
		if not conf then
			return
		end
		if #conf.costtp > 0 and self.m_db.tp < conf.costtp[1] then
			self:SendTipsMsg(1,"体力不足")
			return
		end
		for i,v in ipairs(conf.costex) do
			if v[1] == 1 and v[2] > 0 and self:GetMoney(true) < v[2] then
				self:SendTipsMsg(1,"绑定金币不足")
				return
			elseif v[1] == 2 and v[2] > 0 and self:GetRmb(true) < v[2] then
				self:SendTipsMsg(1,"绑定元宝不足")
				return
			elseif v[1] == 3 and v[2] > 0 and self.m_db.泡点数 < v[2] then
				self:SendTipsMsg(1,"泡点数不足")
				return
			elseif v[1] > 10000 and v[2] > 0 and 背包DB.CheckCount(self, v[1]) < v[2] then
				self:SendTipsMsg(1,物品逻辑.GetItemName(v[1]).."不足")
				return
			end
		end
		self:CheckCostTime(mapid)
	end
	self.m_db.mapid = mapid
	--[[while 1 do
		local x = mapx + math.random(-100, 100)
		local y = mapy + math.random(-100, 100) * (self.Is2DScene and 1/self.MoveGridRate or 1)
		if self.MoveGrid then
			x = math.floor(x / self.MoveGrid[1]) * self.MoveGrid[1] + self.MoveGrid[1]/2
			y = math.floor(y / self.MoveGrid[2]) * self.MoveGrid[2] + self.MoveGrid[2]/2
		end
		if _IsPosCanRun(nSceneID, x, y) then
			self.m_db.x = x
			self.m_db.y = y
			self:JumpScene(nSceneID, x, y)
			break
		end
	end]]
	local posindex = math.random(2,9)
	local posindexstart = posindex
	local posloop = false
	local x, y
	while 1 do
		x = mapx+技能逻辑.itemdroppos[posindex][1]*(self.MoveGrid and self.MoveGrid[1] or 50)
		y = mapy+技能逻辑.itemdroppos[posindex][2]*(self.MoveGrid and self.MoveGrid[1] or 50)*(self.Is2DScene and 1/self.MoveGridRate or 1)
		if self.MoveGrid then
			x = math.floor(x / self.MoveGrid[1]) * self.MoveGrid[1] + self.MoveGrid[1]/2
			y = math.floor(y / self.MoveGrid[2]) * self.MoveGrid[2] + self.MoveGrid[2]/2
		end
		posindex = posindex + 1
		if posindex > 9 then
			posindex = 2
		end
		if posindex == posindexstart then
			posloop = true
		end
		if posloop or _IsPosCanRun(self.m_nSceneID, x, y) then
			self.m_db.x = x
			self.m_db.y = y
			self:JumpScene(nSceneID, x, y)
			break
		end
	end
	return true
end

function 玩家对象类:RandomTransport(mapid)
	if self.m_nSceneID == -1 then
		return
	end
	local escortId = Npc对话逻辑.CheckEscortTask(self)
	if escortId and self.m_db.task[escortId].state ~= 0 then
		self:SendTipsMsg(1, "正在押镖中,无法传送")
		return
	end
	local spiritId = Npc对话逻辑.CheckSpiritTask(self)
	if spiritId and self.m_db.task[spiritId].state ~= 0 then
		self:SendTipsMsg(1, "正在护送中,无法传送")
		return
	end
	local nSceneID = self.m_nSceneID
	if mapid then
		nSceneID = 场景管理.GetSceneId(mapid, true)
		if nSceneID == -1 then
			return
		end
	end
	if nSceneID ~= self.m_nSceneID then
		local conf = 地图表[mapid]
		if not conf then
			return
		end
		if #conf.costtp > 0 and self.m_db.tp < conf.costtp[1] then
			self:SendTipsMsg(1,"体力不足")
			return
		end
		for i,v in ipairs(conf.costex) do
			if v[1] == 1 and v[2] > 0 and self:GetMoney(true) < v[2] then
				self:SendTipsMsg(1,"绑定金币不足")
				return
			elseif v[1] == 2 and v[2] > 0 and self:GetRmb(true) < v[2] then
				self:SendTipsMsg(1,"绑定元宝不足")
				return
			elseif v[1] == 3 and v[2] > 0 and self.m_db.泡点数 < v[2] then
				self:SendTipsMsg(1,"泡点数不足")
				return
			elseif v[1] > 10000 and v[2] > 0 and 背包DB.CheckCount(self, v[1]) < v[2] then
				self:SendTipsMsg(1,物品逻辑.GetItemName(v[1]).."不足")
				return
			end
		end
		实用工具.DeleteTable(self.costtime)
		if #conf.costtp > 0 then
			self:RecoverTP(-conf.costtp[1])
			self.costtime[0] = 玩家事件处理.g_nSecTimerCounter + conf.costtp[2]*60
		end
		for i,v in ipairs(conf.costex) do
			if v[1] == 1 and v[2] ~= 0 then
				if v[2] > 0 then
					self:DecMoney(v[2], true)
				else
					self:AddMoney(v[2], true)
				end
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif v[1] == 2 and v[2] ~= 0 then
				if v[2] > 0 then
					self:DecRmb(v[2], true)
				else
					self:AddRmb(v[2], true)
				end
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif v[1] == 3 and v[2] ~= 0 then
				self.m_db.泡点数 = math.max(0, self.m_db.泡点数 - v[2])
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif (v[1] == 4 or v[1] == 5) and v[2] ~= 0 then
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			elseif v[1] > 10000 and v[2] ~= 0 then
				if v[2] > 0 then
					背包DB.RemoveCount(self, v[1], v[2])
				else
					local inds = self:PutItemGrids(v[1], v[2], 1, true)
					if inds and #inds > 0 then
						背包逻辑.SendBagQuery(self, inds)
						self:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(v[1])]..物品逻辑.GetItemName(v[1])..(v[2] > 1 and "x"..v[2] or ""))
					end
				end
				self.costtime[i] = 玩家事件处理.g_nSecTimerCounter + v[3]
			end
		end
	end
	local mapheight, mapwidth = _GetHeightAndWidth(nSceneID)
	while 1 do
		local x = math.random(0, mapwidth)
		local y = math.random(0, mapheight)
		if self.MoveGrid then
			x = math.floor(x / self.MoveGrid[1]) * self.MoveGrid[1] + self.MoveGrid[1]/2
			y = math.floor(y / self.MoveGrid[2]) * self.MoveGrid[2] + self.MoveGrid[2]/2
		end
		if _IsPosCanRun(nSceneID, x, y) then
			self.m_db.x = x
			self.m_db.y = y
			self:JumpScene(nSceneID, x, y)
			break
		end
	end
	return true
end

function 玩家对象类:GetMoney(bind)
	if 公共定义.使用绑定货币 == 1 and bind then
		return self.m_db.bindmoney
	else
		return self.m_db.money
	end
end

function 玩家对象类:AddMoney(cnt, bind)
	if cnt <= 0 then
		return
	end
	if 公共定义.使用绑定货币 == 1 and bind then
		self.m_db.bindmoney = self.m_db.bindmoney + cnt
	else
		self.m_db.money = self.m_db.money + cnt
	end
	return true
end

function 玩家对象类:DecMoney(cnt, bind)
	if cnt <= 0 then
		return
	end
	if 公共定义.使用绑定货币 == 1 and bind then
		self.m_db.bindmoney = math.max(0,self.m_db.bindmoney - cnt)
	else
		self.m_db.money = math.max(0,self.m_db.money - cnt)
	end
	return true
end

function 玩家对象类:GetRmb(bind)
	if 公共定义.使用绑定货币 == 1 and bind then
		return self.m_db.bindrmb
	else
		return self.m_db.rmb
	end
end

function 玩家对象类:AddRmb(cnt, bind)
	if cnt <= 0 then
		return
	end
	if 公共定义.使用绑定货币 == 1 and bind then
		self.m_db.bindrmb = self.m_db.bindrmb + cnt
	else
		self.m_db.rmb = self.m_db.rmb + cnt
		self.m_db.historyRMB = self.m_db.historyRMB + cnt
		--self:Save()
	end
	return true
end

function 玩家对象类:DecRmb(cnt, bind)
	if cnt <= 0 then
		return
	end
	if 公共定义.使用绑定货币 == 1 and bind then
		self.m_db.bindrmb = math.max(0,self.m_db.bindrmb - cnt)
	else
		self.m_db.rmb = math.max(0,self.m_db.rmb - cnt)
		--self:Save()
	end
	return true
end

function 玩家对象类:PutEquip(pos, id, grade, strengthen, wash, attach, gem, ringsoul, ishero, isbind)
	--if self.hp <= 0 then
	--	return
	--end
	local posnew = 背包DB.PutEquip(self, pos, id, grade, strengthen, wash, attach, gem, ringsoul, ishero, isbind)
	if posnew and id ~= 0 then
		local call = 事件触发._M["call_穿上装备_"..pos]
		if call then
			self:显示对话(-2,call(self))
		end
	end
	if posnew and posnew > 0 then
		local call = 事件触发._M["call_脱下装备_"..pos]
		if call then
			self:显示对话(-2,call(self))
		end
	end
	return posnew
end

function 玩家对象类:最近城市()
	local mapid = 场景管理.GetMapId(self.m_nSceneID)
	local maptype = 0
	if not mapid then
	elseif mapid > 1000 then
		maptype = math.floor(mapid / 1000)
	else
		maptype = math.floor(mapid / 100)
	end
	local 地图id
	if maptype == 1 or maptype == 2 then
		地图id = 101
	elseif maptype == 4 then
		地图id = 401
	elseif maptype == 3 then
		地图id = 301
	elseif maptype == 7 or maptype == 8 then
		地图id = 701
	elseif maptype == 5 then
		地图id = 501
	elseif maptype == 6 then
		地图id = 601
	else
		地图id = 401
	end
	return 地图id
end

function 玩家对象类:回城地图()
	return 公共定义.复活地图
end

function 玩家对象类:回城(随机)
	if self.m_nSceneID == -1 then
		return
	end
	local escortId = Npc对话逻辑.CheckEscortTask(self)
	if escortId and self.m_db.task[escortId].state ~= 0 then
		self:SendTipsMsg(1, "正在押镖中,无法传送")
		return
	end
	local spiritId = Npc对话逻辑.CheckSpiritTask(self)
	if spiritId and self.m_db.task[spiritId].state ~= 0 then
		self:SendTipsMsg(1, "正在护送中,无法传送")
		return
	end
	实用工具.DeleteTable(self.costtime)
	if self.m_db.backMapid ~= 0 then
		if 随机 then
			self:RandomTransport(self.m_db.backMapid)
		else
			self:Transport(self.m_db.backMapid, self.m_db.backX, self.m_db.backY)
		end
	else
		local 地图id = self:回城地图()
		local 地图配置 = 地图表[地图id]
		if 地图配置 then
			if 随机 then
				self:RandomTransport(地图id)
			elseif #地图配置.relivepos == 0 then
				local x, y = 场景管理.GetPosCanRun(场景管理.GetSceneId(地图id))
				self:Transport(地图id, x, y)
			else
				self:Transport(地图id,
					地图配置.relivepos[1] + math.random(-地图配置.relivepos[3],地图配置.relivepos[3]),
					地图配置.relivepos[2] + math.random(-地图配置.relivepos[3],地图配置.relivepos[3]))
			end
		end
	end
	return true
end

function 玩家对象类:增加战魂值(val)
	self.m_db.战魂值 = self.m_db.战魂值 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前战魂值为: #cffff00,"..self.m_db.战魂值)
	return true
end

function 玩家对象类:增加功勋值(val)
	self.m_db.功勋值 = self.m_db.功勋值 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前功勋值为: #cffff00,"..self.m_db.功勋值)
	return true
end

function 玩家对象类:增加成就积分(val)
	self.m_db.成就积分 = self.m_db.成就积分 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前成就积分为: #cffff00,"..self.m_db.成就积分)
	return true
end

function 玩家对象类:增加转生修为(val)
	self.m_db.转生修为 = self.m_db.转生修为 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前转生修为为: #cffff00,"..self.m_db.转生修为)
	return true
end

function 玩家对象类:增加魂力值(val)
	self.m_db.魂力值 = self.m_db.魂力值 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前魂力值为: #cffff00,"..self.m_db.魂力值)
	return true
end

function 玩家对象类:增加金刚石(val)
	self.m_db.金刚石 = self.m_db.金刚石 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前金刚石为: #cffff00,"..self.m_db.金刚石)
	return true
end

function 玩家对象类:增加神石结晶(val)
	self.m_db.神石结晶 = self.m_db.神石结晶 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前神石结晶为: #cffff00,"..self.m_db.神石结晶)
	return true
end

function 玩家对象类:增加魂珠碎片(val)
	self.m_db.魂珠碎片 = self.m_db.魂珠碎片 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前魂珠碎片为: #cffff00,"..self.m_db.魂珠碎片)
	return true
end

function 玩家对象类:增加灵韵值(val)
	self.m_db.灵韵值 = self.m_db.灵韵值 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前灵韵值为: #cffff00,"..self.m_db.灵韵值)
	return true
end

function 玩家对象类:增加灵兽精魂(val)
	self.m_db.灵兽精魂 = self.m_db.灵兽精魂 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前神石结晶为: #cffff00,"..self.m_db.灵兽精魂)
	return true
end

function 玩家对象类:增加注灵碎片(val)
	self.m_db.注灵碎片 = self.m_db.注灵碎片 + val
	self:SendTipsMsg(1, "#s16,#cff00,你的当前注灵碎片为: #cffff00,"..self.m_db.注灵碎片)
	return true
end

function 玩家对象类:武器祝福()
	local human = self
	if self.是否英雄 then
		human = 对象类:GetObj(self.ownerid)
	end
	if self.m_db.bagdb.equips[1] == nil then
		human:SendTipsMsg(1, "你没有装备武器")
		return
	end
	local 幸运i = nil
	self.m_db.bagdb.equips[1].wash = self.m_db.bagdb.equips[1].wash or {}
	for i,v in ipairs(self.m_db.bagdb.equips[1].wash) do
		if v[1] == 公共定义.属性_幸运 then
			幸运i = i
			break
		end
	end
	local 幸运 = 幸运i and self.m_db.bagdb.equips[1].wash[幸运i][2] or 0
	if 幸运 >= 7 then
		human:SendTipsMsg(1, "你的武器幸运达到上限")
		return
	end
	local 新幸运 = 幸运
	if 幸运 <= 0 then
		新幸运 = 幸运 + 1
	elseif 幸运 == 1 then
		if math.random(1,100) <= 50 then
			新幸运 = 幸运 + 1
		end
	elseif 幸运 == 2 then
		if math.random(1,100) <= 20 then
			新幸运 = 幸运 + 1
		elseif math.random(1,100) <= 20 then
			新幸运 = 幸运 - 1
		end
	elseif 幸运 == 3 then
		if math.random(1,100) <= 10 then
			新幸运 = 幸运 + 1
		elseif math.random(1,100) <= 40 then
			新幸运 = 幸运 - 1
		end
	elseif 幸运 == 4 then
		if math.random(1,100) <= 5 then
			新幸运 = 幸运 + 1
		elseif math.random(1,100) <= 60 then
			新幸运 = 幸运 - 1
		end
	elseif 幸运 == 5 then
		if math.random(1,100) <= 2 then
			新幸运 = 幸运 + 1
		elseif math.random(1,100) <= 80 then
			新幸运 = 幸运 - 1
		end
	elseif 幸运 == 6 then
		if math.random(1,100) <= 1 then
			新幸运 = 幸运 + 1
		elseif math.random(1,100) <= 100 then
			新幸运 = 幸运 - 1
		end
	end
	if 新幸运 > 幸运 then
		human:SendTipsMsg(1, "#cff00,你的武器获得了幸运")
	elseif 新幸运 < 幸运 and 新幸运 >= 0 then
		human:SendTipsMsg(1, "你的武器幸运降低了")
	elseif 新幸运 < 幸运 and 新幸运 < 0 then
		human:SendTipsMsg(1, "你的武器被诅咒了")
	else
		human:SendTipsMsg(1, "#cff00,使用无效")
	end
	if 新幸运 ~= 幸运 then
		if 幸运i then
			self.m_db.bagdb.equips[1].wash[幸运i][2] = 新幸运
		else
			self.m_db.bagdb.equips[1].wash[#self.m_db.bagdb.equips[1].wash+1] = {公共定义.属性_幸运,新幸运}
		end
		self:CalcDynamicAttr()
		if self.是否英雄 then
			human:SendEquipView(human.英雄, true)
		else
			背包逻辑.SendEquipQuery(self, {1})
		end
	end
	return true
end

function 玩家对象类:项链祝福()
	local human = self
	if self.是否英雄 then
		human = 对象类:GetObj(self.ownerid)
	end
	if self.m_db.bagdb.equips[4] == nil then
		human:SendTipsMsg(1, "你没有装备项链")
		return
	end
	local 幸运i = nil
	self.m_db.bagdb.equips[4].wash = self.m_db.bagdb.equips[4].wash or {}
	for i,v in ipairs(self.m_db.bagdb.equips[4].wash) do
		if v[1] == 公共定义.属性_幸运 then
			幸运i = i
			break
		end
	end
	local 幸运 = 幸运i and self.m_db.bagdb.equips[4].wash[幸运i][2] or 0
	if 幸运 >= 2 then
		human:SendTipsMsg(1, "你的项链幸运达到上限")
		return
	end
	local 新幸运 = 幸运 + 1
	human:SendTipsMsg(1, "#cff00,你的项链获得了幸运")
	if 新幸运 ~= 幸运 then
		if 幸运i then
			self.m_db.bagdb.equips[4].wash[幸运i][2] = 新幸运
		else
			self.m_db.bagdb.equips[4].wash[#self.m_db.bagdb.equips[4].wash+1] = {公共定义.属性_幸运,新幸运}
		end
		self:CalcDynamicAttr()
		if self.是否英雄 then
			human:SendEquipView(human.英雄, true)
		else
			背包逻辑.SendEquipQuery(self, {4})
		end
	end
	return true
end

function 玩家对象类:开宝箱(钥匙id,宝藏)
	local index = 背包逻辑.GetEmptyIndex(self)
	if not index then
		self:SendTipsMsg(1,"背包不足")
		return
	end
	if 钥匙id ~= 0 then
		if 背包DB.CheckCount(self, 钥匙id) < 1 then
			self:SendTipsMsg(1,"#cffff00,"..物品逻辑.GetItemName(钥匙id).."#C数量不足")
			return
		end
		背包DB.RemoveCount(self, 钥匙id, 1)
	end
	local weight=0
	for i,v in ipairs(宝藏) do
		weight = weight + v[3]
	end
	local wei = math.random(1,weight)
	weight=0
	local 物品=nil
	for i,v in ipairs(宝藏) do
		weight = weight + v[3]
		if wei <= weight then
			物品 = v
			break
		end
	end
	if not 物品 then
		return
	end
	local wash = nil
	if 物品逻辑.GetItemType1(物品[1]) == 3 and 物品逻辑.GetItemType2(物品[1]) == 14 then
		wash = 拾取物品逻辑.宠物蛋极品属性(物品[5] or 0,物品[4] or 1)
	elseif 物品逻辑.GetItemType1(物品[1]) == 3 and 物品[4] and 物品[4] > 1 then
		wash = 拾取物品逻辑.自动极品属性(物品[4]-1,物品[4]-1)
	end
	local indexs = self:PutItemGrids(物品[1], 物品[2],
		(物品[1] == 公共定义.金币物品ID or 物品[1] == 公共定义.元宝物品ID) and 1 or 0, true, 物品[4], 物品[5], wash) or {}
	if 物品[1] ~= 公共定义.金币物品ID and 物品[1] ~= 公共定义.元宝物品ID and #indexs == 0 then
		self:SendTipsMsg(1,"背包不足")
		return
	end
	if #indexs > 0 then
		背包逻辑.SendBagQuery(self, indexs)
	end
	if 物品[1] == 公共定义.金币物品ID then
		self:SendTipsMsg(2, "获得绑定金币#cffff00,"..物品[2])
	elseif 物品[1] == 公共定义.元宝物品ID then
		self:SendTipsMsg(2, "获得绑定元宝#cffff00,"..物品[2])
	else
		self:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品[4] or 1]..物品逻辑.GetItemName(物品[1],物品逻辑.GetItemBodyID(物品[1]))..(物品[2] > 1 and "x"..物品[2] or ""))
	end
	聊天逻辑.SendSystemChat("#cffff00,"..self:GetName().."#C开启#cffff00,"..
		物品逻辑.GetItemName(钥匙id+5).."#C获得了"..
		广播.colorRgb[物品[4] or 1]..物品逻辑.GetItemName(物品[1],物品逻辑.GetItemBodyID(物品[1]))..(物品[2] > 1 and "x"..物品[2] or ""))
	return true
end

function 玩家对象类:转生(转生等级)
	local 等级限制 = {46,48,50,52,54,56,58,59,60}
	if not 等级限制[转生等级] then
		return
	end
	--if not self.英雄 then
	--	self:SendTipsMsg(1,"请先召唤英雄")
	--	return
	--end
	if self.m_db.转生等级 + 1 ~= 转生等级 then
		self:SendTipsMsg(1,"你需要达到前一转生等级")
		return
	end
	--if self.m_db.英雄转生等级 + 1 ~= 转生等级 then
	--	self:SendTipsMsg(1,"英雄需要达到前一转生等级")
	--	return
	--end
	if self.m_db.level < 等级限制[转生等级] then
		self:SendTipsMsg(1,"等级不足")
		return
	end
	self.m_db.转生等级 = self.m_db.转生等级 + 1
	self:CheckAttrLearn()
	self:SendPropAddPoint()
	self:SendTipsMsg(1,"#cffff00,转生成功")
	return true
end

function 玩家对象类:英雄转生(转生等级)
	local 等级限制 = {46,48,50,52,54,56,58,59,60}
	if not 等级限制[转生等级] then
		return
	end
	if not self.英雄 then
		self:SendTipsMsg(1,"请先召唤英雄")
		return
	end
	--if self.m_db.转生等级 ~= 转生等级 then
	--	self:SendTipsMsg(1,"你需要达到此转生等级")
	--	return
	--end
	if self.m_db.英雄转生等级 + 1 ~= 转生等级 then
		self:SendTipsMsg(1,"英雄需要达到前一转生等级")
		return
	end
	if self.英雄.m_db.level < 等级限制[转生等级] then
		self:SendTipsMsg(1,"英雄等级不足")
		return
	end
	self.m_db.英雄转生等级 = self.m_db.英雄转生等级 + 1
	self.英雄.m_db.转生等级 = self.m_db.英雄转生等级
	self:SendEquipView(self.英雄, true)
	self:CheckAttrLearn(true)
	self:SendPropAddPoint()
	self:SendTipsMsg(1,"#cffff00,英雄转生成功")
	return true
end

function 玩家对象类:GetBodyID()
	if Config.IS3G then
		return self.m_db.job+1000
	end
	if self.m_db.显示时装 == 1 and self.m_db.bagdb.equips[23] then
		local fashion = 物品表[self.m_db.bagdb.equips[23].id]
		if fashion then
			return fashion.bodyid
		end
	end
	if self.m_db.bagdb.equips[2] == nil then
		return self.m_db.sex == 1 and 公共定义.裸模ID1 or 公共定义.裸模ID2
	end
	local conf = 物品表[self.m_db.bagdb.equips[2].id]
	if not conf then
		return self.m_db.sex == 1 and 公共定义.裸模ID1 or 公共定义.裸模ID2
	end
	return conf.bodyid
end

function 玩家对象类:GetWeaponID()
	if Config.IS3G then
		return 0
	end
	if self.m_db.显示炫武 == 1 and self.m_db.bagdb.equips[27] then
		local fashion = 物品表[self.m_db.bagdb.equips[27].id]
		if fashion then
			return fashion.bodyid
		end
	end
	if self.m_db.bagdb.equips[1] == nil then
		return 0
	end
	local conf = 物品表[self.m_db.bagdb.equips[1].id]
	if not conf then
		return 0
	end
	if conf.bodyid == 0 or self.m_db.sex == 1 then
		return conf.bodyid
	else
		return conf.bodyid + (Config.ISWZ and 2000 or 1)
	end
end

function 玩家对象类:GetBodyEffID()
	if Config.IS3G then
		return 0
	end
	if self.m_db.显示时装 == 1 and self.m_db.bagdb.equips[23] then
		local fashion = 物品表[self.m_db.bagdb.equips[23].id]
		if fashion then
			return fashion.effid
		end
	end
	if self.m_db.bagdb.equips[2] == nil then
		return 0
	end
	local conf = 物品表[self.m_db.bagdb.equips[2].id]
	if not conf then
		return 0
	end
	return conf.effid
end

function 玩家对象类:GetWeaponEffID()
	if Config.IS3G then
		return 0
	end
	if self.m_db.显示时装 == 1 and self.m_db.bagdb.equips[27] then
		local fashion = 物品表[self.m_db.bagdb.equips[27].id]
		if fashion then
			return fashion.effid
		end
	end
	if self.m_db.bagdb.equips[1] == nil then
		return 0
	end
	local conf = 物品表[self.m_db.bagdb.equips[1].id]
	if not conf then
		return 0
	end
	if conf.effid == 0 or self.m_db.sex == 1 then
		return conf.effid
	else
		return conf.effid + (Config.ISWZ and 2000 or 1)
	end
end

function 玩家对象类:GetHorseID()
	if self.mountid == 0 then
		return 0
	end
	return 0
end

function 玩家对象类:GetHorseEffID()
	if self.mountid == 0 then
		return 0
	end
	return 0
end

function 玩家对象类:GetWingID()
	if self.wingid == 0 then
		return 0
	end
	return 0
end

function 玩家对象类:GetWingEffID()
	if self.wingid == 0 then
		return 0
	end
	local conf = 翅膀表[self.wingid]
	if not conf then
		return 0
	end
	return conf.effid
end

function 玩家对象类:获取斗笠外观()
	if self.m_db.bagdb.equips[11] == nil then
		return 0
	end
	local conf = 物品表[self.m_db.bagdb.equips[11].id]
	if not conf then
		return 0
	end
	if conf.bodyid == 0 or self.m_db.sex == 1 then
		return conf.bodyid
	else
		return conf.bodyid + 1
	end
end

function 玩家对象类:PutItemGrids(id, count, bind, merge, grade, strengthen, wash, attach, gem, ringsoul)
	--if self.hp <= 0 then
	--	return
	--end
	if id == 公共定义.金币物品ID then
		self:AddMoney(count, bind == 1)
		return
	elseif id == 公共定义.元宝物品ID then
		self:AddRmb(count, bind == 1)
		return
	elseif id == 公共定义.经验物品ID then
		self:AddExp(count)
		return
	end
	return 背包DB.PutItemGrids(self, id, count, ((公共定义.物品获得绑定 == 1 and bind == 1) or 物品逻辑.IsAutoBind(id)) and 1 or 0, merge, grade, strengthen, wash, attach, gem, ringsoul)
end

function 玩家对象类:RemoveDeadBuff()
	for k,v in pairs(self.buffhit) do
		local buffconf = Buff表[k]
		if buffconf.last ~= 1 then
			_DelTimer(v, self.id)
			self.buffhit[k] = nil
		end
	end
	for k,v in pairs(self.buffend) do
		local buffconf = Buff表[k]
		if buffconf.last ~= 1 then
			_DelTimer(v, self.id)
			self.buffend[k] = nil
			技能逻辑.DoHitBuffEnd(self, buffconf)
		end
	end
	if self.updateInfoTime then
		self:UpdateObjInfo()
		self.updateInfoTime = nil
	end
end

function 玩家对象类:RemoveBuff()
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

function 玩家对象类:IsDead()
	return self.hp <= 0
end

function 玩家对象类:GetType()
	return 0
end

function 玩家对象类:GetLevel()
	return self.m_db.level
end

function 玩家对象类:SendDetailAttr()
	local conf = 玩家属性表[self.m_db.level]
	if not conf then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_DETAIL_ATTR]
	oReturnMsg.expmax = conf.exp
	oReturnMsg.exp = self.m_db.exp
	oReturnMsg.hpmax = self.hpMax
	oReturnMsg.hp = self:GetHP()
	oReturnMsg.mpmax = self.mpMax
	oReturnMsg.mp = self.mp
	oReturnMsg.money = self.m_db.money
	oReturnMsg.bindmoney = self.m_db.bindmoney
	oReturnMsg.rmb = self.m_db.rmb
	oReturnMsg.bindrmb = self.m_db.bindrmb
	oReturnMsg.speed = self.属性值[公共定义.属性_移动速度]--self:获取移动速度()
	oReturnMsg.power = self:CalcPower()
	oReturnMsg.totalpower = oReturnMsg.power
	oReturnMsg.suitcntsLen = 0
	for k,v in pairs(self.suitcnts) do
		oReturnMsg.suitcnts[oReturnMsg.suitcntsLen+1] = k
		oReturnMsg.suitcnts[oReturnMsg.suitcntsLen+2] = v
		oReturnMsg.suitcntsLen = oReturnMsg.suitcntsLen + 2
	end
	if self.英雄 then
		for k,v in pairs(self.英雄.suitcnts) do
			oReturnMsg.suitcnts[oReturnMsg.suitcntsLen+1] = -k
			oReturnMsg.suitcnts[oReturnMsg.suitcntsLen+2] = v
			oReturnMsg.suitcntsLen = oReturnMsg.suitcntsLen + 2
		end
	end
	oReturnMsg.PK值 = self.m_db.PK值
	oReturnMsg.总充值 = self.m_db.总充值
	oReturnMsg.每日充值 = self.m_db.每日充值
	oReturnMsg.特戒抽取次数 = self.m_db.特戒抽取次数
	oReturnMsg.刷新BOSS次数 = self.m_db.刷新BOSS次数
	oReturnMsg.开区活动倒计时 = 0
	oReturnMsg.vip等级 = self.m_db.vip等级
	oReturnMsg.转生等级 = self.m_db.转生等级
	oReturnMsg.防御 = self.属性值[公共定义.属性_防御]
	oReturnMsg.防御上限 = self.属性值[公共定义.属性_防御上限]
	oReturnMsg.魔御 = self.属性值[公共定义.属性_魔御]
	oReturnMsg.魔御上限 = self.属性值[公共定义.属性_魔御上限]
	oReturnMsg.攻击 = self.属性值[公共定义.属性_攻击]
	oReturnMsg.攻击上限 = self.属性值[公共定义.属性_攻击上限]
	oReturnMsg.魔法 = self.属性值[公共定义.属性_魔法]
	oReturnMsg.魔法上限 = self.属性值[公共定义.属性_魔法上限]
	oReturnMsg.道术 = self.属性值[公共定义.属性_道术]
	oReturnMsg.道术上限 = self.属性值[公共定义.属性_道术上限]
	oReturnMsg.幸运 = self.属性值[公共定义.属性_幸运]
	oReturnMsg.准确 = self.属性值[公共定义.属性_准确]
	oReturnMsg.敏捷 = self.属性值[公共定义.属性_敏捷]
	oReturnMsg.魔法命中 = self.属性值[公共定义.属性_魔法命中]
	oReturnMsg.魔法躲避 = self.属性值[公共定义.属性_魔法躲避]
	oReturnMsg.生命恢复 = self.属性值[公共定义.属性_生命恢复]
	oReturnMsg.魔法恢复 = self.属性值[公共定义.属性_魔法恢复]
	oReturnMsg.中毒恢复 = self.属性值[公共定义.属性_中毒恢复]
	oReturnMsg.攻击速度 = self.属性值[公共定义.属性_攻击速度]
	oReturnMsg.移动速度 = self.属性值[公共定义.属性_移动速度]
	oReturnMsg.力量 = self.属性值[公共定义.属性_力量]
	oReturnMsg.智力 = self.属性值[公共定义.属性_智力]
	oReturnMsg.精神 = self.属性值[公共定义.属性_精神]
	oReturnMsg.体质 = self.属性值[公共定义.属性_体质]
	oReturnMsg.重击 = self.属性值[公共定义.属性_重击]
	消息类.SendMsg(oReturnMsg, self.id)
end

function 玩家对象类:SendEquipView(human, 是否英雄)
	local conf = 玩家属性表[human.m_db.level]
	if not conf then
		return
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_EQUIP_VIEW]
	oReturnMsg.rolename = human:GetName()--human.platform..
	oReturnMsg.objid = human.id
	oReturnMsg.level = human.m_db.level -- 角色等级
	oReturnMsg.job = human.m_db.job
	oReturnMsg.sex = human.m_db.sex
	oReturnMsg.expmax = conf.exp
	oReturnMsg.exp = human.m_db.exp
	local confnew = human.avatarid ~= 0 and 怪物表[human.avatarid] or human.monsterid ~= 0 and 怪物表[human.monsterid] or nil
	oReturnMsg.bodyid = confnew and confnew.bodyid or human:GetBodyID()
	oReturnMsg.weaponid = confnew and 0 or human:GetWeaponID()
	oReturnMsg.wingid = confnew and 0 or human:GetWingID()
	oReturnMsg.horseid = confnew and 0 or human:GetHorseID()
	oReturnMsg.bodyeff = confnew and confnew.effid or human:GetBodyEffID()
	oReturnMsg.weaponeff = confnew and 0 or human:GetWeaponEffID()
	oReturnMsg.wingeff = confnew and 0 or human:GetWingEffID()
	oReturnMsg.horseeff = confnew and 0 or human:GetHorseEffID()
	oReturnMsg.hpmax = human.hpMax
	oReturnMsg.mpmax = human.mpMax
	oReturnMsg.speed = human.属性值[公共定义.属性_移动速度]--human:获取移动速度()
	oReturnMsg.power = human:CalcPower()
	oReturnMsg.转生等级 = human.m_db.转生等级
	oReturnMsg.防御 = human.属性值[公共定义.属性_防御]
	oReturnMsg.防御上限 = human.属性值[公共定义.属性_防御上限]
	oReturnMsg.魔御 = human.属性值[公共定义.属性_魔御]
	oReturnMsg.魔御上限 = human.属性值[公共定义.属性_魔御上限]
	oReturnMsg.攻击 = human.属性值[公共定义.属性_攻击]
	oReturnMsg.攻击上限 = human.属性值[公共定义.属性_攻击上限]
	oReturnMsg.魔法 = human.属性值[公共定义.属性_魔法]
	oReturnMsg.魔法上限 = human.属性值[公共定义.属性_魔法上限]
	oReturnMsg.道术 = human.属性值[公共定义.属性_道术]
	oReturnMsg.道术上限 = human.属性值[公共定义.属性_道术上限]
	oReturnMsg.幸运 = human.属性值[公共定义.属性_幸运]
	oReturnMsg.准确 = human.属性值[公共定义.属性_准确]
	oReturnMsg.敏捷 = human.属性值[公共定义.属性_敏捷]
	oReturnMsg.魔法命中 = human.属性值[公共定义.属性_魔法命中]
	oReturnMsg.魔法躲避 = human.属性值[公共定义.属性_魔法躲避]
	oReturnMsg.生命恢复 = human.属性值[公共定义.属性_生命恢复]
	oReturnMsg.魔法恢复 = human.属性值[公共定义.属性_魔法恢复]
	oReturnMsg.中毒恢复 = human.属性值[公共定义.属性_中毒恢复]
	oReturnMsg.攻击速度 = human.属性值[公共定义.属性_攻击速度]
	oReturnMsg.移动速度 = human.属性值[公共定义.属性_移动速度]
	oReturnMsg.力量 = human.属性值[公共定义.属性_力量]
	oReturnMsg.智力 = human.属性值[公共定义.属性_智力]
	oReturnMsg.精神 = human.属性值[公共定义.属性_精神]
	oReturnMsg.体质 = human.属性值[公共定义.属性_体质]
	oReturnMsg.重击 = human.属性值[公共定义.属性_重击]
	
	oReturnMsg.itemdataLen = 0
	for k,v in pairs(human.m_db.bagdb.equips) do
		oReturnMsg.itemdataLen = oReturnMsg.itemdataLen + 1
		背包逻辑.PutItemData(oReturnMsg.itemdata[oReturnMsg.itemdataLen], k, v, 0)
	end
	oReturnMsg.是否英雄 = 是否英雄 and 1 or 0
	oReturnMsg.斗笠外观 = human:获取斗笠外观()
	oReturnMsg.显示时装 = human.m_db.显示时装
	oReturnMsg.显示炫武 = human.m_db.显示炫武
	消息类.SendMsg(oReturnMsg, self.id)
end

function 玩家对象类:UpdateObjInfo()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or self.monsterid ~= 0 and 怪物表[self.monsterid] or nil
	local oMsgCacheData = 派发器.ProtoContainer[协议ID.GG_ADD_PLAYER_CACHE_DATA]
	oMsgCacheData.rolename = self.nametitle or self:GetName()--self.platform..
	oMsgCacheData.guildname = (self.m_db.guildname or "")..城堡管理.GetCastleGuildName(self.m_db.guildname or "")
	oMsgCacheData.color = self.m_db.PK值 > 200 and 4 or self.m_db.PK值 > 100 and 3 or self.graynametime > 0 and 1 or self.m_db.PK值 > 0 and 2 or 0
	oMsgCacheData.titleLen = #self.titles
	for i,v in ipairs(self.titles) do
		oMsgCacheData.title[i] = v
	end
	oMsgCacheData.level = self.m_db.level -- 角色等级
	oMsgCacheData.job = self.m_db.job
	oMsgCacheData.sex = self.m_db.sex
	oMsgCacheData.status = self.m_status
	oMsgCacheData.buffinfoLen = 0
	for k,v in pairs(self.buffend) do
		local timer = _GetTimer(v, self.id)
		local buffconf = Buff表[k]
		if buffconf and buffconf.效果计时 == 1 and timer and timer.interval > 0 then
			oMsgCacheData.buffinfoLen = oMsgCacheData.buffinfoLen + 1
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].effid = buffconf.effid
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].icon = buffconf.icon
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].time = timer.interval
		elseif buffconf and timer and timer.nextCallTime > _CurrentTime() then
			oMsgCacheData.buffinfoLen = oMsgCacheData.buffinfoLen + 1
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].effid = buffconf.effid
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].icon = buffconf.icon
			oMsgCacheData.buffinfo[oMsgCacheData.buffinfoLen].time = timer.nextCallTime - _CurrentTime()
		end
	end
	oMsgCacheData.mergehpLen = #self.petmerge
	for i,v in ipairs(self.petmerge) do
		oMsgCacheData.mergehp[i].maxhp = v.hpmax
		oMsgCacheData.mergehp[i].hp = v.hp
		oMsgCacheData.mergehp[i].grade = v.grade
	end
	oMsgCacheData.bodyid = confnew and confnew.bodyid or self:GetBodyID()
	oMsgCacheData.weaponid = confnew and 0 or self:GetWeaponID()
	oMsgCacheData.wingid = confnew and 0 or self:GetWingID()
	oMsgCacheData.horseid = confnew and 0 or self:GetHorseID()
	oMsgCacheData.bodyeff = confnew and confnew.effid or self:GetBodyEffID()
	oMsgCacheData.weaponeff = confnew and 0 or self:GetWeaponEffID()
	oMsgCacheData.wingeff = confnew and 0 or self:GetWingEffID()
	oMsgCacheData.horseeff = confnew and 0 or self:GetHorseEffID()
	oMsgCacheData.ownerid = self.ownerid
	oMsgCacheData.teamid = self.teamid
	oMsgCacheData.斗笠外观 = self:获取斗笠外观()
	消息类.SendMsg(oMsgCacheData, self.id)
end

function 玩家对象类:ChangeName()
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_NAME]
	oHumanInfoMsg.rolename = self.nametitle or self:GetName()
	oHumanInfoMsg.guildname = (self.m_db.guildname or "")..城堡管理.GetCastleGuildName(self.m_db.guildname or "")
	oHumanInfoMsg.color = self.m_db.PK值 > 200 and 4 or self.m_db.PK值 > 100 and 3 or self.graynametime > 0 and 1 or self.m_db.PK值 > 0 and 2 or 0
	oHumanInfoMsg.titleLen = #self.titles
	for i,v in ipairs(self.titles) do
		oHumanInfoMsg.title[i] = v
	end
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.ownerid = self.ownerid
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 玩家对象类:ChangeSpeed()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or self.monsterid ~= 0 and 怪物表[self.monsterid] or nil
	self:SetEngineMoveSpeed((confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度())
	self:UpdateObjInfo()
	
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_SPEED]
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.speed = (confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度()
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 玩家对象类:ChangeBody()
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or self.monsterid ~= 0 and 怪物表[self.monsterid] or nil
	self:SetEngineMoveSpeed((confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度())
	self:UpdateObjInfo()
	
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_FACADE]
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.bodyid = confnew and confnew.bodyid or self:GetBodyID()
	oHumanInfoMsg.weaponid = confnew and 0 or self:GetWeaponID()
	oHumanInfoMsg.wingid = confnew and 0 or self:GetWingID()
	oHumanInfoMsg.horseid = confnew and 0 or self:GetHorseID()
	oHumanInfoMsg.bodyeff = confnew and confnew.effid or self:GetBodyEffID()
	oHumanInfoMsg.weaponeff = confnew and 0 or self:GetWeaponEffID()
	oHumanInfoMsg.wingeff = confnew and 0 or self:GetWingEffID()
	oHumanInfoMsg.horseeff = confnew and 0 or self:GetHorseEffID()
	oHumanInfoMsg.speed = (confnew and self.avatarid ~= 0) and confnew.speed or self:获取移动速度()
	oHumanInfoMsg.斗笠外观 = self:获取斗笠外观()
	
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 玩家对象类:ChangeStatus(status, pkmode)
	if self.m_status == status and (not pkmode or pkmode == -1 or self.m_db.pkmode == pkmode) then
		return
	end
	if self.m_nSceneID == -1 then
		return
	end
	if status == 101 then --jump
		if self.unattackable or self.unmovable or (self.jumpendtime and self.jumpendtime > _CurrentTime()) then
			return
		end
		self.jumpendtime = _CurrentTime() + 500
	elseif status == 102 then --block
		if self.unattackable or self.unmovable or (self.blockendtime and self.blockendtime + 2000 > _CurrentTime()) then
			return
		end
		self.blockendtime = _CurrentTime() + 500
	else
		self.m_db.pkmode = (pkmode and pkmode ~= -1) and pkmode or self.m_db.pkmode
		self.m_status = status
		self:ChangeSpeed()
		--self:UpdateObjInfo()
	end
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_STATUS]
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.status = status
	oHumanInfoMsg.pkmode = self.m_db.pkmode
	
	消息类.ZoneBroadCast(oHumanInfoMsg, self.id)
end

function 玩家对象类:GetStatus()
  return self.m_status
end

function 玩家对象类:CheckHumanStatusChange(newStatus)
  return 公共定义.HUMAN_STATUD_CHANGE_OK
end

function 玩家对象类:DoStatusChange(status, value1, value2, value3)
end

function 玩家对象类:SendAttackGuildMsg(release)
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_ATTACK_GUILD]
	oHumanInfoMsg.challenge = ""
	oHumanInfoMsg.alliance = ""
	local castleid = 城堡管理.AttackGuild[self.m_db.guildname]
	if castleid and not release then
		for k,v in pairs(城堡管理.AttackGuild) do
			if v == castleid and (k == self.m_db.guildname or 行会管理.IsAllianceGuild(k, self.m_db.guildname)) then
				oHumanInfoMsg.alliance = oHumanInfoMsg.alliance == "" and k or (oHumanInfoMsg.alliance..","..k)
			elseif v == castleid then
				oHumanInfoMsg.challenge = oHumanInfoMsg.challenge == "" and k or (oHumanInfoMsg.challenge..","..k)
			end
		end
	end
	消息类.SendMsg(oHumanInfoMsg, self.id)
end

function 玩家对象类:SendHumanInfoMsg()
    -- 下发GCHumanInfo消息
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_HUMAN_INFO]
	oHumanInfoMsg.rolename = self.nametitle or self:GetName()--self.platform..
	oHumanInfoMsg.guildname = (self.m_db.guildname or "")..城堡管理.GetCastleGuildName(self.m_db.guildname or "")
	oHumanInfoMsg.challenge = ""
	oHumanInfoMsg.alliance = ""
	local castleid = 城堡管理.AttackGuild[self.m_db.guildname]
	if castleid then
		for k,v in pairs(城堡管理.AttackGuild) do
			if v == castleid and (k == self.m_db.guildname or 行会管理.IsAllianceGuild(k, self.m_db.guildname)) then
				oHumanInfoMsg.alliance = oHumanInfoMsg.alliance == "" and k or (oHumanInfoMsg.alliance..","..k)
			elseif v == castleid then
				oHumanInfoMsg.challenge = oHumanInfoMsg.challenge == "" and k or (oHumanInfoMsg.challenge..","..k)
			end
		end
	end
	oHumanInfoMsg.color = self.m_db.PK值 > 200 and 4 or self.m_db.PK值 > 100 and 3 or self.graynametime > 0 and 1 or self.m_db.PK值 > 0 and 2 or 0
	oHumanInfoMsg.titleLen = #self.titles
	for i,v in ipairs(self.titles) do
		oHumanInfoMsg.title[i] = v
	end
	oHumanInfoMsg.objid = self.id
	oHumanInfoMsg.level = self.m_db.level
	oHumanInfoMsg.job = self.m_db.job
	oHumanInfoMsg.sex = self.m_db.sex
	oHumanInfoMsg.status = self.m_status
	oHumanInfoMsg.pkmode = self.m_db.pkmode
	oHumanInfoMsg.mapid = self.m_db.mapid
	oHumanInfoMsg.scenex = self.m_db.x
	oHumanInfoMsg.sceney = self.m_db.y
	oHumanInfoMsg.speed = self:获取移动速度()
	oHumanInfoMsg.maxhp = self.hpMax
	oHumanInfoMsg.maxmp = self.mpMax
	oHumanInfoMsg.hp = self.hp
	oHumanInfoMsg.mp = self.mp
	oHumanInfoMsg.tp = self.m_db.tp
	oHumanInfoMsg.buffinfoLen = 0
	for k,v in pairs(self.buffend) do
		local timer = _GetTimer(v, self.id)
		local buffconf = Buff表[k]
		if buffconf and buffconf.效果计时 == 1 and timer and timer.interval > 0 then
			oHumanInfoMsg.buffinfoLen = oHumanInfoMsg.buffinfoLen + 1
			oHumanInfoMsg.buffinfo[oHumanInfoMsg.buffinfoLen].effid = buffconf.effid
			oHumanInfoMsg.buffinfo[oHumanInfoMsg.buffinfoLen].icon = buffconf.icon
			oHumanInfoMsg.buffinfo[oHumanInfoMsg.buffinfoLen].time = timer.interval
		elseif buffconf and timer and timer.nextCallTime > _CurrentTime() then
			oHumanInfoMsg.buffinfoLen = oHumanInfoMsg.buffinfoLen + 1
			oHumanInfoMsg.buffinfo[oHumanInfoMsg.buffinfoLen].effid = buffconf.effid
			oHumanInfoMsg.buffinfo[oHumanInfoMsg.buffinfoLen].icon = buffconf.icon
			oHumanInfoMsg.buffinfo[oHumanInfoMsg.buffinfoLen].time = timer.nextCallTime - _CurrentTime()
		end
	end
	oHumanInfoMsg.mergehpLen = #self.petmerge
	for i,v in ipairs(self.petmerge) do
		oHumanInfoMsg.mergehp[i].maxhp = v.hpmax
		oHumanInfoMsg.mergehp[i].hp = v.hp
		oHumanInfoMsg.mergehp[i].grade = v.grade
	end
	local confnew = self.avatarid ~= 0 and 怪物表[self.avatarid] or self.monsterid ~= 0 and 怪物表[self.monsterid] or nil
	oHumanInfoMsg.bodyid = confnew and confnew.bodyid or self:GetBodyID()
	oHumanInfoMsg.weaponid = confnew and 0 or self:GetWeaponID()
	oHumanInfoMsg.wingid = confnew and 0 or self:GetWingID()
	oHumanInfoMsg.horseid = confnew and 0 or self:GetHorseID()
	oHumanInfoMsg.bodyeff = confnew and confnew.effid or self:GetBodyEffID()
	oHumanInfoMsg.weaponeff = confnew and 0 or self:GetWeaponEffID()
	oHumanInfoMsg.wingeff = confnew and 0 or self:GetWingEffID()
	oHumanInfoMsg.horseeff = confnew and 0 or self:GetHorseEffID()
	oHumanInfoMsg.teamid = self.teamid
	oHumanInfoMsg.斗笠外观 = self:获取斗笠外观()
	oHumanInfoMsg.总充值 = self.m_db.总充值
	oHumanInfoMsg.每日充值 = self.m_db.每日充值
	oHumanInfoMsg.特戒抽取次数 = self.m_db.特戒抽取次数
	oHumanInfoMsg.刷新BOSS次数 = self.m_db.刷新BOSS次数
	oHumanInfoMsg.开区活动倒计时 = 0
	oHumanInfoMsg.vip等级 = self.m_db.vip等级
	oHumanInfoMsg.HP保护 = self.m_db.HP保护
	oHumanInfoMsg.MP保护 = self.m_db.MP保护
	oHumanInfoMsg.英雄HP保护 = self.m_db.英雄HP保护
	oHumanInfoMsg.英雄MP保护 = self.m_db.英雄MP保护
	oHumanInfoMsg.自动分解白 = self.m_db.自动分解白
	oHumanInfoMsg.自动分解绿 = self.m_db.自动分解绿
	oHumanInfoMsg.自动分解蓝 = self.m_db.自动分解蓝
	oHumanInfoMsg.自动分解紫 = self.m_db.自动分解紫
	oHumanInfoMsg.自动分解橙 = self.m_db.自动分解橙
	oHumanInfoMsg.自动分解等级 = self.m_db.自动分解等级
	oHumanInfoMsg.使用生命药 = self.m_db.使用生命药
	oHumanInfoMsg.使用魔法药 = self.m_db.使用魔法药
	oHumanInfoMsg.英雄使用生命药 = self.m_db.英雄使用生命药
	oHumanInfoMsg.英雄使用魔法药 = self.m_db.英雄使用魔法药
	oHumanInfoMsg.使用物品HP = self.m_db.使用物品HP
	oHumanInfoMsg.使用物品ID = self.m_db.使用物品ID
	oHumanInfoMsg.自动使用合击 = self.m_db.自动使用合击
	oHumanInfoMsg.自动分解宠物白 = self.m_db.自动分解宠物白
	oHumanInfoMsg.自动分解宠物绿 = self.m_db.自动分解宠物绿
	oHumanInfoMsg.自动分解宠物蓝 = self.m_db.自动分解宠物蓝
	oHumanInfoMsg.自动分解宠物紫 = self.m_db.自动分解宠物紫
	oHumanInfoMsg.自动分解宠物橙 = self.m_db.自动分解宠物橙
	oHumanInfoMsg.自动孵化宠物蛋 = self.m_db.自动孵化宠物蛋
	oHumanInfoMsg.物品自动拾取 = self.m_db.物品自动拾取
	oHumanInfoMsg.显示时装 = self.m_db.显示时装
	oHumanInfoMsg.英雄显示时装 = self.m_db.英雄显示时装
	oHumanInfoMsg.显示炫武 = self.m_db.显示炫武
	oHumanInfoMsg.英雄显示炫武 = self.m_db.英雄显示炫武
	oHumanInfoMsg.副本刷怪数量 = self.m_db.副本刷怪数量
	oHumanInfoMsg.队伍拒绝邀请 = self.m_db.队伍拒绝邀请
	oHumanInfoMsg.队伍拒绝申请 = self.m_db.队伍拒绝申请
	消息类.SendMsg(oHumanInfoMsg, self.id)
end

function 玩家对象类:SendPropAddPoint()
	local 点数 = 0
	for k,v in pairs(self.m_db.转生加点) do
		点数 = 点数 + v
	end
	local 英雄点数 = 0
	for k,v in pairs(self.m_db.英雄转生加点) do
		英雄点数 = 英雄点数 + v
	end
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_PROP_ADDPOINT]
	oHumanInfoMsg.剩余点数 = math.max(0,self.m_db.属性点数+self.m_db.转生等级*10-点数)
	oHumanInfoMsg.英雄剩余点数 = math.max(0,self.m_db.英雄属性点数+self.m_db.英雄转生等级*10-英雄点数)
	消息类.SendMsg(oHumanInfoMsg, self.id)
	
end

function 玩家对象类:更新属性点()
	local 点数 = 0
	for k,v in pairs(self.m_db.转生加点) do
		点数 = 点数 + v
		if k == 1 then
			self.属性值[公共定义.属性_力量] = v
		elseif k == 2 then
			self.属性值[公共定义.属性_智力] = v
		elseif k == 3 then
			self.属性值[公共定义.属性_敏捷] = v
		elseif k == 4 then
			self.属性值[公共定义.属性_精神] = v
		elseif k == 5 then
			self.属性值[公共定义.属性_体质] = v
		end
	end
	
	self:更新属性值()
	
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_PROP_ADDPOINT]
	oHumanInfoMsg.剩余点数 = math.max(0,self.m_db.属性点数+self.m_db.level*3-点数)
	消息类.SendMsg(oHumanInfoMsg, self.id)
end

function 玩家对象类:四舍五入(e)
	local 文本 = tostring(e)
	local 长度 = string.len(文本)
	local 尾数 = tonumber(string.sub(文本,长度,长度))
	local 数值 = 0
	if(尾数 > 4) then
		数值 = math.ceil(e)
	else
		数值 = math.floor(e)
	end
	
	return 数值
end

function 玩家对象类:更新属性值()
	local human,转生加点,属性 = self,self.m_db.转生加点,{}

	human.attrlearn = {}

	for k,v in pairs(转生加点) do
		if k == 1 then
			human.attrlearn[公共定义.属性_力量] = (human.attrlearn[公共定义.属性_力量] or 0) + v * 1
			属性.攻击 = 1 * human.attrlearn[公共定义.属性_力量]
			属性.攻击上限 = 1 * human.attrlearn[公共定义.属性_力量]
			属性.防御上限 = 0.3 * human.attrlearn[公共定义.属性_力量]
			属性.生命值 = 2 * human.attrlearn[公共定义.属性_力量]
			
			human.attrlearn[公共定义.属性_攻击] = (human.attrlearn[公共定义.属性_攻击] or 0) + 属性.攻击
			human.attrlearn[公共定义.属性_攻击上限] = (human.attrlearn[公共定义.属性_攻击上限] or 0) + 属性.攻击上限
			human.attrlearn[公共定义.属性_防御上限] = (human.attrlearn[公共定义.属性_防御上限] or 0) + self:四舍五入(属性.防御上限)
			human.attrlearn[公共定义.属性_生命值] = (human.attrlearn[公共定义.属性_生命值] or 0) + 属性.生命值
		elseif k == 2 then
			human.attrlearn[公共定义.属性_智力] = (human.attrlearn[公共定义.属性_智力] or 0) + v * 1
			属性.魔法 = 1.1 * human.attrlearn[公共定义.属性_智力]
			属性.魔法上限 = 1.1 * human.attrlearn[公共定义.属性_智力]
			属性.魔御上限 = 0.3 * human.attrlearn[公共定义.属性_智力]
			属性.魔法值 = 1 * human.attrlearn[公共定义.属性_智力]
			
			human.attrlearn[公共定义.属性_魔法] = (human.attrlearn[公共定义.属性_魔法] or 0) + self:四舍五入(属性.魔法)
			human.attrlearn[公共定义.属性_魔法上限] = (human.attrlearn[公共定义.属性_魔法上限] or 0) + self:四舍五入(属性.魔法上限)
			human.attrlearn[公共定义.属性_魔御上限] = (human.attrlearn[公共定义.属性_魔御上限] or 0) + self:四舍五入(属性.魔御上限)
			human.attrlearn[公共定义.属性_魔法值] = (human.attrlearn[公共定义.属性_魔法值] or 0) + 属性.魔法值
		elseif k == 3 then
			human.attrlearn[公共定义.属性_敏捷] = (human.attrlearn[公共定义.属性_敏捷] or 0) + v * 1
			属性.防御上限 = 1.5 * human.attrlearn[公共定义.属性_敏捷]
			属性.魔御上限 = 1.5 * human.attrlearn[公共定义.属性_敏捷]
			
			human.attrlearn[公共定义.属性_防御上限] = (human.attrlearn[公共定义.属性_防御上限] or 0) + self:四舍五入(属性.防御上限)
			human.attrlearn[公共定义.属性_魔御上限] = (human.attrlearn[公共定义.属性_魔御上限] or 0) + self:四舍五入(属性.魔御上限)
		elseif k == 4 then
			human.attrlearn[公共定义.属性_精神] = (human.attrlearn[公共定义.属性_精神] or 0) + v * 1
			属性.魔御上限 = 0.8 * human.attrlearn[公共定义.属性_精神]
			属性.魔法值 = 3 * human.attrlearn[公共定义.属性_精神]
			属性.攻击速度 = 0.4 * human.attrlearn[公共定义.属性_精神]
			
			human.attrlearn[公共定义.属性_魔御上限] = (human.attrlearn[公共定义.属性_魔御上限] or 0) + self:四舍五入(属性.魔御上限)
			human.attrlearn[公共定义.属性_魔法值] = (human.attrlearn[公共定义.属性_魔法值] or 0) + 属性.魔法值
			human.attrlearn[公共定义.属性_攻击速度] = (human.attrlearn[公共定义.属性_攻击速度] or 0) + self:四舍五入(属性.攻击速度)
		elseif k == 5 then
			human.attrlearn[公共定义.属性_体质] = (human.attrlearn[公共定义.属性_体质] or 0) + v * 1
			属性.防御上限 = 0.4 * human.attrlearn[公共定义.属性_体质]
			属性.魔御上限 = 0.6 * human.attrlearn[公共定义.属性_体质]
			属性.生命值 = 15 * human.attrlearn[公共定义.属性_体质]
			属性.重击 = 0.2 * human.attrlearn[公共定义.属性_体质]
			
			human.attrlearn[公共定义.属性_防御上限] = (human.attrlearn[公共定义.属性_防御上限] or 0) + self:四舍五入(属性.防御上限)
			human.attrlearn[公共定义.属性_魔御上限] = (human.attrlearn[公共定义.属性_魔御上限] or 0) + self:四舍五入(属性.魔御上限)
			human.attrlearn[公共定义.属性_生命值] = (human.attrlearn[公共定义.属性_生命值] or 0) + 属性.生命值
			human.attrlearn[公共定义.属性_重击] = (human.attrlearn[公共定义.属性_重击] or 0) + self:四舍五入(属性.重击)
		end
		
	end

	human:CalcDynamicAttr()
end

function 玩家对象类:SendHeroInfoMsg()
	if not self.英雄 then
		return
	end
    -- 下发GCHumanInfo消息
	local oHumanInfoMsg = 派发器.ProtoContainer[协议ID.GC_HERO_INFO]
	oHumanInfoMsg.rolename = self.英雄:GetName()--self.platform..
	oHumanInfoMsg.objid = self.英雄.id
	oHumanInfoMsg.level = self.英雄.m_db.level
	oHumanInfoMsg.job = self.英雄.m_db.job
	oHumanInfoMsg.sex = self.英雄.m_db.sex
	oHumanInfoMsg.status = self.英雄.m_status
	oHumanInfoMsg.maxhp = self.英雄.hpMax
	oHumanInfoMsg.maxmp = self.英雄.mpMax
	oHumanInfoMsg.hp = self.英雄.hp
	oHumanInfoMsg.mp = self.英雄.mp
	消息类.SendMsg(oHumanInfoMsg, self.id)
end

function 玩家对象类:CheckDead()
	if self.hp > 0 then
		return
	end
  for i,v in ipairs(self.m_db.petdb.call) do
	local ind = 宠物DB.FindIndex(self.petmerge, v.index)
	if ind then
		v.hp = self.petmerge[ind].hp
	elseif self.pet[v.index] then
		v.hp = self.pet[v.index].hp
	end
	local dbind = 宠物DB.FindIndex(self.m_db.petdb.db, v.index)
	if dbind and self.pet[v.index] then
		vv = self.pet[v.index]
		self.m_db.petdb.db[dbind].level = vv.level
		self.m_db.petdb.db[dbind].exp = vv.exp
		self.m_db.petdb.db[dbind].starlevel = vv.starlevel
		self.m_db.petdb.db[dbind].starexp = vv.starexp
	end
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
	if self.英雄 then
		self.英雄:RecoverHP(-self.英雄.hpMax)
		self.英雄:CheckDead()
		self.英雄.relivetime = nil
	end
  self.calllen = nil
  for k,v in pairs(self.call) do
	if k == -1 then
		self.m_db.镖车血量 = v.hp
		self.m_db.镖车玩家伤害 = {}
		for kk,vv in pairs(v.humanenmity) do
			self.m_db.镖车玩家伤害[kk] = vv
		end
	end
	v:Destroy()
  end
  self.call = {}
  for k,v in pairs(self.pet) do
	v:Destroy()
  end
  self.pet = {}
  self.petmerge = {}
	self:RemoveDeadBuff()
	self:StopMove()
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, 0)
	self.inrunbock = nil
	if self.displace then
		_DelTimer(self.displace, self.id)
		DisplaceMove[self.id] = nil
		self.displace = nil
	end
	if self.hitpoint then
		_DelTimer(self.hitpoint, self.id)
		self.hitpoint = nil
	end
	if self.是否英雄 then
		self.relivetime = _CurrentTime() + 10000
	end
	if not self.是否英雄 then
		local call = 事件触发._M["call_玩家死亡"]
		if call then
			self:显示对话(-2,call(self))
		end
	end
end

function 玩家对象类:Destroy()
  if self.fake then
    assert(nil)
    return
  end
  
	for i=#DelayCalls,1,-1 do
		if DelayCalls[i][4] == self then
			table.remove(DelayCalls, i)
		end
	end
	for i=#定时中间公告,1,-1 do
		local v = 定时中间公告[i]
		if v[3] == self then
			table.remove(定时中间公告,i)
		end
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
  self.calllen = nil
  for k,v in pairs(self.call) do
	if k == -1 then
		self.m_db.镖车血量 = v.hp
		self.m_db.镖车玩家伤害 = {}
		for kk,vv in pairs(v.humanenmity) do
			self.m_db.镖车玩家伤害[kk] = vv
		end
	end
	v:Destroy()
  end
  self.call = {}
  for k,v in pairs(self.pet) do
	v:Destroy()
  end
  self.pet = {}
  self.petmerge = {}
  
  if Config.ISGAMESVR then
	self:Save()
	副本管理.SceneHumanName[self:GetName()] = nil
	副本管理.SceneMatchList[self] = nil
  end
	if self.英雄 then
		self.英雄:Destroy()
		self.英雄 = nil
	end

	if self.teamid ~= 0 and 队伍管理.TeamList[self.teamid] then
		for i,v in ipairs(队伍管理.TeamList[self.teamid]) do
			if v == self then
				table.remove(队伍管理.TeamList[self.teamid],i)
				break
			end
		end
		for i,v in ipairs(队伍管理.TeamList[self.teamid]) do
			队伍管理.SendTeammate(v)
		end
		if #队伍管理.TeamList[self.teamid] == 0 then
			队伍管理.TeamList[self.teamid] = nil
		end
		self.teamid = 0
	end
	在线玩家管理[self:GetName()] = nil
	在线账号管理[self:GetAccount()] = nil

	DisplaceMove[self.id] = nil
	self:CleanFD()
	self:RemoveBuff()
	self:LeaveScene()
	self:ReleaseObj()
	对象管理[self.id] = nil
end

function 玩家对象类:AddUser()
  return self.m_db:Add()
end

function 玩家对象类:GetName()
  return tostring(self.m_db.name)
end

function 玩家对象类:GetAccount()
  return tostring(self.m_db.account)
end

local timer1 = {}
local timer2 = {}

function 玩家对象类:Save()
	--local fd = _GetFD(self.id)
	--if fd == -1 then
	--	return
	--end
	if self:GetName() == "" or self.是否英雄 then
		return
	end
--处理元宝为负时转为0
	if self.m_nSceneID ~= -1 then
		local x, y = self:GetPosition()
		if x ~= -1 and y ~= -1 then
		  self.m_db.x, self.m_db.y = x, y
		end
	end
	self.m_db.hp = self.hp
	self.m_db.mp = self.mp
	self.m_db.bufftime = {}
	for k,v in pairs(self.buffend) do
		local timer = _GetTimer(v, self.id)
		local buffconf = Buff表[k]
		if buffconf and buffconf.效果计时 == 1 and timer and timer.interval > 0 then
			self.m_db.bufftime[k] = timer.interval
		elseif timer and timer.nextCallTime > _CurrentTime() then
			self.m_db.bufftime[k] = timer.nextCallTime - _CurrentTime()
		end
	end
	if self.英雄 then
		self.m_db.英雄等级 = self.英雄.m_db.level
		self.m_db.英雄经验 = self.英雄.m_db.exp
		self.m_db.英雄生命 = self.英雄.hp
		self.m_db.英雄魔法 = self.英雄.mp
		self.m_db.英雄复活 = self.英雄.relivetime and self.英雄.relivetime - _CurrentTime() or 0
	end
  for i,v in ipairs(self.m_db.petdb.call) do
	local ind = 宠物DB.FindIndex(self.petmerge, v.index)
	if ind then
		v.hp = self.petmerge[ind].hp
	elseif self.pet[v.index] then
		v.hp = self.pet[v.index].hp
	end
	local dbind = 宠物DB.FindIndex(self.m_db.petdb.db, v.index)
	if dbind and self.pet[v.index] then
		vv = self.pet[v.index]
		self.m_db.petdb.db[dbind].level = vv.level
		self.m_db.petdb.db[dbind].exp = vv.exp
		self.m_db.petdb.db[dbind].starlevel = vv.starlevel
		self.m_db.petdb.db[dbind].starexp = vv.starexp
		if self:GetLevel() >= 35 and vv.level >= 35 then
			宠物排行管理.UpdatePower(vv:GetName(true),self:GetName(),v.index,vv:CalcPower(),vv.starlevel,vv.level)
		end
	end
  end
  if self:GetLevel() >= 35 then
	if self.英雄 and self.英雄:GetLevel() >= 35 then
		英雄排行管理.UpdatePower(self.英雄:GetName(),公共定义.转生[self.m_db.英雄转生等级] or "",self.英雄.m_db.job,self.英雄:CalcPower(),self.英雄.m_db.level)
	end
	if self.m_db.VIP推广人数 > 0 then
		VIP推广排行管理.UpdatePower(self:GetName(),self.m_db.VIP推广人数,self.m_db.VIP推广有效人数,self.m_db.job,self.m_db.VIP成长经验,self.m_db.level)
	end
	排行榜管理.UpdatePower(self:GetName(),公共定义.转生[self.m_db.转生等级] or "",self.m_db.job,self:CalcPower(),self.m_db.level)
  end
  if self.m_db.guildname ~= "" then
	  行会管理.UpdateMemberInfo(self.m_db.guildname,self:GetName(),self:CalcPower(),self.m_db.job,self:GetLevel(),self.m_db.转生等级)
  end
  local ret, err = pcall(玩家对象类.RealSave, self)
  if not ret then
    日志.WriteLog(日志.LOGIN_SAVE_DB_ERR, self:GetName(), err)
  end
end

function 玩家对象类:RealSave()
  if self:GetName() == "" then
    return false
  end
  if self.fake then --假人
    return false
  end
  
  local ret = self.m_db:Save()
  print("save objhuman", _convert(self:GetName()))

  return ret
end

function 玩家对象类:Load(username, bAccount, svrname)
  self.m_db = 玩家DB:New()
  local ret
  if bAccount then
    ret = self.m_db:LoadByAccount(username, svrname)
  else
    ret = self.m_db:LoadByName(username)
  end
  if not ret then
    return ret
  end
  return ret
end

function 玩家对象类:ResetDynamicAttrCache()
  self.m_oAttrCached = nil
end

function 玩家对象类:CalcDynamicAttr()
	if self.是否英雄 then
		self:CalcDynamicAttrImpl()
	else
		self.willCalcDynamicAttr = true
	end
end

function 玩家对象类:CalcDynamicAttrImpl()
	local conf = 玩家属性表[self.m_db.level]
	if not conf then
		return
	end
	
	self.willCalcDynamicAttr = nil
	local hppercent = self.hpMax > 0 and self.hp / self.hpMax or 1
	local mppercent = self.mpMax > 0 and self.mp / self.mpMax or 1
	
	for i,v in ipairs(公共定义.属性文字) do
		self.属性值[i] = conf[v..self.m_db.job] or conf[v] or 0
	end
	
	实用工具.DeleteTable(self.额外属性)--self.额外属性 = {}
	实用工具.DeleteTable(self.attrattach)--self.attrattach = {}
	实用工具.DeleteTable(self.suitcnts)--self.suitcnts = {}
	for k,v in pairs(self.m_db.bagdb.equips) do
		local cf = 物品表[v.id]
		if cf.suitid ~= 0 then
			self.suitcnts[cf.suitid] = (self.suitcnts[cf.suitid] or 0) + 1
		end
		for i,prop in ipairs(cf.prop) do
			self.属性值[prop[1]] = self.属性值[prop[1]] + prop[2] * (1 + ((v.grade or 1) - 1) / 5) + (prop[2] * (v.strengthen or 0) / 10)
		end
		if v.wash then
			for i,prop in ipairs(v.wash) do
				if 公共定义.属性文字[prop[1]] then
					self.属性值[prop[1]] = (self.属性值[prop[1]] or 0) + prop[2]
				else
					self.额外属性[prop[1]] = (self.额外属性[prop[1]] or 0) + prop[2]
				end
			end
		end
		if v.attach and #v.attach > 0 then
			self.attrattach[v.attach[1]] = (self.attrattach[v.attach[1]] or 0) + (v.attach[2] or 0)
		end
		if v.gem then
			for i,prop in ipairs(v.gem) do
				if prop[1] == 1 then
					self.属性值[公共定义.属性_生命值] = self.属性值[公共定义.属性_生命值] + prop[2]*10
				elseif prop[1] == 2 then
					self.属性值[公共定义.属性_防御上限] = self.属性值[公共定义.属性_防御上限] + prop[2]
				elseif prop[1] == 3 then
					self.属性值[公共定义.属性_魔御上限] = self.属性值[公共定义.属性_魔御上限] + prop[2]
				elseif prop[1] == 4 then
					self.属性值[公共定义.属性_攻击上限] = self.属性值[公共定义.属性_攻击上限] + prop[2]
				elseif prop[1] == 5 then
					self.属性值[公共定义.属性_魔法上限] = self.属性值[公共定义.属性_魔法上限] + prop[2]
				elseif prop[1] == 6 then
					self.属性值[公共定义.属性_道术上限] = self.属性值[公共定义.属性_道术上限] + prop[2]
				end
			end
		end
		for i,propex in ipairs(cf.propex) do
			self.额外属性[propex[1]] = (self.额外属性[propex[1]] or 0) + propex[2] * (1 + ((v.grade or 1) - 1) / 5) + (propex[2] * (v.strengthen or 0) / 10)
		end
	end
	for i,v in pairs(self.attrlearn) do
		if 公共定义.属性文字[i] then
			self.属性值[i] = (self.属性值[i] or 0) + v
		else
			self.额外属性[i] = (self.额外属性[i] or 0) + v
		end
	end
	for i,v in pairs(self.attrattach) do
		if i == 公共定义.附魔_生命值 then
			self.属性值[公共定义.属性_生命值] = self.属性值[公共定义.属性_生命值] * (1+v/100)
		elseif i == 公共定义.附魔_魔法值 then
			self.属性值[公共定义.属性_魔法值] = self.属性值[公共定义.属性_魔法值] * (1+v/100)
		elseif i == 公共定义.附魔_防御 then
			self.属性值[公共定义.属性_防御] = self.属性值[公共定义.属性_防御] * (1+v/100)
			self.属性值[公共定义.属性_防御上限] = self.属性值[公共定义.属性_防御上限] * (1+v/100)
		elseif i == 公共定义.附魔_魔御 then
			self.属性值[公共定义.属性_魔御] = self.属性值[公共定义.属性_魔御] * (1+v/100)
			self.属性值[公共定义.属性_魔御上限] = self.属性值[公共定义.属性_魔御上限] * (1+v/100)
		elseif i == 公共定义.附魔_攻击 then
			self.属性值[公共定义.属性_攻击] = self.属性值[公共定义.属性_攻击] * (1+v/100)
			self.属性值[公共定义.属性_攻击上限] = self.属性值[公共定义.属性_攻击上限] * (1+v/100)
		elseif i == 公共定义.附魔_魔法 then
			self.属性值[公共定义.属性_魔法] = self.属性值[公共定义.属性_魔法] * (1+v/100)
			self.属性值[公共定义.属性_魔法上限] = self.属性值[公共定义.属性_魔法上限] * (1+v/100)
		elseif i == 公共定义.附魔_道术 then
			self.属性值[公共定义.属性_道术] = self.属性值[公共定义.属性_道术] * (1+v/100)
			self.属性值[公共定义.属性_道术上限] = self.属性值[公共定义.属性_道术上限] * (1+v/100)
		end
	end
	for i,v in pairs(self.suitcnts) do
		local cf = 套装表[i]
		if cf and v >= cf.cnt then
			for ii,prop in ipairs(cf.prop) do
				self.属性值[prop[1]] = self.属性值[prop[1]] + prop[2]
			end
			for ii,propex in ipairs(cf.propex) do
				self.额外属性[propex[1]] = (self.额外属性[propex[1]] or 0) + propex[2]
			end
		end
	end
	for i,v in pairs(self.在线属性) do
		if 公共定义.属性文字[i] then
			self.属性值[i] = (self.属性值[i] or 0) + v
		else
			self.额外属性[i] = (self.额外属性[i] or 0) + v
		end
	end
	for i,v in pairs(self.管理属性) do
		if 公共定义.属性文字[i] then
			self.属性值[i] = (self.属性值[i] or 0) + v[1]
		else
			self.额外属性[i] = (self.额外属性[i] or 0) + v[1]
		end
	end
	for i,v in pairs(self.m_db.药水属性) do
		if 公共定义.属性文字[i] then
			self.属性值[i] = (self.属性值[i] or 0) + v[1]
		else
			self.额外属性[i] = (self.额外属性[i] or 0) + v[1]
		end
	end
	if self.额外属性[公共定义.额外属性_体质] then
		self.属性值[公共定义.属性_生命值] = self.属性值[公共定义.属性_生命值] * (100+self.额外属性[公共定义.额外属性_体质])/100
		self.属性值[公共定义.属性_魔法值] = self.属性值[公共定义.属性_魔法值] * (100+self.额外属性[公共定义.额外属性_体质])/100
	end
	self.属性值[公共定义.属性_生命值] = math.max(1, self.属性值[公共定义.属性_生命值])
	self.hpMax = self:获取生命值()--self.属性值[公共定义.属性_生命值]
	self.hp = self.hpMax * hppercent
	self.mpMax = self:获取魔法值()--self.属性值[公共定义.属性_魔法值]
	self.mp = self.mpMax * mppercent
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, self.hp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, self.hpMax)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MP, self.mp)
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXMP, self.mpMax)
	self:SetEngineMoveSpeed(self:获取移动速度())
	self:ChangeInfo()
end

function 玩家对象类:CalcPower()
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
	for k,v in pairs(self.额外属性) do
		战力 = 战力 + v
	end
	return math.floor(战力)
end

function 玩家对象类:JumpScene(nSceneID, nX, nY)
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
    self.m_db.x = nX
    self.m_db.y = nY
    local oMsgJumpPoint = 派发器.ProtoContainer[协议ID.GC_JUMP_SCENE]
    oMsgJumpPoint.objid = self.id
    oMsgJumpPoint.mapid = 场景管理.GetMapId(nSceneID) or 0
    oMsgJumpPoint.x = nX
    oMsgJumpPoint.y = nY
    消息类.ZoneBroadCast(oMsgJumpPoint, self.id)
    self:ChangePosition(nX, nY)
  elseif self.是否英雄 then
    self:LeaveScene()
    self.m_db.mapid = 场景管理.GetMapId(nSceneID)
    self.m_db.x = nX
    self.m_db.y = nY
	self:EnterScene(nSceneID, nX, nY)
  else
	self:SendTipsMsg(3, "")
    self:LeaveScene()
    self.m_db.mapid = 场景管理.GetMapId(nSceneID)
    self.m_db.x = nX
    self.m_db.y = nY
	self.entersceneid = nSceneID
	local msgRet = 派发器.ProtoContainer[协议ID.GC_ENTER_SCENE]
    msgRet.result = 1
    msgRet.objid = self.id
    msgRet.mapid = 场景管理.GetMapId(nSceneID)
    msgRet.maptype = 场景管理.GetMapType(nSceneID)
    msgRet.scenex = nX
    msgRet.sceney = nY
    msgRet.mode = 场景管理.SceneMod[nSceneID] and 场景管理.SceneMod[nSceneID].mode or 0
    msgRet.mapheight, msgRet.mapwidth = _GetHeightAndWidth(nSceneID)
    msgRet.isstatshurt = 0--地图表[msgRet.mapid].isStatsHurt
    消息类.SendMsg(msgRet, self.id)
  end
end

function 玩家对象类:GetHP()
	local hp = self.hp
	if #self.petmerge > 0 then
		for i,v in ipairs(self.petmerge) do
			hp = hp + v.hp
		end
	end
	return hp
end

function 玩家对象类:获取性别()
	return self.m_db.sex
end

function 玩家对象类:获取职业()
	return self.m_db.job
end

function 玩家对象类:当前生命()
	local hp = self.hp
	if #self.petmerge > 0 then
		for i,v in ipairs(self.petmerge) do
			hp = hp + v.hp
		end
	end
	return hp
end

function 玩家对象类:当前魔法()
	return self.mp
end

function 玩家对象类:获取生命值()
	local 生命值 = self.属性值[公共定义.属性_生命值]
	if #self.petmerge > 0 then
		for i,v in ipairs(self.petmerge) do
			生命值 = 生命值 + v.hpmax
		end
	end
	if self.attr[公共定义.属性_生命值] then
		return 生命值 + self.attr[公共定义.属性_生命值][1] - self.attr[公共定义.属性_生命值][2]
	else
		return 生命值
	end
end

function 玩家对象类:获取魔法值()
	if self.attr[公共定义.属性_魔法值] then
		return self.属性值[公共定义.属性_魔法值] + self.attr[公共定义.属性_魔法值][1] - self.attr[公共定义.属性_魔法值][2]
	else
		return self.属性值[公共定义.属性_魔法值]
	end
end

function 玩家对象类:获取防御()
	if self.attr[公共定义.属性_防御] then
		return self.属性值[公共定义.属性_防御] + self.attr[公共定义.属性_防御][1] - self.attr[公共定义.属性_防御][2]
	else
		return self.属性值[公共定义.属性_防御]
	end
end

function 玩家对象类:获取防御上限()
	if self.attr[公共定义.属性_防御上限] then
		return self.属性值[公共定义.属性_防御上限] + self.attr[公共定义.属性_防御上限][1] - self.attr[公共定义.属性_防御上限][2]
	else
		return self.属性值[公共定义.属性_防御上限]
	end
end

function 玩家对象类:获取魔御()
	if self.attr[公共定义.属性_魔御] then
		return self.属性值[公共定义.属性_魔御] + self.attr[公共定义.属性_魔御][1] - self.attr[公共定义.属性_魔御][2]
	else
		return self.属性值[公共定义.属性_魔御]
	end
end

function 玩家对象类:获取魔御上限()
	if self.attr[公共定义.属性_魔御上限] then
		return self.属性值[公共定义.属性_魔御上限] + self.attr[公共定义.属性_魔御上限][1] - self.attr[公共定义.属性_魔御上限][2]
	else
		return self.属性值[公共定义.属性_魔御上限]
	end
end

function 玩家对象类:获取攻击()
	if self.attr[公共定义.属性_攻击] then
		return self.属性值[公共定义.属性_攻击] + self.attr[公共定义.属性_攻击][1] - self.attr[公共定义.属性_攻击][2]
	else
		return self.属性值[公共定义.属性_攻击]
	end
end

function 玩家对象类:获取攻击上限()
	if self.attr[公共定义.属性_攻击上限] then
		return self.属性值[公共定义.属性_攻击上限] + self.attr[公共定义.属性_攻击上限][1] - self.attr[公共定义.属性_攻击上限][2]
	else
		return self.属性值[公共定义.属性_攻击上限]
	end
end

function 玩家对象类:获取魔法()
	if self.attr[公共定义.属性_魔法] then
		return self.属性值[公共定义.属性_魔法] + self.attr[公共定义.属性_魔法][1] - self.attr[公共定义.属性_魔法][2]
	else
		return self.属性值[公共定义.属性_魔法]
	end
end

function 玩家对象类:获取魔法上限()
	if self.attr[公共定义.属性_魔法上限] then
		return self.属性值[公共定义.属性_魔法上限] + self.attr[公共定义.属性_魔法上限][1] - self.attr[公共定义.属性_魔法上限][2]
	else
		return self.属性值[公共定义.属性_魔法上限]
	end
end

function 玩家对象类:获取道术()
	if self.attr[公共定义.属性_道术] then
		return self.属性值[公共定义.属性_道术] + self.attr[公共定义.属性_道术][1] - self.attr[公共定义.属性_道术][2]
	else
		return self.属性值[公共定义.属性_道术]
	end
end

function 玩家对象类:获取道术上限()
	if self.attr[公共定义.属性_道术上限] then
		return self.属性值[公共定义.属性_道术上限] + self.attr[公共定义.属性_道术上限][1] - self.attr[公共定义.属性_道术上限][2]
	else
		return self.属性值[公共定义.属性_道术上限]
	end
end

function 玩家对象类:获取幸运()
	if self.attr[公共定义.属性_幸运] then
		return self.属性值[公共定义.属性_幸运] + self.attr[公共定义.属性_幸运][1] - self.attr[公共定义.属性_幸运][2]
	else
		return self.属性值[公共定义.属性_幸运]
	end
end

function 玩家对象类:获取准确()
	if self.attr[公共定义.属性_准确] then
		return self.属性值[公共定义.属性_准确] + self.attr[公共定义.属性_准确][1] - self.attr[公共定义.属性_准确][2]
	else
		return self.属性值[公共定义.属性_准确]
	end
end

function 玩家对象类:获取敏捷()
	if self.attr[公共定义.属性_敏捷] then
		return self.属性值[公共定义.属性_敏捷] + self.attr[公共定义.属性_敏捷][1] - self.attr[公共定义.属性_敏捷][2]
	else
		return self.属性值[公共定义.属性_敏捷]
	end
end

function 玩家对象类:获取力量()
	if self.attr[公共定义.属性_力量] then
		return self.属性值[公共定义.属性_力量] + self.attr[公共定义.属性_力量][1] - self.attr[公共定义.属性_力量][2]
	else
		return self.属性值[公共定义.属性_力量]
	end
end

function 玩家对象类:获取智力()
	if self.attr[公共定义.属性_智力] then
		return self.属性值[公共定义.属性_智力] + self.attr[公共定义.属性_智力][1] - self.attr[公共定义.属性_智力][2]
	else
		return self.属性值[公共定义.属性_智力]
	end
end

function 玩家对象类:获取精神()
	if self.attr[公共定义.属性_精神] then
		return self.属性值[公共定义.属性_精神] + self.attr[公共定义.属性_精神][1] - self.attr[公共定义.属性_精神][2]
	else
		return self.属性值[公共定义.属性_精神]
	end
end

function 玩家对象类:获取体质()
	if self.attr[公共定义.属性_体质] then
		return self.属性值[公共定义.属性_体质] + self.attr[公共定义.属性_体质][1] - self.attr[公共定义.属性_体质][2]
	else
		return self.属性值[公共定义.属性_体质]
	end
end

function 玩家对象类:获取重击()
	if self.attr[公共定义.属性_重击] then
		return self.属性值[公共定义.属性_重击] + self.attr[公共定义.属性_重击][1] - self.attr[公共定义.属性_重击][2]
	else
		return self.属性值[公共定义.属性_重击]
	end
end

function 玩家对象类:获取魔法命中()
	if self.attr[公共定义.属性_魔法命中] then
		return self.属性值[公共定义.属性_魔法命中] + self.attr[公共定义.属性_魔法命中][1] - self.attr[公共定义.属性_魔法命中][2]
	else
		return self.属性值[公共定义.属性_魔法命中]
	end
end

function 玩家对象类:获取魔法躲避()
	if self.attr[公共定义.属性_魔法躲避] then
		return self.属性值[公共定义.属性_魔法躲避] + self.attr[公共定义.属性_魔法躲避][1] - self.attr[公共定义.属性_魔法躲避][2]
	else
		return self.属性值[公共定义.属性_魔法躲避]
	end
end

function 玩家对象类:获取生命恢复()
	if self.attr[公共定义.属性_生命恢复] then
		return self.属性值[公共定义.属性_生命恢复] + self.attr[公共定义.属性_生命恢复][1] - self.attr[公共定义.属性_生命恢复][2]
	else
		return self.属性值[公共定义.属性_生命恢复]
	end
end

function 玩家对象类:获取魔法恢复()
	if self.attr[公共定义.属性_魔法恢复] then
		return self.属性值[公共定义.属性_魔法恢复] + self.attr[公共定义.属性_魔法恢复][1] - self.attr[公共定义.属性_魔法恢复][2]
	else
		return self.属性值[公共定义.属性_魔法恢复]
	end
end

function 玩家对象类:获取中毒恢复()
	if self.attr[公共定义.属性_中毒恢复] then
		return self.属性值[公共定义.属性_中毒恢复] + self.attr[公共定义.属性_中毒恢复][1] - self.attr[公共定义.属性_中毒恢复][2]
	else
		return self.属性值[公共定义.属性_中毒恢复]
	end
end

function 玩家对象类:获取攻击速度()
	if self.attr[公共定义.属性_攻击速度] then
		return self.属性值[公共定义.属性_攻击速度] + self.attr[公共定义.属性_攻击速度][1] - self.attr[公共定义.属性_攻击速度][2]
	else
		return self.属性值[公共定义.属性_攻击速度]
	end
end

function 玩家对象类:获取移动速度()
	local 移动速度 = self.mountid ~= 0 and self.属性值[公共定义.属性_移动速度] + 0 or self.属性值[公共定义.属性_移动速度]
	if self.m_status == 公共定义.STATUS_WALK then
		移动速度 = 移动速度 * 0.5
	end
	if self.attr[公共定义.属性_移动速度] then
		return 移动速度 + self.attr[公共定义.属性_移动速度][1] - self.attr[公共定义.属性_移动速度][2]
	else
		return 移动速度
	end
end

function 玩家对象类:GetAttr(attrtype)
	local val = self.额外属性[attrtype] or 0
	if self.attrlearn[attrtype] then
		val = val + self.attrlearn[attrtype]
	end
	if self.attr[attrtype] then
		val = val + self.attr[attrtype][1] - self.attr[attrtype][2]
	end
	return val
end

function 玩家对象类:AddBuff(buffid,time)
	local buffconf = Buff表[buffid]
	if buffconf == nil then
		return
	end
	time = time>0 and time or 9999999
	if buffconf.mutex ~= 0 then
		for k,v in pairs(self.buffhit) do
			local conf = Buff表[k]
			if k ~= buffid and conf.mutex == buffconf.mutex then
				_DelTimer(v, self.id)
				self.buffhit[k] = nil
			end
		end
		for k,v in pairs(self.buffend) do
			local conf = Buff表[k]
			if k ~= buffid and conf.mutex == buffconf.mutex then
				_DelTimer(v, self.id)
				self.buffend[k] = nil
				技能逻辑.DoHitBuffEnd(self, conf)
			end
		end
	end
	local buffhit = 技能逻辑.CheckHitBuff(buffconf)
	if buffhit then
		if self.buffhit[buffid] then
			_DelTimer(self.buffhit[buffid], self.id)
		end
		self.buffhit[buffid] = _AddTimer(self.id, 计时器ID.TIMER_BUFF_HIT, 1000, 1, {atkerid=-1,buffid=buffid,hitindex=1,time=time})
	end
	if self.buffend[buffid] then
		local timer = _GetTimer(self.buffend[buffid], self.id)
		if buffconf.last == 1 and buffconf.效果计时 == 1 and timer and timer.interval > 0 then
			time = time + timer.interval
		elseif buffconf.last == 1 and timer and timer.nextCallTime > _CurrentTime() then
			time = time + timer.nextCallTime - _CurrentTime()
		end
		_DelTimer(self.buffend[buffid], self.id)
		技能逻辑.DoHitBuffEnd(self, buffconf)
	end
	技能逻辑.DoHitBuff(self, buffconf, time)
	self.buffend[buffid] = _AddTimer(self.id, 计时器ID.TIMER_BUFF_END, time, 1, {buffid=buffid}, buffconf.效果计时)
	技能逻辑.SendBuff(self.id, buffconf, time)
	if buffconf.last == 1 and buffconf.效果计时 == 1 then
		self:SendTipsMsg(2,广播.colorRgb[5]..buffconf.name.."总量剩余："..time)
	elseif buffconf.last == 1 then
		self:SendTipsMsg(2,广播.colorRgb[5]..buffconf.name.."时间剩余："..
		(time > 3600000 and string.format("%.1f",time/3600000).."小时" or time > 60000 and string.format("%d",time/60000).."分钟" or string.format("%d",time/1000).."秒"))
	end
	self:UpdateObjInfo()
	self.updateInfoTime = math.max(self.updateInfoTime or 0, _CurrentTime() + time + 1000)
	return true
end

function 玩家对象类:RecoverTP(covertp)
	if covertp == 0 then return end
	local oldtp = self.m_db.tp
	if oldtp == 0 and covertp < 0 then return end
	if oldtp == 500 and covertp > 0 then return end
	self.m_db.tp = math.max(0,math.min(self.m_db.tp + covertp, 500))
	self:SendActualAttr()
	return true
end

function 玩家对象类:RecoverMP(covermp, useitem)
	if useitem and 场景管理.IsNoDrug(self.m_nSceneID) == 1 then
		--self:SendTipsMsg(1,"该地图禁止吃药")
		return
	end
	if covermp == 0 then return end
	local oldmp = self.mp
	if oldmp == 0 and covermp < 0 then return end
	if oldmp == self.mpMax and covermp > 0 then return end
	self.mp = math.max(0,math.min(self.mp + covermp, self.mpMax))
	self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MP, self.mp)
	self:SendActualAttr()
	return true
end

function 玩家对象类:RecoverHP(coverhp, useitem)
	--if useitem and 场景管理.GetMapType(self.m_nSceneID) == 4 and self.m_db.singlecopyfinish[self.m_db.mapid] ~= 1 then
	--	self:SendTipsMsg(1,"关卡副本未通关前无法使用药水")
	--	return
	--end
	if useitem and 场景管理.IsNoDrug(self.m_nSceneID) == 1 then
		--self:SendTipsMsg(1,"该地图禁止吃药")
		return
	end
	if coverhp == 0 then return end
	local oldhp = self:GetHP()
	if oldhp == 0 and coverhp < 0 then return end
	if oldhp == self.hpMax and coverhp > 0 then return end
	if #self.petmerge > 0 then
		if coverhp < 0 then
			self.petmerge[#self.petmerge].hp = math.max(0, self.petmerge[#self.petmerge].hp + coverhp)
		else
			for i=#self.petmerge,1,-1 do
				if self.petmerge[i].hp + coverhp > self.petmerge[i].hpmax then
					coverhp = self.petmerge[i].hp + coverhp - self.petmerge[i].hpmax
					self.petmerge[i].hp = self.petmerge[i].hpmax
				else
					self.petmerge[i].hp = self.petmerge[i].hp + coverhp
					break
				end
			end
			if coverhp > 0 then
				self.hp = math.max(0,math.min(self.hp + coverhp, self.hpMax))
			end
		end
	else
		self.hp = math.max(0,math.min(self.hp + coverhp, self.hpMax))
		self:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, self.hp)
	end
	if self.hp == 0 then
		self:StopMove()
	end
	if self.hp == 0 and self.mountid ~= 0 then
		self.mountid = 0
		self:ChangeBody()
	end
	self:ChangeInfo()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SKILL_HURT]
	oReturnMsg.objid = self.id
	oReturnMsg.effid1 = 0
	oReturnMsg.effid2 = oldhp == 0 and 3657 or 0
	oReturnMsg.dechp = oldhp - self:GetHP()
	oReturnMsg.crit = 0
	oReturnMsg.status = self.hp == 0 and 1 or oldhp == 0 and 2 or 0
	消息类.ZoneBroadCast(oReturnMsg, self.id)
	self:CheckMergePet()
	return true
end

function 玩家对象类:OnRelive(inplace)
	if self.hp > 0 or self.m_nSceneID == -1 then
		return
	end
	if self.graynametime > 0 then
		self.graynametime = 0
		self:ChangeName()
		self:UpdateObjInfo()
	end
	if (inplace == 1 or inplace == 2 or self.m_db.level < 公共定义.新手保护等级 or self.relivepos) and not 场景管理.IsCopyscene(self.m_nSceneID) then
		if self.relivepos then
			self:JumpScene(self.m_nSceneID, self.relivepos[1], self.relivepos[2])
		end
		self:RecoverHP(self.hpMax)
		self:召唤英雄()
		self:ReCallPet()
		副本管理.ReliveSceneObj(self.m_nSceneID, self)
		if inplace == 2 then
			self:RandomTransport()
		end
	else
		local nSceneID = -1
		if self.m_db.backMapid ~= 0 then
			nSceneID = 场景管理.GetSceneId(self.m_db.backMapid, true)
			if nSceneID ~= -1 then
				self:JumpScene(nSceneID, self.m_db.backX, self.m_db.backY)
			end
		else
			local 地图id = self:回城地图()
			nSceneID = 场景管理.GetSceneId(地图id, true)
			if nSceneID ~= -1 then
				local 地图配置 = 地图表[地图id]
				if #地图配置.relivepos == 0 then
					local x, y = 场景管理.GetPosCanRun(nSceneID)
					self:JumpScene(nSceneID, x, y)
				else
					local x = 地图配置.relivepos[1] + math.random(-地图配置.relivepos[3],地图配置.relivepos[3])
					local y = 地图配置.relivepos[2] + math.random(-地图配置.relivepos[3],地图配置.relivepos[3])
					self:JumpScene(nSceneID, x, y)
				end
			end
		end
		if self.m_nSceneID == nSceneID then
			self:RecoverHP(self.hpMax)
			self:召唤英雄()
			self:ReCallPet()
			副本管理.ReliveSceneObj(self.m_nSceneID, self)
		else
			self.isreliving = true
		end
	end
	if self.viewid ~= -1 then
		self.viewid = -1
		self:ChangeStatus(公共定义.STATUS_NORMAL)
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_VIEWER]
		oReturnMsg.objid = self.viewid
		消息类.SendMsg(oReturnMsg, self.id)
	end
end

function 玩家对象类:增加行会贡献(val)
	return 行会管理.DonateGuild(self, val, true)
end

function 玩家对象类:恢复HP(coverhp)
	return self:RecoverHP(coverhp, true)
end

function 玩家对象类:恢复MP(coverhp)
	return self:RecoverMP(coverhp, true)
end

function 玩家对象类:登录时间()
	return os.date("%c", self.m_db.lastLogin)
end

function 玩家对象类:在线时长()
	return os.time() - self.m_db.lastLogin
end

function 玩家对象类:获取PK值()
	return self.m_db.PK值
end

function 玩家对象类:是否管理员()
	return self:GetAccount() == Config.GM_ACCOUNT
end

function 玩家对象类:调整元宝(val)
	local addrmb = val - (公共定义.使用绑定货币 == 1 and self.m_db.bindrmb or self.m_db.rmb)
	if addrmb > 0 then
		self:SendTipsMsg(2, "获得绑定元宝#cffff00,"..addrmb)
	end
	if 公共定义.使用绑定货币 == 1 then
		self.m_db.bindrmb = math.max(0, val)
	else
		self.m_db.rmb = math.max(0, val)
		--self:Save()
	end
	return true
end

function 玩家对象类:调整泡点数(val)
	self.m_db.泡点数 = math.max(0, val)
	return true
end

function 玩家对象类:调整声望值(val)
	self.m_db.声望值 = math.max(0, val)
	return true
end

function 玩家对象类:调整等级(val)
	local oldlevel = self.m_db.level
	self.m_db.level = math.max(1, math.min(#玩家属性表, val))
	self.m_db.exp = 0
	if self.m_db.level ~= oldlevel then
		self:LevelUp()
	end
	self:SendActualAttr()
	return true
end

function 玩家对象类:调整经验(val)
	local addexp = math.max(0, val - self.m_db.exp)
	if self:AddExp(addexp) then
		self:SendTipsMsg(2, "获得经验#cff00,"..addexp)
	end
	return true
end

function 玩家对象类:调整PK值(val)
	self.m_db.PK值 = math.max(0, val)
	self:ChangeName()
	self:UpdateObjInfo()
	return true
end

function 玩家对象类:踢下线()
	self:DoDisconnect(-1)
	return true
end

function 玩家对象类:死亡()
	self.hp = 0
	self:CheckDead()
	return true
end

function 玩家对象类:复活(inplace)
	self:OnRelive(inplace)
	return true
end

function 玩家对象类:宝宝死亡()
	for k,v in pairs(self.call) do
		if v.relivetime == -1 then
			v:Destroy()
		end
	end
	return true
end

function 玩家对象类:清除转生()
	self.m_db.转生等级 = 0
	self:CheckAttrLearn()
	self:SendPropAddPoint()
	return true
end

function 玩家对象类:更换职业(job)
	return self:ChangeJob(job)
end

function 玩家对象类:发送广播(msg)
	聊天逻辑.发送玩家聊天(msg, 0, self)
	return true
end

function 延迟弹出消息框(human)
	human:SendTipsMsg(5,human.delaymsg or "")
	human.delaymsg = nil
end

function 玩家对象类:弹出消息框(msg)
	if not self.delaymsg then
		DelayCalls[#DelayCalls+1] = {_CurrentTime()+1, 延迟弹出消息框, -1, self}
	end
	self.delaymsg = msg:gsub("\\","#n")
	return true
end

function 玩家对象类:学习技能(skillinfoid)
	return self:LearnSkill(skillinfoid)
end

function 玩家对象类:删除技能(skillinfoid, cleartype)
	if skillinfoid ~= 0 then
		技能逻辑.DoDiscardSkill(self,skillinfoid)
	end
	if cleartype == 1 or cleartype == 2 then
		local hero = 0
		local skills = hero ~= 0 and self.m_db.英雄技能 or self.m_db.skills
		local findskillid = {}
		for i=#skills,1,-1 do
			local v = skills[i]
			local conf = 技能信息表[v[1]]
			if conf == nil or conf.special ~= 0 then
			elseif cleartype == 2 or (conf.job ~= 0 and self.m_db.job ~= conf.job) then
				findskillid[v[1]] = 1
				table.remove(skills,i)
			end
		end
		local skillquicks = self.m_db.skillquicks
		for i=1,6 do
			if skillquicks[i] and findskillid[skillquicks[i]] == 1 then
				skillquicks[i] = 0
			end
		end
		技能逻辑.SendQuickQuery(self)
		self:CheckAttrLearn()
		self:SendTipsMsg(1, "#s16,#cffff00,成功删除技能")
		技能逻辑.SendSkillInfo(self)
	end
	return true
end

function 玩家对象类:检查杀死怪物(monid, clear)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	if self.killmonid == monid then
		if clear then
			self.killmonid = 0
		end
		return true
	else
		return false
	end
end

function 玩家对象类:检查玩家击杀()
	if self.killerid == nil then
		return false
	end
	local obj = 对象类:GetObj(self.killerid)
	if obj and obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then
		return true
	else
		return false
	end
end

function 玩家对象类:击杀者()
	if self.killerid == nil then
		return ""
	end
	local obj = 对象类:GetObj(self.killerid)
	if obj then
		return obj:GetName()
	else
		return ""
	end
end

function 玩家对象类:召唤宝宝(monid)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	if self.m_nSceneID == -1 then
		return
	end
	local ox,oy = self:GetPosition()
	local m = 怪物对象类:CreateMonster(-1, monid, ox, oy, self.id)
	m.teamid = self.teamid
	m:EnterScene(self.m_nSceneID, m.bornx, m.borny)
	m.relivetime = -1
	self.calllen = (self.calllen or 0) + 1
	m.callid = self.calllen
	self.call[self.calllen] = m
	local nX, nY = 实用工具.GetRandPos(ox, oy, 200, m.Is2DScene, m.MoveGridRate)
	m:MoveTo(nX, nY)
	return true
end

function 玩家对象类:宝宝数量()
	local cnt = 0
	for k,v in pairs(self.call) do
		if v.relivetime == -1 then
			cnt = cnt + 1
		end
	end
	return cnt
end

function 玩家对象类:宝宝最高等级()
	local lv = 0
	for k,v in pairs(self.call) do
		if v.relivetime == -1 then
			lv = math.max(v:GetLv(), lv)
		end
	end
	return lv
end

function 玩家对象类:传送(mapid, mapx, mapy)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	return self:Transport(mapid, mapx, mapy)
end

function 玩家对象类:随机传送(mapid)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	return self:RandomTransport(mapid)
end

function 玩家对象类:获取名字()
	return self:GetName()
end

function 玩家对象类:获取等级()
	return self.m_db.level
end

function 玩家对象类:增长经验()
	return self.addexp or 0
end

function 玩家对象类:获取经验()
	return self.m_db.exp
end

function 玩家对象类:获取经验上限()
	local conf = 玩家属性表[self.m_db.level]
	if not conf then
		return 0
	end
	return conf.exp
end

function 玩家对象类:获取对面等级()
	return 0
end

function 玩家对象类:获取对面性别()
	return 0
end

function 玩家对象类:获取对面站位()
	return false
end

function 玩家对象类:当前地图ID()
	return self.m_db.mapid
end

function 玩家对象类:当前地图名字()
	local 地图配置 = 地图表[self.m_db.mapid]
	if 地图配置 then
		return 地图配置.name
	else
		return "无"
	end
end

function 玩家对象类:当前位置X()
	local x,y = self:GetPosition()
	return math.floor(x/60)
end

function 玩家对象类:当前位置Y()
	local x,y = self:GetPosition()
	return math.floor(y/40)
end

function 玩家对象类:获取账号()
	return self:GetAccount()
end

function 玩家对象类:获取IP()
	return self.m_db.ip
end

function 玩家对象类:获取会员等级()
	return self.m_db.vip等级
end

function 玩家对象类:获取声望值()
	return self.m_db.声望值
end

function 玩家对象类:获取金刚石()
	return self.m_db.金刚石
end

function 玩家对象类:获取灵符数()
	return self.m_db.灵符数
end

function 玩家对象类:获取转生等级()
	return self.m_db.转生等级
end

function 玩家对象类:是否付费()
	return self.m_db.总充值 > 0
end

--背包
function 玩家对象类:背包空格数()
	return 背包逻辑.GetEmptyIndexCount(self)
end

function 玩家对象类:是否穿戴(equippos)
	return self.m_db.bagdb.equips[equippos] ~= nil
end

--背包
function 玩家对象类:检查物品数量(itemid, count)
	itemid = 获取物品名字ID(itemid)
	if itemid == 0 then
		return
	end
	if count == 0 and 背包DB.CheckCount(self, itemid) > 0 then
		return false
	end
	if 背包DB.CheckCount(self, itemid) < count then
		return false
	end
	return true
end

--背包
function 玩家对象类:检查穿戴类型(equippos)
	return 0
end

function 玩家对象类:获取金币()
	return 公共定义.使用绑定货币 == 1 and self.m_db.bindmoney or self.m_db.money
end

function 玩家对象类:获取元宝()
	return 公共定义.使用绑定货币 == 1 and self.m_db.bindrmb or self.m_db.rmb
end

function 玩家对象类:获取泡点数()
	return self.m_db.泡点数
end

function 玩家对象类:检查属性点数()
	local 点数 = 0
	for k,v in pairs(self.m_db.转生加点) do
		点数 = 点数 + v
	end
	return 点数
end

function 玩家对象类:检查技能等级(skillinfoid)
	for i,v in ipairs(self.m_db.skills) do
		if v[1] == skillinfoid then
			return v[2]
		end
	end
	return 0
end

function 玩家对象类:是否在地图(mapid)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	return self.m_db.mapid == mapid
end

function 玩家对象类:检查附加属性(equippos,proptype)
	if self.m_db.bagdb.equips[equippos] == nil or
		self.m_db.bagdb.equips[equippos].wash == nil then
		return 0
	end
	for i,v in ipairs(self.m_db.bagdb.equips[equippos].wash) do
		if v[1] == proptype then
			return v[2]
		end
	end
	return 0
end

function 玩家对象类:检查附加总和(equippos,extype)
	if self.m_db.bagdb.equips[equippos] == nil or
		self.m_db.bagdb.equips[equippos].wash == nil then
		return 0
	end
	local cnt = 0
	for i,v in ipairs(self.m_db.bagdb.equips[equippos].wash) do
		if extype and 公共定义.属性文字[v[1]] == nil then
			cnt = cnt + v[2]
		elseif not extype and 公共定义.属性文字[v[1]] then
			cnt = cnt + v[2]
		end
	end
	return cnt
end

function 玩家对象类:装备附加属性(equippos,proptype,val)
	if self.m_db.bagdb.equips[equippos] == nil then
		return false
	end
	self.m_db.bagdb.equips[equippos].wash = self.m_db.bagdb.equips[equippos].wash or {}
	local index = nil
	for i,v in ipairs(self.m_db.bagdb.equips[equippos].wash) do
		if v[1] == proptype then
			v[2] = math.max(1,val)
			index = i
			break
		end
	end
	if index == nil then
		self.m_db.bagdb.equips[equippos].wash[#self.m_db.bagdb.equips[equippos].wash+1] = {proptype,math.max(1,val)}
	end
	self:CalcDynamicAttr()
	背包逻辑.SendEquipQuery(self, {equippos})
end

function 玩家对象类:获取职业()
	return self.m_db.job
end

function 玩家对象类:是否有英雄()
	return self.英雄 ~= nil
end

function 玩家对象类:获取英雄等级()
	return self.m_db.英雄等级
end

function 玩家对象类:获取英雄性别()
	return self.m_db.英雄性别
end

function 玩家对象类:获取英雄职业()
	return self.m_db.英雄职业
end

function 玩家对象类:获取英雄PK值()
	return self.m_db.英雄PK值
end

function 玩家对象类:获取英雄忠诚度()
	return self.m_db.英雄忠诚度
end

function 玩家对象类:获取英雄名字()
	return self.英雄 and self:GetName().."的英雄" or "无"
end

function 玩家对象类:是否在范围(mapid,x,y,range)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	if self.m_db.mapid ~= mapid then
		return false
	end
	local px,py = self:GetPosition()
	return px >= x*60-range*60 and px <= x*60+range*60 and py >= y*40-range*40 and py <= y*40+range*40
end

function 玩家对象类:检查宝宝距离(monid, dist)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	local obj = nil
	for k,v in pairs(self.call) do
		if v.relivetime == -1 and v.m_nMonsterID == monid then
			obj = v
			break
		end
	end
	if obj == nil or self.m_nSceneID ~= obj.m_nSceneID then
		return false
	end
	local px,py = self:GetPosition()
	local x,y = obj:GetPosition()
	return 实用工具.GetDistance(x,y,px,py,obj.Is2DScene,obj.MoveGridRate) <= dist*48
end

function 玩家对象类:检查装备升级(equippos)
	if self.m_db.bagdb.equips[equippos] == nil or
		self.m_db.bagdb.equips[equippos].wash == nil then
		return 0
	end
	local cnt = 0
	for i,v in ipairs(self.m_db.bagdb.equips[equippos].wash) do
		cnt = cnt + v[2]
	end
	return cnt
end

function 玩家对象类:检查装备名字(equippos)
	if self.m_db.bagdb.equips[equippos] == nil then
		return "无"
	end
	return 物品逻辑.GetItemName(self.m_db.bagdb.equips[equippos].id)
end

function 玩家对象类:获取PK模式()
	return self.m_db.pkmode
end

function 玩家对象类:获取荣誉值()
	return self.m_db.荣誉值
end

function 玩家对象类:获得物品(itemid, count)
	itemid = 获取物品名字ID(itemid)
	if itemid == 0 then
		return
	end
	local conf = 物品表[id]
	if conf and conf.usecnt > 1 then
		count = conf.usecnt*count
	end
	local indexs = self:PutItemGrids(itemid, count, 1, true) or {}
	if itemid ~= 公共定义.金币物品ID and itemid ~= 公共定义.元宝物品ID and #indexs == 0 then
		self:SendTipsMsg(1,"背包不足")
		return
	end
	if #indexs > 0 then
		背包逻辑.SendBagQuery(self, indexs)
	end
	if itemid == 公共定义.金币物品ID then
		self:SendTipsMsg(2, "获得绑定金币#cffff00,"..count)
	elseif itemid == 公共定义.元宝物品ID then
		self:SendTipsMsg(2, "获得绑定元宝#cffff00,"..count)
	else
		self:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(itemid)]..物品逻辑.GetItemName(itemid)..(count > 1 and "x"..count or ""))
	end
	return true
end

function 玩家对象类:收回物品(itemid, count)
	itemid = 获取物品名字ID(itemid)
	if itemid == 0 then
		return
	end
	if itemid == 公共定义.金币物品ID then
		self:DecMoney(count, true)
		return true
	elseif itemid == 公共定义.元宝物品ID then
		self:DecRmb(count, true)
		return true
	end
	if 背包DB.CheckCount(self, itemid) < count then
		self:SendTipsMsg(1,物品逻辑.GetItemName(itemid).."不足")
		return
	end
	背包DB.RemoveCount(self, itemid, count)
	return true
end

function 玩家对象类:显示对话(objid, sayret)
	Npc对话逻辑.ShowTalkInfo(self, objid, sayret)
	return true
end

function 玩家对象类:检查分身数()
	return false
end

function 玩家对象类:是否仓库锁定()
	return false
end

function 玩家对象类:仓库解锁次数()
	return 0
end

function 玩家对象类:获取会员类型()
	return self.m_db.vip类型
end

function 玩家对象类:检查会员时间()
	return 0xffffff
end

function 玩家对象类:检查取下装备()
	return self.takeoffid and 物品逻辑.GetItemName(self.takeoffid) or "无"
end

function 玩家对象类:检查组队人数()
	if self.teamid ~= 0 and 队伍管理.TeamList[self.teamid] then
		return #队伍管理.TeamList[self.teamid]
	end
	return 0
end

function 玩家对象类:是否队长()
	if self.teamid ~= 0 and 队伍管理.TeamList[self.teamid] then
		return self == 队伍管理.TeamList[self.teamid][1]
	end
	return false
end

function 玩家对象类:是否有行会()
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		return true
	end
	return false
end

function 玩家对象类:是否行会成员(guildname)
	local guild = 行会管理.GuildList[guildname]
	if guild and guild.member[self:GetName()] then
		return true
	end
	return false
end

function 玩家对象类:是否会长()
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		local guild = 行会管理.GuildList[self.m_db.guildname]
		if guild.chairman == self:GetName() then
			return true
		end
	end
	return false
end

function 玩家对象类:获取行会名称()
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		return self.m_db.guildname
	end
	return "无"
end

function 玩家对象类:获取行会职位()
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		local member = 行会管理.GuildList[self.m_db.guildname].member[self:GetName()]
		if member then
			return 行会定义.ZHIWEI_NAME[member[1]] or "无"
		end
	end
	return "无"
end

function 玩家对象类:获取行会人数()
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		local guild = 行会管理.GuildList[self.m_db.guildname]
		return guild.num
	end
	return 0
end

function 玩家对象类:是否城堡成员(castleid)
	if castleid == nil or castleid == 0 then
		castleid = 3
	end
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		local castle = 城堡管理.CastleList[castleid]
		if castle and castle.guild == self.m_db.guildname then
			return true
		end
	end
	return false
end

function 玩家对象类:是否城主(castleid)
	if castleid == nil or castleid == 0 then
		castleid = 3
	end
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		local castle = 城堡管理.CastleList[castleid]
		if castle and castle.guild == self.m_db.guildname then
			return 行会管理.GuildList[self.m_db.guildname].chairman == self:GetName()
		end
	end
	return false
end

function 玩家对象类:是否重叠()
	return false
end

function 玩家对象类:检查祝福罐数量()
	return 0
end

function 玩家对象类:检查攻击怪物()
	return self.hitmonid or 0
end

function 玩家对象类:检查被踢次数()
	return 0
end

function 玩家对象类:检测伤害吸收()
	return self.m_db.伤害吸收
end

function 玩家对象类:英雄伤害吸收()
	return self.m_db.英雄伤害吸收
end

function 玩家对象类:检查无限仓库()
	return 0
end

function 玩家对象类:检查攻城区域()
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		if 城堡管理.MoveAttackMap(human, human.m_db.guildname, true) then
			return true
		end
	end
	return false
end

function 玩家对象类:检查宝石升级(pos,itemid)
	itemid = 获取物品名字ID(itemid)
	if itemid == 0 then
		return
	end
	if pos == 1 and self.stoneupgrade1 == itemid then
		return true
	end
	if pos == 0 and self.stoneupgrade0 == itemid then
		return true
	end
	return false
end

function 玩家对象类:检查装备绑定(equippos)
	if self.m_db.bagdb.equips[equippos] == nil then
		return false
	end
	return self.m_db.bagdb.equips[equippos].bind == 1
end

function 玩家对象类:检查装备颜色(equippos,proptype)
	if self.m_db.bagdb.equips[equippos] == nil then
		return false
	end
	return self.m_db.bagdb.equips[equippos].color or 物品逻辑.GetItemColor(self.m_db.bagdb.equips[equippos].id)
end

function 玩家对象类:检查矿石纯度(itemid,value)
	itemid = 获取物品名字ID(itemid)
	if itemid == 0 then
		return 0
	end
	return 0
end

function 玩家对象类:检查装备持久(equippos,mode)
	return 0
end

function 玩家对象类:检查记录坐标(recordid)
	return self.m_db.记录坐标[recordid] ~= nil
end

function 玩家对象类:检查验证码()
	return false
end

function 玩家对象类:开启怪物宝箱(monid)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	local monconf = 怪物表[monid]
	if monconf and #monconf.drop > 0 then
		for i,v in ipairs(monconf.drop) do
			local 物品掉率 = (mapconf and mapconf.maptype == 1) and v[3]*(1+self.m_db.vip等级/10) or v[3]
			if math.random(1,10000) <= 物品掉率 then
				local grade = nil
				if 物品逻辑.GetItemType1(v[1]) == 3 and monconf.type <= 2 then
					grade = math.random(1,10000)
					local 极品爆率 = 100*(1+self.m_db.vip等级/10)
					if self.m_db.bagdb.equips[10] and self.m_db.bagdb.equips[10].count > 0 then
						极品爆率 = 极品爆率 + 物品逻辑.GetItemBodyID(self.m_db.bagdb.equips[10].id)
					end
					if self.英雄 and self.英雄.m_db.bagdb.equips[10] and self.英雄.m_db.bagdb.equips[10].count > 0 then
						极品爆率 = 极品爆率 + 物品逻辑.GetItemBodyID(self.英雄.m_db.bagdb.equips[10].id)
					end
					if monconf.type == 2 and monconf.level < 100 then
						grade = grade <= 极品爆率 and 5 or grade <= 1000 and 4 or grade <= 3000 and 3 or grade <= 6000 and 2 or 1
					elseif monconf.type == 1 and monconf.level < 100 then
						grade = grade <= 极品爆率 and 4 or grade <= 1000 and 3 or grade <= 4000 and 2 or 1
					else
						grade = grade <= 极品爆率 and 3 or grade <= 1000 and 2 or 1
					end
					grade = math.min(grade, 公共定义.装备掉落品质)
				end
				local itemx, itemy = self:GetPosition()
				local 物品 = 物品对象类:CreateItem(-1, self.id, v[1], v[2], itemx, itemy, grade)--v[4], v[5])
				if 物品==nil then
					print("null itemid: ",v[1])
					break
				end
				物品.teamid = self.teamid
				物品:EnterScene(obj.m_nSceneID, itemx, itemy)
				拾取物品逻辑.SendPickItem(self, 物品.id)
			end
		end
	end
end

function 玩家对象类:在线获得经验(persec,addexp,safearea,mapid)
	self.在线经验 = addexp
	self.在线经验秒 = persec
	self.在线经验时间 = _CurrentTime() + persec*1000
	self.在线经验地图 = mapid
	self.在线经验安全区 = safearea
end

function 玩家对象类:设置名字(val)
	self.nametitle = val
	self:ChangeName()
	self:UpdateObjInfo()
end

function 玩家对象类:更改发型(val)
end

function 玩家对象类:更改名字颜色(val)
	self.namecolor = val
end

function 玩家对象类:获取属性点(val)
	return self.m_db.属性点数
end

function 玩家对象类:调整属性点(val)
	self.m_db.属性点数 = math.max(0, val)
	self:SendPropAddPoint()
end

function 玩家对象类:调整技能等级(skillinfoid,val)
	local conf = 技能信息表[infoid]
	if not conf then
		return
	end
	local hero = 0
	local skills = hero ~= 0 and self.m_db.英雄技能 or self.m_db.skills
	for i=#skills,1,-1 do
		local v = skills[i]
		if v[1] == skillinfoid then
			if v[2] == val then
				return
			else
				v[2] = math.max(1, val)
				break
			end
		end
	end
	if conf.passive == 1 then
		self:CheckAttrLearn()
	end
	self:SendTipsMsg(1, "#s16,#cffff00,成功升级#cff00,"..conf.name)
	技能逻辑.SendSkillInfo(self)
end

function 玩家对象类:调整会员等级(val)
	self.m_db.vip等级 = math.max(0, val)
end

function 玩家对象类:调整会员类型(val)
	self.m_db.vip类型 = math.max(0, val)
end

function 玩家对象类:增加药水属性(proptype, val, time)
	if not self.m_db.药水属性[proptype] then
		self.m_db.药水属性[proptype] = {val or 0, _CurrentOSTime()+time*1000}
	else
		self.m_db.药水属性[proptype][1] = val or 0
		self.m_db.药水属性[proptype][2] = _CurrentOSTime()+time*1000
	end
	
	self:CalcDynamicAttr()
	return true
end

function 玩家对象类:增加状态技能()
	--[[
	1102	基础武学
	1104	护甲增强
	1107	活力
	
	1112	法术精通
	1114	铁甲
	1117	生命增强

	1122	棍法精通
	1130	元神增强
	]]
	local 攻击,攻击上限,魔法,魔法上限,防御,防御上限,魔御,魔御上限,几率 = 0,0,0,0,0,0,0,0,0
	
	for i,v in ipairs(self.m_db.skills) do
		local conf = 技能信息表[v[1]]
		if conf and 实用工具.FindIndex(conf.skill,1102) then
			几率 = 0.2
			攻击 = self:获取攻击() * 几率
			攻击上限 = self:获取攻击上限() * 几率
			
			self:增加药水属性(7,攻击,99999999)
			self:增加药水属性(8,攻击上限,99999999)
		elseif conf and 实用工具.FindIndex(conf.skill,1104) then
			几率 = 0.2
			防御 = self:获取防御() * 几率
			防御上限 = self:获取防御上限() * 几率
			
			self:增加药水属性(3,防御,99999999)
			self:增加药水属性(4,防御上限,99999999)
		elseif conf and 实用工具.FindIndex(conf.skill,1107) then
			self:增加药水属性(1,10,99999999)
		elseif conf and 实用工具.FindIndex(conf.skill,1112) then
			几率 = 0.6
			魔法 = self:获取魔法() * 几率
			魔法上限 = self:获取魔法上限() * 几率
			
			self:增加药水属性(9,魔法,99999999)
			self:增加药水属性(10,魔法上限,99999999)
		elseif conf and 实用工具.FindIndex(conf.skill,1114) then
			几率 = 0.4
			魔御 = self:获取魔御() * 几率
			魔御上限 = self:获取魔御上限() * 几率
			
			self:增加药水属性(5,魔御,99999999)
			self:增加药水属性(6,魔御上限,99999999)
		elseif conf and 实用工具.FindIndex(conf.skill,1117) then
			self:增加药水属性(1,75,99999999)
		elseif conf and 实用工具.FindIndex(conf.skill,1122) then
			几率 = 0.2
			攻击 = self:获取攻击() * 几率
			攻击上限 = self:获取攻击上限() * 几率
			
			self:增加药水属性(7,攻击,99999999)
			self:增加药水属性(8,攻击上限,99999999)
			
			魔法 = self:获取魔法() * 几率
			魔法上限 = self:获取魔法上限() * 几率
			
			self:增加药水属性(9,魔法,99999999)
			self:增加药水属性(10,魔法上限,99999999)
		end
	end
end



function 玩家对象类:管理模式(proptype,val,time)
	if not self.管理属性[proptype] then
		self.管理属性[proptype] = {val, time>0 and _CurrentTime()+time*1000 or 0}
	else
		self.管理属性[proptype][1] = val
		self.管理属性[proptype][2] = time>0 and _CurrentTime()+time*1000 or 0
	end
	if proptype == 公共定义.额外属性_潜行 then
		if val > 0 then
			技能逻辑.DoAddBuff(self, -1, 公共定义.潜行BUFF, time)
		elseif self.buffend[公共定义.潜行BUFF] then
			技能逻辑.DoRemoveBuff(self, 公共定义.潜行BUFF)
		end
	end
	self:CalcDynamicAttr()
end

function 玩家对象类:管理权限(val)
end

function 玩家对象类:设置经验倍数(val1,val2)
	self.经验倍数 = val1
	self.经验倍数时间 = _CurrentTime() + val2*1000
end

function 玩家对象类:设置攻击倍数(val1,val2)
	self.攻击倍数 = val1
	self.攻击倍数时间 = _CurrentTime() + val2*1000
end

function 玩家对象类:清除仓库密码()
end

function 玩家对象类:清除结婚信息()
end

function 玩家对象类:设置转生(val1,val2,val3)
	self.m_db.转生等级 = self.m_db.转生等级 + val1
	if val2 > 0 then
		self.m_db.level = math.max(1, val2)
	end
	self.m_db.属性点数 = self.m_db.属性点数 + val3
	self:CheckAttrLearn()
	self:SendPropAddPoint()
	self:SendTipsMsg(1,"#cffff00,转生成功")
end

function 玩家对象类:装备属性升级(equippos,proptype,val1,val2,val3)
	if self.m_db.bagdb.equips[equippos] == nil then
		return 0
	end
	local fail = false
	if math.random(1,100) <= val1 then
		fail = true
		if val3 == 1 then
			self.m_db.bagdb.equips[equippos] = nil
			self:CalcDynamicAttr()
			背包逻辑.SendEquipQuery(self, {equippos})
			self:SendTipsMsg(1,"#cff0000,装备升级失败,武器已破碎")
		else
			self:SendTipsMsg(1,"#cffff00,装备升级失败")
		end
	end
	self.m_db.bagdb.equips[equippos].wash = self.m_db.bagdb.equips[equippos].wash or {}
	local index = nil
	for i,v in ipairs(self.m_db.bagdb.equips[equippos].wash) do
		if v[1] == proptype then
			v[2] = v[2] + math.max(1,val2)
			index = i
			break
		end
	end
	if index == nil then
		self.m_db.bagdb.equips[equippos].wash[#self.m_db.bagdb.equips[equippos].wash+1] = {proptype,math.max(1,val2)}
	end
	self:CalcDynamicAttr()
	背包逻辑.SendEquipQuery(self, {equippos})
	self:SendTipsMsg(1,"#cff00,装备升级成功")
end

function 玩家对象类:重置属性点()
	self.m_db.转生加点 = {}
	self:CheckAttrLearn(false)
	self:SendDetailAttr()
	self:SendTipsMsg(1,"#cffff00,重置属性点成功")
	self:SendPropAddPoint()
end

function 玩家对象类:组队地图传送(mapid,x,y)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	if self.teamid ~= 0 and 队伍管理.TeamList[self.teamid] then
		for i,v in ipairs(队伍管理.TeamList[self.teamid]) do
			if x ~= -1 and y ~= -1 then
				v:Transport(mapid, x, y)
			else
				v:RandomTransport(mapid)
			end
		end
	end
end

function 玩家对象类:行会地图传送(mapid,x,y)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	if self.m_db.guildname ~= "" and 行会管理.GuildList[self.m_db.guildname] then
		local guild = 行会管理.GuildList[self.m_db.guildname]
		for k,v in pairs(guild.member) do
			local human = 在线玩家管理[k]
			if human then
				if x ~= -1 and y ~= -1 then
					human:Transport(mapid, x, y)
				else
					human:RandomTransport(mapid)
				end
			end
		end
	end
end

function 玩家对象类:获取属性值(proptype)
	return self.在线属性[proptype] or 0
end

function 玩家对象类:调整属性值(proptype,val)
	self.在线属性[proptype] = math.max(0, val)
	self:CalcDynamicAttr()
end

function 玩家对象类:是否安全区()
	return self.insafearea
end

function 玩家对象类:离线挂机(persec,addexp,kicktime)
	if not self.insafearea then
		self:回城()
	end
	self.是否离线挂机 = 1
	self:在线获得经验(persec,addexp,1,nil)
	if kicktime > 0 then
		self.离线挂机时间 = _CurrentTime() + kicktime*1000
	end
	self:踢下线()
end

function 玩家对象类:输入验证码()
end

function 玩家对象类:记录坐标(recordid,val)
	if val == 1 then
		if not 场景管理.GetIsCopy(self.m_db.mapid) then
			local x, y = self:GetPosition()
			self.m_db.记录坐标[recordid] = {self.m_db.mapid, x, y}
		end
	else
		self.m_db.记录坐标[recordid] = nil
	end
end

function 玩家对象类:传送坐标(recordid)
	if self.m_db.记录坐标[recordid] then
		self:传送(self.m_db.记录坐标[recordid][1],
			self.m_db.记录坐标[recordid][2],
			self.m_db.记录坐标[recordid][3])
	end
end

function 玩家对象类:特修身上装备()
end

function 玩家对象类:自动穿戴装备(itemid)
	itemid = 获取物品名字ID(itemid)
	if itemid == 0 then
		return
	end
	local itconf = 物品表[itemid]
	if itconf and itconf.type1 == 3 and itconf.type2 ~= 14 then
		local bagdb = self.m_db.bagdb
		local grid = nil
		local pos = 0
		for k,v in pairs(bagdb.baggrids) do
			if v.id == itemid then
				grid = v
				pos = k
				break
			end
		end
		if grid then
			local equippos = itconf.type2
			local hero = 0
			if equippos == 5 then
				if bagdb.equips[5] == nil or bagdb.equips[5].count == 0 then
				elseif bagdb.equips[14] == nil or bagdb.equips[14].count == 0 then
					equippos = 14
				elseif 物品逻辑.GetItemLevel(bagdb.equips[5].id) > 物品逻辑.GetItemLevel(bagdb.equips[14].id) then
					equippos = 14
				end
			elseif equippos == 6 then
				if bagdb.equips[6] == nil or bagdb.equips[6].count == 0 then
				elseif bagdb.equips[15] == nil or bagdb.equips[15].count == 0 then
					equippos = 15
				elseif 物品逻辑.GetItemLevel(bagdb.equips[6].id) > 物品逻辑.GetItemLevel(bagdb.equips[15].id) then
					equippos = 15
				end
			end
			local indexs = {pos}
			local posnew = nil
			bagdb.baggrids[pos] = nil
			posnew = self:PutEquip(equippos, grid.id, grid.grade, grid.strengthen, grid.wash, grid.attach, grid.gem, grid.ringsoul, hero == 1, grid.bind)
			if posnew ~= nil then
				if hero == 1 then
					self:SendEquipView(self.英雄, true)
				else
					背包逻辑.SendEquipQuery(self, {equippos})
				end
			else
				bagdb.baggrids[pos] = grid
			end
			if posnew ~= nil and posnew ~= 0 then
				--indexs[#indexs+1] = posnew
				背包逻辑.InsertIndexes(indexs, posnew)
			end
			背包逻辑.SendBagQuery(self, indexs)
		end
	end
end

function 玩家对象类:加入行会(guildname)
	if self.m_db.guildname == "" and 行会管理.GuildList[guildname] then
		local guild = 行会管理.GuildList[guildname]
		if guild.member[self:GetName()] == nil then
			local zhanli = human:CalcPower()
			guild.zhanli = guild.zhanli + zhanli
			guild.member[self:GetName()] = {行会定义.GUILD_ZHIWEI_MEMBER,0,zhanli,human.m_db.job,human:GetLevel(),human.m_db.转生等级}
			guild.num = guild.num + 1
			guild:Save()
		end
	end
end

function 玩家对象类:改变衣服特效(val)
end

function 玩家对象类:召唤分身(sectime)
end

function 玩家对象类:传送指定玩家(humanname)
	if humanname == self:GetName() then
		return
	end
	local human = 在线玩家管理[humanname]
	if not human or 场景管理.GetIsCopy(human.m_db.mapid) then
		return
	end
	local x, y = human:GetPosition()
	self:传送(human.m_db.mapid, x, y)
end

function 玩家对象类:杀死宝宝(monid, num)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	local cnt = 0
	for k,v in pairs(self.call) do
		if v.relivetime == -1 and v.m_nMonsterID == monid then
			v:Destroy()
			cnt = cnt + 1
			if cnt == num then
				return true
			end
		end
	end
	return true
end

function 玩家对象类:宝宝叛变(monid)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	for k,v in pairs(self.call) do
		if v.relivetime == -1 and v.m_nMonsterID == monid then
			v:ResetOwner(-1)
		end
	end
	return true
end

function 玩家对象类:改变装备持久(val1,val2)
end

function 玩家对象类:减少祝福罐物品()
end

function 玩家对象类:取出祝福罐物品()
end

function 玩家对象类:增加物品限次(val)
end

function 玩家对象类:恢复发言()
end

function 玩家对象类:取下装备(equippos)
	local posnew = 背包DB.PutEquip(self, equippos, 0)
	if posnew ~= nil then
		背包逻辑.SendEquipQuery(self, {equippos})
	end
	if posnew ~= nil and posnew ~= 0 then
		背包逻辑.SendBagQuery(self, {posnew})
	end
end

function 玩家对象类:设置HP(val)
	self:RecoverHP(val-self.hp)
end

function 玩家对象类:设置MP(val)
	self:RecoverMP(val-self.mp)
end

function 玩家对象类:获取在线属性(proptype)
	return self.在线属性[proptype] or 0
end

function 玩家对象类:调整在线属性(proptype, val)
	self.在线属性[proptype] = math.max(0, val)
	self:CalcDynamicAttr()
end

function 玩家对象类:调整英雄等级(val)
	if not self.英雄 then
		return
	end
	local oldlevel = self.英雄.m_db.level
	self.英雄.m_db.level = math.max(0, val)
	self.英雄.m_db.exp = 0
	if self.英雄.m_db.level ~= oldlevel then
		self.英雄:LevelUp()
	end
	self.英雄:SendActualAttr()
	self:SendEquipView(self.英雄, true)
end

function 玩家对象类:创建英雄(job, sex)
	if self.m_db.英雄职业 ~= 0 then
		self:SendTipsMsg(1,"你已经有英雄了")
		return
	else
		self.m_db.英雄职业 = job
		self.m_db.英雄性别 = sex
		self:召唤英雄()
		玩家事件处理.OnXpPrepare(-1, self.id)
		return
	end
end

function 玩家对象类:删除英雄()
end

function 玩家对象类:调整英雄职业(val)
	return self:ChangeJob(val, true)
end

function 玩家对象类:调整英雄PK值(val)
	if not self.英雄 then
		return
	end
	self.m_db.英雄PK值 = math.max(0, val)
end

function 玩家对象类:清除英雄技能()
	if not self.英雄 then
		return
	end
	local hero = 1
	local skills = hero ~= 0 and self.m_db.英雄技能 or self.m_db.skills
	for i=#skills,1,-1 do
		local conf = 技能信息表[v[1]]
		if conf == nil or conf.special ~= 0 then
		else
			table.remove(skills,i)
		end
	end
	self:CheckAttrLearn(true)
	self:SendTipsMsg(1, "#s16,#cffff00,成功删除技能")
	技能逻辑.SendSkillInfo(self)
end

function 玩家对象类:获取伤害吸收()
	return 0
end

function 玩家对象类:伤害吸收(val1,val2,val3)
end

function 玩家对象类:获取英雄伤害吸收()
	return 0
end

function 玩家对象类:英雄伤害吸收(val1,val2,val3)
end

function 玩家对象类:对面人物名字()
	return "无"
end

function 玩家对象类:获取无限仓库数量()
	return 0
end

function 玩家对象类:无限仓库数量()
	return "无"
end

function 玩家对象类:播放声音(val)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_COMMAND_MSG]
	oReturnMsg.type = 2
	oReturnMsg.msg = val
	消息类.SendMsg(oReturnMsg, self.id)
end

function 玩家对象类:播放特效(effid, playcnt, x, y, broadcast)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_COMMAND_MSG]
	oReturnMsg.type = 3
	oReturnMsg.msg = effid..","..playcnt..","..x..","..y
	if broadcast then
		消息类.ZoneBroadCast(oReturnMsg, self.id)
	else
		消息类.SendMsg(oReturnMsg, self.id)
	end
end

function 玩家对象类:调整宝宝等级(monid, val)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
end

function 玩家对象类:打开大对话框(val)
end

function 玩家对象类:穿人模式(val1,val2)
end

function 玩家对象类:关闭大对话框(val)
end

function 玩家对象类:调整英雄忠诚度(val)
end

function 玩家对象类:显示卧龙书页()
	local call = 事件触发._M["call_卧龙书页"]
	if call then
		human:显示对话(-2,call(human))
	end
end

function 玩家对象类:开启物品宝箱(val)
end

function 玩家对象类:强制攻击模式(val)
end

function 玩家对象类:装备发光(equippos,val)
end

function 玩家对象类:自动寻路(x,y)
end

function 玩家对象类:显示称号(pos,val,x,y)
	if pos < 0 or pos > 3 then
		return
	end
	for i=1,#self.titles,4 do
		if self.titles[i] == pos then
			self.titles[i+1] = val
			self.titles[i+2] = x
			self.titles[i+3] = y
			self:ChangeName()
			self:UpdateObjInfo()
			return
		end
	end
	
	self.titles[#self.titles+1] = pos
	self.titles[#self.titles+1] = val
	self.titles[#self.titles+1] = x
	self.titles[#self.titles+1] = y
	self:ChangeName()
	self:UpdateObjInfo()
end

function 玩家对象类:获取称号()
	local 称号 = ""
	
	for i,v in ipairs(self.titles) do
		称号 = 称号..v
	end
	
	
	
	for i=1,#self.titles,4 do
		--称号 = 称号..self.titles[i+1].."-"..self.titles[i+2].."-"..self.titles[i+3]
	end
	
	return 称号
end

function 玩家对象类:宝石升级失败()
	self.stoneupgradefail = true
end

function 玩家对象类:装备改名(equippos,val)
end

function 玩家对象类:装备绑定(equippos,val)
	if self.m_db.bagdb.equips[equippos] == nil then
		return false
	end
	self.m_db.bagdb.equips[equippos].bind = val
end

function 玩家对象类:调整荣誉值(val)
	self.m_db.荣誉值 = math.max(0, val)
end

function 玩家对象类:调整金刚石(val)
	self.m_db.金刚石 = math.max(0, val)
end

function 玩家对象类:调整灵符数(val)
	self.m_db.灵符数 = math.max(0, val)
end

function 玩家对象类:开通元宝交易()
end

function 玩家对象类:调整装备颜色(equippos,val)
	if self.m_db.bagdb.equips[equippos] == nil then
		return false
	end
	self.m_db.bagdb.equips[equippos].color = val
end

function 玩家对象类:收回英雄()
end

function 玩家对象类:商城价格比例(val)
end

function 玩家对象类:改变宝宝颜色(monid,val)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
end

function 玩家对象类:打开网站(val)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_COMMAND_MSG]
	oReturnMsg.type = 1
	oReturnMsg.msg = val
	消息类.SendMsg(oReturnMsg, self.id)
end

function 玩家对象类:领取充值()
	if Config.CATCH_PAY_GAME ~= "" then
		for i,v in ipairs(后台事件处理.CatchPayQuery) do
			if v == self:GetAccount() then
				return
			end
		end
		后台事件处理.CatchPayQuery[#后台事件处理.CatchPayQuery+1] = self:GetAccount()
	end
end

function 玩家对象类:打开物品投放(val)
	self.openitemindex = val
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_COMMAND_MSG]
	oReturnMsg.type = 4
	oReturnMsg.msg = "请放入你需要投放的物品"
	消息类.SendMsg(oReturnMsg, self.id)
end

function 玩家对象类:打开宝石升级()
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_COMMAND_MSG]
	oReturnMsg.type = 5
	oReturnMsg.msg = "上格放入装备,下两格放入宝石和幸运石"
	消息类.SendMsg(oReturnMsg, self.id)
end

function 玩家对象类:聊天文字颜色(sectime,val)
	self.chatcolor = string.format("#c%x,",val)
	self.chatcolortime = _CurrentTime() + sectime*1000
end

function 玩家对象类:探测玩家(humanname)
	local human = 在线玩家管理[humanname]
	if human then
		聊天逻辑.发送玩家聊天("#cffff00,["..humanname.."]在["..human:当前地图名字().."]的["..human:当前位置X()..","..human:当前位置Y().."]", 0, self)
	else
		聊天逻辑.发送玩家聊天("#cff0000,玩家不在线,无法探测对方", 0, self)
	end
end

function 玩家对象类:设置游戏速度(val1,val2,val3)
end

function 玩家对象类:清除宝石属性(equippos)
	if self.m_db.bagdb.equips[equippos] == nil or
		self.m_db.bagdb.equips[equippos].wash == nil then
		return 0
	end
	实用工具.DeleteTable(self.m_db.bagdb.equips[equippos].wash)
	self:CalcDynamicAttr()
end

function 检查城堡攻城(castleid)
	if castleid == nil or castleid == 0 then
		castleid = 3
	end
	local castle = 城堡管理.CastleList[castleid]
	if castle then
		local isoneday = 实用工具.IsInOneDay(castle.attacktime)
		if not isoneday then
			return false
		end
		local dt = os.date("*t")
		local mintime1 = dt.hour * 60 + dt.min
		local mintime2 = 公共定义.攻城时间[1] * 60 + 公共定义.攻城时间[2]
		if mintime1 < mintime2 or mintime1 > mintime2 + 公共定义.攻城时间[3] then
			return false
		end
		return true
	end
	return false
end

function 随机杀死怪物(mapid,monid,cnt)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
end

function SortHumanVar1(v1, v2)
	local n1 = tonumber(v1:sub(v1:find(":")+1)) or 0
	local n2 = tonumber(v2:sub(v2:find(":")+1)) or 0
	if n1 ~= n2 then
		return n1 < n2
	else
		return false
	end
end

function SortHumanVar2(v1, v2)
	local n1 = tonumber(v1:sub(v1:find(":")+1)) or 0
	local n2 = tonumber(v2:sub(v2:find(":")+1)) or 0
	if n1 ~= n2 then
		return n1 > n2
	else
		return false
	end
end

function 排序玩家变量(datafile, str, sortmode, savefile, savemode)
	if str == nil or str == "" then
		return
	end
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	local outfilename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..savefile)
	local outstrs = {}
	local isfind = false
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			if v:sub(1,1) == "[" then
				outstrs[#outstrs+1] = v:sub(2,-2)..":0"
				isfind = true
			elseif isfind then
				local ss = 实用工具.SplitString(_GBK2UTF8(v), "=")
				if #ss == 2 and str == ss[1] then
					outstrs[#outstrs] = outstrs[#outstrs]:sub(1,outstrs[#outstrs]:find(":"))..(tonumber(ss[2]) or 0)
				end
			end
		end
	end
	if #outstrs > 1 then
		table.sort(outstrs, sortmode == 1 and SortHumanVar2 or SortHumanVar1)
	end
	实用工具.PrintToFile(outfilename, 实用工具.JoinString(outstrs, "\r\n"))
end

function 创建目录(val)
end

function 清理地图物品(mapid,mapx,mapy,range,itemid)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	itemid = 获取物品名字ID(itemid)
	if itemid == 0 then
		return
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if nSceneID == -1 then
		return
	end
	for k,v in pairs(物品管理) do
		if (itemid == -1 or v.m_nItemId == itemid) and v.m_nSceneID == nSceneID then
			local x,y = v:GetPosition()
			if x >= mapx*60-range*60 and x <= mapx*60+range*60 and y >= mapy*40-range*40 and y <= mapy*40+range*40 then
				v:Destroy()
			end
		end
	end
end

function 动态生成泉水(mapid,x,y,type)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
end

function 获取行会人数上限(guildname)
	return 0
end

function 调整行会人数上限(guildname,num)
end

function 移动怪物位置(monid,mapid,x,y,newx,newy)
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if not MonsterScene[nSceneID] then
		return
	end
	local cx,cy
	for i,v in pairs(MonsterScene[nSceneID]) do
		if v[2] == 1 then
			if v[1].movegridpos then
				cx,cy = v[1].movegridpos[1], v[1].movegridpos[2]
			else
				cx,cy = v[1]:GetPosition()
			end
			if math.floor(cx/60) == x and math.floor(cy/40) == y then
				v[1]:JumpScene(nSceneID,newx*60+30,newy*40+20)
			end
		elseif v[2] == 0 and v[1].hp > 0 then
			cx,cy = v[1].currx, v[1].curry
			if math.floor(cx/60) == x and math.floor(cy/40) == y then
				v[1].currx = newx*60+30
				v[1].curry = newy*40+20
			end
		end
	end
end

function 滚动公告广播(val,type,human)
	if type == 1 or not human then
		for _,v in pairs(在线玩家管理) do
			v:SendTipsMsg(4, val)
		end
	elseif type == 0 then
		human:SendTipsMsg(4, val)
	elseif type == 2 then
		if human.m_db.guildname ~= "" and 行会管理.GuildList[human.m_db.guildname] then
			local guild = 行会管理.GuildList[human.m_db.guildname]
			for k,v in pairs(guild.member) do
				local hum = 在线玩家管理[k]
				if hum then
					hum:SendTipsMsg(4, val)
				end
			end
		end
	elseif type == 3 then
	else
		for _,v in pairs(在线玩家管理) do
			if human.m_nSceneID ~= -1 and v.m_nSceneID == human.m_nSceneID then
				v:SendTipsMsg(4, val)
			end
		end
	end
end

定时中间公告 = 定时中间公告 or {}

function 中间公告广播(val,type,human,sectime,exec,start)
	if start and sectime > 0 then
		定时中间公告[#定时中间公告+1] = {val,type,human,sectime-1,exec}
	end
	val = val:gsub("%%d",sectime)
	if type == 1 or not human then
		for _,v in pairs(在线玩家管理) do
			v:SendTipsMsg(3, val)
		end
	elseif type == 0 then
		human:SendTipsMsg(3, val)
	elseif type == 2 then
		if human.m_db.guildname ~= "" and 行会管理.GuildList[human.m_db.guildname] then
			local guild = 行会管理.GuildList[human.m_db.guildname]
			for k,v in pairs(guild.member) do
				local hum = 在线玩家管理[k]
				if hum then
					hum:SendTipsMsg(3, val)
				end
			end
		end
	elseif type == 3 then
	else
		for _,v in pairs(在线玩家管理) do
			if human.m_nSceneID ~= -1 and v.m_nSceneID == human.m_nSceneID then
				v:SendTipsMsg(3, val)
			end
		end
	end
end

function 添加动态跳转(jumpid, mapid, x, y)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
end

function 设置动态跳转(jumpid, mapid, x, y)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
end

function 删除动态跳转(jumpid)
end

function 查看动态跳转(jumpid, type, retmapname, retmapx, retmapy)
end

function 修改地图名字(mapid, mapname)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
end

function 地图出现物品(mapid, x, y, range, itemid, cnt, expire)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if nSceneID == -1 then
		return
	end
	物品对象类:CreateItem(nSceneID, -1, itemid, cnt, x*60+30, y*40+20)
end

function 移动地图玩家(mapid, newmapid, x, y, range)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	newmapid = 获取地图名字ID(newmapid)
	if newmapid == 0 then
		return
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if nSceneID == -1 then
		return
	end
	for _,v in pairs(在线玩家管理) do
		if v.m_nSceneID == nSceneID then
			v:Transport(newmapid, x*60+30, y*40+20)
		end
	end
end

function 创建Npc(npcname, npcid, mapid, x, y)
	npcid = 获取Npc名字ID(npcid)
	if npcid == 0 then
		return
	end
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
end

function 删除Npc(npcname)
end

function 改变行会会长(guildname, humanname)
end

function 建立行会(guildname, humanname)
end

function 当晚行会攻城(guildname)
end

function 地图相同行会(mapid)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	return false
end

function 检查最高属性(type)
	return "无"
end

function 是否允许传送(mapid)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	return true
end

function 城堡城门状态(castleid)
	return 0
end

function 城堡战争天数(castleid)
	return 0
end

function 城堡占领天数(castleid)
	return 0
end

function 检查在线人数()
	local cnt = 0
	for _,v in pairs(在线玩家管理) do
		cnt = cnt + 1
	end
	return cnt
end

function 检查范围怪物数(mapid, x, y, range)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return 0
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if not MonsterScene[nSceneID] then
		return 0
	end
	local cnt = 0
	local cx,cy
	for i,v in pairs(MonsterScene[nSceneID]) do
		if v[2] == 1 then
			if v[1].movegridpos then
				cx,cy = v[1].movegridpos[1], v[1].movegridpos[2]
			else
				cx,cy = v[1]:GetPosition()
			end
			if cx >= x*60-range*60 and cx <= x*60+range*60 and cy >= y*40-range*40 and cy <= y*40+range*40 then
				cnt = cnt + 1
			end
		elseif v[2] == 0 and v[1].hp > 0 then
			cx,cy = v[1].currx, v[1].curry
			if cx >= x*60-range*60 and cx <= x*60+range*60 and cy >= y*40-range*40 and cy <= y*40+range*40 then
				cnt = cnt + 1
			end
		end
	end
	return cnt
end

function 检查地图怪物数(mapid, monid)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return 0
	end
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return 0
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if not MonsterScene[nSceneID] then
		return 0
	end
	local cnt = 0
	for i,v in pairs(MonsterScene[nSceneID]) do
		cnt = cnt + 1
	end
	return cnt
end

function 检查地图玩家数(mapid, x, y, range)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return 0
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	local cnt = 0
	local cx,cy
	for _,v in pairs(在线玩家管理) do
		if v.m_nSceneID == nSceneID then
			cx,cy = v:GetPosition()
			if cx >= x*60-range*60 and cx <= x*60+range*60 and cy >= y*40-range*40 and cy <= y*40+range*40 then
				cnt = cnt + 1
			end
		end
	end
	return cnt--场景管理.GetSceneObjCount(nSceneID, 公共定义.OBJ_TYPE_HUMAN)
end

function 清除地图怪物(mapid)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if not MonsterScene[nSceneID] then
		return
	end
	for i,v in pairs(MonsterScene[nSceneID]) do
		if v[1].relivetime == -1 then
			v[1]:Destroy()
		end
	end
	return true
end

function 地图刷怪(mapid, monid, count, px, py, range)
	mapid = 获取地图名字ID(mapid)
	if mapid == 0 then
		return
	end
	monid = 获取怪物名字ID(monid)
	if monid == 0 then
		return
	end
	local nSceneID = 场景管理.GetSceneId(mapid, true)
	if nSceneID == -1 then
		return
	end
	local cnt = 0
	while cnt < count do
		local x = px*60 + (range == 0 and 0 or math.random(-range*60, range*60))
		local y = py*40 + (range == 0 and 0 or math.random(-range*40, range*40))
		local MoveGrid = 场景管理.GetMoveGrid(mapid)
		if MoveGrid then
			x = math.floor(x / MoveGrid[1]) * MoveGrid[1] + MoveGrid[1]/2
			y = math.floor(y / MoveGrid[2]) * MoveGrid[2] + MoveGrid[2]/2
		end
		if _IsPosCanRun(nSceneID, x, y) then
			local m = 怪物对象类:CreateMonster(nSceneID, monid, x, y)
			m.relivetime = -1
			cnt = cnt + 1
		end
	end
	return true
end

function 最高等级玩家()
	local val = 1
	for _,v in pairs(在线玩家管理) do
		val = math.max(val, v:获取等级())
	end
	return val
end

function 最高PK值玩家()
	local val = 1
	for _,v in pairs(在线玩家管理) do
		val = math.max(val, v:获取PK值())
	end
	return val
end

function 最高攻击玩家()
	local val = 1
	for _,v in pairs(在线玩家管理) do
		val = math.max(val, v:获取攻击上限())
	end
	return val
end

function 最高魔法玩家()
	local val = 1
	for _,v in pairs(在线玩家管理) do
		val = math.max(val, v:获取魔法上限())
	end
	return val
end

function 最高道术玩家()
	local val = 1
	for _,v in pairs(在线玩家管理) do
		val = math.max(val, v:获取道术上限())
	end
	return val
end

function 全服广播(msg)
	聊天逻辑.SendSystemChat(msg)
	return true
end

function 开始提问(exec)
	local call = 登录触发._M["call_"..exec]
	if call then
		for _,v in pairs(在线玩家管理) do
			v:显示对话(-3,call(v))
		end
	end
end

function 开始执行(human, exec)
	local call = 登录触发._M["call_"..exec]
	if call then
		if human then
			human:显示对话(-3,call(human))
		end
	end
end

function 延时执行(human, msectime, exec, calltype)
	local call = nil
	if calltype == -2 then
		call = 事件触发._M["call_"..exec]
	elseif calltype == -3 then
		call = 登录触发._M["call_"..exec]
	elseif calltype == -4 then
		call = 定时触发._M["call_"..exec]
	else--if calltype == -1 then
		call = Npc触发._M["call_"..exec]
	end
	if call ~= nil then
		DelayCalls[#DelayCalls+1] = {_CurrentTime()+msectime, call, calltype, human}
	end
end

function 取消延时执行(human)
	for i=#DelayCalls,1,-1 do
		if DelayCalls[i][4] == human and DelayCalls[i][5] == nil then
			DelayCalls[i][2] = nil
			--table.remove(DelayCalls, i)
		end
	end
end

function 开启定时器(human, timerid, sectime)
	local call = 登录触发._M["call_定时器_"..timerid]
	if call ~= nil then
		DelayCalls[#DelayCalls+1] = {_CurrentTime()+sectime*1000, call, -3, human, timerid, sectime*1000}
	end
end

function 停止定时器(human, timerid)
	for i=#DelayCalls,1,-1 do
		if DelayCalls[i][4] == human and DelayCalls[i][5] == timerid then
			DelayCalls[i][2] = nil
			--table.remove(DelayCalls, i)
		end
	end
end

function 取随机字符(datafile, line)
	local strs = 实用工具.GetStrFromFile((__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile))
	if strs and #strs > 0 then
		if line then
			line = math.max(1, line)
			return (line > 0 and line <= #strs) and _GBK2UTF8(strs[line]) or ""
		else
			return _GBK2UTF8(strs[math.random(1,#strs)])
		end
	end
	return ""
end

function 取字符下标(datafile, str1)
	if str1 == nil or str1 == "" then
		return -1
	end
	local strs = 实用工具.GetStrFromFile((__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile))
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			if _GBK2UTF8(v) == str1 then
				return i-1
			end
		end
	end
	return -1
end

function 在文件列表(datafile, str1, str2)
	if str1 == nil or str1 == "" then
		return -1
	end
	local strs = 实用工具.GetStrFromFile((__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile))
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			if str2 then
				local ss = 实用工具.SplitString(_GBK2UTF8(v), " ")
				if #ss == 2 and str1 == ss[1] and str2 == ss[2] then
					return i-1
				end
			else
				if _GBK2UTF8(v) == str1 then
					return i-1
				end
			end
		end
	end
	return -1
end

function 清文件内容(datafile)
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	实用工具.PrintToFile(filename, "")
end

function 删文件内容(datafile, str1, str2)
	if str1 == nil or str1 == "" then
		return -1
	end
	local ret = -1
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			if str2 then
				local ss = 实用工具.SplitString(_GBK2UTF8(v), " ")
				if #ss == 2 and str1 == ss[1] then
					table.remove(strs, i)
					ret = i-1
					break
				end
			else
				if _GBK2UTF8(v) == str1 then
					table.remove(strs, i)
					ret = i-1
					break
				end
			end
		end
	end
	if ret ~= -1 then
		实用工具.PrintToFile(filename, 实用工具.JoinString(strs, "\r\n"))
	end
	return ret
end

function 插文件内容(datafile, str1, line)
	if str1 == nil or str1 == "" then
		return -1
	end
	local ret = -1
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	if line and line < #strs then
		table.insert(strs, line+1, REAL_CONVERT(str1))
		ret = line
	else
		strs[#strs+1] = str1
		ret = #strs-1
	end
	实用工具.PrintToFile(filename, 实用工具.JoinString(strs, "\r\n"))
	return ret
end

function 写文件内容(datafile, str1, str2)
	if str1 == nil or str1 == "" then
		return -1
	end
	local ret = -1
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			if str2 then
				local ss = 实用工具.SplitString(_GBK2UTF8(v), " ")
				if #ss == 2 and str1 == ss[1] then
					strs[i] = REAL_CONVERT(str1.." "..str2)
					ret = i-1
					break
				end
			else
				if _GBK2UTF8(v) == str1 then
					ret = i-1
					break
				end
			end
		end
	end
	if ret == -1 then
		if str2 then
			strs[#strs+1] = REAL_CONVERT(str1.." "..str2)
		else
			strs[#strs+1] = REAL_CONVERT(str1)
		end
		ret = #strs-1
	end
	实用工具.PrintToFile(filename, 实用工具.JoinString(strs, "\r\n"))
	return ret
end

function 读文件内容(datafile, str1)
	if str1 == nil or str1 == "" then
		return ""
	end
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			local ss = 实用工具.SplitString(_GBK2UTF8(v), " ")
			if #ss == 2 and str1 == ss[1] then
				return ss[2]
			end
		end
	end
	return ""
end

function 取文件内容(datafile, str1, str2, type)
	if str1 == nil or str1 == "" then
		return type == "string" and "" or 0
	end
	if str2 == nil or str2 == "" then
		return type == "string" and "" or 0
	end
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	local isfind = false
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			if v:sub(1,1) == "[" then
				if _GBK2UTF8(v:sub(2,-2)) == str1 then
					isfind = true
				else
					isfind = false
				end
			elseif isfind then
				local ss = 实用工具.SplitString(_GBK2UTF8(v), "=")
				if #ss == 2 and str2 == ss[1] then
					return type == "string" and ss[2] or tonumber(ss[2]) or 0
				end
			end
		end
	end
	return type == "string" and "" or 0
end

function 存文件内容(datafile, str1, str2, str3)
	if str1 == nil or str1 == "" then
		return -1
	end
	if str2 == nil or str2 == "" then
		return -1
	end
	local ret = -1
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	local isfind = false
	if strs and #strs > 0 then
		for i,v in ipairs(strs) do
			if v:sub(1,1) == "[" then
				if _GBK2UTF8(v:sub(2,-2)) == str1 then
					isfind = true
				elseif isfind then
					table.insert(strs, i+1, REAL_CONVERT(str2.."="..(str3 or "")))
					ret = i
					break
				end
			elseif isfind then
				local ss = 实用工具.SplitString(_GBK2UTF8(v), "=")
				if #ss == 2 and str2 == ss[1] then
					strs[i] = REAL_CONVERT(str2.."="..(str3 or ""))
					ret = i-1
					break
				end
			end
		end
	end
	if ret == -1 then
		if not isfind then
			strs[#strs+1] = REAL_CONVERT("["..str1.."]")
		end
		strs[#strs+1] = REAL_CONVERT(str2.."="..(str3 or ""))
		ret = #strs-1
	end
	实用工具.PrintToFile(filename, 实用工具.JoinString(strs, "\r\n"))
	return ret
end

function 读文本变量(datafile, line)
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/数据文件/"..datafile)
	local strs = 实用工具.GetStrFromFile(filename)
	if strs and line < #strs then
		local v = strs[line+1]
		local ss = 实用工具.SplitString(_GBK2UTF8(v), ":")
		if #ss > 1 then
			return ss[1], ss[2]
		else
			return ""
		end
	end
	return ""
end

function 当前日期时间()
	return os.date("%c")
end

function 当前年份()
	return 玩家事件处理.g_nNowDate.year
end

function 当前月份()
	return 玩家事件处理.g_nNowDate.month
end

function 当前日期()
	return 玩家事件处理.g_nNowDate.day
end

function 当前星期几()
	return 玩家事件处理.g_nNowDate.wday
end

function 当前小时()
	return 玩家事件处理.g_nNowDate.hour
end

function 当前分钟()
	return 玩家事件处理.g_nNowDate.min
end

function 当前秒()
	return 玩家事件处理.g_nNowDate.sec
end

human = human or {私人变量 = {},m_db = {私人变量 = {}}}
行会变量 = {}

function 获取行会变量(human)
	if human.m_db.行会ID ~= 0 then
		return 行会变量[human.m_db.行会ID] or {}
	else
		return {}
	end
end

function 保存全局变量()
	if Config.ISZY and not Config.ISLT then
		return
	end
	local str = "module(..., package.seeall)\n\n"
	for k,v in pairs(全局变量._M) do
		if k:sub(1,1) == "G" and tonumber(k:sub(2)) ~= nil then
			str = str..k.." = "..(v ~= "" and v or 0).."\n"
		elseif k:sub(1,1) == "A" and tonumber(k:sub(2)) ~= nil then
			str = str..k.." = \""..v.."\"\n"
		end
	end
	local filename = (__SCRIPT_PATH__ or "") .. _convert("./scripts/模块/触发器/全局变量.lua")
	实用工具.PrintToFile(filename, str)
end
