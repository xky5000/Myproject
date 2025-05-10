module(..., package.seeall)

SERVERS = {
	[0] = {
		-- ip = "113.125.78.208",
		ip = "127.0.0.1",
		port = 5020,
		hport = 10000,
	},
	[1] = {
		ip = "113.125.78.208",
		port = 5021,
		hport = 10001,
	},
	[2] = {
		ip = "113.125.78.208",
		port = 5022,
		hport = 10002,
	},
}

account = "test"
timestamp = 0
agentid = 0
serverid = 0
fcm = 1
ticket = ""

function getColorRgbVal(grade)
	if grade <= 1 then
		return 0xCCCCCC  --白色
	elseif grade == 2 then
		return 0x38BB41  --绿色
	elseif grade == 3 then
		return 0x1FABE1  --蓝色
	elseif grade == 4 then
		return 0xDD61E2  --紫色
	else
		return 0xEB7B29  --橙色
	end
end

NAMECOLOR = {
	[0] = 0xffffff,--白名
	[1] = 0x996600,--灰名
	[2] = 0xffff00,--黄名
	[3] = 0xff0000,--红名
	[4] = 0xff007f,--紫名
	[5] = 0x00ff00,--绿名
	[6] = 0x0000ff,--蓝名
	[7] = 0xff8040,--橙名
}

if IS3G then
	附魔 = {
		{"回风扫叶威力","天女散花威力","百步穿杨威力","无上冰牢威力","劈涛斩浪威力","血之轮回威力","雷神之握威力"},
		{"大鹏展翅威力","织女穿梭威力","后羿射日威力","玄冥冰魄威力","长刀碎月威力","八荒魔斩威力","风行瞬剑威力"},
		{"神龙摆尾威力","召唤吕布威力","无限箭制威力","青龙狂潮威力","排山倒海威力","飞龙在天威力","惊雷剑阵威力"},
		{"乾坤一击威力","刀扇魅影威力","北望天狼威力","灭世玄武威力","风卷残云威力","怒斩天下威力","雷霆之剑威力"},
		{"虎跃龙腾威力","风华绝代威力","流星箭雨威力","龙啸九天威力","冰凰映月威力","血域狂龙威力","万剑归宗威力"},
		{"生命值"},
		{"怒气值"},
		{"防御"},
		{"技能防御"},
		{"攻击"},
		{"技能伤害"},
		{"神圣伤害"},
	}
else
	附魔 = {
		{"攻杀剑术威力","雷电术威力","灵魂火符威力"},
		{"刺杀剑术威力","抗拒火环威力","治愈术威力"},
		{"半月弯刀威力","火墙威力","召唤骷髅威力"},
		{"野蛮冲撞威力","魔法盾威力","施毒术威力"},
		{"烈火剑法威力","冰咆哮威力","召唤神兽威力"},
		{"生命值"},
		{"魔法值"},
		{"防御"},
		{"魔御"},
		{"攻击"},
		{"魔法"},
		{"道术"},
	}
end

if IS3G then
	宝石 = {
		{"生命宝石",10704},
		{"防御宝石",10705},
		{"技能防御宝石",10706},
		{"攻击宝石",10701},
		{"技能伤害宝石",10702},
		{"神圣伤害宝石",10703},
	}
else
	宝石 = {
		{"生命宝石",10704},
		{"防御宝石",10705},
		{"魔御宝石",10706},
		{"攻击宝石",10701},
		{"魔法宝石",10702},
		{"道术宝石",10703},
	}
end

转生 = {
	"一转",
	"二转",
	"三转",
	"四转",
	"五转",
	"六转",
	"七转",
	"八转",
	"九转",
	"十转",
	"十一转",
	"十二转",
}

物品类型 = {
	{1,1,"碎片"},
	{1,2,"技能残页"},
	{1,3,"锻造石"},
	{1,4,"镶嵌宝石"},
	{1,5,"武将卡"},
	{2,1,"金币"},
	{2,2,"元宝"},
	{2,3,"药水"},
	{2,4,"宠物"},
	{2,5,"坐骑"},
	{2,6,"翅膀"},
	{2,7,"技能书"},
	{2,8,"道具"},
	{2,9,"魔法药"},
	{2,10,"卷轴"},
	{2,11,"祝福油"},
	{3,1,"武器"},
	{3,2,"衣服"},
	{3,3,"头盔"},
	{3,4,"项链"},
	{3,5,"护腕"},
	{3,6,"戒指"},
	{3,7,"腰带"},
	{3,8,"靴子"},
	{3,9,"勋章"},
	{3,10,"宝石"},
	{3,11,"斗笠"},
	{3,12,"面巾"},
	{3,13,"特戒"},
	{3,14,"宠物蛋"},
	{3,15,"进阶石"},
	{3,16,"聚灵珠"},
}

