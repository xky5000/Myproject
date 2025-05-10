local NPCConfig = require("配置.Npc表").Config
local 派发器 = require("公用.派发器")
local 公共定义 = require("公用.公共定义")
local 协议ID = require("公用.协议ID")
local 实用工具 = require("公用.实用工具")
local 消息类 = require("公用.消息类")

Npc对象类= 对象类:New()
--NPCPos = NPCPos or {}

function Npc对象类:ReSetMetatable()
	Npc对象类.__index = Npc对象类;
	setmetatable(self, Npc对象类);
end


function Npc对象类:New(nObjId)
	if 对象管理[nObjId] then
		assert(nil, "lua newobj fail npc already exist")
	end

	if 对象管理[nObjId] == nil then
        对象管理[nObjId] = {
			id=nObjId,
			m_nNpcID=0,
			m_nSceneID=-1,
			m_nBornX=0,
			m_nBornY=0,
		}
    end
	
    local obj = 对象管理[nObjId]     
    setmetatable(obj, self)
    self.__index = self
    return obj 
end

function Npc对象类:CreateNPC(nSceneId, nNpcId, nX, nY)
	local conf = NPCConfig[nNpcId]
	if conf == nil then
		print("error: CreateNPC Failed,npc id no exist:", nNpcId)
		return
	end

	local nObjType = conf.type == 1 and 公共定义.OBJ_TYPE_JUMP or 公共定义.OBJ_TYPE_NPC--math.floor(nNpcId/1000)%10
	local nObjId = self:CreateObj(nObjType, -1)--公共定义.OBJ_TYPE_NPC, -1)
	if nObjId == -1 then
		return 
	end
	
	local oObj = self:New(nObjId)
	oObj.m_nNpcID	= nNpcId
	oObj.m_nBornX	= nX
	oObj.m_nBornY   = nY
	if Config.ISLT and nObjType == 公共定义.OBJ_TYPE_NPC then
		oObj:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, 1)
	end
	oObj:UpdateObjInfo() 
	if nSceneId ~= -1 then
		oObj:EnterScene(nSceneId, nX, nY)
	end
    --if NPCPos[nNpcId] ~= nil then
    --    oldPos = NPCPos[nNpcId]
    --    if oldPos.x ~= nX or oldPos.y ~= nY then
    --        print(_convert(string.format("npc位置信息错误: %s(%d) (%d,%d) -> (%d,%d)", conf.name, nNpcId, oldPos.x, oldPos.y, nX, nY)))
    --    end
    --end

    --NPCPos[nNpcId] = {x=nX, y=nY, sceneID=nSceneId}
    --print (string.format("NPC [%d - %d] %s: (%d, %d)", nSceneId, nNpcId, conf.name, nX, nY))
	return oObj
end


function Npc对象类:Destroy()
	self:LeaveScene()
	self:ReleaseObj()
	对象管理[self.id]=nil
end


function Npc对象类:GetNPCConfig()
	return NPCConfig[self.m_nNpcID]
end

function Npc对象类:UpdateObjInfo()
	local conf = self:GetNPCConfig()
	
	local oMsgCacheData = 派发器.ProtoContainer[协议ID.GG_ADD_NPC_CACHE_DATA]
	oMsgCacheData.name = conf.name
	oMsgCacheData.level = 100
	oMsgCacheData.confid = self.m_nNpcID
	oMsgCacheData.bodyid = conf.bodyid -- 形象id 
	oMsgCacheData.effid = conf.effid
	
	消息类.SendMsg(oMsgCacheData, self.id)
end
