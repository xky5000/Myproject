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

function call_玩家死亡(human)--@PLAYDIE
	local sayret = nil
	if human:检查玩家击杀() and true then
		全服广播("#cff00ff,".."〖提示〗玩家【"..human:获取名字().."】在".."".."("..""..":"..""..")被【"..human:击杀者().."】无情的杀害.")
		human.私人变量.XV=(human.私人变量.XV or 0)+1
		存文件内容("杀敌阵亡.txt",human:获取名字(),"XV",human.私人变量.XV)
		return sayret
	end
	return sayret
end

function call_玩家升级(human)--@PlayLevelUp
	local sayret = nil

	human:更新属性点()
	
	return sayret
end

function call_物品使用_10317(human)--@StdModeFunc10
	local sayret = nil
	if human:获取等级()>0 and true then
		human:获得物品(10002,1000000)
		return sayret
	end
	return sayret
end

function call_物品使用_11(human)--@StdModeFunc11
	local sayret = nil
	if human:获取等级()>0 and true then
		human:传送(186,330*48,333*32)
		return sayret
	end
	return sayret
end

function call_物品使用_12(human)--@StdModeFunc12
	local sayret = nil
	if human:检查物品数量(10195,6) and true then
		human:收回物品(10195,6)
		human:获得物品(10301,1)
	elseif true then
		sayret = [[
你都没有足够的强效太阳水需要打捆，
还捆什么? 
浪费...  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_物品使用_13(human)--@StdModeFunc13
	local sayret = nil
	if human:检查物品数量(10215,6) and true then
		human:收回物品(10215,6)
		human:获得物品(10302,1)
	elseif true then
		sayret = [[
你都没有足够的万年雪霜需要打捆，
还捆什么? 
浪费...  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_物品使用_14(human)--@StdModeFunc14
	local sayret = nil
	if human:检查物品数量(10198,6) and true then
		human:收回物品(10198,6)
		human:获得物品(10303,1)
	elseif true then
		sayret = [[
你都没有足够的疗伤药需要打捆，
还捆什么? 
浪费...  
#u#lc0000ff:-1,#cffff00,离 开#L#U#C
]]
	end
	return sayret
end

function call_物品使用_10325(human)--@StdModeFunc15
	local sayret = nil
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,"..human:获取名字().."在["..human:当前地图名字()..":"..human:当前位置X()..":"..human:当前位置Y().."]燃放了<一心一意>烟花!")
		return sayret
	end
	return sayret
end

function call_物品使用_10326(human)--@StdModeFunc16
	local sayret = nil
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,"..human:获取名字().."在["..human:当前地图名字()..":"..human:当前位置X()..":"..human:当前位置Y().."]燃放了<心心相印>烟花!")
		return sayret
	end
	return sayret
end

function call_物品使用_10327(human)--@StdModeFunc17
	local sayret = nil
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,"..human:获取名字().."在["..human:当前地图名字()..":"..human:当前位置X()..":"..human:当前位置Y().."]燃放了<飞火流量>烟花!")
		return sayret
	end
	return sayret
end

function call_物品使用_10328(human)--@StdModeFunc18
	local sayret = nil
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,"..human:获取名字().."在["..human:当前地图名字()..":"..human:当前位置X()..":"..human:当前位置Y().."]燃放了<浪漫星雨>烟花!")
		return sayret
	end
	return sayret
end

function call_物品使用_10329(human)--@StdModeFunc19
	local sayret = nil
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,"..human:获取名字().."在["..human:当前地图名字()..":"..human:当前位置X()..":"..human:当前位置Y().."]燃放了<绮梦幻想>烟花!")
		return sayret
	end
	return sayret
end

function call_物品使用_10330(human)--@StdModeFunc20
	local sayret = nil
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,"..human:获取名字().."在["..human:当前地图名字()..":"..human:当前位置X()..":"..human:当前位置Y().."]燃放了<长空火舞>烟花!")
		return sayret
	end
	return sayret
end

function call_物品使用_10331(human)--@StdModeFunc21
	local sayret = nil
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,"..human:获取名字().."在["..human:当前地图名字()..":"..human:当前位置X()..":"..human:当前位置Y().."]燃放了<如梦似雾>烟花!")
		return sayret
	end
	return sayret
end

function call_物品使用_10332(human)--@StdModeFunc22
	local sayret = nil
	if human:获取等级()>0 and true then
		sayret = call_2(human) or sayret--系统功能\庆典蛋糕@庆典蛋糕
		return sayret
	end
	return sayret
end

function call_物品使用_10333(human)--@StdModeFunc23
	local sayret = nil
	if human:获取性别()==2 and true then
		human:更改发型(0)
		human:发送广播("#c00ff00,".."发型已经变更!")
		return sayret
	end
	if human:获取性别()==1 and true then
		human:更改发型(0)
		human:发送广播("#c00ff00,".."发型已经变更!")
		return sayret
	end
	return sayret
end

function call_物品使用_10334(human)--@StdModeFunc24
	local sayret = nil
	if human:获取性别()==2 and true then
		human:更改发型(1)
		human:发送广播("#c00ff00,".."发型已经变更!")
		return sayret
	end
	if human:获取性别()==1 and true then
		human:更改发型(1)
		human:发送广播("#c00ff00,".."发型已经变更!")
		return sayret
	end
	return sayret
end

function call_物品使用_10335(human)--@StdModeFunc25
	local sayret = nil
	if true then
		sayret = [[
移动仓库为您提供以下服务功能: 
#u#lc0000ff:3,#cffff00,存放物品#L#U#C 
#u#lc0000ff:4,#cffff00,取回物品#L#U#C
]]
	end
	return sayret
end

function call_3(human)--@storage
	local sayret = nil
	if true then
		sayret = [[
需要保管什么东西? 
#u#lc0000ff:4,#cffff00,取回物品#L#U#C 
#u#lc0000ff:5,#cffff00,返回上页#L#U#C
]]
	end
	return sayret
end

function call_4(human)--@getback
	local sayret = nil
	if true then
		sayret = [[
请看目录决定找什么东西. 
#u#lc0000ff:3,#cffff00,存放物品#L#U#C 
#u#lc0000ff:5,#cffff00,返回上页#L#U#C
]]
	end
	return sayret
end

function call_物品使用_26(human)--@StdModeFunc26
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整PK值(0)
		human:发送广播("#c00ff00,".."你的PK值已清洗!")
		return sayret
	end
	return sayret
end

function call_物品使用_10337(human)--@StdModeFunc27
	local sayret = nil
	if human:获取等级()>0 and true then
		human:设置经验倍数(200/100,3600)
		return sayret
	end
	return sayret
end

function call_物品使用_10338(human)--@StdModeFunc28
	local sayret = nil
	if human:获取等级()>0 and true then
		human:设置经验倍数(400/100,3600)
		return sayret
	end
	return sayret
end

function call_物品使用_29(human)--@StdModeFunc29
	local sayret = nil
	if human:获取等级()>0 and true then
		human:获得物品(10138,1)
		return sayret
	end
	return sayret
end

function call_物品使用_10340(human)--@StdModeFunc30
	local sayret = nil
	if human:获取等级()>0 and true then
		human:传送(440,84*48,70*32)
		human:发送广播("#cff00ff,".."本地图总共三层.暴率为2倍.")
		return sayret
	end
	return sayret
end

function call_物品使用_10341(human)--@StdModeFunc31
	local sayret = nil
	if (human.m_db.私人变量._300 or 0)==0 and true then
		human.m_db.私人变量._300=1
		human:更改名字颜色(0xFF00FE)
		return sayret
	elseif true then
		human:发送广播("#c00ff00,".."您已经享受金钻服务!相关命令@服务")
		human:获得物品(10341,1)
		return sayret
	end
	return sayret
end

function call_物品使用_10342(human)--@StdModeFunc32
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+1)
		human:发送广播("#c00ff00,".."提示:增加1个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10343(human)--@StdModeFunc33
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+5)
		human:发送广播("#c00ff00,".."提示:增加5个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10344(human)--@StdModeFunc34
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+10)
		human:发送广播("#c00ff00,".."提示:增加10个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10345(human)--@StdModeFunc35
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+20)
		human:发送广播("#c00ff00,".."提示:增加20个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10346(human)--@StdModeFunc36
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+50)
		human:发送广播("#c00ff00,".."提示:增加50个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10347(human)--@StdModeFunc37
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+100)
		human:发送广播("#c00ff00,".."提示:增加100个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10348(human)--@StdModeFunc38
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+500)
		human:发送广播("#c00ff00,".."提示:增加500个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10349(human)--@StdModeFunc39
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+1000)
		human:发送广播("#c00ff00,".."提示:增加1000个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10350(human)--@StdModeFunc40
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+5000)
		human:发送广播("#c00ff00,".."提示:增加5000个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10351(human)--@StdModeFunc41
	local sayret = nil
	if human:获取等级()>0 and true then
		human:调整元宝(human:获取元宝()+10000)
		human:发送广播("#c00ff00,".."提示:增加10000个元宝!")
		return sayret
	end
	return sayret
end

function call_物品使用_10352(human)--@StdModeFunc42
	local sayret = nil
	if human:检查附加属性(1,13)<7 and true then
		human:装备属性升级(1,13,0,1,0)
		return sayret
	elseif true then
		sayret = [[
你的武器附加了7点幸运值.不可以在加了!!
]]
	end
	return sayret
end

function call_物品使用_10353(human)--@StdModeFunc43
	local sayret = nil
	if human:获取等级()>0 and true then
		human:随机传送(102)
		human:发送广播("#c00ffff,".."本地图总共二层.")
		全服广播("#cff00ff,".."玩家「"..human:获取名字().."」到达了猪洞八层，玩家想去的话可以到商铺购买传送卡")
		return sayret
	end
	return sayret
end

function call_物品使用_10363(human)--@StdModeFunc126
	local sayret = nil
	if human:获取等级()>0 and true then
		human:随机传送(470)
		全服广播("#cff00ff,".."玩家「"..human:获取名字().."」到达了神龙殿，玩家想去的话可以到商铺购买传送卡")
		return sayret
	end
	return sayret
end

function call_用户命令_后台管理(human)--@USERCMD0
	local sayret = nil
	if human:是否管理员() and true then
		sayret = call_6(human) or sayret--系统功能\后台管理@管理
	end
	return sayret
end

function call_用户命令_帮助(human)--@USERCMD1
	local sayret = nil
	if true then
		sayret = call_7(human) or sayret--系统功能\帮助命令@帮助命令
	end
	return sayret
end

function call_用户命令_服务(human)--@USERCMD2
	local sayret = nil
	if (human.m_db.私人变量._300 or 0)==1 and true then
		sayret = call_8(human) or sayret--系统功能\金钻会员@金钻会员
	end
	return sayret
end

function call_用户命令_千山1(human)--@USERCMD3
	local sayret = nil
	if true then
		sayret = call_9(human) or sayret--系统功能\二号后台@二号后台
	end
	return sayret
end

function call_物品使用_45(human)--@StdModeFunc45
	local sayret = nil
	if human:获取等级()>0 and true then
		human:获得物品(10215,6)
		return sayret
	end
	return sayret
end

function call_物品使用_46(human)--@StdModeFunc46
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,千里传音#C可以将你要说出的话全区显示，特别醒目！
每句话限制为：30个字
请将要说的话编辑写到千里传音内！ 
#u#lc0000ff:10:1:2,#cffff00,千里传音#L#U#C
]]
	end
	return sayret
end

function call_10(human)--@INPUTSTRING2
	local sayret = nil
	if human:获取等级()>0 and true then
		sayret = call_11(human) or sayret--~InPutInteger5
		return sayret
	end
	return sayret
end

function call_11(human)--~InPutInteger5
	local sayret = nil
	if true then
		全服广播("#cff00ff,"..human:获取名字()..":"..(human.私人变量.S2 or ""))
		return sayret
	end
	return sayret
end
function call_6(human)--系统功能\后台管理@管理
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C ┆

#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆

#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆

#u#lc0000ff:15,#cffff00,[赌场设置]#L#U#C ┆

#u#lc0000ff:16,#cffff00,[开放作弊]#L#U#C ┆

#u#lc0000ff:17,#cffff00,[关闭作弊]#L#U#C ┆

]]
	end
	return sayret
