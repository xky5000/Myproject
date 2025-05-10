module(..., package.seeall)

-- char db， 需要保存到数据库的信息
--             玩家DB 都要new出来

local ns = "char"                --数据库表
local QueryByName = { name=""}         --按角色名查询
local QueryByAccount={ account=""}     --按帐号查询
local 公共定义 = require("公用.公共定义")
local 实用工具 = require("公用.实用工具")
local 宠物DB = require("宠物.宠物DB")
local 背包DB = require("物品.背包DB")
玩家DB={}

-- 这里的表还是显示的初始化比较好 否则db数据格式升级后 table里可能会有nil对象
function 玩家DB:New()
    local o={
        svrname="",--Config.SVRNAME,
        account="",
        name="",
		level=1,exp=0,
		PK值=0,
		总充值=0,
		每日充值=0,
		每日充值领取 = {},
		累计充值领取 = {},
		特戒抽取次数=0,
		刷新BOSS次数=0,
		vip等级=0,
		vip类型=0,
		vip领取奖励=0,
		vip领取等级=0,
		hp=0,mp=0,tp=100,
		task={},
		currtaskid=0,
        dbflag=公共定义.DB_IN_NORMAL_GAME_SERVER,
		rmb=0,bindrmb=0,money=0,bindmoney=0,
        job=0,sex=0,
		mapid=0,--公共定义.CHAR_BORN_MAPID, 
		x=0,y=0,prevMapid=0,prevX=0,prevY=0,backMapid=0,backX=0,backY=0,
        historyRMB=0,
		atkmode=公共定义.ATK_MODE_PEACE,
		pkmode = 0,
        ip = "",--玩家登陆ip地址
        lastLogin=os.time(),lastLogout=os.time(),createRoleTime=0,
		copysceneID=-1,copysceneCreateTime=0,
		petdb = 宠物DB:New(),
		bagdb = 背包DB:New(),
		skills = {},
		skillquicks = {},
		singlecopy = {},
		singlecopyfinish = {},
		bosscopy = {},
		bosssinglecopy = {},
		bufftime = {},
		英雄PK值 = 0,
		英雄忠诚度 = 0,
		英雄职业 = 0,
		英雄性别 = 0,
		英雄等级 = 1,
		英雄经验 = 0,
		英雄生命 = 0,
		英雄魔法 = 0,
		英雄装备 = {},
		英雄技能 = {},
		英雄复活 = 0,
		HP保护 = 50,
		MP保护 = 50,
		英雄HP保护 = 50,
		英雄MP保护 = 50,
		自动分解白 = 0,
		自动分解绿 = 0,
		自动分解蓝 = 0,
		自动分解紫 = 0,
		自动分解橙 = 0,
		自动分解等级 = 30,
		使用生命药 = 0,
		使用魔法药 = 0,
		英雄使用生命药 = 0,
		英雄使用魔法药 = 0,
		使用物品HP = 10,
		使用物品ID = 0,
		自动使用合击 = 0,
		自动分解宠物白 = 0,
		自动分解宠物绿 = 0,
		自动分解宠物蓝 = 0,
		自动分解宠物紫 = 0,
		自动分解宠物橙 = 0,
		自动孵化宠物蛋 = 0,
		物品自动拾取 = 0,
		VIP成长经验 = 0,
		VIP推广人 = "",
		VIP推广人成长 = 0,
		VIP推广人数 = 0,
		VIP推广有效人数 = 0,
		VIP礼包领取 = {},
		转生等级 = 0,
		转生加点 = {},
		英雄转生等级 = 0,
		英雄转生加点 = {},
		日常任务次数 = 0,
		悬赏任务次数 = 0,
		护送押镖次数 = 0,
		护送灵兽次数 = 0,
		庄园采集次数 = 0,
		日限商品购买 = {},
		每日使用次数 = {},
		每日采集次数 = 0,
		领取补偿 = {},
		副本刷怪数量 = 10,
		镖车血量 = 0,
		镖车玩家伤害 = {},
		战魂值 = 0,
		功勋值 = 0,
		成就积分 = 0,
		转生修为 = 0,
		魂力值 = 0,
		金刚石 = 0,
		神石结晶 = 0,
		魂珠碎片 = 0,
		灵韵值 = 0,
		灵兽精魂 = 0,
		驯兽术等级 = 1,
		注灵碎片 = 0,
		显示时装 = 0,
		英雄显示时装 = 0,
		显示炫武 = 0,
		英雄显示炫武 = 0,
		荣誉值 = 0,
		声望值 = 0,
		灵符数 = 0,
		泡点数 = 0,
		私人变量 = {},
		行会ID = 0,
		伤害吸收 = 0,
		英雄伤害吸收 = 0,
		属性点数 = 0,
		英雄属性点数 = 0,
		记录坐标 = {},
		队伍拒绝邀请 = 0,
		队伍拒绝申请 = 0,
		guildname = "",
		guildapply = {},
		药水属性 = {},
		checkbug = 0,
		代理推广人 = "",
	}
    setmetatable(o,self)
    self.__index=self
    return o
