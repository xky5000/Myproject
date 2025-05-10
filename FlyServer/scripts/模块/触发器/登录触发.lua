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

function call_服务启动()
	公共定义.骷髅怪物ID = {2085}
	公共定义.神兽怪物ID = {2160}
	公共定义.神兽变身ID = {2161}
	公共定义.出生地图 = 3001
	公共定义.复活地图 = 3001
	公共定义.元宝充值NPC = {1151,1152}
end

function call_1(human)--@Resume
	local sayret = nil
	if true then
		human:发送广播("#cff00ff,".."　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　因为你上次下线的时候使用了离线挂机功能　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　　管理员为避免你在游戏中出现数据错误　　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　　　　所以请你小退一下再重新登陆　　　　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　")
		human:发送广播("#cff00ff,".."　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　")
		human:踢下线()
		return sayret
	end
	return sayret
end

function call_玩家登录(human)--@Login
	local sayret = nil
	if human:获取等级()>43 and true then
		human.私人变量.XV=0
		human.私人变量.XZ=0
		human.私人变量.XV=取文件内容("杀敌阵亡.txt",human:获取名字(),"XV",type(human.私人变量.XV))
		human.私人变量.XZ=取文件内容("杀敌阵亡.txt",human:获取名字(),"XZ",type(human.私人变量.XZ))
		sayret = call_2(human) or sayret--系统功能\登陆脚本@登陆设置
		sayret = call_3(human) or sayret--系统功能\封号设置@封号设置
		sayret = call_4(human) or sayret--系统功能\爵位属性@爵位属性
		sayret = call_5(human) or sayret--二级密码\密码登陆@密码登陆
		return sayret
	end
	if human:获取等级()>5 and true then
		human.私人变量.XV=0
		human.私人变量.XZ=0
		human.私人变量.XV=取文件内容("杀敌阵亡.txt",human:获取名字(),"XV",type(human.私人变量.XV))
		human.私人变量.XZ=取文件内容("杀敌阵亡.txt",human:获取名字(),"XZ",type(human.私人变量.XZ))
		sayret = call_2(human) or sayret--系统功能\登陆脚本@登陆设置
		sayret = call_3(human) or sayret--系统功能\封号设置@封号设置
		sayret = call_4(human) or sayret--系统功能\爵位属性@爵位属性
		sayret = call_5(human) or sayret--二级密码\密码登陆@密码登陆
		return sayret
	end
	if human:获取等级()>0 and true then
		human.私人变量.XV=0
		human.私人变量.XZ=0
		human.私人变量.XV=取文件内容("杀敌阵亡.txt",human:获取名字(),"XV",type(human.私人变量.XV))
		human.私人变量.XZ=取文件内容("杀敌阵亡.txt",human:获取名字(),"XZ",type(human.私人变量.XZ))
		sayret = call_2(human) or sayret--系统功能\登陆脚本@登陆设置
		sayret = call_3(human) or sayret--系统功能\封号设置@封号设置
		sayret = call_4(human) or sayret--系统功能\爵位属性@爵位属性
		sayret = call_5(human) or sayret--二级密码\密码登陆@密码登陆
	end
	return sayret
end

function call_抢庄开始(human)--@抢庄开始
	local sayret = nil

	return sayret
end

function call_抢庄结束(human)--@抢庄结束
	local sayret = nil

	return sayret
end

function call_下注开始(human)--@下注开始
	local sayret = nil

	return sayret
end

function call_下注结束(human)--@下注结束
	local sayret = nil

	return sayret
end

function call_猜点开始(human)--@猜点开始
	local sayret = nil

	return sayret
end

function call_6(human)--@ZZNEW
	local sayret = nil

	return sayret
end

function call_赌博结帐(human)--@赌博结帐
	local sayret = nil

	return sayret
end

function call_赌博清零(human)--@赌博清零
	local sayret = nil

	return sayret
end

function call_定时器_3(human)--@OnTimer3
	local sayret = nil
	if human:是否在地图(104) and true then
		human:发送广播("#c00ffff,".."15秒内未输入密码，系统让你强制退出！")
		human:踢下线()
		return sayret
	elseif true then
		延时执行(human,1,"7",-3)--@条件不足
	end
	return sayret
end

function call_7(human)--@条件不足
	local sayret = nil
	if human:是否在地图(104) and true then
	elseif true then
	end
	return sayret
end
function call_3(human)--系统功能\封号设置@封号设置
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
	
	--human:显示称号(1,8,-40,-70)
	return sayret