end

function call_16(human)--系统功能\后台管理@开放作弊
	local sayret = nil
	if true then
		全局变量.A15="开"
		human:发送广播("#c00ffff,".."假人作弊开放了")
	end
	return sayret
end

function call_17(human)--系统功能\后台管理@关闭作弊
	local sayret = nil
	if true then
		全局变量.A15="关"
		human:发送广播("#c00ffff,".."假人作弊关闭了")
	end
	return sayret
end

function call_14(human)--系统功能\后台管理@行会攻沙设置
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆#u#lc0000ff:19,#cffff00,将所有行会加入攻城战#L#U#C  #cFF0000,请你想设置的攻沙当天20:00前操作#C
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C ┆#cFF0000,将所有行会加入攻城战后请点击下面的查看详情况确认核对,并去沙看看城门是否正常#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆#u#lc0000ff:20,#cffff00,查看攻沙详情#L#U#C   #u#lc0000ff:21,#cffff00,前往沙巴克#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆
#c00FFFF,[行会攻沙设置]#C-┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_19(human)--系统功能\后台管理@加入攻城战
	local sayret = nil
	if true then
		human:弹出消息框("设置成功！所有行会已加入了攻沙列表！")
		sayret = call_14(human) or sayret--系统功能\后台管理@行会攻沙设置
		return sayret
	end
	return sayret
end

function call_21(human)--系统功能\后台管理@前往沙巴克
	local sayret = nil
	if true then
		human:传送(186,632*48,276*32)
		return sayret
	end
	return sayret
end