if IS3G then
	武神外观 = {
		{0,1001,0,0,0},
		{0,1002,0,0,0},
		{0,1003,0,0,0},
		{0,1004,0,0,0},
		{0,1005,0,0,0},
		{0,1006,0,0,0},
		{0,1007,0,0,0},
	}
else
	武神外观 = {
		{1,2003,0,3001,0},
		{2,2004,0,3002,0},
		{1,2005,0,3003,0},
		{2,2006,0,3004,0},
		{1,2007,0,3021,0},
		{2,2008,0,3022,0},
		{1,2009,0,3023,0},
		{2,2010,0,3024,0},
		{1,2011,0,3017,0},
		{2,2012,0,3018,0},
		{1,2007,0,3047,0},
		{2,2008,0,3048,0},
		{1,2009,0,3055,0},
		{2,2010,0,3056,0},
		{1,2011,0,3049,0},
		{2,2012,0,3050,0},
		{1,2013,0,3051,0},
		{2,2014,0,3052,0},
		{1,2015,0,3053,0},
		{2,2016,0,3054,0},
		{1,2017,0,3065,0},
		{2,2018,0,3066,0},
		{1,2019,5015,3067,0},
		{2,2020,5016,3068,0},
		{1,2019,5005,3069,0},
		{2,2020,5006,3070,0},
		{1,2019,5001,3071,0},
		{2,2020,5002,3072,0},
		{1,2023,0,3113,0},
		{2,2024,0,3114,0},
		{1,2023,0,3103,0},
		{2,2024,0,3104,0},
		{1,2023,0,3105,0},
		{2,2024,0,3106,0},
		{1,2021,5003,3073,0},
		{2,2022,5004,3074,0},
		{1,2021,5003,3073,0},
		{2,2022,5004,3074,0},
		{1,2021,5003,3073,0},
		{2,2022,5004,3074,0},
		{1,2045,5025,3111,5023},
		{2,2046,5026,3112,5024},
		{1,2045,5025,3111,5023},
		{2,2046,5026,3112,5024},
		{1,2045,5025,3111,5023},
		{2,2046,5026,3112,5024},
		{1,2057,5029,3123,5031},
		{2,2058,5030,3124,5032},
		{1,2057,5029,3123,5031},
		{2,2058,5030,3124,5032},
		{1,2057,5029,3123,5031},
		{2,2058,5030,3124,5032},
		{1,2063,5033,3127,5035},
		{2,2064,5034,3128,5036},
		{1,2063,5033,3131,5043},
		{2,2064,5034,3132,5044},
		{1,2063,5033,3129,5037},
		{2,2064,5034,3130,5038},
		{1,2077,5057,3147,5059},
		{2,2078,5058,3148,5063},
		{1,2077,5057,3151,5063},
		{2,2078,5058,3152,5064},
		{1,2077,5057,3149,5061},
		{2,2078,5058,3150,5062},
		{1,2071,5045,3141,5051},
		{2,2072,5046,3142,5052},
		{1,2073,5047,3145,5053},
		{2,2074,5048,3146,5054},
		{1,2075,5049,3143,5055},
		{2,2076,5050,3144,5056},
		{1,2081,5067,3153,5069},
		{2,2082,5068,3154,5070},
		{1,2081,5067,3157,5073},
		{2,2082,5068,3158,5074},
		{1,2081,5067,3155,5071},
		{2,2082,5068,3156,5072},
	}
end

职业名字 = {
	[1] = "龙枪",
	[2] = "战姬",
	[3] = "烈弓",
	[4] = "神羽",
	[5] = "舞娘",
	[6] = "狂刃",
	[7] = "剑魂",
}

function 获取物品类型(type1,type2)
	for i,v in ipairs(物品类型) do
		if v[1] == type1 and v[2] == type2 then
			return v[3]
		end
	end
	return "其他"
end

function 获取职业类型(job)
	if IS3G then
		return 职业名字[job] or "全职业"
	elseif job == 1 then
		return "战士"
	elseif job == 2 then
		return "法师"
	elseif job == 3 then
		return "召唤"
	else
		return "全职业"
	end
