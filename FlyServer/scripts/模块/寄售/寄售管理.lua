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
local 寄售DB = require("寄售.寄售DB").寄售DB

dbsorts = dbsorts or {}

function Init()
    local pCursor = _Find(g_oMongoDB,"sell","{}")
    if not pCursor then
        return true
    end
	local id = 1
    while true do
		local db = 寄售DB:New()
		if not _NextCursor(pCursor,db) then
			db:Delete()
			break
		elseif Config.MERGEDB then
			db.id = id
			dbsorts[#dbsorts+1] = db
			db:Save()
			id = id + 1
		else
			dbsorts[#dbsorts+1] = db
		end
    end
	if Config.MERGEST and Config.SVRNAME:len() > 0 then
		for i,v in ipairs(dbsorts) do
			if v.belong:sub(1,Config.SVRNAME:len()) ~= Config.SVRNAME then
				v.belong = Config.SVRNAME..v.belong
			end
			v:Save()
		end
	end
	table.sort(dbsorts, CompareDB)
    return true
end

function CompareDB(first,second)
	if first.id ~= second.id then return first.id<second.id end
	if first.time ~= second.time then return first.time<second.time end
end

function AddSellGrid(grid,belong,rmb,price)
	local db = 寄售DB:New()
	db.grid = grid
	db.belong = belong
	db.time = os.time()
	db.rmb = rmb
	db.price = price
	db.id = #dbsorts > 0 and dbsorts[#dbsorts].id+1 or 1
	db:Add()
	dbsorts[#dbsorts+1] = db
end

function DelSellID(id)
	for i,v in ipairs(dbsorts) do
		if v.id == id then
			v:Delete()
			table.remove(dbsorts, i)
			break
		end
	end
end