end
function call_5(human)--二级密码\密码登陆@密码登陆
	local sayret = nil
	if 在文件列表("密码名单.txt",human:获取名字())>=0 and true then
		sayret = call_8(human) or sayret--二级密码\密码登陆@检测IP
	elseif true then
		human:发送广播("#c00ff00,".."〖提示〗你还没有设置2级密码,及时去土城[340.342]设置!")
		human:发送广播("#c00ff00,".."〖提示〗你还没有设置2级密码,及时去土城[340.342]设置!")
		human:发送广播("#c00ff00,".."〖提示〗你还没有设置2级密码,及时去土城[340.342]设置!")
		human:发送广播("#c00ff00,".."〖提示〗你还没有设置2级密码,及时去土城[340.342]设置!")
		human:发送广播("#c00ff00,".."〖提示〗你还没有设置2级密码,及时去土城[340.342]设置!")
	end
	return sayret
end

function call_8(human)--二级密码\密码登陆@检测ip
	local sayret = nil
	if true then
		human:发送广播("#c00ff00,".."〖提示〗当前IP为安全IP!祝你游戏愉快!")
	elseif true then
		human.私人变量.二级密码=0
		human.私人变量.二级密码=取文件内容("密码数据.txt",human:获取名字(),"二级密码",type(human.私人变量.二级密码))
		human:随机传送(104)
	end
	return sayret
end
function call_2(human)--系统功能\登陆脚本@登陆设置
	local sayret = nil
	if human:是否管理员() and true then
		human:管理模式(0,1,0)
		human:管理模式(71,1,0)
		human:管理模式(73,1,0)
		human:发送广播("#cff00ff,"..human:获取名字().."管理员,当前在线人数"..检查在线人数().."人")
	end
	if (全局变量.H30 or 0)==0 and true then
		全局变量.H30=5
	end
	if human.是否新人 and human:获取职业()==1 and true then
		全服广播("#cff00ff,".."欢迎玩家["..human:获取名字().."]登陆["..Config.SERVER_NAME.."]!!!")
		
		human:调整等级(160)
		human:更新属性点()
		
		human:学习技能(2)
		human:学习技能(3)
		human:学习技能(4)
		human:学习技能(5)
		human:学习技能(6)
		human:学习技能(7)
		human:学习技能(8)
		human:学习技能(9)
		human:学习技能(10)
		human:学习技能(11)

		延时执行(human,8000,"9",-3)--@假人新手
		return sayret
	end
	if human.是否新人 and human:获取职业()==2 and true then
		全服广播("#cff00ff,".."欢迎玩家["..human:获取名字().."]登陆["..Config.SERVER_NAME.."]!!!")
		
		human:调整等级(160)
		human:更新属性点()
		
		human:学习技能(12)
		human:学习技能(13)
		human:学习技能(14)
		human:学习技能(15)
		human:学习技能(16)
		human:学习技能(17)
		human:学习技能(18)
		human:学习技能(19)
		human:学习技能(20)
		human:学习技能(21)

		延时执行(human,8000,"9",-3)--@假人新手
		return sayret
	end
	if human.是否新人 and human:获取职业()==3 and true then
		全服广播("#cff00ff,".."欢迎玩家["..human:获取名字().."]登陆["..Config.SERVER_NAME.."]!!!")
		
		human:调整等级(160)
		human:更新属性点()
		
		human:学习技能(22)
		human:学习技能(23)
		human:学习技能(24)
		human:学习技能(25)
		human:学习技能(26)
		human:学习技能(27)
		human:学习技能(30)
		human:学习技能(31)

		
		延时执行(human,8000,"9",-3)--@假人新手
		return sayret
	end
	if human:获取等级()>0 and true then
		全服广播("#cff00ff,".."欢迎玩家["..human:获取名字().."]登陆["..Config.SERVER_NAME.."]!!!")
		
		human:增加状态技能()
		human:更新属性点()
		
		return sayret
	end
	return sayret
end

function call_9(human)--系统功能\登陆脚本@假人新手
	local sayret = nil
	if (human.私人变量.D0 or 0)<2 and true then
		human.私人变量.S54=取随机字符("新手骗子.txt",nil)
		全服广播("#cff00ff,".."欢迎玩家["..human:获取名字().."]登陆["..Config.SERVER_NAME.."]!!!")
		human.私人变量.D0=实用工具.SumString((human.私人变量.D0 or 0),1)
		延时执行(human,8000,"9",-3)--@假人新手
		return sayret
	end
	return sayret
end
function call_4(human)--系统功能\爵位属性@爵位属性
	local sayret = nil
	if human:获取转生等级()==44 and true then
		return sayret
	end
	if human:获取转生等级()==45 and true then
		return sayret
	end
	if human:获取转生等级()==46 and true then
		return sayret
	end
	if human:获取转生等级()==47 and true then
		return sayret
	end
	if human:获取转生等级()==48 and true then
		return sayret
	end
	if human:获取转生等级()==49 and true then
		return sayret
	end
	if human:获取转生等级()==50 and true then
		return sayret
	end
	if human:获取转生等级()==51 and true then
		return sayret
	end
	if human:获取转生等级()==52 and true then
		return sayret
	end
	return sayret
end
