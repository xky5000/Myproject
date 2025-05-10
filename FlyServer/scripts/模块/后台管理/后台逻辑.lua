module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 广播 = require("公用.广播")
local 日志 = require("公用.日志")
local 玩家DB = require("玩家.玩家DB").玩家DB
local 聊天逻辑 = require("聊天.聊天逻辑")
local 玩家事件处理 = require("玩家.事件处理")
Json = Json or require("公用.Json")

catchhttpresp = true
spreadhuman = spreadhuman or {}

function HandleHttpRespRequest(input)
  catchhttpresp = true
  if not Config.ISGAMESVR then
    return "error"
  end
  --print("HttpRespDispatch input = ", input)
  if input:byte(1) ~= string.byte("{") or input:byte(-1) ~= string.byte("}") then
	return "error"
  end
  local oJsonInput = Json.Decode(input)
  local handler = _M[oJsonInput.method]
  if handler then
    return handler(oJsonInput, input)
  end
  return "{method:" .. (oJsonInput.method or "") .. " no handler}"
  --return "success"
end

function VIP推广成长(推广人名字)
	local VIP升级经验 = {50,100,200,500,1000,2000,5000,10000,20000,50000,50000}
	local 推广人 = 在线玩家管理[推广人名字]
	if 推广人 then
		推广人.m_db.rmb = 推广人.m_db.rmb + 500
		推广人.m_db.VIP成长经验 = 推广人.m_db.VIP成长经验 + 5
		if 推广人.m_db.vip等级 < 10 and 推广人.m_db.VIP成长经验 >= VIP升级经验[推广人.m_db.vip等级+1] then
			推广人.m_db.vip等级 = 推广人.m_db.vip等级 + 1
		end
		推广人.m_db.VIP推广有效人数 = 推广人.m_db.VIP推广有效人数 + 1
		推广人:SendVIPSpread()
	else
		local db = 玩家DB:New()
		local ret = db:LoadByName(推广人名字)
		if ret then
			db.rmb = db.rmb + 500
			db.VIP成长经验 = (db.VIP成长经验 or 0) + 5
			if db.vip等级 < 10 and db.VIP成长经验 >= VIP升级经验[db.vip等级+1] then
				db.vip等级 = db.vip等级 + 1
			end
			db.VIP推广有效人数 = (db.VIP推广有效人数 or 0) + 1
			db:Save()
		end
	end
end

