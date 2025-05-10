--
-- Script logic entrance
--

REAL_CONVERT = REAL_CONVERT or _convert
REAL_PRINT = REAL_PRINT or print
REAL_REQUIRE = REAL_REQUIRE or require

_convert = function(str)
	if str:len() > 100 then return str end
	return __PLATFORM__=="WIN" and REAL_CONVERT(str) or str
end

require = function(str)
	if Config and Config.ISZY and str:find("触发器%.") then
		str = str:gsub("触发器%.","触发器空%.")
	end
	return REAL_REQUIRE(_convert(str))
end

--print = _print	--把lua系统的print指向重写的_print
--booson_debug = true

TimeEvents = TimeEvents or {}
TimeEventsPool = TimeEventsPool or {}
AddTimerCnt = AddTimerCnt or 0
MonsterAI = MonsterAI or {}
MonsterScene = MonsterScene or {}
MonsterRespawn = MonsterRespawn or {}
HumanMoveGrid = HumanMoveGrid or {}
DisplaceMove = DisplaceMove or {}
DelayCalls = DelayCalls or {}

function AppendPath(path)
	local tmp = ";" .. (__SCRIPT_PATH__ or "") .. "./scripts/" .. path
	if not string.find(package.path, tmp, 1, true) then
		package.path = package.path .. tmp
	end
end