function call_20(human)--系统功能\后台管理@查看攻沙详情
	local sayret = nil
	if true then
		sayret = [[
#c00ff00,◆最近的攻城战役预告:#C
战役开始时间： #cff00ff,]]..""..[[#C , 8:00开始。 
#u#lc0000ff:26,#cffff00,◆详细攻城时间表：#L#U#C
#u#lc0000ff:14,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_26(human)--系统功能\后台管理@listwar
	local sayret = nil
	if true then
		sayret = [[
#cff00ff,]]..""..[[#C
#u#lc0000ff:14,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_15(human)--系统功能\后台管理@游戏活动设置
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆#u#lc0000ff:27,#cffff00,[开启赌场]#L#U#C    #u#lc0000ff:28,#cffff00,[关闭赌场]#L#U#C
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C ┆
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#c00FFFF,[游戏活动设置]#C-┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_27(human)--系统功能\后台管理@开启赌场
	local sayret = nil
	if true then
		全局变量.H31=1
		human:发送广播("#c00ffff,".."设置为开启赌场生效！")
		sayret = call_15(human) or sayret--系统功能\后台管理@游戏活动设置
		return sayret
	end
	return sayret
end

function call_28(human)--系统功能\后台管理@关闭赌场
	local sayret = nil
	if true then
		全局变量.H31=0
		human:发送广播("#c00ffff,".."设置为关闭赌场生效！")
		sayret = call_15(human) or sayret--系统功能\后台管理@游戏活动设置
		return sayret
	end
	return sayret
end

function call_13(human)--系统功能\后台管理@开区模式设置
	local sayret = nil
	if (全局变量.G0 or 0)==0 and true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C ┆当前服务器处于：[正式]开区模式！
#c00FFFF,[开区模式设置]#C-┆
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆#u#lc0000ff:29,#cffff00,设置为测试开区模式#L#U#C
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	elseif true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C ┆当前服务器处于：[测试]开区模式！
#c00FFFF,[开区模式设置]#C-┆
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆#u#lc0000ff:30,#cffff00,设置为正式开区模式#L#U#C
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_29(human)--系统功能\后台管理@设置为测试
	local sayret = nil
	if true then
		全局变量.G0=1
		human:发送广播("#c00ffff,".."设置为测试开区模式生效！")
		sayret = call_13(human) or sayret--系统功能\后台管理@开区模式设置
		return sayret
	end
	return sayret
end

function call_30(human)--系统功能\后台管理@设置为正式
	local sayret = nil
	if true then
		全局变量.G0=0
		human:发送广播("#c00ffff,".."设置为正式开区模式生效！")
		sayret = call_13(human) or sayret--系统功能\后台管理@开区模式设置
		return sayret
	end
	return sayret
end

function call_12(human)--系统功能\后台管理@属性修改设置
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#c00FFFF,[属性修改设置]#C-┆       #u#lc0000ff:31,#cffff00,项链+属性#L#U#C       #u#lc0000ff:32,#cffff00,武器+属性#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆       #u#lc0000ff:33,#cffff00,手镯+属性#L#U#C       #u#lc0000ff:34,#cffff00,衣服+属性#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆　　　 #u#lc0000ff:35,#cffff00,戒指+属性#L#U#C       #u#lc0000ff:36,#cffff00,头盔+属性#L#U#C
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆　　　 #u#lc0000ff:37,#cffff00,勋章+属性#L#U#C
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆       #u#lc0000ff:38,#cffff00,改变性别#L#U#C
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_38(human)--系统功能\后台管理@改变性别
	local sayret = nil
	if human:获取性别()==1 and true then
		sayret = call_39(human) or sayret--系统功能\后台管理@towoman
	elseif true then
		sayret = call_40(human) or sayret--系统功能\后台管理@toman
	end
	return sayret
end

function call_40(human)--系统功能\后台管理@toman
	local sayret = nil
	if true then
		sayret = call_12(human) or sayret--系统功能\后台管理@属性修改设置
		return sayret
	end
	return sayret
end

function call_39(human)--系统功能\后台管理@towoman
	local sayret = nil
	if true then
		sayret = call_12(human) or sayret--系统功能\后台管理@属性修改设置
		return sayret
	end
	return sayret
end

function call_37(human)--系统功能\后台管理@sx7
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C-┆     #u#lc0000ff:41,#cffff00,勋章攻击#L#U#C  #u#lc0000ff:42,#cffff00,勋章魔法#L#U#C  #u#lc0000ff:43,#cffff00,勋章道术#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆     #u#lc0000ff:44,#cffff00,勋章防御#L#U#C  #u#lc0000ff:45,#cffff00,勋章魔御#L#U#C  #u#lc0000ff:46,#cffff00,勋章持久#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_41(human)--系统功能\后台管理@勋章攻击
	local sayret = nil
	if true then
		human:装备属性升级(9,8,0,1,0)
		sayret = call_37(human) or sayret--系统功能\后台管理@sx7
		return sayret
	end
	return sayret
end

function call_42(human)--系统功能\后台管理@勋章魔法
	local sayret = nil
	if true then
		human:装备属性升级(9,10,0,1,0)
		sayret = call_37(human) or sayret--系统功能\后台管理@sx7
		return sayret
	end
	return sayret
end

function call_43(human)--系统功能\后台管理@勋章道术
	local sayret = nil
	if true then
		human:装备属性升级(9,12,0,1,0)
		sayret = call_37(human) or sayret--系统功能\后台管理@sx7
		return sayret
	end
	return sayret
end

function call_44(human)--系统功能\后台管理@勋章防御
	local sayret = nil
	if true then
		human:装备属性升级(9,4,0,1,0)
		sayret = call_37(human) or sayret--系统功能\后台管理@sx7
		return sayret
	end
	return sayret
end

function call_45(human)--系统功能\后台管理@勋章魔御
	local sayret = nil
	if true then
		human:装备属性升级(9,6,0,1,0)
		sayret = call_37(human) or sayret--系统功能\后台管理@sx7
		return sayret
	end
	return sayret
end

function call_46(human)--系统功能\后台管理@勋章持久
	local sayret = nil
	if true then
		human:装备属性升级(9,0,0,1,0)
		sayret = call_37(human) or sayret--系统功能\后台管理@sx7
		return sayret
	end
	return sayret
end

function call_34(human)--系统功能\后台管理@sx5
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C-┆     #u#lc0000ff:47,#cffff00,衣服攻击#L#U#C  #u#lc0000ff:48,#cffff00,衣服魔法#L#U#C  #u#lc0000ff:49,#cffff00,衣服道术#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆     #u#lc0000ff:50,#cffff00,衣服防御#L#U#C  #u#lc0000ff:51,#cffff00,衣服魔御#L#U#C  #u#lc0000ff:52,#cffff00,衣服持久#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_47(human)--系统功能\后台管理@衣服攻击
	local sayret = nil
	if true then
		human:装备属性升级(2,8,0,1,0)
		sayret = call_34(human) or sayret--系统功能\后台管理@sx5
		return sayret
	end
	return sayret
end

function call_48(human)--系统功能\后台管理@衣服魔法
	local sayret = nil
	if true then
		human:装备属性升级(2,10,0,1,0)
		sayret = call_34(human) or sayret--系统功能\后台管理@sx5
		return sayret
	end
	return sayret
end

function call_49(human)--系统功能\后台管理@衣服道术
	local sayret = nil
	if true then
		human:装备属性升级(2,12,0,1,0)
		sayret = call_34(human) or sayret--系统功能\后台管理@sx5
		return sayret
	end
	return sayret
end

function call_50(human)--系统功能\后台管理@衣服防御
	local sayret = nil
	if true then
		human:装备属性升级(2,4,0,1,0)
		sayret = call_34(human) or sayret--系统功能\后台管理@sx5
		return sayret
	end
	return sayret
end

function call_51(human)--系统功能\后台管理@衣服魔御
	local sayret = nil
	if true then
		human:装备属性升级(2,6,0,1,0)
		sayret = call_34(human) or sayret--系统功能\后台管理@sx5
		return sayret
	end
	return sayret
end

function call_52(human)--系统功能\后台管理@衣服持久
	local sayret = nil
	if true then
		human:装备属性升级(2,0,0,1,0)
		sayret = call_34(human) or sayret--系统功能\后台管理@sx5
		return sayret
	end
	return sayret
end

function call_32(human)--系统功能\后台管理@sx4
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C-┆     #u#lc0000ff:53,#cffff00,武器+攻击#L#U#C  #u#lc0000ff:54,#cffff00,武器+魔法#L#U#C  #u#lc0000ff:55,#cffff00,武器+道术#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆     #u#lc0000ff:56,#cffff00,武器+幸运#L#U#C  #u#lc0000ff:57,#cffff00,武器+准确#L#U#C  #u#lc0000ff:58,#cffff00,武器+持久#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆     #u#lc0000ff:59,#cffff00,武器+速度#L#U#C
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆　　 注意:攻击速度+1必须要点10次武器
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆　　 速度后才能正常增加!否则是减速度!
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_53(human)--系统功能\后台管理@武器+攻击
	local sayret = nil
	if true then
		human:装备属性升级(1,8,0,1,0)
		sayret = call_32(human) or sayret--系统功能\后台管理@sx4
		return sayret
	end
	return sayret
end

function call_54(human)--系统功能\后台管理@武器+魔法
	local sayret = nil
	if true then
		human:装备属性升级(1,10,0,1,0)
		sayret = call_32(human) or sayret--系统功能\后台管理@sx4
		return sayret
	end
	return sayret
end

function call_55(human)--系统功能\后台管理@武器+道术
	local sayret = nil
	if true then
		human:装备属性升级(1,12,0,1,0)
		sayret = call_32(human) or sayret--系统功能\后台管理@sx4
		return sayret
	end
	return sayret
end

function call_56(human)--系统功能\后台管理@武器+幸运
	local sayret = nil
	if true then
		human:装备属性升级(1,13,0,1,0)
		sayret = call_32(human) or sayret--系统功能\后台管理@sx4
		return sayret
	end
	return sayret
end

function call_58(human)--系统功能\后台管理@武器+持久
	local sayret = nil
	if true then
		human:装备属性升级(1,0,0,1,0)
		sayret = call_32(human) or sayret--系统功能\后台管理@sx4
		return sayret
	end
	return sayret
end

function call_57(human)--系统功能\后台管理@武器+准确
	local sayret = nil
	if true then
		human:装备属性升级(1,14,0,1,0)
		sayret = call_32(human) or sayret--系统功能\后台管理@sx4
		return sayret
	end
	return sayret
end

function call_59(human)--系统功能\后台管理@武器+速度
	local sayret = nil
	if true then
		human:装备属性升级(1,21,0,1,0)
		sayret = call_32(human) or sayret--系统功能\后台管理@sx4
		return sayret
	end
	return sayret
end

function call_31(human)--系统功能\后台管理@sx1
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C-┆     #u#lc0000ff:60,#cffff00,项链攻击#L#U#C  #u#lc0000ff:61,#cffff00,项链魔法#L#U#C  #u#lc0000ff:62,#cffff00,项链道术#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆     #u#lc0000ff:63,#cffff00,项链幸运#L#U#C  #u#lc0000ff:64,#cffff00,项链准确#L#U#C  #u#lc0000ff:65,#cffff00,项链持久#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆     注意:准确或魔法躲避，根据项链不同而不同
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆     加幸运或加敏捷，根据项链不同而不同
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_64(human)--系统功能\后台管理@项链准确
	local sayret = nil
	if true then
		human:装备属性升级(4,17,0,1,0)
		sayret = call_31(human) or sayret--系统功能\后台管理@sx1
		return sayret
	end
	return sayret
end

function call_63(human)--系统功能\后台管理@项链幸运
	local sayret = nil
	if true then
		human:装备属性升级(4,13,0,1,0)
		sayret = call_31(human) or sayret--系统功能\后台管理@sx1
		return sayret
	end
	return sayret
end

function call_60(human)--系统功能\后台管理@项链攻击
	local sayret = nil
	if true then
		human:装备属性升级(4,8,0,1,0)
		sayret = call_31(human) or sayret--系统功能\后台管理@sx1
		return sayret
	end
	return sayret
end

function call_61(human)--系统功能\后台管理@项链魔法
	local sayret = nil
	if true then
		human:装备属性升级(4,10,0,1,0)
		sayret = call_31(human) or sayret--系统功能\后台管理@sx1
		return sayret
	end
	return sayret
end

function call_62(human)--系统功能\后台管理@项链道术
	local sayret = nil
	if true then
		human:装备属性升级(4,12,0,1,0)
		sayret = call_31(human) or sayret--系统功能\后台管理@sx1
		return sayret
	end
	return sayret
end

function call_65(human)--系统功能\后台管理@项链持久
	local sayret = nil
	if true then
		human:装备属性升级(4,0,0,1,0)
		sayret = call_31(human) or sayret--系统功能\后台管理@sx1
		return sayret
	end
	return sayret
end

function call_36(human)--系统功能\后台管理@sx6
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C-┆     #u#lc0000ff:66,#cffff00,头盔攻击#L#U#C  #u#lc0000ff:67,#cffff00,头盔魔法#L#U#C  #u#lc0000ff:68,#cffff00,头盔道术#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆     #u#lc0000ff:69,#cffff00,头盔防御#L#U#C  #u#lc0000ff:70,#cffff00,头盔魔御#L#U#C  #u#lc0000ff:71,#cffff00,头盔持久#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_66(human)--系统功能\后台管理@头盔攻击
	local sayret = nil
	if true then
		human:装备属性升级(3,8,0,1,0)
		sayret = call_36(human) or sayret--系统功能\后台管理@sx6
		return sayret
	end
	return sayret
end

function call_67(human)--系统功能\后台管理@头盔魔法
	local sayret = nil
	if true then
		human:装备属性升级(3,10,0,1,0)
		sayret = call_36(human) or sayret--系统功能\后台管理@sx6
		return sayret
	end
	return sayret
end

function call_68(human)--系统功能\后台管理@头盔道术
	local sayret = nil
	if true then
		human:装备属性升级(3,12,0,1,0)
		sayret = call_36(human) or sayret--系统功能\后台管理@sx6
		return sayret
	end
	return sayret
end

function call_69(human)--系统功能\后台管理@头盔防御
	local sayret = nil
	if true then
		human:装备属性升级(3,4,0,1,0)
		sayret = call_36(human) or sayret--系统功能\后台管理@sx6
		return sayret
	end
	return sayret
end

function call_70(human)--系统功能\后台管理@头盔魔御
	local sayret = nil
	if true then
		human:装备属性升级(3,6,0,1,0)
		sayret = call_36(human) or sayret--系统功能\后台管理@sx6
		return sayret
	end
	return sayret
end

function call_71(human)--系统功能\后台管理@头盔持久
	local sayret = nil
	if true then
		human:装备属性升级(3,0,0,1,0)
		sayret = call_36(human) or sayret--系统功能\后台管理@sx6
		return sayret
	end
	return sayret
end

function call_35(human)--系统功能\后台管理@sx3
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C-┆     #u#lc0000ff:72,#cffff00,左戒攻击#L#U#C     #u#lc0000ff:73,#cffff00,右戒攻击#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆     #u#lc0000ff:74,#cffff00,左戒魔法#L#U#C     #u#lc0000ff:75,#cffff00,右戒魔法#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆     #u#lc0000ff:76,#cffff00,左戒道术#L#U#C     #u#lc0000ff:77,#cffff00,右戒道术#L#U#C
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆　　 #u#lc0000ff:78,#cffff00,左戒防御#L#U#C     #u#lc0000ff:79,#cffff00,右戒防御#L#U#C
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆　　 #u#lc0000ff:80,#cffff00,左戒魔御#L#U#C     #u#lc0000ff:81,#cffff00,右戒魔御#L#U#C
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆　　 #u#lc0000ff:82,#cffff00,左戒持久#L#U#C     #u#lc0000ff:83,#cffff00,右戒持久#L#U#C
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_72(human)--系统功能\后台管理@左戒攻击
	local sayret = nil
	if true then
		human:装备属性升级(6,8,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_74(human)--系统功能\后台管理@左戒魔法
	local sayret = nil
	if true then
		human:装备属性升级(6,10,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_76(human)--系统功能\后台管理@左戒道术
	local sayret = nil
	if true then
		human:装备属性升级(6,12,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_78(human)--系统功能\后台管理@左戒防御
	local sayret = nil
	if true then
		human:装备属性升级(6,4,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_80(human)--系统功能\后台管理@左戒魔御
	local sayret = nil
	if true then
		human:装备属性升级(6,6,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_82(human)--系统功能\后台管理@左戒持久
	local sayret = nil
	if true then
		human:装备属性升级(6,0,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_73(human)--系统功能\后台管理@右戒攻击
	local sayret = nil
	if true then
		human:装备属性升级(15,8,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_75(human)--系统功能\后台管理@右戒魔法
	local sayret = nil
	if true then
		human:装备属性升级(15,10,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_77(human)--系统功能\后台管理@右戒道术
	local sayret = nil
	if true then
		human:装备属性升级(15,10,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_79(human)--系统功能\后台管理@右戒防御
	local sayret = nil
	if true then
		human:装备属性升级(15,4,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_81(human)--系统功能\后台管理@右戒魔御
	local sayret = nil
	if true then
		human:装备属性升级(15,6,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_83(human)--系统功能\后台管理@右戒持久
	local sayret = nil
	if true then
		human:装备属性升级(15,0,0,1,0)
		sayret = call_35(human) or sayret--系统功能\后台管理@sx3
		return sayret
	end
	return sayret
end

function call_33(human)--系统功能\后台管理@sx2
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:18,#cffff00,[等待添加设置]#L#U#C ┆
#u#lc0000ff:12,#cffff00,[属性修改设置]#L#U#C-┆     #u#lc0000ff:84,#cffff00,左手攻击#L#U#C     #u#lc0000ff:85,#cffff00,右手攻击#L#U#C
#u#lc0000ff:13,#cffff00,[开区模式设置]#L#U#C ┆     #u#lc0000ff:86,#cffff00,左手魔法#L#U#C     #u#lc0000ff:87,#cffff00,右手魔法#L#U#C
#u#lc0000ff:22,#cffff00,[等待添加设置]#L#U#C ┆     #u#lc0000ff:88,#cffff00,左手道术#L#U#C     #u#lc0000ff:89,#cffff00,右手道术#L#U#C
#u#lc0000ff:23,#cffff00,[等待添加设置]#L#U#C ┆　　 #u#lc0000ff:90,#cffff00,左手防御#L#U#C     #u#lc0000ff:91,#cffff00,右手防御#L#U#C
#u#lc0000ff:14,#cffff00,[行会攻沙设置]#L#U#C ┆　　 #u#lc0000ff:92,#cffff00,左手魔御#L#U#C     #u#lc0000ff:93,#cffff00,右手魔御#L#U#C
#u#lc0000ff:24,#cffff00,[等待添加设置]#L#U#C ┆　　 #u#lc0000ff:94,#cffff00,左手持久#L#U#C     #u#lc0000ff:95,#cffff00,右手持久#L#U#C
#u#lc0000ff:15,#cffff00,[游戏活动设置]#L#U#C ┆
#u#lc0000ff:25,#cffff00,[等待添加设置]#L#U#C ┆
]]
	end
	return sayret
end

function call_84(human)--系统功能\后台管理@左手攻击
	local sayret = nil
	if true then
		human:装备属性升级(5,8,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_86(human)--系统功能\后台管理@左手魔法
	local sayret = nil
	if true then
		human:装备属性升级(5,10,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_88(human)--系统功能\后台管理@左手道术
	local sayret = nil
	if true then
		human:装备属性升级(5,12,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_90(human)--系统功能\后台管理@左手防御
	local sayret = nil
	if true then
		human:装备属性升级(5,4,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_92(human)--系统功能\后台管理@左手魔御
	local sayret = nil
	if true then
		human:装备属性升级(5,6,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_94(human)--系统功能\后台管理@左手持久
	local sayret = nil
	if true then
		human:装备属性升级(5,0,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_85(human)--系统功能\后台管理@右手攻击
	local sayret = nil
	if true then
		human:装备属性升级(14,8,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_87(human)--系统功能\后台管理@右手魔法
	local sayret = nil
	if true then
		human:装备属性升级(14,10,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_89(human)--系统功能\后台管理@右手道术
	local sayret = nil
	if true then
		human:装备属性升级(14,12,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_91(human)--系统功能\后台管理@右手防御
	local sayret = nil
	if true then
		human:装备属性升级(14,4,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_93(human)--系统功能\后台管理@右手魔御
	local sayret = nil
	if true then
		human:装备属性升级(14,6,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end

function call_95(human)--系统功能\后台管理@右手持久
	local sayret = nil
	if true then
		human:装备属性升级(14,0,0,1,0)
		sayret = call_33(human) or sayret--系统功能\后台管理@sx2
		return sayret
	end
	return sayret
end
function call_7(human)--系统功能\帮助命令@帮助命令
	local sayret = nil
	if true then
		sayret = [[
问题综合解答： 
#u#lc0000ff:96,#cffff00,如何赚取传奇币?#L#U#C    #u#lc0000ff:97,#cffff00,祖玛阁怎么走法?#L#U#C    #u#lc0000ff:98,#cffff00,王者禁地怎么走?#L#U#C
#u#lc0000ff:99,#cffff00,35级书在那里打?#L#U#C    #u#lc0000ff:100,#cffff00,荣誉勋章那里爆?#L#U#C    #u#lc0000ff:101,#cffff00,沙藏宝阁怎么走?#L#U#C
#u#lc0000ff:102,#cffff00,赤月入口的坐标?#L#U#C    #u#lc0000ff:103,#cffff00,圣战装备那里打?#L#U#C    #u#lc0000ff:104,#cffff00,未知暗殿怎么走?#L#U#C
#u#lc0000ff:105,#cffff00,石墓阵详细走法?#L#U#C    #u#lc0000ff:106,#cffff00,新衣服在那里爆?#L#U#C    #u#lc0000ff:107,#cffff00,屠龙怒斩那里爆?#L#U#C
#u#lc0000ff:108,#cffff00,金钻有什么功能?#L#U#C    #u#lc0000ff:109,#cffff00,元宝怎么去冲值?#L#U#C    #u#lc0000ff:110,#cffff00,合区后密码错误?#L#U#C
#u#lc0000ff:111,#cffff00,烟花之地怎么进?#L#U#C
]]
	end
	return sayret
end

function call_111(human)--系统功能\帮助命令@wentig
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C:烟花之地怎么进? 
#cFFFF00,答#C:在商铺元宝购买"九珠连环炮"放完随机进入. 
里面刷烟花恶魔、金刚、血魔。各爆三职业赤月装备.
-----------------------------------------------------------
注：刷怪时间#cFF0000,30分钟#C一刷 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_110(human)--系统功能\帮助命令@wentif
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C:由于合区后部分帐号重复,(如:1区和2区ID一样合区了),
就会导致密码错误或者角色人物是游戏小号等!!
#cFFFF00,答#C: 在帐号后面+字母a,比如:合区前帐号:123456  合区后
登陆发现密码错误,就在帐号后面+a登陆,如果不对就+b...c....
加到你要找的号为止!密码不变!!
-----------------------------------------------------------
#c00ff00,注意#C:如果帐号位数10个已满加不了字母,请把帐号最后一位删除再+a.
比如:帐号1234567890→123456789a!! 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_98(human)--系统功能\帮助命令@wentiC
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 王者禁地怎么走? 
#cFFFF00,答#C: 入口：传送到幻境，身后有#cFF0000,一小门#C进入幻境二层北
　  幻境二层北：坐标 31,193  进入幻境四层北
　  幻境四层北：坐标 42,19   进入幻境五层北
　  幻境五层北：坐标 163,23  进入王者禁地
　  怪物：六大暗之教主,重装使者 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_101(human)--系统功能\帮助命令@wentiD
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 沙藏宝阁怎么走? 
#cFFFF00,答#C: 可以从#cFF0000,幻境10层#C坐标:370.376
　  的神秘老人那进入 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_104(human)--系统功能\帮助命令@wentiE
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 未知暗殿怎么走? 
#cFFFF00,答#C: 可以从土彩票员直接进入!!! 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_96(human)--系统功能\帮助命令@wenti1
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 没有钱怎么办? 
#cFFFF00,答#C: 传奇币可以挖肉(一块肉可卖3000左右),或者矿区 
　  挖矿(矿的价格5000-10000,一次就可以挖10多万) 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_99(human)--系统功能\帮助命令@wenti2
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 35级的书在那打? 
#cFFFF00,答#C: 35级前的书全部在书店内能买到,35级的书可到尸王殿打
　  尸王爆率,爆率为1/30. 
附: 尸王殿从矿区过--废矿区东部-坐标:137,107 (僵尸爬出的洞)进入 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_102(human)--系统功能\帮助命令@wenti3
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 赤月怎么走法? 
#cFFFF00,答#C: 赤月峡谷东走廊,坐标:123,24
　  赤月峡谷东二层,坐标:13,26
　  抉择之地   坐标:217,133 (山谷秘道1)
　  抉择之地   坐标:146,110 (山谷秘道2)
　  山谷秘道1  坐标:140,23  (赤月魔穴)
　  山谷秘道2  坐标:178,53  (恶魔祭坛) 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_105(human)--系统功能\帮助命令@wenti4
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 石墓七怎么走? 
#cFFFF00,答#C: 从猪五下到石墓,然后走右上的门,然后进去出来反复三次  
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_108(human)--系统功能\帮助命令@wenti5
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 金钻有什么功能? 
#cFFFF00,答#C: 各地图中层飞跃如：祖玛七，新衣服六地方等等
　  每天可以领取50万及相应20-30元宝的小礼物 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_97(human)--系统功能\帮助命令@wenti6
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 祖玛七怎么走? 
#cFFFF00,答#C: 进入祖玛阁后,左、上、上、上、右 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_107(human)--系统功能\帮助命令@wenti7
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 屠龙怒斩那爆? 
#cFFFF00,答#C: 屠龙,嗜魂可以在赤月恶魔,祖玛教主处爆
　  怒斩,龙牙,逍遥扇,牛魔王,暗之牛魔王爆 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_103(human)--系统功能\帮助命令@wenti8
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 三圣装备那打? 
#cFFFF00,答#C: 赤月恶魔,双头血魔,双头金刚 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_106(human)--系统功能\帮助命令@wenti9
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 新衣服在那爆? 
#cFFFF00,答#C: 钳虫巢穴　　白日门　　　343 325
　  死亡神殿  　封魔谷　　　205,218
　  地狱烈焰  　比奇省　　　428,474
　  深渊魔域  　沃玛森林　　215,312 
　  堕落坟场  　沃玛森林　　320,56
　  困惑殿堂  　世外桃园　　55,94 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_109(human)--系统功能\帮助命令@wenti0
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 元宝怎么冲值? 
#cFFFF00,答#C: 1:　可以使用手机短信自动冲值，请查看土城“元宝服务中心”
　  　→在线冲值→编辑短信冲值
　  2:　可以通过固定电话，神洲行缴费卡，网上银行等进行冲值。
　　　请登陆我们的网站: #cff00ff,]]..Config.WEBSITE..[[#C 元宝购买内在线冲值
　  3:　直接先进银行汇款冲值，请直接联系本传奇客服QQ:#cff00ff,]]..""..[[#C
　　　汇款现金冲值由于省去手续费，将额外赠送20%
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end

function call_100(human)--系统功能\帮助命令@wentia
	local sayret = nil
	if true then
		sayret = [[
#cFF0000,问#C: 勋章在那里出? 
#cFFFF00,答#C: 新版删除圣域，勋章可以到比奇城,坐标417.244
　  　进入，武馆教头那换取
　  　还可以从比奇坐标:107.416处进入圣域获得 
#u#lc0000ff:112,#cffff00,返回#L#U#C
]]
	end
	return sayret
end
function call_9(human)--系统功能\二号后台@二号后台
	local sayret = nil
	if (全局变量.A15 or "")=="开" and true then
		sayret = [[
 
#u#lc0000ff:113,#cffff00,挂机杀怪#L#U#C 
 
]]
	elseif true then
		human:弹出消息框("本指令拒绝为你服务！")
	end
	return sayret
end

function call_113(human)--系统功能\二号后台@杀怪A
	local sayret = nil
	if true then
		sayret = [[
恭喜你离线挂机打怪设置成功你现在可以安全离线了！
]]
	end
	return sayret
end
function call_1(human)--系统功能\封号设置@封号设置
	local sayret = nil
	if (human.m_db.私人变量._300 or 0)==1 and true then
		human:更改名字颜色(0xFF00FE)
	end
	if human:获取等级()==0 and true then
		human.私人变量.S1="═══市井小民═══\\"
	end
	if human:获取等级()==44 and true then
		human.私人变量.S1="═══⑨品知县═══\\"
	end
	if human:获取等级()==45 and true then
		human.私人变量.S1="═══⑧品知府═══\\"
	end
	if human:获取等级()==46 and true then
		human.私人变量.S1="═══⑦品太守═══\\"
	end
	if human:获取等级()==47 and true then
		human.私人变量.S1="═══⑥品巡抚═══\\"
	end
	if human:获取等级()==48 and true then
		human.私人变量.S1="═══⑤品提督═══\\"
	end
	if human:获取等级()==49 and true then
		human.私人变量.S1="═══④品总督═══\\"
	end
	if human:获取等级()==50 and true then
		human.私人变量.S1="═══③品尚书═══\\"
	end
	if human:获取等级()==51 and true then
		human.私人变量.S1="═══②品太傅═══\\"
	end
	if human:获取等级()==52 and true then
		human.私人变量.S1="═══①统天下═══\\"
	end
	if human:获取等级()>0 and true then
		return sayret
	end
	return sayret
end
function call_2(human)--系统功能\庆典蛋糕@庆典蛋糕
	local sayret = nil
	if true then
		human.私人变量.M3=实用工具.SumString((human.私人变量.M3 or 0),2)
		全服广播("#cff00ff,".."["..human:获取名字().."]在:"..human:当前地图名字()..""..human:当前位置X()..":"..human:当前位置Y().."处放庆典蛋糕、大家快去欣赏哦。")
		延时执行(human,2000,"114",-2)--@庆典蛋糕1
	elseif true then
		human.私人变量.M3=0
		取消延时执行(human)
	end
	return sayret
end

function call_114(human)--系统功能\庆典蛋糕@庆典蛋糕1
	local sayret = nil
	if (human.私人变量.M3 or 0)<60 and true then
		human.私人变量.M3=实用工具.SumString((human.私人变量.M3 or 0),2)
		延时执行(human,2000,"115",-2)--@庆典蛋糕2
	elseif true then
		human.私人变量.M3=0
		取消延时执行(human)
	end
	return sayret
end

function call_115(human)--系统功能\庆典蛋糕@庆典蛋糕2
	local sayret = nil
	if (human.私人变量.M3 or 0)<60 and true then
		human.私人变量.M3=实用工具.SumString((human.私人变量.M3 or 0),2)
		延时执行(human,2000,"116",-2)--@庆典蛋糕3
	elseif true then
		human.私人变量.M3=0
		取消延时执行(human)
	end
	return sayret
end

function call_116(human)--系统功能\庆典蛋糕@庆典蛋糕3
	local sayret = nil
	if (human.私人变量.M3 or 0)<60 and true then
		human.私人变量.M3=实用工具.SumString((human.私人变量.M3 or 0),2)
		延时执行(human,2000,"117",-2)--@庆典蛋糕4
	elseif true then
		human.私人变量.M3=0
		取消延时执行(human)
	end
	return sayret
end

function call_117(human)--系统功能\庆典蛋糕@庆典蛋糕4
	local sayret = nil
	if (human.私人变量.M3 or 0)<60 and true then
		human.私人变量.M3=实用工具.SumString((human.私人变量.M3 or 0),2)
		延时执行(human,2000,"118",-2)--@庆典蛋糕5
	elseif true then
		human.私人变量.M3=0
		取消延时执行(human)
	end
	return sayret
end

function call_118(human)--系统功能\庆典蛋糕@庆典蛋糕5
	local sayret = nil
	if (human.私人变量.M3 or 0)<60 and true then
		human.私人变量.M3=实用工具.SumString((human.私人变量.M3 or 0),2)
		延时执行(human,2000,"119",-2)--@庆典蛋糕6
	elseif true then
		human.私人变量.M3=0
		取消延时执行(human)
	end
	return sayret
end

function call_119(human)--系统功能\庆典蛋糕@庆典蛋糕6
	local sayret = nil
	if (human.私人变量.M3 or 0)<60 and true then
		human.私人变量.M3=实用工具.SumString((human.私人变量.M3 or 0),2)
		延时执行(human,2000,"2",-2)--@庆典蛋糕
	elseif true then
		human.私人变量.M3=0
		取消延时执行(human)
	end
	return sayret
end
function call_8(human)--系统功能\金钻会员@金钻会员
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:120,#cffff00,尸 王 殿#L#U#C    #u#lc0000ff:121,#cffff00,生死之间#L#U#C    #u#lc0000ff:122,#cffff00,沃玛三层#L#U#C    #u#lc0000ff:123,#cffff00,石 墓 阵#L#U#C
#u#lc0000ff:124,#cffff00,祖玛七层#L#U#C    #u#lc0000ff:125,#cffff00,牛魔六层#L#U#C    #u#lc0000ff:126,#cffff00,霸者大厅#L#U#C    #u#lc0000ff:127,#cffff00,未知暗殿#L#U#C
#u#lc0000ff:128,#cffff00,幻境七层#L#U#C    #u#lc0000ff:129,#cffff00,沙藏宝阁#L#U#C    #u#lc0000ff:130,#cffff00,王者禁地#L#U#C    #u#lc0000ff:131,#cffff00,圣域之门#L#U#C
#u#lc0000ff:132,#cffff00,恶魔祭坛#L#U#C    #u#lc0000ff:133,#cffff00,赤月老巢#L#U#C    #u#lc0000ff:134,#cffff00,万恶之源#L#U#C    #u#lc0000ff:135,#cffff00,六新衣服#L#U#C
#u#lc0000ff:136,#cffff00,去幻境三层练级#L#U#C    #u#lc0000ff:137,#cffff00,幽冥领地#L#U#C    #u#lc0000ff:138,#cffff00,镜像殿堂#L#U#C
]]
	end
	return sayret
end

function call_136(human)--系统功能\金钻会员@幻境
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:随机传送(376)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:随机传送(376)
		return sayret
	end
	return sayret
end

function call_138(human)--系统功能\金钻会员@镜像
	local sayret = nil
	if human:检查物品数量(10137,1) and human:获取金币()>=500000 and true then
		human:收回物品(10002,500000)
		human:随机传送(469)
		return sayret
	end
	if human:获取金币()>=500000 and true then
		human:收回物品(10002,500000)
		human:获得物品(10137,1)
		human:随机传送(469)
		return sayret
	elseif true then
		sayret = [[
你没有500000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_134(human)--系统功能\金钻会员@传送20
	local sayret = nil
	if human:获取金币()>=100000 and human:检查物品数量(10137,1) and true then
		human:收回物品(10002,100000)
		human:随机传送(457)
		return sayret
	end
	if human:获取金币()>=100000 and true then
		human:获得物品(10137,1)
		human:收回物品(10002,100000)
		human:随机传送(457)
		return sayret
	elseif true then
		sayret = [[
你没有100000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_133(human)--系统功能\金钻会员@传送19
	local sayret = nil
	if human:获取金币()>=100000 and human:检查物品数量(10137,1) and true then
		human:收回物品(10002,100000)
		human:传送(319,139*48,25*32)
		return sayret
	end
	if human:获取金币()>=100000 and true then
		human:获得物品(10137,1)
		human:收回物品(10002,100000)
		human:传送(319,139*48,25*32)
		return sayret
	elseif true then
		sayret = [[
你没有100000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_132(human)--系统功能\金钻会员@传送18
	local sayret = nil
	if human:获取金币()>=100000 and human:检查物品数量(10137,1) and true then
		human:收回物品(10002,100000)
		human:传送(318,180*48,55*32)
		return sayret
	end
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:获得物品(10137,1)
		human:传送(318,180*48,55*32)
		return sayret
	elseif true then
		sayret = [[
你没有100000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_127(human)--系统功能\金钻会员@传送17
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:随机传送(300)
		return sayret
	elseif true then
		human:随机传送(300)
		human:获得物品(10137,1)
		return sayret
	end
	return sayret
end

function call_131(human)--系统功能\金钻会员@传送21
	local sayret = nil
	if human:获取金币()>=300000 and human:检查物品数量(10137,1) and true then
		human:收回物品(10002,300000)
		human:随机传送(401)
		return sayret
	end
	if human:获取金币()>=300000 and true then
		human:收回物品(10002,300000)
		human:随机传送(401)
		human:获得物品(10137,1)
		return sayret
	elseif true then
		sayret = [[
你没有300000金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_131(human)--系统功能\金钻会员@传送21
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:随机传送(401)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:随机传送(401)
		return sayret
	end
	return sayret
end

function call_139(human)--系统功能\金钻会员@tc
	local sayret = nil
	if true then
		human:传送(186,333*48,333*32)
		return sayret
	end
	return sayret
end

function call_137(human)--系统功能\金钻会员@幽冥
	local sayret = nil
	if human:检查物品数量(10137,1) and human:获取金币()>=500000 and true then
		human:收回物品(10002,500000)
		human:随机传送(458)
		return sayret
	end
	if human:获取金币()>=500000 and true then
		human:获得物品(10137,1)
		human:收回物品(10002,500000)
		human:随机传送(458)
		return sayret
	elseif true then
		sayret = [[
你没有50万金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_120(human)--系统功能\金钻会员@传送05
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:收回物品(10002,10000)
		human:随机传送(301)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:随机传送(301)
		return sayret
	end
	return sayret
end

function call_121(human)--系统功能\金钻会员@传送06
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(280,9*48,51*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(280,9*48,51*32)
		return sayret
	end
	return sayret
end

function call_122(human)--系统功能\金钻会员@传送07
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(164,52*48,366*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(164,52*48,366*32)
		return sayret
	end
	return sayret
end

function call_123(human)--系统功能\金钻会员@传送08
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(235,83*48,81*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(235,83*48,81*32)
		return sayret
	end
	return sayret
end

function call_124(human)--系统功能\金钻会员@传送09
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(220,8*48,10*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(220,8*48,10*32)
		return sayret
	end
	return sayret
end

function call_125(human)--系统功能\金钻会员@传送10
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(372,251*48,250*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(372,251*48,250*32)
		return sayret
	end
	return sayret
end

function call_126(human)--系统功能\金钻会员@传送11
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(343,84*48,85*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(343,84*48,85*32)
		return sayret
	end
	return sayret
end

function call_129(human)--系统功能\金钻会员@传送12
	local sayret = nil
	if human:获取等级()>41 and true then
		human:传送(436,13*48,103*32)
		return sayret
	elseif true then
		sayret = [[
禁止42级以下皇宫
 
#u#lc0000ff:-1,#cffff00,离开#L#U#C
]]
	end
	return sayret
end

function call_140(human)--系统功能\金钻会员@传送13
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(317,171*48,88*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(317,171*48,88*32)
		return sayret
	end
	return sayret
end

function call_128(human)--系统功能\金钻会员@传送14
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(380,161*48,172*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(380,161*48,172*32)
		return sayret
	end
	return sayret
end

function call_130(human)--系统功能\金钻会员@传送15
	local sayret = nil
	if human:检查物品数量(10137,1) and true then
		human:传送(399,135*48,184*32)
		return sayret
	elseif true then
		human:获得物品(10137,1)
		human:传送(399,135*48,184*32)
		return sayret
	end
	return sayret
end

function call_135(human)--系统功能\金钻会员@传送16
	local sayret = nil
	if true then
		sayret = [[
#u#lc0000ff:141,#cffff00,死亡神殿#L#U#C    #u#lc0000ff:142,#cffff00,地狱烈焰#L#U#C    #u#lc0000ff:143,#cffff00,钳虫巢穴#L#U#C
#u#lc0000ff:144,#cffff00,堕落坟场#L#U#C    #u#lc0000ff:145,#cffff00,困惑殿堂#L#U#C    #u#lc0000ff:146,#cffff00,深渊魔域#L#U#C
]]
	end
	return sayret
end

function call_141(human)--系统功能\金钻会员@衣服01
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:获得物品(10137,1)
		human:传送(325,205*48,218*32)
		return sayret
	elseif true then
		sayret = [[
你没有10w金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_142(human)--系统功能\金钻会员@衣服02
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:收回物品(10002,100000)
		human:获得物品(10137,1)
		human:传送(105,428*48,474*32)
		return sayret
	elseif true then
		sayret = [[
你没有10w金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_143(human)--系统功能\金钻会员@衣服03
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:获得物品(10137,1)
		human:收回物品(10002,100000)
		human:传送(302,343*48,325*32)
		return sayret
	elseif true then
		sayret = [[
你没有10w金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_144(human)--系统功能\金钻会员@衣服04
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:获得物品(10137,1)
		human:收回物品(10002,100000)
		human:传送(161,320*48,56*32)
		return sayret
	elseif true then
		sayret = [[
你没有10w金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_145(human)--系统功能\金钻会员@衣服05
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:获得物品(10137,1)
		human:收回物品(10002,100000)
		human:传送(267,55*48,94*32)
		return sayret
	elseif true then
		sayret = [[
你没有10w金币用来支付我们的服务费用!
]]
	end
	return sayret
end

function call_146(human)--系统功能\金钻会员@衣服06
	local sayret = nil
	if human:获取金币()>=100000 and true then
		human:获得物品(10137,1)
		human:收回物品(10002,100000)
		human:传送(161,215*48,312*32)
		return sayret
	elseif true then
		sayret = [[
你没有10w金币用来支付我们的服务费用!
]]
	end
	return sayret
end
