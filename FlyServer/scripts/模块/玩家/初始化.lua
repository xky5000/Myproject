module(..., package.seeall)
local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 计时器ID = require("公用.计时器ID")
local 事件处理 = require("玩家.事件处理")
local 协议 = require("玩家.协议")

派发器.RegisterTimerHandler(计时器ID.TIMER_CHAR_ATTR_REFRESH, 事件处理.OnRefreshAttr)
派发器.RegisterTimerHandler(计时器ID.TIMER_CHAR_HP_RECOVER, 事件处理.OnHPRecover)
派发器.RegisterTimerHandler(计时器ID.TIMER_SAVE_CHAR_DB, 事件处理.OnSaveCharDB)
派发器.RegisterTimerHandler(计时器ID.TIMER_CHAR_REAL_DESTROY, 事件处理.OnCharRealDestroy)
派发器.RegisterTimerHandler(计时器ID.TIMER_CHAR_SIT_EXP_ADD, 事件处理.OnHumanSitStatusExpAdd)
派发器.RegisterTimerHandler(计时器ID.TIMER_CHAR_ONE_MIN_CHECK, 事件处理.OnOneMinCheck)
派发器.RegisterTimerHandler(计时器ID.TIMER_CHAR_ONE_SEC_CHECK, 事件处理.OnOneSecCheck)
派发器.RegisterTimerHandler(计时器ID.TIMER_HALF_HOUR_UPDATE, 事件处理.OnHalfHourUpdate)
派发器.RegisterTimerHandler(计时器ID.TIMER_DAY_UPDATE, 事件处理.OnDayUpdate)
派发器.RegisterTimerHandler(计时器ID.TIMER_XP_PREPARE, 事件处理.OnXpPrepare)
派发器.RegisterTimerHandler(计时器ID.TIMER_XP_FINISH, 事件处理.OnXpFinish)
派发器.RegisterTimerHandler(计时器ID.TIMER_HUMAN_MOVEGRID, 事件处理.OnMoveGrid)

if 事件处理.g_nHourTimerID == nil then
	print("g_nHourTimerID init timer:", os.date("%c"), " left:", (1800 -os.time() % 1800))	
	事件处理.g_nHourTimerID = _AddTimer(-1, 计时器ID.TIMER_HALF_HOUR_UPDATE, (1800 - os.time() % 1800) * 1000, 1, 0, 0, 0)
end

if 事件处理.g_nDayTimerID == nil then
	print("g_nDayTimerID init timer:", os.date("%c"), " left:", (24 * 60 * 60 - (os.time() + 8 * 60 * 60) % (24 * 60 * 60)))	
	-- 这里注意 因为是东八区 所以初始化+8小时
	事件处理.g_nDayTimerID = _AddTimer(-1, 计时器ID.TIMER_DAY_UPDATE, (24 * 60 * 60 - (os.time() + 8 * 60 * 60) % (24 * 60 * 60)) * 1000, 1, 0, 0, 0)
end

if 事件处理.g_nMinTimerID == nil then
	事件处理.g_nMinTimerID = _AddTimer(-1, 计时器ID.TIMER_CHAR_ONE_MIN_CHECK, 60 * 1000, -1, 0, 0, 0)
end

if 事件处理.g_nSecTimerID == nil then
	事件处理.g_nSecTimerID = _AddTimer(-1, 计时器ID.TIMER_CHAR_ONE_SEC_CHECK, 1000, -1, 0, 0, 0)
end