end
DefaultChar = 玩家DB:New()

-- 直接查询db 帐号是否存在
function IsNameExistInDB(name)
	 QueryByName.name = name
	return _Find(g_oMongoDB,ns,QueryByName, "{_id:1}") ~= nil
end

function IsAccountExistInDB(account)
   QueryByAccount.account = account
   return _Find(g_oMongoDB,ns,QueryByAccount, "{_id:1}") ~= nil
end

-- 直接查询db 获取离线角色的特定属性
function GetCharPropertyOffLine(name, queryDescrib, isAccount)
	local query={}
	if isAccount then
      query.account = name
    else
	  query.name=name
    end
	local pCursor = _Find(DB.GetDB(name),ns,query,queryDescrib)
	if pCursor == nil then
		return nil
	end
	local result={}
	if not _NextCursor(pCursor,result) then
		return nil
	end
	return result
end

-- 直接查询db 修改离线角色的特定属性
function SetCharPropertyOffLine(name, oValue, isAccount)
	oValue._id = nil

	local query={}
	if isAccount then
      query.account = name
    else
	  query.name=name
    end
	local modify={}
	modify["$set"]=oValue
	return _Update(DB.GetDB(name),ns,query,modify)
end

function 玩家DB:LoadByName(name)
    QueryByName.name = name
    local pCursor = _Find(DB.GetDB(name),ns,QueryByName)
    if not pCursor then
        return false
    end

    if not _NextCursor(pCursor,self) then
        return false
    end
    return true
end

function 玩家DB:LoadByAccount(account, svrname)
   QueryByAccount.account = account
   QueryByAccount.svrname = svrname
   local pCursor = _Find(DB.GetDB(account),ns,QueryByAccount)
    if not pCursor then
        return false
    end

    if not _NextCursor(pCursor,self) then
        return false
    end
    return true
end

function 玩家DB:Save()
    local query={}
    query._id=self._id
    return _Update(DB.GetDB(self.name),ns,query,self)
end

function 玩家DB:Add()
    local ret = _Insert(DB.GetDB(self.name),ns,self)
    if not ret then
        return false
    end
    --加载id
    QueryByName.name = self.name
    local pCursor = _Find(DB.GetDB(self.name),ns,QueryByName,"{_id:1}")
    if not pCursor then
        return false
    end
    if not _NextCursor(pCursor,self) then
        return false
    end
    return true
end

--同步实时更新接口
function 玩家DB:SynchSave(key)
	if self[key] == nil then
		return
	end
	local query={_id=self._id}
	local modify={}
	modify["$set"]={[key]=self[key]}
	return _Update(DB.GetDB(self.name),ns,query,modify)
end

function 玩家DB:ReSetMetatable()
    玩家DB.__index = 玩家DB
    setmetatable(self, 玩家DB)
end

