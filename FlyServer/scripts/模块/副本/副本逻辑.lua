module(..., package.seeall)

local 派发器 = require("公用.派发器")
local 协议ID = require("公用.协议ID")
local 消息类 = require("公用.消息类")
local 聊天定义 = require("聊天.聊天定义")
local GM命令 = require("聊天.GM命令")
local 实用工具 = require("公用.实用工具")
local 公共定义 = require("公用.公共定义")
local 地图表 = require("配置.地图表").Config
local 刷新表 = require("配置.刷新表").Config
local 怪物表 = require("配置.怪物表").Config
local 场景管理 = require("公用.场景管理")
local 副本管理 = require("副本.副本管理")
local 聊天逻辑 = require("聊天.聊天逻辑")

BossInfo = {}
for i,v in pairs(怪物表) do
	if v.type == 1 or v.type == 2 or v.type == 3 then
		local 战力 = 0--v.hp/10+v.atk/2+v.def+v.crit+v.firm+v.hit+v.dodge
		local 战力2 = {}
		for k,vv in ipairs(公共定义.属性文字) do
			local 属性 = v[vv] or 0
			if k == 1 or k == 2 then
				战力 = 战力 + 属性/10
			elseif k >= 3 or k <= 12 then
				ii = math.ceil(k/2)
				战力2[ii] = math.max(战力2[ii] or 0, 属性)
			else
				战力 = 战力 + 属性
			end
		end
		for k,vv in pairs(战力2) do
			战力 = 战力 + vv
		end
		BossInfo[i] = {name=v.name,vid=v.id,bodyid=v.bodyid[1],effid=v.effid[1],zhanli=战力,level=v.level,relive=(Config.IS3G or Config.ISWZ) and v.relive or 24*360000*(v.type == 1 and 1 or 10),reliveboss=v.relive}
	end
end
BossMonsterID = {}
for i,v in pairs(地图表) do
	if v.maptype ~= 0 and v.maptype ~= 1 then
		for ii,vv in ipairs(刷新表) do
			if i == vv.mapid and vv.type == 1 and BossInfo[vv.monid] then
				BossMonsterID[i] = vv.monid
				break
			end
		end
	end
end

function SendSingleCopyInfo(human)
  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_SINGLECOPY_INFO]
  oReturnMsg.infoLen = 0
	for i,v in pairs(地图表) do
		if v.maptype == 1 or v.maptype == 2 or v.maptype == 4 then
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			local il = oReturnMsg.infoLen
			oReturnMsg.info[il].mapid = i
			oReturnMsg.info[il].cnt = human.m_db.singlecopy[i] or 0
			oReturnMsg.info[il].cntmax = v.daycnt
			oReturnMsg.info[il].dropitemLen = 0
			local bossinfo = BossInfo[BossMonsterID[i]]
			oReturnMsg.info[il].首领 = bossinfo and bossinfo.name or ""
			oReturnMsg.info[il].finish = (v.maptype == 4 and human.m_db.singlecopyfinish[i] == 1) and 1 or 0
			if not human.m_db.bosssinglecopy[i]  then
				oReturnMsg.info[il].relive = 0
			elseif _CurrentOSTime() - human.m_db.bosssinglecopy[i] > (bossinfo and bossinfo.relive or 0) then
				oReturnMsg.info[il].relive = 0
				human.m_db.bosssinglecopy[i] = nil
			else
				oReturnMsg.info[il].relive = (bossinfo and bossinfo.relive or 0) - (_CurrentOSTime() - human.m_db.bosssinglecopy[i])
			end
		end
	end
  消息类.SendMsg(oReturnMsg, human.id)
end

