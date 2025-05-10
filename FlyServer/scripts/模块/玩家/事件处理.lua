module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 副本逻辑 = require("副本.副本逻辑")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local Npc对话逻辑 = require("怪物.Npc对话逻辑")
local 技能逻辑 = require("技能.技能逻辑")
local 背包DB = require("物品.背包DB")
local 地图表 = require("配置.地图表").Config
local 限时商店 = require("物品.限时商店")
local 玩家DB = require("玩家.玩家DB").玩家DB
local 技能表 = require("配置.技能表").Config
local 背包逻辑 = require("物品.背包逻辑")
local 物品逻辑 = require("物品.物品逻辑")
local 聊天逻辑 = require("聊天.聊天逻辑")
local 后台逻辑 = require("后台管理.后台逻辑")
local 充值礼包表 = require("配置.充值礼包表").Config
local 福利抽奖表 = require("配置.福利抽奖表").Config
local 拾取物品逻辑 = require("怪物.拾取物品逻辑")
local 副本事件处理 = require("副本.事件处理")
local 事件触发 = require("触发器.事件触发")
local 登录触发 = require("触发器.登录触发")
local 定时触发 = require("触发器.定时触发")
local 行会管理 = require("行会.行会管理")
local 行会定义 = require("行会.行会定义")
local 城堡管理 = require("行会.城堡管理")
local 物品表 = require("配置.物品表").Config

g_nHourTimerID = g_nHourTimerID or nil
g_nDayTimerID = g_nDayTimerID or nil
g_nMinTimerID = g_nMinTimerID or nil
g_nSecTimerID = g_nMinTimerID or nil
g_nMinTimerCounter = g_nMinTimerCounter or 0
g_nSecTimerCounter = g_nSecTimerCounter or 0
g_nNowDate = g_nNowDate or os.date("*t")

特戒之城开启 = 特戒之城开启 or 0
寻宝阁状态 = 寻宝阁状态 or 0
寻宝阁时间 = 寻宝阁时间 or 0
寻宝阁关闭 = 寻宝阁关闭 or 0
寻宝阁波数 = 寻宝阁波数 or 0
寻宝阁怪物 = {
	[1] = {2148,2149},
	[2] = {2150,2151,2152},
	[3] = {2153,2154,2155},
	[4] = {2156,2157,2158},
	[5] = {2159,2160,2161},
	[6] = {2162,2163,2164},
	[7] = {2165,2166,2167},
}

function CG_ASK_LOGIN(nObjFD, msg)
  local account = 实用工具.GetStringFromTable(msg.accountLen, msg.account)
  local authkey = 实用工具.GetStringFromTable(msg.authkeyLen, msg.authkey)
  
  日志.WriteLog(日志.LOGID_USER_LOGIN, account .. "  AskLogin")
  
  local oOldHuman = 在线账号管理[account]
  if oOldHuman then
	if oOldHuman.是否离线挂机 then
		oOldHuman:Destroy()
	else
		oOldHuman:DoDisconnect(公共定义.DISCONNECT_REASON_ANOTHER_CHAR_LOGIN)
	end
  end
  
  -- 加载角色信息
  local human = 玩家对象类:New(nObjFD)
  human.svrname = Config.USESVR and "s"..msg.timestamp.."." or nil
  local ret = human:Load(account, true, human.svrname)
  if not ret then
    -- 创建新的角色
    print("new account login:", account)
    human.m_db.account = tostring(account)
  end
  
  human.oldmapid = human.m_db.mapid
  human.platform = "["..authkey.."]"
	if 场景管理.GetIsCopy(human.m_db.mapid) then
		human.m_db.mapid = human.m_db.prevMapid
		human.m_db.x, human.m_db.y = human.m_db.prevX, human.m_db.prevY
	end
	--human.m_db.bagdb.baggrids = {}
	--human.m_db.bagdb.equips = {}
  if human.m_db.mapid == 0 then--新角色
	local 地图配置 = 地图表[公共定义.出生地图]
	if #地图配置.bornpos == 0 then
		human.m_db.x, human.m_db.y = 场景管理.GetPosCanRun(场景管理.GetSceneId(公共定义.出生地图))
	else
		human.m_db.x = 地图配置.bornpos[1] + math.random(-地图配置.bornpos[3],地图配置.bornpos[3])
		human.m_db.y =  地图配置.bornpos[2] + math.random(-地图配置.bornpos[3],地图配置.bornpos[3])
	end
    human.m_db.mapid = 公共定义.出生地图
	--human.m_db.vip等级 = 1
	--human.m_db.level = 60
	--human:PutItemGrids(14001, 1, 1)
	--human:PutItemGrids(14002, 1, 1)
	--human:PutItemGrids(14003, 1, 1)
	--human:PutItemGrids(14004, 1, 1)
 	--human:PutItemGrids(14005, 1, 1)
	human.是否新人 = 1
  end
  if Config.IS3G then
	human.m_db.job = 1
	human.m_db.sex = 1
  end
  if Config.ISZY then
    human.m_db.bagdb.bagcap = 96
    human.m_db.bagdb.storecap = 96
  end
  if Config.ISZY and human.m_db.checkbug < 1 then
	for k,v in pairs(human.m_db.bagdb.baggrids) do
		local itemtype1 = 物品逻辑.GetItemType1(v.id)
		local itemtype2 = 物品逻辑.GetItemType2(v.id)
		if itemtype1 == 3 and (itemtype2 == 22 or itemtype2 == 24 or itemtype2 == 25 or itemtype2 == 26) then
			human.m_db.bagdb.baggrids[k] = nil
		end
	end
	for k,v in pairs(human.m_db.bagdb.storegrids) do
		local itemtype1 = 物品逻辑.GetItemType1(v.id)
		local itemtype2 = 物品逻辑.GetItemType2(v.id)
		if itemtype1 == 3 and (itemtype2 == 22 or itemtype2 == 24 or itemtype2 == 25 or itemtype2 == 26) then
			human.m_db.bagdb.storegrids[k] = nil
		end
	end
	for k,v in pairs(human.m_db.bagdb.equips) do
		local itemtype1 = 物品逻辑.GetItemType1(v.id)
		local itemtype2 = 物品逻辑.GetItemType2(v.id)
		if itemtype1 == 3 and (itemtype2 == 22 or itemtype2 == 24 or itemtype2 == 25 or itemtype2 == 26) then
			human.m_db.bagdb.equips[k] = nil
		end
	end
	for k,v in pairs(human.m_db.英雄装备) do
		local itemtype1 = 物品逻辑.GetItemType1(v.id)
		local itemtype2 = 物品逻辑.GetItemType2(v.id)
		if itemtype1 == 3 and (itemtype2 == 22 or itemtype2 == 24 or itemtype2 == 25 or itemtype2 == 26) then
			human.m_db.英雄装备[k] = nil
		end
	end
	human.m_db.checkbug = 1
  end
  if Config.ISZY and human.m_db.checkbug < 2 then
	for k,v in pairs(human.m_db.bagdb.baggrids) do
		if v.id >= 14056 and v.id <= 14064 then
			v.bind = 0
		end
	end
	for k,v in pairs(human.m_db.bagdb.storegrids) do
		if v.id >= 14056 and v.id <= 14064 then
			v.bind = 0
		end
	end
	human.m_db.checkbug = 2
  end
  在线账号管理[human:GetAccount()] = human
  
  Npc对话逻辑.CheckHumanTaskAccept(human)
  技能逻辑.CheckSkillLearn(human)
  
  human:CheckAttrLearn()
  human:CalcDynamicAttrImpl()
  if not human.是否新人 and ((human.m_db.hp == 0 and human.m_db.level >= 公共定义.新手保护等级) or 场景管理.GetAutoBack(human.m_db.mapid) == 1 or (human.m_db.mapid == 公共定义.寻宝阁地图 and 寻宝阁状态 == 0) or (human.m_db.mapid == 公共定义.特戒之城地图 and 特戒之城开启 == 0)) then
	if human.m_db.backMapid ~= 0 then
		human.m_db.mapid = human.m_db.backMapid
		human.m_db.x = human.m_db.backX
		human.m_db.y = human.m_db.backY
	else
		local 地图id = human:回城地图()
		local 地图配置 = 地图表[地图id]
		if #地图配置.relivepos == 0 then
			human.m_db.x, human.m_db.y = 场景管理.GetPosCanRun(场景管理.GetSceneId(地图id))
		else
			human.m_db.x = 地图配置.relivepos[1] + math.random(-地图配置.relivepos[3],地图配置.relivepos[3])
			human.m_db.y = 地图配置.relivepos[2] + math.random(-地图配置.relivepos[3],地图配置.relivepos[3])
		end
		human.m_db.mapid = 地图id
	end
  end
  if human.m_db.hp == 0 then
	human.hp = human.hpMax
  else
    human.hp = math.min(human.m_db.hp, human.hpMax)
  end
  
  if human.m_db.mp == 0 then
	human.mp = human.mpMax
  else
    human.mp = math.min(human.m_db.mp, human.mpMax)
  end
  
	local MoveGrid = 场景管理.GetMoveGrid(human.m_db.mapid)
	if MoveGrid then
		human.m_db.x = math.floor(human.m_db.x / MoveGrid[1]) * MoveGrid[1] + MoveGrid[1]/2
		human.m_db.y = math.floor(human.m_db.y / MoveGrid[2]) * MoveGrid[2] + MoveGrid[2]/2
	end
  
  human:UpdateCharCacheAttr(公共定义.CHAR_ATTR_HP, human.hp)
  human:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MP, human.mp)
  human:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXHP, human.hpMax)
  human:UpdateCharCacheAttr(公共定义.CHAR_ATTR_MAXMP, human.mpMax)
  human:SetLogined()
  
  human.m_db.ip = _GetIP(human.id)
  human.m_db.lastLogin = os.time()
  local lastdt = os.date("*t",human.m_db.lastLogout)
  local nowdt = os.date("*t",human.m_db.lastLogin)
  if lastdt.year ~= nowdt.year or lastdt.month ~= nowdt.month or lastdt.day ~= nowdt.day then
	human.m_db.singlecopy = {}
	if human.m_db.转生等级 > 0 then
		--human.m_db.tp = math.max(0,math.min(human.m_db.tp + 50+human.m_db.vip等级*10, 500))
		human:RecoverTP(50+human.m_db.vip等级*10)
	end
	human.m_db.vip领取奖励 = 0
	human.m_db.vip领取等级 = 0
	human.m_db.日常任务次数 = 0
	human.m_db.悬赏任务次数 = 0
	human.m_db.护送押镖次数 = 0
	human.m_db.护送灵兽次数 = 0
	human.m_db.庄园采集次数 = 0
	human.m_db.日限商品购买 = {}
	human.m_db.每日使用次数 = {}
	human.m_db.每日充值 = 0
	--human.m_db.每日充值领取 = {}
	human.m_db.每日采集次数 = 0
	human.m_db.刷新BOSS次数 = 0
  end
  if human.m_db.guildname == "" then
	local passapply = false
	for k,v in pairs(human.m_db.guildapply) do
		local guild = 行会管理.GuildList[k]
		if guild and guild.apply[human:GetName()] == 2 and not passapply then
			local zhanli = human:CalcPower()
			guild.apply[human:GetName()] = nil
			guild.zhanli = guild.zhanli + zhanli
			guild.member[human:GetName()] = {行会定义.GUILD_ZHIWEI_MEMBER,0,zhanli,human.m_db.job,human:GetLevel()}
			guild.num = guild.num + 1
			guild:Save()
			table.sort(行会管理.GuildSorts, 行会管理.CompareRanking)
			human.m_db.guildname = k
			human.m_db.guildapply[k] = nil
			human:SendTipsMsg(1, "#cff00,你的行会申请已经通过")
			passapply = true
		elseif guild and guild.apply[human:GetName()] == nil then
			human.m_db.guildapply[k] = nil
			human:SendTipsMsg(1, "#cffff00,你的行会申请已被拒绝")
		end
	end
	if passapply then
		for k,v in pairs(human.m_db.guildapply) do
			local g = 行会管理.GuildList[k]
			if g then
				g.apply[human:GetName()] = nil
				g:Save()
			end
		end
		human.m_db.guildapply = {}
	end
  end
  if human.m_db.guildname ~= "" then
	local guild = 行会管理.GuildList[human.m_db.guildname]
	if guild and guild.member[human:GetName()] == nil then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "#cffff00,你被踢出行会")
	elseif not guild then
		human.m_db.guildname = ""
		human:SendTipsMsg(1, "行会不存在")
	end
  end
  human:CheckCostTime(human.m_db.mapid)
  日志.Write(日志.LOGID_OSS_LOGIN, os.time(), human:GetAccount(), human:GetName(), human.m_db.level, human.m_db.ip)
  
  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_ASK_LOGIN]
  oReturnMsg.svrname = human.svrname or ""
  oReturnMsg.msvrip = Config.MSVRIP
  oReturnMsg.msvrport = Config.MSVRPORT
  oReturnMsg.result = ret and 公共定义.ASK_LOGIN_OK or 公共定义.ASK_LOGIN_ERROR_CREATE_CHAR
  消息类.SendMsg(oReturnMsg, human.id)
  
  if ret or Config.IS3G then
	human:SendHumanInfoMsg()
	human:SendPropAddPoint()
	human:SendVIPSpread()
	local call = 登录触发._M["call_玩家登录"]
	if call then
		human:显示对话(-3,call(human))
	end
  end
