module(..., package.seeall)
local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 计时器ID = require("公用.计时器ID")
local 事件处理 = require("后台管理.事件处理")

派发器.RegisterTimerHandler(计时器ID.TIMER_ADMIN_LOGIC, 事件处理.OnAdminLogic)

if 事件处理.g_nAdminLogicID == nil then
	--事件处理.g_nAdminLogicID = _AddTimer(-1, 计时器ID.TIMER_ADMIN_LOGIC, 1 * 1000, -1, 0, 0, 0)
end