function NewTimeEventNode(objID, eventID, interval, maxTimes, param, nextCallTime, timerID, pause)
	if #TimeEventsPool < 1 then
		return {objID = objID, eventID = eventID, interval = interval, maxTimes = maxTimes, param=param,nextCallTime = nextCallTime, timerID = timerID}
	end
	local ret = TimeEventsPool[#TimeEventsPool]
	ret.objID = objID
	ret.eventID = eventID
	ret.interval = interval
	ret.maxTimes = maxTimes
	ret.param = param
	ret.nextCallTime = nextCallTime
	ret.timerID = timerID
	ret.pause = pause
	TimeEventsPool[#TimeEventsPool] = nil
	return ret
end

function DelTimeEventNode(node)
	TimeEventsPool[#TimeEventsPool + 1] = node
end

function _AddTimer(objID, eventID, interval, maxTimes, param, pause)--p1, p2, p3, p4)
	AddTimerCnt = AddTimerCnt + 1
	TimeEvents[#TimeEvents + 1] = NewTimeEventNode(objID, eventID, interval, maxTimes, param,_CurrentTime() + interval, AddTimerCnt, pause)
	return AddTimerCnt
end

function _DelTimer(timerID, objID)
	if not timerID or timerID < 1 then
		return
	end
	for i = 1, #TimeEvents do
		if TimeEvents[i].timerID == timerID then
			if objID and TimeEvents[i].objID ~= objID then
				assert(nil)
			end
			TimeEvents[i].maxTimes = 0
			return
		end
	end
end

function _GetTimer(timerID, objID)
	if not timerID or timerID < 1 then
		return
	end
	for i = 1, #TimeEvents do
		if TimeEvents[i].timerID == timerID then
			if objID and TimeEvents[i].objID ~= objID then
				assert(nil)
			end
			return TimeEvents[i]
		end
	end
end

AppendPath("?.lua")
AppendPath(_convert("模块/?.lua"))

require("Config")
local 实用工具 = require("公用.实用工具")
local function phpconfig2config(filename)
	local str = 实用工具.file2str("./scripts/phpconfig/" .. filename .. ".lua")
	if not str then
		return
	end
	实用工具.str2file(str, "./scripts/配置/" .. filename .. ".lua")
end
phpconfig2config("ActConfig")
phpconfig2config("NoticeConfig")

local 公共定义 = require("公用.公共定义")
local 派发器 = require("公用.派发器")
local 消息类 = require("公用.消息类")
local 协议ID = require("公用.协议ID")
local 模块定义 = require("公用.模块定义").RegisterOneModuleProtos

DB = require("公用.DB")
日志 = require("公用.日志")
require("公用.对象类")
require("公用.协议限制")

require("玩家.玩家对象类")
require("怪物.怪物对象类")
require("怪物.Npc对象类")
require("怪物.物品对象类")
require("宠物.宠物对象类")

local 场景管理 = require("公用.场景管理")
local 后台逻辑 = require("后台管理.后台逻辑")
local 排行榜管理 = require("排行榜.排行榜管理")
local 英雄排行管理 = require("排行榜.英雄排行管理")
local 宠物排行管理 = require("排行榜.宠物排行管理")
local VIP推广排行管理 = require("排行榜.VIP推广排行管理")
local 寄售管理 = require("寄售.寄售管理")
local 寄售记录管理 = require("寄售.寄售记录管理")
local 怪物事件处理 = require("怪物.事件处理")
local 玩家事件处理 = require("玩家.事件处理")
local 聊天逻辑 = require("聊天.聊天逻辑")
local 登录触发 = require("触发器.登录触发")
local 行会管理 = require("行会.行会管理")
local 城堡管理 = require("行会.城堡管理")

模块定义("玩家")
模块定义("怪物")
模块定义("技能")
模块定义("物品")
模块定义("宠物")
模块定义("锻造")
模块定义("聊天")
模块定义("副本")
模块定义("后台管理")
模块定义("排行榜")
模块定义("寄售")
模块定义("队伍")
模块定义("行会")

local AI = require("怪物.AI")

对象类:RefreshOldObj()		--刷新老obj对象的元表,必须require所有obj类后面，否则不能热更新
日志.Init()

function Init()
	_SetServerInfo(Config.GAME_IO_LISTEN_PORT, Config.GAME_HTTP_LISTEN_PORT, Config.MSVRIP, Config.MSVRHTTPPORT, Config.MEMORY_USE, Config.MEMORY_THRESHOLD)
	
    if Config.ISGAMESVR then
        print("[init] connect mongodb")
		g_oMongoDB = g_oMongoDB or _CreateDB()
		if not _Connect(g_oMongoDB, Config.DBIP, Config.DBNAME,Config.DBUSER, Config.DBPWD) then
			print("Connection MongoDB Error")
			return
		end
		print("[init] init db index")
        DB.InitDBIndex()
		
        print("[init] ranking init")
		排行榜管理.Init()
		--排行榜管理.DelAll()
		
        print("[init] heroranking init")
		英雄排行管理.Init()
		--英雄排行管理.DelAll()
		
        print("[init] petranking init")
		宠物排行管理.Init()
		--宠物排行管理.DelAll()
		
        print("[init] vipspreadranking init")
		VIP推广排行管理.Init()
		--VIP推广排行管理.DelAll()
		
        print("[init] sell init")
		寄售管理.Init()
		
        print("[init] sellrecord init")
		寄售记录管理.Init()
		
        print("[init] guild init")
		行会管理.Init()
		
        print("[init] castle init")
		城堡管理.Init()
	else
		g_oMongoDBs = {}
		for i = 1, #Config.GSVR do
			g_oMongoDBs[Config.GSVR[i].svrName] = MongoDB()
			if not g_oMongoDBs[Config.GSVR[i].svrName]:Connect(Config.GSVR[i].dbIP, Config.GSVR[i].dbName,Config.GSVR[i].dbUser, Config.GSVR[i].dbPwd) then
				print("Connection ",  Config.GSVR[i].dbIP, " MongoDB Error");
            end
        end
    end
	
    print("[init] loadmaps")
    场景管理.LoadAllMaps()
	
    print("[init] init done")
    日志.WriteLog(日志.LOGID_MONITOR, "Server Started......")
	
	local call = 登录触发._M["call_服务启动"]
	if call then
		call()
	end
end

function MsgDispatch(nObjID, nPacketID)
    --print("DispatchMsg: ", nObjID, nPacketID)
    if Config.ISGAMESVR and (nPacketID > 19000 and  nPacketID < 19500) then
		-- 19000 - 19500 的协议专门给跨服pk服使用 正常游戏服不应该收到这些id
		return false
    end

    local OnMsg = 派发器.ProtoHandler[nPacketID]
    if OnMsg then
        local oMsg = 消息类.RecvMsg(nPacketID)
        if not oMsg then
			print("Packet:", nPacketID, "read fail")
			return false
		end

		if nPacketID == 协议ID.GG_DISCONNECT or nPacketID == 协议ID.CG_ASK_LOGIN
			or nPacketID == 协议ID.CG_CROSS_SCENE_LOGIN
            or nPacketID == 协议ID.SG_CROSS_CONNECT then
			return OnMsg(nObjID, oMsg)
		else
			local oHuman = 玩家对象类:GetObj(nObjID)
			if not oHuman then
			    print("Packet:", nPacketID, ":has not human handler:", nObjID)
			    return false
			end

			if Config.ISGAMESVR then
				return OnMsg(oHuman, oMsg)
			end

			if CrossSceneFilter.PacketFilter(oHuman, nPacketID) then
				return OnMsg(oHuman, oMsg)
			end

			return true
		end
	else
		print("Packet:", nPacketID, "has not handler");
		return false;
	end
end



--生成地图配置中的obj
function CreateLuaObj(nSceneID, nId, nX, nY, nType, expire)
    local nObjType = nType--math.floor(nId/1000)%10
	if nObjType == 公共定义.OBJ_TYPE_MONSTER
        or nObjType == 公共定义.OBJ_TYPE_COLLECT then
		local m = 怪物对象类:CreateMonster(nSceneID, nId, nX, nY)
		m.expire = expire

        --if 场景管理.SceneMonster[nSceneID] == nil then
        --    场景管理.SceneMonster[nSceneID] = {}
        --end

--		if nObjType == 公共定义.OBJ_TYPE_MONSTER and math.floor(nId/1000000) ~= 1 then
--			-- 副本里面的怪物离开场景
--			assert( m , string.format( "怪物 create failed! on map:%d, 怪物 id is:%d.", math.floor( nId )/10000, nId ) ) 
--			m:LeaveScene()
--		end

        --if m then
        --    local sm = 场景管理.SceneMonster[nSceneID]
        --    sm[#sm + 1] = m.id
        --end

	elseif nObjType == 公共定义.OBJ_TYPE_NPC
        or nObjType == 公共定义.OBJ_TYPE_JUMP then
		Npc对象类:CreateNPC(nSceneID, nId, nX, nY)
	elseif 	nObjType == 5 then -- 在地图配置文件里面 5 是特效 这个client用的 服务器端不用处理

    else
        print(string.format("error: 物品 %d not created", nId))
	end
end


function DoAI(nObjID)
	AI.DoAI(nObjID)
end

function DoMoveBreak(nObjID)
end

function HttpReqDispatch(input)
	return 后台逻辑.HandleHttpRequest(input)
end

function HttpRespDispatch(input)
	return 后台逻辑.HandleHttpRespRequest(input)
end

function TimerDispatch(curTime)
    for i = #TimeEvents, 1, -1 do
		local node = TimeEvents[i]
		if node.maxTimes == 0 then
			DelTimeEventNode(TimeEvents[i])
			TimeEvents[i] = TimeEvents[#TimeEvents]
			TimeEvents[#TimeEvents] = nil
		elseif node.pause ~= 1 and node.nextCallTime < curTime + 8 then
			if node.maxTimes > 0 then
				node.maxTimes = node.maxTimes - 1
			end
			node.nextCallTime = curTime + node.interval
			--先进行减1操作，避免timerHandler出错后，下次马上调用
			--print("eventID", node.eventID)
			local timerHandler = 派发器.TimerDispatcher[node.eventID]
			if not timerHandler then
				print("node.eventID = ", node.eventID)
				assert(nil)
			end
			local ret, err = pcall(timerHandler, node.timerID, node.objID, node.eventID, node.param)
			if not ret then
				print(node.timerID, node.objID, node.eventID, node.param, err)
				日志.Write(日志.LOGIN_PCALL_TIMER, node.timerID, node.objID, node.eventID, node.param, err)
			end
		end
    end
	for k,v in pairs(MonsterAI) do
		if v.moveaitime and curTime > v.moveaitime then
			v.movegridtime = nil
			AI.DoMoveAI(v)
			v.moveaitime = _CurrentTime() + (v.movegridtime or 500)
		end
	end
	for k,v in pairs(MonsterRespawn) do
		if v.respawntime and curTime > v.respawntime then
			v.respawntime = nil
			怪物事件处理.OnRespawn(-1, k)
			MonsterRespawn[k] = nil
		end
	end
	for k,v in pairs(HumanMoveGrid) do
		if v.movegridtime and curTime > v.movegridtime then
			v.movegridtime = nil
			玩家事件处理.OnMoveGrid(-1, k)
		end
	end
	for k,v in pairs(DisplaceMove) do
		if v.displacetime and curTime < v.displacetime then
			local r = (curTime-v.disstarttime)/(v.displacetime-v.disstarttime)
			v:ChangePosition(v.disstartx+(v.displacex-v.disstartx)*r, v.disstarty+(v.displacey-v.disstarty)*r)
		elseif v.displacetime then
			v:ChangePosition(v.displacex, v.displacey)
			v.displacetime = nil
			DisplaceMove[k] = nil
		end
	end
	for i=#DelayCalls,1,-1 do
		if curTime > DelayCalls[i][1] then
			if not DelayCalls[i][2] then
				table.remove(DelayCalls, i)
			elseif DelayCalls[i][4] then
				DelayCalls[i][4]:显示对话(DelayCalls[i][3],DelayCalls[i][2](DelayCalls[i][4]))
				if DelayCalls[i][5] then
					DelayCalls[i][1] = curTime + DelayCalls[i][6]
				else
					table.remove(DelayCalls, i)
				end
			else
				DelayCalls[i][2]()
				if DelayCalls[i][5] then
					DelayCalls[i][1] = curTime + DelayCalls[i][6]
				else
					table.remove(DelayCalls, i)
				end
			end
			--if DelayCalls[i][5] then
			--	DelayCalls[i][1] = curTime + DelayCalls[i][6]
			--else
			--	table.remove(DelayCalls, i)
			--end
		end
	end
end

--跨服连接至所有游戏服
function Connect2AllGameSvr()
    if Config.ISGAMESVR then
        return
    end
    local fd
    local returnMsg = 派发器.ProtoContainer[协议ID.SG_CROSS_CONNECT]
    local time = os.time()
    for i = 1, #Config.GSVR do
		fd = _ConnectToGameSvr(Config.GSVR[i].ip,Config.GSVR[i].ioPort)
        if fd >0 then
          GameSrvList[Config.GSVR[i].svrName] = ObjServer:New(fd)
          GameSrvList[Config.GSVR[i].svrName].svrName = Config.GSVR[i].svrName
          returnMsg.time = time
          returnMsg.sign = _md5(Config.ADMIN_KEY..time)
          消息类.SendMsgByFD(returnMsg, fd)
        end
    end
    print("[CrossServer] connect all game server finish")
    日志.WriteLog(日志.LOGID_MONITOR, "[CrossServer] connect all game server finish")
end


function save_db_signal()
	print( "force_save_db" )

	for namekey, human in pairs( 在线玩家管理 ) do 
		if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then 
			human:Save()
	--		human:Destroy()
		end
	end
	保存全局变量()
end

function kick_all_signal()
	print( "force_kick_all" )

	for namekey, human in pairs( 在线玩家管理 ) do 
		if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then 
			human:DoDisconnect(公共定义.DISCONNECT_REASON_SERVER_CLOSE)
		end
	end
end

function close_all_signal()
	print( "force_close_all" )

	for namekey, human in pairs( 在线玩家管理 ) do 
		if human and human:GetObjType() == 公共定义.OBJ_TYPE_HUMAN then 
			human:DoDisconnect(公共定义.DISCONNECT_REASON_SERVER_CLOSE_ALL)
		end
	end
end

function memory_full_check(memory)
	print(string.format("current memory: %.2fM", memory))
	
	local nowDate = os.date("*t")
	if nowDate.hour == 4 and nowDate.min == 0 then--每天4:00重启一次
		聊天逻辑.SendSystemChat("#cffff00,服务器#cff00,30秒后#cff0000,将自动重启更新,请做好保管工作")
		return true
	elseif memory > Config.MEMORY_THRESHOLD then
		聊天逻辑.SendSystemChat("#cffff00,服务器#cff00,30秒后#cff0000,将自动重启更新,请做好保管工作")
		return true
	end
end

if not hasInit then
	hasInit = true
	Init()
end
