module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 全局变量 = require("触发器.全局变量")

function call_每秒触发(sec)
	if sec%1==0 then
		call_坐庄游戏a()
	end
	if sec%1==0 then
		call_坐庄游戏b()
	end
	if sec%1==0 then
		call_坐庄游戏c()
	end
end

function call_每分触发(min)
	if 当前小时()==21 and 当前分钟()==50 then--21:50
		call_开赌博提示()
	end
	if 当前小时()==22 and 当前分钟()==0 then--22:00
		call_开赌博()
	end
	if 当前小时()==23 and 当前分钟()==50 then--23:50
		call_关赌博提示()
	end
	if 当前小时()==0 and 当前分钟()==0 then--00:00
		call_关赌博()
	end
	if 当前小时()==14 and 当前分钟()==50 then--14:50
		call_开赌博提示()
	end
	if 当前小时()==15 and 当前分钟()==0 then--15:00
		call_开赌博()
	end
	if 当前小时()==16 and 当前分钟()==50 then--16:50
		call_关赌博提示()
	end
	if 当前小时()==17 and 当前分钟()==0 then--17:00
		call_关赌博()
	end
	if 当前小时()==19 and 当前分钟()==1 then--19:01
		call_设功沙()
	end
	if 当前小时()==0 and 当前分钟()==1 then--00:01
		call_过一天()
	end
	if 当前小时()==22 and 当前分钟()==30 then--22:30
		call_行会争夺提示1()
	end
	if 当前小时()==22 and 当前分钟()==40 then--22:40
		call_行会争夺提示2()
	end
	if 当前小时()==22 and 当前分钟()==50 then--22:50
		call_行会争夺关闭()
	end
	if 当前小时()==23 and 当前分钟()==25 then--23:25
		call_行会争夺结束()
	end
end

function call_行会争夺提示1()--@行会争夺提示1
	local sayret = nil
	if true then
		全服广播("#cff00ff,".."行会争霸:入口在20分钟后将自动关闭，请参赛玩家进入比赛场地！获胜的行会可以获得999元宝奖励！")
		全服广播("#cff00ff,".."行会争霸:入口在20分钟后将自动关闭，请参赛玩家进入比赛场地！获胜的行会可以获得999元宝奖励！")
		return sayret
	end
	return sayret
end

function call_行会争夺提示2()--@行会争夺提示2
	local sayret = nil
	if true then
		全服广播("#cff00ff,".."行会争霸:入口在10分钟后将自动关闭，请参赛玩家进入比赛场地！获胜的行会可以获得999元宝奖励！")
		全服广播("#cff00ff,".."行会争霸:入口在10分钟后将自动关闭，请参赛玩家进入比赛场地！获胜的行会可以获得999元宝奖励！")
		return sayret
	end
	return sayret
end

function call_行会争夺关闭()--@行会争夺关闭
	local sayret = nil
	if true then
		全服广播("#cff00ff,".."行会争霸:入口已经关闭。")
		return sayret
	end
	return sayret
end

function call_行会争夺结束()--@行会争夺结束
	local sayret = nil
	if true then
		return sayret
	end
	return sayret
end

function call_坐庄游戏a()--@坐庄游戏A
	local sayret = nil
	if (全局变量.A36 or "")=="" and true then
		全局变量.A36="　　　　　　　　　　　　　　　　　　　　"
	end
	if (全局变量.A35 or "")=="无" and true then
		return sayret
	end
	if (全局变量.A35 or "")=="" and true then
		return sayret
	end
	if (全局变量.I12 or 0)==0 and true then
		开始提问("抢庄开始")
		全局变量.I10=9
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==10 and true then
		开始提问("抢庄结束")
		全局变量.I10=0
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==11 and true then
		开始提问("下注开始")
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==67 and true then
		开始提问("下注结束")
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==68 and (全局变量.I64 or 0)>0 and (全局变量.I65 or 0)>0 and (全局变量.I66 or 0)>0 and true then
		全局变量.I42=(全局变量.I64 or 0)
		全局变量.I43=(全局变量.I65 or 0)
		全局变量.I44=(全局变量.I66 or 0)
		全局变量.I45=(全局变量.I42 or 0)
		全局变量.I45=实用工具.SumString((全局变量.I45 or 0),(全局变量.I43 or 0))
		全局变量.I45=实用工具.SumString((全局变量.I45 or 0),(全局变量.I44 or 0))
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==68 and true then
		全局变量.I42=实用工具.GetRandomVal(6,0)
		全局变量.I42=实用工具.SumString((全局变量.I42 or 0),1)
		全局变量.I43=实用工具.GetRandomVal(6,0)
		全局变量.I43=实用工具.SumString((全局变量.I43 or 0),1)
		全局变量.I44=实用工具.GetRandomVal(6,0)
		全局变量.I44=实用工具.SumString((全局变量.I44 or 0),1)
		全局变量.I45=(全局变量.I42 or 0)
		全局变量.I45=实用工具.SumString((全局变量.I45 or 0),(全局变量.I43 or 0))
		全局变量.I45=实用工具.SumString((全局变量.I45 or 0),(全局变量.I44 or 0))
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==70 and true then
		开始提问("猜点开始")
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==76 and true then
		开始提问("赌博结帐")
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==78 and true then
		开始提问("赌博清零")
		全局变量.I64=0
		全局变量.I65=0
		全局变量.I66=0
		全局变量.A34="无"
		全局变量.I16=0
		全局变量.I17=0
		全局变量.I11=0
		全局变量.I13=0
		全局变量.I14=0
		全局变量.I31=0
		全局变量.I42=0
		全局变量.I43=0
		全局变量.I44=0
		全局变量.I45=0
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	if (全局变量.I12 or 0)==80 and true then
		全局变量.A35="无"
		全局变量.I12=0
		return sayret
	end
	if (全局变量.I10 or 0)>0 and true then
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		全局变量.I10=(全局变量.I10 or 0)-1
		return sayret
	end
	if true then
		全局变量.I12=实用工具.SumString((全局变量.I12 or 0),1)
		return sayret
	end
	return sayret