end

function CG_CREATE_ROLE(human, msg)
	if human:GetName() ~= "" then
		return false
	end
    local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	if rolename == "" or rolename:find(" ") or rolename:find("　") or rolename:find("%.") or rolename=="无" or rolename:find("的英雄") then
		human:SendTipsMsg(1,"名字含有非法字符")
		return false
	end
	if human.svrname and human.svrname ~= "" then
		rolename = human.svrname..rolename
	end
	if tonumber(rolename) ~= nil then
		human:SendTipsMsg(1, "名字不能全为数字")
		return
	end
	local db = 玩家DB:New()
	local ret = db:LoadByName(rolename)
	if ret then
		human:SendTipsMsg(1,"角色名字已存在")
		return false
	end
    human.m_db.sex = msg.sex
    human.m_db.job = msg.job
    human.m_db.name = rolename
    human.m_db.createRoleTime = os.time()
	human.m_db.svrname = human.svrname or ""
	human:AddUser()
    human:Save()
	
	技能逻辑.CheckSkillLearn(human)
	human:CheckAttrLearn()
	
  if human.是否新人 and 后台逻辑.spreadhuman[human.m_db.ip] and _CurrentTime() < 后台逻辑.spreadhuman[human.m_db.ip][1] then
	local saccount = 后台逻辑.spreadhuman[human.m_db.ip][2]
	local shuman = 在线账号管理[saccount]
	if 后台逻辑.spreadhuman[human.m_db.ip][3] == 1 then
		human.m_db.代理推广人 = saccount
	elseif not shuman then
		local db = 玩家DB:New()
		local ret = db:LoadByAccount(saccount)
		if ret then
			填写推广人(human, db.name)
			human.m_db.代理推广人 = db.代理推广人 ~= "" and db.代理推广人 or saccount
		else
			human.m_db.代理推广人 = saccount
		end
	else
		填写推广人(human, shuman.m_db.name)
		human.m_db.代理推广人 = shuman.m_db.代理推广人 ~= "" and shuman.m_db.代理推广人 or saccount
	end
  end
	日志.Write(日志.LOGID_OSS_CREATEROLE, os.time(), human:GetAccount(), human:GetName(), human.m_db.sex, human.m_db.job, human.m_db.代理推广人 or "")
	if human.m_nSceneID == -1 then
		human:SendHumanInfoMsg()
		human:SendPropAddPoint()
		human:SendVIPSpread()
		local call = 登录触发._M["call_玩家登录"]
		if call then
			human:显示对话(-3,call(human))
		end
	else
		在线玩家管理[human:GetName()] = human
		聊天逻辑.SendSystemChat("江山代有才人出,欢迎#cffff00,"..human:GetName().."#C进入#cff00ff,"..Config.GAME_NAME)
		human:UpdateObjInfo()
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_CHANGE_JOB]
		oReturnMsg.objid = human.id
		oReturnMsg.rolename = human:GetName()
		oReturnMsg.sex = human.m_db.sex
		oReturnMsg.job = human.m_db.job
		消息类.ZoneBroadCast(oReturnMsg, human.id)
	end
end

function CG_ENTER_SCENE_OK(human, msg)
	if msg.isfirstenter == 1 then
		if human:GetName() ~= "" then
			在线玩家管理[human:GetName()] = human
			聊天逻辑.SendSystemChat("江山代有才人出,欢迎#cffff00,"..human:GetName().."#C进入#cff00ff,"..Config.GAME_NAME)
		end
		human:SetReady()
		human:SetEngineMoveSpeed(human:获取移动速度())
		if human.hpRecoverTimer == nil then
			human.hpRecoverTimer = _AddTimer(human.id, 计时器ID.TIMER_CHAR_HP_RECOVER, 5000, -1)
		end
		if human.attrRefreshTimer == nil then
			human.attrRefreshTimer = _AddTimer(human.id, 计时器ID.TIMER_CHAR_ATTR_REFRESH, 1000, -1)
		end
		if human.xpPrepareTimer == nil then
			human.xpPrepareTimer = _AddTimer(human.id, 计时器ID.TIMER_XP_PREPARE, 10000, 1)
			human.xpstatus = 0
			human.xpcd = 0
			human.xpcdmax = 10000
			human:SendXPInfo()
		end
		human:SendTipsMsg(3, "")
	end
	local nSceneID = human.entersceneid or 场景管理.GetSceneId(human.m_db.mapid, true)
	if nSceneID ~= -1 then
		human:EnterScene(nSceneID, human.m_db.x, human.m_db.y)
		if msg.isfirstenter == 1 then
			human:召唤英雄()
			human:ReCallPet()
			human:ReAddBuff()
			human:CheckXPSkill()
		end
	end
	if human.isreliving then
		human:RecoverHP(human.hpMax)
		human:召唤英雄()
		human:ReCallPet()
		副本管理.ReliveSceneObj(human.m_nSceneID, human)
		human.isreliving = nil
	end
	if msg.isfirstenter == 1 and human.oldmapid and 场景管理.GetIsCopy(human.oldmapid) then
		local mapConfig = 地图表[human.oldmapid]
		if mapConfig.maptype == 4 and human.m_db.singlecopyfinish[human.oldmapid] == 1 then
			副本事件处理.CG_ENTER_COPYSCENE(human,{mapid=human.oldmapid,刷怪数量=human.m_db.副本刷怪数量 or 10})
		end
	end
end

function CG_HUMAN_SETUP(human, msg)
	human.m_db.HP保护 = msg.HP保护
	human.m_db.MP保护 = msg.MP保护
	human.m_db.英雄HP保护 = msg.英雄HP保护
	human.m_db.英雄MP保护 = msg.英雄MP保护
	human.m_db.自动分解白 = msg.自动分解白
	human.m_db.自动分解绿 = msg.自动分解绿
	human.m_db.自动分解蓝 = msg.自动分解蓝
	human.m_db.自动分解紫 = msg.自动分解紫
	human.m_db.自动分解橙 = msg.自动分解橙
	human.m_db.自动分解等级 = msg.自动分解等级
	human.m_db.使用生命药 = msg.使用生命药
	human.m_db.使用魔法药 = msg.使用魔法药
	human.m_db.英雄使用生命药 = msg.英雄使用生命药
	human.m_db.英雄使用魔法药 = msg.英雄使用魔法药
	human.m_db.使用物品HP = msg.使用物品HP
	human.m_db.使用物品ID = msg.使用物品ID
	if human.m_db.vip等级 > 0 then
		human.m_db.自动使用合击 = msg.自动使用合击
	end
	human.m_db.自动分解宠物白 = msg.自动分解宠物白
	human.m_db.自动分解宠物绿 = msg.自动分解宠物绿
	human.m_db.自动分解宠物蓝 = msg.自动分解宠物蓝
	human.m_db.自动分解宠物紫 = msg.自动分解宠物紫
	human.m_db.自动分解宠物橙 = msg.自动分解宠物橙
	if human.m_db.vip等级 > 0 then
		human.m_db.自动孵化宠物蛋 = msg.自动孵化宠物蛋
	end
	if human.m_db.vip等级 > 1 then
		human.m_db.物品自动拾取 = msg.物品自动拾取
	end
end