function SendBossCopyInfo(human)
  local oReturnMsg = 派发器.ProtoContainer[协议ID.GC_BOSSCOPY_INFO]
  oReturnMsg.infoLen = 0
	for i,v in pairs(地图表) do
		if v.maptype == 3 then
			if oReturnMsg.infoLen >= 200 then
				break
			end
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			local il = oReturnMsg.infoLen
			local 武神殿地图1 = Config.IS3G and 5001 or 9048
			local 武神殿地图2 = Config.IS3G and 5099 or 9085
			local 魔神殿地图 = Config.IS3G and 4001 or 10000
			oReturnMsg.info[il].type = (i >= 武神殿地图1 and i <= 武神殿地图2) and 3 or i >= 魔神殿地图 and 2 or 1
			oReturnMsg.info[il].mapid = i
			local bossinfo = BossInfo[BossMonsterID[i]]
			oReturnMsg.info[il].bodyid = bossinfo and bossinfo.bodyid or 0
			oReturnMsg.info[il].effid = bossinfo and bossinfo.effid or 0
			oReturnMsg.info[il].name = bossinfo and bossinfo.name or ""
			oReturnMsg.info[il].zhanli = bossinfo and bossinfo.zhanli or 0
			oReturnMsg.info[il].level = bossinfo and bossinfo.level or 0
			if not human.m_db.bosscopy[i]  then
				oReturnMsg.info[il].status = 0
				oReturnMsg.info[il].relive = 0
			elseif _CurrentOSTime() - human.m_db.bosscopy[i] > (bossinfo and bossinfo.relive or 0) then
				oReturnMsg.info[il].status = 0
				oReturnMsg.info[il].relive = 0
				human.m_db.bosscopy[i] = nil
			else
				oReturnMsg.info[il].status = 2
				oReturnMsg.info[il].relive = (bossinfo and bossinfo.relive or 0) - (_CurrentOSTime() - human.m_db.bosscopy[i])
			end
			oReturnMsg.info[il].dropitemLen = 0
		end
	end
	for i,v in ipairs(WorldBossManager) do
		if v:GetType() == 2 or v:GetType() == 3 then
			if oReturnMsg.infoLen >= 200 then
				break
			end
			oReturnMsg.infoLen = oReturnMsg.infoLen + 1
			local il = oReturnMsg.infoLen
			local mapconf = 地图表[v.bornmapid]
			oReturnMsg.info[il].type = (not Config.ISWZ and mapconf and mapconf.转生等级 > 0) and 2 or (Config.ISWZ and mapconf.viplevel > 0) and 2 or 0
			oReturnMsg.info[il].mapid = v.bornmapid
			local bossinfo = BossInfo[v.m_nMonsterID]
			oReturnMsg.info[il].bodyid = bossinfo and bossinfo.bodyid or 0
			oReturnMsg.info[il].effid = bossinfo and bossinfo.effid or 0
			oReturnMsg.info[il].name = bossinfo and bossinfo.name or ""
			oReturnMsg.info[il].zhanli = bossinfo and bossinfo.zhanli or 0
			oReturnMsg.info[il].level = bossinfo and bossinfo.level or 0
			if v.hp > 0 then-- v.m_nSceneID ~= -1 and
				oReturnMsg.info[il].status = 0
				oReturnMsg.info[il].relive = 0
			else
				oReturnMsg.info[il].status = 1
				oReturnMsg.info[il].relive = (bossinfo and bossinfo.reliveboss or 0) - (_CurrentOSTime() - (v.lastdeadtime or 0))
			end
			oReturnMsg.info[il].dropitemLen = 0
		end
	end
  消息类.SendMsg(oReturnMsg, human.id)
end

function SendWorldBossDead(obj, atker)
	local ownerid = atker.id
	if (atker:GetObjType() == 公共定义.OBJ_TYPE_HERO or atker:GetObjType() == 公共定义.OBJ_TYPE_MONSTER or atker:GetObjType() == 公共定义.OBJ_TYPE_PET) and atker.ownerid ~= -1 then
		ownerid = atker.ownerid
	end
	local human = 对象类:GetObj(ownerid)
	聊天逻辑.SendSystemChat("#cff00ff,"..场景管理.GetMapName(场景管理.GetMapId(obj.m_nSceneID)).."#C的#cffff00,"..obj:GetName().."#C被玩家#cffff00,"..human:GetName().."#C击杀,宝物散落一地")
end