end

function 获取行会职位(职位)
	if 职位 == 3 then
		return "会长"
	elseif 职位 == 2 then
		return "副会长"
	elseif 职位 == 1 then
		return "管理员"
	else
		return "成员"
	end
end

OBJTYPE_PLAYER = 1
OBJTYPE_MONSTER = 2
OBJTYPE_PET = 3
OBJTYPE_NPC = 4
OBJTYPE_COLLECT = 5
OBJTYPE_ITEM = 6

STATUS_NORMAL = 0			-- 正常
STATUS_DISAPPEAR = 1		-- 消失

gradeimgurl = {
	"",
	UIPATH.."公用/grid/img_quality1.png",
	UIPATH.."公用/grid/img_quality2.png",
	UIPATH.."公用/grid/img_quality3.png",
	UIPATH.."公用/grid/img_quality4.png",
}

MONEYICON = {
	[0] = UIPATH.."公用/money/money_2.png",
	[1] = UIPATH.."公用/money/money_3.png",
	[2] = UIPATH.."公用/money/money_0.png",
	[3] = UIPATH.."公用/money/money_1.png",
}

function getGradeUrl(grade)
	return gradeimgurl[grade] or ""
end

proptexts = {
	{"生命值", 1},
	{"魔法值", 2},
	{"防御", 3},
	{"防御上限", 4},
	{"魔御", 5},
	{"魔御上限", 6},
	{"攻击", 7},
	{"攻击上限", 8},
	{"魔法", 9},
	{"魔法上限", 10},
	{"道术", 11},
	{"道术上限", 12},
	
	{"幸运", 13},
	{"准确", 14},
	{"敏捷", 15},
	{"魔法命中", 16, true},
	{"魔法躲避", 17, true},
	{"生命恢复", 18},
	{"魔法恢复", 19},
	{"中毒恢复", 20, true},
	{"攻击速度", 21, true},
	{"移动速度", 22},
	
	{"技能冷却", 23, true},
	{"伤害吸血", 24, true},
	{"伤害反弹", 25, true},
	{"伤害加成", 26, true},
	{"真实伤害", 27},
	{"伤害抵挡", 28},
	
	{"麻痹几率", 29, true},
	{"灼烧几率", 32, true},
	{"冰冻几率", 33, true},
	{"红毒几率", 34, true},
	{"绿毒几率", 35, true},
	{"抵御几率", 36, true},
	{"暴击几率", 37, true},
	{"忽视防御", 38, true},
	{"物理抵挡", 39, true},
	{"魔法抵挡", 40, true},
	{"体质", 41, true},
	{"经验加成", 42, true},
	{"物品掉率", 43, true},
	{"极品爆率", 44, true},
	{"抵抗", 45, true},
	{"经验存储", 46},
}

function getPropText(prop)
	for i,v in ipairs(proptexts) do
		if v[2] == prop then
			return v[1]
		end
	end
	return ""
end

function getHPColor(type,iscall,isboss)
	if type == OBJTYPE_PLAYER then
		return 0xffffff00
	elseif type == OBJTYPE_MONSTER then
		return isboss and 0xffff8040 or iscall and 0xff0080ff or 0xffff0000
	elseif type == OBJTYPE_PET then
		return 0xffff00ff
	elseif type == OBJTYPE_NPC then
		return 0xff00ff00
	elseif type == OBJTYPE_COLLECT then
		return 0xff00ffff
	else
		return 0xffffffff
	end
end

function getAvatarSetUrl(job)
	if job == 1 then
		return uri("/res/avatar/男狂战10.txt")
	elseif job == 2 then
		return uri("/res/avatar/女魔导9.txt")
	elseif job == 3 then
		return uri("/res/avatar/男龙骑5.txt")
	elseif job == 4 then
		return uri("/res/avatar/男亡灵5.txt")
	else
		return ""
	end
end

function getFaceUrl(job)
	if job == 1 then
		return "/res/avatar/face/42005/42005.mesh"
	elseif job == 2 then
		return "/res/avatar/face/42008/42008.mesh"
	else
		return ""
	end
end

function getHairUrl(job)
	if job == 1 then
		return "/res/avatar/hair/41005/41005.mesh"
	elseif job == 2 then
		return "/res/avatar/hair/41008/41008.mesh"
	else
		return ""
	end
end