function CG_MOVE_GRID(human, msg)
	if human.m_nSceneID == -1 then
		return
	end
	--if Config.IS3G then
	--	human.disstarttime = _CurrentTime()
	--	human.disstartx = x
	--	human.disstarty = y
	--	human.displacex = msg.movex
	--	human.displacey = msg.movey
	--	human.displacetime = _CurrentTime() + math.floor(实用工具.GetDistance(x,y,msg.movex,msg.movey,human.Is2DScene,human.MoveGridRate)/human:获取移动速度()*1000)
	--	DisplaceMove[human.id] = human
	--	return
	--end
	if not human.MoveGrid and not Config.IS3G then
		return
	end
	local x,y
	if human.movegrids and #human.movegrids > 0 then
		x = human.movegrids[#human.movegrids][1]
		y = human.movegrids[#human.movegrids][2]
	elseif human.movegridpos then
		x = human.movegridpos[1]
		y = human.movegridpos[2]
	else
		x,y = human:GetPosition()
	end
	if not human:IsPosWalkable(msg.movex, msg.movey) then
	  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_STOP_MOVE]
	  oReturnMsg.objid = human.id
	  oReturnMsg.x = x
	  oReturnMsg.y = y
	  消息类.SendMsg(oReturnMsg, human.id)
		return
	end
	local mx = msg.movex - x
	local my = (msg.movey - y)*(Config.IS3G and 2 or human.MoveGrid[1]/human.MoveGrid[2])
	local dist = math.sqrt(mx * mx + my * my)
	if dist > (Config.IS3G and 50 or human.MoveGrid[1]) * 2 then
	  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_STOP_MOVE]
	  oReturnMsg.objid = human.id
	  oReturnMsg.x = x
	  oReturnMsg.y = y
	  消息类.SendMsg(oReturnMsg, human.id)
		return
	end
	if human.buffend[公共定义.隐身BUFF] then
		技能逻辑.DoRemoveBuff(human, 公共定义.隐身BUFF)
	end
	local time = math.floor(dist/human:获取移动速度()*1000)
	--print(math.floor(dist),time)
	--if human.movegridtimer then
	--	_DelTimer(human.movegridtimer, human.id)
	--	human.movegridtimer = nil
	--end
	if human.movegridpos then
		human:ChangePosition(human.movegridpos[1], human.movegridpos[2])
		human.movegridpos = nil
	end
	if human.movegridpos then
		--human.movegrids = human.movegrids or {}
		--human.movegrids[#human.movegrids+1] = {msg.movex, msg.movey, time}
	else
		human.movegridpos = {msg.movex, msg.movey}
		human.movegrids = nil
		--human.movegridtimer = _AddTimer(human.id, 计时器ID.TIMER_HUMAN_MOVEGRID, time, 1)
		human.movegridtime = _CurrentTime() + time
		local oMsg = 派发器.ProtoContainer[协议ID.GC_MOVE]
		oMsg.objid = human.id
		oMsg.objtype = human:GetObjType()
		oMsg.posx = x
		oMsg.posy = y
		oMsg.movex = msg.movex
		oMsg.movey = msg.movey
		消息类.ZoneBroadCast(oMsg, human.id)
	end
end

function GG_DISCONNECT(nObjFD, msg)
	local human = 玩家对象类:GetObj(nObjFD)
	if human == nil or human:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN then
		return
	end
	human:DoDisconnect(msg.reason)
	--human.m_db.lastLogout = os.time()
	--日志.WriteLog(日志.LOGID_USER_OUTLIFE, human:GetAccount() .. " Logout reason:" .. msg.reason)
	--日志.Write(日志.LOGID_OSS_LOGOUT, os.time(), human:GetAccount(), human:GetName(), human.m_db.level, os.time() - human.m_db.lastLogin, human.m_db.ip, msg.reason, human.m_db.mapid, human:GetPosition())
	--human:CleanFD()
	--human:Destroy()
end

function CG_HEART_BEAT(human, msg)
  --print("HeartBeat", human.id)
end

function CG_TRANSPORT(human, msg)
	if human.hp <= 0 then
		return
	end
	if human.m_nSceneID == -1 then
		return
	end
	local conf = 地图表[msg.mapid]
	if not conf then
		return
	end
	if conf.maptype ~= 0 then
		return
	end
	if msg.mapid == 公共定义.寻宝阁地图 and 寻宝阁状态 ~= 1 then
		human:SendTipsMsg(1,"寻宝阁暂未开启")
		return
	end
	if msg.mapid == 公共定义.特戒之城地图 and 特戒之城开启 == 0 then
		human:SendTipsMsg(1,"特戒之城暂未开启")
		return
	end
	local nSceneID = 场景管理.GetSceneId(msg.mapid, true)
	if nSceneID == -1 then
		human:SendTipsMsg(1,"目标点无法到达")
		return
	end
	if (msg.posx ~= -1 or msg.posy ~= -1) and not _IsPosCanRun(nSceneID, msg.posx, msg.posy) then
		human:SendTipsMsg(1,"目标点无法到达")
		return
	end
	if nSceneID ~= human.m_nSceneID then
		if human.m_db.level < conf.level then
			human:SendTipsMsg(1,"等级不足")
			return
		end
		if human.m_db.转生等级 < conf.转生等级 then
			human:SendTipsMsg(1,"转生等级不足")
			return
		end
		if human.m_db.vip等级 < conf.viplevel then
			human:SendTipsMsg(1,"VIP等级不足")
			return
		end
	end
	if 公共定义.传送卷ID ~= 0 then
		if 背包DB.CheckCount(human, 公共定义.传送卷ID) < 1 then
			human:SendTipsMsg(1,"快捷传送卷数量不足")
			return
		end
		背包DB.RemoveCount(human, 公共定义.传送卷ID, 1)
	end
	if conf.转生等级 > 0 or (msg.posx == -1 and msg.posy == -1) then
		human:RandomTransport(msg.mapid)
	else
		human:Transport(msg.mapid, msg.posx, msg.posy)
	end
end

function GetXPSkillID(human)
	if human.xpskill == 3 then
		return 1153
	elseif human.m_db.job == 1 and human.m_db.英雄职业 == 1 then
		return 1140
	elseif (human.m_db.job == 1 and human.m_db.英雄职业 == 2) or (human.m_db.job == 2 and human.m_db.英雄职业 == 1) then
		return 1142
	elseif (human.m_db.job == 1 and human.m_db.英雄职业 == 3) or (human.m_db.job == 3 and human.m_db.英雄职业 == 1) then
		return 1141
	elseif human.m_db.job == 2 and human.m_db.英雄职业 == 2 then
		return 1145
	elseif (human.m_db.job == 2 and human.m_db.英雄职业 == 3) or (human.m_db.job == 3 and human.m_db.英雄职业 == 2) then
		return 1144
	elseif human.m_db.job == 3 and human.m_db.英雄职业 == 3 then
		return 1143
	else
		return 0
	end
end

function CG_XP_USE(human, msg)
	if human.hp <= 0 then
		return
	end
	if human.xpstatus ~= 1 then
		return
	end
	--[[if msg.headid == 10241 then
		human.avatarid = 2184
		human:ChangeBody()
		技能逻辑.SendSkillInfo(human)
	elseif msg.headid == 10291 then
		human.avatarid = 2191
		human:ChangeBody()
		技能逻辑.SendSkillInfo(human)
	else
		return
	end]]
	if not human.英雄 then
		human:SendTipsMsg(1,"请先召唤英雄")
		return
	end
	if human.英雄:IsDead() then
		human:SendTipsMsg(1,"英雄已经死亡")
		return
	end
	if msg.targetid == -1 then
		human:SendTipsMsg(1,"请选择一个目标")
		return
	end
	local target = 对象类:GetObj(msg.targetid)
	if not target then
		human:SendTipsMsg(1,"请选择一个目标")
		return
	end
	local skillid = GetXPSkillID(human)
	if skillid == 0 then
		return
	end
	local posx, posy = target:GetPosition()
	if not 技能逻辑.DoUseSkill(human, skillid, msg.targetid, posx, posy) then
		return
	end
	if skillid ~= 1153 then
		local conf = 技能表[skillid]
		local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_USE_SKILL]
		oReturnMsg.objid = human.英雄.id
		oReturnMsg.targetid = msg.targetid
		oReturnMsg.skillid = skillid
		oReturnMsg.action = conf.act
		oReturnMsg.effid1 = conf.eff1
		oReturnMsg.effid2 = conf.eff2
		oReturnMsg.effid3 = conf.eff3
		oReturnMsg.posx = posx
		oReturnMsg.posy = posy
		if conf.eff3 ~= 0 and #conf.hitpoint > 0 then
			oReturnMsg.flytime = math.max(0,conf.hitpoint[1] - 200)
		else
			oReturnMsg.flytime = 0
		end
		消息类.ZoneBroadCast(oReturnMsg, human.英雄.id)
	end
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_XP_USE]
	oReturnMsg.objid = human.id
	oReturnMsg.effid = 3649
	消息类.ZoneBroadCast(oReturnMsg, human.id)
	--if human.xpUseDownTimer == nil then
		human.xpUseDownTimer = _AddTimer(human.id, 计时器ID.TIMER_XP_FINISH, 1000, 1)
	--end
	human.xpstatus = 2
	human.xpcd = 10000
	human.xpcdmax = 10000
	human:SendXPInfo()
end

function CG_USE_MOUNT(human, msg)
	if human.hp <= 0 then
		return
	end
	if human.mountid == msg.mountid then
		return
	end
	human.mountid = msg.mountid
	human:ChangeBody()
end

function CG_USE_WING(human, msg)
	if human.hp <= 0 then
		return
	end
	if human.wingid == msg.wingid then
		return
	end
	human.wingid = msg.wingid
	human:ChangeBody()
end

function CG_REQUEST_RELIVE(human, msg)
	human:OnRelive()
end

function CG_EQUIP_VIEW(human, msg)
	local viewhuman
	if msg.objid ~= -1 then
		viewhuman = 玩家对象类:GetObj(msg.objid)
	else
		local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
		local p = rolename:find("的英雄")
		if p then
			viewhuman = 在线玩家管理[rolename:sub(1,p-1)]
		else
			viewhuman = 在线玩家管理[rolename]
		end
		if p and viewhuman then
			viewhuman = viewhuman.英雄
		end
	end
	if viewhuman then
		human:SendEquipView(viewhuman)
	else
		human:SendTipsMsg(1,"玩家不在线,无法查看")
	end
end

function CG_PROP_ADDPOINT(human, msg)
	local 点数 = 0
	for k,v in pairs(human.m_db.转生加点) do
		点数 = 点数 + v
	end
	
	human.m_db.转生加点[msg.类型] = (human.m_db.转生加点[msg.类型] or 0) + 1
	
	human:SendDetailAttr()
	human:SendTipsMsg(1,"#cffff00,属性加点成功")
	human:更新属性点()
	
end

