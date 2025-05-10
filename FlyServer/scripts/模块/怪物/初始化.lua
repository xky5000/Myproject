module(..., package.seeall)
local 派发器 = require("公用.派发器")
local 计时器ID = require("公用.计时器ID")
local 事件处理 = require("怪物.事件处理")


派发器.RegisterTimerHandler(计时器ID.TIMER_MONSTER_RESPAWN, 事件处理.OnRespawn)
派发器.RegisterTimerHandler(计时器ID.TIMER_DROP_ITEM_EXPIRE, 事件处理.OnDropItemExpire)
派发器.RegisterTimerHandler(计时器ID.TIMER_DROP_ITEM_ROLL, 事件处理.OnDropItemRoll)
派发器.RegisterTimerHandler(计时器ID.TIMER_CLEAR_BIAOCHE, 事件处理.OnBiaocheExpire)
派发器.RegisterTimerHandler(计时器ID.TIMER_MONSTER_MOVEAI, 事件处理.OnMoveAI)
派发器.RegisterTimerHandler(计时器ID.TIMER_MONSTER_COLLECT, 事件处理.OnMonsterCollect)
