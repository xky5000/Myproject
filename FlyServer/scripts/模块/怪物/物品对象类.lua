local 公共定义 = require("公用.公共定义")
local 派发器 = require("公用.派发器")
local 消息类 = require("公用.消息类")
local 协议ID = require("公用.协议ID")
local 计时器ID = require("公用.计时器ID")
local 实用工具 = require("公用.实用工具")
local 场景管理 = require("公用.场景管理")
local 日志 = require("公用.日志")
local 物品表 = require("配置.物品表").Config
local 物品逻辑 = require("物品.物品逻辑")
local 怪物表 = require("配置.怪物表").Config

物品对象类 = 对象类:New()
物品管理 = 物品管理 or {}

function 物品对象类:ReSetMetatable()
	物品对象类.__index = 物品对象类;
	setmetatable(self, 物品对象类);
end

function 物品对象类:New(nObjId)
	if 对象管理[nObjId] then
		assert(nil, "lua newobj fail 物品 already exist")
	end

	if 对象管理[nObjId] == nil then
        对象管理[nObjId] = {
			id=nObjId,
			m_nItemId=0,
			m_nOwnerId=-1,
			m_nSceneID=-1,
			m_nBornX=0, m_nBornY=0,
			m_nTimerId = -1,
			m_nCreateTime = 0,
			m_nCount=1,      --道具数量
			grade = nil,
			strengthen = nil,
			wash = nil,
			attach = nil,
			teamid = 0,
		}
    end
	
    local obj = 对象管理[nObjId]
    setmetatable(obj, self)
    self.__index = self
    return obj 
end

function 物品对象类:Destroy()
	_DelTimer(self.m_nTimerId,self.id)
    self:LeaveScene()
	self:ReleaseObj()
	对象管理[self.id] = nil
	物品管理[self.id] = nil
end

function 物品对象类:GetItemId()
	return self.m_nItemId
end

function 物品对象类:GetCount()
    return self.m_nCount
end

function 物品对象类:CreateItem(nSceneId, nOwnerId, nItemId, nCount, nX, nY, grade, strengthen, wash, attach, gem, ringsoul, expire)
	local conf = 物品表[nItemId]
	if conf == nil then
		return
	end

	local nObjId = self:CreateObj(公共定义.OBJ_TYPE_ITEM, -1)
	if nObjId == -1 then
	    assert(nObjId ~= -1, "物品对象类:CreateObj fail")
		return
	end

	local oObj = self:New(nObjId)
	local nTimerId = -1
	expire = expire or 60000
	if expire > 0 then
		nTimerId = _AddTimer(nObjId, 计时器ID.TIMER_DROP_ITEM_EXPIRE,expire,1, 0, 0, 0)
		if nTimerId == -1 then
			oObj:Destroy()
			return
		end
	end
	oObj.m_nItemId = nItemId
	oObj.m_nCount = nCount
	oObj.m_nOwnerId = nOwnerId
	oObj.m_nBornX = nX
	oObj.m_nBornY = nY
	oObj.m_nCreateTime = os.time()
	oObj:UpdateObjInfo()
	oObj.m_nTimerId = nTimerId
	oObj.grade = grade
	oObj.strengthen = strengthen
	oObj.wash = wash
	oObj.attach = attach
	oObj.gem = gem
	oObj.ringsoul = ringsoul
	
	oObj.m_oOwnerName = {}
  if nSceneId ~= -1 then
	oObj:EnterScene(nSceneId, nX, nY)
  end
	
	物品管理[oObj.id] = oObj
	--print("SceneId", nSceneId, oObj.id, nX, nY, nOwnerId,dropIcon)
	return oObj
end

function 物品对象类:GetItemConfig()
  local ret = 物品表[self.m_nItemId]
  if ret == nil then
    print("invalid 物品 id: ", self.m_nItemId)
  end
  return ret
end

function 物品对象类:GetGrade()
	if self.grade then
		return self.grade
	end
	local conf = self:GetItemConfig()
	if conf == nil then
		return 0
	end
	return conf.grade or 0
end

function 物品对象类:GetColor()
	if self.color then
		return self.color
	end
	local conf = self:GetItemConfig()
	if conf == nil then
		return 0
	end
	return tonumber(conf.color) or 0
end

function 物品对象类:GetName()
	local conf = self:GetItemConfig()
	if conf == nil then
		return ""
	end
	if 物品逻辑.GetItemType1(self.m_nItemId) == 3 and 物品逻辑.GetItemType2(self.m_nItemId) == 14 then
		local monconf = 怪物表[self.strengthen]
		return conf.name.."("..(monconf and monconf.name or "")..")"
	else
		if 公共定义.装备提示属性 == 1 and self.wash and #self.wash > 0 then
			local cnt = 0
			for i,v in ipairs(self.wash) do
				cnt = cnt + v[2]
			end
			return conf.name..(cnt > 0 and "+"..cnt or "")
		else
			return conf.name
		end
	end
end

function 物品对象类:UpdateObjInfo()
	local conf = self:GetItemConfig()
	if conf == nil then
		return 
	end
	
	local oMsgCacheData = 派发器.ProtoContainer[协议ID.GG_ADD_ITEM_CACHE_DATA]
	oMsgCacheData.name = self:GetName()
	oMsgCacheData.icon = conf.icon
	oMsgCacheData.itemid = self.m_nItemId
	oMsgCacheData.cnt = self.m_nCount
	oMsgCacheData.ownerid = self.m_nOwnerId
	oMsgCacheData.grade = self:GetGrade()
	oMsgCacheData.teamid = self.teamid
	oMsgCacheData.color = self:GetColor()
	消息类.SendMsg(oMsgCacheData, self.id)	
end
