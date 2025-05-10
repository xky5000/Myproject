module(..., package.seeall)

local 地图表 = require("配置.地图表").Config
local 刷新表 = require("配置.刷新表").Config
local 计时器ID = require("公用.计时器ID")
local 公共定义 = require("公用.公共定义")
local 场景管理 = require("公用.场景管理")
local 副本逻辑 = require("副本.副本逻辑")

for k,v in pairs(地图表) do
	if v.logicfile ~= "" then
		v._logicfile = require("副本."..v.logicfile.."逻辑")
	end
end

SceneHumanName = SceneHumanName or {}
SceneMatchList = SceneMatchList or {}
SceneRunTime = SceneRunTime or {}
SceneCostTP = SceneCostTP or {}
SceneLastTime = SceneLastTime or {}

SceneHumanObj = SceneHumanObj or {}
SceneItemObj = SceneItemObj or {}
SceneMonsterObj = SceneMonsterObj or {}
SceneBossObj = SceneBossObj or {}
SceneTowerObj = SceneTowerObj or {}
SceneNpcObj = SceneNpcObj or {}
SceneTeamObj = SceneTeamObj or {}

function CheckMonsterRespawn(scene_id, monster_type)
	if not 场景管理.IsCopyscene(scene_id) then
		return true
	end
	if 场景管理.GetMapType(scene_id) == 1 then
		return true
	end
	if 场景管理.GetMapType(scene_id) ~= 4 then
		return false
	end
	if SceneHumanObj[scene_id] then
		local mapId = 场景管理.GetMapId(scene_id)
		for k,v in pairs(SceneHumanObj[scene_id]) do
			if k.m_db.singlecopyfinish[mapId] == 1 and monster_type == 0 then
				return true
			end
		end
	end
	return false
end

function CheckMonsterDropitem(scene_id)
	if not 场景管理.IsCopyscene(scene_id) then
		return true
	end
	if 场景管理.GetMapType(scene_id) ~= 4 then
		return true
	end
	if SceneHumanObj[scene_id] then
		local mapId = 场景管理.GetMapId(scene_id)
		for k,v in pairs(SceneHumanObj[scene_id]) do
			if k.m_db.singlecopyfinish[mapId] == 1 then
				return true
			end
		end
	end
	return false
end

function GetHumanCount(scene_id,checkdead)
	local cnt = 0
	if SceneHumanObj[scene_id] then
		for k,v in pairs(SceneHumanObj[scene_id]) do
			if not checkdead then
				cnt = cnt + 1
			elseif v == 1 and k.hp > 0 then
				cnt = cnt + 1
			end
		end
	end
	return cnt
end

function GetItemCount(scene_id)
	local cnt = 0
	if SceneItemObj[scene_id] then
		for k,v in pairs(SceneItemObj[scene_id]) do
			cnt = cnt + 1
		end
	end
	return cnt
end

function GetMonsterCount(scene_id,checkdead)
	local cnt = 0
	if SceneMonsterObj[scene_id] then
		for k,v in pairs(SceneMonsterObj[scene_id]) do
			if not checkdead then
				cnt = cnt + 1
			elseif v == 1 and k.hp > 0 then
				cnt = cnt + 1
			end
		end
	end
	return cnt
end

function GetBossCount(scene_id,checkdead)
	local cnt = 0
	if SceneBossObj[scene_id] then
		for k,v in pairs(SceneBossObj[scene_id]) do
			if not checkdead then
				cnt = cnt + 1
			elseif v == 1 and k.hp > 0 then
				cnt = cnt + 1
			end
		end
	end
	return cnt
end

function GetTowerCount(scene_id,checkdead)
	local cnt = 0
	if SceneTowerObj[scene_id] then
		for k,v in pairs(SceneTowerObj[scene_id]) do
			if not checkdead then
				cnt = cnt + 1
			elseif v == 1 and k.hp > 0 then
				cnt = cnt + 1
			end
		end
	end
	return cnt
end

