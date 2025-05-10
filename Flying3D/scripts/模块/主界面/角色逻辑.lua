module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 实用工具 = require("公用.实用工具")
local 消息 = require("网络.消息")
local 角色UI = require("主界面.角色UI")
local 头像信息UI = require("主界面.头像信息UI")
local 背包UI = require("主界面.背包UI")
local 主界面UI = require("主界面.主界面UI")
local 商城UI = require("主界面.商城UI")
local 福利UI = require("主界面.福利UI")
local Boss副本UI = require("主界面.Boss副本UI")

m_rolename = ""
m_guildname = ""
m_rolejob = 0
m_rolesex = 0
m_bodyid = 0
m_weaponid = 0
m_wingid = 0
m_horseid = 0
m_bodyeff = 0
m_weaponeff = 0
m_wingeff = 0
m_horseeff = 0
m_level = 0
m_expmax = 0
m_exp = 0
m_hpmax = 0
m_hp = 0
m_mpmax = 0
m_mp = 0
m_money = 0
m_bindmoney = 0
m_rmb = 0
m_bindrmb = 0
m_atk = 0
m_def = 0
m_crit = 0
m_firm = 0
m_hit = 0
m_dodge = 0
m_speed = 0
m_power = 0
m_totalpower = 0
m_teamid = 0
m_suitcnts = {}
m_PK值 = 0
m_总充值 = 0
m_每日充值 = 0
m_特戒抽取次数 = 0
m_刷新BOSS次数 = 0
m_开区活动倒计时 = 0
m_vip等级 = 0
m_转生等级 = 0
m_防御 = 0
m_防御上限 = 0
m_魔御 = 0
m_魔御上限 = 0
m_攻击 = 0
m_攻击上限 = 0
m_魔法 = 0
m_魔法上限 = 0
m_道术 = 0
m_道术上限 = 0
m_幸运 = 0
m_准确 = 0
m_敏捷 = 0
m_魔法命中 = 0
m_魔法躲避 = 0
m_生命恢复 = 0
m_魔法恢复 = 0
m_中毒恢复 = 0
m_攻击速度 = 0
m_移动速度 = 0
m_显示时装 = 0
m_英雄显示时装 = 0
m_显示炫武 = 0
m_英雄显示炫武 = 0

m_liliang = 0
m_zhili = 0
m_jingshen = 0
m_tizhi = 0
m_zhongji = 0

m_力量 = 0
m_智力 = 0
m_精神 = 0
m_体质 = 0
m_重击 = 0

m_challenge = {}
m_alliance = {}



function setAttackGuild(challenge,alliance)
	实用工具.DeleteTable(m_challenge)
	实用工具.DeleteTable(m_alliance)
	local challenges = 实用工具.SplitString(challenge,",")
	local alliances = 实用工具.SplitString(alliance,",")
	for i,v in ipairs(challenges) do
		m_challenge[v] = 1
	end
	for i,v in ipairs(alliances) do
		m_alliance[v] = 1
	end
end

function setOtherAttr(vip等级, 总充值, 每日充值, 特戒抽取次数, 刷新BOSS次数, 开区活动倒计时)
	local 等级 = m_vip等级
	local 充值 = m_总充值
	local 今日充值 = m_每日充值
	m_vip等级 = vip等级
	m_总充值 = 总充值
	m_每日充值 = 每日充值
	m_特戒抽取次数 = 特戒抽取次数
	m_刷新BOSS次数 = 刷新BOSS次数
	m_开区活动倒计时 = 开区活动倒计时
	商城UI.updateVipLevel(等级 ~= m_vip等级)
	福利UI.updateVipLevel()
	Boss副本UI.updateCnt()
end

function setLevel(level)
	m_level = level
	角色UI.update()
	头像信息UI.update()
end

function setRoleJob(job)
	m_rolejob = job
	角色UI.update()
	头像信息UI.update()
end

function setActualAttr(expmax,exp,mpmax,mp)
	m_expmax = expmax
	m_exp = exp
	m_mpmax = mpmax
	m_mp = mp
	头像信息UI.setMPBar(mp,mpmax)
	主界面UI.updateExp()
end

function setDetailAttr(expmax,exp,hpmax,hp,mpmax,mp,money,bindmoney,rmb,bindrmb,atk,def,crit,firm,hit,dodge,speed,power,totalpower,转生等级,PK值,suitcnts,liliang,zhili,jingshen,tizhi,zhongji)
	m_expmax = expmax
	m_exp = exp
	m_hpmax = hpmax
	m_hp = hp
	m_mpmax = mpmax
	m_mp = mp
	m_money = money
	m_bindmoney = bindmoney
	m_rmb = rmb
	m_bindrmb = bindrmb
	m_atk = atk
	m_def = def
	m_crit = crit
	m_firm = firm
	m_hit = hit
	m_dodge = dodge
	m_speed = speed
	m_power = power
	m_totalpower = totalpower
	m_转生等级 = 转生等级
	m_PK值 = PK值
	m_suitcnts = suitcnts
	m_liliang = liliang
	m_zhili = zhili
	m_jingshen = jingshen
	m_tizhi = tizhi
	m_zhongji = zhongji
	角色UI.update()
	头像信息UI.update()
	背包UI.updateMoney()
	福利UI.updateVipLevel()
	商城UI.updateMoney()
	主界面UI.updateExp()
	主界面UI.updatePower()
	主界面UI.update()
end

function setExtraAttr(防御,防御上限,魔御,魔御上限,攻击,攻击上限,魔法,魔法上限,道术,道术上限,幸运,准确,敏捷,魔法命中,魔法躲避,生命恢复,魔法恢复,中毒恢复,攻击速度,移动速度,力量,智力,精神,体质,重击)
	m_防御 = 防御
	m_防御上限 = 防御上限
	m_魔御 = 魔御
	m_魔御上限 = 魔御上限
	m_攻击 = 攻击
	m_攻击上限 = 攻击上限
	m_魔法 = 魔法
	m_魔法上限 = 魔法上限
	m_道术 = 道术
	m_道术上限 = 道术上限
	m_幸运 = 幸运
	m_准确 = 准确
	m_敏捷 = 敏捷
	m_魔法命中 = 魔法命中
	m_魔法躲避 = 魔法躲避
	m_生命恢复 = 生命恢复
	m_魔法恢复 = 魔法恢复
	m_中毒恢复 = 中毒恢复
	m_攻击速度 = 攻击速度
	m_移动速度 = 移动速度
	m_力量 = 力量
	m_智力 = 智力
	m_精神 = 精神
	m_体质 = 体质
	m_重击 = 重击
end

function setFacade(bodyid, weaponid, wingid, horseid, bodyeff, weaponeff, wingeff, horseeff)
	m_bodyid = bodyid
	m_weaponid = weaponid
	m_wingid = wingid
	m_horseid = horseid
	m_bodyeff = bodyeff
	m_weaponeff = weaponeff
	m_wingeff = wingeff
	m_horseeff = horseeff
	角色UI.update()
end
