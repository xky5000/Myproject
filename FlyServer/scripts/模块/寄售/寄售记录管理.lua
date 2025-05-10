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
local 寄售记录DB = require("寄售.寄售记录DB").寄售记录DB
local 物品逻辑 = require("物品.物品逻辑")

dbsorts = dbsorts or {}

function Init()
    local pCursor = _Find(g_oMongoDB,"sellrecord","{}")
    if not pCursor then
        return true
    end
    while true do
		local db = 寄售记录DB:New()
		if not _NextCursor(pCursor,db) then
			db:Delete()
			break
		else
			dbsorts[#dbsorts+1] = db
		end
    end
    return true
end

function AddSellRecord(seller,buyer,name,rmb,price)
	local db = 寄售记录DB:New()
	db.seller = seller
	db.buyer = buyer
	db.name = name
	db.time = os.time()
	db.rmb = rmb
	db.price = price
	db:Add()
	dbsorts[#dbsorts+1] = db
end