function CG_VIP_REWARD(human, msg)
	if human.m_db.vip领取奖励 == 1 and human.m_db.vip领取等级 >= human.m_db.vip等级 then
		human:SendTipsMsg(1,"#cffff00,尊敬的VIP,#C今日已领取奖励,请明天再来")
		return
	end
	if human.m_db.vip等级 == 0 then
		human:SendTipsMsg(1,"你不是VIP,无法领取奖励")
		return
	end
	local cnt = 背包逻辑.GetEmptyIndexCount(human)
	if cnt < math.ceil(human.m_db.vip等级/2) then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	local indexs = {}
	local 奖励 = nil
	if Config.ISWZ then
		if human.m_db.vip等级 == 1 then
			奖励 = {{19000, 1000000},{10100, 1}}
		elseif human.m_db.vip等级 == 2 then
			奖励 = {{19000, 2000000},{10100, 2}}
		elseif human.m_db.vip等级 == 3 then
			奖励 = {{19000, 3000000},{10100, 3}}
		elseif human.m_db.vip等级 == 4 then
			奖励 = {{19000, 4000000},{10100, 4}}
		elseif human.m_db.vip等级 == 5 then
			奖励 = {{19000, 5000000},{10100, 5}}
		elseif human.m_db.vip等级 == 6 then
			奖励 = {{19000, 6000000},{10100, 6}}
		elseif human.m_db.vip等级 == 7 then
			奖励 = {{19000, 7000000},{10100, 7}}
		elseif human.m_db.vip等级 == 8 then
			奖励 = {{19000, 8000000},{10100, 8}}
		elseif human.m_db.vip等级 == 9 then
			奖励 = {{19000, 9000000},{10100, 9}}
		elseif human.m_db.vip等级 == 10 then
			奖励 = {{19000, 10000000},{10100, 10}}
		else
			return
		end
		if human.m_db.vip领取等级 == 1 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 1000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 1
				end
			end
		elseif human.m_db.vip领取等级 == 2 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 2000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 2
				end
			end
		elseif human.m_db.vip领取等级 == 3 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 3000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 3
				end
			end
		elseif human.m_db.vip领取等级 == 4 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 4000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 4
				end
			end
		elseif human.m_db.vip领取等级 == 5 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 5000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 5
				end
			end
		elseif human.m_db.vip领取等级 == 6 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 6000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 6
				end
			end
		elseif human.m_db.vip领取等级 == 7 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 7000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 7
				end
			end
		elseif human.m_db.vip领取等级 == 8 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 8000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 8
				end
			end
		elseif human.m_db.vip领取等级 == 9 then
			for i,v in ipairs(奖励) do
				if v[1] == 19000 then
					v[2] = v[2] - 9000000
				elseif v[1] == 10100 then
					v[2] = v[2] - 9
				end
			end
		end
	else
		if human.m_db.vip等级 == 1 then
			奖励 = {{10002, 1000000},{10036, 1}}
		elseif human.m_db.vip等级 == 2 then
			奖励 = {{10002, 2000000},{10036, 2}}
		elseif human.m_db.vip等级 == 3 then
			奖励 = {{10002, 3000000},{10036, 2},{10037, 1}}
		elseif human.m_db.vip等级 == 4 then
			奖励 = {{10002, 4000000},{10036, 2},{10037, 2}}
		elseif human.m_db.vip等级 == 5 then
			奖励 = {{10002, 5000000},{10036, 2},{10037, 2},{10038, 1}}
		elseif human.m_db.vip等级 == 6 then
			奖励 = {{10002, 6000000},{10036, 2},{10037, 2},{10038, 2}}
		elseif human.m_db.vip等级 == 7 then
			奖励 = {{10002, 7000000},{10036, 2},{10037, 2},{10038, 2},{10039, 1}}
		elseif human.m_db.vip等级 == 8 then
			奖励 = {{10002, 8000000},{10036, 2},{10037, 2},{10038, 2},{10039, 2}}
		elseif human.m_db.vip等级 == 9 then
			奖励 = {{10002, 9000000},{10036, 2},{10037, 2},{10038, 2},{10039, 2},{10040, 1}}
		elseif human.m_db.vip等级 == 10 then
			奖励 = {{10002, 10000000},{10036, 2},{10037, 2},{10038, 2},{10039, 2},{10040, 2}}
		else
			return
		end
		if human.m_db.vip领取等级 == 1 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 1000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 1
				end
			end
		elseif human.m_db.vip领取等级 == 2 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 2000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				end
			end
		elseif human.m_db.vip领取等级 == 3 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 3000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				elseif v[1] == 10037 then
					v[2] = v[2] - 1
				end
			end
		elseif human.m_db.vip领取等级 == 4 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 4000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				elseif v[1] == 10037 then
					v[2] = v[2] - 2
				end
			end
		elseif human.m_db.vip领取等级 == 5 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 5000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				elseif v[1] == 10037 then
					v[2] = v[2] - 2
				elseif v[1] == 10038 then
					v[2] = v[2] - 1
				end
			end
		elseif human.m_db.vip领取等级 == 6 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 6000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				elseif v[1] == 10037 then
					v[2] = v[2] - 2
				elseif v[1] == 10038 then
					v[2] = v[2] - 2
				end
			end
		elseif human.m_db.vip领取等级 == 7 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 7000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				elseif v[1] == 10037 then
					v[2] = v[2] - 2
				elseif v[1] == 10038 then
					v[2] = v[2] - 2
				elseif v[1] == 10039 then
					v[2] = v[2] - 1
				end
			end
		elseif human.m_db.vip领取等级 == 8 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 8000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				elseif v[1] == 10037 then
					v[2] = v[2] - 2
				elseif v[1] == 10038 then
					v[2] = v[2] - 2
				elseif v[1] == 10039 then
					v[2] = v[2] - 2
				end
			end
		elseif human.m_db.vip领取等级 == 9 then
			for i,v in ipairs(奖励) do
				if v[1] == 10002 then
					v[2] = v[2] - 9000000
				elseif v[1] == 10036 then
					v[2] = v[2] - 2
				elseif v[1] == 10037 then
					v[2] = v[2] - 2
				elseif v[1] == 10038 then
					v[2] = v[2] - 2
				elseif v[1] == 10039 then
					v[2] = v[2] - 2
				elseif v[1] == 10040 then
					v[2] = v[2] - 1
				end
			end
		end
	end
	for i,v in ipairs(奖励) do
		if v[2] > 0 then
			local inds = human:PutItemGrids(v[1], v[2], 1, true)
			if inds then
				for i,v in ipairs(inds) do
					背包逻辑.InsertIndexes(indexs, v)
				end
			end
			if v[1] == 公共定义.经验物品ID then
				human:SendTipsMsg(2, "获得经验#cff00,"..v[2])
			elseif v[1] == 公共定义.金币物品ID then
				human:SendTipsMsg(2, "获得绑定金币#cffff00,"..v[2])
			elseif v[1] == 公共定义.元宝物品ID then
				human:SendTipsMsg(2, "获得绑定元宝#cffff00,"..v[2])
			else
				human:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(v[1])]..物品逻辑.GetItemName(v[1])..(v[2] > 1 and "x"..v[2] or ""))
			end
		end
	end
	if #indexs > 0 then
		背包逻辑.SendBagQuery(human, indexs)
	end
	human.m_db.vip领取奖励 = 1
	human.m_db.vip领取等级 = human.m_db.vip等级
	human:SendTipsMsg(1,"#cffff00,尊敬的VIP,#cff00,奖励已到达背包,欢迎明天再来")
end

function CG_VIP_SPREAD(human, msg)
	if not msg.礼包领取 then
		return
	end
	local 礼包领取1 = msg.礼包领取[1] or 0
	local 礼包领取2 = msg.礼包领取[2] or 0
	if 礼包领取1 ~= 0 or 礼包领取2 ~= 0 then
		local 礼包表 = msg.每日充值领取 == 1 and 每日充值表 or VIP礼包表
		if not 礼包表[礼包领取1] or not 礼包表[礼包领取1].奖励[礼包领取2] then
			human:SendTipsMsg(1,"找不到该奖励")
			return
		end
		local 礼包 = 礼包表[礼包领取1]
		if human.m_db.vip等级 < 礼包.领取VIP then
			human:SendTipsMsg(1,"VIP等级不足")
			return
		end
		local 总充值 = human.m_db.总充值--msg.每日充值领取 == 1 and human.m_db.每日充值 or human.m_db.总充值
		if 总充值 < 礼包.领取充值 then
			human:SendTipsMsg(1,"总充值不足")
			return
		end
		local index = 背包逻辑.GetEmptyIndex(human)
		if not index then
			human:SendTipsMsg(1,"背包不足")
			return
		end
		local 物品 = 礼包表[礼包领取1].奖励[礼包领取2]
		local grade = 物品[1]==2 and 物品[5] or nil
		local wash = 物品[1]==2 and 拾取物品逻辑.自动极品属性(物品[5]-1,物品[5]-1) or nil
		local indexs = human:PutItemGrids(物品[2], 物品[4], 1, false, grade, nil, wash, nil) or {}
		if #indexs > 0 then
			背包逻辑.SendBagQuery(human, indexs)
		end
		--human.m_db.bagdb.baggrids[index] = {id=物品[2],count=物品[4],bind=1,cd=0,grade=grade,wash=wash}
		--背包逻辑.SendBagQuery(human, {index})
		if msg.每日充值领取 == 1 then
			human.m_db.每日充值领取[礼包领取1] = 1
		else
			human.m_db.VIP礼包领取[礼包领取1] = 1
		end
		if 物品[2] == 公共定义.金币物品ID then
			human:SendTipsMsg(2, "获得绑定金币#cffff00,"..物品[4])
		elseif 物品[2] == 公共定义.元宝物品ID then
			human:SendTipsMsg(2, "获得绑定元宝#cffff00,"..物品[4])
		else
			human:SendTipsMsg(2, "获得物品"..广播.colorRgb[grade or 物品逻辑.GetItemGrade(物品[2])]..物品逻辑.GetItemName(物品[2],物品逻辑.GetItemBodyID(物品[2]))..(物品[4] > 1 and "x"..物品[4] or ""))
		end
		human:SendTipsMsg(0,"#cff00,领取成功")
		human:SendVIPSpread()
		return
	end
    local rolename = 实用工具.GetStringFromTable(msg.rolenameLen, msg.rolename)
	填写推广人(human, rolename)
end

function 填写推广人(human, rolename)
	if human.m_db.VIP推广人 ~= "" then
		human:SendTipsMsg(1,"你已经填写过推广人了")
		return
	end
	if human:GetName() == rolename then
		human:SendTipsMsg(1,"推广人不能填写自己")
		return
	end
	local cnt = 背包逻辑.GetEmptyIndexCount(human)
	if cnt < 3 then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	local 推广人 = 在线玩家管理[rolename]
	if 推广人 then
		推广人.m_db.VIP推广人数 = 推广人.m_db.VIP推广人数 + 1
		推广人:SendVIPSpread()
		if human.m_db.总充值 >= 50 and human.m_db.VIP推广人成长 == 0 then
			后台逻辑.VIP推广成长(rolename)
			human.m_db.VIP推广人成长 = 1
		end
	else
		local db = 玩家DB:New()
		local ret = db:LoadByName(rolename)
		if ret then
			db.VIP推广人数 = (db.VIP推广人数 or 0) + 1
			db:Save()
			if human.m_db.总充值 >= 50 and human.m_db.VIP推广人成长 == 0 then
				后台逻辑.VIP推广成长(rolename)
				human.m_db.VIP推广人成长 = 1
			end
		else
			human:SendTipsMsg(1,"找不到此推广人,请检查是否填写错误")
			return
		end
	end
	local indexs = {}
	local 奖励 = Config.ISWZ and {{10071,1},{10100,1},{10075,1}} or {{10016,1},{10027,1},{10017,1}}
	for i,v in ipairs(奖励) do
		local inds = human:PutItemGrids(v[1], v[2], 1, true)
		if inds then
			for i,v in ipairs(inds) do
				背包逻辑.InsertIndexes(indexs, v)
			end
		end
		if v[1] == 公共定义.经验物品ID then
			human:SendTipsMsg(2, "获得经验#cff00,"..v[2])
		elseif v[1] == 公共定义.金币物品ID then
			human:SendTipsMsg(2, "获得绑定金币#cffff00,"..v[2])
		elseif v[1] == 公共定义.元宝物品ID then
			human:SendTipsMsg(2, "获得绑定元宝#cffff00,"..v[2])
		else
			human:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(v[1])]..物品逻辑.GetItemName(v[1])..(v[2] > 1 and "x"..v[2] or ""))
		end
	end
	if #indexs > 0 then
		背包逻辑.SendBagQuery(human, indexs)
	end
	human.m_db.VIP推广人 = rolename
	human:SendTipsMsg(1,"#cffff00,绑定推广人成功")
	human:SendVIPSpread()
