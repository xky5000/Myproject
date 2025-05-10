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

local ns = "sell"

寄售DB={}
function 寄售DB:New()	
	local db = {			 
			 id=0,
			 grid=nil,			--格子
			 belong = "",
			 time=0,		--时间戳
			 rmb=0,
			 price=0,
			}
	
	setmetatable(db, self)
    self.__index = self
    return db 
end


function 寄售DB:Add()
	local ret = _Insert(g_oMongoDB,ns,self)
    if not ret then
        return false
    end
    local query={id=self.id}
    local pCursor = _Find(g_oMongoDB,ns,query,"{_id:1}")
    if not pCursor then
        return false    
    end
    if not _NextCursor(pCursor,self) then
        return false
    end
    return true
end


function 寄售DB:Save()
    local query={}
    query._id=self._id
    return _Update(g_oMongoDB,ns,query,self)
end

function 寄售DB:Delete()
	if self._id == nil then
		return
	end
	local query={}
    query._id=self._id
    return _Delete(g_oMongoDB,ns,query)
end

function 寄售DB:ResetMetatable()
    寄售DB.__index = 寄售DB
    setmetatable(self, 寄售DB)
end
