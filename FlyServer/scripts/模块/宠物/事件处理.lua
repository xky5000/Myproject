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
local 技能逻辑 = require("技能.技能逻辑")
local 技能表 = require("配置.技能表").Config
local Buff表 = require("配置.Buff表").Config
local 宠物DB = require("宠物.宠物DB")
local 宠物逻辑 = require("宠物.宠物逻辑")

function CG_PET_QUERY(human, msg)
	宠物逻辑.SendPetInfo(human)
end

function CG_CALL_PET(human, msg)
	宠物DB.CallPet(human, msg.index)
end

function CG_BACK_PET(human, msg)
	宠物DB.BackPet(human, msg.index)
end

function CG_MERGE_PET(human, msg)
	宠物DB.MergePet(human, msg.index)
end

function CG_BREAK_PET(human, msg)
	宠物DB.BreakPet(human, msg.index)
end

function CG_TRAIN_PET(human, msg)
	宠物逻辑.TrainPet(human, msg.index1, msg.index2)
end

function CG_FEED_PET(human, msg)
	--宠物逻辑.FeedPet(human, msg.index)
end

function CG_PET_ADDPOINT(human, msg)
	宠物逻辑.AddPointPet(human, msg.index, msg.类型)
end