end

特戒抽取表 = {}
王者宝藏表 = {}
for i,v in ipairs(福利抽奖表) do
	if v.类型 == 0 then
		特戒抽取表[#特戒抽取表+1] = v
	else
		王者宝藏表[#王者宝藏表+1] = v
	end
end

function CG_DRAW_SRING(human, msg)
	if human.hp <= 0 then
		return
	end
	if msg.drawcnt ~= 1 and msg.drawcnt ~= 10 then
		return
	end
	if msg.type ~= 1 and human.m_db.特戒抽取次数 + msg.drawcnt > human.m_db.总充值 then--1 + math.min(500, human.m_db.每日充值) then
		human:SendTipsMsg(1,"特戒抽取次数已达上限")
		return
	end
	if msg.type == 1 and human.m_db.rmb < 200 * msg.drawcnt then
		human:SendTipsMsg(1,"元宝不足")
		return
	end
	local cnt = 背包逻辑.GetEmptyIndexCount(human)
	if cnt < msg.drawcnt then
		human:SendTipsMsg(1,"背包不足")
		return
	end
	local 抽奖表 = msg.type == 1 and 王者宝藏表 or 特戒抽取表
	--local 碎片1 = {10149,10150,10151}
	--local 碎片2 = {10152,10153,10154,10155,10156,10157,10158,10159,10160,10161,10162,10163}
	--local 碎片 = {10149,10150,10151,10152,10153,10154,10155,10156,10157,10158,10159,10160,10161,10162,10163}
	--local 特戒 = {13101,13102,13103,13104,13105,13106,13107,13108,13109,13110,13111,13112,13113,13114,13115}
	local indexs = {}
	for i=1, msg.drawcnt do
		local 物品id
		local prizeconf={}
		local weight=0
		for _,奖品 in ipairs(抽奖表) do
			if 奖品.概率 > 0 then
				prizeconf[#prizeconf+1] = 奖品
				weight = weight + 奖品.概率
			end
		end
		local wei = math.random(1,weight)
		weight=0
		local 是否非绑 = 0
		local 是否广播 = 0
		for _,奖品 in ipairs(prizeconf) do
			weight = weight + 奖品.概率
			if wei <= weight then
				物品id = 奖品.奖励[2]
				是否非绑 = 奖品.非绑
				是否广播 = 奖品.广播
				break
			end
		end
		--if human.m_db.特戒抽取次数 == 0 or math.random(1,100) > 10 then
		--	物品id = 碎片2[math.random(1,#碎片2)]--碎片[math.random(1,#碎片)]
		--else
		--	物品id = 碎片1[math.random(1,#碎片1)]--特戒[math.random(1,#特戒)]
		--end
		local inds = human:PutItemGrids(物品id, 1, 是否非绑 == 0 and 1 or 0, true)
		if inds then
			for i,v in ipairs(inds) do
				背包逻辑.InsertIndexes(indexs, v)
			end
		end
		if 是否广播 == 1 then
			local msg = "恭喜玩家#cffff00,"..human:GetName().."#C抽奖获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(物品id)]..物品逻辑.GetItemName(物品id).."#C,如果你也想获得,请快来抽奖吧"
			for _,v in pairs(在线玩家管理) do
				v:SendTipsMsg(4, msg)
			end
			聊天逻辑.SendSystemChat(msg)
		end
		human:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(物品id)]..物品逻辑.GetItemName(物品id))
	end
	if #indexs > 0 then
		背包逻辑.SendBagQuery(human, indexs)
	end
	if msg.type ~= 1 then
		human.m_db.特戒抽取次数 = human.m_db.特戒抽取次数 + msg.drawcnt
	end
	if msg.type == 1 then
		human:DecRmb(200 * msg.drawcnt)
	end
	human:SendTipsMsg(1,"#cff00,恭喜成功抽奖")
end

function CG_CHANGE_STATUS(human, msg)
	if human.hp <= 0 then
		return
	end
	human:ChangeStatus(msg.status, msg.pkmode)
	if human.英雄 and human.英雄.m_status ~= human.m_status then
		--human.英雄.m_status = human.m_status
		human.英雄:ChangeStatus(human.m_status, 0)
	end
end

function CG_CHANGE_JOB(human, msg)
	if human.hp <= 0 then
		return
	end
	if msg.job < 1 or msg.job > 7 then
		return
	end
	human:ChangeJob(msg.job)
end

function CG_COLLECT_START(human, msg)
	if human.hp <= 0 then
		return
	end
	if human.m_db.每日采集次数 >= 100 then
		human:SendTipsMsg(1,"今日采集次数已达上限")
		return
	end
	if human.collectid ~= -1 and msg.objid == -1 then
		human:StopCollect()
		return
	end
	if human.collectid ~= -1 and msg.objid ~= human.collectid then
		human:SendTipsMsg(1,"你已经正在采集中")
		return
	end
	if human.collectid ~= -1 and msg.objid == human.collectid then
		return
	end
	local 采集物 = 对象类:GetObj(msg.objid)
	if not 采集物 or 采集物:GetObjType() ~= 公共定义.OBJ_TYPE_COLLECT then
		return
	end
	if 采集物.m_nSceneID == -1 or 采集物.m_nSceneID ~= human.m_nSceneID then
		return
	end
	if 采集物.collecter ~= -1 then
		human:SendTipsMsg(1,"该物品正在被采集")
		return
	end
	human.collectid = 采集物.id
	采集物.collecter = human.id
	采集物.collecttimer = _AddTimer(msg.objid, 计时器ID.TIMER_MONSTER_COLLECT,5000,1, human.id, 0, 0)
	local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_COLLECT_START]
	oReturnMsg.objid = msg.objid
	消息类.SendMsg(oReturnMsg, human.id)
end

function CG_SHOW_FASHION(human, msg)
	human.m_db.显示时装 = msg.显示时装
	human.m_db.英雄显示时装 = msg.英雄显示时装
	human.m_db.显示炫武 = msg.显示炫武
	human.m_db.英雄显示炫武 = msg.英雄显示炫武
	human:ChangeBody()
	if human.英雄 then
		human.英雄.m_db.显示时装 = msg.英雄显示时装
		human.英雄.m_db.显示炫武 = msg.英雄显示炫武
		human.英雄:ChangeBody()
	end
end

function CG_COMMAND_MSG(human, msg)
    local msgtxt = 实用工具.GetStringFromTable(msg.msgLen, msg.msg)
	if msg.type == 4 then
		local ss = 实用工具.SplitString(msgtxt, ",")
		if #ss < 2 then
			human:SendTipsMsg(1,"请放入物品")
			return
		end
		local cont1,pos1 = tonumber(ss[1]) or 0, tonumber(ss[2]) or 0
		if cont1 == 2 and not human.英雄 then
			human:SendTipsMsg(1,"请先召唤英雄")
			return
		end
		local bagdb = human.m_db.bagdb
		local baggrids1 = cont1 == 1 and bagdb.equips or cont1 == 2 and human.m_db.英雄装备 or bagdb.baggrids
		local grid1 = baggrids1[pos1]
		if grid1 == nil or grid1.count == 0 then
			human:SendTipsMsg(1,"请放入物品")
			return
		end
		human.私人变量.S0 = 物品逻辑.GetItemName(grid1.id)
		local call = 事件触发._M["call_物品投放_"..(human.openitemindex or 1)]
		if call then
			human:显示对话(-2,call(human))
		end
		grid1.count = grid1.count - 1
		if grid1.count == 0 then
			baggrids1[pos1] = nil
		end
		if cont1 == 1 then
			human:CalcDynamicAttr()
			背包逻辑.SendEquipQuery(human, {pos1})
		elseif cont1 == 2 then
			human.英雄:CalcDynamicAttr()
			human:SendEquipView(human.英雄, true)
		else
			背包逻辑.SendBagQuery(human, {pos1})
		end
	elseif msg.type == 5 then
		local ss = 实用工具.SplitString(msgtxt, ",")
		if #ss < 6 then
			human:SendTipsMsg(1,"请放入装备与宝石")
			return
		end
		local cont1,pos1 = tonumber(ss[1]) or 0, tonumber(ss[2]) or 0
		local cont2,pos2 = tonumber(ss[3]) or 0, tonumber(ss[4]) or 0
		local cont3,pos3 = tonumber(ss[5]) or 0, tonumber(ss[6]) or 0
		if (cont1 == 2 or cont2 == 2 or cont3 == 2) and not human.英雄 then
			human:SendTipsMsg(1,"请先召唤英雄")
			return
		end
		local bagdb = human.m_db.bagdb
		local baggrids1 = cont1 == 1 and bagdb.equips or cont1 == 2 and human.m_db.英雄装备 or bagdb.baggrids
		local grid1 = baggrids1[pos1]
		if grid1 == nil or grid1.count == 0 or not 物品逻辑.IsEquip(grid1.id) then
			human:SendTipsMsg(1,"请放入装备")
			return
		end
		local grid2 = bagdb.baggrids[pos2]
		if grid2 == nil or grid2.count == 0 or not 物品逻辑.IsStone(grid2.id) then
			human:SendTipsMsg(1,"请放入宝石")
			return
		end
		local grid3 = bagdb.baggrids[pos3]
		if not (grid3 == nil or grid3.count == 0) and not 物品逻辑.IsLuckStone(grid3.id) then
			human:SendTipsMsg(1,"请放入幸运石")
			return
		end
		human.stoneupgrade0 = grid1.id
		human.stoneupgrade1 = grid2.id
		human.stoneupgradefail = nil
		local call = 事件触发._M["call_宝石升级"]
		if call then
			human:显示对话(-2,call(human))
		end
		if human.stoneupgradefail then
			human:SendTipsMsg(1,"宝石升级条件不符")
			return
		end
		local conf = 物品表[grid2.id]
		if not conf then
			return
		end
		if (conf.propex[1] or 0) ~= 0 and (conf.propex[1] or 0) ~= 物品逻辑.GetItemType2(grid1.id) then
			human:SendTipsMsg(1,"宝石升级条件不符")
			return
		end
		grid1.wash = grid1.wash or {}
		local cnt = 0
		for i,v in ipairs(grid1.wash) do
			if 公共定义.属性文字[v[1]] then
				cnt = cnt + v[2]
			end
		end
		if (conf.propex[2] or 0) > cnt or ((conf.propex[3] or 0) > 0 and (conf.propex[3] or 0) <= cnt) then
			human:SendTipsMsg(1,"宝石升级条件不符")
			return
		end
		local luckrate = conf.bodyid + ((grid3 and grid3.count > 0) and 物品逻辑.GetItemBodyID(grid3.id) or 0)
		local bagindexs = {}
		if math.random(1,100) > luckrate then
			if conf.propex[4] == 1 then
				for i=#grid1.wash,1,-1 do
					if 公共定义.属性文字[grid1.wash[i][1]] then
						table.remove(grid1.wash, i)
					end
				end
				human:SendTipsMsg(1,"宝石升级失败,属性已清除")
			elseif conf.propex[4] == 2 then
				baggrids1[pos1] = nil
				human:SendTipsMsg(1,"宝石升级失败,装备已破碎")
			else
				human:SendTipsMsg(1,"#cffff00,宝石升级失败")
			end
			if conf.propex[4] == 1 or conf.propex[4] == 2 then
				if cont1 == 1 then
					human:CalcDynamicAttr()
					背包逻辑.SendEquipQuery(human, {pos1})
				elseif cont1 == 2 then
					human.英雄:CalcDynamicAttr()
					human:SendEquipView(human.英雄, true)
				else
					bagindexs[#bagindexs+1] = pos1
				end
			end
		else
			for i,v in ipairs(conf.prop) do
				local index = nil
				for ii,vv in ipairs(grid1.wash) do
					if vv[1] == v[1] then
						vv[2] = vv[2] + (v[2] or 1)
						index = ii
						break
					end
				end
				if index == nil then
					grid1.wash[#grid1.wash+1] = {v[1],v[2] or 1}
				end
			end
			for i=1,conf.effid do
				local proptype = math.random(1,公共定义.属性_幸运-1)
				local index = nil
				for ii,vv in ipairs(grid1.wash) do
					if vv[1] == proptype then
						vv[2] = vv[2] + 1
						index = ii
						break
					end
				end
				if index == nil then
					grid1.wash[#grid1.wash+1] = {proptype,1}
				end
			end
			if cont1 == 1 then
				human:CalcDynamicAttr()
				背包逻辑.SendEquipQuery(human, {pos1})
			elseif cont1 == 2 then
				human.英雄:CalcDynamicAttr()
				human:SendEquipView(human.英雄, true)
			else
				bagindexs[#bagindexs+1] = pos1
			end
			human:SendTipsMsg(1,"#cff00,宝石升级成功")
		end
		grid2.count = grid2.count - 1
		if grid2.count == 0 then
			bagdb.baggrids[pos2] = nil
		end
		bagindexs[#bagindexs+1] = pos2
		if grid3 and grid3.count > 0 then
			grid3.count = grid3.count - 1
			if grid3.count == 0 then
				bagdb.baggrids[pos3] = nil
			end
			bagindexs[#bagindexs+1] = pos3
		end
		背包逻辑.SendBagQuery(human, bagindexs)
	end
end

function OnCharRealDestroy(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
end

function OnRefreshAttr(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	local human = 玩家对象类:GetObj(nObjID)
	if not human or human.m_nSceneID == -1 then
		return
	end
	if human.hp == 0 and human.viewid ~= -1 and human.m_nSceneID ~= -1 then
		local viewer = 对象类:GetObj(human.viewid)
		if viewer and viewer.m_nSceneID == human.m_nSceneID then
			human:JumpScene(viewer.m_nSceneID, viewer:GetPosition())
		end
	end
	if human.autoquitscene and human.autoquitscene > 0 then
		human.autoquitscene = human.autoquitscene - 1
		if human.autoquitscene == 0 and 场景管理.IsCopyscene(human.m_nSceneID) then
			local sceneid = 场景管理.GetSceneId(human.m_db.prevMapid)
			if sceneid ~= -1 then
				human:JumpScene(sceneid, human.m_db.prevX, human.m_db.prevY)
			end
			human.autoquitscene = nil
		else
			human:SendTipsMsg(0, "#s16,等待#c00ffff,"..human.autoquitscene.."#C秒后自动退出")
		end
	end
	if human.relivesecond and human.relivesecond > 0 then
		human.relivesecond = human.relivesecond - 1
		if human.relivesecond == 0 then
			human:OnRelive()
			human.relivesecond = nil
		else
			human:SendTipsMsg(0, "#s16,等待#c00ffff,"..human.relivesecond.."#C秒后复活")
		end
	end
	if human.updateInfoTime and human.updateInfoTime > _CurrentTime() then
		human:UpdateObjInfo()
	elseif human.updateInfoTime then
		human.updateInfoTime = nil
	end
	local mapid = 场景管理.GetMapId(human.m_nSceneID)
	local x,y = human:GetPosition()
	local ret,px,py = 场景管理.CheckSafeArea(mapid,x,y)
	if ret then
		human.m_db.backMapid = mapid
		human.m_db.backX = px
		human.m_db.backY = py
	end
	if not human.insafearea and (human:IsInSafeArea() or ret) then
		human.insafearea = true
		human:SendTipsMsg(1,"#c00ff00,你已进入安全区")
	elseif human.insafearea and not human:IsInSafeArea() and not ret then
		human.insafearea = nil
		human:SendTipsMsg(1,"#cff0000,你已离开安全区")
	end
	  local mapconf = 地图表[human.m_db.mapid]
	  if not human.inrunbock and mapconf.runmon == 0 and not human.insafearea and human.hp > 0 then
		human.inrunbock = true
		human:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, 1)
	  elseif human.inrunbock and (mapconf.runmon == 1 or human.insafearea or human.hp == 0) then
		human.inrunbock = nil
		human:UpdateCharCacheAttr(公共定义.CHAR_ATTR_RADIUS, 0)
	  end
	if human.在线经验时间 and _CurrentTime() >= human.在线经验时间 then
		if (human.在线经验地图 == nil or human.m_db.mapid == human.在线经验地图) and
			(human.在线经验安全区 == 0 or human.insafearea) then
			human.在线经验时间 = _CurrentTime() + human.在线经验秒*1000
			if human:AddExp(human.在线经验) then
				human:SendTipsMsg(2, "获得经验#cff00,"..human.在线经验)
			end
		end
	end
	if human.经验倍数时间 and _CurrentTime() >= human.经验倍数时间 then
		human.经验倍数 = nil
		human.经验倍数时间 = nil
	end
	if human.攻击倍数时间 and _CurrentTime() >= human.攻击倍数时间 then
		human.攻击倍数 = nil
		human.攻击倍数时间 = nil
	end
	if human.是否离线挂机 and human.离线挂机时间 and _CurrentTime() >= human.离线挂机时间 then
		human.是否离线挂机 = nil
		human.离线挂机时间 = nil
		human:Destroy()
	end
	if human.graynametime > 0 and _CurrentTime() >= human.graynametime then
		human.graynametime = 0
		human:ChangeName()
		human:UpdateObjInfo()
	end
	for i,v in pairs(human.管理属性) do
		if v[2] > 0 and _CurrentTime() >= v[2] then
			human.管理属性[i] = nil
			human:CalcDynamicAttr()
			if i == 公共定义.额外属性_潜行 then
				if human.buffend[公共定义.潜行BUFF] then
					DoRemoveBuff(human, 公共定义.潜行BUFF)
				end
			end
		end
	end
	for i,v in pairs(human.m_db.药水属性) do
		if _CurrentOSTime() >= v[2] then
			human.m_db.药水属性[i] = nil
			human:CalcDynamicAttr()
		end
	end
	local mapConfig = 地图表[mapid]
	if human.hp == 0 and mapConfig.deadrelive ~= 0 then
		human:OnRelive(mapConfig.deadrelive == 1 and 1 or mapConfig.deadrelive == 2 and 2 or 0)
	end
	if human.willCalcDynamicAttr then
		human:CalcDynamicAttrImpl()
		human.willCalcDynamicAttr = nil
	end
	human:SendDetailAttr()
end

function OnHPRecover(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	local human = 玩家对象类:GetObj(nObjID)
	if human == nil or human:GetObjType() ~= 公共定义.OBJ_TYPE_HUMAN then
		_DelTimer(nTimerID, nObjID)
		return
	end
	if human.m_nSceneID == -1 then
		return
	end
	if human:IsDead() then
		return
	end
	--for k,v in pairs(human.call) do
	--	if v.hp > 0 then
	--		v:RecoverHP(5)
	--	end
	--end
	--for k,v in pairs(human.pet) do
	--	if v.hp > 0 then
	--		v:RecoverHP(5)
	--	end
	--end
	human:RecoverHP(human.属性值[公共定义.属性_生命恢复])
	human:RecoverMP(human.属性值[公共定义.属性_魔法恢复])
	if human.英雄 and not human.英雄:IsDead() then
		human.英雄:RecoverHP(human.英雄.属性值[公共定义.属性_生命恢复])
		human.英雄:RecoverMP(human.英雄.属性值[公共定义.属性_魔法恢复])
	end
end

function OnXpPrepare(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	local human = 玩家对象类:GetObj(nObjID)
	if human and human.英雄 then
		human.xpstatus = 1
		human.xpcd = 10000
		human.xpcdmax = 10000
		if human.xpskill then
			if human.xpskill >= 3 then
				human.xpskill = 1
			else
				human.xpskill = human.xpskill + 1
			end
		end
		local icon = 0
		local skillid = GetXPSkillID(human)
		if skillid == 1153 then
			icon = 1112
		elseif skillid == 1140 then
			icon = Config.ISWZ and 35 or 1122
		elseif skillid == 1141 then
			icon = Config.ISWZ and 81 or 1124
		elseif skillid == 1142 then
			icon = Config.ISWZ and 24 or 1126
		elseif skillid == 1143 then
			icon = Config.ISWZ and 6 or 1128
		elseif skillid == 1144 then
			icon = Config.ISWZ and 23 or 1132
		elseif skillid == 1145 then
			icon = Config.ISWZ and 88 or 1130
		end
		human:SendXPInfo(icon)
	end
end

function OnXpFinish(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	local human = 玩家对象类:GetObj(nObjID)
	if human then
		human.xpPrepareTimer = _AddTimer(human.id, 计时器ID.TIMER_XP_PREPARE, 10000, 1)
		--human.avatarid = 0
		--human:ChangeBody()
		--技能逻辑.SendSkillInfo(human)
		human.xpstatus = 0
		human.xpcd = 0
		human.xpcdmax = 10000
		human:SendXPInfo()
	end
end

function OnMoveGrid(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
	local human = 玩家对象类:GetObj(nObjID)
	if human then
		if human.movegridpos then
			human:ChangePosition(human.movegridpos[1], human.movegridpos[2])
			human.movegridpos = nil
		end
		if human.movegrids and #human.movegrids > 0 then
			local movex = human.movegrids[1][1]
			local movey = human.movegrids[1][2]
			local time = human.movegrids[1][3]
			table.remove(human.movegrids, 1)
			human.movegridpos = {movex, movey}
			--print("timer",human.movegrids[1][3])
			--human.movegridtimer = _AddTimer(human.id, 计时器ID.TIMER_HUMAN_MOVEGRID, time, 1)
			human.movegridtime = _CurrentTime() + time
			local x,y = human:GetPosition()
			local oMsg = 派发器.ProtoContainer[协议ID.GC_MOVE]
			oMsg.objid = human.id
			oMsg.objtype = human:GetObjType()
			oMsg.posx = x
			oMsg.posy = y
			oMsg.movex = movex
			oMsg.movey = movey
			消息类.ZoneBroadCast(oMsg, human.id)
		end
	end
end

function OnSaveCharDB(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
end

function OnHumanSitStatusExpAdd(timerID, objID)
end

function OnOneSecCheck(timerID, objID)
	g_nNowDate = os.date("*t")
	g_nSecTimerCounter = g_nSecTimerCounter + 1
	for namekey, human in pairs( 在线玩家管理 ) do 
		if human.m_nSceneID ~= -1 then
			local mapid = 场景管理.SceneId2ConfigMapId[human.m_nSceneID]
			local mapConfig = 地图表[mapid]
			if mapConfig and mapConfig.maptype == 0 then
				if #mapConfig.costtp > 0 and human.costtime[0] and g_nSecTimerCounter >= human.costtime[0] then
					if human.m_db.tp < mapConfig.costtp[1] then
						human:回城()
					else
						human:RecoverTP(-mapConfig.costtp[1])
						human.costtime[0] = g_nSecTimerCounter + mapConfig.costtp[2]*60
					end
				end
				for i,v in ipairs(mapConfig.costex) do
					if v[1] == 1 and v[2] ~= 0 and human.costtime[i] and g_nSecTimerCounter >= human.costtime[i] then
						if v[2] > 0 and human:GetMoney(true) < v[2] then
							human:回城()
						else
							if v[2] > 0 then
								human:DecMoney(v[2], true)
							else
								human:AddMoney(v[2], true)
							end
							human.costtime[i] = g_nSecTimerCounter + v[3]
						end
					elseif v[1] == 2 and v[2] ~= 0 and human.costtime[i] and g_nSecTimerCounter >= human.costtime[i] then
						if v[2] > 0 and human:GetMoney(true) < v[2] then
							human:回城()
						else
							if v[2] > 0 then
								human:DecRmb(v[2], true)
							else
								human:AddRmb(v[2], true)
							end
							human.costtime[i] = g_nSecTimerCounter + v[3]
						end
					elseif v[1] == 3 and v[2] ~= 0 and human.costtime[i] and g_nSecTimerCounter >= human.costtime[i] then
						if v[2] > 0 and human.m_db.泡点数 < v[2] then
							human:回城()
						else
							human.m_db.泡点数 = math.max(0, human.m_db.泡点数 - v[2])
							human.costtime[i] = g_nSecTimerCounter + v[3]
						end
					elseif v[1] == 4 and v[2] ~= 0 and human.costtime[i] and g_nSecTimerCounter >= human.costtime[i] then
						human:RecoverHP(-v[2])
						human.costtime[i] = g_nSecTimerCounter + v[3]
					elseif v[1] == 5 and v[2] ~= 0 and human.costtime[i] and g_nSecTimerCounter >= human.costtime[i] then
						human:RecoverMP(-v[2])
						human.costtime[i] = g_nSecTimerCounter + v[3]
					elseif v[1] > 10000 and v[2] ~= 0 and human.costtime[i] and g_nSecTimerCounter >= human.costtime[i] then
						if v[2] > 0 and 背包DB.CheckCount(human, v[1]) < v[2] then
							human:回城()
						else
							if v[2] > 0 then
								背包DB.RemoveCount(human, v[1], v[2])
							else
								local inds = human:PutItemGrids(v[1], v[2], 1, true)
								if inds and #inds > 0 then
									背包逻辑.SendBagQuery(human, inds)
									human:SendTipsMsg(2, "获得物品"..广播.colorRgb[物品逻辑.GetItemGrade(v[1])]..物品逻辑.GetItemName(v[1])..(v[2] > 1 and "x"..v[2] or ""))
								end
							end
							human.costtime[i] = g_nSecTimerCounter + v[3]
						end
					end
				end
			end
		end
	end
	if Config.ISZY and (寻宝阁状态 == 2 or 寻宝阁状态 == 3) then
		local sceneid = 场景管理.GetSceneId(公共定义.寻宝阁地图)
		if 寻宝阁关闭 ~= 0 and 场景管理.GetSceneObjCount(sceneid, 公共定义.OBJ_TYPE_HUMAN) > 0 then
			寻宝阁关闭 = 0
		end
		if 场景管理.GetSceneObjCount(sceneid, 公共定义.OBJ_TYPE_HUMAN) == 0 then
			if 寻宝阁状态 == 2 and 寻宝阁关闭 == 0 then
				寻宝阁关闭 = _CurrentTime() + 30000
			elseif 寻宝阁状态 == 2 and _CurrentTime() > 寻宝阁关闭 then
				local msg = "#cffff00,寻宝阁#C已经结束,请留意下一次活动开启"
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
				寻宝阁状态 = 0
				清除地图怪物(公共定义.寻宝阁地图)
			elseif 寻宝阁状态 == 3 then
				寻宝阁状态 = 4
			end
		elseif 寻宝阁波数 == 0 or (寻宝阁时间 > 0 and _CurrentTime() > 寻宝阁时间) then
			if 寻宝阁状态 == 3 then
				寻宝阁状态 = 4
				移动地图玩家(公共定义.寻宝阁地图, 401, 333, 333, 3)
			else
				寻宝阁波数 = 寻宝阁波数 + 1
				寻宝阁时间 = 0
				for i,v in ipairs(寻宝阁怪物[寻宝阁波数]) do
					地图刷怪(公共定义.寻宝阁地图, v, 1, 25, 25, 1)
				end
			end
		elseif 寻宝阁时间 == 0 then
			local hasmonster = false
			for i,v in ipairs(寻宝阁怪物[寻宝阁波数]) do
				if 检查地图怪物数(公共定义.寻宝阁地图, v) > 0 then
					hasmonster = true
					break
				end
			end
			if not hasmonster then
				local msg
				if 寻宝阁波数 == 7 then
					msg = "#cffff00,寻宝阁#C所有怪物已被勇士消灭,#cff00,30#C秒后结束,#cff00,特戒之城#C将在下一小时开放"
					寻宝阁状态 = 3
				else
					msg = "#cffff00,寻宝阁#C下一波怪物将于#cff00,30#C秒后出现,请大家做好准备"
				end
				寻宝阁时间 = _CurrentTime() + 30000
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
			end
		end
	end
	for i=#定时中间公告,1,-1 do
		local v = 定时中间公告[i]
		if not v[4] or v[4] == 0 then
			if v[5] and v[3] then
				local call = 事件触发._M["call_"..v[5]]
				if call ~= nil then
					v[3]:显示对话(-2,call(v[3]))
				end
			end
			中间公告广播(v[1],v[2],v[3],v[4],v[5])
			table.remove(定时中间公告,i)
		else
			中间公告广播(v[1],v[2],v[3],v[4],v[5])
			v[4] = v[4] - 1
		end
	end
	local call = 定时触发._M["call_每秒触发"]
	if call then
		call(g_nSecTimerCounter)
	end
end

-- 每分钟进一次的timer 专门做一些杂七杂八的事情
function OnOneMinCheck(timerID, objID)
	g_nMinTimerCounter = g_nMinTimerCounter + 1
	if g_nMinTimerCounter % 5 == 0 then
		print("Auto Save Humans:", os.date("%c"))
		local cnt = 0
		local realcnt = 0
		for namekey, human in pairs( 在线玩家管理 ) do 
			if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then 
				human:Save()
			end
			if human and not human.是否离线挂机 then
				realcnt = realcnt + 1
			end
			cnt = cnt + 1
		end
		保存全局变量()
		print("online human cnt/realcnt: ", cnt, realcnt)
	end
	local dt = os.date("*t")
	if Config.ISZY and (特戒之城开启 == 0 or 特戒之城开启 == 1) then
		if dt.min < 5 and 特戒之城开启 == 0 and (寻宝阁状态 == 3 or 寻宝阁状态 == 4) then
			特戒之城开启 = 1
			local msg = "#cffff00,特戒之城#C已经开放,持续#cff00,一个小时#C,请大家前往盟重寻找#cffff00,特戒之城NPC#C进入"
			for _,v in pairs(在线玩家管理) do
				v:SendTipsMsg(4, msg)
			end
			聊天逻辑.SendSystemChat(msg)
		elseif dt.min < 5 and 特戒之城开启 == 1 and 寻宝阁状态 ~= 3 and 寻宝阁状态 ~= 4 then
			特戒之城开启 = 0
			移动地图玩家(公共定义.特戒之城地图, 401, 333, 333, 3)
			local msg = "#cffff00,特戒之城#C已经关闭,请各位勇士继续探寻开启之路"
			for _,v in pairs(在线玩家管理) do
				v:SendTipsMsg(4, msg)
			end
			聊天逻辑.SendSystemChat(msg)
		end
		if dt.min < 5 and 寻宝阁状态 ~= 0 and 寻宝阁状态 ~= 1 then
			寻宝阁状态 = 0
		end
	end
	if Config.ISZY and (寻宝阁状态 == 0 or 寻宝阁状态 == 1) then
		if dt.min < 5 and 寻宝阁状态 == 0 then
			寻宝阁状态 = 1
			清除地图怪物(公共定义.寻宝阁地图)
			移动地图玩家(公共定义.寻宝阁地图, 401, 333, 333, 3)
			local msg = "#cffff00,寻宝阁#C已经开启,入口将于#cff00,5#C分钟后关闭,请大家前往盟重寻找#cffff00,寻宝阁NPC#C进入"
			for _,v in pairs(在线玩家管理) do
				v:SendTipsMsg(4, msg)
			end
			聊天逻辑.SendSystemChat(msg)
		elseif dt.min >= 5 and 寻宝阁状态 == 1 then
			寻宝阁状态 = 0
			local msg = "#cffff00,寻宝阁#C已经关闭,活动将于#cff00,55#C分钟后结束,请大家期待勇者的凯旋归来"
			for _,v in pairs(在线玩家管理) do
				v:SendTipsMsg(4, msg)
			end
			聊天逻辑.SendSystemChat(msg)
			local sceneid = 场景管理.GetSceneId(公共定义.寻宝阁地图)
			if 场景管理.GetSceneObjCount(sceneid, 公共定义.OBJ_TYPE_HUMAN) > 0 then
				寻宝阁状态 = 2
				寻宝阁时间 = 0
				寻宝阁关闭 = 0
				寻宝阁波数 = 0
				清除地图怪物(公共定义.寻宝阁地图)
			end
		end
	end
	for id,castle in pairs(城堡管理.CastleList) do
		local isoneday = 实用工具.IsInOneDay(castle.attacktime)
		if isoneday then
			local mintime1 = dt.hour * 60 + dt.min
			local mintime2 = 公共定义.攻城时间[1] * 60 + 公共定义.攻城时间[2]
			if mintime1 >= mintime2 + 公共定义.攻城时间[3] and 城堡管理.ForbidMapID[castle.mapid] then
				local nSceneID = 场景管理.GetSceneId(castle.mapid, true)
				local guildnames = {}
				for _,v in pairs(在线玩家管理) do
					if v.m_nSceneID == nSceneID and v.m_db.guildname ~= "" then
						实用工具.InsertArrayTable(guildnames, v.m_db.guildname)
					end
				end
				local guildcamp = ""
				for _,v in ipairs(guildnames) do
					if guildcamp == "" then
						if castle.guild == "" then
							if 实用工具.FindIndex(castle.attackguild,v) then
								guildcamp = v
							end
						else
							if 实用工具.FindIndex(castle.unionguild,v) then
								guildcamp = castle.guild
							elseif 实用工具.FindIndex(castle.attackguild,v) then
								guildcamp = castle.attackguild[1]
							end
						end
					else
						if castle.guild == "" then
							if v ~= guildcamp then
								guildcamp = ""
								break
							end
						elseif guildcamp == castle.guild then
							if v ~= castle.guild and not 实用工具.FindIndex(castle.unionguild,v) then
								guildcamp = ""
								break
							end
						else
							if not 实用工具.FindIndex(castle.attackguild,v) then
								guildcamp = ""
								break
							end
						end
					end
				end
				城堡管理.ForbidMapID[castle.mapid] = nil
				local oldguild = castle.guild
				local msg = ""
				if castle.guild ~= "" and (guildcamp == "" or guildcamp == castle.guild) then
					msg = "#cffff00,"..castle.name.."#C城堡今晚仍然属于强大的行会#cff00,"..castle.guild.."#C,请大家热烈祝贺"
				elseif guildcamp ~= "" then
					castle.guild = guildcamp
					msg = "#cffff00,"..castle.name.."#C城堡今晚开始将属于强大的行会#cff00,"..guildcamp.."#C,请大家热烈祝贺"
				else
					castle.guild = ""
					msg = "#cffff00,"..castle.name.."#C城堡今晚不属于任何行会,请各大行会再接再厉"
				end
				实用工具.DeleteTable(castle.unionguild)
				实用工具.DeleteTable(castle.attackguild)
				castle:Save()
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
					if v.m_db.guildname == oldguild or v.m_db.guildname == castle.guild then
						v:ChangeName()
						v:UpdateObjInfo()
					end
				end
				聊天逻辑.SendSystemChat(msg)
			elseif mintime1 >= mintime2 + 公共定义.攻城时间[3] - 10 and mintime1 < mintime2 + 公共定义.攻城时间[3] then
				城堡管理.ForbidMapID[castle.mapid] = ""
				local msg = "#cffff00,"..castle.name.."#C城堡将于#cff00,"..((mintime2 + 公共定义.攻城时间[3])-mintime1).."#C分钟后结束,请大家期待城堡花落谁家"
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
			elseif mintime1 >= mintime2 + 公共定义.攻城时间[3] - 20 and mintime1 < mintime2 + 公共定义.攻城时间[3] - 10 then
				城堡管理.ForbidMapID[castle.mapid] = nil
				local msg = "#cffff00,"..castle.name.."#C城堡城门将于#cff00,"..((mintime2 + 公共定义.攻城时间[3] - 10)-mintime1).."#C分钟后关闭,请各大行会注意"
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
			elseif mintime1 >= mintime2 + 10 and 城堡管理.ForbidMapID[castle.mapid] then
				城堡管理.ForbidMapID[castle.mapid] = nil
				local msg = "#cffff00,"..castle.name.."#C城堡城门已经打开,请攻城行会注意"
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
			elseif mintime1 >= mintime2 and mintime1 < mintime2 + 10 then
				城堡管理.ForbidMapID[castle.mapid] = castle.guild
				local msg = "#cffff00,"..castle.name.."#C城堡城门将于#cff00,"..((mintime2 + 10)-mintime1).."#C分钟后打开,请攻城行会注意"
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
			elseif mintime1 >= mintime2 - 10 and mintime1 < mintime2 then
				local msg = "#cffff00,"..castle.name.."#C城堡将于#cff00,"..(mintime2-mintime1).."#C分钟后开启攻城,请各大行会准备"
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
			end
			if (mintime1 < mintime2 or mintime1 > mintime2 + 公共定义.攻城时间[3]) and 城堡管理.AttackGuild[castle.castleid] then
				for _,v in pairs(在线玩家管理) do
					if v.m_db.guildname ~= "" and 城堡管理.AttackGuild[v.m_db.guildname] == castle.castleid then
						v:SendAttackGuildMsg(true)
					end
				end
				for k,v in pairs(城堡管理.AttackGuild) do
					if v == castle.castleid then
						城堡管理.AttackGuild[k] = nil
					end
				end
				城堡管理.AttackGuild[castle.castleid] = nil
			elseif mintime1 >= mintime2 and mintime1 <= mintime2 + 公共定义.攻城时间[3] and 城堡管理.AttackGuild[castle.castleid] == nil then
				if castle.guild ~= "" then
					城堡管理.AttackGuild[castle.guild] = castle.castleid
				end
				for _,v in ipairs(castle.unionguild) do
					城堡管理.AttackGuild[v] = castle.castleid
				end
				for _,v in ipairs(castle.attackguild) do
					城堡管理.AttackGuild[v] = castle.castleid
				end
				for _,v in pairs(在线玩家管理) do
					if v.m_db.guildname ~= "" and 城堡管理.AttackGuild[v.m_db.guildname] == castle.castleid then
						v:SendAttackGuildMsg()
					end
				end
				城堡管理.AttackGuild[castle.castleid] = 9999
			end
		end
	end
	local call = 定时触发._M["call_每分触发"]
	if call then
		call(g_nMinTimerCounter)
	end
end

function OnHalfHourUpdate(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
  g_nHourTimerID = _AddTimer(-1, 计时器ID.TIMER_HALF_HOUR_UPDATE, (1800 - os.time() % 1800) * 1000, 1, 0, 0, 0)
  print("OnHalfHourUpdate:", os.date("%c"))
	限时商店.Init()
	for namekey, human in pairs( 在线玩家管理 ) do 
		if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then 
			限时商店.SendShopQuery(human)
			if human.m_db.PK值 > 0 then
				human.m_db.PK值 = math.max(0, human.m_db.PK值 - 5)
				human:ChangeName()
				human:UpdateObjInfo()
			end
		end
	end
	for k,castle in pairs(城堡管理.CastleList) do
		local isoneday = 实用工具.IsInOneDay(castle.attacktime)
		if isoneday then
			local dt = os.date("*t")
			if dt.hour <= 公共定义.攻城时间[1] and dt.min < 公共定义.攻城时间[2] then
				local msg = "#cffff00,"..castle.name.."#C城堡将于今日#cff00,"..公共定义.攻城时间[1]..":"..公共定义.攻城时间[2].."分#C开启攻城,请各大行会做好准备"
				for _,v in pairs(在线玩家管理) do
					v:SendTipsMsg(4, msg)
				end
				聊天逻辑.SendSystemChat(msg)
			end
		end
	end
	if 公共定义.元宝宝箱ID ~= 0 then
		local mapid = math.random(1,7)*100+1
		local mapconf = 地图表[mapid]
		local sceneid = 场景管理.GetSceneId(mapid)
		if sceneid and sceneid ~= -1 then
			local mapheight, mapwidth = _GetHeightAndWidth(sceneid)
			while true do
				local x = math.random(1, mapwidth-1)
				local y = math.random(1, mapheight-1)
				local gx = x
				local gy = y
				if #mapconf.movegrid > 0 then
					x = math.floor(x / mapconf.movegrid[1]) * mapconf.movegrid[1] + mapconf.movegrid[1]/2
					y = math.floor(y / mapconf.movegrid[2]) * mapconf.movegrid[2] + mapconf.movegrid[2]/2
					gx = math.floor(x / mapconf.movegrid[1])
					gy = math.floor(y / mapconf.movegrid[2])
				end
				if _IsPosCanRun(sceneid, x, y) then
					local m = 怪物对象类:CreateMonster(sceneid, 公共定义.元宝宝箱ID, x, y, -1)
					m.callid = -1
					m.deadtime = _CurrentTime() + 1800000
					聊天逻辑.SendSystemChat("#cffff00,"..m:GetName().."#C在#cff00ff,"..
					场景管理.GetMapName(场景管理.GetMapId(sceneid)).."["..gx..","..gy.."]#C出现,必爆大量元宝,#cff0000,"..m:GetName().."只存活30分钟,请火速前往击杀#C")
					break
				end
			end
		end
	end
end

function OnDayUpdate(nTimerID, nObjID, nEvent, nParam1, nParam2, nParam3)
  g_nDayTimerID = _AddTimer(-1, 计时器ID.TIMER_DAY_UPDATE, 24 * 60 * 60 * 1000, 1, 0, 0, 0)
  print("OnDayUpdate:", os.date("%c"))
	for namekey, human in pairs( 在线玩家管理 ) do 
		if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then 
			human.m_db.singlecopy = {}
			副本逻辑.SendSingleCopyInfo(human)
			if human.m_db.转生等级 > 0 then
				human:RecoverTP(50+human.m_db.vip等级*10)
			end
			human.m_db.vip领取奖励 = 0
			human.m_db.vip领取等级 = 0
			human.m_db.日常任务次数 = 0
			human.m_db.悬赏任务次数 = 0
			human.m_db.护送押镖次数 = 0
			human.m_db.护送灵兽次数 = 0
			human.m_db.庄园采集次数 = 0
			human.m_db.日限商品购买 = {}
			human.m_db.每日使用次数 = {}
			human.m_db.每日充值 = 0
			--human.m_db.每日充值领取 = {}
			human.m_db.每日采集次数 = 0
			human.m_db.刷新BOSS次数 = 0
		end
	end
end
