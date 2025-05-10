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

local ns = "sellrecord"

寄售记录DB={}
function 寄售记录DB:New()	
	local db = {			 
			 seller="",			--卖方
			 buyer="",		--买方
			 name="",
			 time=0,		--时间戳
			 rmb=0,
			 price=0,
			}
	
	setmetatable(db, self)
    self.__index = self
    return db 
end


function 寄售记录DB:Add()
	local ret = _Insert(g_oMongoDB,ns,self)
    if not ret then
        return false
    end
    local query={name=self.name}
    local pCursor = _Find(g_oMongoDB,ns,query,"{_id:1}")
    if not pCursor then
        return false    
    end
    if not _NextCursor(pCursor,self) then
        return false
    end
    return true
end


function 寄售记录DB:Save()
    local query={}
    query._id=self._id
    return _Update(g_oMongoDB,ns,query,self)
end

function 寄售记录DB:Delete()
	if self._id == nil then
		return
	end
	local query={}
    query._id=self._id
    return _Delete(g_oMongoDB,ns,query)
end

function 寄售记录DB:ResetMetatable()
    寄售记录DB.__index = 寄售记录DB
    setmetatable(self, 寄售记录DB)
end