function getMirHairUrl(sex)
	if sex == 1 then
		return "/res/animpack/2903/2903.animpack"
	elseif sex == 2 then
		return "/res/animpack/2904/2904.animpack"
	else
		return ""
	end
end

function getAnimsetUrl(job)
	if job == 1 then
		return "/res/avatar/animset/3_1.txt"
	elseif job == 2 then
		return "/res/avatar/animset/5_2.txt"
	else
		return ""
	end
end

function getBodyUrl(id)
	return (id==0) and "" or "/res/avatar/body/"..id.."/"..id..".mesh"
end

function getWeaponUrl(id)
	return (id==0) and "" or "/res/avatar/weapon/"..id.."/"..id..".mesh"
end

function getWingUrl(id)
	return (id==0) and "" or "/res/avatar/wing/"..id.."/"..id..".mesh"
end

function getAnimPackUrl(id,effect)
	if id > 0 and id < 1000 then
		return (IS3G and "/res/anim3g/" or "/res/animpack/")..武神外观[id][2].."/"..武神外观[id][2]..".animpack"
	elseif ISWZ and not effect then
		return (id==0) and "" or "/res/anim_wz/"..id.."/"..id..".animpack"
	elseif id > 7000 and id < 8000 then
		return (id==0) and "" or "/res/animpack1/"..id.."/"..id..".animpack"
	else
		return (id==0) and "" or (IS3G and "/res/anim3g/" or "/res/animpack/")..id.."/"..id..".animpack"
	end
end

function getFixedID(id)
	if id < 0 then
		id = id + 0x10000--id & 0xffff
	end
	return id
end

function getModelUrl(id)
	id = getFixedID(id)
	if id < 10 then
		return getAvatarSetUrl(id)
	elseif id > 4000 and id <= 5000 then
		return getNpcUrl(id)
	elseif id > 40000 then
		return getPetUrl(id)
	else
		return getMonsterUrl(id)
	end
end

function getMonsterUrl(id)
	return (id==0) and "" or "/res/monster/"..id.."/"..id..".mesh"
end

function getPetUrl(id)
	return (id==0) and "" or "/res/pet/"..id.."/"..id..".mesh"
end

function getNpcUrl(id)
	return (id==0) and "" or "/res/npc/"..id.."/"..id..".mesh"
end

function getEffectUrl(id)
	return (id==0) and "" or "/res/effect/"..id.."/"..id..".effect"
end

function getSceneUrl(id)
	return (id==0) and "" or "/res/scene/"..id.."/"..id..".scene"
end

function getMapUrl(id,dirname)--is3d)
	if IS3G then
		return "/res/map3g/"..id.."/"..id..".map"
	elseif ISWZ then
		return "/res/map_wz/"..id.."/"..id..".map"
	elseif ISMIR2D then
		return "/res/"..dirname.."/"..id.."/"..id..".map"--mirmap
	else
		return (is3d and "/res/scene/" or "/res/map/")..id.."/"..id..".map"
	end
end

function getMinimapUrl(id,dirname)--is3d)
	if IS3G then
		return "/res/map3g/"..id.."/"..id..".png"
	elseif ISWZ then
		return "/res/map_wz/"..id.."/"..id..".jpg"
	elseif ISMIR2D then
		return "/res/"..dirname.."/"..id.."/"..id..".jpg"--(dirname == "mirmap" and ".png" or ".jpg")
	else
		return (is3d and "/res/scene/" or "/res/map/")..id.."/"..id..".jpg"
	end
end

function getSoundUrl(id)
	return (id==0) and "" or "/res/sound/"..id..".mp3"
end

function getIconIconUrl(id)
	if ITEMICON ~= 0 then
		return "/res/icon/icon"..ITEMICON.."/"..string.format("%05d",id+1)..".png"
	else
		return "/res/icon/icon/"..string.format("%05d",id+1)..".png"
	end
end

function getStateItemIconUrl(id)
	if id < 0 then
		id = id + 0x10000--id & 0xffff
	end
	if id > 20000 then
		return (id==0) and "" or "/res/icon/itemx/"..id..".png"
	elseif ITEMICON ~= 0 then
		return (id==0) and "" or "/res/icon/stateitem"..ITEMICON.."/"..string.format("%05d",id-10000)..".png"
	elseif ISMIR2D then
		return (id==0) and "" or "/res/icon/stateitem/"..string.format("%05d",id)..".png"
	else
		return ""
	end
end