function GetNpcCount(scene_id)
	local cnt = 0
	if SceneNpcObj[scene_id] then
		for k,v in pairs(SceneNpcObj[scene_id]) do
			cnt = cnt + 1
		end
	end
	return cnt
end

function AddSceneObj(scene_id, obj)
	if not 场景管理.IsCopyscene(scene_id) then
		return
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or (obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.isrobot) then
		if SceneHumanObj[scene_id] then
			SceneHumanObj[scene_id][obj] = 1
		else
			SceneHumanObj[scene_id] = {[obj]=1}
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_ITEM then
		if SceneItemObj[scene_id] then
			SceneItemObj[scene_id][obj] = 1
		else
			SceneItemObj[scene_id] = {[obj]=1}
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.ownerid == -1 and obj:GetType() == 2 then
		if SceneBossObj[scene_id] then
			SceneBossObj[scene_id][obj] = 1
		else
			SceneBossObj[scene_id] = {[obj]=1}
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.ownerid == -1 and obj:GetType() == 3 then
		if SceneTowerObj[scene_id] then
			SceneTowerObj[scene_id][obj] = 1
		else
			SceneTowerObj[scene_id] = {[obj]=1}
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.ownerid == -1 then
		if SceneMonsterObj[scene_id] then
			SceneMonsterObj[scene_id][obj] = 1
		else
			SceneMonsterObj[scene_id] = {[obj]=1}
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_NPC then
		if SceneNpcObj[scene_id] then
			SceneNpcObj[scene_id][obj] = 1
		else
			SceneNpcObj[scene_id] = {[obj]=1}
		end
	end
end

function DecSceneObj(scene_id, obj)
	if not 场景管理.IsCopyscene(scene_id) then
		return
	end
	if obj:GetObjType() == 公共定义.OBJ_TYPE_HUMAN or (obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.isrobot) then
		if SceneHumanObj[scene_id] then
			SceneHumanObj[scene_id][obj] = nil
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_ITEM then
		if SceneItemObj[scene_id] then
			SceneItemObj[scene_id][obj] = nil
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.ownerid == -1 and obj:GetType() == 2 then
		if SceneBossObj[scene_id] then
			SceneBossObj[scene_id][obj] = 0
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.ownerid == -1 and obj:GetType() == 3 then
		if SceneTowerObj[scene_id] then
			SceneTowerObj[scene_id][obj] = 0
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and obj.ownerid == -1 then
		if SceneMonsterObj[scene_id] then
			SceneMonsterObj[scene_id][obj] = 0
		end
	elseif obj:GetObjType() == 公共定义.OBJ_TYPE_NPC then
		if SceneNpcObj[scene_id] then
			SceneNpcObj[scene_id][obj] = nil
		end
	end
end

function KillSceneObj(scene_id, obj, atker)
	if not 场景管理.IsCopyscene(scene_id) then
		if obj:GetObjType() == 公共定义.OBJ_TYPE_MONSTER and (obj:GetType() == 2 or obj:GetType() == 3) then
			副本逻辑.SendWorldBossDead(obj, atker)
		end
		return
	end
	local mapid = 场景管理.SceneId2ConfigMapId[scene_id]
	local mapConfig = 地图表[mapid]
	if mapConfig and mapConfig._logicfile then
		mapConfig._logicfile.KillSceneObj(scene_id, obj, atker)
	end
end

function ReliveSceneObj(scene_id, obj)
	if not 场景管理.IsCopyscene(scene_id) then
		return
	end
	local mapid = 场景管理.SceneId2ConfigMapId[scene_id]
	local mapConfig = 地图表[mapid]
	if mapConfig and mapConfig._logicfile then
		mapConfig._logicfile.ReliveSceneObj(scene_id, obj)
	end
end

function LevelUpSceneObj(scene_id, obj)
	if not 场景管理.IsCopyscene(scene_id) then
		return
	end
	local mapid = 场景管理.SceneId2ConfigMapId[scene_id]
	local mapConfig = 地图表[mapid]
	if mapConfig and mapConfig._logicfile then
		mapConfig._logicfile.LevelUpSceneObj(scene_id, obj)
	end
end
