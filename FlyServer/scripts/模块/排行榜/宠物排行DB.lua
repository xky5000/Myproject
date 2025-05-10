module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")

local ns = "petranking"

RankingDB={}
function RankingDB:New()	
	local ranking = {			 
			 name="",		
			 belong="",			--所属
			 index=0,			--索引
			 power=0,			--战力
			 level=1,			--等级
			 starlevel=1,		--星级
			}
	
	setmetatable(ranking, self)
    self.__index = self
    return ranking 
end

function RankingDB:Add()
	local ret = _Insert(g_oMongoDB,ns,self)
    if not ret then
        return false
    end
    local query={belong=self.belong,index=self.index}
    local pCursor = _Find(g_oMongoDB,ns,query,"{_id:1}")
    if not pCursor then
        return false
    end
    if not _NextCursor(pCursor,self) then
        return false
    end
    return true
end

function RankingDB:Save()
    local query={}
    query._id=self._id
    return _Update(g_oMongoDB,ns,query,self)
end

function RankingDB:Delete()
	if self._id == nil then
		return
	end
	local query={}
    query._id=self._id
    return _Delete(g_oMongoDB,ns,query)
end

function RankingDB:ResetMetatable()
    RankingDB.__index = RankingDB
    setmetatable(self, RankingDB)
end