end

function call_坐庄游戏b()--@坐庄游戏B
	local sayret = nil
	if (全局变量.A35 or "")=="无" and true then
		return sayret
	end
	if (全局变量.A35 or "")=="" and true then
		return sayret
	end
	if true then
		全局变量.I18=0
		全局变量.I19=0
		全局变量.I15=80
		全局变量.I15=(全局变量.I15 or 0)-(全局变量.I12 or 0)
		全局变量.I11=(全局变量.I13 or 0)
		全局变量.I11=实用工具.SumString((全局变量.I11 or 0),(全局变量.I14 or 0))
		全局变量.I16=(全局变量.I31 or 0)
		全局变量.I16=实用工具.SumString((全局变量.I16 or 0),(全局变量.I14 or 0))
		全局变量.I16=(全局变量.I16 or 0)-(全局变量.I13 or 0)
		全局变量.I17=(全局变量.I31 or 0)
		全局变量.I17=实用工具.SumString((全局变量.I17 or 0),(全局变量.I13 or 0))
		全局变量.I17=(全局变量.I17 or 0)-(全局变量.I14 or 0)
		return sayret
	end
	return sayret
end

function call_坐庄游戏c()--@坐庄游戏C
	local sayret = nil
	if (全局变量.A35 or "")=="无" and true then
		return sayret
	end
	if (全局变量.A35 or "")=="" and true then
		return sayret
	end
	if (全局变量.I12 or 0)==72 and (全局变量.I42 or 0)==(全局变量.I43 or 0) and (全局变量.I42 or 0)==(全局变量.I44 or 0) and true then
		全局变量.A34="豹子"
		return sayret
	end
	if (全局变量.I12 or 0)==72 and (全局变量.I45 or 0)<11 and true then
		全局变量.A34="小"
		return sayret
	end
	if (全局变量.I12 or 0)==72 and (全局变量.I45 or 0)>10 and true then
		全局变量.A34="大"
		return sayret
	end
	return sayret
end

function call_过一天()--@过一天
	local sayret = nil
	if (全局变量.G88 or 0)==0 and true then
		全局变量.G89=1
		全局变量.G88=实用工具.SumString((全局变量.G88 or 0),1)
		全局变量.G88=实用工具.SumString((全局变量.G88 or 0),1)
		全局变量.G90=0
		return sayret
	end
	if (全局变量.G89 or 0)==0 and true then
		全局变量.G89=1
		全局变量.G88=实用工具.SumString((全局变量.G88 or 0),1)
		全局变量.G90=0
		return sayret
	end
	if (全局变量.G89 or 0)==1 and true then
		全局变量.G89=0
		全局变量.G88=实用工具.SumString((全局变量.G88 or 0),1)
		全局变量.G90=0
		return sayret
	end
	return sayret
end

function call_设功沙()--@设功沙
	local sayret = nil
	if (全局变量.G88 or 0)>3 and (全局变量.G89 or 0)==1 and true then
		return sayret
	end
	return sayret
end

function call_开赌博提示()--@开赌博提示
	local sayret = nil
	if true then
		全服广播("#cff00ff,".."赌博:今天晚上没有攻沙，不如大家来小赌一把！赌城将在15点-17点.22点-24点开放，还不快去充好元宝做准备！！")
		return sayret
	end
	return sayret
end

function call_开赌博()--@开赌博
	local sayret = nil
	if true then
		全局变量.H31=1
		return sayret
	end
	return sayret
end

function call_关赌博提示()--@关赌博提示
	local sayret = nil
	if true then
		全服广播("#cff00ff,".."赌博:赌城将在10分钟后关闭！下次开放时间为明天")
		全服广播("#cff00ff,".."赌博:赌城将在10分钟后关闭！下次开放时间为明天")
		全服广播("#cff00ff,".."赌博:赌城将在10分钟后关闭！下次开放时间为明天")
		全服广播("#cff00ff,".."赌博:赌城将在10分钟后关闭！下次开放时间为明天")
		return sayret
	end
	return sayret
end

function call_关赌博()--@关赌博
	local sayret = nil
	if true then
		全局变量.H31=0
		全服广播("#cff00ff,".."赌博:赌城已关闭！下次开放时间为明天")
		全服广播("#cff00ff,".."赌博:赌城已关闭！下次开放时间为明天")
		全服广播("#cff00ff,".."赌博:赌城已关闭！下次开放时间为明天")
		全服广播("#cff00ff,".."赌博:赌城已关闭！下次开放时间为明天")
		return sayret
	end
	return sayret
end