function catchpay(oJsonInput)
	if oJsonInput.result == 0 and oJsonInput.account and oJsonInput.account ~= "" and oJsonInput.rmb and oJsonInput.rmb > 0 then
		local 代理推广人 = ""
		local humanName = oJsonInput.account
		local human = 在线账号管理[oJsonInput.account]
		if Config.ISLT and #公共定义.充值文件 > 0 then
			if human then
				humanName = human.m_db.name
			else
				local db = 玩家DB:New()
				local ret = db:LoadByAccount(oJsonInput.account)
				if ret then
					humanName = db.name
				end
			end
			local payrmb = math.floor(oJsonInput.rmb)
			for i=#公共定义.充值文件,1,-1 do
				local rmb = tonumber(公共定义.充值文件[i]) or 1
				while payrmb >= rmb do
					插文件内容(rmb..".txt",oJsonInput.account)
					payrmb = payrmb - rmb
				end
			end
		elseif human then
			human.m_db.总充值 = human.m_db.总充值 + math.floor(oJsonInput.rmb)
			human.m_db.每日充值 = human.m_db.每日充值 + math.floor(oJsonInput.rmb)
			if human.m_db.总充值 >= 50 and human.m_db.VIP推广人 ~= "" and human.m_db.VIP推广人成长 == 0 then
				VIP推广成长(human.m_db.VIP推广人)
				human.m_db.VIP推广人成长 = 1
			end
			if human.m_db.总充值 >= 50000 then
				human.m_db.vip等级 = 10
			elseif human.m_db.总充值 >= 20000 then
				human.m_db.vip等级 = 9
			elseif human.m_db.总充值 >= 10000 then
				human.m_db.vip等级 = 8
			elseif human.m_db.总充值 >= 5000 then
				human.m_db.vip等级 = 7
			elseif human.m_db.总充值 >= 2000 then
				human.m_db.vip等级 = 6
			elseif human.m_db.总充值 >= 1000 then
				human.m_db.vip等级 = 5
			elseif human.m_db.总充值 >= 500 then
				human.m_db.vip等级 = 4
			elseif human.m_db.总充值 >= 200 then
				human.m_db.vip等级 = 3
			elseif human.m_db.总充值 >= 100 then
				human.m_db.vip等级 = 2
			elseif human.m_db.总充值 >= 50 then
				human.m_db.vip等级 = 1
			else
				human.m_db.vip等级 = 0
			end
			local rmb = 0
			if oJsonInput.rmb >= 100 and oJsonInput.rmb < 200 then
				rmb = math.floor(oJsonInput.rmb * 200 * 1.1)
			elseif oJsonInput.rmb >= 200 and oJsonInput.rmb < 300 then
				rmb = math.floor(oJsonInput.rmb * 200 * 1.2)
			elseif oJsonInput.rmb >= 300 and oJsonInput.rmb < 400 then
				rmb = math.floor(oJsonInput.rmb * 200 * 1.3)
			elseif oJsonInput.rmb >= 400 and oJsonInput.rmb < 500 then
				rmb = math.floor(oJsonInput.rmb * 200 * 1.4)
			elseif oJsonInput.rmb >= 500 then
				rmb = math.floor(oJsonInput.rmb * 200 * 1.5)
			else
				rmb = math.floor(oJsonInput.rmb * 200)
			end
			human:AddRmb(rmb)
			humanName = human.m_db.name
			代理推广人 = human.m_db.代理推广人 or ""
			聊天逻辑.SendSystemChat("恭喜玩家#cffff00,"..humanName.."#C通过在线充值获得#cffff00,"..rmb.."元宝,#c00ffff,如果您也想获得,请赶快充值吧!")
		else
			local db = 玩家DB:New()
			local ret = db:LoadByAccount(oJsonInput.account)
			if ret then
				db.总充值 = db.总充值 + math.floor(oJsonInput.rmb)
				db.每日充值 = db.每日充值 + math.floor(oJsonInput.rmb)
				if db.总充值 >= 50 and db.VIP推广人 ~= "" and db.VIP推广人成长 == 0 then
					VIP推广成长(db.VIP推广人)
					db.VIP推广人成长 = 1
				end
				if db.总充值 >= 50000 then
					db.vip等级 = 10
				elseif db.总充值 >= 20000 then
					db.vip等级 = 9
				elseif db.总充值 >= 10000 then
					db.vip等级 = 8
				elseif db.总充值 >= 5000 then
					db.vip等级 = 7
				elseif db.总充值 >= 2000 then
					db.vip等级 = 6
				elseif db.总充值 >= 1000 then
					db.vip等级 = 5
				elseif db.总充值 >= 500 then
					db.vip等级 = 4
				elseif db.总充值 >= 200 then
					db.vip等级 = 3
				elseif db.总充值 >= 100 then
					db.vip等级 = 2
				elseif db.总充值 >= 50 then
					db.vip等级 = 1
				else
					db.vip等级 = 0
				end
				local rmb = 0
				if oJsonInput.rmb >= 100 and oJsonInput.rmb < 200 then
					rmb = math.floor(oJsonInput.rmb * 200 * 1.1)
				elseif oJsonInput.rmb >= 200 and oJsonInput.rmb < 300 then
					rmb = math.floor(oJsonInput.rmb * 200 * 1.2)
				elseif oJsonInput.rmb >= 300 and oJsonInput.rmb < 400 then
					rmb = math.floor(oJsonInput.rmb * 200 * 1.3)
				elseif oJsonInput.rmb >= 400 and oJsonInput.rmb < 500 then
					rmb = math.floor(oJsonInput.rmb * 200 * 1.4)
				elseif oJsonInput.rmb >= 500 then
					rmb = math.floor(oJsonInput.rmb * 200 * 1.5)
				else
					rmb = math.floor(oJsonInput.rmb * 200)
				end
				db.rmb = db.rmb + rmb
				db.historyRMB = db.historyRMB + rmb
				db:Save()
				humanName = db.name
				代理推广人 = db.代理推广人 or ""
				聊天逻辑.SendSystemChat("恭喜玩家#cffff00,"..humanName.."#C通过在线充值获得#cffff00,"..rmb.."元宝,#c00ffff,如果您也想获得,请赶快充值吧!")
			end
		end
		日志.Write(日志.LOGID_OSS_RECHARGE, os.time(), oJsonInput.account, humanName, oJsonInput.rmb, 代理推广人)
	elseif oJsonInput.result ~= 5 then
		--print("catchpay error: ".._convert(oJsonInput.errormsg))
	end
end

function HandleHttpRequest(input)
  if not Config.ISGAMESVR then
    return "error"
  end
  --print("HttpReqDispatch input = ", input)
  local oJsonInput = Json.Decode(input)
  if oJsonInput.method == nil and oJsonInput.tradeNo and oJsonInput.tradeNo ~= "" then
	oJsonInput.method = "gamepay"
  end
  --print("HandleHttpRequest input = ", oJsonInput.method)
  
  if Config.CHECKAUTH == true then
    --验证
	if _md5(Config.ADMIN_KEY..Config.SVRNAME..oJsonInput.method..oJsonInput.unixTime) ~= oJsonInput.sign then
        return "{\"result\":100,\"errorMsg\":\"sign auth failed\"}"
	end
  end

  local handler = _M[oJsonInput.method]
  if handler then
    return handler(oJsonInput, input)
  end
  return "{method:" .. (oJsonInput.method or "") .. " no handler}"
end
local ParamErrRet={}