function getItemIconUrl(id)
	if id < 0 then
		id = id + 0x10000--id & 0xffff
	end
	if id > 20000 then
		return (id==0) and "" or "/res/icon/itemx/"..id..".png"
	elseif ITEMICON ~= 0 then
		return (id==0) and "" or "/res/icon/items"..ITEMICON.."/"..string.format("%05d",id-10000)..".png"
	elseif ISWZ then
		return (id==0) and "" or "/res/icon/item_wz/"..id..".png"
	elseif ISMIR2D then
		return (id==0) and "" or "/res/icon/items/"..string.format("%05d",id)..".png"
	else
		return (id==0) and "" or "/res/icon/item/"..id..".png"
	end
end

function getDropItemIconUrl(id)
	if id < 0 then
		id = id + 0x10000--id & 0xffff
	end
	if id > 20000 then
		return (id==0) and "" or "/res/icon/itemx/"..id..".png"
	elseif ITEMICON ~= 0 then
		return (id==0) and "" or "/res/icon/dnitems"..ITEMICON.."/"..string.format("%05d",id-10000)..".png"
	elseif IS3G then
		return (id==0) and "" or "/res/icon/items/"..id..".png"
	elseif ISWZ then
		return (id==0) and "" or "/res/icon/item_wz/"..id..".png"
	elseif ISMIR2D then
		return (id==0) and "" or "/res/icon/dnitems/"..string.format("%05d",id)..".png"
	else
		return (id==0) and "" or "/res/icon/dropitem/"..id..".png"
	end
end

function getSkillIconUrl(id)
	if ISWZ then
		return (id==0) and "" or "/res/icon/skill_wz/"..id..".jpg"
	else
		return (id==0) and "" or "/res/icon/skill/"..string.format("%05d",id)..".png"
	end
end

function getHeadIconUrl(id)
	return (id==0) and "" or "/res/icon/head/"..id..".png"
end

function getBossIconUrl(id)
	if ISMIR2D and id > 0 and id < 1000 then
		return (IS3G and "/res/icon/head3g/" or "/res/icon/headicon/")..武神外观[id][2]..".png"
	elseif IS3G then
		return (id==0) and "" or "/res/icon/head3g/"..id..".png"
	elseif ISWZ then
		return (id==0) and "" or "/res/icon/head_wz/"..id..".png"
	elseif ISMIR2D then
		return (id==0) and "" or "/res/icon/headicon/"..string.format("%05d",id)..".png"
	else
		return (id==0) and "" or "/res/icon/bossicon/"..id..".png"
	end
end

function getBossHeadUrl(id)
	if ISMIR2D and id > 0 and id < 1000 then
		return (IS3G and "/res/icon/head3g/" or "/res/icon/headicon/")..武神外观[id][2]..".png"
	elseif IS3G then
		return (id==0) and "" or "/res/icon/head3g/"..id..".png"
	elseif ISWZ then
		return (id==0) and "" or "/res/icon/head_wz/"..id..".png"
	elseif ISMIR2D then
		return (id==0) and "" or "/res/icon/headicon/"..string.format("%05d",id)..".png"
	else
		return (id==0) and "" or "/res/icon/boss/"..id..".png"
	end
end

function getPetIconUrl(id)
	if ISMIR2D and id > 0 and id < 1000 then
		return (IS3G and "/res/icon/head3g/" or "/res/icon/headicon/")..武神外观[id][2]..".png"
	elseif IS3G then
		return (id==0) and "" or "/res/icon/head3g/"..id..".png"
	elseif ISWZ then
		return (id==0) and "" or "/res/icon/head_wz/"..id..".png"
	elseif ISMIR2D then
		return (id==0) and "" or "/res/icon/headicon/"..string.format("%05d",id)..".png"
	else
		return (id==0) and "" or "/res/icon/pet/"..id..".jpg"
	end
end

function getPetHeadUrl(id)
	if ISMIR2D and id > 0 and id < 1000 then
		return (IS3G and "/res/icon/head3g/" or "/res/icon/headicon/")..武神外观[id][2]..".png"
	elseif IS3G then
		return (id==0) and "" or "/res/icon/head3g/"..id..".png"
	elseif ISWZ then
		return (id==0) and "" or "/res/icon/head_wz/"..id..".png"
	elseif ISMIR2D then
		return (id==0) and "" or "/res/icon/headicon/"..string.format("%05d",id)..".png"
	else
		return (id==0) and "" or "/res/icon/pethead/"..id..".png"
	end
end
