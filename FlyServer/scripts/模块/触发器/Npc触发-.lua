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

function call_4056_1001(human)--仓库NPC/比奇城_仓库-0-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1001_1(human)--仓库NPC/比奇城_仓库-0-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1001_2(human)--仓库NPC/比奇城_仓库-0-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1001_3(human)--仓库NPC/比奇城_仓库-0-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1001_7(human)--仓库NPC/比奇城_仓库-0-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1001_8(human)--仓库NPC/比奇城_仓库-0-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1001_6(human)--仓库NPC/比奇城_仓库-0-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1001_4(human)--仓库NPC/比奇城_仓库-0-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_9(human)--仓库NPC/比奇城_仓库-0-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1001_12(human)--仓库NPC/比奇城_仓库-0-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_10(human)--仓库NPC/比奇城_仓库-0-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_13(human)--仓库NPC/比奇城_仓库-0-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1001_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1001_14(human)--仓库NPC/比奇城_仓库-0-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_11(human)--仓库NPC/比奇城_仓库-0-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1001_15(human)--仓库NPC/比奇城_仓库-0-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1001_16(human)--仓库NPC/比奇城_仓库-0-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1001_17(human)--仓库NPC/比奇城_仓库-0-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1001_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_27(human)--仓库NPC/比奇城_仓库-0-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_18(human)--仓库NPC/比奇城_仓库-0-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1001_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_28(human)--仓库NPC/比奇城_仓库-0-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_19(human)--仓库NPC/比奇城_仓库-0-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1001_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_29(human)--仓库NPC/比奇城_仓库-0-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_20(human)--仓库NPC/比奇城_仓库-0-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1001_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_30(human)--仓库NPC/比奇城_仓库-0-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_21(human)--仓库NPC/比奇城_仓库-0-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1001_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_31(human)--仓库NPC/比奇城_仓库-0-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_22(human)--仓库NPC/比奇城_仓库-0-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1001_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_32(human)--仓库NPC/比奇城_仓库-0-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_23(human)--仓库NPC/比奇城_仓库-0-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1001_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_33(human)--仓库NPC/比奇城_仓库-0-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_24(human)--仓库NPC/比奇城_仓库-0-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1001_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_34(human)--仓库NPC/比奇城_仓库-0-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_25(human)--仓库NPC/比奇城_仓库-0-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1001_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_35(human)--仓库NPC/比奇城_仓库-0-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_26(human)--仓库NPC/比奇城_仓库-0-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1001_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1001_36(human)--仓库NPC/比奇城_仓库-0-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1002_0(human)--仓库NPC/比奇城_仓库-0125-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1002_1(human)--仓库NPC/比奇城_仓库-0125-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1002_2(human)--仓库NPC/比奇城_仓库-0125-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1002_3(human)--仓库NPC/比奇城_仓库-0125-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1002_7(human)--仓库NPC/比奇城_仓库-0125-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1002_8(human)--仓库NPC/比奇城_仓库-0125-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1002_6(human)--仓库NPC/比奇城_仓库-0125-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1002_4(human)--仓库NPC/比奇城_仓库-0125-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_9(human)--仓库NPC/比奇城_仓库-0125-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1002_12(human)--仓库NPC/比奇城_仓库-0125-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_10(human)--仓库NPC/比奇城_仓库-0125-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_13(human)--仓库NPC/比奇城_仓库-0125-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1002_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1002_14(human)--仓库NPC/比奇城_仓库-0125-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_11(human)--仓库NPC/比奇城_仓库-0125-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1002_15(human)--仓库NPC/比奇城_仓库-0125-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1002_16(human)--仓库NPC/比奇城_仓库-0125-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1002_17(human)--仓库NPC/比奇城_仓库-0125-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1002_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_27(human)--仓库NPC/比奇城_仓库-0125-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_18(human)--仓库NPC/比奇城_仓库-0125-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1002_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_28(human)--仓库NPC/比奇城_仓库-0125-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_19(human)--仓库NPC/比奇城_仓库-0125-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1002_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_29(human)--仓库NPC/比奇城_仓库-0125-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_20(human)--仓库NPC/比奇城_仓库-0125-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1002_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_30(human)--仓库NPC/比奇城_仓库-0125-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_21(human)--仓库NPC/比奇城_仓库-0125-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1002_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_31(human)--仓库NPC/比奇城_仓库-0125-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_22(human)--仓库NPC/比奇城_仓库-0125-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1002_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_32(human)--仓库NPC/比奇城_仓库-0125-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_23(human)--仓库NPC/比奇城_仓库-0125-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1002_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_33(human)--仓库NPC/比奇城_仓库-0125-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_24(human)--仓库NPC/比奇城_仓库-0125-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1002_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_34(human)--仓库NPC/比奇城_仓库-0125-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_25(human)--仓库NPC/比奇城_仓库-0125-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1002_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_35(human)--仓库NPC/比奇城_仓库-0125-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_26(human)--仓库NPC/比奇城_仓库-0125-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1002_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1002_36(human)--仓库NPC/比奇城_仓库-0125-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1003_0(human)--仓库NPC/比奇城_商人-0126-@main
	local sayret = nil
	if true then
		sayret = [[
你知道我是谁吗？ 
告诉你我是何等人物...
你要试一下吗..？说说看需要我帮你做什么？ 
#u#lc0000ff:1,#cffff00,了解金条#L#U#C
#u#lc0000ff:2,#cffff00,了解金砖#L#U#C
#u#lc0000ff:3,#cffff00,了解金盒#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1003_1(human)--仓库NPC/比奇城_商人-0126-@gold100
	local sayret = nil
	if true then
		sayret = [[
关于金条，我所能做的事情是：
将金条换成金币或将金币换成金条。一个金条的价值
是#c00ff00,100万金币#C。记住了，你需要我为你做什么？ 
#u#lc0000ff:4,#cffff00,将金币换成金条#L#U#C 
#u#lc0000ff:5,#cffff00,将金条换成金币#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_2(human)--仓库NPC/比奇城_商人-0126-@gold500
	local sayret = nil
	if true then
		sayret = [[
关于金砖，我所能做的是：
将金砖换成金条或将金条换成金砖。一个金砖的价值
等于#c00ff00,5个金条#C。你需要我为你做什么？ 
#u#lc0000ff:6,#cffff00,金条换成金砖#L#U#C
#u#lc0000ff:7,#cffff00,金砖换成金条#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_3(human)--仓库NPC/比奇城_商人-0126-@gold1000
	local sayret = nil
	if true then
		sayret = [[
关于金盒，我所能做的是：
将金盒换成金砖或将金砖换成金盒。一个金盒的价值
等于#c00ff00,2个金砖#C，你需要为你做什么？ 
#u#lc0000ff:8,#cffff00,金砖换成金盒#L#U#C
#u#lc0000ff:9,#cffff00,金盒换成金砖#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_6(human)--仓库NPC/比奇城_商人-0126-@Change5Set
	local sayret = nil
	if human:检查物品数量(10317,5) and true then
		sayret = [[
你想用金条换金砖？
好，我可以帮你换但是你要支付手续费...
手续费是12000金币，要换吗？ 
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你没有5个金条，要我怎么帮你换？
等你有足够的金条，再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_10(human)--仓库NPC/比奇城_商人-0126-@Change5Set_1
	local sayret = nil
	if human:检查物品数量(10317,5) and human:获取金币()>=12000 and true then
		human:收回物品(10317,5)
		human:收回物品(10002,12000)
		human:获得物品(10231,1)
		sayret = [[
金条已经换好金砖。继续换吗？  
#u#lc0000ff:6,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
没有金条，或没有足够的手续费。
重新确认一下吧... 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1003_7(human)--仓库NPC/比奇城_商人-0126-@Reverse5Set
	local sayret = nil
	if human:检查物品数量(10231,1) and true then
		sayret = [[
你要将金砖换成金条？
好，我帮你换。但是你要支付手续费...
手续费是12000金币，要换吗？  
#u#lc0000ff:11,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你没有金砖还要我换什么？
等准备好金砖之后再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_11(human)--仓库NPC/比奇城_商人-0126-@Reverse5Set_1
	local sayret = nil
	if human:检查物品数量(10231,1) and human:获取金币()>=12000 and true then
		human:收回物品(10231,1)
		human:收回物品(10002,12000)
		human:获得物品(10317,5)
		sayret = [[
金砖已经换好金条。
还要继续换吗？  
#u#lc0000ff:7,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
背包已满或没有金砖、没有足够的手续费支付。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1003_8(human)--仓库NPC/比奇城_商人-0126-@Change10Set
	local sayret = nil
	if human:检查物品数量(10231,2) and true then
		sayret = [[
你要将金砖换成金盒？ 
好，我帮你换不过你要支付手续费...
手续费是10000金币，还要换吗？ 
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你连2个金砖都没有，还叫我换什么？
等你有足够的金砖之后再来找我把... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_12(human)--仓库NPC/比奇城_商人-0126-@Change10Set_1
	local sayret = nil
	if human:检查物品数量(10231,2) and human:获取金币()>=10000 and true then
		human:收回物品(10231,2)
		human:收回物品(10002,10000)
		human:获得物品(10318,1)
		sayret = [[
我已经把金砖换好金盒。
还继续换吗？ 
#u#lc0000ff:8,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
没有金砖或没有足够的金币支付手续费。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1003_9(human)--仓库NPC/比奇城_商人-0126-@Reverse10Set
	local sayret = nil
	if human:检查物品数量(10318,1) and true then
		sayret = [[
你想把金盒换成金砖？
好，我帮你换。不过你要支付一定的手续费...
手续费是10000金币，你要换吗？ 
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金盒，还叫我换什么？
等准备好金盒之后再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_13(human)--仓库NPC/比奇城_商人-0126-@Reverse10Set_1
	local sayret = nil
	if human:检查物品数量(10318,1) and human:获取金币()>=10000 and true then
		human:收回物品(10318,1)
		human:收回物品(10002,10000)
		human:获得物品(10231,2)
		sayret = [[
金盒已经换成金砖。
还继续换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
背包已满或没有金盒、没有足够的手续费支付。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1003_4(human)--仓库NPC/比奇城_商人-0126-@Change
	local sayret = nil
	if human:获取金币()>=1000000 and true then
		sayret = [[
你想用金币换金条？
好，我可以帮你换。
不过你要支付一定的手续费。
手续费是2000金币，你还换吗？ 
#u#lc0000ff:14,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱，还叫我换什么？
等有钱之后再来找我吧。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1003_14(human)--仓库NPC/比奇城_商人-0126-@Change_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条。
还继续换吗？ 
#u#lc0000ff:4,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
包里东西已满或没有足够的手续费可支付。
重新确认一下吧... 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1003_5(human)--仓库NPC/比奇城_商人-0126-@Reverse
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你想用金条换金币？
好，我可以帮你换。不过你要支付一定的手续费。
手续费是2000金币，你还换吗？ 
#u#lc0000ff:15,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条，还叫我换什么？ 
你在和我开玩笑？快在我面前消失！ 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1003_15(human)--仓库NPC/比奇城_商人-0126-@Reverse_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想帮你换。
但是你的金币太多了，我不能给你换。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = call_1003_16(human) or sayret--@Reverse_2
	end
	return sayret
end

function call_1003_16(human)--仓库NPC/比奇城_商人-0126-@Reverse_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币。
还继续换吗？ 
#u#lc0000ff:5,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end
function call_1004_0(human)--仓库NPC/银杏新人村_仓库-0-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1004_1(human)--仓库NPC/银杏新人村_仓库-0-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1004_2(human)--仓库NPC/银杏新人村_仓库-0-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1004_3(human)--仓库NPC/银杏新人村_仓库-0-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1004_7(human)--仓库NPC/银杏新人村_仓库-0-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1004_8(human)--仓库NPC/银杏新人村_仓库-0-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1004_6(human)--仓库NPC/银杏新人村_仓库-0-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1004_4(human)--仓库NPC/银杏新人村_仓库-0-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_9(human)--仓库NPC/银杏新人村_仓库-0-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1004_12(human)--仓库NPC/银杏新人村_仓库-0-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_10(human)--仓库NPC/银杏新人村_仓库-0-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_13(human)--仓库NPC/银杏新人村_仓库-0-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1004_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1004_14(human)--仓库NPC/银杏新人村_仓库-0-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_11(human)--仓库NPC/银杏新人村_仓库-0-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1004_15(human)--仓库NPC/银杏新人村_仓库-0-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1004_16(human)--仓库NPC/银杏新人村_仓库-0-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1004_17(human)--仓库NPC/银杏新人村_仓库-0-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1004_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_27(human)--仓库NPC/银杏新人村_仓库-0-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_18(human)--仓库NPC/银杏新人村_仓库-0-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1004_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_28(human)--仓库NPC/银杏新人村_仓库-0-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_19(human)--仓库NPC/银杏新人村_仓库-0-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1004_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_29(human)--仓库NPC/银杏新人村_仓库-0-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_20(human)--仓库NPC/银杏新人村_仓库-0-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1004_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_30(human)--仓库NPC/银杏新人村_仓库-0-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_21(human)--仓库NPC/银杏新人村_仓库-0-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1004_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_31(human)--仓库NPC/银杏新人村_仓库-0-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_22(human)--仓库NPC/银杏新人村_仓库-0-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1004_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_32(human)--仓库NPC/银杏新人村_仓库-0-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_23(human)--仓库NPC/银杏新人村_仓库-0-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1004_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_33(human)--仓库NPC/银杏新人村_仓库-0-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_24(human)--仓库NPC/银杏新人村_仓库-0-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1004_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_34(human)--仓库NPC/银杏新人村_仓库-0-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_25(human)--仓库NPC/银杏新人村_仓库-0-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1004_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_35(human)--仓库NPC/银杏新人村_仓库-0-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_26(human)--仓库NPC/银杏新人村_仓库-0-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1004_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1004_36(human)--仓库NPC/银杏新人村_仓库-0-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1005_0(human)--仓库NPC/比奇新人村_仓库-0140-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1005_1(human)--仓库NPC/比奇新人村_仓库-0140-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1005_2(human)--仓库NPC/比奇新人村_仓库-0140-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1005_3(human)--仓库NPC/比奇新人村_仓库-0140-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1005_7(human)--仓库NPC/比奇新人村_仓库-0140-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1005_8(human)--仓库NPC/比奇新人村_仓库-0140-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1005_6(human)--仓库NPC/比奇新人村_仓库-0140-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1005_4(human)--仓库NPC/比奇新人村_仓库-0140-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_9(human)--仓库NPC/比奇新人村_仓库-0140-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1005_12(human)--仓库NPC/比奇新人村_仓库-0140-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_10(human)--仓库NPC/比奇新人村_仓库-0140-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_13(human)--仓库NPC/比奇新人村_仓库-0140-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1005_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1005_14(human)--仓库NPC/比奇新人村_仓库-0140-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_11(human)--仓库NPC/比奇新人村_仓库-0140-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1005_15(human)--仓库NPC/比奇新人村_仓库-0140-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1005_16(human)--仓库NPC/比奇新人村_仓库-0140-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1005_17(human)--仓库NPC/比奇新人村_仓库-0140-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1005_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_27(human)--仓库NPC/比奇新人村_仓库-0140-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_18(human)--仓库NPC/比奇新人村_仓库-0140-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1005_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_28(human)--仓库NPC/比奇新人村_仓库-0140-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_19(human)--仓库NPC/比奇新人村_仓库-0140-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1005_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_29(human)--仓库NPC/比奇新人村_仓库-0140-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_20(human)--仓库NPC/比奇新人村_仓库-0140-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1005_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_30(human)--仓库NPC/比奇新人村_仓库-0140-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_21(human)--仓库NPC/比奇新人村_仓库-0140-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1005_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_31(human)--仓库NPC/比奇新人村_仓库-0140-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_22(human)--仓库NPC/比奇新人村_仓库-0140-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1005_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_32(human)--仓库NPC/比奇新人村_仓库-0140-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_23(human)--仓库NPC/比奇新人村_仓库-0140-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1005_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_33(human)--仓库NPC/比奇新人村_仓库-0140-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_24(human)--仓库NPC/比奇新人村_仓库-0140-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1005_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_34(human)--仓库NPC/比奇新人村_仓库-0140-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_25(human)--仓库NPC/比奇新人村_仓库-0140-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1005_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_35(human)--仓库NPC/比奇新人村_仓库-0140-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_26(human)--仓库NPC/比奇新人村_仓库-0140-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1005_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1005_36(human)--仓库NPC/比奇新人村_仓库-0140-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1006_0(human)--仓库NPC/盟重土城_仓库-3-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1006_1(human)--仓库NPC/盟重土城_仓库-3-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1006_2(human)--仓库NPC/盟重土城_仓库-3-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1006_3(human)--仓库NPC/盟重土城_仓库-3-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:5,#cffff00,详细说明#L#U#C
#u#lc0000ff:6,#cffff00,密码找回#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1006_6(human)--仓库NPC/盟重土城_仓库-3-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:7,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1006_7(human)--仓库NPC/盟重土城_仓库-3-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1006_5(human)--仓库NPC/盟重土城_仓库-3-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1006_4(human)--仓库NPC/盟重土城_仓库-3-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:8,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:9,#cffff00,交换#L#U#C金币 
#u#lc0000ff:10,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_8(human)--仓库NPC/盟重土城_仓库-3-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:11,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1006_11(human)--仓库NPC/盟重土城_仓库-3-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:8,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_9(human)--仓库NPC/盟重土城_仓库-3-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_12(human)--仓库NPC/盟重土城_仓库-3-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1006_13(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1006_13(human)--仓库NPC/盟重土城_仓库-3-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_10(human)--仓库NPC/盟重土城_仓库-3-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:14,#cffff00,捆#L#U#C药水 
#u#lc0000ff:15,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1006_14(human)--仓库NPC/盟重土城_仓库-3-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:16,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:17,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:18,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:19,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:20,#cffff00,捆#L#U#C金创药
#u#lc0000ff:21,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:10,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1006_15(human)--仓库NPC/盟重土城_仓库-3-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:22,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:23,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:10,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1006_16(human)--仓库NPC/盟重土城_仓库-3-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1006_26(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_26(human)--仓库NPC/盟重土城_仓库-3-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_17(human)--仓库NPC/盟重土城_仓库-3-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1006_27(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_27(human)--仓库NPC/盟重土城_仓库-3-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_18(human)--仓库NPC/盟重土城_仓库-3-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1006_28(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_28(human)--仓库NPC/盟重土城_仓库-3-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_19(human)--仓库NPC/盟重土城_仓库-3-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1006_29(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_29(human)--仓库NPC/盟重土城_仓库-3-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_20(human)--仓库NPC/盟重土城_仓库-3-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1006_30(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_30(human)--仓库NPC/盟重土城_仓库-3-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_21(human)--仓库NPC/盟重土城_仓库-3-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1006_31(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_31(human)--仓库NPC/盟重土城_仓库-3-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_22(human)--仓库NPC/盟重土城_仓库-3-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1006_32(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_32(human)--仓库NPC/盟重土城_仓库-3-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_23(human)--仓库NPC/盟重土城_仓库-3-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1006_33(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_33(human)--仓库NPC/盟重土城_仓库-3-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_24(human)--仓库NPC/盟重土城_仓库-3-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1006_34(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_34(human)--仓库NPC/盟重土城_仓库-3-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_25(human)--仓库NPC/盟重土城_仓库-3-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1006_35(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1006_35(human)--仓库NPC/盟重土城_仓库-3-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1007_0(human)--仓库NPC/盟重土城_仓库-0145-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1007_1(human)--仓库NPC/盟重土城_仓库-0145-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1007_2(human)--仓库NPC/盟重土城_仓库-0145-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1007_3(human)--仓库NPC/盟重土城_仓库-0145-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:5,#cffff00,详细说明#L#U#C
#u#lc0000ff:6,#cffff00,密码找回#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1007_6(human)--仓库NPC/盟重土城_仓库-0145-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:7,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1007_7(human)--仓库NPC/盟重土城_仓库-0145-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1007_5(human)--仓库NPC/盟重土城_仓库-0145-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1007_4(human)--仓库NPC/盟重土城_仓库-0145-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:8,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:9,#cffff00,交换#L#U#C金币 
#u#lc0000ff:10,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_8(human)--仓库NPC/盟重土城_仓库-0145-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:11,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1007_11(human)--仓库NPC/盟重土城_仓库-0145-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:8,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_9(human)--仓库NPC/盟重土城_仓库-0145-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_12(human)--仓库NPC/盟重土城_仓库-0145-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1007_13(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1007_13(human)--仓库NPC/盟重土城_仓库-0145-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_10(human)--仓库NPC/盟重土城_仓库-0145-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:14,#cffff00,捆#L#U#C药水 
#u#lc0000ff:15,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1007_14(human)--仓库NPC/盟重土城_仓库-0145-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:16,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:17,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:18,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:19,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:20,#cffff00,捆#L#U#C金创药
#u#lc0000ff:21,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:10,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1007_15(human)--仓库NPC/盟重土城_仓库-0145-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:22,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:23,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:10,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1007_16(human)--仓库NPC/盟重土城_仓库-0145-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1007_26(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_26(human)--仓库NPC/盟重土城_仓库-0145-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_17(human)--仓库NPC/盟重土城_仓库-0145-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1007_27(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_27(human)--仓库NPC/盟重土城_仓库-0145-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_18(human)--仓库NPC/盟重土城_仓库-0145-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1007_28(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_28(human)--仓库NPC/盟重土城_仓库-0145-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_19(human)--仓库NPC/盟重土城_仓库-0145-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1007_29(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_29(human)--仓库NPC/盟重土城_仓库-0145-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_20(human)--仓库NPC/盟重土城_仓库-0145-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1007_30(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_30(human)--仓库NPC/盟重土城_仓库-0145-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_21(human)--仓库NPC/盟重土城_仓库-0145-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1007_31(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_31(human)--仓库NPC/盟重土城_仓库-0145-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:14,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_22(human)--仓库NPC/盟重土城_仓库-0145-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1007_32(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_32(human)--仓库NPC/盟重土城_仓库-0145-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_23(human)--仓库NPC/盟重土城_仓库-0145-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1007_33(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_33(human)--仓库NPC/盟重土城_仓库-0145-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_24(human)--仓库NPC/盟重土城_仓库-0145-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1007_34(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_34(human)--仓库NPC/盟重土城_仓库-0145-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_25(human)--仓库NPC/盟重土城_仓库-0145-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1007_35(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1007_35(human)--仓库NPC/盟重土城_仓库-0145-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1008_0(human)--仓库NPC/盟重土城_商人-0146-@main
	local sayret = nil
	if true then
		sayret = [[
你知道我是谁吗？ 
告诉你我是何等人物...
你要试一下吗..？说说看需要我帮你做什么？ 
#u#lc0000ff:1,#cffff00,了解金条#L#U#C
#u#lc0000ff:2,#cffff00,了解金砖#L#U#C
#u#lc0000ff:3,#cffff00,了解金盒#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1008_1(human)--仓库NPC/盟重土城_商人-0146-@gold100
	local sayret = nil
	if true then
		sayret = [[
关于金条，我所能做的事情是：
将金条换成金币或将金币换成金条。一个金条的价值
是#c00ff00,100万金币#C。记住了，你需要我为你做什么？ 
#u#lc0000ff:4,#cffff00,将金币换成金条#L#U#C 
#u#lc0000ff:5,#cffff00,将金条换成金币#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_2(human)--仓库NPC/盟重土城_商人-0146-@gold500
	local sayret = nil
	if true then
		sayret = [[
关于金砖，我所能做的是：
将金砖换成金条或将金条换成金砖。一个金砖的价值
等于#c00ff00,5个金条#C。你需要我为你做什么？ 
#u#lc0000ff:6,#cffff00,金条换成金砖#L#U#C
#u#lc0000ff:7,#cffff00,金砖换成金条#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_3(human)--仓库NPC/盟重土城_商人-0146-@gold1000
	local sayret = nil
	if true then
		sayret = [[
关于金盒，我所能做的是：
将金盒换成金砖或将金砖换成金盒。一个金盒的价值
等于#c00ff00,2个金砖#C，你需要为你做什么？ 
#u#lc0000ff:8,#cffff00,金砖换成金盒#L#U#C
#u#lc0000ff:9,#cffff00,金盒换成金砖#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_6(human)--仓库NPC/盟重土城_商人-0146-@Change5Set
	local sayret = nil
	if human:检查物品数量(10317,5) and true then
		sayret = [[
你想用金条换金砖？
好，我可以帮你换但是你要支付手续费...
手续费是12000金币，要换吗？ 
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你没有5个金条，要我怎么帮你换？
等你有足够的金条，再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_10(human)--仓库NPC/盟重土城_商人-0146-@Change5Set_1
	local sayret = nil
	if human:检查物品数量(10317,5) and human:获取金币()>=12000 and true then
		human:收回物品(10317,5)
		human:收回物品(10002,12000)
		human:获得物品(10231,1)
		sayret = [[
金条已经换好金砖。继续换吗？  
#u#lc0000ff:6,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
没有金条，或没有足够的手续费。
重新确认一下吧... 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1008_7(human)--仓库NPC/盟重土城_商人-0146-@Reverse5Set
	local sayret = nil
	if human:检查物品数量(10231,1) and true then
		sayret = [[
你要将金砖换成金条？
好，我帮你换。但是你要支付手续费...
手续费是12000金币，要换吗？  
#u#lc0000ff:11,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你没有金砖还要我换什么？
等准备好金砖之后再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_11(human)--仓库NPC/盟重土城_商人-0146-@Reverse5Set_1
	local sayret = nil
	if human:检查物品数量(10231,1) and human:获取金币()>=12000 and true then
		human:收回物品(10231,1)
		human:收回物品(10002,12000)
		human:获得物品(10317,5)
		sayret = [[
金砖已经换好金条。
还要继续换吗？  
#u#lc0000ff:7,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
背包已满或没有金砖、没有足够的手续费支付。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1008_8(human)--仓库NPC/盟重土城_商人-0146-@Change10Set
	local sayret = nil
	if human:检查物品数量(10231,2) and true then
		sayret = [[
你要将金砖换成金盒？ 
好，我帮你换不过你要支付手续费...
手续费是10000金币，还要换吗？ 
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你连2个金砖都没有，还叫我换什么？
等你有足够的金砖之后再来找我把... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_12(human)--仓库NPC/盟重土城_商人-0146-@Change10Set_1
	local sayret = nil
	if human:检查物品数量(10231,2) and human:获取金币()>=10000 and true then
		human:收回物品(10231,2)
		human:收回物品(10002,10000)
		human:获得物品(10318,1)
		sayret = [[
我已经把金砖换好金盒。
还继续换吗？ 
#u#lc0000ff:8,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
没有金砖或没有足够的金币支付手续费。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1008_9(human)--仓库NPC/盟重土城_商人-0146-@Reverse10Set
	local sayret = nil
	if human:检查物品数量(10318,1) and true then
		sayret = [[
你想把金盒换成金砖？
好，我帮你换。不过你要支付一定的手续费...
手续费是10000金币，你要换吗？ 
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金盒，还叫我换什么？
等准备好金盒之后再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_13(human)--仓库NPC/盟重土城_商人-0146-@Reverse10Set_1
	local sayret = nil
	if human:检查物品数量(10318,1) and human:获取金币()>=10000 and true then
		human:收回物品(10318,1)
		human:收回物品(10002,10000)
		human:获得物品(10231,2)
		sayret = [[
金盒已经换成金砖。
还继续换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
背包已满或没有金盒、没有足够的手续费支付。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1008_4(human)--仓库NPC/盟重土城_商人-0146-@Change
	local sayret = nil
	if human:获取金币()>=1000000 and true then
		sayret = [[
你想用金币换金条？
好，我可以帮你换。
不过你要支付一定的手续费。
手续费是2000金币，你还换吗？ 
#u#lc0000ff:14,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱，还叫我换什么？
等有钱之后再来找我吧。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1008_14(human)--仓库NPC/盟重土城_商人-0146-@Change_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条。
还继续换吗？ 
#u#lc0000ff:4,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
包里东西已满或没有足够的手续费可支付。
重新确认一下吧... 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1008_5(human)--仓库NPC/盟重土城_商人-0146-@Reverse
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你想用金条换金币？
好，我可以帮你换。不过你要支付一定的手续费。
手续费是2000金币，你还换吗？ 
#u#lc0000ff:15,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条，还叫我换什么？ 
你在和我开玩笑？快在我面前消失！ 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1008_15(human)--仓库NPC/盟重土城_商人-0146-@Reverse_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想帮你换。
但是你的金币太多了，我不能给你换。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = call_1008_16(human) or sayret--@Reverse_2
	end
	return sayret
end

function call_1008_16(human)--仓库NPC/盟重土城_商人-0146-@Reverse_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币。
还继续换吗？ 
#u#lc0000ff:5,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end
function call_1009_0(human)--仓库NPC/沙巴克_仓库-0152-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1009_1(human)--仓库NPC/沙巴克_仓库-0152-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1009_2(human)--仓库NPC/沙巴克_仓库-0152-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1009_3(human)--仓库NPC/沙巴克_仓库-0152-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1009_7(human)--仓库NPC/沙巴克_仓库-0152-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1009_8(human)--仓库NPC/沙巴克_仓库-0152-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1009_6(human)--仓库NPC/沙巴克_仓库-0152-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1009_4(human)--仓库NPC/沙巴克_仓库-0152-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_9(human)--仓库NPC/沙巴克_仓库-0152-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1009_12(human)--仓库NPC/沙巴克_仓库-0152-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_10(human)--仓库NPC/沙巴克_仓库-0152-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_13(human)--仓库NPC/沙巴克_仓库-0152-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1009_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1009_14(human)--仓库NPC/沙巴克_仓库-0152-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_11(human)--仓库NPC/沙巴克_仓库-0152-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1009_15(human)--仓库NPC/沙巴克_仓库-0152-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1009_16(human)--仓库NPC/沙巴克_仓库-0152-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1009_17(human)--仓库NPC/沙巴克_仓库-0152-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1009_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_27(human)--仓库NPC/沙巴克_仓库-0152-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_18(human)--仓库NPC/沙巴克_仓库-0152-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1009_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_28(human)--仓库NPC/沙巴克_仓库-0152-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_19(human)--仓库NPC/沙巴克_仓库-0152-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1009_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_29(human)--仓库NPC/沙巴克_仓库-0152-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_20(human)--仓库NPC/沙巴克_仓库-0152-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1009_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_30(human)--仓库NPC/沙巴克_仓库-0152-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_21(human)--仓库NPC/沙巴克_仓库-0152-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1009_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_31(human)--仓库NPC/沙巴克_仓库-0152-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_22(human)--仓库NPC/沙巴克_仓库-0152-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1009_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_32(human)--仓库NPC/沙巴克_仓库-0152-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_23(human)--仓库NPC/沙巴克_仓库-0152-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1009_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_33(human)--仓库NPC/沙巴克_仓库-0152-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_24(human)--仓库NPC/沙巴克_仓库-0152-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1009_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_34(human)--仓库NPC/沙巴克_仓库-0152-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_25(human)--仓库NPC/沙巴克_仓库-0152-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1009_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_35(human)--仓库NPC/沙巴克_仓库-0152-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_26(human)--仓库NPC/沙巴克_仓库-0152-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1009_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1009_36(human)--仓库NPC/沙巴克_仓库-0152-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1010_0(human)--仓库NPC/沙巴克_商人-0152-@main
	local sayret = nil
	if true then
		sayret = [[
你知道我是谁吗？ 
告诉你我是何等人物...
你要试一下吗..？说说看需要我帮你做什么？ 
#u#lc0000ff:1,#cffff00,了解金条#L#U#C
#u#lc0000ff:2,#cffff00,了解金砖#L#U#C
#u#lc0000ff:3,#cffff00,了解金盒#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1010_1(human)--仓库NPC/沙巴克_商人-0152-@gold100
	local sayret = nil
	if true then
		sayret = [[
关于金条，我所能做的事情是：
将金条换成金币或将金币换成金条。一个金条的价值
是#c00ff00,100万金币#C。记住了，你需要我为你做什么？ 
#u#lc0000ff:4,#cffff00,将金币换成金条#L#U#C 
#u#lc0000ff:5,#cffff00,将金条换成金币#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_2(human)--仓库NPC/沙巴克_商人-0152-@gold500
	local sayret = nil
	if true then
		sayret = [[
关于金砖，我所能做的是：
将金砖换成金条或将金条换成金砖。一个金砖的价值
等于#c00ff00,5个金条#C。你需要我为你做什么？ 
#u#lc0000ff:6,#cffff00,金条换成金砖#L#U#C
#u#lc0000ff:7,#cffff00,金砖换成金条#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_3(human)--仓库NPC/沙巴克_商人-0152-@gold1000
	local sayret = nil
	if true then
		sayret = [[
关于金盒，我所能做的是：
将金盒换成金砖或将金砖换成金盒。一个金盒的价值
等于#c00ff00,2个金砖#C，你需要为你做什么？ 
#u#lc0000ff:8,#cffff00,金砖换成金盒#L#U#C
#u#lc0000ff:9,#cffff00,金盒换成金砖#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_6(human)--仓库NPC/沙巴克_商人-0152-@Change5Set
	local sayret = nil
	if human:检查物品数量(10317,5) and true then
		sayret = [[
你想用金条换金砖？
好，我可以帮你换但是你要支付手续费...
手续费是12000金币，要换吗？ 
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你没有5个金条，要我怎么帮你换？
等你有足够的金条，再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_10(human)--仓库NPC/沙巴克_商人-0152-@Change5Set_1
	local sayret = nil
	if human:检查物品数量(10317,5) and human:获取金币()>=12000 and true then
		human:收回物品(10317,5)
		human:收回物品(10002,12000)
		human:获得物品(10231,1)
		sayret = [[
金条已经换好金砖。继续换吗？  
#u#lc0000ff:6,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
没有金条，或没有足够的手续费。
重新确认一下吧... 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1010_7(human)--仓库NPC/沙巴克_商人-0152-@Reverse5Set
	local sayret = nil
	if human:检查物品数量(10231,1) and true then
		sayret = [[
你要将金砖换成金条？
好，我帮你换。但是你要支付手续费...
手续费是12000金币，要换吗？  
#u#lc0000ff:11,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你没有金砖还要我换什么？
等准备好金砖之后再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_11(human)--仓库NPC/沙巴克_商人-0152-@Reverse5Set_1
	local sayret = nil
	if human:检查物品数量(10231,1) and human:获取金币()>=12000 and true then
		human:收回物品(10231,1)
		human:收回物品(10002,12000)
		human:获得物品(10317,5)
		sayret = [[
金砖已经换好金条。
还要继续换吗？  
#u#lc0000ff:7,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
背包已满或没有金砖、没有足够的手续费支付。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1010_8(human)--仓库NPC/沙巴克_商人-0152-@Change10Set
	local sayret = nil
	if human:检查物品数量(10231,2) and true then
		sayret = [[
你要将金砖换成金盒？ 
好，我帮你换不过你要支付手续费...
手续费是10000金币，还要换吗？ 
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你连2个金砖都没有，还叫我换什么？
等你有足够的金砖之后再来找我把... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_12(human)--仓库NPC/沙巴克_商人-0152-@Change10Set_1
	local sayret = nil
	if human:检查物品数量(10231,2) and human:获取金币()>=10000 and true then
		human:收回物品(10231,2)
		human:收回物品(10002,10000)
		human:获得物品(10318,1)
		sayret = [[
我已经把金砖换好金盒。
还继续换吗？ 
#u#lc0000ff:8,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
没有金砖或没有足够的金币支付手续费。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1010_9(human)--仓库NPC/沙巴克_商人-0152-@Reverse10Set
	local sayret = nil
	if human:检查物品数量(10318,1) and true then
		sayret = [[
你想把金盒换成金砖？
好，我帮你换。不过你要支付一定的手续费...
手续费是10000金币，你要换吗？ 
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金盒，还叫我换什么？
等准备好金盒之后再来找我吧... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_13(human)--仓库NPC/沙巴克_商人-0152-@Reverse10Set_1
	local sayret = nil
	if human:检查物品数量(10318,1) and human:获取金币()>=10000 and true then
		human:收回物品(10318,1)
		human:收回物品(10002,10000)
		human:获得物品(10231,2)
		sayret = [[
金盒已经换成金砖。
还继续换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
背包已满或没有金盒、没有足够的手续费支付。
重新确认一下吧。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1010_4(human)--仓库NPC/沙巴克_商人-0152-@Change
	local sayret = nil
	if human:获取金币()>=1000000 and true then
		sayret = [[
你想用金币换金条？
好，我可以帮你换。
不过你要支付一定的手续费。
手续费是2000金币，你还换吗？ 
#u#lc0000ff:14,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱，还叫我换什么？
等有钱之后再来找我吧。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1010_14(human)--仓库NPC/沙巴克_商人-0152-@Change_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条。
还继续换吗？ 
#u#lc0000ff:4,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
包里东西已满或没有足够的手续费可支付。
重新确认一下吧... 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1010_5(human)--仓库NPC/沙巴克_商人-0152-@Reverse
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你想用金条换金币？
好，我可以帮你换。不过你要支付一定的手续费。
手续费是2000金币，你还换吗？ 
#u#lc0000ff:15,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条，还叫我换什么？ 
你在和我开玩笑？快在我面前消失！ 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1010_15(human)--仓库NPC/沙巴克_商人-0152-@Reverse_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想帮你换。
但是你的金币太多了，我不能给你换。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	elseif true then
		sayret = call_1010_16(human) or sayret--@Reverse_2
	end
	return sayret
end

function call_1010_16(human)--仓库NPC/沙巴克_商人-0152-@Reverse_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币。
还继续换吗？ 
#u#lc0000ff:5,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end
function call_1011_0(human)--仓库NPC/白日门_仓库-11-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1011_1(human)--仓库NPC/白日门_仓库-11-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1011_2(human)--仓库NPC/白日门_仓库-11-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1011_3(human)--仓库NPC/白日门_仓库-11-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1011_7(human)--仓库NPC/白日门_仓库-11-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1011_8(human)--仓库NPC/白日门_仓库-11-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1011_6(human)--仓库NPC/白日门_仓库-11-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1011_4(human)--仓库NPC/白日门_仓库-11-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_9(human)--仓库NPC/白日门_仓库-11-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1011_12(human)--仓库NPC/白日门_仓库-11-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_10(human)--仓库NPC/白日门_仓库-11-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_13(human)--仓库NPC/白日门_仓库-11-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1011_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1011_14(human)--仓库NPC/白日门_仓库-11-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_11(human)--仓库NPC/白日门_仓库-11-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1011_15(human)--仓库NPC/白日门_仓库-11-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1011_16(human)--仓库NPC/白日门_仓库-11-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1011_17(human)--仓库NPC/白日门_仓库-11-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1011_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_27(human)--仓库NPC/白日门_仓库-11-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_18(human)--仓库NPC/白日门_仓库-11-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1011_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_28(human)--仓库NPC/白日门_仓库-11-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_19(human)--仓库NPC/白日门_仓库-11-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1011_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_29(human)--仓库NPC/白日门_仓库-11-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_20(human)--仓库NPC/白日门_仓库-11-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1011_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_30(human)--仓库NPC/白日门_仓库-11-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_21(human)--仓库NPC/白日门_仓库-11-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1011_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_31(human)--仓库NPC/白日门_仓库-11-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_22(human)--仓库NPC/白日门_仓库-11-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1011_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_32(human)--仓库NPC/白日门_仓库-11-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_23(human)--仓库NPC/白日门_仓库-11-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1011_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_33(human)--仓库NPC/白日门_仓库-11-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_24(human)--仓库NPC/白日门_仓库-11-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1011_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_34(human)--仓库NPC/白日门_仓库-11-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_25(human)--仓库NPC/白日门_仓库-11-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1011_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_35(human)--仓库NPC/白日门_仓库-11-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_26(human)--仓库NPC/白日门_仓库-11-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1011_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1011_36(human)--仓库NPC/白日门_仓库-11-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1012_0(human)--仓库NPC/封魔谷_仓库-b347-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1012_1(human)--仓库NPC/封魔谷_仓库-b347-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1012_2(human)--仓库NPC/封魔谷_仓库-b347-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1012_3(human)--仓库NPC/封魔谷_仓库-b347-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1012_7(human)--仓库NPC/封魔谷_仓库-b347-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1012_8(human)--仓库NPC/封魔谷_仓库-b347-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1012_6(human)--仓库NPC/封魔谷_仓库-b347-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1012_4(human)--仓库NPC/封魔谷_仓库-b347-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_9(human)--仓库NPC/封魔谷_仓库-b347-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1012_12(human)--仓库NPC/封魔谷_仓库-b347-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_10(human)--仓库NPC/封魔谷_仓库-b347-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_13(human)--仓库NPC/封魔谷_仓库-b347-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1012_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1012_14(human)--仓库NPC/封魔谷_仓库-b347-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_11(human)--仓库NPC/封魔谷_仓库-b347-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1012_15(human)--仓库NPC/封魔谷_仓库-b347-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1012_16(human)--仓库NPC/封魔谷_仓库-b347-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1012_17(human)--仓库NPC/封魔谷_仓库-b347-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1012_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_27(human)--仓库NPC/封魔谷_仓库-b347-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_18(human)--仓库NPC/封魔谷_仓库-b347-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1012_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_28(human)--仓库NPC/封魔谷_仓库-b347-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_19(human)--仓库NPC/封魔谷_仓库-b347-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1012_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_29(human)--仓库NPC/封魔谷_仓库-b347-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_20(human)--仓库NPC/封魔谷_仓库-b347-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1012_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_30(human)--仓库NPC/封魔谷_仓库-b347-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_21(human)--仓库NPC/封魔谷_仓库-b347-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1012_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_31(human)--仓库NPC/封魔谷_仓库-b347-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_22(human)--仓库NPC/封魔谷_仓库-b347-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1012_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_32(human)--仓库NPC/封魔谷_仓库-b347-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_23(human)--仓库NPC/封魔谷_仓库-b347-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1012_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_33(human)--仓库NPC/封魔谷_仓库-b347-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_24(human)--仓库NPC/封魔谷_仓库-b347-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1012_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_34(human)--仓库NPC/封魔谷_仓库-b347-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_25(human)--仓库NPC/封魔谷_仓库-b347-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1012_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_35(human)--仓库NPC/封魔谷_仓库-b347-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_26(human)--仓库NPC/封魔谷_仓库-b347-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1012_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1012_36(human)--仓库NPC/封魔谷_仓库-b347-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1013_0(human)--仓库NPC/苍月岛_仓库-5-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1013_1(human)--仓库NPC/苍月岛_仓库-5-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1013_2(human)--仓库NPC/苍月岛_仓库-5-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1013_3(human)--仓库NPC/苍月岛_仓库-5-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1013_7(human)--仓库NPC/苍月岛_仓库-5-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1013_8(human)--仓库NPC/苍月岛_仓库-5-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1013_6(human)--仓库NPC/苍月岛_仓库-5-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1013_4(human)--仓库NPC/苍月岛_仓库-5-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_9(human)--仓库NPC/苍月岛_仓库-5-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1013_12(human)--仓库NPC/苍月岛_仓库-5-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_10(human)--仓库NPC/苍月岛_仓库-5-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_13(human)--仓库NPC/苍月岛_仓库-5-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1013_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1013_14(human)--仓库NPC/苍月岛_仓库-5-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_11(human)--仓库NPC/苍月岛_仓库-5-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1013_15(human)--仓库NPC/苍月岛_仓库-5-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1013_16(human)--仓库NPC/苍月岛_仓库-5-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1013_17(human)--仓库NPC/苍月岛_仓库-5-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1013_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_27(human)--仓库NPC/苍月岛_仓库-5-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_18(human)--仓库NPC/苍月岛_仓库-5-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1013_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_28(human)--仓库NPC/苍月岛_仓库-5-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_19(human)--仓库NPC/苍月岛_仓库-5-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1013_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_29(human)--仓库NPC/苍月岛_仓库-5-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_20(human)--仓库NPC/苍月岛_仓库-5-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1013_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_30(human)--仓库NPC/苍月岛_仓库-5-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_21(human)--仓库NPC/苍月岛_仓库-5-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1013_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_31(human)--仓库NPC/苍月岛_仓库-5-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_22(human)--仓库NPC/苍月岛_仓库-5-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1013_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_32(human)--仓库NPC/苍月岛_仓库-5-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_23(human)--仓库NPC/苍月岛_仓库-5-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1013_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_33(human)--仓库NPC/苍月岛_仓库-5-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_24(human)--仓库NPC/苍月岛_仓库-5-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1013_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_34(human)--仓库NPC/苍月岛_仓库-5-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_25(human)--仓库NPC/苍月岛_仓库-5-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1013_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_35(human)--仓库NPC/苍月岛_仓库-5-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_26(human)--仓库NPC/苍月岛_仓库-5-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1013_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1013_36(human)--仓库NPC/苍月岛_仓库-5-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1014_0(human)--仓库NPC/仓库管理员-H003-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1014_1(human)--仓库NPC/仓库管理员-H003-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1014_2(human)--仓库NPC/仓库管理员-H003-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1014_3(human)--仓库NPC/仓库管理员-H003-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1014_7(human)--仓库NPC/仓库管理员-H003-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1014_8(human)--仓库NPC/仓库管理员-H003-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1014_6(human)--仓库NPC/仓库管理员-H003-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1014_4(human)--仓库NPC/仓库管理员-H003-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_9(human)--仓库NPC/仓库管理员-H003-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1014_12(human)--仓库NPC/仓库管理员-H003-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_10(human)--仓库NPC/仓库管理员-H003-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_13(human)--仓库NPC/仓库管理员-H003-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1014_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1014_14(human)--仓库NPC/仓库管理员-H003-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_11(human)--仓库NPC/仓库管理员-H003-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1014_15(human)--仓库NPC/仓库管理员-H003-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1014_16(human)--仓库NPC/仓库管理员-H003-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1014_17(human)--仓库NPC/仓库管理员-H003-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1014_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_27(human)--仓库NPC/仓库管理员-H003-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_18(human)--仓库NPC/仓库管理员-H003-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1014_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_28(human)--仓库NPC/仓库管理员-H003-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_19(human)--仓库NPC/仓库管理员-H003-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1014_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_29(human)--仓库NPC/仓库管理员-H003-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_20(human)--仓库NPC/仓库管理员-H003-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1014_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_30(human)--仓库NPC/仓库管理员-H003-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_21(human)--仓库NPC/仓库管理员-H003-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1014_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_31(human)--仓库NPC/仓库管理员-H003-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_22(human)--仓库NPC/仓库管理员-H003-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1014_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_32(human)--仓库NPC/仓库管理员-H003-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_23(human)--仓库NPC/仓库管理员-H003-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1014_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_33(human)--仓库NPC/仓库管理员-H003-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_24(human)--仓库NPC/仓库管理员-H003-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1014_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_34(human)--仓库NPC/仓库管理员-H003-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_25(human)--仓库NPC/仓库管理员-H003-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1014_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_35(human)--仓库NPC/仓库管理员-H003-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_26(human)--仓库NPC/仓库管理员-H003-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1014_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1014_36(human)--仓库NPC/仓库管理员-H003-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1015_0(human)--仓库NPC/仓库管理员-H007-@main
	local sayret = nil
	if true then
		sayret = [[
您好。我是仓库保管员。为了您的仓库又#c00ff00,方便#C又#c00ff00,安全#C。
我为您提供以下仓库服务功能： 
#u#lc0000ff:1,#cffff00,存放物品#L#U#C
#u#lc0000ff:2,#cffff00,取回物品#L#U#C
#u#lc0000ff:3,#cffff00,加密仓库#L#U#C
#u#lc0000ff:4,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1015_1(human)--仓库NPC/仓库管理员-H007-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1015_2(human)--仓库NPC/仓库管理员-H007-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1015_3(human)--仓库NPC/仓库管理员-H007-@jiami
	local sayret = nil
	if true then
		sayret = [[
全新的仓库保护系统，可锁定仓库，设置仓库密码，修改仓库密码，
下线后自动锁定仓库，锁定仓库后玩家不能交易等等。 
#u#lc0000ff:6,#cffff00,详细说明#L#U#C
#u#lc0000ff:7,#cffff00,密码找回#L#U#C
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1015_7(human)--仓库NPC/仓库管理员-H007-@mimazhao
	local sayret = nil
	if true then
		sayret = [[
本服务是收费服务，请以后牢记自己的密码，以免给您带来
不必要的损失！本服务需要费用为5万元，申请服务后，在第
二天(或者今天)中午12:00登录后，服务器将自动清除您的
仓库密码。清除密码成功后服务器将会提示您！谢谢您的合作！ 
#u#lc0000ff:8,#cffff00,找回密码#L#U#C
#u#lc0000ff:-1,#cffff00,来看看#L#U#C
]]
	end
	return sayret
end

function call_1015_8(human)--仓库NPC/仓库管理员-H007-@qcqkmm-001
	local sayret = nil
	if human:获取金币()>=50000 and true then
		sayret = [[
提交清除密码申请成功！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
		human:收回物品(10002,50000)
		写文件内容("申请清除密码名单.txt",human:获取名字())
	elseif true then
		sayret = [[
对不起,您没有足够的金钱来使用我们的服务。 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1015_6(human)--仓库NPC/仓库管理员-H007-@readme
	local sayret = nil
	if true then
		sayret = [[
新加的密码仓库系统指令说明:
修改密码：命令为#c00ff00,@修改密码#C
设置密码：命令为#c00ff00,@设置密码#C
锁定仓库：命令为#c00ff00,@锁定仓库#C
解锁仓库：命令为#c00ff00,@开锁#C 
#u#lc0000ff:5,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1015_4(human)--仓库NPC/仓库管理员-H007-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:9,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:10,#cffff00,交换#L#U#C金币 
#u#lc0000ff:11,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_9(human)--仓库NPC/仓库管理员-H007-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:12,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1015_12(human)--仓库NPC/仓库管理员-H007-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:9,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_10(human)--仓库NPC/仓库管理员-H007-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:13,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_13(human)--仓库NPC/仓库管理员-H007-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1015_14(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1015_14(human)--仓库NPC/仓库管理员-H007-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:10,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_11(human)--仓库NPC/仓库管理员-H007-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:15,#cffff00,捆#L#U#C药水 
#u#lc0000ff:16,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1015_15(human)--仓库NPC/仓库管理员-H007-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:17,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:18,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:19,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:20,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:21,#cffff00,捆#L#U#C金创药
#u#lc0000ff:22,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1015_16(human)--仓库NPC/仓库管理员-H007-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:23,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:24,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:25,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:26,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:11,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1015_17(human)--仓库NPC/仓库管理员-H007-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1015_27(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_27(human)--仓库NPC/仓库管理员-H007-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_18(human)--仓库NPC/仓库管理员-H007-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1015_28(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_28(human)--仓库NPC/仓库管理员-H007-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_19(human)--仓库NPC/仓库管理员-H007-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1015_29(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_29(human)--仓库NPC/仓库管理员-H007-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_20(human)--仓库NPC/仓库管理员-H007-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1015_30(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_30(human)--仓库NPC/仓库管理员-H007-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_21(human)--仓库NPC/仓库管理员-H007-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1015_31(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_31(human)--仓库NPC/仓库管理员-H007-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_22(human)--仓库NPC/仓库管理员-H007-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1015_32(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_32(human)--仓库NPC/仓库管理员-H007-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:15,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_23(human)--仓库NPC/仓库管理员-H007-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1015_33(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_33(human)--仓库NPC/仓库管理员-H007-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_24(human)--仓库NPC/仓库管理员-H007-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1015_34(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_34(human)--仓库NPC/仓库管理员-H007-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_25(human)--仓库NPC/仓库管理员-H007-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1015_35(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_35(human)--仓库NPC/仓库管理员-H007-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_26(human)--仓库NPC/仓库管理员-H007-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1015_36(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1015_36(human)--仓库NPC/仓库管理员-H007-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:16,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1016_0(human)--【比奇城】/比奇城_肉店-0-@main
	local sayret = nil
	if true then
		sayret = [[
最近我这里可以卖肉.
我会出高价钱购买!
#u#lc0000ff:1,#cffff00,卖#L#U#C
#u#lc0000ff:2,#cffff00,询问#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1016_1(human)--【比奇城】/比奇城_肉店-0-@sell
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,肉#C在鸡，鹿身上暴!
其他的就是相关怪物身上暴!
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end

function call_1016_2(human)--【比奇城】/比奇城_肉店-0-@meathelp
	local sayret = nil
	if true then
		sayret = [[
肉可以从鸡、鹿、羊身上割的，先打这些怪物，小心碰到
被比自己厉害的怪物打死，打死怪物之后，按alt键，把鼠标
放在怪物尸体上，您就会看到自己割肉的样子。过一会儿，
您的包里就会放着一个大肉块。对了，差一点忘了告诉你，
企图逃跑的怪物品质更好。用魔法打的怪物，其品质会变成0，
这一点千万记住。 
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end
function call_1017_0(human)--【比奇城】/比奇城_药店-0-@main
	local sayret = nil
	if true then
		sayret = call_1017_1(human) or sayret--Market\Market0@Markets
		sayret = call_1017_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1017_1(human)--【比奇城】/比奇城_药店-0-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1017_3(human)--【比奇城】/比奇城_药店-0-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1017_4(human)--【比奇城】/比奇城_药店-0-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1017_2(human)--【比奇城】/比奇城_药店-0-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1018_0(human)--【比奇城】/比奇城_书店-0-@main
	local sayret = nil
	if true then
		sayret = call_1018_1(human) or sayret--Market\Market2@Markets
		sayret = call_1018_2(human) or sayret--Market\书店@7
	end
	return sayret
end

function call_1018_1(human)--【比奇城】/比奇城_书店-0-Market\Market2@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，你想买些修炼的书吗？ 
#u#lc0000ff:3,#cffff00,购买书籍#L#U#C
#u#lc0000ff:4,#cffff00,出售书籍#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1018_3(human)--【比奇城】/比奇城_书店-0-Market\Market2@buy
	local sayret = nil
	if true then
		sayret = [[
以下是本店所有书籍的清单，请挑选你想要书籍。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1018_4(human)--【比奇城】/比奇城_书店-0-Market\Market2@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的书籍给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1018_2(human)--【比奇城】/比奇城_书店-0-Market\书店@7
	local sayret = nil
	return sayret
end
function call_1019_0(human)--【比奇城】/比奇城_杂货铺-0-@main
	local sayret = nil
	if true then
		sayret = call_1019_1(human) or sayret--Market\Market3@Markets
		sayret = call_1019_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1019_1(human)--【比奇城】/比奇城_杂货铺-0-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1019_3(human)--【比奇城】/比奇城_杂货铺-0-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1019_4(human)--【比奇城】/比奇城_杂货铺-0-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1019_5(human)--【比奇城】/比奇城_杂货铺-0-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1019_2(human)--【比奇城】/比奇城_杂货铺-0-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1020_0(human)--【比奇城】/比奇城_特殊修理-0-@main
	local sayret = nil
	if true then
		sayret = [[
关于武器的问题我愿意为您效劳。
当然除了武器以外的物品我也可以为您试着修理。 
#u#lc0000ff:1,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关    闭#L#U#C
]]
	end
	return sayret
end

function call_1020_1(human)--【比奇城】/比奇城_特殊修理-0-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1021_0(human)--【比奇城】/比奇城_武器店-0103-@main
	local sayret = nil
	if true then
		sayret = call_1021_1(human) or sayret--Market\Market1@Markets
		sayret = call_1021_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1021_2(human)--【比奇城】/比奇城_武器店-0103-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1021_1(human)--【比奇城】/比奇城_武器店-0103-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1021_3(human)--【比奇城】/比奇城_武器店-0103-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1021_4(human)--【比奇城】/比奇城_武器店-0103-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1021_5(human)--【比奇城】/比奇城_武器店-0103-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1021_6(human)--【比奇城】/比奇城_武器店-0103-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1022_0(human)--【比奇城】/比奇城_戒指店-0105-@main
	local sayret = nil
	if true then
		sayret = call_1022_1(human) or sayret--Market\Market1@Markets
		sayret = call_1022_2(human) or sayret--Market\戒指@5
	end
	return sayret
end

function call_1022_2(human)--【比奇城】/比奇城_戒指店-0105-Market\戒指@5
	local sayret = nil
	return sayret
end

function call_1022_1(human)--【比奇城】/比奇城_戒指店-0105-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买戒指#L#U#C
#u#lc0000ff:4,#cffff00,出售戒指#L#U#C
#u#lc0000ff:5,#cffff00,修理戒指#L#U#C
#u#lc0000ff:6,#cffff00,特修戒指#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1022_3(human)--【比奇城】/比奇城_戒指店-0105-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要戒指。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1022_4(human)--【比奇城】/比奇城_戒指店-0105-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的戒指给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1022_5(human)--【比奇城】/比奇城_戒指店-0105-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的戒指给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1022_6(human)--【比奇城】/比奇城_戒指店-0105-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1023_0(human)--【比奇城】/比奇城_手镯店-0105-@main
	local sayret = nil
	if true then
		sayret = call_1023_1(human) or sayret--Market\Market1@Markets
		sayret = call_1023_2(human) or sayret--Market\手镯@4
	end
	return sayret
end

function call_1023_2(human)--【比奇城】/比奇城_手镯店-0105-Market\手镯@4
	local sayret = nil
	return sayret
end

function call_1023_1(human)--【比奇城】/比奇城_手镯店-0105-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买手镯#L#U#C
#u#lc0000ff:4,#cffff00,出售手镯#L#U#C
#u#lc0000ff:5,#cffff00,修理手镯#L#U#C
#u#lc0000ff:6,#cffff00,特修手镯#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1023_3(human)--【比奇城】/比奇城_手镯店-0105-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要手镯。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1023_4(human)--【比奇城】/比奇城_手镯店-0105-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的手镯给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1023_5(human)--【比奇城】/比奇城_手镯店-0105-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的手镯给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1023_6(human)--【比奇城】/比奇城_手镯店-0105-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1024_0(human)--【比奇城】/比奇城_项链店-0105-@main
	local sayret = nil
	if true then
		sayret = call_1024_1(human) or sayret--Market\Market1@Markets
		sayret = call_1024_2(human) or sayret--Market\项链@2
	end
	return sayret
end

function call_1024_2(human)--【比奇城】/比奇城_项链店-0105-Market\项链@2
	local sayret = nil
	return sayret
end

function call_1024_1(human)--【比奇城】/比奇城_项链店-0105-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买项链#L#U#C
#u#lc0000ff:4,#cffff00,出售项链#L#U#C
#u#lc0000ff:5,#cffff00,修理项链#L#U#C
#u#lc0000ff:6,#cffff00,特修项链#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1024_3(human)--【比奇城】/比奇城_项链店-0105-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要项链。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1024_4(human)--【比奇城】/比奇城_项链店-0105-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的项链给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1024_5(human)--【比奇城】/比奇城_项链店-0105-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的项链给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1024_6(human)--【比奇城】/比奇城_项链店-0105-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我这正好有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1025_0(human)--【比奇城】/比奇城_服饰店-0106-@main
	local sayret = nil
	if true then
		sayret = call_1025_1(human) or sayret--Market\Market1@Markets
		sayret = call_1025_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1025_2(human)--【比奇城】/比奇城_服饰店-0106-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1025_1(human)--【比奇城】/比奇城_服饰店-0106-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1025_3(human)--【比奇城】/比奇城_服饰店-0106-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1025_4(human)--【比奇城】/比奇城_服饰店-0106-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1025_5(human)--【比奇城】/比奇城_服饰店-0106-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1025_6(human)--【比奇城】/比奇城_服饰店-0106-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1026_0(human)--【比奇城】/比奇城_炼药店-0109-@main
	local sayret = nil
	if true then
		sayret = call_1026_1(human) or sayret--Market\Market4@Markets
		sayret = call_1026_2(human) or sayret--Market\毒药@9
	end
	return sayret
end

function call_1026_2(human)--【比奇城】/比奇城_炼药店-0109-Market\毒药@9
	local sayret = nil
	return sayret
end

function call_1026_1(human)--【比奇城】/比奇城_炼药店-0109-Market\Market4@Markets
	local sayret = nil
	if true then
		sayret = [[
这地方是做药品买卖的，你需要点什么？当然，如果你要的是可卡因或其他之类精神药品的话，我们可不卖。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,打听#L#U#C药品的解释
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1026_4(human)--【比奇城】/比奇城_炼药店-0109-Market\Market4@helps
	local sayret = nil
	if true then
		sayret = [[
这里我们可以卖2种药品。. 
#u#lc0000ff:5,#cffff00,灰色药粉#L#U#C的效果
#u#lc0000ff:6,#cffff00,黄色药粉#L#U#C的效果
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1026_5(human)--【比奇城】/比奇城_炼药店-0109-Market\Market4@helpdrug1
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用灰色药粉。
如果中了毒，对手的体力值将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1026_6(human)--【比奇城】/比奇城_炼药店-0109-Market\Market4@helpdrug2
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用黄色药粉。
如果中了毒，对手的防御力将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1026_3(human)--【比奇城】/比奇城_炼药店-0109-Market\Market4@buy
	local sayret = nil
	if true then
		sayret = [[
请选择你要购买的药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1027_0(human)--【比奇城】/比奇城_书店-0104-@main
	local sayret = nil
	if true then
		sayret = call_1027_1(human) or sayret--Market\Market2@Markets
		sayret = call_1027_2(human) or sayret--Market\书店@7
	end
	return sayret
end

function call_1027_1(human)--【比奇城】/比奇城_书店-0104-Market\Market2@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，你想买些修炼的书吗？ 
#u#lc0000ff:3,#cffff00,购买书籍#L#U#C
#u#lc0000ff:4,#cffff00,出售书籍#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1027_3(human)--【比奇城】/比奇城_书店-0104-Market\Market2@buy
	local sayret = nil
	if true then
		sayret = [[
以下是本店所有书籍的清单，请挑选你想要书籍。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1027_4(human)--【比奇城】/比奇城_书店-0104-Market\Market2@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的书籍给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1027_2(human)--【比奇城】/比奇城_书店-0104-Market\书店@7
	local sayret = nil
	return sayret
end
function call_1028_0(human)--【比奇城】/比奇城_药店-0108-@main
	local sayret = nil
	if true then
		sayret = call_1028_1(human) or sayret--Market\Market0@Markets
		sayret = call_1028_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1028_1(human)--【比奇城】/比奇城_药店-0108-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1028_3(human)--【比奇城】/比奇城_药店-0108-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1028_4(human)--【比奇城】/比奇城_药店-0108-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1028_2(human)--【比奇城】/比奇城_药店-0108-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1029_0(human)--【银杏村】/银杏新人村_肉店-0-@main
	local sayret = nil
	if true then
		sayret = [[
最近我这里可以卖肉.
我会出高价钱购买!
#u#lc0000ff:1,#cffff00,卖#L#U#C
#u#lc0000ff:2,#cffff00,询问#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1029_1(human)--【银杏村】/银杏新人村_肉店-0-@sell
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,肉#C在鸡，鹿身上暴!
其他的就是相关怪物身上暴!
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end

function call_1029_2(human)--【银杏村】/银杏新人村_肉店-0-@meathelp
	local sayret = nil
	if true then
		sayret = [[
肉可以从鸡、鹿、羊身上割的，先打这些怪物，小心碰到
被比自己厉害的怪物打死，打死怪物之后，按alt键，把鼠标
放在怪物尸体上，您就会看到自己割肉的样子。过一会儿，
您的包里就会放着一个大肉块。对了，差一点忘了告诉你，
企图逃跑的怪物品质更好。用魔法打的怪物，其品质会变成0，
这一点千万记住。 
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end
function call_1030_0(human)--【银杏村】/银杏新人村_杂货铺-0-@main
	local sayret = nil
	if true then
		sayret = call_1030_1(human) or sayret--Market\Market3@Markets
		sayret = call_1030_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1030_1(human)--【银杏村】/银杏新人村_杂货铺-0-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1030_3(human)--【银杏村】/银杏新人村_杂货铺-0-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1030_4(human)--【银杏村】/银杏新人村_杂货铺-0-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1030_5(human)--【银杏村】/银杏新人村_杂货铺-0-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1030_2(human)--【银杏村】/银杏新人村_杂货铺-0-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1031_0(human)--【银杏村】/银杏新人村_武器店-0-@main
	local sayret = nil
	if true then
		sayret = call_1031_1(human) or sayret--Market\Market1@Markets
		sayret = call_1031_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1031_2(human)--【银杏村】/银杏新人村_武器店-0-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1031_1(human)--【银杏村】/银杏新人村_武器店-0-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1031_3(human)--【银杏村】/银杏新人村_武器店-0-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1031_4(human)--【银杏村】/银杏新人村_武器店-0-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1031_5(human)--【银杏村】/银杏新人村_武器店-0-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1031_6(human)--【银杏村】/银杏新人村_武器店-0-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1032_0(human)--【银杏村】/银杏新人村_服饰店-0-@main
	local sayret = nil
	if true then
		sayret = call_1032_1(human) or sayret--Market\Market1@Markets
		sayret = call_1032_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1032_2(human)--【银杏村】/银杏新人村_服饰店-0-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1032_1(human)--【银杏村】/银杏新人村_服饰店-0-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1032_3(human)--【银杏村】/银杏新人村_服饰店-0-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1032_4(human)--【银杏村】/银杏新人村_服饰店-0-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1032_5(human)--【银杏村】/银杏新人村_服饰店-0-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1032_6(human)--【银杏村】/银杏新人村_服饰店-0-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1033_0(human)--【银杏村】/银杏新人村_药店-0119-@main
	local sayret = nil
	if true then
		sayret = call_1033_1(human) or sayret--Market\Market0@Markets
		sayret = call_1033_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1033_1(human)--【银杏村】/银杏新人村_药店-0119-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1033_3(human)--【银杏村】/银杏新人村_药店-0119-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1033_4(human)--【银杏村】/银杏新人村_药店-0119-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1033_2(human)--【银杏村】/银杏新人村_药店-0119-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1034_0(human)--【银杏村】/银杏新人村_炼药店-0119-@main
	local sayret = nil
	if true then
		sayret = call_1034_1(human) or sayret--Market\Market4@Markets
		sayret = call_1034_2(human) or sayret--Market\毒药@9
	end
	return sayret
end

function call_1034_2(human)--【银杏村】/银杏新人村_炼药店-0119-Market\毒药@9
	local sayret = nil
	return sayret
end

function call_1034_1(human)--【银杏村】/银杏新人村_炼药店-0119-Market\Market4@Markets
	local sayret = nil
	if true then
		sayret = [[
这地方是做药品买卖的，你需要点什么？当然，如果你要的是可卡因或其他之类精神药品的话，我们可不卖。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,打听#L#U#C药品的解释
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1034_4(human)--【银杏村】/银杏新人村_炼药店-0119-Market\Market4@helps
	local sayret = nil
	if true then
		sayret = [[
这里我们可以卖2种药品。. 
#u#lc0000ff:5,#cffff00,灰色药粉#L#U#C的效果
#u#lc0000ff:6,#cffff00,黄色药粉#L#U#C的效果
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1034_5(human)--【银杏村】/银杏新人村_炼药店-0119-Market\Market4@helpdrug1
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用灰色药粉。
如果中了毒，对手的体力值将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1034_6(human)--【银杏村】/银杏新人村_炼药店-0119-Market\Market4@helpdrug2
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用黄色药粉。
如果中了毒，对手的防御力将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1034_3(human)--【银杏村】/银杏新人村_炼药店-0119-Market\Market4@buy
	local sayret = nil
	if true then
		sayret = [[
请选择你要购买的药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1035_0(human)--【银杏村】/新人接待员-0-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎来到这个世界。在你面前的将是一个陌生的。
新奇的#c00ff00,全新世界#C。在这个世界中历险需要的是你的#c00ff00,智慧#C与#c00ff00,胆量#C。
不过在经历这些乐趣之前，你必须要拥有#c00ff00,强健#C的体魄！
让我来看看你是什么职业，我好告诉你如何生存下去。
#u#lc0000ff:1,#cffff00,下一步#L#U#C
#u#lc0000ff:2,#cffff00,前往比齐省#L#U#C
#u#lc0000ff:3,#cffff00,前往新手训练地#L#U#C
#u#lc0000ff:4,#cffff00,我要拜师#L#U#C
]]
	end
	return sayret
end

function call_1035_4(human)--【银杏村】/新人接待员-0-@baishi
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,＝师徒系统＝#C
『师父』:人物等级到达#c00ff00,40#C级，就可以收徒弟了！
『徒弟』:人物等级必须在#c00ff00,30#C级以下才能做别人徒弟！
『出师』:徒弟等级到达#c00ff00,40#C级，徒弟自动出师！
『好处』:徒弟出师后师父会自动获得#c00ff00,5点#C声望 
#u#lc0000ff:5,#cffff00,[我要拜师]#L#U#C　　#u#lc0000ff:6,#cffff00,[强行脱离师徒关系]#L#U#C
]]
	end
	return sayret
end

function call_1035_1(human)--【银杏村】/新人接待员-0-@next
	local sayret = nil
	if human:获取职业()==1 and true then
		sayret = [[
你知道吗？你是一名#c00ff00,战士#C哦！
拥有#c00ff00,强健的体魄#C是你最为突出的优势。
无论面对任何险恶的环境你都能进退自如。
不过你这种职业有一点不足之处就是。
没有#c00ff00,远程攻击#C的魔法。在组队中适合和道士共同打猎！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		sayret = call_1035_7(human) or sayret--@next_1_2
	end
	return sayret
end

function call_1035_7(human)--【银杏村】/新人接待员-0-@next_1_2
	local sayret = nil
	if human:获取职业()==3 and true then
		sayret = [[
你是一名伟大的#c00ff00,道士#C。你有着博大的胸怀。
由于你的智慧与胸襟，你所修炼的都是一些博爱的武术。
在打猎的时候你最适合与战士配合。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		sayret = [[
强大的精神力量造就了你——#c00ff00,魔法师#C！
正是因为#c00ff00,精神力的强大#C，你可以学习众多的攻击魔法！
不过在初期，你的#c00ff00,体质#C是最让人担心的！
保护好自己的生命是最重要的！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_2(human)--【银杏村】/新人接待员-0-@biqi
	local sayret = nil
	if human:获取等级()>14 and true then
		human:传送(105,334*48,266*32)
	elseif true then
		sayret = [[
看你的体格很是#c00ff00,脆弱#C。
等到你把级别提升到#c00ff00,15级#C以上再来找我吧。
我告诉你的那个洞里的怪物#c00ff00,经验很高#C的哦。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_3(human)--【银杏村】/新人接待员-0-@next1
	local sayret = nil
	if true then
		sayret = [[
#cff00ff,]]..human:获取名字()..[[#C，你好！这里是新人修炼的地方，建议15级
以下的新人在#c00ff00,新人战场#C修炼！
请选择要去的修炼场！ 
#u#lc0000ff:8,#cffff00,新人战场#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_8(human)--【银杏村】/新人接待员-0-@xiulianyi
	local sayret = nil
	if human:获取等级()>29 and true then
		sayret = call_1035_9(human) or sayret--@next2
		return sayret
	end
	if 检查地图怪物数(137)>=40 and true then
		human:获得物品(10137,1)
		human:传送(137,20*48,22*32)
	elseif true then
		地图刷怪(137,2045,100,20,22,100)
		human:传送(137,20*48,22*32)
		human:获得物品(10137,1)
	end
	return sayret
end

function call_1035_9(human)--【银杏村】/新人接待员-0-@next2
	local sayret = nil
	if true then
		sayret = [[
看看你现在的这个级别吧.
你已经不需要再去这里冲级啦.里面有很多新手.
为了保护新手.我们决定#c00ff00,30级以上#C的玩家无法进入新人战场.
实在抱歉,你可以选择其他冲级的地方.
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_5(human)--【银杏村】/新人接待员-0-@master
	local sayret = nil
	if true then
		sayret = [[
想拜师呀，你要拜的师父来了没有？
与你师父面对面站好，开始拜师。 
#u#lc0000ff:10,#cffff00,准备好了#L#U#C
#u#lc0000ff:-1,#cffff00,我知道了#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_10(human)--【银杏村】/新人接待员-0-@agree
	local sayret = nil
	if true then
		sayret = [[
没事别来这玩！！！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if true then
		sayret = [[
你都都已经拜了别人为师，怎么还拜师！！！  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if true then
		sayret = [[
你找了个什么人做师父，怎么现在还是别人的徒弟？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if human:获取对面站位(0) and true then
	elseif true then
		sayret = [[
你们二个面对面站好呀，不要乱动。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		return sayret
	end
	if true then
		sayret = [[
你都30多级了还要找师父？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if human:获取对面等级()>39 and true then
	elseif true then
		sayret = [[
你找个什么师父呀，等级这么低？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		return sayret
	end
	return sayret
end

function call_1035_11(human)--【银杏村】/新人接待员-0-@StartGetMaster
	local sayret = nil
	if true then
		sayret = [[
拜师仪式正式开始。 
你是否确认拜师？ 
#u#lc0000ff:12,#cffff00,确认#L#U#C
]]
	end
	return sayret
end

function call_1035_13(human)--【银杏村】/新人接待员-0-@StartMaster
	local sayret = nil
	if true then
		sayret = [[
拜师仪式正式开始。 
对方已经向你提出拜师请求。 
]]
	end
	return sayret
end

function call_1035_12(human)--【银杏村】/新人接待员-0-@RequestMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1035_14(human)--【银杏村】/新人接待员-0-@WateMaster
	local sayret = nil
	if true then
		sayret = [[
你已向对方请求拜师，请耐心等待对方的答复。
]]
	end
	return sayret
end

function call_1035_15(human)--【银杏村】/新人接待员-0-@RevMaster
	local sayret = nil
	if true then
		sayret = [[
对方想拜你为师，你是否想收此人为徒？  
#u#lc0000ff:16,#cffff00,同意#L#U#C 
#u#lc0000ff:17,#cffff00,不同意#L#U#C
]]
	end
	return sayret
end

function call_1035_16(human)--【银杏村】/新人接待员-0-@ResposeMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1035_17(human)--【银杏村】/新人接待员-0-@ResposeMasterFail
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1035_18(human)--【银杏村】/新人接待员-0-@EndMaster
	local sayret = nil
	if true then
		sayret = [[
你们二个已经是师徒关系了。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1035_19(human)--【银杏村】/新人接待员-0-@EndMasterFail
	local sayret = nil
	if true then
		sayret = [[
拜师失败！ 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1035_20(human)--【银杏村】/新人接待员-0-@MasterDirErr
	local sayret = nil
	if true then
		sayret = [[
对方没站好位置
]]
	end
	return sayret
end

function call_1035_21(human)--【银杏村】/新人接待员-0-@MasterCheckDir
	local sayret = nil
	if true then
		sayret = [[
请站好位置
]]
	end
	return sayret
end

function call_1035_22(human)--【银杏村】/新人接待员-0-@HumanTypeErr
	local sayret = nil
	if true then
		sayret = [[
此人不可以做你的师父。
开始
]]
	end
	return sayret
end

function call_1035_6(human)--【银杏村】/新人接待员-0-@unmaster
	local sayret = nil
	if true then
	elseif true then
		sayret = [[
你都没师父，跑来做什么？？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_23(human)--【银杏村】/新人接待员-0-@UnMasterCheckDir
	local sayret = nil
	if true then
		sayret = [[
按正常出师步骤，必须二个人对面对站好位置，
如果人来不了你只能选择强行出师了。 
#u#lc0000ff:24,#cffff00,我要强行出师#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_25(human)--【银杏村】/新人接待员-0-@UnMasterTypeErr
	local sayret = nil
	if true then
		sayret = [[
你对面站了个什么东西，怎么不太象人来的。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_26(human)--【银杏村】/新人接待员-0-@UnIsMaster
	local sayret = nil
	if true then
		sayret = [[
必须由徒弟发出请求！！！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_27(human)--【银杏村】/新人接待员-0-@UnMasterError
	local sayret = nil
	if true then
		sayret = [[
不要来捣乱！！！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_28(human)--【银杏村】/新人接待员-0-@StartUnMaster
	local sayret = nil
	if true then
		sayret = [[
出师仪式现在开始！！！ 
是否确定真的要脱离师徒关系？ 
#u#lc0000ff:29,#cffff00,确定#L#U#C
]]
	end
	return sayret
end

function call_1035_30(human)--【银杏村】/新人接待员-0-@WateUnMaster
	local sayret = nil
	if true then
		sayret = [[
出师仪式现在开始！！！ 
]]
	end
	return sayret
end

function call_1035_29(human)--【银杏村】/新人接待员-0-@RequestUnMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1035_31(human)--【银杏村】/新人接待员-0-@ResposeUnMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1035_30(human)--【银杏村】/新人接待员-0-@WateUnMaster
	local sayret = nil
	if true then
		sayret = [[
你已向对方发出请求，请耐心等待对方的答复。
]]
	end
	return sayret
end

function call_1035_32(human)--【银杏村】/新人接待员-0-@RevUnMaster
	local sayret = nil
	if true then
		sayret = [[
对方向你请求，你是否答应？  
#u#lc0000ff:29,#cffff00,我愿意#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1035_33(human)--【银杏村】/新人接待员-0-@ExeMasterFail
	local sayret = nil
	if true then
		sayret = [[
你都没师父，跑来做什么？  
]]
	end
	return sayret
end

function call_1035_24(human)--【银杏村】/新人接待员-0-@fUnMaster
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
	elseif true then
		sayret = [[
要收一根金条的手续费，你没有金条，
#u#lc0000ff:-1,#cffff00,确定#L#U#C
]]
	end
	return sayret
end

function call_1035_34(human)--【银杏村】/新人接待员-0-@UnMasterEnd
	local sayret = nil
	if true then
		sayret = [[
呵呵，你已经脱离师徒关系了！！！  
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end
function call_1036_0(human)--【银杏村】/新人接待员-0-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎来到这个世界。在你面前的将是一个陌生的。
新奇的#c00ff00,全新世界#C。在这个世界中历险需要的是你的#c00ff00,智慧#C与#c00ff00,胆量#C。
不过在经历这些乐趣之前，你必须要拥有#c00ff00,强健#C的体魄！
让我来看看你是什么职业，我好告诉你如何生存下去。
#u#lc0000ff:1,#cffff00,下一步#L#U#C
#u#lc0000ff:2,#cffff00,前往比齐省#L#U#C
#u#lc0000ff:3,#cffff00,前往新手训练地#L#U#C
#u#lc0000ff:4,#cffff00,我要拜师#L#U#C
]]
	end
	return sayret
end

function call_1036_4(human)--【银杏村】/新人接待员-0-@baishi
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,＝师徒系统＝#C
『师父』:人物等级到达#c00ff00,40#C级，就可以收徒弟了！
『徒弟』:人物等级必须在#c00ff00,30#C级以下才能做别人徒弟！
『出师』:徒弟等级到达#c00ff00,40#C级，徒弟自动出师！
『好处』:徒弟出师后师父会自动获得#c00ff00,5点#C声望 
#u#lc0000ff:5,#cffff00,[我要拜师]#L#U#C　　#u#lc0000ff:6,#cffff00,[强行脱离师徒关系]#L#U#C
]]
	end
	return sayret
end

function call_1036_1(human)--【银杏村】/新人接待员-0-@next
	local sayret = nil
	if human:获取职业()==1 and true then
		sayret = [[
你知道吗？你是一名#c00ff00,战士#C哦！
拥有#c00ff00,强健的体魄#C是你最为突出的优势。
无论面对任何险恶的环境你都能进退自如。
不过你这种职业有一点不足之处就是。
没有#c00ff00,远程攻击#C的魔法。在组队中适合和道士共同打猎！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		sayret = call_1036_7(human) or sayret--@next_1_2
	end
	return sayret
end

function call_1036_7(human)--【银杏村】/新人接待员-0-@next_1_2
	local sayret = nil
	if human:获取职业()==3 and true then
		sayret = [[
你是一名伟大的#c00ff00,道士#C。你有着博大的胸怀。
由于你的智慧与胸襟，你所修炼的都是一些博爱的武术。
在打猎的时候你最适合与战士配合。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		sayret = [[
强大的精神力量造就了你——#c00ff00,魔法师#C！
正是因为#c00ff00,精神力的强大#C，你可以学习众多的攻击魔法！
不过在初期，你的#c00ff00,体质#C是最让人担心的！
保护好自己的生命是最重要的！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_2(human)--【银杏村】/新人接待员-0-@biqi
	local sayret = nil
	if human:获取等级()>14 and true then
		human:传送(105,334*48,266*32)
	elseif true then
		sayret = [[
看你的体格很是#c00ff00,脆弱#C。
等到你把级别提升到#c00ff00,15级#C以上再来找我吧。
我告诉你的那个洞里的怪物#c00ff00,经验很高#C的哦。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_3(human)--【银杏村】/新人接待员-0-@next1
	local sayret = nil
	if true then
		sayret = [[
#cff00ff,]]..human:获取名字()..[[#C，你好！这里是新人修炼的地方，建议15级
以下的新人在#c00ff00,新人战场#C修炼！
请选择要去的修炼场！ 
#u#lc0000ff:8,#cffff00,新人战场#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_8(human)--【银杏村】/新人接待员-0-@xiulianyi
	local sayret = nil
	if human:获取等级()>29 and true then
		sayret = call_1036_9(human) or sayret--@next2
		return sayret
	end
	if 检查地图怪物数(137)>=40 and true then
		human:获得物品(10137,1)
		human:传送(137,20*48,22*32)
	elseif true then
		地图刷怪(137,2045,100,20,22,100)
		human:传送(137,20*48,22*32)
		human:获得物品(10137,1)
	end
	return sayret
end

function call_1036_9(human)--【银杏村】/新人接待员-0-@next2
	local sayret = nil
	if true then
		sayret = [[
看看你现在的这个级别吧.
你已经不需要再去这里冲级啦.里面有很多新手.
为了保护新手.我们决定#c00ff00,30级以上#C的玩家无法进入新人战场.
实在抱歉,你可以选择其他冲级的地方.
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_5(human)--【银杏村】/新人接待员-0-@master
	local sayret = nil
	if true then
		sayret = [[
想拜师呀，你要拜的师父来了没有？
与你师父面对面站好，开始拜师。 
#u#lc0000ff:10,#cffff00,准备好了#L#U#C
#u#lc0000ff:-1,#cffff00,我知道了#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_10(human)--【银杏村】/新人接待员-0-@agree
	local sayret = nil
	if true then
		sayret = [[
没事别来这玩！！！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if true then
		sayret = [[
你都都已经拜了别人为师，怎么还拜师！！！  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if true then
		sayret = [[
你找了个什么人做师父，怎么现在还是别人的徒弟？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if human:获取对面站位(0) and true then
	elseif true then
		sayret = [[
你们二个面对面站好呀，不要乱动。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		return sayret
	end
	if true then
		sayret = [[
你都30多级了还要找师父？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
		return sayret
	end
	if human:获取对面等级()>39 and true then
	elseif true then
		sayret = [[
你找个什么师父呀，等级这么低？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	elseif true then
		return sayret
	end
	return sayret
end

function call_1036_11(human)--【银杏村】/新人接待员-0-@StartGetMaster
	local sayret = nil
	if true then
		sayret = [[
拜师仪式正式开始。 
你是否确认拜师？ 
#u#lc0000ff:12,#cffff00,确认#L#U#C
]]
	end
	return sayret
end

function call_1036_13(human)--【银杏村】/新人接待员-0-@StartMaster
	local sayret = nil
	if true then
		sayret = [[
拜师仪式正式开始。 
对方已经向你提出拜师请求。 
]]
	end
	return sayret
end

function call_1036_12(human)--【银杏村】/新人接待员-0-@RequestMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1036_14(human)--【银杏村】/新人接待员-0-@WateMaster
	local sayret = nil
	if true then
		sayret = [[
你已向对方请求拜师，请耐心等待对方的答复。
]]
	end
	return sayret
end

function call_1036_15(human)--【银杏村】/新人接待员-0-@RevMaster
	local sayret = nil
	if true then
		sayret = [[
对方想拜你为师，你是否想收此人为徒？  
#u#lc0000ff:16,#cffff00,同意#L#U#C 
#u#lc0000ff:17,#cffff00,不同意#L#U#C
]]
	end
	return sayret
end

function call_1036_16(human)--【银杏村】/新人接待员-0-@ResposeMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1036_17(human)--【银杏村】/新人接待员-0-@ResposeMasterFail
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1036_18(human)--【银杏村】/新人接待员-0-@EndMaster
	local sayret = nil
	if true then
		sayret = [[
你们二个已经是师徒关系了。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1036_19(human)--【银杏村】/新人接待员-0-@EndMasterFail
	local sayret = nil
	if true then
		sayret = [[
拜师失败！ 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1036_20(human)--【银杏村】/新人接待员-0-@MasterDirErr
	local sayret = nil
	if true then
		sayret = [[
对方没站好位置
]]
	end
	return sayret
end

function call_1036_21(human)--【银杏村】/新人接待员-0-@MasterCheckDir
	local sayret = nil
	if true then
		sayret = [[
请站好位置
]]
	end
	return sayret
end

function call_1036_22(human)--【银杏村】/新人接待员-0-@HumanTypeErr
	local sayret = nil
	if true then
		sayret = [[
此人不可以做你的师父。
开始
]]
	end
	return sayret
end

function call_1036_6(human)--【银杏村】/新人接待员-0-@unmaster
	local sayret = nil
	if true then
	elseif true then
		sayret = [[
你都没师父，跑来做什么？？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_23(human)--【银杏村】/新人接待员-0-@UnMasterCheckDir
	local sayret = nil
	if true then
		sayret = [[
按正常出师步骤，必须二个人对面对站好位置，
如果人来不了你只能选择强行出师了。 
#u#lc0000ff:24,#cffff00,我要强行出师#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_25(human)--【银杏村】/新人接待员-0-@UnMasterTypeErr
	local sayret = nil
	if true then
		sayret = [[
你对面站了个什么东西，怎么不太象人来的。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_26(human)--【银杏村】/新人接待员-0-@UnIsMaster
	local sayret = nil
	if true then
		sayret = [[
必须由徒弟发出请求！！！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_27(human)--【银杏村】/新人接待员-0-@UnMasterError
	local sayret = nil
	if true then
		sayret = [[
不要来捣乱！！！ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_28(human)--【银杏村】/新人接待员-0-@StartUnMaster
	local sayret = nil
	if true then
		sayret = [[
出师仪式现在开始！！！ 
是否确定真的要脱离师徒关系？ 
#u#lc0000ff:29,#cffff00,确定#L#U#C
]]
	end
	return sayret
end

function call_1036_30(human)--【银杏村】/新人接待员-0-@WateUnMaster
	local sayret = nil
	if true then
		sayret = [[
出师仪式现在开始！！！ 
]]
	end
	return sayret
end

function call_1036_29(human)--【银杏村】/新人接待员-0-@RequestUnMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1036_31(human)--【银杏村】/新人接待员-0-@ResposeUnMaster
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1036_30(human)--【银杏村】/新人接待员-0-@WateUnMaster
	local sayret = nil
	if true then
		sayret = [[
你已向对方发出请求，请耐心等待对方的答复。
]]
	end
	return sayret
end

function call_1036_32(human)--【银杏村】/新人接待员-0-@RevUnMaster
	local sayret = nil
	if true then
		sayret = [[
对方向你请求，你是否答应？  
#u#lc0000ff:29,#cffff00,我愿意#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1036_33(human)--【银杏村】/新人接待员-0-@ExeMasterFail
	local sayret = nil
	if true then
		sayret = [[
你都没师父，跑来做什么？  
]]
	end
	return sayret
end

function call_1036_24(human)--【银杏村】/新人接待员-0-@fUnMaster
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
	elseif true then
		sayret = [[
要收一根金条的手续费，你没有金条，
#u#lc0000ff:-1,#cffff00,确定#L#U#C
]]
	end
	return sayret
end

function call_1036_34(human)--【银杏村】/新人接待员-0-@UnMasterEnd
	local sayret = nil
	if true then
		sayret = [[
呵呵，你已经脱离师徒关系了！！！  
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end
function call_1037_0(human)--【新人村】/比奇新人村_杂货铺-0-@main
	local sayret = nil
	if true then
		sayret = call_1037_1(human) or sayret--Market\Market3@Markets
		sayret = call_1037_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1037_1(human)--【新人村】/比奇新人村_杂货铺-0-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1037_3(human)--【新人村】/比奇新人村_杂货铺-0-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1037_4(human)--【新人村】/比奇新人村_杂货铺-0-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1037_5(human)--【新人村】/比奇新人村_杂货铺-0-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1037_2(human)--【新人村】/比奇新人村_杂货铺-0-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1038_0(human)--【新人村】/比奇新人村_武器店-0-@main
	local sayret = nil
	if true then
		sayret = call_1038_1(human) or sayret--Market\Market1@Markets
		sayret = call_1038_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1038_2(human)--【新人村】/比奇新人村_武器店-0-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1038_1(human)--【新人村】/比奇新人村_武器店-0-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1038_3(human)--【新人村】/比奇新人村_武器店-0-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1038_4(human)--【新人村】/比奇新人村_武器店-0-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1038_5(human)--【新人村】/比奇新人村_武器店-0-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1038_6(human)--【新人村】/比奇新人村_武器店-0-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1039_0(human)--【新人村】/比奇新人村_肉店-0-@main
	local sayret = nil
	if true then
		sayret = [[
最近我这里可以卖肉.
我会出高价钱购买!
#u#lc0000ff:1,#cffff00,卖#L#U#C
#u#lc0000ff:2,#cffff00,询问#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1039_1(human)--【新人村】/比奇新人村_肉店-0-@sell
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,肉#C在鸡，鹿身上暴!
其他的就是相关怪物身上暴!
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end

function call_1039_2(human)--【新人村】/比奇新人村_肉店-0-@meathelp
	local sayret = nil
	if true then
		sayret = [[
肉可以从鸡、鹿、羊身上割的，先打这些怪物，小心碰到
被比自己厉害的怪物打死，打死怪物之后，按alt键，把鼠标
放在怪物尸体上，您就会看到自己割肉的样子。过一会儿，
您的包里就会放着一个大肉块。对了，差一点忘了告诉你，
企图逃跑的怪物品质更好。用魔法打的怪物，其品质会变成0，
这一点千万记住。 
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end
function call_1040_0(human)--【新人村】/比奇新人村_服饰店-0-@main
	local sayret = nil
	if true then
		sayret = call_1040_1(human) or sayret--Market\Market1@Markets
		sayret = call_1040_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1040_2(human)--【新人村】/比奇新人村_服饰店-0-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1040_1(human)--【新人村】/比奇新人村_服饰店-0-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1040_3(human)--【新人村】/比奇新人村_服饰店-0-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1040_4(human)--【新人村】/比奇新人村_服饰店-0-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1040_5(human)--【新人村】/比奇新人村_服饰店-0-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1040_6(human)--【新人村】/比奇新人村_服饰店-0-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1041_0(human)--【新人村】/比奇新人村_书店-0132-@main
	local sayret = nil
	if true then
		sayret = call_1041_1(human) or sayret--Market\Market2@Markets
		sayret = call_1041_2(human) or sayret--Market\书店@7
	end
	return sayret
end

function call_1041_1(human)--【新人村】/比奇新人村_书店-0132-Market\Market2@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，你想买些修炼的书吗？ 
#u#lc0000ff:3,#cffff00,购买书籍#L#U#C
#u#lc0000ff:4,#cffff00,出售书籍#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1041_3(human)--【新人村】/比奇新人村_书店-0132-Market\Market2@buy
	local sayret = nil
	if true then
		sayret = [[
以下是本店所有书籍的清单，请挑选你想要书籍。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1041_4(human)--【新人村】/比奇新人村_书店-0132-Market\Market2@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的书籍给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1041_2(human)--【新人村】/比奇新人村_书店-0132-Market\书店@7
	local sayret = nil
	return sayret
end
function call_1042_0(human)--【新人村】/比奇新人村_戒指店-0141-@main
	local sayret = nil
	if true then
		sayret = call_1042_1(human) or sayret--Market\Market1@Markets
		sayret = call_1042_2(human) or sayret--Market\戒指@5
	end
	return sayret
end

function call_1042_2(human)--【新人村】/比奇新人村_戒指店-0141-Market\戒指@5
	local sayret = nil
	return sayret
end

function call_1042_1(human)--【新人村】/比奇新人村_戒指店-0141-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买戒指#L#U#C
#u#lc0000ff:4,#cffff00,出售戒指#L#U#C
#u#lc0000ff:5,#cffff00,修理戒指#L#U#C
#u#lc0000ff:6,#cffff00,特修戒指#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1042_3(human)--【新人村】/比奇新人村_戒指店-0141-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要戒指。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1042_4(human)--【新人村】/比奇新人村_戒指店-0141-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的戒指给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1042_5(human)--【新人村】/比奇新人村_戒指店-0141-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的戒指给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1042_6(human)--【新人村】/比奇新人村_戒指店-0141-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1043_0(human)--【新人村】/比奇新人村_项链店-0141-@main
	local sayret = nil
	if true then
		sayret = call_1043_1(human) or sayret--Market\Market1@Markets
		sayret = call_1043_2(human) or sayret--Market\项链@2
	end
	return sayret
end

function call_1043_2(human)--【新人村】/比奇新人村_项链店-0141-Market\项链@2
	local sayret = nil
	return sayret
end

function call_1043_1(human)--【新人村】/比奇新人村_项链店-0141-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买项链#L#U#C
#u#lc0000ff:4,#cffff00,出售项链#L#U#C
#u#lc0000ff:5,#cffff00,修理项链#L#U#C
#u#lc0000ff:6,#cffff00,特修项链#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1043_3(human)--【新人村】/比奇新人村_项链店-0141-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要项链。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1043_4(human)--【新人村】/比奇新人村_项链店-0141-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的项链给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1043_5(human)--【新人村】/比奇新人村_项链店-0141-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的项链给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1043_6(human)--【新人村】/比奇新人村_项链店-0141-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我这正好有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1044_0(human)--【新人村】/比奇新人村_手镯店-0141-@main
	local sayret = nil
	if true then
		sayret = call_1044_1(human) or sayret--Market\Market1@Markets
		sayret = call_1044_2(human) or sayret--Market\手镯@4
	end
	return sayret
end

function call_1044_2(human)--【新人村】/比奇新人村_手镯店-0141-Market\手镯@4
	local sayret = nil
	return sayret
end

function call_1044_1(human)--【新人村】/比奇新人村_手镯店-0141-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买手镯#L#U#C
#u#lc0000ff:4,#cffff00,出售手镯#L#U#C
#u#lc0000ff:5,#cffff00,修理手镯#L#U#C
#u#lc0000ff:6,#cffff00,特修手镯#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1044_3(human)--【新人村】/比奇新人村_手镯店-0141-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要手镯。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1044_4(human)--【新人村】/比奇新人村_手镯店-0141-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的手镯给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1044_5(human)--【新人村】/比奇新人村_手镯店-0141-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的手镯给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1044_6(human)--【新人村】/比奇新人村_手镯店-0141-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1045_0(human)--【毒蛇村】/毒蛇山谷_朴铁匠-0120-@main
	local sayret = nil
	if true then
		sayret = call_1045_1(human) or sayret--Market\Market1@Markets
		sayret = call_1045_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1045_2(human)--【毒蛇村】/毒蛇山谷_朴铁匠-0120-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1045_1(human)--【毒蛇村】/毒蛇山谷_朴铁匠-0120-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1045_3(human)--【毒蛇村】/毒蛇山谷_朴铁匠-0120-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1045_4(human)--【毒蛇村】/毒蛇山谷_朴铁匠-0120-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1045_5(human)--【毒蛇村】/毒蛇山谷_朴铁匠-0120-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1045_6(human)--【毒蛇村】/毒蛇山谷_朴铁匠-0120-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1046_0(human)--【毒蛇村】/毒蛇山谷_铁匠-2-@main
	local sayret = nil
	if true then
		sayret = call_1046_1(human) or sayret--Market\Market1@Markets
		sayret = call_1046_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1046_2(human)--【毒蛇村】/毒蛇山谷_铁匠-2-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1046_1(human)--【毒蛇村】/毒蛇山谷_铁匠-2-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1046_3(human)--【毒蛇村】/毒蛇山谷_铁匠-2-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1046_4(human)--【毒蛇村】/毒蛇山谷_铁匠-2-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1046_5(human)--【毒蛇村】/毒蛇山谷_铁匠-2-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1046_6(human)--【毒蛇村】/毒蛇山谷_铁匠-2-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1047_0(human)--【毒蛇村】/毒蛇山谷_薄家药-0117-@main
	local sayret = nil
	if true then
		sayret = call_1047_1(human) or sayret--Market\Market0@Markets
		sayret = call_1047_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1047_1(human)--【毒蛇村】/毒蛇山谷_薄家药-0117-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1047_3(human)--【毒蛇村】/毒蛇山谷_薄家药-0117-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1047_4(human)--【毒蛇村】/毒蛇山谷_薄家药-0117-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1047_2(human)--【毒蛇村】/毒蛇山谷_薄家药-0117-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1048_0(human)--【毒蛇村】/毒蛇山谷_药铺-2-@main
	local sayret = nil
	if true then
		sayret = call_1048_1(human) or sayret--Market\Market0@Markets
		sayret = call_1048_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1048_1(human)--【毒蛇村】/毒蛇山谷_药铺-2-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1048_3(human)--【毒蛇村】/毒蛇山谷_药铺-2-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1048_4(human)--【毒蛇村】/毒蛇山谷_药铺-2-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1048_2(human)--【毒蛇村】/毒蛇山谷_药铺-2-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1049_0(human)--【毒蛇村】/毒蛇山谷_罗家铺子-2-@main
	local sayret = nil
	if true then
		sayret = call_1049_1(human) or sayret--Market\Market3@Markets
		sayret = call_1049_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1049_1(human)--【毒蛇村】/毒蛇山谷_罗家铺子-2-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1049_3(human)--【毒蛇村】/毒蛇山谷_罗家铺子-2-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1049_4(human)--【毒蛇村】/毒蛇山谷_罗家铺子-2-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1049_5(human)--【毒蛇村】/毒蛇山谷_罗家铺子-2-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1049_2(human)--【毒蛇村】/毒蛇山谷_罗家铺子-2-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1050_0(human)--【毒蛇村】/毒蛇山谷_米家服装-2-@main
	local sayret = nil
	if true then
		sayret = call_1050_1(human) or sayret--Market\Market1@Markets
		sayret = call_1050_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1050_2(human)--【毒蛇村】/毒蛇山谷_米家服装-2-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1050_1(human)--【毒蛇村】/毒蛇山谷_米家服装-2-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1050_3(human)--【毒蛇村】/毒蛇山谷_米家服装-2-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1050_4(human)--【毒蛇村】/毒蛇山谷_米家服装-2-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1050_5(human)--【毒蛇村】/毒蛇山谷_米家服装-2-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1050_6(human)--【毒蛇村】/毒蛇山谷_米家服装-2-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1051_0(human)--【盟重省】/攻沙奖励大使-3-@main
	local sayret = nil
	if human:是否管理员() and (全局变量.G89 or 0)==1 and true then
		sayret = [[
#u#lc0000ff:1,#cffff00,修改开区天数#L#U#C  #u#lc0000ff:2,#cffff00,修改攻沙模式#L#U#C(今晚20:00攻沙)
======（以上玩家看不到。只有GM才能看到）==========
]]
	end
	if human:是否管理员() and (全局变量.G89 or 0)==0 and true then
		sayret = [[
#u#lc0000ff:1,#cffff00,修改开区天数#L#U#C  #u#lc0000ff:2,#cffff00,修改攻沙模式#L#U#C(今晚不攻沙)
======（以上玩家看不到。只有GM才能看到）==========
]]
	end
	if (全局变量.G88 or 0)==4 and (全局变量.G89 or 0)==1 and true then
		sayret = [[
最近一次攻沙在今天晚上20:00-22:00
攻沙奖励为3000元宝
　
#u#lc0000ff:3,#cffff00,领取攻沙元宝#L#U#C    
]]
		return sayret
	end
	if (全局变量.G88 or 0)>3 and (全局变量.G89 or 0)==0 and true then
		sayret = [[
最近一次攻沙在明天晚上20:00-22:00
攻沙奖励为3000元宝
　
#u#lc0000ff:3,#cffff00,领取攻沙元宝#L#U#C      
]]
		return sayret
	end
	if (全局变量.G88 or 0)>3 and (全局变量.G89 or 0)==1 and true then
		sayret = [[
最近一次攻沙在今天晚上20:00-22:00
攻沙奖励为3000元宝
　
#u#lc0000ff:3,#cffff00,领取攻沙元宝#L#U#C      
]]
		return sayret
	end
	if (全局变量.G88 or 0)==3 and true then
		sayret = [[
最近一次攻沙在明天晚上20:00-22:00
攻沙奖励为3000元宝
　
#u#lc0000ff:3,#cffff00,领取攻沙元宝#L#U#C      
]]
		return sayret
	end
	if (全局变量.G88 or 0)<3 and true then
		sayret = [[
最近一次攻沙在开区第三天晚上20:00-22:00
攻沙奖励为3000元宝
　
#u#lc0000ff:3,#cffff00,领取攻沙元宝#L#U#C      
]]
		return sayret
	end
	return sayret
end

function call_1051_1(human)--【盟重省】/攻沙奖励大使-3-@tInteger12
	local sayret = nil
	if human:是否管理员() and true then
		return sayret
	end
	return sayret
end

function call_1051_2(human)--【盟重省】/攻沙奖励大使-3-@修改攻沙模式
	local sayret = nil
	if (全局变量.G89 or 0)==0 and true then
		全局变量.G89=1
		延时执行(human,1,"1051_0",human.opennpcobjid or -1)--@MAIN
		return sayret
	end
	if (全局变量.G89 or 0)==1 and true then
		全局变量.G89=0
		延时执行(human,1,"1051_0",human.opennpcobjid or -1)--@MAIN
		return sayret
	end
	return sayret
end

function call_1051_3(human)--【盟重省】/攻沙奖励大使-3-@领取攻沙元宝
	local sayret = nil
	if human:是否城主(0) and (全局变量.G88 or 0)==4 and (全局变量.G89 or 0)==1 and (全局变量.G90 or 0)==0 and true then
		全局变量.G90=1
		human:调整元宝(human:获取元宝()+3000)
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
	end
	if human:是否城主(0) and (全局变量.G88 or 0)>4 and (全局变量.G89 or 0)==1 and (全局变量.G90 or 0)==0 and true then
		全局变量.G90=1
		human:调整元宝(human:获取元宝()+3000)
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
		全服广播("#cff00ff,".."提示：城主【"..human:获取名字().."】领取今天的攻沙奖励：3000元宝。请再接再励！")
	elseif true then
		sayret = [[
领取条件：
1.城主。
2.攻沙日
3.时间为：22:02-22:50
4.一天只能领一次。或者您同伙领了也可能！
]]
	end
	return sayret
end
function call_1052_0(human)--【盟重省】/盟重红名村_商店-3-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎，你需要点什么？
#u#lc0000ff:1,#cffff00,买#L#U#C药品
#u#lc0000ff:2,#cffff00,卖#L#U#C药品 
#u#lc0000ff:3,#cffff00,回土城#L#U#C 
]]
	end
	return sayret
end

function call_1052_3(human)--【盟重省】/盟重红名村_商店-3-@fanhuitu
	local sayret = nil
	if true then
		human:传送(186,345*48,414*32)
	end
	return sayret
end

function call_1052_1(human)--【盟重省】/盟重红名村_商店-3-@buy
	local sayret = nil
	if true then
		sayret = [[
你想买点什么药品？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1052_2(human)--【盟重省】/盟重红名村_商店-3-@sell
	local sayret = nil
	if true then
		sayret = [[
给我看看你的东西。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1053_0(human)--【盟重省】/盟重土城_肉店-3-@main
	local sayret = nil
	if true then
		sayret = [[
最近我这里可以卖肉.
我会出高价钱购买!
#u#lc0000ff:1,#cffff00,卖#L#U#C
#u#lc0000ff:2,#cffff00,询问#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1053_1(human)--【盟重省】/盟重土城_肉店-3-@sell
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,肉#C在鸡，鹿身上暴!
其他的就是相关怪物身上暴!
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end

function call_1053_2(human)--【盟重省】/盟重土城_肉店-3-@meathelp
	local sayret = nil
	if true then
		sayret = [[
肉可以从鸡、鹿、羊身上割的，先打这些怪物，小心碰到
被比自己厉害的怪物打死，打死怪物之后，按alt键，把鼠标
放在怪物尸体上，您就会看到自己割肉的样子。过一会儿，
您的包里就会放着一个大肉块。对了，差一点忘了告诉你，
企图逃跑的怪物品质更好。用魔法打的怪物，其品质会变成0，
这一点千万记住。 
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end
function call_1054_0(human)--【盟重省】/盟重土城_手镯店-0149-@main
	local sayret = nil
	if true then
		sayret = call_1054_1(human) or sayret--Market\Market1@Markets
		sayret = call_1054_2(human) or sayret--Market\手镯@4
	end
	return sayret
end

function call_1054_2(human)--【盟重省】/盟重土城_手镯店-0149-Market\手镯@4
	local sayret = nil
	return sayret
end

function call_1054_1(human)--【盟重省】/盟重土城_手镯店-0149-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买手镯#L#U#C
#u#lc0000ff:4,#cffff00,出售手镯#L#U#C
#u#lc0000ff:5,#cffff00,修理手镯#L#U#C
#u#lc0000ff:6,#cffff00,特修手镯#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1054_3(human)--【盟重省】/盟重土城_手镯店-0149-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要手镯。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1054_4(human)--【盟重省】/盟重土城_手镯店-0149-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的手镯给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1054_5(human)--【盟重省】/盟重土城_手镯店-0149-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的手镯给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1054_6(human)--【盟重省】/盟重土城_手镯店-0149-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1055_0(human)--【盟重省】/盟重土城_武器店-0159-@main
	local sayret = nil
	if true then
		sayret = call_1055_1(human) or sayret--Market\Market1@Markets
		sayret = call_1055_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1055_2(human)--【盟重省】/盟重土城_武器店-0159-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1055_1(human)--【盟重省】/盟重土城_武器店-0159-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1055_3(human)--【盟重省】/盟重土城_武器店-0159-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1055_4(human)--【盟重省】/盟重土城_武器店-0159-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1055_5(human)--【盟重省】/盟重土城_武器店-0159-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1055_6(human)--【盟重省】/盟重土城_武器店-0159-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1056_0(human)--【盟重省】/盟重土城_杂货铺-3-@main
	local sayret = nil
	if true then
		sayret = call_1056_1(human) or sayret--Market\Market3@Markets
		sayret = call_1056_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1056_1(human)--【盟重省】/盟重土城_杂货铺-3-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1056_3(human)--【盟重省】/盟重土城_杂货铺-3-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1056_4(human)--【盟重省】/盟重土城_杂货铺-3-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1056_5(human)--【盟重省】/盟重土城_杂货铺-3-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1056_2(human)--【盟重省】/盟重土城_杂货铺-3-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1057_0(human)--【盟重省】/盟重土城_药店-3-@main
	local sayret = nil
	if true then
		sayret = call_1057_1(human) or sayret--Market\Market0@Markets
		sayret = call_1057_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1057_1(human)--【盟重省】/盟重土城_药店-3-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1057_3(human)--【盟重省】/盟重土城_药店-3-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1057_4(human)--【盟重省】/盟重土城_药店-3-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1057_2(human)--【盟重省】/盟重土城_药店-3-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1058_0(human)--【盟重省】/盟重土城_头盔店-0149-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:1,#cffff00,买#L#U#C头盔
#u#lc0000ff:2,#cffff00,卖#L#U#C头盔
#u#lc0000ff:3,#cffff00,修补#L#U#C头盔
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1058_1(human)--【盟重省】/盟重土城_头盔店-0149-@buy
	local sayret = nil
	if true then
		sayret = [[
你想买什么样的头盔？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1058_2(human)--【盟重省】/盟重土城_头盔店-0149-@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的头盔给我看看，我会给你个估价。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1058_3(human)--【盟重省】/盟重土城_头盔店-0149-@repair
	local sayret = nil
	if true then
		sayret = [[
请放上去要修补的头盔。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1058_4(human)--【盟重省】/盟重土城_头盔店-0149-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1059_0(human)--【盟重省】/盟重土城_戒指店-0158-@main
	local sayret = nil
	if true then
		sayret = call_1059_1(human) or sayret--Market\Market1@Markets
		sayret = call_1059_2(human) or sayret--Market\戒指@5
	end
	return sayret
end

function call_1059_2(human)--【盟重省】/盟重土城_戒指店-0158-Market\戒指@5
	local sayret = nil
	return sayret
end

function call_1059_1(human)--【盟重省】/盟重土城_戒指店-0158-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买戒指#L#U#C
#u#lc0000ff:4,#cffff00,出售戒指#L#U#C
#u#lc0000ff:5,#cffff00,修理戒指#L#U#C
#u#lc0000ff:6,#cffff00,特修戒指#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1059_3(human)--【盟重省】/盟重土城_戒指店-0158-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要戒指。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1059_4(human)--【盟重省】/盟重土城_戒指店-0158-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的戒指给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1059_5(human)--【盟重省】/盟重土城_戒指店-0158-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的戒指给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1059_6(human)--【盟重省】/盟重土城_戒指店-0158-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1060_0(human)--【盟重省】/盟重土城_手镯店-0158-@main
	local sayret = nil
	if true then
		sayret = call_1060_1(human) or sayret--Market\Market1@Markets
		sayret = call_1060_2(human) or sayret--Market\手镯@4
	end
	return sayret
end

function call_1060_2(human)--【盟重省】/盟重土城_手镯店-0158-Market\手镯@4
	local sayret = nil
	return sayret
end

function call_1060_1(human)--【盟重省】/盟重土城_手镯店-0158-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买手镯#L#U#C
#u#lc0000ff:4,#cffff00,出售手镯#L#U#C
#u#lc0000ff:5,#cffff00,修理手镯#L#U#C
#u#lc0000ff:6,#cffff00,特修手镯#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1060_3(human)--【盟重省】/盟重土城_手镯店-0158-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要手镯。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1060_4(human)--【盟重省】/盟重土城_手镯店-0158-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的手镯给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1060_5(human)--【盟重省】/盟重土城_手镯店-0158-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的手镯给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1060_6(human)--【盟重省】/盟重土城_手镯店-0158-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1061_0(human)--【盟重省】/盟重土城_项链店-0158-@main
	local sayret = nil
	if true then
		sayret = call_1061_1(human) or sayret--Market\Market1@Markets
		sayret = call_1061_2(human) or sayret--Market\项链@2
	end
	return sayret
end

function call_1061_2(human)--【盟重省】/盟重土城_项链店-0158-Market\项链@2
	local sayret = nil
	return sayret
end

function call_1061_1(human)--【盟重省】/盟重土城_项链店-0158-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买项链#L#U#C
#u#lc0000ff:4,#cffff00,出售项链#L#U#C
#u#lc0000ff:5,#cffff00,修理项链#L#U#C
#u#lc0000ff:6,#cffff00,特修项链#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1061_3(human)--【盟重省】/盟重土城_项链店-0158-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要项链。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1061_4(human)--【盟重省】/盟重土城_项链店-0158-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的项链给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1061_5(human)--【盟重省】/盟重土城_项链店-0158-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的项链给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1061_6(human)--【盟重省】/盟重土城_项链店-0158-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我这正好有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1062_0(human)--【盟重省】/盟重土城_书店-0161-@main
	local sayret = nil
	if true then
		sayret = call_1062_1(human) or sayret--Market\Market2@Markets
		sayret = call_1062_2(human) or sayret--Market\书店@7
	end
	return sayret
end

function call_1062_1(human)--【盟重省】/盟重土城_书店-0161-Market\Market2@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，你想买些修炼的书吗？ 
#u#lc0000ff:3,#cffff00,购买书籍#L#U#C
#u#lc0000ff:4,#cffff00,出售书籍#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1062_3(human)--【盟重省】/盟重土城_书店-0161-Market\Market2@buy
	local sayret = nil
	if true then
		sayret = [[
以下是本店所有书籍的清单，请挑选你想要书籍。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1062_4(human)--【盟重省】/盟重土城_书店-0161-Market\Market2@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的书籍给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1062_2(human)--【盟重省】/盟重土城_书店-0161-Market\书店@7
	local sayret = nil
	return sayret
end
function call_1063_0(human)--【盟重省】/盟重土城_服饰店-0149-@main
	local sayret = nil
	if true then
		sayret = call_1063_1(human) or sayret--Market\Market1@Markets
		sayret = call_1063_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1063_2(human)--【盟重省】/盟重土城_服饰店-0149-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1063_1(human)--【盟重省】/盟重土城_服饰店-0149-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1063_3(human)--【盟重省】/盟重土城_服饰店-0149-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1063_4(human)--【盟重省】/盟重土城_服饰店-0149-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1063_5(human)--【盟重省】/盟重土城_服饰店-0149-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1063_6(human)--【盟重省】/盟重土城_服饰店-0149-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1064_0(human)--【盟重省】/盟重土城_药店-0160-@main
	local sayret = nil
	if true then
		sayret = call_1064_1(human) or sayret--Market\Market0@Markets
		sayret = call_1064_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1064_1(human)--【盟重省】/盟重土城_药店-0160-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1064_3(human)--【盟重省】/盟重土城_药店-0160-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1064_4(human)--【盟重省】/盟重土城_药店-0160-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1064_2(human)--【盟重省】/盟重土城_药店-0160-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1065_0(human)--【盟重省】/新手攻略-3-@MAIN
	local sayret = nil
	if true then
		sayret = [[
新爱的玩家：#cff00ff,]]..human:获取名字()..[[#C 感谢你对#cff00ff,]]..Config.SERVER_IP..[[#C的支持！ #u#lc0000ff:1,#cffff00,游戏命令查询#L#U#C   
#u#lc0000ff:2,#cffff00,玩家升级方式介绍#L#U#C              #u#lc0000ff:3,#cffff00,关于各职业技能介绍#L#U#C
#u#lc0000ff:4,#cffff00,玩家各职业装备爆率#L#U#C            #u#lc0000ff:5,#cffff00,关于极器装备与幸运问题#L#U#C 
#u#lc0000ff:6,#cffff00,玩家各职业装备出处#L#U#C            #u#lc0000ff:7,#cffff00,本服开区、攻沙、合区方法#L#U#C 
#u#lc0000ff:8,#cffff00,玩家打元宝方式介绍#L#U#C            #u#lc0000ff:9,#cffff00,合区后账号问题及解决方法#L#U#C 
#c00ff00,其它问题请打@帮助即可查询#C
#c00ffff,提示：本服非市面变态1.76，所有装备一切靠打，等级靠练！#C
　　　#c00ffff,本服最高封顶为52级，极品装备最高+3！屠龙赤月装备最好。#C
　　　#c00ffff,本服已开启排行榜，玩家可随时关注排行实事动向！#C
]]
	end
	return sayret
end

function call_1065_2(human)--【盟重省】/新手攻略-3-@升级
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,散人玩家升级方式：#C 
1.去幻境1.2.3.4地图，带上双倍或四倍勋章10分钟到达40级。
2.初级地图打祖玛装备、赤月装备、新衣服等、回收高额经验。
3.使用聚灵珠,存满后无论自己吃还是卖给RMB玩家,都有高额回报!
#c00ffff,RMB玩家升级方式：#C
1.收普通玩家手里祖玛装备、赤月装备、新衣服等回收高额经验。
2.收普通玩家已存满的聚灵珠升级，这是本服最快速升级的方法。
3.自己带双倍、四倍勋章或带上聚灵珠，前往幻境地图练级！
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_3(human)--【盟重省】/新手攻略-3-@技能
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,关于职业技能#C 
1.本服35级以前技能在你达到相应等级时，系统全部自动赠送！
2.35级技能书可在尸王殿内爆出，每10分钟刷新一次！ 
3.着重调整了道士毒符的威力，40级出3级强化神兽,44级出7级！ 
4.法师44级可以招出900勇士！  
5.本服无4级技能，完美仿盛大1.76版本！ 
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_4(human)--【盟重省】/新手攻略-3-@爆率
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,装备爆率：#C  
沃玛装备：爆率恐怖!                       难度：☆
袓玛装备：爆率超高!                       难度：★
赤月装备：爆率适中!                       难度：★★
新 衣 服：爆率适中!                       难度：★★☆
怒斩武器：爆率适中!                       难度：★★☆
屠龙霸者：爆率一般!                       难度：★★★★
极品装备：爆率适中,随机爆出,最高+3!       难度：★★★
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_5(human)--【盟重省】/新手攻略-3-@幸运
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,极器装备与幸运#C 
1.本服幸运9即可触发最高威力，运10可达到峰值！ 
2.幸运链可在各大小随机BOSS爆出，也可在综合NPC升，运9不难！ 
3.极品最高+3，各大小BOSS随机爆出，+3以上祖玛，价格不菲！ 
4.武器最高升7点，可在综合NPC进行升，时间约10分钟！难度适中！
5.普通装备不是终点，+3套才是你的最终的梦想！ 
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_6(human)--【盟重省】/新手攻略-3-@出处
	local sayret = nil
	if true then
		sayret = [[
　　　　　　　　          #c00ff00,装备爆率：#C
　　　　　　　　 #u#lc0000ff:10,#cffff00,屠龙、嗜魂法杖、霸者之刃出处#L#U#C
　　　　　　　　    #u#lc0000ff:11,#cffff00,怒斩、龙牙、逍遥扇出处#L#U#C
　　　　　　　　   #u#lc0000ff:12,#cffff00,圣战、法神、天尊首饰出处#L#U#C
　　　　　　　　  #u#lc0000ff:13,#cffff00,40级新衣服与各职业勋章出处#L#U#C
　　　　　　　      　#u#lc0000ff:13,#cffff00,各职业祖玛首饰出处#L#U#C
　　　　　　　      　#u#lc0000ff:13,#cffff00,各类极品装备的出处#L#U#C
　　　　　　　　　　         #u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_10(human)--【盟重省】/新手攻略-3-@屠龙
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,屠龙出处：#C
主要出处：幽冥教主,暗之赤月恶魔,镜像冥王
其它出处：赤月恶魔,祖玛教主  
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:6,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_11(human)--【盟重省】/新手攻略-3-@怒斩
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,怒斩出处：#C  
　　　　地藏魔王,幽冥教主,祖玛教主,赤月恶魔,镜像冥王
　　　　黄泉教主,牛魔王   
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:6,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_12(human)--【盟重省】/新手攻略-3-@圣战
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,赤月首饰出处：#C  
圣战首饰出处:双头血魔,暗之赤月恶魔,地藏王,镜像冥王 
天尊首饰出处:赤月恶魔,暗之赤月恶魔,地藏王,幽冥教主 
法神首饰出处:双头金刚,暗之赤月恶魔,地藏王,幽冥教主   
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:6,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_13(human)--【盟重省】/新手攻略-3-@衣服
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,新衣服出处：#C    重装使者,各大新衣服BOSS 
#c00ffff,勋章出处：#C      勋章使者 
#c00ffff,祖玛首饰出处：#C  各大BOSS祖玛大小怪,白野猪等等! 
#c00ffff,极品装备出处：#C  各大地图大小BOSS均随机爆出!最高极品+3 
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:6,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_7(human)--【盟重省】/新手攻略-3-@攻沙
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,开区合区方法#C 
开区：在没有物殊情况下，本服每天准时新区开放！
攻沙：新区开放第4日晚上统一进行攻沙，首次奖励500人民币+5000元宝
合区：合区采用新区与新区合，半新区与半新区合！
　　　举列:1区-2区-3区合，再以后123区-456区合,不胡乱合区！
　　　合区后每周1.3.5.7系统自动攻沙,攻沙奖励8000元宝！
　　　其它时间行会可自行提交祖玛图像,第2天即可攻沙,无奖励! 
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_8(human)--【盟重省】/新手攻略-3-@元宝
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,元宝主要获得方式：#C
1.祖玛件以上装备#c00ffff,高额元宝回收#C,为本服主要元宝的获得途径之一！
2.打怪升级存满#c00ffff,聚灵珠#C摆摊出售,RMB玩家会有大量需求！
3.中后期升武器时高纯度的#c00ffff,黑铁矿石和白项链#C也将是抢手货。
4.参加本服的活动，也许能获得一定数量的元宝！
5.打装备过程中可能会出现极品，#c00ffff,+3祖玛以上极品#C价格不菲！
#c00ffff,注：元宝回收请查看回收NPC，极品装备及交易请玩家自行协商！#C 
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1065_9(human)--【盟重省】/新手攻略-3-@账号
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,合区账号问题解决#C 
合并后原来玩家请使用原帐号密码登陆合区后的服务器. 
如果登陆时输入帐号密码后提示密码错误,
比喻你的账号是aaa请最后一位换b,c或d等以此类推,例如:帐号是aaa,那么帐号就变成了aab
密码不变如果帐号字符已满,
请修改最后一位字符为a,b或c,
例如:帐号是111,那么帐号就变成了111a
(如提示密码错误就输入帐号111b,111c)
密码不变.总之,进不了自己想进的账号或者人物,
你就在账号后加a或b或c!
不断的尝试下去直到进入了为止! 
　　　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1066_0(human)--【盟重省】/综合服务生-3-@MAIN
	local sayret = nil
	if true then
		sayret = [[
　
　　　　　　　　　　　　　　　　　　 #cff00ff,]]..Config.SERVER_IP..[[#C 1.76小极品!
#c00FFFF,我为您提供以下服务#C         #c00FF00,----------------------------#C
╔════════╦════════╦════════╗
║　#c00ff00,欢迎光临本店#C　║　#u#lc0000ff:1,#cffff00,≮武器升级≯#L#U#C　║　#u#lc0000ff:2,#cffff00,≮我存东西≯#L#U#C　║
╠════════╬════════╬════════╣
║　#c00ff00,欢迎光临本店#C　║　#u#lc0000ff:3,#cffff00,≮返回武器≯#L#U#C　║　#u#lc0000ff:4,#cffff00,≮我取东西≯#L#U#C　║
╚════════╩════════╩════════╝
]]
	end
	return sayret
end

function call_1066_5(human)--【盟重省】/综合服务生-3-@幸运
	local sayret = nil
	if true then
		sayret = [[
¤╭⌒╮╭⌒╮        
╱◥██◣ ╭⌒╮     欢迎光临 #c00ffff,提示:幸运项链可随机爆出#C
︱田︱田田|╰-------  本服只有灯笼,记忆,白虎项链可升幸运
╬╬╬╬╬╬╬╬╬╬  #c00ffff,注意:项链升级不会破碎,成功率为随机!#C
------------------------------------------------------------　
只有已经是运1或运2的项链才能在我这提高项链的幸运！
#c00ff00,项链#C幸运提升至+1    #c00ff00,需要1000元宝   成功率 80%#C     #u#lc0000ff:6,#cffff00,确定提升#L#U#C
#c00ff00,项链#C幸运提升至+2    #c00ff00,需要2000元宝   成功率 50%#C     #u#lc0000ff:7,#cffff00,确定提升#L#U#C
#c00ff00,项链#C幸运提升至+3    #c00ff00,需要3000元宝   成功率 30%#C     #u#lc0000ff:8,#cffff00,确定提升#L#U#C
运9泛滥的服绝对不会长久，本服运9套不好搞！　　#u#lc0000ff:0,#cffff00,返回首页#L#U#C
]]
	end
	return sayret
end

function call_1066_6(human)--【盟重省】/综合服务生-3-@幸运1
	local sayret = nil
	if human:检查附加属性(4,13)==0 and human:获取元宝()>1000 and true then
		sayret = call_1066_9(human) or sayret--幸运项链\灯笼项链1@灯笼项链1
		return sayret
	end
	if human:检查附加属性(4,13)==0 and human:获取元宝()>1000 and true then
		sayret = call_1066_10(human) or sayret--幸运项链\虎齿项链1@白色虎齿项链1
		return sayret
	end
	if human:检查附加属性(4,13)==0 and human:获取元宝()>1000 and true then
		sayret = call_1066_11(human) or sayret--幸运项链\记忆项链1@记忆项链1
		return sayret
	elseif true then
		human:弹出消息框("您没有佩带项链，\\不是幸运加0的\\或者您没有1000元宝，无法升级。。")
		return sayret
	end
	return sayret
end

function call_1066_7(human)--【盟重省】/综合服务生-3-@幸运2
	local sayret = nil
	if human:检查附加属性(4,13)==1 and human:获取元宝()>2000 and true then
		sayret = call_1066_12(human) or sayret--幸运项链\灯笼项链2@灯笼项链2
		return sayret
	end
	if human:检查附加属性(4,13)==1 and human:获取元宝()>2000 and true then
		sayret = call_1066_13(human) or sayret--幸运项链\虎齿项链2@白色虎齿项链2
		return sayret
	end
	if human:检查附加属性(4,13)==1 and human:获取元宝()>2000 and true then
		sayret = call_1066_14(human) or sayret--幸运项链\记忆项链2@记忆项链2
		return sayret
	elseif true then
		human:弹出消息框("您没有佩带项链，\\不是幸运加1的\\或者您没有2000元宝，无法升级。。")
		return sayret
	end
	return sayret
end

function call_1066_8(human)--【盟重省】/综合服务生-3-@幸运3
	local sayret = nil
	if human:检查附加属性(4,13)==2 and human:获取元宝()>3000 and true then
		sayret = call_1066_15(human) or sayret--幸运项链\灯笼项链3@灯笼项链3
		return sayret
	end
	if human:检查附加属性(4,13)==2 and human:获取元宝()>3000 and true then
		sayret = call_1066_16(human) or sayret--幸运项链\虎齿项链3@白色虎齿项链3
		return sayret
	end
	if human:检查附加属性(4,13)==2 and human:获取元宝()>3000 and true then
		sayret = call_1066_17(human) or sayret--幸运项链\记忆项链3@记忆项链3
		return sayret
	elseif true then
		human:弹出消息框("您没有佩带项链，\\不是幸运加2的\\或者您没有3000元宝，无法升级。。")
		return sayret
	end
	return sayret
end

function call_1066_2(human)--【盟重省】/综合服务生-3-@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1066_4(human)--【盟重省】/综合服务生-3-@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西.  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1066_1(human)--【盟重省】/综合服务生-3-@upgrade
	local sayret = nil
	if true then
		sayret = [[
你像是想要升级你的武器
给我看你的武器,升级价格是#cff00ff,]]..""..[[#C金币
修炼这个武器需要原料#u#lc0000ff:18,#cffff00,黑铁矿石#L#U#C,#u#lc0000ff:19,#cffff00,饰品#L#U#C,#u#lc0000ff:20,#cffff00,武器#L#U#C
和 #u#lc0000ff:21,#cffff00,金币#L#U#C.你确定要它吗？
别的原料你可以使用你包内的物品
你想委托你的武器进入修炼系统吗？ 
#u#lc0000ff:22,#cffff00,确认修炼#L#U#C
#u#lc0000ff:0,#cffff00,取消#L#U#C
]]
	end
	return sayret
end

function call_1066_18(human)--【盟重省】/综合服务生-3-@Biron
	local sayret = nil
	if true then
		sayret = [[
你可以在矿山里采到黑铁矿石。
如果你想修炼过程得到一个好得结果
你最好拿给我更高纯度的黑铁矿石。
顺便请记得，在修炼期间如果没有足够数
量的黑色铁矿，那怕你的矿石纯度再高
修练的结果也可能不好. 
#u#lc0000ff:1,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1066_19(human)--【盟重省】/综合服务生-3-@Etc
	local sayret = nil
	if true then
		sayret = [[
装饰品，项链，手镯
当你的特殊技能融入了这种装饰
物的时候，能够加强你的武器
如果你给我好原料我能给你好结果
如果你给我糟糕的装饰品
那可能会失败，除非你有很好的运气 
#u#lc0000ff:1,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1066_20(human)--【盟重省】/综合服务生-3-@Weapon
	local sayret = nil
	if true then
		sayret = [[
只能对武器进行炼制
如果你想要升级武器
请给我你携带的武器 ... 
#u#lc0000ff:1,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1066_21(human)--【盟重省】/综合服务生-3-@Gold
	local sayret = nil
	if true then
		sayret = [[
修练武器的金子太少...
你真的认为我的技术的价值就这么点数量的程度？
这个价格我不能做这个工作。 ..
#u#lc0000ff:1,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1066_22(human)--【盟重省】/综合服务生-3-@confirmupgrade
	local sayret = nil
	if true then
		sayret = [[
给我看你给我的原料
修炼你的#cff00ff,]]..""..[[#C，我的视力不好
我想从你的包里取得更多的饰品和黑铁矿石。
如果你有重要的物品，在你寄存在仓库后请回来
#u#lc0000ff:23,#cffff00,请求修炼#L#U#C
#u#lc0000ff:-1,#cffff00,在安排好以后再回来#L#U#C
]]
	end
	return sayret
end

function call_1066_23(human)--【盟重省】/综合服务生-3-@upgradenow
	local sayret = nil
	if human:是否仓库锁定() and true then
		return sayret
	elseif true then
		sayret = [[
messagebox  你的仓库已经锁住!请先解锁再来!
]]
	end
	return sayret
end

function call_1066_3(human)--【盟重省】/综合服务生-3-@getbackupgnow
	local sayret = nil
	if true then
		return sayret
	end
	return sayret
end

function call_1066_24(human)--【盟重省】/综合服务生-3-@Success
	local sayret = nil
	if true then
		sayret = [[
通过使用它，你可以体会到它精炼的好处。
无论你的战斗对象是其他玩家还是怪物...
你都会发现这个成果... 
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end

function call_1066_16(human)--【盟重省】/综合服务生-3-幸运项链\虎齿项链3@白色虎齿项链3
	local sayret = nil
	if 实用工具.GetRandomVal(1,4)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:装备属性升级(4,0,0,1,0)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将白色虎齿项链升级成功。项链被赋予了随机爆击点数。")
		return sayret
	end
	if 实用工具.GetRandomVal(1,3)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的白色虎齿项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,2)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的白色虎齿项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的白色虎齿项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的白色虎齿项链升级失败")
		return sayret
	end
	return sayret
end

function call_1066_15(human)--【盟重省】/综合服务生-3-幸运项链\灯笼项链3@灯笼项链3
	local sayret = nil
	if 实用工具.GetRandomVal(1,4)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:装备属性升级(4,0,0,1,0)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将灯笼项链幸运3升级成功，项链被赋予了随机爆击点数。")
		return sayret
	end
	if 实用工具.GetRandomVal(1,3)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的灯笼项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,2)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的灯笼项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的灯笼项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的灯笼项链升级失败")
		return sayret
	end
	return sayret
end

function call_1066_10(human)--【盟重省】/综合服务生-3-幸运项链\虎齿项链1@白色虎齿项链1
	local sayret = nil
	if true then
		human:调整元宝(human:获取元宝()-1000)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将白色虎齿项链升级成功。")
		return sayret
	end
	return sayret
end

function call_1066_9(human)--【盟重省】/综合服务生-3-幸运项链\灯笼项链1@灯笼项链1
	local sayret = nil
	if true then
		human:调整元宝(human:获取元宝()-1000)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将灯笼项链升级成功。")
		return sayret
	end
	return sayret
end

function call_1066_14(human)--【盟重省】/综合服务生-3-幸运项链\记忆项链2@记忆项链2
	local sayret = nil
	if 实用工具.GetRandomVal(1,2)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将记忆项链升级成功。")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:弹出消息框("非常抱歉您的记忆项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:弹出消息框("非常抱歉您的记忆项链升级失败")
		return sayret
	end
	return sayret
end

function call_1066_17(human)--【盟重省】/综合服务生-3-幸运项链\记忆项链3@记忆项链3
	local sayret = nil
	if 实用工具.GetRandomVal(1,4)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:装备属性升级(4,0,0,1,0)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将记忆项链升级成功。项链被赋予了随机爆击点数。")
		return sayret
	end
	if 实用工具.GetRandomVal(1,3)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的记忆项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,2)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的记忆项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的记忆项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-3000)
		human:弹出消息框("非常抱歉您的记忆项链升级失败")
		return sayret
	end
	return sayret
end

function call_1066_13(human)--【盟重省】/综合服务生-3-幸运项链\虎齿项链2@白色虎齿项链2
	local sayret = nil
	if 实用工具.GetRandomVal(1,2)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将白色虎齿项链升级成功。")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:弹出消息框("非常抱歉您的白色虎齿项链升级失败")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:弹出消息框("非常抱歉您的白色虎齿项链升级失败")
		return sayret
	end
	return sayret
end

function call_1066_11(human)--【盟重省】/综合服务生-3-幸运项链\记忆项链1@记忆项链1
	local sayret = nil
	if true then
		human:调整元宝(human:获取元宝()-1000)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将记忆项链升级成功。")
		return sayret
	end
	return sayret
end

function call_1066_12(human)--【盟重省】/综合服务生-3-幸运项链\灯笼项链2@灯笼项链2
	local sayret = nil
	if 实用工具.GetRandomVal(1,2)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:装备属性升级(4,13,0,1,0)
		全服广播("#cff00ff,".."恭喜["..human:获取名字().."]在幸运之家将灯笼项链升级成功。")
		return sayret
	end
	if 实用工具.GetRandomVal(1,1)==1 and true then
		human:调整元宝(human:获取元宝()-2000)
		human:弹出消息框("非常抱歉您的灯笼项链升级失败")
		return sayret
	end
	return sayret
end
function call_1067_0(human)--【盟重省】/东郊皇陵-3-@main
	local sayret = nil
	if true then
		sayret = [[
玛法大陆最险恶的墓地
很多邪恶的领主野兽死在里面
他们的灵魂每隔一段时间都会复活
传说在墓地的三层有很强大的神兵"霸者之刃"出现
#u#lc0000ff:1,#cffff00,进入死亡陵墓#L#U#C 
#u#lc0000ff:-1,#cffff00,骗人我才不去#L#U#C
]]
	end
	return sayret
end

function call_1067_1(human)--【盟重省】/东郊皇陵-3-@进入
	local sayret = nil
	if true then
		human:传送(463,72*48,17*32)
	end
	return sayret
end
function call_1068_0(human)--【盟重省】/加官进爵-3-@MAIN
	local sayret = nil
	if true then
		sayret = [[
#c00FFFF,九品知县#C + #c00FF00,特殊封号#C  #cFF00FF,上线+1点攻.魔.道属性#C  →  #cFFFF00,44级自动赠送#C
#c00FFFF,八品知府#C + #c00FF00,特殊封号#C  #cFF00FF,上线+2点攻.魔.道属性#C  →  #cFFFF00,45级自动赠送#C
#c00FFFF,七品太守#C + #c00FF00,特殊封号#C  #cFF00FF,上线+3点攻.魔.道属性#C  →  #cFFFF00,46级自动赠送#C
#c00FFFF,六品巡抚#C + #c00FF00,特殊封号#C  #cFF00FF,上线+4点攻.魔.道属性#C  →  #cFFFF00,47级自动赠送#C
#c00FFFF,五品提督#C + #c00FF00,特殊封号#C  #cFF00FF,上线+5点攻.魔.道属性#C  →  #cFFFF00,48级自动赠送#C
#c00FFFF,四品总督#C + #c00FF00,特殊封号#C  #cFF00FF,上线+6点攻.魔.道属性#C  →  #cFFFF00,49级自动赠送#C
#c00FFFF,三品尚书#C + #c00FF00,特殊封号#C  #cFF00FF,上线+7点攻.魔.道属性#C  →  #cFFFF00,50级自动赠送#C
#c00FFFF,二品太傅#C + #c00FF00,特殊封号#C  #cFF00FF,上线+8点攻.魔.道属性#C  →  #cFFFF00,51级自动赠送#C
#c00FFFF,一统天下#C + #c00FF00,特殊封号#C  #cFF00FF,上线+10点攻.魔#C →  #cFFFF00,52级自动赠送#C
#cFF0000,注：以上封号及上线属性,玩家达到相应级别后,小退上线即可查看!#C
]]
	end
	return sayret
end
function call_1069_0(human)--【盟重省】/装备回收-3-@main
	local sayret = nil
	if true then
		sayret = [[
#c00ffff,本服开放装备一件回收,分别为元宝和经验回收,屠龙霸者不设回收!#C
#c00ffff,回收前请仔细检查包裹内是否有极品,以免造成损失!#C 
=========#c00ffff,↓元宝回收↓#C=================#c00ffff,↓经验回收↓#C=========
#cFF00FF,祖玛首饰#C #u#lc0000ff:1,#cffff00,1键回收#L#U#C    #c00FF00,祖玛首饰#C #u#lc0000ff:2,#cffff00,1键回收#L#U#C
#cFF00FF,祖玛武器#C #u#lc0000ff:3,#cffff00,1键回收#L#U#C    #c00FF00,祖玛武器#C #u#lc0000ff:4,#cffff00,1键回收#L#U#C
#cFF00FF,赤月首饰#C #u#lc0000ff:5,#cffff00,1键回收#L#U#C    #c00FF00,赤月首饰#C #u#lc0000ff:6,#cffff00,1键回收#L#U#C
#cFF00FF,40级衣服#C #u#lc0000ff:7,#cffff00,1键回收#L#U#C    #c00FF00,40级衣服#C #u#lc0000ff:8,#cffff00,1键回收#L#U#C
#cFF00FF,怒斩龙牙#C #u#lc0000ff:9,#cffff00,1键回收#L#U#C    #c00FF00,怒斩龙牙#C #u#lc0000ff:10,#cffff00,1键回收#L#U#C
注意:祖码首饰回收不包括#c00ffff,"黑铁头盔"#C,40级衣服回收包含武器#c00ffff,"血饮"#C
　　 怒斩龙牙回收包括#c00ffff,逍遥扇#C,玩家回收时请注意极品装备!
]]
	end
	return sayret
end

function call_1069_9(human)--【盟重省】/装备回收-3-@新武器元宝
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10267,1) and true then
		human:收回物品(10267,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10268,1) and true then
		human:收回物品(10268,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10269,1) and true then
		human:收回物品(10269,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10267,1) and true then
		human:收回物品(10267,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10268,1) and true then
		human:收回物品(10268,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10269,1) and true then
		human:收回物品(10269,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10267,1) and true then
		human:收回物品(10267,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10268,1) and true then
		human:收回物品(10268,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if human:检查物品数量(10269,1) and true then
		human:收回物品(10269,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),80)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整元宝(human:获取元宝()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了新武器("..(human.私人变量.P8 or 0)..")件,获得元宝+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无新武器。")
		return sayret
	end
	return sayret
end

function call_1069_7(human)--【盟重省】/装备回收-3-@衣服元宝
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10166,1) and true then
		human:收回物品(10166,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10266,1) and true then
		human:收回物品(10266,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10265,1) and true then
		human:收回物品(10265,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10264,1) and true then
		human:收回物品(10264,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10263,1) and true then
		human:收回物品(10263,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10262,1) and true then
		human:收回物品(10262,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10261,1) and true then
		human:收回物品(10261,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10166,1) and true then
		human:收回物品(10166,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10266,1) and true then
		human:收回物品(10266,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10265,1) and true then
		human:收回物品(10265,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10264,1) and true then
		human:收回物品(10264,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10263,1) and true then
		human:收回物品(10263,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10262,1) and true then
		human:收回物品(10262,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10261,1) and true then
		human:收回物品(10261,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10166,1) and true then
		human:收回物品(10166,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10266,1) and true then
		human:收回物品(10266,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10265,1) and true then
		human:收回物品(10265,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10264,1) and true then
		human:收回物品(10264,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10263,1) and true then
		human:收回物品(10263,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10262,1) and true then
		human:收回物品(10262,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10261,1) and true then
		human:收回物品(10261,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整元宝(human:获取元宝()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了40级衣服("..(human.私人变量.P8 or 0)..")件,获得元宝+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无40级衣服。")
		return sayret
	end
	return sayret
end

function call_1069_5(human)--【盟重省】/装备回收-3-@赤月元宝
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),40)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整元宝(human:获取元宝()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了赤月首饰("..(human.私人变量.P8 or 0)..")件,获得元宝+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无赤月首饰。")
		return sayret
	end
	return sayret
end

function call_1069_3(human)--【盟重省】/装备回收-3-@裁决元宝
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),10)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整元宝(human:获取元宝()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了祖玛武器("..(human.私人变量.P8 or 0)..")件,获得元宝+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无祖玛武器。")
		return sayret
	end
	return sayret
end

function call_1069_1(human)--【盟重省】/装备回收-3-@祖玛元宝
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),5)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整元宝(human:获取元宝()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了祖玛装备("..(human.私人变量.P8 or 0)..")件,获得元宝+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无祖玛装备。")
		return sayret
	end
	return sayret
end

function call_1069_10(human)--【盟重省】/装备回收-3-@新武器经验
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10267,1) and true then
		human:收回物品(10267,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10268,1) and true then
		human:收回物品(10268,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10269,1) and true then
		human:收回物品(10269,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10267,1) and true then
		human:收回物品(10267,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10268,1) and true then
		human:收回物品(10268,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10269,1) and true then
		human:收回物品(10269,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10267,1) and true then
		human:收回物品(10267,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10268,1) and true then
		human:收回物品(10268,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if human:检查物品数量(10269,1) and true then
		human:收回物品(10269,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),400000)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整经验(human:获取经验()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了新武器("..(human.私人变量.P8 or 0)..")件,获得经验+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无新武器。")
		return sayret
	end
	return sayret
end

function call_1069_8(human)--【盟重省】/装备回收-3-@衣服经验
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10166,1) and true then
		human:收回物品(10166,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10266,1) and true then
		human:收回物品(10266,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10265,1) and true then
		human:收回物品(10265,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10264,1) and true then
		human:收回物品(10264,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10263,1) and true then
		human:收回物品(10263,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10262,1) and true then
		human:收回物品(10262,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10261,1) and true then
		human:收回物品(10261,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10166,1) and true then
		human:收回物品(10166,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10266,1) and true then
		human:收回物品(10266,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10265,1) and true then
		human:收回物品(10265,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10264,1) and true then
		human:收回物品(10264,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10263,1) and true then
		human:收回物品(10263,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10262,1) and true then
		human:收回物品(10262,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10261,1) and true then
		human:收回物品(10261,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10166,1) and true then
		human:收回物品(10166,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10266,1) and true then
		human:收回物品(10266,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10265,1) and true then
		human:收回物品(10265,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10264,1) and true then
		human:收回物品(10264,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10263,1) and true then
		human:收回物品(10263,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10262,1) and true then
		human:收回物品(10262,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10261,1) and true then
		human:收回物品(10261,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10166,1) and true then
		human:收回物品(10166,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10266,1) and true then
		human:收回物品(10266,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10265,1) and true then
		human:收回物品(10265,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10264,1) and true then
		human:收回物品(10264,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10263,1) and true then
		human:收回物品(10263,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10262,1) and true then
		human:收回物品(10262,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10261,1) and true then
		human:收回物品(10261,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整经验(human:获取经验()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了40级衣服("..(human.私人变量.P8 or 0)..")件,获得经验+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无40级衣服。")
		return sayret
	end
	return sayret
end

function call_1069_6(human)--【盟重省】/装备回收-3-@赤月经验
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10252,1) and true then
		human:收回物品(10252,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10251,1) and true then
		human:收回物品(10251,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10250,1) and true then
		human:收回物品(10250,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10260,1) and true then
		human:收回物品(10260,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10259,1) and true then
		human:收回物品(10259,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10258,1) and true then
		human:收回物品(10258,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10256,1) and true then
		human:收回物品(10256,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10255,1) and true then
		human:收回物品(10255,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10254,1) and true then
		human:收回物品(10254,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10253,1) and true then
		human:收回物品(10253,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10257,1) and true then
		human:收回物品(10257,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if human:检查物品数量(10249,1) and true then
		human:收回物品(10249,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),200000)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整经验(human:获取经验()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了赤月首饰("..(human.私人变量.P8 or 0)..")件,获得经验+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无赤月首饰。")
		return sayret
	end
	return sayret
end

function call_1069_4(human)--【盟重省】/装备回收-3-@裁决经验
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10167,1) and true then
		human:收回物品(10167,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10199,1) and true then
		human:收回物品(10199,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if human:检查物品数量(10200,1) and true then
		human:收回物品(10200,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),100000)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整经验(human:获取经验()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了祖玛武器("..(human.私人变量.P8 or 0)..")件,获得经验+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无祖玛武器。")
		return sayret
	end
	return sayret
end

function call_1069_2(human)--【盟重省】/装备回收-3-@祖玛经验
	local sayret = nil
	if human:获取等级()>0 and true then
		human.私人变量.P8=0
		human.私人变量.P9=0
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10182,1) and true then
		human:收回物品(10182,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10122,1) and true then
		human:收回物品(10122,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10204,1) and true then
		human:收回物品(10204,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10126,1) and true then
		human:收回物品(10126,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10123,1) and true then
		human:收回物品(10123,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10127,1) and true then
		human:收回物品(10127,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10203,1) and true then
		human:收回物品(10203,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10207,1) and true then
		human:收回物品(10207,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if human:检查物品数量(10130,1) and true then
		human:收回物品(10130,1)
		human.私人变量.P8=实用工具.SumString((human.私人变量.P8 or 0),1)
		human.私人变量.P9=实用工具.SumString((human.私人变量.P9 or 0),50000)
	end
	if (human.私人变量.P8 or 0)>0 and true then
		human:调整经验(human:获取经验()+(human.私人变量.P9 or 0))
		全服广播("#cff00ff,".."提示：玩家【"..human:获取名字().."】一键回收了祖玛装备("..(human.私人变量.P8 or 0)..")件,获得经验+("..(human.私人变量.P9 or 0)..")")
		human.私人变量.P8=0
		human.私人变量.P9=0
		sayret = call_1069_0(human) or sayret--@MAIN
	elseif true then
		human:发送广播("#c00ff00,".."你背包中无祖玛装备。")
		return sayret
	end
	return sayret
end
function call_1070_0(human)--【盟重省】/勇夺皇宫-3-@MAIN
	local sayret = nil
	if true then
		sayret = [[
~~●█〓██▄▄▄▄▄▄●●●●●●  兄弟们,往皇宫冲啊
▄▄██████▄▄▃▂   #c00ff00,纪律+速度+团结#C
██████████████   #c00ff00,砝码勇士们加油#C
◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲◤
╔══════════════════════════╗
‖所有点位均需要10万金币的过路费                      ‖
┠══════════════════════════┨
‖#u#lc0000ff:1,#cffff00,拿沙一号点#L#U#C‖‖#u#lc0000ff:2,#cffff00,拿沙二号点#L#U#C‖‖#u#lc0000ff:3,#cffff00,拿沙三号点#L#U#C‖‖#u#lc0000ff:4,#cffff00,拿沙复活点#L#U#C‖
╚═════╝╚═════╝╚═════╝╚═════╝
]]
	end
	return sayret
end

function call_1070_1(human)--【盟重省】/勇夺皇宫-3-@ns1
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:传送(186,631*48,286*32)
		return sayret
	elseif true then
		sayret = [[
你没有10万金币，看清楚介绍在进，别想忽悠俺们！
]]
	end
	return sayret
end

function call_1070_2(human)--【盟重省】/勇夺皇宫-3-@ns2
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:传送(186,613*48,284*32)
		return sayret
	elseif true then
		sayret = [[
你没有10万金币，看清楚介绍在进，别想忽悠俺们！
]]
	end
	return sayret
end

function call_1070_3(human)--【盟重省】/勇夺皇宫-3-@ns3
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:传送(186,643*48,256*32)
		return sayret
	elseif true then
		sayret = [[
你没有10万金币，看清楚介绍在进，别想忽悠俺们！
]]
	end
	return sayret
end

function call_1070_4(human)--【盟重省】/勇夺皇宫-3-@ns4
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:传送(186,647*48,290*32)
		return sayret
	elseif true then
		sayret = [[
你没有10万金币，看清楚介绍在进，别想忽悠俺们！
]]
	end
	return sayret
end
function call_1071_0(human)--【盟重省】/盟重老兵-3-@main
	local sayret = nil
	if true then
		sayret = [[
在这里我将为你提供一些免费商店传送！   
#u#lc0000ff:1,#cffff00,≮铁匠铺≯#L#U#C   #u#lc0000ff:2,#cffff00,≮客  栈≯#L#U#C
#u#lc0000ff:3,#cffff00,≮首饰店≯#L#U#C   #u#lc0000ff:4,#cffff00,≮布料店≯#L#U#C
#u#lc0000ff:5,#cffff00,≮书  店≯#L#U#C  
#u#lc0000ff:-1,#cffff00,≮关  闭≯#L#U#C
]]
	end
	return sayret
end

function call_1071_1(human)--【盟重省】/盟重老兵-3-@Gwe
	local sayret = nil
	if true then
		human:随机传送(195)
	end
	return sayret
end

function call_1071_4(human)--【盟重省】/盟重老兵-3-@Gpo
	local sayret = nil
	if true then
		human:随机传送(193)
	end
	return sayret
end

function call_1071_3(human)--【盟重省】/盟重老兵-3-@Gza
	local sayret = nil
	if true then
		human:随机传送(194)
	end
	return sayret
end

function call_1071_2(human)--【盟重省】/盟重老兵-3-@Gwh
	local sayret = nil
	if true then
		human:随机传送(189)
	end
	return sayret
end

function call_1071_5(human)--【盟重省】/盟重老兵-3-@Gbo
	local sayret = nil
	if true then
		human:随机传送(197)
	end
	return sayret
end
function call_1072_0(human)--【盟重省】/林小姐-0148-@main
	local sayret = nil
	if true then
		sayret = [[
哦，我也要快一点赚钱，开这样的客栈。
这样就得努力做事。 
#u#lc0000ff:-1,#cffff00,关 闭#L#U#C
]]
	end
	return sayret
end
function call_1073_0(human)--【盟重省】/林小姐-FPQP1-@main
	local sayret = nil
	if true then
		sayret = [[
注意:除非棋牌房,其他任何地方都可能涉嫌诈骗!
  
#u#lc0000ff:1,#cffff00,返回土城#L#U#C

#u#lc0000ff:-1,#cffff00,关闭退出#L#U#C
]]
	end
	return sayret
end

function call_1073_1(human)--【盟重省】/林小姐-FPQP1-@gomo3
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
	end
	return sayret
end
function call_1074_0(human)--【盟重省】/林小姐-FPQP2-@main
	local sayret = nil
	if true then
		sayret = [[
注意:除非棋牌房,其他任何地方都可能涉嫌诈骗!
  
#u#lc0000ff:1,#cffff00,返回土城#L#U#C

#u#lc0000ff:-1,#cffff00,关闭退出#L#U#C
]]
	end
	return sayret
end

function call_1074_1(human)--【盟重省】/林小姐-FPQP2-@gomo3
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
	end
	return sayret
end
function call_1075_0(human)--【盟重省】/林小姐-FPQP3-@main
	local sayret = nil
	if true then
		sayret = [[
注意:除非棋牌房,其他任何地方都可能涉嫌诈骗!
  
#u#lc0000ff:1,#cffff00,返回土城#L#U#C

#u#lc0000ff:-1,#cffff00,关闭退出#L#U#C
]]
	end
	return sayret
end

function call_1075_1(human)--【盟重省】/林小姐-FPQP3-@gomo3
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
	end
	return sayret
end
function call_1076_0(human)--【盟重省】/林小姐-FPQP4-@main
	local sayret = nil
	if true then
		sayret = [[
注意:除非棋牌房,其他任何地方都可能涉嫌诈骗!
  
#u#lc0000ff:1,#cffff00,返回土城#L#U#C

#u#lc0000ff:-1,#cffff00,关闭退出#L#U#C
]]
	end
	return sayret
end

function call_1076_1(human)--【盟重省】/林小姐-FPQP4-@gomo3
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
	end
	return sayret
end
function call_1077_0(human)--【盟重省】/赌博/美女服务员-3-@MAIN
	local sayret = nil
	if (全局变量.H31 or 0)==0 and true then
		sayret = [[
赌博开放时间为 每天晚上15:00-17:00 22:00-24:00 其他时间为关闭状态
#u#lc0000ff:1,#cffff00,回盟重土城#L#U#C
]]
		return sayret
	end
	if human:是否管理员() and (全局变量.A35 or "")=="无" and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#u#lc0000ff:3:2:40,#cffff00,开始抢庄#L#U#C┊  ┊#cFF0000,下注押大#C┊  ┊#cFF0000,下注押小#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#cFF0000,抢庄时间：#C10
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】    #u#lc0000ff:4,#cffff00,设置税率#L#U#C
#u#lc0000ff:5,#cffff00,设置骰子1的点数#L#U#C：]]..(全局变量.I64 or 0)..[[#B，#u#lc0000ff:6,#cffff00,骰子2的点数#L#U#C：]]..(全局变量.I65 or 0)..[[#B，#u#lc0000ff:7,#cffff00,骰子3的点数#L#U#C：]]..(全局变量.I66 or 0)..[[#B
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】
#c00FFFF,请同时设置3个骰子的点数，并且在开出点数前设置完成，#C
#c00FFFF,如果在设置中途，系统进行摇骰子，那你设置的点数将作废，点数归零，#C
#c00FFFF,同时设置3个骰子的点数后，请耐心等待倒计时结束后系统自动开点。#C
#c00FFFF,当前税率：#C]]..(全局变量.H30 or 0)..[[#B%,不能为0%否则会出错！
]]
		return sayret
	end
	if human:是否管理员() and (全局变量.A35 or "")=="" and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#u#lc0000ff:3:2:40,#cffff00,开始抢庄#L#U#C┊  ┊#cFF0000,下注押大#C┊  ┊#cFF0000,下注押小#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#cFF0000,抢庄时间：#C10
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】    #u#lc0000ff:4,#cffff00,设置税率#L#U#C
#u#lc0000ff:5,#cffff00,设置骰子1的点数#L#U#C：]]..(全局变量.I64 or 0)..[[#B，#u#lc0000ff:6,#cffff00,骰子2的点数#L#U#C：]]..(全局变量.I65 or 0)..[[#B，#u#lc0000ff:7,#cffff00,骰子3的点数#L#U#C：]]..(全局变量.I66 or 0)..[[#B
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】
#c00FFFF,请同时设置3个骰子的点数，并且在开出点数前设置完成，#C
#c00FFFF,如果在设置中途，系统进行摇骰子，那你设置的点数将作废，点数归零，#C
#c00FFFF,同时设置3个骰子的点数后，请耐心等待倒计时结束后系统自动开点。#C
#c00FFFF,当前税率：#C]]..(全局变量.H30 or 0)..[[#B%,不能为0%否则会出错！
]]
		return sayret
	end
	if (全局变量.A35 or "")=="无" and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#u#lc0000ff:3:2:40,#cffff00,开始抢庄#L#U#C┊  ┊#cFF0000,下注押大#C┊  ┊#cFF0000,下注押小#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#cFF0000,抢庄时间：#C10
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】  
#c00ff00,提示：押大赢大，押小赢小，豹子通吃！本游戏系统不收取税金#C
#c00ff00,但若游戏时玩家单独掉线导致元宝无法收回情况服务器不负责任#C
#c00FFFF,╔┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╗#C
#c00FFFF,┊友情提示：游戏只为娱乐，小赌贻情，大赌伤身，切勿贪迷赌博。┊#C
#c00FFFF,╚┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╝#C
]]
		return sayret
	end
	if (全局变量.A35 or "")=="" and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#u#lc0000ff:3:2:40,#cffff00,开始抢庄#L#U#C┊  ┊#cFF0000,下注押大#C┊  ┊#cFF0000,下注押小#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#cFF0000,抢庄时间：#C10
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】  
#c00ff00,提示：押大赢大，押小赢小，豹子通吃！本游戏系统不收取税金#C
#c00ff00,但若游戏时玩家单独掉线导致元宝无法收回情况服务器不负责任#C
#c00FFFF,╔┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╗#C
#c00FFFF,┊友情提示：游戏只为娱乐，小赌贻情，大赌伤身，切勿贪迷赌博。┊#C
#c00FFFF,╚┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╝#C
]]
		return sayret
	end
	if (全局变量.I10 or 0)>0 and human:是否管理员() and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#u#lc0000ff:3:2:40,#cffff00,开始抢庄#L#U#C┊  ┊#cFF0000,下注押大#C┊  ┊#cFF0000,下注押小#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#cFF0000,抢庄时间：#C]]..(全局变量.I10 or 0)..[[#B
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】    #u#lc0000ff:4,#cffff00,设置税率#L#U#C
#u#lc0000ff:5,#cffff00,设置骰子1的点数#L#U#C：]]..(全局变量.I64 or 0)..[[#B，#u#lc0000ff:6,#cffff00,骰子2的点数#L#U#C：]]..(全局变量.I65 or 0)..[[#B，#u#lc0000ff:7,#cffff00,骰子3的点数#L#U#C：]]..(全局变量.I66 or 0)..[[#B
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】
#c00FFFF,请同时设置3个骰子的点数，并且在开出点数前设置完成，#C
#c00FFFF,如果在设置中途，系统进行摇骰子，那你设置的点数将作废，点数归零，#C
#c00FFFF,同时设置3个骰子的点数后，请耐心等待倒计时结束后系统自动开点。#C
#c00FFFF,当前税率：#C]]..(全局变量.H30 or 0)..[[#B%,不能为0%否则会出错！
]]
		human.私人变量.M47=2
		return sayret
	end
	if (全局变量.I10 or 0)>0 and human:获取等级()>0 and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#u#lc0000ff:3:2:40,#cffff00,开始抢庄#L#U#C┊  ┊#cFF0000,下注押大#C┊  ┊#cFF0000,下注押小#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#cFF0000,抢庄时间：#C]]..(全局变量.I10 or 0)..[[#B
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】  
#c00ff00,提示：押大赢大，押小赢小，豹子通吃！本游戏系统不收取税金#C
#c00ff00,但若游戏时玩家单独掉线导致元宝无法收回情况服务器不负责任#C
#c00FFFF,╔┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╗#C
#c00FFFF,┊友情提示：游戏只为娱乐，小赌贻情，大赌伤身，切勿贪迷赌博。┊#C
#c00FFFF,╚┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╝#C
]]
		human.私人变量.M47=2
		return sayret
	end
	if human:是否管理员() and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#cFF0000,开始抢庄#C┊  ┊#u#lc0000ff:8:2:41,#cffff00,下注押大#L#U#C┊  ┊#u#lc0000ff:9:2:42,#cffff00,下注押小#L#U#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#c00FFFF,下注时间：#C]]..(全局变量.I15 or 0)..[[#B
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】    #u#lc0000ff:4,#cffff00,设置税率#L#U#C
#u#lc0000ff:5,#cffff00,设置骰子1的点数#L#U#C：]]..(全局变量.I64 or 0)..[[#B，#u#lc0000ff:6,#cffff00,骰子2的点数#L#U#C：]]..(全局变量.I65 or 0)..[[#B，#u#lc0000ff:7,#cffff00,骰子3的点数#L#U#C：]]..(全局变量.I66 or 0)..[[#B
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】
#c00FFFF,请同时设置3个骰子的点数，并且在开出点数前设置完成，#C
#c00FFFF,如果在设置中途，系统进行摇骰子，那你设置的点数将作废，点数归零，#C
#c00FFFF,同时设置3个骰子的点数后，请耐心等待倒计时结束后系统自动开点。#C
#c00FFFF,当前税率：#C]]..(全局变量.H30 or 0)..[[#B%,不能为0%否则会出错！
]]
		human.私人变量.M47=2
		return sayret
	end
	if human:获取等级()>0 and true then
		sayret = [[
欢迎光临，这里是抢庄猜点赌场，你所拥有的元宝：【#cff00ff,]]..human:获取元宝()..[[#C】
庄家姓名：【]]..(全局变量.A35 or "")..[[#B】　庄家本钱数：【]]..(全局变量.I31 or 0)..[[#B】
╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗  ╔┈┈┈┈╗
┊#u#lc0000ff:2,#cffff00,查看说明#L#U#C┊  ┊#cFF0000,开始抢庄#C┊  ┊#u#lc0000ff:8:2:41,#cffff00,下注押大#L#U#C┊  ┊#u#lc0000ff:9:2:42,#cffff00,下注押小#L#U#C┊
╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝  ╚┈┈┈┈╝
押大总金额：【]]..(全局变量.I13 or 0)..[[#B】　　　　　　　　　　　#c00FFFF,下注时间：#C]]..(全局变量.I15 or 0)..[[#B
押小总金额：【]]..(全局变量.I14 or 0)..[[#B】    #u#lc0000ff:1,#cffff00,回盟重土城#L#U#C    #u#lc0000ff:0,#cffff00,刷新#L#U#C
你的下注情况：你下注【]]..(human.私人变量.M43 or 0)..[[#B】元宝押【]]..(human.私人变量.S23 or "")..[[#B】
#cFF00FF,历史记录：#C【]]..(全局变量.A36 or "")..[[#B】  
#c00ff00,提示：押大赢大，押小赢小，豹子通吃！本游戏系统不收取税金#C
#c00ff00,但若游戏时玩家单独掉线导致元宝无法收回情况服务器不负责任#C
#c00FFFF,╔┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╗#C
#c00FFFF,┊友情提示：游戏只为娱乐，小赌贻情，大赌伤身，切勿贪迷赌博。┊#C
#c00FFFF,╚┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╝#C
]]
		human.私人变量.M47=2
		return sayret
	end
	return sayret
end

function call_1077_4(human)--【盟重省】/赌博/美女服务员-3-@设置税率
	local sayret = nil
	if human:是否管理员() and true then
		return sayret
	end
	return sayret
end

function call_1077_1(human)--【盟重省】/赌博/美女服务员-3-@HTCL
	local sayret = nil
	if true then
		human:传送(186,330*48,330*32)
	end
	return sayret
end

function call_1077_5(human)--【盟重省】/赌博/美女服务员-3-@A
	local sayret = nil
	if human:是否管理员() and true then
		return sayret
	end
	return sayret
end

function call_1077_6(human)--【盟重省】/赌博/美女服务员-3-@B
	local sayret = nil
	if human:是否管理员() and true then
		return sayret
	end
	return sayret
end

function call_1077_7(human)--【盟重省】/赌博/美女服务员-3-@C
	local sayret = nil
	if human:是否管理员() and true then
		return sayret
	end
	return sayret
end

function call_1077_3(human)--【盟重省】/赌博/美女服务员-3-@InPutInteger40
	local sayret = nil
	if human:获取等级()>0 and true then
		sayret = call_1077_10(human) or sayret--~InPutInteger40
	end
	return sayret
end

function call_1077_10(human)--【盟重省】/赌博/美女服务员-3-~InPutInteger40
	local sayret = nil
	if (全局变量.I12 or 0)>10 and true then
		human:弹出消息框("[提示]：抢庄时间已经结束。请等待开局！")
		human.私人变量.M40=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M40 or 0)<10 and true then
		human:弹出消息框("[提示]：请输入10以上的数值！")
		human.私人变量.M40=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M40 or 0)>200000 and true then
		human:弹出消息框("[提示]：请输入200000以下的数值！")
		human.私人变量.M40=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.A35 or "")==human:获取名字() and true then
		human.私人变量.M40=0
		human:弹出消息框("[提示]：你目前已经是庄家，无法重复坐庄。")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M45 or 0)==2 and true then
		human.私人变量.M40=0
		human:弹出消息框("[提示]：你已经下注押了大，无法坐庄！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M45 or 0)==3 and true then
		human.私人变量.M40=0
		human:弹出消息框("[提示]：你已经下注押了小，无法坐庄！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if human:获取元宝()>(human.私人变量.M40 or 0) and true then
	elseif true then
		human:弹出消息框("[提示]：你身上的元宝不足。")
		human.私人变量.M40=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.A35 or "")=="无" and (human.私人变量.M40 or 0)>(全局变量.I31 or 0) and true then
		全局变量.I10=10
		human:调整元宝(human:获取元宝()-(human.私人变量.M40 or 0))
		全局变量.I31=(human.私人变量.M40 or 0)
		全服广播("#cff00ff,"..human:获取名字().."使用"..(human.私人变量.M40 or 0).."个元宝坐庄。")
		全服广播("#cff00ff,".."[美女庄家]：玩家【"..human:获取名字().."】使用【"..(human.私人变量.M40 or 0).."】个元宝坐庄。")
		全局变量.A35=human:获取名字()
		human.私人变量.M43=(human.私人变量.M40 or 0)
		human.私人变量.S23="庄"
		sayret = call_1077_0(human) or sayret--@MAIN
		human:弹出消息框("[提示]：使用【"..(human.私人变量.M40 or 0).."】个元宝坐庄。")
		return sayret
	end
	if (全局变量.A35 or "")=="" and (human.私人变量.M40 or 0)>(全局变量.I31 or 0) and true then
		全局变量.I10=10
		human:调整元宝(human:获取元宝()-(human.私人变量.M40 or 0))
		全局变量.I31=(human.私人变量.M40 or 0)
		全服广播("#cff00ff,"..human:获取名字().."使用"..(human.私人变量.M40 or 0).."个元宝坐庄。")
		全服广播("#cff00ff,".."[美女庄家]：玩家【"..human:获取名字().."】使用【"..(human.私人变量.M40 or 0).."】个元宝坐庄。")
		全局变量.A35=human:获取名字()
		human.私人变量.M43=(human.私人变量.M40 or 0)
		human.私人变量.S23="庄"
		sayret = call_1077_0(human) or sayret--@MAIN
		human:弹出消息框("[提示]：使用【"..(human.私人变量.M40 or 0).."】个元宝坐庄。")
		return sayret
	end
	if (human.私人变量.M40 or 0)>(全局变量.I31 or 0) and true then
		human.私人变量.S23="无"
		human.私人变量.M43=0
		在线玩家管理["$str(a35)"]:调整元宝(在线玩家管理["$str(a35)"]:获取元宝()+(全局变量.I31 or 0))
		human:调整元宝(human:获取元宝()-(human.私人变量.M40 or 0))
		全局变量.I31=(human.私人变量.M40 or 0)
		全服广播("#cff00ff,"..human:获取名字().."使用"..(human.私人变量.M40 or 0).."个元宝坐庄。")
		全服广播("#cff00ff,".."[美女庄家]：玩家【"..human:获取名字().."】使用【"..(human.私人变量.M40 or 0).."】个元宝坐庄。")
		全局变量.A35=human:获取名字()
		human.私人变量.M43=(human.私人变量.M40 or 0)
		human.私人变量.S23="庄"
		sayret = call_1077_0(human) or sayret--@MAIN
		human:弹出消息框("[提示]：使用【"..(human.私人变量.M40 or 0).."】个元宝坐庄。")
		return sayret
	elseif true then
		human:弹出消息框("[提示]：你必须出多于【"..(全局变量.I31 or 0).."】个元宝才能抢庄。")
		human.私人变量.M40=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	return sayret
end

function call_1077_8(human)--【盟重省】/赌博/美女服务员-3-@InPutInteger41
	local sayret = nil
	if human:获取等级()>0 and true then
		sayret = call_1077_11(human) or sayret--~InPutInteger41
	end
	return sayret
end

function call_1077_11(human)--【盟重省】/赌博/美女服务员-3-~InPutInteger41
	local sayret = nil
	if (全局变量.I12 or 0)>70 and true then
		human:弹出消息框("[提示]：下注时间已经结束。请等待开局！")
		human.私人变量.M41=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.I12 or 0)<11 and true then
		human:弹出消息框("[提示]：下注时间还没到，现在是抢庄时间。")
		human.私人变量.M41=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M41 or 0)<10 and true then
		human:弹出消息框("[提示]：请输入10以上的数值！")
		human.私人变量.M41=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.A35 or "")==human:获取名字() and true then
		human.私人变量.M40=0
		human:弹出消息框("[提示]：你目前已经是庄家，无法下注。")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M45 or 0)==2 and true then
		human.私人变量.M41=0
		human:弹出消息框("[提示]：你已经下注押了大，无法重复下注！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M45 or 0)==3 and true then
		human.私人变量.M41=0
		human:弹出消息框("[提示]：你已经下注押了小，无法重复下注！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M41 or 0)>(全局变量.I16 or 0) and true then
		human.私人变量.M41=0
		human:弹出消息框("[提示]：对不起，庄家的本钱已达到上线不够赔了。\\　　　　\\目前你只可以下注【"..(全局变量.I16 or 0).."】以下的元宝！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.I18 or 0)==1 and true then
		human.私人变量.M40=0
		human:弹出消息框("[提示]：请重新输入。")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if human:获取元宝()>(human.私人变量.M41 or 0) and true then
		全局变量.I18=1
		human.私人变量.M45=2
		human.私人变量.S23="大"
		human:调整元宝(human:获取元宝()-(human.私人变量.M41 or 0))
		human.私人变量.M43=(human.私人变量.M41 or 0)
		全局变量.I13=实用工具.SumString((全局变量.I13 or 0),(human.私人变量.M43 or 0))
		全服广播("#cff00ff,"..human:获取名字().."使用"..(human.私人变量.M41 or 0).."个元宝下注押大。")
		sayret = call_1077_0(human) or sayret--@MAIN
		human:弹出消息框("[提示]：使用【"..(human.私人变量.M41 or 0).."】个元宝下注押大。")
		human.私人变量.M41=0
		return sayret
	elseif true then
		human:弹出消息框("[提示]：你身上的元宝不足。")
		human.私人变量.M41=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	return sayret
end

function call_1077_9(human)--【盟重省】/赌博/美女服务员-3-@InPutInteger42
	local sayret = nil
	if human:获取等级()>0 and true then
		sayret = call_1077_12(human) or sayret--~InPutInteger42
	end
	return sayret
end

function call_1077_12(human)--【盟重省】/赌博/美女服务员-3-~InPutInteger42
	local sayret = nil
	if (全局变量.I12 or 0)>70 and true then
		human:弹出消息框("[提示]：下注时间已经结束。请等待开局！")
		human.私人变量.M42=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.I12 or 0)<11 and true then
		human:弹出消息框("[提示]：下注时间还没到，现在是抢庄时间。")
		human.私人变量.M42=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M42 or 0)<10 and true then
		human:弹出消息框("[提示]：请输入10以上的数值！")
		human.私人变量.M42=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.A35 or "")==human:获取名字() and true then
		human.私人变量.M40=0
		human:弹出消息框("[提示]：你目前已经是庄家，无法重复坐庄。")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M45 or 0)==2 and true then
		human.私人变量.M42=0
		human:弹出消息框("[提示]：你已经下注押了大，无法重复下注！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M45 or 0)==3 and true then
		human.私人变量.M42=0
		human:弹出消息框("[提示]：你已经下注押了小，无法重复下注！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (human.私人变量.M42 or 0)>(全局变量.I17 or 0) and true then
		human.私人变量.M42=0
		human:弹出消息框("[提示]：对不起，庄家的本钱已达到上线不够赔了。\\　　　　\\目前你只可以下注【"..(全局变量.I17 or 0).."】以下的元宝！")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if (全局变量.I19 or 0)==1 and true then
		human.私人变量.M40=0
		human:弹出消息框("[提示]：请重新输入。")
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	if human:获取元宝()>(human.私人变量.M42 or 0) and true then
		全局变量.I19=1
		human.私人变量.M45=3
		human.私人变量.S23="小"
		human:调整元宝(human:获取元宝()-(human.私人变量.M42 or 0))
		human.私人变量.M43=(human.私人变量.M42 or 0)
		全局变量.I14=实用工具.SumString((全局变量.I14 or 0),(human.私人变量.M43 or 0))
		全服广播("#cff00ff,"..human:获取名字().."使用"..(human.私人变量.M42 or 0).."个元宝下注押小。")
		sayret = call_1077_0(human) or sayret--@MAIN
		human:弹出消息框("[提示]：使用【"..(human.私人变量.M42 or 0).."】个元宝下注押小。")
		human.私人变量.M42=0
		return sayret
	elseif true then
		human:弹出消息框("[提示]：你身上的元宝不足。")
		human.私人变量.M42=0
		sayret = call_1077_0(human) or sayret--@MAIN
		return sayret
	end
	return sayret
end

function call_1077_13(human)--【盟重省】/赌博/美女服务员-3-@Over
	local sayret = nil
	if true then
		human:传送(186,330*48,330*32)
		return sayret
	end
	return sayret
end

function call_1077_2(human)--【盟重省】/赌博/美女服务员-3-@Help
	local sayret = nil
	if true then
		sayret = [[
猜点游戏规则：
(1)庄家坐庄后，其他玩家可下注，两分钟后三个骰子由庄家掷出，
骰子点数随机出现点数总和小于11代表小，点数总和大于10代表
大，三个点数相同代表豹子。
(2)押大赢大，押小赢小，豹子通吃！本游戏系统不收取税金。
(3)正在坐庄或已下注的玩家如下线将被视做弃权，损失下注元宝。
(4)玩家下注数不能超过庄家坐庄的元宝总和。
#u#lc0000ff:0,#cffff00,返回#L#U#C　　#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1077_14(human)--【盟重省】/赌博/美女服务员-3-@IsInFilterList
	local sayret = nil
	if true then
		human:弹出消息框("[错误]：输入数据中包含了非法字符，请重新编辑！")
	end
	return sayret
end
function call_1078_0(human)--【盟重省】/活动/行会争霸-3-@MAIN
	local sayret = nil
	if true then
		sayret = [[
详细规则：晚上22:30系统自动举行,22:50关闭入口
　　　　　22:51活动正式开始,23:25活动自动结束!
　　　　　如果23:25未分胜负,所有成员自动回城,将无法领奖励 
获胜奖励：半小时中赢得胜利的行会,可以获得999元宝奖励 
进入条件：进入需要加入行会，等级需30级以上！ 
#u#lc0000ff:1,#cffff00,进入场地#L#U#C
]]
	end
	return sayret
end

function call_1078_1(human)--【盟重省】/活动/行会争霸-3-@进入场地
	local sayret = nil
	if human:是否有行会() and true then
		human:传送(455,20*48,23*32)
		return sayret
	elseif true then
		sayret = [[
你加入行会了吗,等级够30级吗?
每天行会争霸开门时间是每天22:30-22:50分
]]
	end
	return sayret
end
function call_1079_0(human)--【盟重省】/活动/行会争霸-D5071B-@main
	local sayret = nil
	if true then
		sayret = [[
现在行会争霸地图已经关闭了
只要你的行会打败了其他行会
行会掌门人就可以获得#c00ff00,999元宝#C奖励！
现在这个地图里面是否只剩下你们行会的成员了呢
如果是话,恭喜你咯,可以领取奖励了
#u#lc0000ff:1,#cffff00,领取奖励#L#U#C    #u#lc0000ff:-1,#cffff00,继续战斗#L#U#C
]]
		return sayret
	elseif true then
		human:弹出消息框("23:00-23:25分之间和我说话！其余时间我不想搭理任何人")
		return sayret
	end
	return sayret
end

function call_1079_1(human)--【盟重省】/活动/行会争霸-D5071B-@领取奖励
	local sayret = nil
	if human:是否会长() and true then
	elseif true then
		human:弹出消息框("你不是行会老大！")
		return sayret
	end
	if true then
		human:调整元宝(human:获取元宝()+999)
		全服广播("#cff00ff,".."行会老大【"..human:获取名字().."】获得行会争霸胜利,奖励元宝999个")
		human:传送(186,333*48,333*32)
	elseif true then
		human:弹出消息框("你还没有将其他行会的人全部请出这里..")
		return sayret
	end
	return sayret
end
function call_1080_0(human)--【盟重省】/二级密码设置-3-@main
	local sayret = nil
	if true then
		sayret = [[
为了保障玩家的帐号安全,在帐号被盗或者被骗,
只要你设置了2级密码,IP不一致上线必须输入2级密码!
如果IP不一致会拉近小黑屋，只有输入您的正确二代密保才可以正常游戏!
#c00ff00,警请各位玩家不要泄露自己的帐号密码保护!避免不必要的损失!#C
#c00ff00,一旦设置二代密保请牢记王者数据，不要与帐号和密码相同#C
#u#lc0000ff:1:2:4,#cffff00,设置2级密码#L#U#C--#c00ff00,2级密码必须为4-7位全数字!否则无效!#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1080_1(human)--【盟重省】/二级密码设置-3-@InPutInteger4
	local sayret = nil
	if 在文件列表("密码名单.txt",human:获取名字())>=0 and true then
		human:弹出消息框("你已经设置了2级密码!请先删除初始密码!")
		human.私人变量.M4=0
		return sayret
	end
	if true then
		sayret = call_1080_2(human) or sayret--~InPutInteger4
	end
	return sayret
end

function call_1080_2(human)--【盟重省】/二级密码设置-3-~InPutInteger4
	local sayret = nil
	if (human.私人变量.M4 or 0)>0 and true then
		human.私人变量.二级密码=0
		human.私人变量.二级密码=(human.私人变量.M4 or 0)
		存文件内容("密码数据.txt",human:获取名字(),"二级密码",human.私人变量.二级密码)
		写文件内容("密码名单.txt",human:获取名字())
		human:弹出消息框("密码设置成功!\\你设置的密码是:◆["..(human.私人变量.M4 or 0).."]◆\\请牢记，否则忘记密码是登陆游戏的!")
		human:随机传送(104)
	elseif true then
		human:弹出消息框("密码设置失败!\\确认你输入的数据为4-7位的数字!")
	end
	return sayret
end
function call_1081_0(human)--【盟重省】/密码验证-mima-@main
	local sayret = nil
	if true then
		sayret = [[
为了保障玩家的帐号安全,在帐号被盗或者被骗,
只要你设置了2级密码,IP不一致上线必须输入2级密码!
注意:有密码保护的人可以申请清除2级密码!
警请各位玩家不要泄露自己的帐号密码保护!避免不必要的损失!
#u#lc0000ff:1:2:5,#cffff00,输入密码#L#U#C--2级密码必须为4-7位全数字!否则无效!
#u#lc0000ff:2,#cffff00,返回比奇#L#U#C
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end

function call_1081_1(human)--【盟重省】/密码验证-mima-@InPutInteger5
	local sayret = nil
	if true then
		sayret = call_1081_3(human) or sayret--~InPutInteger5
	end
	return sayret
end

function call_1081_3(human)--【盟重省】/密码验证-mima-~InPutInteger5
	local sayret = nil
	if (human.私人变量.M5 or 0)==(human.私人变量.二级密码 or 0) and true then
		human:发送广播("#c00ff00,".."[提示:]当前IP已添加为安全IP!祝你游戏愉快!")
	elseif true then
		human:发送广播("#c00ff00,".."[提示:]密码错误!")
	end
	return sayret
end

function call_1081_2(human)--【盟重省】/密码验证-mima-@比奇
	local sayret = nil
	if true then
		human:传送(105,324*48,267*32)
	elseif true then
		human:发送广播("#c00ff00,".."[提示:]当前IP记录不存在!")
	end
	return sayret
end
function call_1082_0(human)--【洞穴NPC】/石墓阵_武器店-D71650-@main
	local sayret = nil
	if true then
		sayret = [[
对你这样的武士来说，武器就跟生命一样。
如果时刻不准备着，那么你也会成为地上的骷髅。
要是你有好几条命，那么可以不修理武器，
怎么样，把你的武器交给我来修理？ 
#u#lc0000ff:1,#cffff00,修理#L#U#C武器
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1082_1(human)--【洞穴NPC】/石墓阵_武器店-D71650-@repair
	local sayret = nil
	if true then
		sayret = [[
要修理武器吗？修理什么武器？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1083_0(human)--【洞穴NPC】/石墓阵_服饰店-D71651-@main
	local sayret = nil
	if true then
		sayret = [[
看你的衣服，很像打了很多猎的勇士。
以我的能力，能为你做的事情就是帮你
修复衣服和头盔，你需要修复衣服和头盔吗？ 
#u#lc0000ff:1,#cffff00,修复#L#U#C衣服 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1083_1(human)--【洞穴NPC】/石墓阵_服饰店-D71651-@repair
	local sayret = nil
	if true then
		sayret = [[
请放上去要修复的物品。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1084_0(human)--【洞穴NPC】/石墓阵_药品店-D71653-@main
	local sayret = nil
	if true then
		sayret = call_1084_1(human) or sayret--Market\Market0@Markets
		sayret = call_1084_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1084_1(human)--【洞穴NPC】/石墓阵_药品店-D71653-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1084_3(human)--【洞穴NPC】/石墓阵_药品店-D71653-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1084_4(human)--【洞穴NPC】/石墓阵_药品店-D71653-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1084_2(human)--【洞穴NPC】/石墓阵_药品店-D71653-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1085_0(human)--【洞穴NPC】/石墓阵_首饰店-D71652-@main
	local sayret = nil
	if true then
		sayret = [[
你也是为了寻找新的东西才来到这里的吗？
你也应该知道这里很危险。
我能够帮你的就是修理装饰品。 
#u#lc0000ff:1,#cffff00,修理#L#U#C装饰品 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1085_1(human)--【洞穴NPC】/石墓阵_首饰店-D71652-@repair
	local sayret = nil
	if true then
		sayret = [[
要修理装饰品吗？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1086_0(human)--【洞穴NPC】/合成师-R001-@main
	local sayret = nil
	if true then
		sayret = [[
已经很多年没有人来过这里了,
今天就破例让你见识见识我的手艺吧! 
#u#lc0000ff:1,#cffff00,合成#L#U#C物品
#u#lc0000ff:2,#cffff00,如何合成#L#U#C物品
#u#lc0000ff:3,#cffff00,进行对话#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1086_1(human)--【洞穴NPC】/合成师-R001-@laitcn
	local sayret = nil
	if human:检查物品数量(10225,1) and human:检查物品数量(10226,1) and human:检查物品数量(10227,1) and human:检查物品数量(10228,1) and human:检查物品数量(10296,1) and human:检查物品数量(10231,1) and true then
		human:收回物品(10225,1)
		human:收回物品(10226,1)
		human:收回物品(10227,1)
		human:收回物品(10228,1)
		human:收回物品(10296,1)
		human:收回物品(10231,1)
		human:获得物品(10233,1)
		sayret = [[
已经为你合成好了,试试我的手艺如何? 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
合成物品, 必须持有我说的那些材料. 
把材料准备好了，才能制作合成, 
缺少材料怎么合成呢?  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1086_2(human)--【洞穴NPC】/合成师-R001-@price
	local sayret = nil
	if true then
		sayret = [[
攻击力药水一瓶 
魔法力药水一瓶 
道术力药水一瓶 
疾风药水一瓶 
罗刹一把 
金砖一个 
以上材料准备好了我随时为你合成 ,缺少材料不能合成物品。
#u#lc0000ff:0,#cffff00,返 回#L#U#C
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1086_3(human)--【洞穴NPC】/合成师-R001-@lait
	local sayret = nil
	if true then
		sayret = [[
#cff00ff,]]..human:获取名字()..[[#C: 这里有着一道通往另一个神秘世界的大门, 
但是如何穿过这道大门,我现在仍然没有参破, 
希望你能够代替我完成这个心愿。  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
当然也需要材料
#u#lc0000ff:0,#cffff00,返 回#L#U#C
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1086_3(human)--【洞穴NPC】/合成师-R001-@lait
	local sayret = nil
	if true then
		sayret = [[
#cff00ff,]]..human:获取名字()..[[#C: 你知道干将吗?听我慢慢给你将吧.
从前,有个天下第一铸剑师,他有个女儿叫莫邪!
两个徒弟叫“干将”,其他有个我也不是很清楚,他们都是铸剑高手.
再他师傅死后,做了一把问天剑.谁能斩乱它变把女儿许配给他.
......几年后,干将投身火炉用天魔妖矿做了把(干将剑)化成了魔.
他杀光了无泪之城的人,用他的怨气和城容为一体.
听说他的师妹“莫邪”用剩下的妖矿做了把莫邪剑,杀死了“干将”.
从此这把（干将剑）就消息了....
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end
function call_1087_0(human)--【洞穴NPC】/沃玛森林_特殊修理-1-@main
	local sayret = nil
	if true then
		sayret = [[
关于武器的问题我愿意为您效劳。
当然除了武器以外的物品我也可以为您试着修理。 
#u#lc0000ff:1,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关    闭#L#U#C
]]
	end
	return sayret
end

function call_1087_1(human)--【洞穴NPC】/沃玛森林_特殊修理-1-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1088_0(human)--【洞穴NPC】/沃玛森林_药店-1-@main
	local sayret = nil
	if true then
		sayret = call_1088_1(human) or sayret--Market\Market0@Markets
		sayret = call_1088_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1088_1(human)--【洞穴NPC】/沃玛森林_药店-1-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1088_3(human)--【洞穴NPC】/沃玛森林_药店-1-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1088_4(human)--【洞穴NPC】/沃玛森林_药店-1-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1088_2(human)--【洞穴NPC】/沃玛森林_药店-1-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1089_0(human)--【洞穴NPC】/孤独老人-E603-@main
	local sayret = nil
	if true then
		sayret = [[
我可以让你进去,但只能在里面待3个小时 
自己小心..   
#u#lc0000ff:1,#cffff00,进入山洞#L#U#C
]]
	end
	return sayret
end

function call_1089_1(human)--【洞穴NPC】/孤独老人-E603-@ad
	local sayret = nil
	if true then
		human:随机传送(300)
		return sayret
	elseif true then
		sayret = [[
TimeRecall 180
]]
	end
	return sayret
end
function call_1090_0(human)--【沙巴克】/沙巴克_肉店-3-@main
	local sayret = nil
	if true then
		sayret = [[
最近我这里可以卖肉.
我会出高价钱购买!
#u#lc0000ff:1,#cffff00,卖#L#U#C
#u#lc0000ff:2,#cffff00,询问#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1090_1(human)--【沙巴克】/沙巴克_肉店-3-@sell
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,肉#C在鸡，鹿身上暴!
其他的就是相关怪物身上暴!
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end

function call_1090_2(human)--【沙巴克】/沙巴克_肉店-3-@meathelp
	local sayret = nil
	if true then
		sayret = [[
肉可以从鸡、鹿、羊身上割的，先打这些怪物，小心碰到
被比自己厉害的怪物打死，打死怪物之后，按alt键，把鼠标
放在怪物尸体上，您就会看到自己割肉的样子。过一会儿，
您的包里就会放着一个大肉块。对了，差一点忘了告诉你，
企图逃跑的怪物品质更好。用魔法打的怪物，其品质会变成0，
这一点千万记住。 
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end
function call_1091_0(human)--【沙巴克】/沙巴克_杂货铺-3-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，您想要些什么？ 
根据这个城堡的主人#cff00ff,]]..""..[[#C的命令，
我们特别对#cff00ff,]]..""..[[#C的成员提供20%的折扣。 
#u#lc0000ff:1,#cffff00,购买#L#U#C物品
#u#lc0000ff:2,#cffff00,出售#L#U#C物品 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1091_1(human)--【沙巴克】/沙巴克_杂货铺-3-@buy
	local sayret = nil
	if true then
		sayret = [[
你需要哪种物品呢？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1091_2(human)--【沙巴克】/沙巴克_杂货铺-3-@sell
	local sayret = nil
	if true then
		sayret = [[
我们出售蜡烛，护身符，卷轴，修理液等。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1092_0(human)--【沙巴克】/沙巴克_特殊修理-0151-@main
	local sayret = nil
	if true then
		sayret = [[
关于武器的问题我愿意为您效劳。
当然除了武器以外的物品我也可以为您试着修理。 
#u#lc0000ff:1,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关    闭#L#U#C
]]
	end
	return sayret
end
function call_1093_0(human)--【沙巴克】/沙巴克_武器店-0151-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，您想要些什么？ 
根据这个城堡的主人#cff00ff,]]..""..[[#C的命令，
我们特别对#cff00ff,]]..""..[[#C的成员提供20%的折扣。 
#u#lc0000ff:1,#cffff00,买#L#U#C武器
#u#lc0000ff:2,#cffff00,卖#L#U#C武器
#u#lc0000ff:3,#cffff00,修理#L#U#C武器
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1093_1(human)--【沙巴克】/沙巴克_武器店-0151-@buy
	local sayret = nil
	if true then
		sayret = [[
您想买些什么？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1093_2(human)--【沙巴克】/沙巴克_武器店-0151-@sell
	local sayret = nil
	if true then
		sayret = [[
给我您要卖的物品。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1093_3(human)--【沙巴克】/沙巴克_武器店-0151-@repair
	local sayret = nil
	if true then
		sayret = [[
你要修理吗？给我您要修理的武器。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1094_0(human)--【沙巴克】/沙巴克_武器升级-0151-@main
	local sayret = nil
	if true then
		sayret = [[
没有一个人来光顾，顾客，请进。
我的自尊使我不允许对这个物品的价格再要求打折。 
#u#lc0000ff:1,#cffff00,开始武器升级#L#U#C
#u#lc0000ff:2,#cffff00,返回武器升级#L#U#C
#u#lc0000ff:3,#cffff00,听更多的歌#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1094_1(human)--【沙巴克】/沙巴克_武器升级-0151-@upgrade
	local sayret = nil
	if true then
		sayret = [[
你像是想要升级你的武器。给我看你的武器，
升级价格是#cff00ff,]]..""..[[#C金币。修炼这个武器需要原料
#u#lc0000ff:4,#cffff00,黑铁矿#L#U#C，#u#lc0000ff:5,#cffff00,饰品#L#U#C，#u#lc0000ff:6,#cffff00,武器#L#U#C和#u#lc0000ff:7,#cffff00,金币#L#U#C。
别的原料你可以使用你包内的物品。
你想委托你的武器进入修炼系统吗？ 
#u#lc0000ff:8,#cffff00,确认修炼#L#U#C 
#u#lc0000ff:0,#cffff00,取消#L#U#C
]]
	end
	return sayret
end

function call_1094_4(human)--【沙巴克】/沙巴克_武器升级-0151-@Biron
	local sayret = nil
	if true then
		sayret = [[
你可以在矿山里采到黑铁矿石。如果你想修炼过程得到
一个好得结果你最好拿给我更高纯度的黑铁矿。
顺便请记得，在修炼期间如果没有足够数量的黑色铁矿，
那怕你的矿石纯度再高修练的结果也可能不好。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1094_5(human)--【沙巴克】/沙巴克_武器升级-0151-@Etc
	local sayret = nil
	if true then
		sayret = [[
装饰品，项链，手镯当你的特殊技能融入了这种装饰物的时候，
能够加强你的武器。如果你给我好原料我能给你好结果。
如果你给我糟糕的装饰品那可能会失败，除非你有很好的运气。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1094_6(human)--【沙巴克】/沙巴克_武器升级-0151-@Weapon
	local sayret = nil
	if true then
		sayret = [[
只能对武器进行炼制。
如果你想要升级武器请给我你携带的武器... 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1094_7(human)--【沙巴克】/沙巴克_武器升级-0151-@Gold
	local sayret = nil
	if true then
		sayret = [[
修练武器的金子太少...
你真的认为我的技术的价值就这么点数量的程度？
这个价格我不能做这个工作。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1094_8(human)--【沙巴克】/沙巴克_武器升级-0151-@confirmupgrade
	local sayret = nil
	if true then
		sayret = [[
给我看你给我的原料，修炼你的#cff00ff,]]..""..[[#C，我的视力不好，
我想从你的包里取得更多的饰品和黑铁矿石。
如果你有重要的物品，在你寄存在仓库后请回来。 
#u#lc0000ff:9,#cffff00,请求修炼#L#U#C 
#u#lc0000ff:-1,#cffff00,在安排好以后再回来#L#U#C
]]
	end
	return sayret
end

function call_1094_3(human)--【沙巴克】/沙巴克_武器升级-0151-@heardsing
	local sayret = nil
	if true then
		sayret = [[
如果你给我3万金子我会再考虑一下... 
#u#lc0000ff:10,#cffff00,支付3万金币#L#U#C 
#u#lc0000ff:0,#cffff00,退出#L#U#C
]]
	end
	return sayret
end

function call_1094_10(human)--【沙巴克】/沙巴克_武器升级-0151-@paythree
	local sayret = nil
	if true then
		sayret = [[
不知名的杂草... 
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end

function call_1094_11(human)--【沙巴克】/沙巴克_武器升级-0151-@Success
	local sayret = nil
	if true then
		sayret = [[
通过使用它，你可以体会到它精炼的好处。
无论你的战斗对象是其他玩家还是怪物...
你都会发现这个成果... 
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end
function call_1095_0(human)--【沙巴克】/沙巴克_炼药店-0153-@main
	local sayret = nil
	if true then
		sayret = [[
这地方是做药品买卖的，你需要点什么？
当然，如果你要的是可卡因或其他之类
精神药品的话，我们可不卖。
对于#cff00ff,]]..""..[[#C的成员我们有20%的折扣
因为这座城堡是属于 #cff00ff,]]..""..[[#C的。 
#u#lc0000ff:1,#cffff00,购买#L#U#C 药品
#u#lc0000ff:2,#cffff00,打听#L#U#C 药品的解释
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1095_1(human)--【沙巴克】/沙巴克_炼药店-0153-@buy
	local sayret = nil
	if true then
		sayret = [[
请选择你要制作的药品。
你肯定没忘了带做药的原料,对吗？ 
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1095_2(human)--【沙巴克】/沙巴克_炼药店-0153-@helpmakedrug
	local sayret = nil
	if true then
		sayret = [[
这里我们可以卖2种药品。. 
#u#lc0000ff:3,#cffff00,灰色药粉#L#U#C的效果
#u#lc0000ff:4,#cffff00,黄色药粉#L#U#C的效果
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1095_3(human)--【沙巴克】/沙巴克_炼药店-0153-@helpdrug1
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用灰色药粉。
如果中了毒，对手的体力值将会下降。 
#u#lc0000ff:2,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1095_4(human)--【沙巴克】/沙巴克_炼药店-0153-@helpdrug2
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用黄色药粉。
如果中了毒，对手的防御力将会下降。 
#u#lc0000ff:2,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end
function call_1096_0(human)--【沙巴克】/沙巴克_药店-0153-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，您想要些什么？ 
根据这个城堡的主人#cff00ff,]]..""..[[#C的命令，
我们特别对#cff00ff,]]..""..[[#C的成员提供20%的折扣。 
#u#lc0000ff:1,#cffff00,买#L#U#C药品
#u#lc0000ff:2,#cffff00,卖#L#U#C药品 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1096_1(human)--【沙巴克】/沙巴克_药店-0153-@buy
	local sayret = nil
	if true then
		sayret = [[
你想买点什么药品？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1096_2(human)--【沙巴克】/沙巴克_药店-0153-@sell
	local sayret = nil
	if true then
		sayret = [[
给我看看你的东西。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1097_0(human)--【沙巴克】/沙巴克_手镯店-0154-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，您想要些什么？ 
根据这个城堡的主人#cff00ff,]]..""..[[#C的命令，
我们特别对#cff00ff,]]..""..[[#C的成员提供20%的折扣。 
#u#lc0000ff:1,#cffff00,购买#L#U#C手镯
#u#lc0000ff:2,#cffff00,出售#L#U#C手镯
#u#lc0000ff:3,#cffff00,修理#L#U#C手镯
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1097_1(human)--【沙巴克】/沙巴克_手镯店-0154-@buy
	local sayret = nil
	if true then
		sayret = [[
请选择你要购买的手镯或手套... 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1097_2(human)--【沙巴克】/沙巴克_手镯店-0154-@sell
	local sayret = nil
	if true then
		sayret = [[
您出售哪种手镯？
我们也处理手套。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1097_3(human)--【沙巴克】/沙巴克_手镯店-0154-@repair
	local sayret = nil
	if true then
		sayret = [[
你可以修理各种手镯，手套。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1098_0(human)--【沙巴克】/沙巴克_项链店-0154-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，您想要些什么？ 
根据这个城堡的主人#cff00ff,]]..""..[[#C的命令，
我们特别对#cff00ff,]]..""..[[#C的成员提供20%的折扣。 
#u#lc0000ff:1,#cffff00,购买#L#U#C项链
#u#lc0000ff:2,#cffff00,出售#L#U#C项链
#u#lc0000ff:3,#cffff00,修理#L#U#C项链
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1098_1(human)--【沙巴克】/沙巴克_项链店-0154-@buy
	local sayret = nil
	if true then
		sayret = [[
你要购买项链？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1098_2(human)--【沙巴克】/沙巴克_项链店-0154-@sell
	local sayret = nil
	if true then
		sayret = [[
您出售哪种项链？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1098_3(human)--【沙巴克】/沙巴克_项链店-0154-@repair
	local sayret = nil
	if true then
		sayret = [[
你要修理项链？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1099_0(human)--【沙巴克】/沙巴克_戒指店-0154-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，您想要些什么？ 
根据这个城堡的主人#cff00ff,]]..""..[[#C的命令，
我们特别对#cff00ff,]]..""..[[#C的成员提供20%的折扣。 
#u#lc0000ff:1,#cffff00,购买#L#U#C戒指 
#u#lc0000ff:2,#cffff00,出售#L#U#C戒指
#u#lc0000ff:3,#cffff00,修理#L#U#C戒指
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1099_1(human)--【沙巴克】/沙巴克_戒指店-0154-@buy
	local sayret = nil
	if true then
		sayret = [[
你要购买哪个戒指？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1099_2(human)--【沙巴克】/沙巴克_戒指店-0154-@sell
	local sayret = nil
	if true then
		sayret = [[
您出售哪种戒指？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1099_3(human)--【沙巴克】/沙巴克_戒指店-0154-@repair
	local sayret = nil
	if true then
		sayret = [[
您要修理戒指？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1100_0(human)--【沙巴克】/沙巴克_服饰店-0155-@main
	local sayret = nil
	if true then
		sayret = call_1100_1(human) or sayret--Market\Market1@Markets
		sayret = call_1100_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1100_2(human)--【沙巴克】/沙巴克_服饰店-0155-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1100_1(human)--【沙巴克】/沙巴克_服饰店-0155-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1100_3(human)--【沙巴克】/沙巴克_服饰店-0155-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1100_4(human)--【沙巴克】/沙巴克_服饰店-0155-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1100_5(human)--【沙巴克】/沙巴克_服饰店-0155-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1100_6(human)--【沙巴克】/沙巴克_服饰店-0155-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1101_0(human)--【沙巴克】/沙巴克_头盔店-0155-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，您想要些什么？ 
根据这个城堡的主人#cff00ff,]]..""..[[#C的命令，
我们特别对#cff00ff,]]..""..[[#C的成员提供20%的折扣。 
#u#lc0000ff:1,#cffff00,买#L#U#C头盔
#u#lc0000ff:2,#cffff00,卖#L#U#C头盔
#u#lc0000ff:3,#cffff00,修补#L#U#C头盔
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1101_1(human)--【沙巴克】/沙巴克_头盔店-0155-@buy
	local sayret = nil
	if true then
		sayret = [[
你想买什么样的头盔？ 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1101_2(human)--【沙巴克】/沙巴克_头盔店-0155-@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的头盔给我看看，我会给你个估价。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1101_3(human)--【沙巴克】/沙巴克_头盔店-0155-@repair
	local sayret = nil
	if true then
		sayret = [[
请放上去要修补的头盔。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1102_0(human)--【白日门】/白日门_特殊修理-11-@main
	local sayret = nil
	if true then
		sayret = [[
关于武器的问题我愿意为您效劳。
当然除了武器以外的物品我也可以为您试着修理。 
#u#lc0000ff:1,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关    闭#L#U#C
]]
	end
	return sayret
end

function call_1102_1(human)--【白日门】/白日门_特殊修理-11-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1103_0(human)--【白日门】/白日门_武器店-1001-@main
	local sayret = nil
	if true then
		sayret = call_1103_1(human) or sayret--Market\Market1@Markets
		sayret = call_1103_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1103_2(human)--【白日门】/白日门_武器店-1001-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1103_1(human)--【白日门】/白日门_武器店-1001-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1103_3(human)--【白日门】/白日门_武器店-1001-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1103_4(human)--【白日门】/白日门_武器店-1001-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1103_5(human)--【白日门】/白日门_武器店-1001-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1103_6(human)--【白日门】/白日门_武器店-1001-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1104_0(human)--【白日门】/白日门_书店-1004-@main
	local sayret = nil
	if true then
		sayret = call_1104_1(human) or sayret--Market\Market2@Markets
		sayret = call_1104_2(human) or sayret--Market\书店@7
	end
	return sayret
end

function call_1104_1(human)--【白日门】/白日门_书店-1004-Market\Market2@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，你想买些修炼的书吗？ 
#u#lc0000ff:3,#cffff00,购买书籍#L#U#C
#u#lc0000ff:4,#cffff00,出售书籍#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1104_3(human)--【白日门】/白日门_书店-1004-Market\Market2@buy
	local sayret = nil
	if true then
		sayret = [[
以下是本店所有书籍的清单，请挑选你想要书籍。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1104_4(human)--【白日门】/白日门_书店-1004-Market\Market2@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的书籍给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1104_2(human)--【白日门】/白日门_书店-1004-Market\书店@7
	local sayret = nil
	return sayret
end
function call_1105_0(human)--【白日门】/白日门_首饰店-1005-@main
	local sayret = nil
	if true then
		sayret = call_1105_1(human) or sayret--Market\Market1@Markets
		sayret = call_1105_2(human) or sayret--Market\首饰@8
	end
	return sayret
end

function call_1105_2(human)--【白日门】/白日门_首饰店-1005-Market\首饰@8
	local sayret = nil
	return sayret
end

function call_1105_1(human)--【白日门】/白日门_首饰店-1005-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买首饰#L#U#C
#u#lc0000ff:4,#cffff00,出售首饰#L#U#C
#u#lc0000ff:5,#cffff00,修理首饰#L#U#C
#u#lc0000ff:6,#cffff00,特修首饰#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1105_3(human)--【白日门】/白日门_首饰店-1005-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要首饰。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1105_4(human)--【白日门】/白日门_首饰店-1005-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的首饰给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1105_5(human)--【白日门】/白日门_首饰店-1005-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的首饰给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1105_6(human)--【白日门】/白日门_首饰店-1005-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1106_0(human)--【白日门】/白日门_药店-1006-@main
	local sayret = nil
	if true then
		sayret = call_1106_1(human) or sayret--Market\Market0@Markets
		sayret = call_1106_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1106_1(human)--【白日门】/白日门_药店-1006-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1106_3(human)--【白日门】/白日门_药店-1006-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1106_4(human)--【白日门】/白日门_药店-1006-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1106_2(human)--【白日门】/白日门_药店-1006-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1107_0(human)--【白日门】/白日门_炼药店-1006-@main
	local sayret = nil
	if true then
		sayret = call_1107_1(human) or sayret--Market\Market4@Markets
		sayret = call_1107_2(human) or sayret--Market\毒药@9
	end
	return sayret
end

function call_1107_2(human)--【白日门】/白日门_炼药店-1006-Market\毒药@9
	local sayret = nil
	return sayret
end

function call_1107_1(human)--【白日门】/白日门_炼药店-1006-Market\Market4@Markets
	local sayret = nil
	if true then
		sayret = [[
这地方是做药品买卖的，你需要点什么？当然，如果你要的是可卡因或其他之类精神药品的话，我们可不卖。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,打听#L#U#C药品的解释
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1107_4(human)--【白日门】/白日门_炼药店-1006-Market\Market4@helps
	local sayret = nil
	if true then
		sayret = [[
这里我们可以卖2种药品。. 
#u#lc0000ff:5,#cffff00,灰色药粉#L#U#C的效果
#u#lc0000ff:6,#cffff00,黄色药粉#L#U#C的效果
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1107_5(human)--【白日门】/白日门_炼药店-1006-Market\Market4@helpdrug1
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用灰色药粉。
如果中了毒，对手的体力值将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1107_6(human)--【白日门】/白日门_炼药店-1006-Market\Market4@helpdrug2
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用黄色药粉。
如果中了毒，对手的防御力将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1107_3(human)--【白日门】/白日门_炼药店-1006-Market\Market4@buy
	local sayret = nil
	if true then
		sayret = [[
请选择你要购买的药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1108_0(human)--【白日门】/白日门_杂货铺-1007-@main
	local sayret = nil
	if true then
		sayret = call_1108_1(human) or sayret--Market\Market3@Markets
		sayret = call_1108_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1108_1(human)--【白日门】/白日门_杂货铺-1007-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1108_3(human)--【白日门】/白日门_杂货铺-1007-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1108_4(human)--【白日门】/白日门_杂货铺-1007-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1108_5(human)--【白日门】/白日门_杂货铺-1007-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1108_2(human)--【白日门】/白日门_杂货铺-1007-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1109_0(human)--【白日门】/白日门_天尊-1002-@main
	local sayret = nil
	if true then
		sayret = [[
见到像你这样年少气盛的勇士，想起了很久以前我年轻时候的事情。
现在的天尊装备正是我当时使用过的终级武器。 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end
function call_1110_0(human)--【白日门】/白日门_服饰店-1003-@main
	local sayret = nil
	if true then
		sayret = call_1110_1(human) or sayret--Market\Market1@Markets
		sayret = call_1110_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1110_2(human)--【白日门】/白日门_服饰店-1003-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1110_1(human)--【白日门】/白日门_服饰店-1003-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1110_3(human)--【白日门】/白日门_服饰店-1003-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1110_4(human)--【白日门】/白日门_服饰店-1003-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1110_5(human)--【白日门】/白日门_服饰店-1003-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1110_6(human)--【白日门】/白日门_服饰店-1003-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1111_0(human)--【封魔谷】/封魔谷_沃玛教主-b341-@main
	local sayret = nil
	if true then
		sayret = [[
哈哈,有人来了.
封魔堡属于我的主人"虹魔教主",
你们是来给他当早餐的吧,嘿嘿......  
#u#lc0000ff:1,#cffff00,打听消息#L#U#C
#u#lc0000ff:-1,#cffff00,确定#L#U#C
]]
	end
	return sayret
end

function call_1111_1(human)--【封魔谷】/封魔谷_沃玛教主-b341-@info
	local sayret = nil
	if true then
		sayret = [[
前几天抓来一个疯疯癫癫的老头,
总说自己是什么掌管世人姻缘的神仙,
被我关到阁楼里去了.
你认识他吗? 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1112_0(human)--【封魔谷】/封魔谷_肉店-4-@main
	local sayret = nil
	if true then
		sayret = [[
最近我这里可以卖肉.
我会出高价钱购买!
#u#lc0000ff:1,#cffff00,卖#L#U#C
#u#lc0000ff:2,#cffff00,询问#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1112_1(human)--【封魔谷】/封魔谷_肉店-4-@sell
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,肉#C在鸡，鹿身上暴!
其他的就是相关怪物身上暴!
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end

function call_1112_2(human)--【封魔谷】/封魔谷_肉店-4-@meathelp
	local sayret = nil
	if true then
		sayret = [[
肉可以从鸡、鹿、羊身上割的，先打这些怪物，小心碰到
被比自己厉害的怪物打死，打死怪物之后，按alt键，把鼠标
放在怪物尸体上，您就会看到自己割肉的样子。过一会儿，
您的包里就会放着一个大肉块。对了，差一点忘了告诉你，
企图逃跑的怪物品质更好。用魔法打的怪物，其品质会变成0，
这一点千万记住。 
#u#lc0000ff:0,#cffff00,继续#L#U#C
]]
	end
	return sayret
end
function call_1113_0(human)--【封魔谷】/封魔谷_特殊修理-4-@main
	local sayret = nil
	if true then
		sayret = [[
关于武器的问题我愿意为您效劳。
当然除了武器以外的物品我也可以为您试着修理。 
#u#lc0000ff:1,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关    闭#L#U#C
]]
	end
	return sayret
end

function call_1113_1(human)--【封魔谷】/封魔谷_特殊修理-4-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1114_0(human)--【封魔谷】/封魔谷_武器店-b342-@main
	local sayret = nil
	if true then
		sayret = call_1114_1(human) or sayret--Market\Market1@Markets
		sayret = call_1114_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1114_2(human)--【封魔谷】/封魔谷_武器店-b342-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1114_1(human)--【封魔谷】/封魔谷_武器店-b342-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1114_3(human)--【封魔谷】/封魔谷_武器店-b342-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1114_4(human)--【封魔谷】/封魔谷_武器店-b342-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1114_5(human)--【封魔谷】/封魔谷_武器店-b342-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1114_6(human)--【封魔谷】/封魔谷_武器店-b342-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1115_0(human)--【封魔谷】/封魔谷_炼药店-b343-@main
	local sayret = nil
	if true then
		sayret = call_1115_1(human) or sayret--Market\Market4@Markets
		sayret = call_1115_2(human) or sayret--Market\毒药@9
	end
	return sayret
end

function call_1115_2(human)--【封魔谷】/封魔谷_炼药店-b343-Market\毒药@9
	local sayret = nil
	return sayret
end

function call_1115_1(human)--【封魔谷】/封魔谷_炼药店-b343-Market\Market4@Markets
	local sayret = nil
	if true then
		sayret = [[
这地方是做药品买卖的，你需要点什么？当然，如果你要的是可卡因或其他之类精神药品的话，我们可不卖。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,打听#L#U#C药品的解释
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1115_4(human)--【封魔谷】/封魔谷_炼药店-b343-Market\Market4@helps
	local sayret = nil
	if true then
		sayret = [[
这里我们可以卖2种药品。. 
#u#lc0000ff:5,#cffff00,灰色药粉#L#U#C的效果
#u#lc0000ff:6,#cffff00,黄色药粉#L#U#C的效果
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1115_5(human)--【封魔谷】/封魔谷_炼药店-b343-Market\Market4@helpdrug1
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用灰色药粉。
如果中了毒，对手的体力值将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1115_6(human)--【封魔谷】/封魔谷_炼药店-b343-Market\Market4@helpdrug2
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用黄色药粉。
如果中了毒，对手的防御力将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1115_3(human)--【封魔谷】/封魔谷_炼药店-b343-Market\Market4@buy
	local sayret = nil
	if true then
		sayret = [[
请选择你要购买的药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1116_0(human)--【封魔谷】/封魔谷_药店-b343-@main
	local sayret = nil
	if true then
		sayret = call_1116_1(human) or sayret--Market\Market0@Markets
		sayret = call_1116_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1116_1(human)--【封魔谷】/封魔谷_药店-b343-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1116_3(human)--【封魔谷】/封魔谷_药店-b343-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1116_4(human)--【封魔谷】/封魔谷_药店-b343-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1116_2(human)--【封魔谷】/封魔谷_药店-b343-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1117_0(human)--【封魔谷】/封魔谷_书店-b343-@main
	local sayret = nil
	if true then
		sayret = call_1117_1(human) or sayret--Market\Market2@Markets
		sayret = call_1117_2(human) or sayret--Market\书店@7
	end
	return sayret
end

function call_1117_1(human)--【封魔谷】/封魔谷_书店-b343-Market\Market2@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，你想买些修炼的书吗？ 
#u#lc0000ff:3,#cffff00,购买书籍#L#U#C
#u#lc0000ff:4,#cffff00,出售书籍#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1117_3(human)--【封魔谷】/封魔谷_书店-b343-Market\Market2@buy
	local sayret = nil
	if true then
		sayret = [[
以下是本店所有书籍的清单，请挑选你想要书籍。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1117_4(human)--【封魔谷】/封魔谷_书店-b343-Market\Market2@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的书籍给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1117_2(human)--【封魔谷】/封魔谷_书店-b343-Market\书店@7
	local sayret = nil
	return sayret
end
function call_1118_0(human)--【封魔谷】/封魔谷_首饰店-b344-@main
	local sayret = nil
	if true then
		sayret = call_1118_1(human) or sayret--Market\Market1@Markets
		sayret = call_1118_2(human) or sayret--Market\首饰@8
	end
	return sayret
end

function call_1118_2(human)--【封魔谷】/封魔谷_首饰店-b344-Market\首饰@8
	local sayret = nil
	return sayret
end

function call_1118_1(human)--【封魔谷】/封魔谷_首饰店-b344-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买首饰#L#U#C
#u#lc0000ff:4,#cffff00,出售首饰#L#U#C
#u#lc0000ff:5,#cffff00,修理首饰#L#U#C
#u#lc0000ff:6,#cffff00,特修首饰#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1118_3(human)--【封魔谷】/封魔谷_首饰店-b344-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要首饰。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1118_4(human)--【封魔谷】/封魔谷_首饰店-b344-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的首饰给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1118_5(human)--【封魔谷】/封魔谷_首饰店-b344-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的首饰给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1118_6(human)--【封魔谷】/封魔谷_首饰店-b344-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1119_0(human)--【封魔谷】/封魔谷_服饰店-b345-@main
	local sayret = nil
	if true then
		sayret = call_1119_1(human) or sayret--Market\Market1@Markets
		sayret = call_1119_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1119_2(human)--【封魔谷】/封魔谷_服饰店-b345-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1119_1(human)--【封魔谷】/封魔谷_服饰店-b345-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1119_3(human)--【封魔谷】/封魔谷_服饰店-b345-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1119_4(human)--【封魔谷】/封魔谷_服饰店-b345-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1119_5(human)--【封魔谷】/封魔谷_服饰店-b345-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1119_6(human)--【封魔谷】/封魔谷_服饰店-b345-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1120_0(human)--【封魔谷】/封魔谷_杂货铺-4-@main
	local sayret = nil
	if true then
		sayret = call_1120_1(human) or sayret--Market\Market3@Markets
		sayret = call_1120_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1120_1(human)--【封魔谷】/封魔谷_杂货铺-4-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1120_3(human)--【封魔谷】/封魔谷_杂货铺-4-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1120_4(human)--【封魔谷】/封魔谷_杂货铺-4-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1120_5(human)--【封魔谷】/封魔谷_杂货铺-4-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1120_2(human)--【封魔谷】/封魔谷_杂货铺-4-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1121_0(human)--【封魔谷】/封魔谷_修理师-D2008-@main
	local sayret = nil
	if true then
		sayret = [[
怎么，看见我很奇怪么？我生前可是个大慈善家。
要什么东西，自己看吧！也可以把你的东西卖给我！ 
我会尽我的全力去帮助你的！
#u#lc0000ff:1,#cffff00,买#L#U#C 东西
#u#lc0000ff:2,#cffff00,卖#L#U#C 东西
#u#lc0000ff:3,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1121_1(human)--【封魔谷】/封魔谷_修理师-D2008-@buy
	local sayret = nil
	if true then
		sayret = [[
你需要什么物品？  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1121_2(human)--【封魔谷】/封魔谷_修理师-D2008-@sell
	local sayret = nil
	if true then
		sayret = [[
给我看看你的东西，我会给你一个估价……
所以如果你不是急需的话在这里卖掉算了。 
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1121_4(human)--【封魔谷】/封魔谷_修理师-D2008-@repair
	local sayret = nil
	if true then
		sayret = [[
这里你可以修补衣服、头盔和帽子、武器、首饰，甚至是护身
符之类的东西也可以.  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end
function call_1122_0(human)--【苍月岛】/苍月岛_杂货铺-5-@main
	local sayret = nil
	if true then
		sayret = call_1122_1(human) or sayret--Market\Market3@Markets
		sayret = call_1122_2(human) or sayret--Market\杂货@6
	end
	return sayret
end

function call_1122_1(human)--【苍月岛】/苍月岛_杂货铺-5-Market\Market3@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，有什么我可帮忙的吗？ 
#u#lc0000ff:3,#cffff00,购买物品#L#U#C
#u#lc0000ff:4,#cffff00,出售物品#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1122_3(human)--【苍月岛】/苍月岛_杂货铺-5-Market\Market3@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要物品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1122_4(human)--【苍月岛】/苍月岛_杂货铺-5-Market\Market3@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的物品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1122_5(human)--【苍月岛】/苍月岛_杂货铺-5-Market\Market3@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1122_2(human)--【苍月岛】/苍月岛_杂货铺-5-Market\杂货@6
	local sayret = nil
	return sayret
end
function call_1123_0(human)--【苍月岛】/苍月岛_特殊修理-5-@main
	local sayret = nil
	if true then
		sayret = [[
关于武器的问题我愿意为您效劳。
当然除了武器以外的物品我也可以为您试着修理。 
#u#lc0000ff:1,#cffff00,特殊修理#L#U#C 
#u#lc0000ff:-1,#cffff00,关    闭#L#U#C
]]
	end
	return sayret
end

function call_1123_1(human)--【苍月岛】/苍月岛_特殊修理-5-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1124_0(human)--【苍月岛】/苍月岛_武器店-5-@main
	local sayret = nil
	if true then
		sayret = call_1124_1(human) or sayret--Market\Market1@Markets
		sayret = call_1124_2(human) or sayret--Market\武器@3
	end
	return sayret
end

function call_1124_2(human)--【苍月岛】/苍月岛_武器店-5-Market\武器@3
	local sayret = nil
	return sayret
end

function call_1124_1(human)--【苍月岛】/苍月岛_武器店-5-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，感谢您到我们的铁匠铺。这里有大量的武器和矿石出售... 
#u#lc0000ff:3,#cffff00,购买武器#L#U#C
#u#lc0000ff:4,#cffff00,出售武器#L#U#C
#u#lc0000ff:5,#cffff00,修理武器#L#U#C
#u#lc0000ff:6,#cffff00,特修武器#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1124_3(human)--【苍月岛】/苍月岛_武器店-5-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要武器。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1124_4(human)--【苍月岛】/苍月岛_武器店-5-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的武器给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1124_5(human)--【苍月岛】/苍月岛_武器店-5-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的武器给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1124_6(human)--【苍月岛】/苍月岛_武器店-5-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1125_0(human)--【苍月岛】/苍月岛_首饰店-5-@main
	local sayret = nil
	if true then
		sayret = call_1125_1(human) or sayret--Market\Market1@Markets
		sayret = call_1125_2(human) or sayret--Market\首饰@8
	end
	return sayret
end

function call_1125_2(human)--【苍月岛】/苍月岛_首饰店-5-Market\首饰@8
	local sayret = nil
	return sayret
end

function call_1125_1(human)--【苍月岛】/苍月岛_首饰店-5-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，我可以帮你什么吗？ 
#u#lc0000ff:3,#cffff00,购买首饰#L#U#C
#u#lc0000ff:4,#cffff00,出售首饰#L#U#C
#u#lc0000ff:5,#cffff00,修理首饰#L#U#C
#u#lc0000ff:6,#cffff00,特修首饰#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1125_3(human)--【苍月岛】/苍月岛_首饰店-5-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要首饰。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1125_4(human)--【苍月岛】/苍月岛_首饰店-5-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的首饰给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1125_5(human)--【苍月岛】/苍月岛_首饰店-5-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的首饰给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1125_6(human)--【苍月岛】/苍月岛_首饰店-5-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1126_0(human)--【苍月岛】/苍月岛_服饰店-5-@main
	local sayret = nil
	if true then
		sayret = call_1126_1(human) or sayret--Market\Market1@Markets
		sayret = call_1126_2(human) or sayret--Market\衣服@0
	end
	return sayret
end

function call_1126_2(human)--【苍月岛】/苍月岛_服饰店-5-Market\衣服@0
	local sayret = nil
	return sayret
end

function call_1126_1(human)--【苍月岛】/苍月岛_服饰店-5-Market\Market1@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，你需要点什么？ 
#u#lc0000ff:3,#cffff00,购买衣服#L#U#C
#u#lc0000ff:4,#cffff00,出售衣服#L#U#C
#u#lc0000ff:5,#cffff00,修理衣服#L#U#C
#u#lc0000ff:6,#cffff00,特修衣服#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1126_3(human)--【苍月岛】/苍月岛_服饰店-5-Market\Market1@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要衣服。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1126_4(human)--【苍月岛】/苍月岛_服饰店-5-Market\Market1@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的衣服给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1126_5(human)--【苍月岛】/苍月岛_服饰店-5-Market\Market1@repair
	local sayret = nil
	if true then
		sayret = [[
把你要修理的衣服给我吧，我会帮你修好的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1126_6(human)--【苍月岛】/苍月岛_服饰店-5-Market\Market1@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1127_0(human)--【苍月岛】/苍月岛_药店-5-@main
	local sayret = nil
	if true then
		sayret = call_1127_1(human) or sayret--Market\Market0@Markets
		sayret = call_1127_2(human) or sayret--Market\药店@1
	end
	return sayret
end

function call_1127_1(human)--【苍月岛】/苍月岛_药店-5-Market\Market0@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎光临，在这里你可以买到一些常见的药品。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,出售药品#L#U#C 
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1127_3(human)--【苍月岛】/苍月岛_药店-5-Market\Market0@buy
	local sayret = nil
	if true then
		sayret = [[
请挑选你想要药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1127_4(human)--【苍月岛】/苍月岛_药店-5-Market\Market0@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的药品给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1127_2(human)--【苍月岛】/苍月岛_药店-5-Market\药店@1
	local sayret = nil
	return sayret
end
function call_1128_0(human)--【苍月岛】/苍月岛_书店-5-@main
	local sayret = nil
	if true then
		sayret = call_1128_1(human) or sayret--Market\Market2@Markets
		sayret = call_1128_2(human) or sayret--Market\书店@7
	end
	return sayret
end

function call_1128_1(human)--【苍月岛】/苍月岛_书店-5-Market\Market2@Markets
	local sayret = nil
	if true then
		sayret = [[
欢迎，你想买些修炼的书吗？ 
#u#lc0000ff:3,#cffff00,购买书籍#L#U#C
#u#lc0000ff:4,#cffff00,出售书籍#L#U#C
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1128_3(human)--【苍月岛】/苍月岛_书店-5-Market\Market2@buy
	local sayret = nil
	if true then
		sayret = [[
以下是本店所有书籍的清单，请挑选你想要书籍。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1128_4(human)--【苍月岛】/苍月岛_书店-5-Market\Market2@sell
	local sayret = nil
	if true then
		sayret = [[
把你要卖的书籍给我看看吧，我会给你好价钱的。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1128_2(human)--【苍月岛】/苍月岛_书店-5-Market\书店@7
	local sayret = nil
	return sayret
end
function call_1129_0(human)--【苍月岛】/苍月岛_药剂师-5-@main
	local sayret = nil
	if true then
		sayret = call_1129_1(human) or sayret--Market\Market4@Markets
		sayret = call_1129_2(human) or sayret--Market\毒药@9
	end
	return sayret
end

function call_1129_2(human)--【苍月岛】/苍月岛_药剂师-5-Market\毒药@9
	local sayret = nil
	return sayret
end

function call_1129_1(human)--【苍月岛】/苍月岛_药剂师-5-Market\Market4@Markets
	local sayret = nil
	if true then
		sayret = [[
这地方是做药品买卖的，你需要点什么？当然，如果你要的是可卡因或其他之类精神药品的话，我们可不卖。 
#u#lc0000ff:3,#cffff00,购买药品#L#U#C
#u#lc0000ff:4,#cffff00,打听#L#U#C药品的解释
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1129_4(human)--【苍月岛】/苍月岛_药剂师-5-Market\Market4@helps
	local sayret = nil
	if true then
		sayret = [[
这里我们可以卖2种药品。. 
#u#lc0000ff:5,#cffff00,灰色药粉#L#U#C的效果
#u#lc0000ff:6,#cffff00,黄色药粉#L#U#C的效果
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1129_5(human)--【苍月岛】/苍月岛_药剂师-5-Market\Market4@helpdrug1
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用灰色药粉。
如果中了毒，对手的体力值将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1129_6(human)--【苍月岛】/苍月岛_药剂师-5-Market\Market4@helpdrug2
	local sayret = nil
	if true then
		sayret = [[
道士在运用施毒术的时候可以使用黄色药粉。
如果中了毒，对手的防御力将会下降。 
#u#lc0000ff:4,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1129_3(human)--【苍月岛】/苍月岛_药剂师-5-Market\Market4@buy
	local sayret = nil
	if true then
		sayret = [[
请选择你要购买的药品。 
#u#lc0000ff:1,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1130_0(human)--【幻　境】/幻境小贩-H003-@main
	local sayret = nil
	if true then
		sayret = [[
你竟然能跑到这里来？
看在你这么卖命的份上，我就帮助你一下。
#u#lc0000ff:1,#cffff00,前往幻境四层#L#U#C
#u#lc0000ff:2,#cffff00,买#L#U#C
#u#lc0000ff:3,#cffff00,卖#L#U#C
#u#lc0000ff:4,#cffff00,修理#L#U#C
#u#lc0000ff:5,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end

function call_1130_2(human)--【幻　境】/幻境小贩-H003-@buy
	local sayret = nil
	if true then
		sayret = [[
您想买些什么?  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1130_3(human)--【幻　境】/幻境小贩-H003-@sell
	local sayret = nil
	if true then
		sayret = [[
给我您要卖的物品.  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1130_4(human)--【幻　境】/幻境小贩-H003-@repair
	local sayret = nil
	if true then
		sayret = [[
您要修理吗?
我可是个万能工匠哦！
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1130_5(human)--【幻　境】/幻境小贩-H003-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1130_1(human)--【幻　境】/幻境小贩-H003-@前往幻境四层
	local sayret = nil
	if true then
		human:随机传送(377)
	end
	return sayret
end
function call_1131_0(human)--【幻　境】/幻境小贩-H007-@main
	local sayret = nil
	if true then
		sayret = [[
你竟然能跑到这里来？
看在你这么卖命的份上，我就帮助你一下。
顺便告诉你一下，一旦进入幻境迷宫，就再也不能回头了！ 
#u#lc0000ff:1,#cffff00,买#L#U#C
#u#lc0000ff:2,#cffff00,卖#L#U#C
#u#lc0000ff:3,#cffff00,修理#L#U#C
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end

function call_1131_1(human)--【幻　境】/幻境小贩-H007-@buy
	local sayret = nil
	if true then
		sayret = [[
您想买些什么?  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1131_2(human)--【幻　境】/幻境小贩-H007-@sell
	local sayret = nil
	if true then
		sayret = [[
给我您要卖的物品.  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1131_3(human)--【幻　境】/幻境小贩-H007-@repair
	local sayret = nil
	if true then
		sayret = [[
您要修理吗?
我可是个万能工匠哦！
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1131_4(human)--【幻　境】/幻境小贩-H007-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你小子运气好，我正在有特殊修理所需的原材料，不过价格可是
普通的三倍哟，我就靠这个赚钱了。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1132_0(human)--【幻　境】/影之道_神秘老人-0150-@main
	local sayret = nil
	if true then
		sayret = [[
这里只有沙巴克成员才能前往!
当然如果你不是沙巴克成员......
#u#lc0000ff:1,#cffff00,从气势上压倒他#L#U#C
#u#lc0000ff:2,#cffff00,用眼神威吓他#L#U#C
#u#lc0000ff:3,#cffff00,用语言咒骂他#L#U#C
#u#lc0000ff:4,#cffff00,我是沙巴克成员#L#U#C
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1132_1(human)--【幻　境】/影之道_神秘老人-0150-@qishi
	local sayret = nil
	if true then
		sayret = [[
我感到你体内蕴含着无比的力量
并且想发泄在我身上,罢了罢了
我放你进去还不成吗?
#u#lc0000ff:5,#cffff00,算你识相#L#U#C
#u#lc0000ff:-1,#cffff00,我无语了#L#U#C
]]
	end
	return sayret
end

function call_1132_2(human)--【幻　境】/影之道_神秘老人-0150-@yanshen
	local sayret = nil
	if true then
		sayret = [[
你完全不行啊，就算你是沙巴克成员
我都不会放你进去的，回家再练练吧
#u#lc0000ff:-1,#cffff00,灰溜溜的离开#L#U#C
]]
	end
	return sayret
end

function call_1132_3(human)--【幻　境】/影之道_神秘老人-0150-@yuyan
	local sayret = nil
	if true then
		sayret = [[
好了好了，差不多了，我服了你了。
#u#lc0000ff:5,#cffff00,看你还敢不敢#L#U#C
]]
	end
	return sayret
end

function call_1132_4(human)--【幻　境】/影之道_神秘老人-0150-@shabake
	local sayret = nil
	if true then
		sayret = [[
你知道我是老糊涂了，现在身手不行了，
就算你不是沙巴克成员我也不敢赶你出去呀，
既然你已经到这里了，那就只好让你进去了!
#u#lc0000ff:5,#cffff00,这就进去#L#U#C
]]
	end
	return sayret
end

function call_1132_5(human)--【幻　境】/影之道_神秘老人-0150-@jinru
	local sayret = nil
	if true then
		sayret = [[
里面便是沙巴克的幻境秘道，
多年来只有沙巴克的成员可以独享里面的宝藏。
#u#lc0000ff:6,#cffff00,同意#L#U#C
#u#lc0000ff:-1,#cffff00,不同意#L#U#C
]]
	end
	return sayret
end

function call_1132_6(human)--【幻　境】/影之道_神秘老人-0150-@tongyi
	local sayret = nil
	if human:是否城堡成员(0) and true then
		human:获得物品(10137,1)
		human:传送(436,13*48,103*32)
	elseif true then
		sayret = [[
你不是沙巴克的成员！ 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end
function call_1133_0(human)--【幻　境】/影之道_幻境小贩-H203-@main
	local sayret = nil
	if true then
		sayret = [[
你竟然能跑到这里来？
看在你这么卖命的份上，我就帮助你一下。
顺便告诉你一下，一旦进入幻境迷宫，就再也不能回头了！ 
#u#lc0000ff:1,#cffff00,买#L#U#C
#u#lc0000ff:2,#cffff00,卖#L#U#C
#u#lc0000ff:3,#cffff00,修理#L#U#C
#u#lc0000ff:4,#cffff00,特殊修理#L#U#C
#u#lc0000ff:-1,#cffff00,退出#L#U#C
]]
	end
	return sayret
end

function call_1133_1(human)--【幻　境】/影之道_幻境小贩-H203-@buy
	local sayret = nil
	if true then
		sayret = [[
您想买些什么?  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1133_2(human)--【幻　境】/影之道_幻境小贩-H203-@sell
	local sayret = nil
	if true then
		sayret = [[
给我您要卖的物品.  
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1133_3(human)--【幻　境】/影之道_幻境小贩-H203-@repair
	local sayret = nil
	if true then
		sayret = [[
您要修理吗?
我可是个万能工匠哦！
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1133_4(human)--【幻　境】/影之道_幻境小贩-H203-@s_repair
	local sayret = nil
	if true then
		sayret = [[
你这个家伙太幸运了，我正好有材料可以做特种修理...
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1134_0(human)--【幻　境】/影之道_仓库保管员-H203-@main
	local sayret = nil
	if true then
		sayret = [[
身上的宝贝舍不的卖了，那先存我这吧！~
目前不收保管费，请多利用。 
#u#lc0000ff:1,#cffff00,保管#L#U#C东西
#u#lc0000ff:2,#cffff00,找回#L#U#C东西
#u#lc0000ff:3,#cffff00,捆#L#U#C各种卷书和药水
#u#lc0000ff:-1,#cffff00,关 闭#L#U#C
]]
	end
	return sayret
end

function call_1134_1(human)--【幻　境】/影之道_仓库保管员-H203-@storage
	local sayret = nil
	if true then
		sayret = [[
你要储存哪种物品呢?   #u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1134_2(human)--【幻　境】/影之道_仓库保管员-H203-@getback
	local sayret = nil
	if true then
		sayret = [[
请从列表中选出你要取回的物品. 
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1134_3(human)--【幻　境】/影之道_仓库保管员-H203-@Mbind
	local sayret = nil
	if true then
		sayret = [[
你知道我是什么人吗？ 
我做的是这样的事情... 
你要试一下吗？有什么要拜托的就说吧  

用金币#u#lc0000ff:4,#cffff00,交换#L#U#C金条 
用金条#u#lc0000ff:5,#cffff00,交换#L#U#C金币 
#u#lc0000ff:6,#cffff00,捆#L#U#C  

#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_4(human)--【幻　境】/影之道_仓库保管员-H203-@changeGold
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		sayret = [[
你说你要用金币换成金条? 
好的，我帮你换 
但是要支付手续费 
费用是2000金币，你还换吗？  
#u#lc0000ff:7,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你连这点钱都没有，还换什么？ 
等你有足够的钱，再来找我吧  
#u#lc0000ff:0,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1134_7(human)--【幻　境】/影之道_仓库保管员-H203-@changeGold_1
	local sayret = nil
	if human:获取金币()>=1002000 and true then
		human:收回物品(10002,1002000)
		human:获得物品(10317,1)
		sayret = [[
金币已经换好金条了. 
还换吗？  
#u#lc0000ff:4,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你的包里东西已经满了，或者你没有足够的钱支付手续费
你再确认一下吧  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_5(human)--【幻　境】/影之道_仓库保管员-H203-@changeMoney
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		sayret = [[
你要把金条换成金币? 
好的，我给你换 
不过需要支付手续费
费用是2000金币，你还换吗？  
#u#lc0000ff:8,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有金条还换什么? 
想骗我?快滚!  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_8(human)--【幻　境】/影之道_仓库保管员-H203-@changeMoney_1
	local sayret = nil
	if human:检查物品数量(10317,1) and human:获取金币()>=14000001 and true then
		sayret = [[
我也很想给你换， 
但是你钱太多了，我没办法给你换.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = call_1134_9(human) or sayret--@changeMoney_2
	end
	return sayret
end

function call_1134_9(human)--【幻　境】/影之道_仓库保管员-H203-@changeMoney_2
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
		human:获得物品(10002,998000)
		sayret = [[
金条已经换好金币了. 
还换吗？  
#u#lc0000ff:5,#cffff00,交换#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_6(human)--【幻　境】/影之道_仓库保管员-H203-@bind
	local sayret = nil
	if true then
		sayret = [[
目前我能捆的只有卷书和药水 
你要捆吗？ 
要捆东西需要100金币.  
#u#lc0000ff:10,#cffff00,捆#L#U#C药水 
#u#lc0000ff:11,#cffff00,捆#L#U#C卷书 
]]
	end
	return sayret
end

function call_1134_10(human)--【幻　境】/影之道_仓库保管员-H203-@P_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:12,#cffff00,捆#L#U#C强效金创药 
#u#lc0000ff:13,#cffff00,捆#L#U#C强效魔法药 
#u#lc0000ff:14,#cffff00,捆#L#U#C金创药(中量) 
#u#lc0000ff:15,#cffff00,捆#L#U#C魔法药(中量)
#u#lc0000ff:16,#cffff00,捆#L#U#C金创药
#u#lc0000ff:17,#cffff00,捆#L#U#C魔法药
#u#lc0000ff:6,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1134_11(human)--【幻　境】/影之道_仓库保管员-H203-@Z_bind
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,捆#L#U#C地牢逃脱卷 
#u#lc0000ff:19,#cffff00,捆#L#U#C随机传送卷 
#u#lc0000ff:20,#cffff00,捆#L#U#C回城卷 
#u#lc0000ff:21,#cffff00,捆#L#U#C行会回城卷 
#u#lc0000ff:6,#cffff00,返 回#L#U#C
]]
	end
	return sayret
end

function call_1134_12(human)--【幻　境】/影之道_仓库保管员-H203-@ch_bind1
	local sayret = nil
	if human:检查物品数量(10179,6) and true then
		sayret = call_1134_22(human) or sayret--@ch_bind1_1
	elseif true then
		sayret = [[
你都没有要捆的药水，还捆什么? 
等准备好药水之后再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_22(human)--【幻　境】/影之道_仓库保管员-H203-@ch_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10179,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10179,6)
		human:获得物品(10193,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
还有要捆的就拿给我吧..  
#u#lc0000ff:10,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_13(human)--【幻　境】/影之道_仓库保管员-H203-@ma_bind1
	local sayret = nil
	if human:检查物品数量(10180,6) and true then
		sayret = call_1134_23(human) or sayret--@ma_bind1_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_23(human)--【幻　境】/影之道_仓库保管员-H203-@ma_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10180,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10180,6)
		human:获得物品(10194,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:10,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_14(human)--【幻　境】/影之道_仓库保管员-H203-@ch_bind2
	local sayret = nil
	if human:检查物品数量(10099,6) and true then
		sayret = call_1134_24(human) or sayret--@ch_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_24(human)--【幻　境】/影之道_仓库保管员-H203-@ch_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10099,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10099,6)
		human:获得物品(10219,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:10,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_15(human)--【幻　境】/影之道_仓库保管员-H203-@ma_bind2
	local sayret = nil
	if human:检查物品数量(10100,6) and true then
		sayret = call_1134_25(human) or sayret--@ma_bind2_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_25(human)--【幻　境】/影之道_仓库保管员-H203-@ma_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10100,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10100,6)
		human:获得物品(10220,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:10,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_16(human)--【幻　境】/影之道_仓库保管员-H203-@ch_binD3
	local sayret = nil
	if human:检查物品数量("金创药",6) and true then
		sayret = call_1134_26(human) or sayret--@ch_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_26(human)--【幻　境】/影之道_仓库保管员-H203-@ch_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("金创药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("金创药",6)
		human:获得物品(10217,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:10,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_17(human)--【幻　境】/影之道_仓库保管员-H203-@ma_binD3
	local sayret = nil
	if human:检查物品数量("魔法药",6) and true then
		sayret = call_1134_27(human) or sayret--@ma_binD3_1
	elseif true then
		sayret = [[
你都没有药水捆，还捆什么? 
等准备好药水之后，再来找我吧.  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_27(human)--【幻　境】/影之道_仓库保管员-H203-@ma_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量("魔法药",6) and true then
		human:收回物品(10002,100)
		human:收回物品("魔法药",6)
		human:获得物品(10218,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:10,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_18(human)--【幻　境】/影之道_仓库保管员-H203-@zum_bind1
	local sayret = nil
	if human:检查物品数量(10083,6) and true then
		sayret = call_1134_28(human) or sayret--@zum_bind1_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_28(human)--【幻　境】/影之道_仓库保管员-H203-@zum_bind1_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10083,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10083,6)
		human:获得物品(10221,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:11,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_19(human)--【幻　境】/影之道_仓库保管员-H203-@zum_bind2
	local sayret = nil
	if human:检查物品数量(10164,6) and true then
		sayret = call_1134_29(human) or sayret--@zum_bind2_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_29(human)--【幻　境】/影之道_仓库保管员-H203-@zum_bind2_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10164,6) and true then
		human:收回物品("金币100",1)
		human:收回物品(10164,6)
		human:获得物品(10222,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:11,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_20(human)--【幻　境】/影之道_仓库保管员-H203-@zum_binD3
	local sayret = nil
	if human:检查物品数量(10137,6) and true then
		sayret = call_1134_30(human) or sayret--@zum_binD3_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_30(human)--【幻　境】/影之道_仓库保管员-H203-@zum_binD3_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10137,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10137,6)
		human:获得物品(10223,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:11,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_21(human)--【幻　境】/影之道_仓库保管员-H203-@zum_bind4
	local sayret = nil
	if human:检查物品数量(10177,6) and true then
		sayret = call_1134_31(human) or sayret--@zum_bind4_1
	elseif true then
		sayret = [[
你都没有可以捆的卷书，还捆什么? 
等准备好之后，再来找我吧..  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_1134_31(human)--【幻　境】/影之道_仓库保管员-H203-@zum_bind4_1
	local sayret = nil
	if human:获取金币()>=100 and human:检查物品数量(10177,6) and true then
		human:收回物品(10002,100)
		human:收回物品(10177,6)
		human:获得物品(10224,1)
		sayret = [[
已经捆好了... 我的技术不错吧.. 
以后还有要捆的，就来找我吧..  
#u#lc0000ff:11,#cffff00,继续捆#L#U#C 
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	elseif true then
		sayret = [[
你都没有钱捆东西，
还捆什么? 
快走吧....  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end
function call_1135_0(human)--【幻　境】/影之道_神秘老人-H204-@main
	local sayret = nil
	if true then
		sayret = [[
这里就是真正的沙巴克藏宝阁了！
沙巴克的宝藏到底有多少......这个就不用我废话了吧,
就连那“王者禁地”才有的“霸者之刃”
都已经在这里收藏了好多把了，你能想到的所有宝藏这里都有了，
每天看着“地藏魔王”拿着“霸者之刃”在我面前炫耀，
我就想动手抢一把来耍耍！还有那“重装使者”，唉......
最后告诉你，在这里下线会回到“盟重”
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end
function call_1136_0(human)--【幻　境】/影之道_沙巴克密使-H201-@main
	local sayret = nil
	if true then
		sayret = [[
哎，真没办法，国王把沙巴克秘史的任务交给了我！
现在我可以把你直接送到沙巴克皇宫中！
不过你必须满足我的要求，而我的要求嘛……
你给我10000金币吧，不算多吧？ 
#u#lc0000ff:1,#cffff00,好的我要进去#L#U#C 
#u#lc0000ff:-1,#cffff00,算了太贵了#L#U#C
]]
	end
	return sayret
end

function call_1136_1(human)--【幻　境】/影之道_沙巴克密使-H201-@111
	local sayret = nil
	if true then
		sayret = call_1136_2(human) or sayret--@jinru
	end
	return sayret
end

function call_1136_2(human)--【幻　境】/影之道_沙巴克密使-H201-@jinru
	local sayret = nil
	if human:获取金币()>=10000 and human:获取等级()>41 and true then
		human:收回物品(10002,10000)
		human:随机传送(198)
	elseif true then
		sayret = [[
你连这么点钱都没有？我可只为有钱人服务！禁止42级以下皇宫
 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end
function call_1137_0(human)--【幻　境】/幻境_沙巴克密使-H007-@main
	local sayret = nil
	if true then
		sayret = [[
哎，真没办法，国王把沙巴克秘史的任务交给了我！
现在我可以把你直接送到沙巴克皇宫中！
不过你必须满足我的要求，而我的要求嘛……
你给我10000金币吧，不算多吧？ 
#u#lc0000ff:1,#cffff00,好的我要进去#L#U#C 
#u#lc0000ff:-1,#cffff00,算了太贵了#L#U#C
]]
	end
	return sayret
end

function call_1137_1(human)--【幻　境】/幻境_沙巴克密使-H007-@111
	local sayret = nil
	if true then
		sayret = call_1137_2(human) or sayret--@jinru
	end
	return sayret
end

function call_1137_2(human)--【幻　境】/幻境_沙巴克密使-H007-@jinru
	local sayret = nil
	if human:获取金币()>=10000 and human:获取等级()>41 and true then
		human:收回物品(10002,10000)
		human:随机传送(198)
	elseif true then
		sayret = [[
你连这么点钱都没有？我可只为有钱人服务！禁止42级以下皇宫
 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end
function call_1138_0(human)--【传送员】/盟重传送员-3-@main
	local sayret = nil
	if true then
		sayret = [[
　　　 地图走法,怪物爆率,未知地图查询,请打#c00ffff,@帮助#C命令
╔┄╗╔┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╗╔┄╗
┆★┆┆#u#lc0000ff:1,#cffff00,比奇大城#L#U#C    #u#lc0000ff:2,#cffff00,银杏山谷#L#U#C   #u#lc0000ff:3,#cffff00,新手小村#L#U#C   #u#lc0000ff:4,#cffff00,白日天门#L#U#C┆┆★┆
┆极┆┆#u#lc0000ff:5,#cffff00,盟重土城#L#U#C    #u#lc0000ff:6,#cffff00,封魔神谷#L#U#C   #u#lc0000ff:7,#cffff00,毒蛇山谷#L#U#C   #u#lc0000ff:8,#cffff00,苍月海岛#L#U#C┆┆极┆
┆品┆╠┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╣┆品┆
┆复┆┆#u#lc0000ff:9,#cffff00,矿区洞口#L#U#C    #u#lc0000ff:10,#cffff00,蜈蚣洞口#L#U#C   #u#lc0000ff:11,#cffff00,沃玛洞口#L#U#C   #u#lc0000ff:12,#cffff00,石墓洞口#L#U#C┆┆复┆
┆古┆┆#u#lc0000ff:13,#cffff00,祖玛洞口#L#U#C    #u#lc0000ff:14,#cffff00,牛魔洞口#L#U#C   #u#lc0000ff:15,#cffff00,尸魔洞口#L#U#C   #u#lc0000ff:16,#cffff00,骨魔洞口#L#U#C┆┆古┆
┆★┆┆#u#lc0000ff:17,#cffff00,赤月洞口#L#U#C    #u#lc0000ff:18,#cffff00,幻境洞口#L#U#C   #u#lc0000ff:19,#cffff00,封魔洞口#L#U#C   #u#lc0000ff:20,#cffff00,圣域之门#L#U#C┆┆★┆
╚┄╝╚┄┄┄┄┄┄┄┄┄#u#lc0000ff:21,#cffff00,沙巴克#L#U#C┄┄┄┄┄┄┄┄┄╝╚┄╝   
]]
	end
	return sayret
end

function call_1138_21(human)--【传送员】/盟重传送员-3-@沙巴克
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(186,706*48,406*32)
		human:获得物品(10137,1)
		return sayret
	elseif true then
		sayret = [[
你没有1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_20(human)--【传送员】/盟重传送员-3-@圣域之门
	local sayret = nil
	if true then
		sayret = [[
嗯,消息挺灵的嘛，这么快就找我到这。
你想去挑战强大的怪物吗？不过你只有60分钟时间，
60分种你还会回来。而且这是要花费金钱的，
毕竟抓来他们也不荣誉，而且我也不能保障你们的安全。
那么还想试试吗？每进去一次收你30万。
#u#lc0000ff:22,#cffff00,打听圣域的消息#L#U#C
#u#lc0000ff:23,#cffff00,去#L#U#C
#u#lc0000ff:-1,#cffff00,不去#L#U#C
]]
	end
	return sayret
end

function call_1138_22(human)--【传送员】/盟重传送员-3-@SY
	local sayret = nil
	if true then
		sayret = [[
荣誉勋章乃圣域至宝，
不过你会首先到达一个叫"圣域之门"的地方。
可别在这个空旷的房间里滞留太长时间哦，
迈出你的第一步，传说中的圣域异兽就会出现。
你可要小心应付啊!
#u#lc0000ff:-1,#cffff00,关闭#L#U#C
]]
	end
	return sayret
end

function call_1138_23(human)--【传送员】/盟重传送员-3-@j
	local sayret = nil
	if human:获取金币()>=300000 and true then
		human:收回物品(10002,300000)
		human:随机传送(401)
		return sayret
	elseif true then
		sayret = [[
不够30万
#u#lc0000ff:-1,#cffff00,取消#L#U#C
]]
	end
	return sayret
end

function call_1138_18(human)--【传送员】/盟重传送员-3-@神秘幻境
	local sayret = nil
	if true then
		human:随机传送(374)
		human:获得物品(10137,1)
	elseif true then
		sayret = [[
你没有10w金币来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_1(human)--【传送员】/盟重传送员-3-@比奇大城
	local sayret = nil
	if true then
		human:传送(105,333*48,268*32)
		return sayret
	end
	return sayret
end

function call_1138_2(human)--【传送员】/盟重传送员-3-@银杏山谷
	local sayret = nil
	if true then
		human:传送(105,650*48,624*32)
		return sayret
	end
	return sayret
end

function call_1138_3(human)--【传送员】/盟重传送员-3-@比奇村庄
	local sayret = nil
	if true then
		human:传送(105,290*48,615*32)
		return sayret
	end
	return sayret
end

function call_1138_7(human)--【传送员】/盟重传送员-3-@毒蛇山谷
	local sayret = nil
	if true then
		human:传送(166,503*48,483*32)
		return sayret
	end
	return sayret
end

function call_1138_5(human)--【传送员】/盟重传送员-3-@盟重土城
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
		return sayret
	end
	return sayret
end

function call_1138_4(human)--【传送员】/盟重传送员-3-@白日天门
	local sayret = nil
	if true then
		human:传送(302,177*48,324*32)
		return sayret
	end
	return sayret
end

function call_1138_6(human)--【传送员】/盟重传送员-3-@封魔神谷
	local sayret = nil
	if true then
		human:传送(325,241*48,203*32)
		return sayret
	end
	return sayret
end

function call_1138_8(human)--【传送员】/盟重传送员-3-@苍月小岛
	local sayret = nil
	if true then
		human:传送(351,140*48,338*32)
		return sayret
	end
	return sayret
end

function call_1138_9(human)--【传送员】/盟重传送员-3-@矿区洞口
	local sayret = nil
	if true then
		human:传送(105,659*48,218*32)
		human:获得物品(10137,1)
		return sayret
	end
	return sayret
end

function call_1138_10(human)--【传送员】/盟重传送员-3-@蜈蚣洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(186,142*48,92*32)
		human:获得物品(10137,1)
		return sayret
	elseif true then
		sayret = [[
需要1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_11(human)--【传送员】/盟重传送员-3-@沃玛洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(162,71*48,69*32)
		human:获得物品(10137,1)
		return sayret
	elseif true then
		sayret = [[
需要1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_12(human)--【传送员】/盟重传送员-3-@石墓洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(230,27*48,20*32)
		human:获得物品(10137,1)
	elseif true then
		sayret = [[
你没有1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_17(human)--【传送员】/盟重传送员-3-@赤月洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(303,89*48,13*32)
		human:获得物品(10137,1)
	elseif true then
		sayret = [[
你没有3000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_13(human)--【传送员】/盟重传送员-3-@祖玛洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(205,17*48,17*32)
		human:获得物品(10137,1)
	elseif true then
		sayret = [[
你没有1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_14(human)--【传送员】/盟重传送员-3-@牛魔洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(351,658*48,463*32)
		human:获得物品(10137,1)
	elseif true then
		sayret = [[
你没有1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_15(human)--【传送员】/盟重传送员-3-@尸魔洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(351,522*48,615*32)
		human:获得物品(10137,1)
		return sayret
	elseif true then
		sayret = [[
你没有1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_16(human)--【传送员】/盟重传送员-3-@骨魔洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(351,545*48,131*32)
		human:获得物品(10137,1)
		return sayret
	elseif true then
		sayret = [[
你没有1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_19(human)--【传送员】/盟重传送员-3-@封魔洞口
	local sayret = nil
	if human:获取金币()>=1000 and true then
		human:收回物品(10002,1000)
		human:传送(325,60*48,71*32)
		human:获得物品(10137,1)
		return sayret
	elseif true then
		sayret = [[
你没有1000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_1138_24(human)--【传送员】/盟重传送员-3-@万恶之源
	local sayret = nil
	if true then
		sayret = [[
玛法大陆的怪物在勇士的围剿下已无处藏身
它们变异成暗之赤月恶魔躲到了这个洞穴里
国王号召勇士们前去消灭这最后的魔王
进入条件10w金币
#u#lc0000ff:25,#cffff00,前往万恶#L#U#C
#u#lc0000ff:-1,#cffff00,我不去了#L#U#C
]]
	end
	return sayret
end

function call_1138_25(human)--【传送员】/盟重传送员-3-@前往万恶
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:随机传送(457)
		human:获得物品(10137,1)
	elseif true then
		human:弹出消息框("你连10w金币都没有还想去！\\")
	end
	return sayret
end

function call_1138_21(human)--【传送员】/盟重传送员-3-@沙巴克
	local sayret = nil
	if true then
		human:传送(186,706*48,407*32)
	end
	return sayret
end
function call_1139_0(human)--【传送员】/比奇老兵-0-@main
	local sayret = nil
		sayret = call_1139_1(human) or sayret--系统功能\老兵@传送员
	return sayret
end

function call_1139_1(human)--【传送员】/比奇老兵-0-系统功能\老兵@传送员
	local sayret = nil
	if true then
		sayret = [[
 
　#cff00ff,]]..Config.SERVER_IP..[[#C,1.76复古小极品版!网站:#cff00ff,]]..Config.WEBSITE..[[#C
╔┄┄┄┄┄┄┄┄┄┄┄安全区域传送┄┄┄┄┄┄┄┄┄┄╗
┆≮#u#lc0000ff:2,#cffff00,比奇城堡#L#U#C≯         ≮#u#lc0000ff:3,#cffff00,盟重土城#L#U#C≯        ≮#u#lc0000ff:4,#cffff00,苍月小岛#L#U#C≯ ┆
┆≮#u#lc0000ff:5,#cffff00,白日天门#L#U#C≯         ≮#u#lc0000ff:6,#cffff00,封魔神谷#L#U#C≯        ≮#u#lc0000ff:7,#cffff00,毒蛇山谷#L#U#C≯ ┆
┆≮#u#lc0000ff:8,#cffff00,银杏山谷#L#U#C≯         ≮#u#lc0000ff:9,#cffff00,比奇村庄#L#U#C≯        ≮#u#lc0000ff:10,#cffff00,沙城区域#L#U#C≯ ┆
╚┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╝
]]
	end
	return sayret
end

function call_1139_2(human)--【传送员】/比奇老兵-0-系统功能\老兵@比奇大城
	local sayret = nil
	if true then
		human:传送(105,333*48,268*32)
		return sayret
	end
	return sayret
end

function call_1139_8(human)--【传送员】/比奇老兵-0-系统功能\老兵@银杏山谷
	local sayret = nil
	if true then
		human:传送(105,650*48,624*32)
		return sayret
	end
	return sayret
end

function call_1139_9(human)--【传送员】/比奇老兵-0-系统功能\老兵@比奇村庄
	local sayret = nil
	if true then
		human:传送(105,290*48,615*32)
		return sayret
	end
	return sayret
end

function call_1139_3(human)--【传送员】/比奇老兵-0-系统功能\老兵@盟重土城
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
		return sayret
	end
	return sayret
end

function call_1139_5(human)--【传送员】/比奇老兵-0-系统功能\老兵@白日天门
	local sayret = nil
	if true then
		human:传送(302,177*48,324*32)
		return sayret
	end
	return sayret
end

function call_1139_6(human)--【传送员】/比奇老兵-0-系统功能\老兵@封魔神谷
	local sayret = nil
	if true then
		human:传送(325,241*48,203*32)
		return sayret
	end
	return sayret
end

function call_1139_4(human)--【传送员】/比奇老兵-0-系统功能\老兵@苍月小岛
	local sayret = nil
	if true then
		human:传送(351,140*48,338*32)
		return sayret
	end
	return sayret
end

function call_1139_7(human)--【传送员】/比奇老兵-0-系统功能\老兵@毒蛇山谷
	local sayret = nil
	if true then
		human:传送(166,503*48,483*32)
		return sayret
	end
	return sayret
end

function call_1139_10(human)--【传送员】/比奇老兵-0-系统功能\老兵@沙城区域
	local sayret = nil
	if true then
		human:传送(186,706*48,407*32)
		human:获得物品(10137,1)
		return sayret
	end
	return sayret
end
function call_1140_0(human)--【传送员】/白日老兵-11-@main
	local sayret = nil
		sayret = call_1140_1(human) or sayret--系统功能\老兵@传送员
	return sayret
end

function call_1140_1(human)--【传送员】/白日老兵-11-系统功能\老兵@传送员
	local sayret = nil
	if true then
		sayret = [[
 
　#cff00ff,]]..Config.SERVER_IP..[[#C,1.76复古小极品版!网站:#cff00ff,]]..Config.WEBSITE..[[#C
╔┄┄┄┄┄┄┄┄┄┄┄安全区域传送┄┄┄┄┄┄┄┄┄┄╗
┆≮#u#lc0000ff:2,#cffff00,比奇城堡#L#U#C≯         ≮#u#lc0000ff:3,#cffff00,盟重土城#L#U#C≯        ≮#u#lc0000ff:4,#cffff00,苍月小岛#L#U#C≯ ┆
┆≮#u#lc0000ff:5,#cffff00,白日天门#L#U#C≯         ≮#u#lc0000ff:6,#cffff00,封魔神谷#L#U#C≯        ≮#u#lc0000ff:7,#cffff00,毒蛇山谷#L#U#C≯ ┆
┆≮#u#lc0000ff:8,#cffff00,银杏山谷#L#U#C≯         ≮#u#lc0000ff:9,#cffff00,比奇村庄#L#U#C≯        ≮#u#lc0000ff:10,#cffff00,沙城区域#L#U#C≯ ┆
╚┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╝
]]
	end
	return sayret
end

function call_1140_2(human)--【传送员】/白日老兵-11-系统功能\老兵@比奇大城
	local sayret = nil
	if true then
		human:传送(105,333*48,268*32)
		return sayret
	end
	return sayret
end

function call_1140_8(human)--【传送员】/白日老兵-11-系统功能\老兵@银杏山谷
	local sayret = nil
	if true then
		human:传送(105,650*48,624*32)
		return sayret
	end
	return sayret
end

function call_1140_9(human)--【传送员】/白日老兵-11-系统功能\老兵@比奇村庄
	local sayret = nil
	if true then
		human:传送(105,290*48,615*32)
		return sayret
	end
	return sayret
end

function call_1140_3(human)--【传送员】/白日老兵-11-系统功能\老兵@盟重土城
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
		return sayret
	end
	return sayret
end

function call_1140_5(human)--【传送员】/白日老兵-11-系统功能\老兵@白日天门
	local sayret = nil
	if true then
		human:传送(302,177*48,324*32)
		return sayret
	end
	return sayret
end

function call_1140_6(human)--【传送员】/白日老兵-11-系统功能\老兵@封魔神谷
	local sayret = nil
	if true then
		human:传送(325,241*48,203*32)
		return sayret
	end
	return sayret
end

function call_1140_4(human)--【传送员】/白日老兵-11-系统功能\老兵@苍月小岛
	local sayret = nil
	if true then
		human:传送(351,140*48,338*32)
		return sayret
	end
	return sayret
end

function call_1140_7(human)--【传送员】/白日老兵-11-系统功能\老兵@毒蛇山谷
	local sayret = nil
	if true then
		human:传送(166,503*48,483*32)
		return sayret
	end
	return sayret
end

function call_1140_10(human)--【传送员】/白日老兵-11-系统功能\老兵@沙城区域
	local sayret = nil
	if true then
		human:传送(186,706*48,407*32)
		human:获得物品(10137,1)
		return sayret
	end
	return sayret
end
function call_1141_0(human)--【传送员】/苍月老兵-5-@main
	local sayret = nil
		sayret = call_1141_1(human) or sayret--系统功能\老兵@传送员
	return sayret
end

function call_1141_1(human)--【传送员】/苍月老兵-5-系统功能\老兵@传送员
	local sayret = nil
	if true then
		sayret = [[
 
　#cff00ff,]]..Config.SERVER_IP..[[#C,1.76复古小极品版!网站:#cff00ff,]]..Config.WEBSITE..[[#C
╔┄┄┄┄┄┄┄┄┄┄┄安全区域传送┄┄┄┄┄┄┄┄┄┄╗
┆≮#u#lc0000ff:2,#cffff00,比奇城堡#L#U#C≯         ≮#u#lc0000ff:3,#cffff00,盟重土城#L#U#C≯        ≮#u#lc0000ff:4,#cffff00,苍月小岛#L#U#C≯ ┆
┆≮#u#lc0000ff:5,#cffff00,白日天门#L#U#C≯         ≮#u#lc0000ff:6,#cffff00,封魔神谷#L#U#C≯        ≮#u#lc0000ff:7,#cffff00,毒蛇山谷#L#U#C≯ ┆
┆≮#u#lc0000ff:8,#cffff00,银杏山谷#L#U#C≯         ≮#u#lc0000ff:9,#cffff00,比奇村庄#L#U#C≯        ≮#u#lc0000ff:10,#cffff00,沙城区域#L#U#C≯ ┆
╚┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╝
]]
	end
	return sayret
end

function call_1141_2(human)--【传送员】/苍月老兵-5-系统功能\老兵@比奇大城
	local sayret = nil
	if true then
		human:传送(105,333*48,268*32)
		return sayret
	end
	return sayret
end

function call_1141_8(human)--【传送员】/苍月老兵-5-系统功能\老兵@银杏山谷
	local sayret = nil
	if true then
		human:传送(105,650*48,624*32)
		return sayret
	end
	return sayret
end

function call_1141_9(human)--【传送员】/苍月老兵-5-系统功能\老兵@比奇村庄
	local sayret = nil
	if true then
		human:传送(105,290*48,615*32)
		return sayret
	end
	return sayret
end

function call_1141_3(human)--【传送员】/苍月老兵-5-系统功能\老兵@盟重土城
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
		return sayret
	end
	return sayret
end

function call_1141_5(human)--【传送员】/苍月老兵-5-系统功能\老兵@白日天门
	local sayret = nil
	if true then
		human:传送(302,177*48,324*32)
		return sayret
	end
	return sayret
end

function call_1141_6(human)--【传送员】/苍月老兵-5-系统功能\老兵@封魔神谷
	local sayret = nil
	if true then
		human:传送(325,241*48,203*32)
		return sayret
	end
	return sayret
end

function call_1141_4(human)--【传送员】/苍月老兵-5-系统功能\老兵@苍月小岛
	local sayret = nil
	if true then
		human:传送(351,140*48,338*32)
		return sayret
	end
	return sayret
end

function call_1141_7(human)--【传送员】/苍月老兵-5-系统功能\老兵@毒蛇山谷
	local sayret = nil
	if true then
		human:传送(166,503*48,483*32)
		return sayret
	end
	return sayret
end

function call_1141_10(human)--【传送员】/苍月老兵-5-系统功能\老兵@沙城区域
	local sayret = nil
	if true then
		human:传送(186,706*48,407*32)
		human:获得物品(10137,1)
		return sayret
	end
	return sayret
end
function call_1142_0(human)--【传送员】/封魔老兵-4-@main
	local sayret = nil
		sayret = call_1142_1(human) or sayret--系统功能\老兵@传送员
	return sayret
end

function call_1142_1(human)--【传送员】/封魔老兵-4-系统功能\老兵@传送员
	local sayret = nil
	if true then
		sayret = [[
 
　#cff00ff,]]..Config.SERVER_IP..[[#C,1.76复古小极品版!网站:#cff00ff,]]..Config.WEBSITE..[[#C
╔┄┄┄┄┄┄┄┄┄┄┄安全区域传送┄┄┄┄┄┄┄┄┄┄╗
┆≮#u#lc0000ff:2,#cffff00,比奇城堡#L#U#C≯         ≮#u#lc0000ff:3,#cffff00,盟重土城#L#U#C≯        ≮#u#lc0000ff:4,#cffff00,苍月小岛#L#U#C≯ ┆
┆≮#u#lc0000ff:5,#cffff00,白日天门#L#U#C≯         ≮#u#lc0000ff:6,#cffff00,封魔神谷#L#U#C≯        ≮#u#lc0000ff:7,#cffff00,毒蛇山谷#L#U#C≯ ┆
┆≮#u#lc0000ff:8,#cffff00,银杏山谷#L#U#C≯         ≮#u#lc0000ff:9,#cffff00,比奇村庄#L#U#C≯        ≮#u#lc0000ff:10,#cffff00,沙城区域#L#U#C≯ ┆
╚┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╝
]]
	end
	return sayret
end

function call_1142_2(human)--【传送员】/封魔老兵-4-系统功能\老兵@比奇大城
	local sayret = nil
	if true then
		human:传送(105,333*48,268*32)
		return sayret
	end
	return sayret
end

function call_1142_8(human)--【传送员】/封魔老兵-4-系统功能\老兵@银杏山谷
	local sayret = nil
	if true then
		human:传送(105,650*48,624*32)
		return sayret
	end
	return sayret
end

function call_1142_9(human)--【传送员】/封魔老兵-4-系统功能\老兵@比奇村庄
	local sayret = nil
	if true then
		human:传送(105,290*48,615*32)
		return sayret
	end
	return sayret
end

function call_1142_3(human)--【传送员】/封魔老兵-4-系统功能\老兵@盟重土城
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
		return sayret
	end
	return sayret
end

function call_1142_5(human)--【传送员】/封魔老兵-4-系统功能\老兵@白日天门
	local sayret = nil
	if true then
		human:传送(302,177*48,324*32)
		return sayret
	end
	return sayret
end

function call_1142_6(human)--【传送员】/封魔老兵-4-系统功能\老兵@封魔神谷
	local sayret = nil
	if true then
		human:传送(325,241*48,203*32)
		return sayret
	end
	return sayret
end

function call_1142_4(human)--【传送员】/封魔老兵-4-系统功能\老兵@苍月小岛
	local sayret = nil
	if true then
		human:传送(351,140*48,338*32)
		return sayret
	end
	return sayret
end

function call_1142_7(human)--【传送员】/封魔老兵-4-系统功能\老兵@毒蛇山谷
	local sayret = nil
	if true then
		human:传送(166,503*48,483*32)
		return sayret
	end
	return sayret
end

function call_1142_10(human)--【传送员】/封魔老兵-4-系统功能\老兵@沙城区域
	local sayret = nil
	if true then
		human:传送(186,706*48,407*32)
		human:获得物品(10137,1)
		return sayret
	end
	return sayret
end
function call_1143_0(human)--【传送员】/毒蛇老兵-2-@main
	local sayret = nil
		sayret = call_1143_1(human) or sayret--系统功能\老兵@传送员
	return sayret
end

function call_1143_1(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@传送员
	local sayret = nil
	if true then
		sayret = [[
 
　#cff00ff,]]..Config.SERVER_IP..[[#C,1.76复古小极品版!网站:#cff00ff,]]..Config.WEBSITE..[[#C
╔┄┄┄┄┄┄┄┄┄┄┄安全区域传送┄┄┄┄┄┄┄┄┄┄╗
┆≮#u#lc0000ff:2,#cffff00,比奇城堡#L#U#C≯         ≮#u#lc0000ff:3,#cffff00,盟重土城#L#U#C≯        ≮#u#lc0000ff:4,#cffff00,苍月小岛#L#U#C≯ ┆
┆≮#u#lc0000ff:5,#cffff00,白日天门#L#U#C≯         ≮#u#lc0000ff:6,#cffff00,封魔神谷#L#U#C≯        ≮#u#lc0000ff:7,#cffff00,毒蛇山谷#L#U#C≯ ┆
┆≮#u#lc0000ff:8,#cffff00,银杏山谷#L#U#C≯         ≮#u#lc0000ff:9,#cffff00,比奇村庄#L#U#C≯        ≮#u#lc0000ff:10,#cffff00,沙城区域#L#U#C≯ ┆
╚┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╝
]]
	end
	return sayret
end

function call_1143_2(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@比奇大城
	local sayret = nil
	if true then
		human:传送(105,333*48,268*32)
		return sayret
	end
	return sayret
end

function call_1143_8(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@银杏山谷
	local sayret = nil
	if true then
		human:传送(105,650*48,624*32)
		return sayret
	end
	return sayret
end

function call_1143_9(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@比奇村庄
	local sayret = nil
	if true then
		human:传送(105,290*48,615*32)
		return sayret
	end
	return sayret
end

function call_1143_3(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@盟重土城
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
		return sayret
	end
	return sayret
end

function call_1143_5(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@白日天门
	local sayret = nil
	if true then
		human:传送(302,177*48,324*32)
		return sayret
	end
	return sayret
end

function call_1143_6(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@封魔神谷
	local sayret = nil
	if true then
		human:传送(325,241*48,203*32)
		return sayret
	end
	return sayret
end

function call_1143_4(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@苍月小岛
	local sayret = nil
	if true then
		human:传送(351,140*48,338*32)
		return sayret
	end
	return sayret
end

function call_1143_7(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@毒蛇山谷
	local sayret = nil
	if true then
		human:传送(166,503*48,483*32)
		return sayret
	end
	return sayret
end

function call_1143_10(human)--【传送员】/毒蛇老兵-2-系统功能\老兵@沙城区域
	local sayret = nil
	if true then
		human:传送(186,706*48,407*32)
		human:获得物品(10137,1)
		return sayret
	end
	return sayret
end
function call_1144_0(human)--【盟重省】/找我买太阳水-3-@main
	local sayret = nil
	if true then
		sayret = [[
欢迎光临本店，被管理员所逼，在此卖太阳水包，请多多光顾！ 
#u#lc0000ff:1,#cffff00,强效太阳包(1包)#L#U#C:4元宝  #u#lc0000ff:2,#cffff00,强效太阳包(6包)#L#U#C:24元宝 
#u#lc0000ff:3,#cffff00,强效太阳捆(1捆)#L#U#C:25元宝 #u#lc0000ff:4,#cffff00,强效太阳捆(6捆)#L#U#C:150元宝 
#c00ff00,说明#C:强效太阳捆包含6个强效太阳包，点开获取6个强效太阳包 
　　　　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1144_1(human)--【盟重省】/找我买太阳水-3-@一包
	local sayret = nil
	if human:背包空格数()>=1 and human:获取元宝()>3 and true then
		human:调整元宝(human:获取元宝()-4)
		human:获得物品(10301,1)
		human:发送广播("#c00ff00,".."购买成功")
	elseif true then
		sayret = [[
对不起元宝不够，包袱空格不够    
　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1144_2(human)--【盟重省】/找我买太阳水-3-@六包
	local sayret = nil
	if human:背包空格数()>=6 and human:获取元宝()>23 and true then
		human:调整元宝(human:获取元宝()-24)
		human:获得物品(10301,6)
		human:发送广播("#c00ff00,".."购买成功")
	elseif true then
		sayret = [[
对不起元宝不够，包袱空格不够    
　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1144_3(human)--【盟重省】/找我买太阳水-3-@一捆
	local sayret = nil
	if human:背包空格数()>=1 and human:获取元宝()>24 and true then
		human:调整元宝(human:获取元宝()-25)
		human:获得物品(10358,1)
		human:发送广播("#c00ff00,".."购买成功")
	elseif true then
		sayret = [[
对不起元宝不够，包袱空格不够    
　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1144_4(human)--【盟重省】/找我买太阳水-3-@六捆
	local sayret = nil
	if human:背包空格数()>=6 and human:获取元宝()>149 and true then
		human:调整元宝(human:获取元宝()-150)
		human:获得物品(10358,6)
		human:发送广播("#c00ff00,".."购买成功")
	elseif true then
		sayret = [[
对不起元宝不够，包袱空格不够    
　　　　　　　　　　　　　　　　　　　　　#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1145_0(human)--教主之家-3-@main
	local sayret = nil
	if true then
		sayret = [[
想到BOSS之家吗100万金币费用40级
所有BOSS都有哦 (满载着你的梦想)
注意：里面怪物异常凶悍，请组队进入
但凡人在那逗留过久会渐染魔性
#u#lc0000ff:1,#cffff00,进入BOSS之家#L#U#C #u#lc0000ff:1,#cffff00,进入BOSS之家#L#U#C #u#lc0000ff:1,#cffff00,进入BOSS之家#L#U#C
]]
	end
	return sayret
end

function call_1145_1(human)--教主之家-3-@1
	local sayret = nil
	if human:获取等级()>39 and human:获取金币()>=1000000 and true then
		human:收回物品(10002,1000000)
		human:获得物品(10137,1)
		human:随机传送(471)
		全服广播("#cff00ff,".."★恭喜【"..human:获取名字().."】进入BOSS之家，祝他好运！！")
		return sayret
	elseif true then
		human:弹出消息框("需要100万金币用来支付我们的服务费用或没有40级!。")
		return sayret
	end
	return sayret
end
function call_1146_0(human)--比奇国王-0122-@main
	local sayret = nil
	if true then
		sayret = [[
我是比齐皇宫管理人,掌管着许多事物。希望我能对你有帮助
#u#lc0000ff:1,#cffff00,请求创建行会.#L#U#C
#u#lc0000ff:2,#cffff00,申请行会战争.#L#U#C
#u#lc0000ff:3,#cffff00,如何建立行会.#L#U#C
#u#lc0000ff:4,#cffff00,有关行会战争.#L#U#C
#u#lc0000ff:5,#cffff00,申请攻城战争.#L#U#C
]]
	end
	return sayret
end

function call_1146_3(human)--比奇国王-0122-@buildguildexp
	local sayret = nil
	if true then
		sayret = [[
建立行会你应该证明你有资格。必须支付100万金币作为基础
而且要取得位于沃玛寺庙底部深处的沃玛教主所拥有的号角! 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1146_2(human)--比奇国王-0122-@guildwar
	local sayret = nil
	if true then
		sayret = [[
填写与你交战的敌对行会的名字，申请行会战争必须支付3万金币 
#u#lc0000ff:6,#cffff00,立即申请行会战争#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1146_4(human)--比奇国王-0122-@guildwarexp
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:7,#cffff00,行会战#L#U#C是一种合法的战争，因为目前有许多行会和
玩家都同意，这是#u#lc0000ff:8,#cffff00,合法的#L#U#C的行会间战争。
你是否#u#lc0000ff:9,#cffff00,请求#L#U#C行会战争?战争将
进行3小时,你必须支付#cff00ff,]]..""..[[#C所规定的申请费用. 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1146_7(human)--比奇国王-0122-@guildwar2
	local sayret = nil
	if true then
		sayret = [[
当你请求行会战争的时候,相同行会成员的名字将会出现在蓝色的。
在另一方面,敌人的行会成员名字将会变成橘色的.开战中的行会
成员在此期间登录,信息窗口会有[××在与你行会进行行会战]
的信息出现，在这个时候，如果你杀敌了人的行会某一个成员,
系统对你的行为将不会被视为 PK 。  
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1146_8(human)--比奇国王-0122-@warrule
	local sayret = nil
	if true then
		sayret = [[
行会战争在城市中不能发生,它在城市某范围外或内部竞赛区
域(一些建筑物之内)被启动.否则你 PK 你的身份将会是红色
的!甚至在战争期间。 
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1146_9(human)--比奇国王-0122-@propose
	local sayret = nil
	if true then
		sayret = [[
行会战争的提议只能由行会首领提出。 
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1146_5(human)--比奇国王-0122-@requestcastlewar
	local sayret = nil
	if true then
		sayret = [[
本服暂不开放沙巴克攻城战
]]
	end
	return sayret
end
function call_1147_0(human)--比奇国王-3-@main
	local sayret = nil
	if true then
		sayret = [[
我是比齐皇宫管理人,掌管着许多事物。希望我能对你有帮助
#u#lc0000ff:1,#cffff00,请求创建行会.#L#U#C
#u#lc0000ff:2,#cffff00,申请行会战争.#L#U#C
#u#lc0000ff:3,#cffff00,如何建立行会.#L#U#C
#u#lc0000ff:4,#cffff00,有关行会战争.#L#U#C
#u#lc0000ff:5,#cffff00,申请攻城战争.#L#U#C
]]
	end
	return sayret
end

function call_1147_3(human)--比奇国王-3-@buildguildexp
	local sayret = nil
	if true then
		sayret = [[
建立行会你应该证明你有资格。必须支付100万金币作为基础
而且要取得位于沃玛寺庙底部深处的沃玛教主所拥有的号角! 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1147_2(human)--比奇国王-3-@guildwar
	local sayret = nil
	if true then
		sayret = [[
填写与你交战的敌对行会的名字，申请行会战争必须支付3万金币 
#u#lc0000ff:6,#cffff00,立即申请行会战争#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1147_4(human)--比奇国王-3-@guildwarexp
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:7,#cffff00,行会战#L#U#C是一种合法的战争，因为目前有许多行会和
玩家都同意，这是#u#lc0000ff:8,#cffff00,合法的#L#U#C的行会间战争。
你是否#u#lc0000ff:9,#cffff00,请求#L#U#C行会战争?战争将
进行3小时,你必须支付#cff00ff,]]..""..[[#C所规定的申请费用. 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1147_7(human)--比奇国王-3-@guildwar2
	local sayret = nil
	if true then
		sayret = [[
当你请求行会战争的时候,相同行会成员的名字将会出现在蓝色的。
在另一方面,敌人的行会成员名字将会变成橘色的.开战中的行会
成员在此期间登录,信息窗口会有[××在与你行会进行行会战]
的信息出现，在这个时候，如果你杀敌了人的行会某一个成员,
系统对你的行为将不会被视为 PK 。  
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1147_8(human)--比奇国王-3-@warrule
	local sayret = nil
	if true then
		sayret = [[
行会战争在城市中不能发生,它在城市某范围外或内部竞赛区
域(一些建筑物之内)被启动.否则你 PK 你的身份将会是红色
的!甚至在战争期间。 
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1147_9(human)--比奇国王-3-@propose
	local sayret = nil
	if true then
		sayret = [[
行会战争的提议只能由行会首领提出。 
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1147_5(human)--比奇国王-3-@requestcastlewar
	local sayret = nil
	if true then
		sayret = [[
本服暂不开放沙巴克攻城战
]]
	end
	return sayret
end
function call_1148_0(human)--管理人员-0150-@main
	local sayret = nil
	if true then
		sayret = [[
沙巴克是在 #cff00ff,]]..""..[[#C 的管理下。并且受约束于 #cff00ff,]]..""..[[#C
城堡的总黄金是: #cff00ff,]]..""..[[#C
今天的收入是: #cff00ff,]]..""..[[#C 
#u#lc0000ff:1,#cffff00,取回资金#L#U#C　#u#lc0000ff:2,#cffff00,存入资金#L#U#C
#u#lc0000ff:3,#cffff00,控制城门#L#U#C　#u#lc0000ff:4,#cffff00,修理城门#L#U#C
#u#lc0000ff:5,#cffff00,雇用守卫#L#U#C　#u#lc0000ff:6,#cffff00,城主公告#L#U#C
]]
	end
	return sayret
end

function call_1148_6(human)--管理人员-0150-@@sendMsg
	local sayret = nil
	if true then
	elseif true then
		sayret = [[
城内资金不足，不要乱用钱。 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1148_3(human)--管理人员-0150-@treatdoor
	local sayret = nil
	if true then
		sayret = [[
城门当前状态为:#cff00ff,]]..""..[[#C 
#u#lc0000ff:7,#cffff00,关闭城门#L#U#C
#u#lc0000ff:8,#cffff00,打开城门#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1148_8(human)--管理人员-0150-@openmaindoor
	local sayret = nil
	if true then
		sayret = [[
城门已经打开。 
#u#lc0000ff:3,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1148_7(human)--管理人员-0150-@closemaindoor
	local sayret = nil
	if true then
		sayret = [[
城门已经关闭。 
#u#lc0000ff:3,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1148_4(human)--管理人员-0150-@repaircastle
	local sayret = nil
	if true then
		sayret = [[
请选择要修理的位置？ 
#u#lc0000ff:9,#cffff00,修理城门#L#U#C
#u#lc0000ff:10,#cffff00,修理城墙#L#U#C 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1148_9(human)--管理人员-0150-@repairdoor
	local sayret = nil
	if true then
		sayret = [[
修理城门所需费用为:#cff00ff,]]..""..[[#C金币。 
#u#lc0000ff:11,#cffff00,修理城门#L#U#C
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1148_10(human)--管理人员-0150-@repairwalls
	local sayret = nil
	if true then
		sayret = [[
修理城墙所需费用为:#cff00ff,]]..""..[[#C金币。 
#u#lc0000ff:12,#cffff00,修理城墙一#L#U#C
#u#lc0000ff:13,#cffff00,修理城墙二#L#U#C
#u#lc0000ff:14,#cffff00,修理城墙三#L#U#C 
#u#lc0000ff:4,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1148_5(human)--管理人员-0150-@hirearchers
	local sayret = nil
	if true then
		sayret = [[
雇用弓箭手可保护城堡的安全，并维护城堡的治安。
每个弓箭手的雇用费用为#cff00ff,]]..""..[[#C金币。
请选择要雇用弓箭手放置位置: 
#u#lc0000ff:15,#cffff00,流动弓箭手一#L#U#C, #u#lc0000ff:16,#cffff00,流动弓箭手二#L#U#C, #u#lc0000ff:17,#cffff00,流动弓箭手三#L#U#C, #u#lc0000ff:18,#cffff00,流动弓箭手四#L#U#C
#u#lc0000ff:19,#cffff00,城墙左弓箭手三#L#U#C, #u#lc0000ff:20,#cffff00,城墙左弓箭手二#L#U#C, #u#lc0000ff:21,#cffff00,城墙左弓箭手一#L#U#C
#u#lc0000ff:22,#cffff00,城墙右弓箭手一#L#U#C, #u#lc0000ff:23,#cffff00,城墙右弓箭手二#L#U#C, #u#lc0000ff:24,#cffff00,城墙右弓箭手三#L#U#C
#u#lc0000ff:25,#cffff00,城门左弓箭手#L#U#C, #u#lc0000ff:26,#cffff00,城门左弓箭手#L#U#C, #u#lc0000ff:27,#cffff00,城门右弓箭手#L#U#C, #u#lc0000ff:28,#cffff00,城门右弓箭手#L#U#C
#u#lc0000ff:29,#cffff00,皇宫左弓箭手#L#U#C, #u#lc0000ff:30,#cffff00,皇宫右弓箭手#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_1149_0(human)--老人-3-@main
	local sayret = nil
	if true then
		sayret = [[
你想知道最近沙巴克的攻城战役吗? 
#u#lc0000ff:1,#cffff00,查看.#L#U#C
]]
	end
	return sayret
end

function call_1149_1(human)--老人-3-@aboutwar
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,最近的攻城战役预告:#C
战役开始时间： #cff00ff,]]..""..[[#C , 20:00开始。 
#u#lc0000ff:2,#cffff00,详细攻城时间表：#L#U#C
#u#lc0000ff:-1,#cffff00,关闭.#L#U#C
]]
	end
	return sayret
end

function call_1149_2(human)--老人-3-@listwar
	local sayret = nil
	if true then
		sayret = [[
#cff00ff,]]..""..[[#C
#u#lc0000ff:-1,#cffff00,知道了.#L#U#C
]]
	end
	return sayret
end
function call_1150_0(human)--红娘-M101-@Main
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:1,#cffff00,我想结婚#L#U#C
#u#lc0000ff:2,#cffff00,我想离婚#L#U#C 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_1150_1(human)--红娘-M101-@Marry
	local sayret = nil
	if true then
		sayret = [[
#cff00ff,]]..human:获取名字()..[[#C,你和你的心上人一起来了吗.?
结婚可是双方自愿的,如果你们准备好了.
请面对面站好.!再向对方#u#lc0000ff:3,#cffff00,求婚#L#U#C..!
不管你的求婚有没有成功.都需要给我一个求婚戒指..! 
#u#lc0000ff:-1,#cffff00,还没准备好#L#U#C
]]
	end
	return sayret
end

function call_1150_3(human)--红娘-M101-@Agree
	local sayret = nil
	if true then
		human:弹出消息框("你都结过婚了.还来注册结婚.想犯重婚罪呀.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
		human:弹出消息框("对方已经结过婚了.是不是想犯重婚罪呀.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if human:获取性别()==1 and true then
	elseif true then
		human:弹出消息框("只有男的向女的求婚.还没见过大姑娘向小伙子求婚的.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if human:获取对面性别()==1 and true then
		human:弹出消息框("你变态呀.想搞同性恋.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if human:获取对面站位(2) and true then
	elseif true then
		human:弹出消息框("你们二个面对面站好呀.不要乱动.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
	elseif true then
		human:弹出消息框("结婚要求你的等级必须40级或以上.小伙子努力练好级再来找我.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if human:获取对面等级()>34 and true then
	elseif true then
		human:弹出消息框("你的对象还没成年.等她长大点再来吧.小伙子不要心急嘛.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
	elseif true then
		human:弹出消息框("你没求婚戒指.弄到求婚戒指再来找我吧.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
	end
	return sayret
end

function call_1150_4(human)--红娘-M101-@StartMarry
	local sayret = nil
	if true then
		human:弹出消息框("你都结过婚了.还来注册结婚.想犯重婚罪呀.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if human:获取性别()==1 and true then
		sayret = [[
婚礼现在正式开始. 
你愿意娶对方为妻.并照顾她一生一世吗.? 
#u#lc0000ff:5,#cffff00,我愿意#L#U#C
]]
		return sayret
	end
	if human:获取性别()==2 and true then
		sayret = [[
婚礼现在正式开始. 
请耐心等待你心爱的人向你求婚 
]]
		return sayret
	end
	return sayret
end

function call_1150_5(human)--红娘-M101-@RequestMarry
	local sayret = nil
	if true then
		human:弹出消息框("你都结过婚了.还来注册结婚，想犯重婚罪呀.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
	end
	return sayret
end

function call_1150_6(human)--红娘-M101-@WateMarry
	local sayret = nil
	if true then
		sayret = [[
你已向对方求婚.请耐心等待对方的答复.!
]]
	end
	return sayret
end

function call_1150_7(human)--红娘-M101-@RevMarry
	local sayret = nil
	if true then
		human:弹出消息框("你都结过婚了.还来注册结婚.想犯重婚罪呀.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
		sayret = [[
对方向你求婚.你是否答应嫁给他.? 
#u#lc0000ff:8,#cffff00,我愿意#L#U#C 
#u#lc0000ff:9,#cffff00,我不愿意#L#U#C
]]
	end
	return sayret
end

function call_1150_8(human)--红娘-M101-@ResposeMarry
	local sayret = nil
	if true then
		human:弹出消息框("你都结过婚了.还来注册结婚.想犯重婚罪呀.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
	end
	return sayret
end

function call_1150_9(human)--红娘-M101-@ResposeMarryFail
	local sayret = nil
	if true then
		human:弹出消息框("你都结过婚了.还来注册结婚.想犯重婚罪呀.!")
		sayret = call_1150_0(human) or sayret--@Main
		return sayret
	end
	if true then
	end
	return sayret
end

function call_1150_10(human)--红娘-M101-@EndMarry
	local sayret = nil
	if true then
		human:弹出消息框("你们二个已经成为了一对全法夫妻了.")
	end
	return sayret
end

function call_1150_11(human)--红娘-M101-@EndMarryFail
	local sayret = nil
	if true then
		human:弹出消息框("结婚失败.")
	end
	return sayret
end

function call_1150_12(human)--红娘-M101-@MarryDirErr
	local sayret = nil
	if true then
		human:弹出消息框("对方没站好位置.")
	end
	return sayret
end

function call_1150_13(human)--红娘-M101-@MarryCheckDir
	local sayret = nil
	if true then
		human:弹出消息框("请站好位置.")
	end
	return sayret
end

function call_1150_14(human)--红娘-M101-@HumanTypeErr
	local sayret = nil
	if true then
		human:弹出消息框("你变态呀.既然选择一个非人类作为结婚对象.")
	end
	return sayret
end

function call_1150_15(human)--红娘-M101-@MarrySexErr
	local sayret = nil
	if true then
		human:弹出消息框("你变态呀.既然同性恋.")
	end
	return sayret
end

function call_1150_2(human)--红娘-M101-@unmarry
	local sayret = nil
	if true then
	elseif true then
		human:弹出消息框("你都没结婚离什么婚.?")
	end
	return sayret
end

function call_1150_16(human)--红娘-M101-@UnMarryCheckDir
	local sayret = nil
	if true then
		sayret = [[
要离婚是吧.?离婚是二个人的事.必须二个人对面对站好位置.
如果人来不了你只能选择强行离婚姻了.! 
#u#lc0000ff:17,#cffff00,我要强行离婚#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1150_18(human)--红娘-M101-@UnMarryTypeErr
	local sayret = nil
	if true then
		sayret = [[
你对面站了个什么东西.怎么不太象人来的.! 
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1150_19(human)--红娘-M101-@StartUnMarry
	local sayret = nil
	if human:获取性别()==1 and true then
		sayret = [[
是否确定真的要与你共事多年的妻子离婚吗.? 
#u#lc0000ff:20,#cffff00,确定#L#U#C
]]
		return sayret
	end
	if human:获取性别()==2 and true then
		sayret = [[
你的老公现在向我请求离婚.是不是愿意协议离婚.?  
#u#lc0000ff:20,#cffff00,确定#L#U#C
]]
		return sayret
	end
	return sayret
end

function call_1150_20(human)--红娘-M101-@RequestUnMarry
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1150_21(human)--红娘-M101-@ResposeUnMarry
	local sayret = nil
	if true then
	end
	return sayret
end

function call_1150_22(human)--红娘-M101-@WateUnMarry
	local sayret = nil
	if true then
		sayret = [[
你已向对方发出离婚请求.请耐心等待对方的答复.!
]]
	end
	return sayret
end

function call_1150_23(human)--红娘-M101-@RevUnMarry
	local sayret = nil
	if true then
		sayret = [[
对方向你离婚请求,你是否答应离婚.?  
#u#lc0000ff:20,#cffff00,我愿意#L#U#C
#u#lc0000ff:0,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_1150_24(human)--红娘-M101-@ExeMarryFail
	local sayret = nil
	if true then
		sayret = [[
你都没结过婚.跑来做什么.?  
]]
	end
	return sayret
end

function call_1150_17(human)--红娘-M101-@fUnMarry
	local sayret = nil
	if human:检查物品数量(10317,1) and true then
		human:收回物品(10317,1)
	elseif true then
		human:弹出消息框("要收一根金条的手续费.你没有金条.我不能让你离婚.!")
	end
	return sayret
end

function call_1150_25(human)--红娘-M101-@UnMarryEnd
	local sayret = nil
	if true then
		human:弹出消息框("呵呵.你已经脱离苦海了..")
	end
	return sayret
end

function call_1150_26(human)--红娘-M101-@Asktime
	local sayret = nil
	if true then
		sayret = [[
你调查结婚时间的请求已发出.请稍后
#u#lc0000ff:-1,#cffff00,确定#L#U#C
]]
	end
	return sayret
end