function querylogname(oJsonInput)
	print("querylogname", oJsonInput.logtime)
	if not oJsonInput.account or oJsonInput.account == "" then
		ParamErrRet.result = 5
		ParamErrRet.errormsg = "请输入账号"
		return Json.Encode(ParamErrRet)
	end
	if not oJsonInput.key or (oJsonInput.key ~= "" and oJsonInput.key ~= Config.LOG_QUERY_KEY) then
		ParamErrRet.result = 1
		ParamErrRet.errormsg = "查询Key错误"
		return Json.Encode(ParamErrRet)
	end
	if not oJsonInput.logtime or oJsonInput.logtime == "" then
		ParamErrRet.result = 2
		ParamErrRet.errormsg = "请输入日志时间"
		return Json.Encode(ParamErrRet)
	end
	local dt = 实用工具.SplitString(oJsonInput.logtime, "-")
	local dtstr = string.format("%d-%02d-%02d",tonumber(dt[1]) or 0,tonumber(dt[2]) or 0,tonumber(dt[3]) or 0)
	ParamErrRet.result = 0
	ParamErrRet.errormsg = ""
	if oJsonInput.key == Config.LOG_QUERY_KEY then
		ParamErrRet.logname = "登录@1退出登录@1创建角色@1任务@1充值"
	else
		ParamErrRet.logname = "创建角色@1充值"
	end
	return Json.Encode(ParamErrRet)
end

function queryloginfo(oJsonInput)
	print("queryloginfo", _convert(oJsonInput.logname), oJsonInput.logtime)
	if not oJsonInput.account or oJsonInput.account == "" then
		ParamErrRet.result = 5
		ParamErrRet.errormsg = "请输入账号"
		return Json.Encode(ParamErrRet)
	end
	if not oJsonInput.key or (oJsonInput.key ~= "" and oJsonInput.key ~= Config.LOG_QUERY_KEY) then
		ParamErrRet.result = 1
		ParamErrRet.errormsg = "查询Key错误"
		return Json.Encode(ParamErrRet)
	end
	if not oJsonInput.logtime or oJsonInput.logtime == "" then
		ParamErrRet.result = 2
		ParamErrRet.errormsg = "请输入日志时间"
		return Json.Encode(ParamErrRet)
	end
	if not oJsonInput.logname or oJsonInput.logname == "" then
		ParamErrRet.result = 3
		ParamErrRet.errormsg = "请输入日志名称"
		return Json.Encode(ParamErrRet)
	end
	--local dt = os.date("*t")
	--local dtstr = string.format("%d-%02d-%02d",dt.year,dt.month,dt.day)
	local dt = 实用工具.SplitString(oJsonInput.logtime, "-")
	local dtstr = string.format("%d-%02d-%02d",tonumber(dt[1]) or 0,tonumber(dt[2]) or 0,tonumber(dt[3]) or 0)
	local strs = {}
	local cnt = 0
	local logf = nil
	if oJsonInput.logname == "登录" then
		logf = "log/oss_login_"
	elseif oJsonInput.logname == "退出登录" then
		logf = "log/oss_logout_"
	elseif oJsonInput.logname == "创建角色" then
		logf = "log/oss_createrole_"
	elseif oJsonInput.logname == "任务" then
		logf = "log/oss_task_"
	elseif oJsonInput.logname == "充值" then
		logf = "log/oss_recharge_"
	else
		ParamErrRet.result = 4
		ParamErrRet.errormsg = "日志名称错误"
		return Json.Encode(ParamErrRet)
	end
	local f = io.open((__SCRIPT_PATH__ or "")..logf..dtstr..".log", "rb")
	if f then
		local isfirst = true
		while true do
			local str = f:read()
			if not str then
				break
			elseif str ~= "" and (isfirst or oJsonInput.key == Config.LOG_QUERY_KEY or str:sub(-oJsonInput.account:len()-2) == "\""..oJsonInput.account.."\"") then
				strs[#strs+1] = str
			end
			cnt = cnt + 1
			isfirst = false
		end
	end
	local jstr = 实用工具.JoinString(strs, ";") or ""
	jstr = jstr:gsub("@","@@")
	jstr = jstr:gsub(",","@1")
	jstr = jstr:gsub(":","@2")
	jstr = jstr:gsub("\"","@3")
	ParamErrRet.result = 0
	ParamErrRet.errormsg = ""
	ParamErrRet.loginfo = jstr
	return Json.Encode(ParamErrRet)
end

function spreadlink(oJsonInput)
	print("spreadlink", oJsonInput.account, oJsonInput.ip, oJsonInput.agent)
	if not oJsonInput.account or oJsonInput.account == "" then
		ParamErrRet.result = 1
		ParamErrRet.errormsg = "请输入账号"
		return Json.Encode(ParamErrRet)
	end
	if not oJsonInput.ip or oJsonInput.ip == "" then
		ParamErrRet.result = 2
		ParamErrRet.errormsg = "请输入IP"
		return Json.Encode(ParamErrRet)
	end
	spreadhuman[oJsonInput.ip] = {_CurrentTime()+600000, oJsonInput.account, tonumber(oJsonInput.agent) or 0}
	ParamErrRet.result = 0
	ParamErrRet.errormsg = ""
	return Json.Encode(ParamErrRet)
end
