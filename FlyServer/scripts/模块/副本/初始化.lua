module(..., package.seeall)
local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 计时器ID = require("公用.计时器ID")
local 事件处理 = require("副本.事件处理")
local 协议 = require("副本.协议")

派发器.RegisterTimerHandler(计时器ID.TIMER_COPYSCENE_MANAGER, 事件处理.OnCopySceneManager)
派发器.RegisterTimerHandler(计时器ID.TIMER_COPYSCENE_AI, 事件处理.OnCopySceneAI)
派发器.RegisterTimerHandler(计时器ID.TIMER_COPYSCENE_COSTTP, 事件处理.OnCopySceneCostTP)

if 事件处理.g_nCopySceneManagerID == nil then
	事件处理.g_nCopySceneManagerID = _AddTimer(-1, 计时器ID.TIMER_COPYSCENE_MANAGER, 10 * 1000, -1, 0, 0, 0)
end

if 事件处理.g_nCopySceneAIID == nil then
	事件处理.g_nCopySceneAIID = _AddTimer(-1, 计时器ID.TIMER_COPYSCENE_AI, 1 * 1000, -1, 0, 0, 0)
end
