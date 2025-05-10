module(..., package.seeall)

local 地图表 = require("配置.地图表").Config
local 刷新表 = require("配置.刷新表").Config
local 计时器ID = require("公用.计时器ID")
--local 副本管理 = require("副本.副本管理")
local 公共定义 = require("公用.公共定义")

local INIT_DAY_NIGHT_TIME = 600 * 1000

-- relation link: 配置 mapid -> logic mapid -> scene id
ConfigMapId2LogicMapId = ConfigMapId2LogicMapId or {}
LogicMapId2SceneId = LogicMapId2SceneId or {}
SceneId2ConfigMapId = SceneId2ConfigMapId or {}
IdleCopySceneIds = IdleCopySceneIds or {}
-- {"SceneId_Type": Count}
SceneObjCount = SceneObjCount or {}

-- 场景内怪物
SceneMonster = SceneMonster or {}

-- 昼夜模式
SceneMod = SceneMod or {}
function RegisterDayNightMod(sceneId)
  local timerId = _AddTimer(sceneId, 计时器ID.TIMER_DAY_NIGHT_TRANS, INIT_DAY_NIGHT_TIME, 1, 0, 0, 0)
  if timerId < 0 then
    print("Register error:", timerId)
  end
  SceneMod[sceneId] = { mode = 0, transTime = os.time() + INIT_DAY_NIGHT_TIME }
end

function InitMap(configMapId)
	print(string.format("----------LoadMap:%d----------", configMapId))
	local mapConfig = 地图表[configMapId]
	local logicMapId = _LoadMap((__SCRIPT_PATH__ or "") .. mapConfig.map)
	ConfigMapId2LogicMapId[configMapId] = logicMapId

	for i = 1, mapConfig.scenecount do
		AppendScene(configMapId)
	end
end

function AppendScene(configMapId, idlehumans)
	local mapConfig = 地图表[configMapId]
	local logicMapId = ConfigMapId2LogicMapId[configMapId]

	local MoveGrid = GetMoveGrid(configMapId)
	local MoveGridRate = MoveGrid and MoveGrid[1]/MoveGrid[2] or 2
	local sceneId = _AddScene(logicMapId, mapConfig.scenetype, mapConfig.zonesize, MoveGridRate)
	--assert( sceneId > -1 , string.format( "append scene failed! on map:%d.", configMapId ) )

	SceneId2ConfigMapId[sceneId] = configMapId
	if IsCopyscene(sceneId) then
		--副本管理.CopySceneStatus[sceneId] = 副本管理.COPY_SCENE_STATUS_FREE
		--副本管理.CopySceneHumanCounter[sceneId] = 0
		--副本管理.HeartbeatCounter[sceneId] = 0
		--副本管理.CopySceneMembers[sceneId] = {}
	end

	if LogicMapId2SceneId[logicMapId] == nil then
		LogicMapId2SceneId[logicMapId] = {}
	end
	local num = #LogicMapId2SceneId[logicMapId]
	LogicMapId2SceneId[logicMapId][num + 1] = sceneId

	if GetIsCopy(configMapId) then
		table.insert(IdleCopySceneIds,math.random(1,#IdleCopySceneIds+1),{sceneId, idlehumans or {}})
	end
	return sceneId
end

function LoadAllMaps()
  for mapid, _ in pairs(地图表) do
    InitMap(mapid)
  end
  for _, conf in ipairs(刷新表) do
	local sceneid = GetSceneId(conf.mapid)
	if sceneid ~= -1 then
		local cnt = 0
		local Is2DScene = GetIs2DScene(conf.mapid)
		local MoveGrid = GetMoveGrid(conf.mapid)
		local MoveGridRate = MoveGrid and MoveGrid[1]/MoveGrid[2] or 2
		local gencnt = 0
		local bornrange = conf.bornpos[3]
		while cnt < conf.cnt do
			local x = conf.bornpos[1] + math.random(-bornrange, bornrange)
			local y = conf.bornpos[2] + math.random(-bornrange, bornrange) * (Is2DScene and 1/MoveGridRate or 1)
			if MoveGrid then
				x = math.floor(x / MoveGrid[1]) * MoveGrid[1] + MoveGrid[1]/2
				y = math.floor(y / MoveGrid[2]) * MoveGrid[2] + MoveGrid[2]/2
			end
			if _IsPosCanRun(sceneid, x, y) then
				CreateLuaObj(sceneid, conf.monid, x, y, conf.type == 1 and 公共定义.OBJ_TYPE_MONSTER or 公共定义.OBJ_TYPE_NPC, conf.expire)
				cnt = cnt + 1
				gencnt = 0
			else
				if bornrange == 0 then
					bornrange = MoveGrid and MoveGrid[1] or 50
				end
				if gencnt >= 10000 then
					print("genid",_)
					cnt = cnt + 1
					gencnt = 0
				end
				gencnt = gencnt + 1
			end
		end
	end
  end
  --_AddTimer(0, 计时器ID.TIMER_COPYSCENE_MANAGER, 10 * 1000, -1, 0, 0, 0)
  --_AddTimer(0, 计时器ID.TIMER_COPYSCENE_AI, 1 * 1000, -1, 0, 0, 0)
end

function GetMapId(sceneId)
  return SceneId2ConfigMapId[sceneId]
end

function CheckSafeArea(mapId, x, y)
  local map = 地图表[mapId]
  if map == nil then
	return false
  end
  if #map.safearea == 0 then
	return false
  end
  for i,v in ipairs(map.safearea) do
	  local posx = #map.movegrid > 0 and math.floor(v[1]/map.movegrid[1])*map.movegrid[1]+map.movegrid[1]/2 or v[1]
	  local posy = #map.movegrid > 0 and math.floor(v[2]/map.movegrid[2])*map.movegrid[2]+map.movegrid[2]/2 or v[2]
	  local rangex = v[3]
	  local rangey = v[3] / (#map.movegrid > 0 and map.movegrid[1] / map.movegrid[2] or 1)
	  if x >= posx - rangex and x <= posx + rangex and y >= posy - rangey and y <= posy + rangey then
		rangex = math.floor(rangex/2)
		rangey = math.floor(rangey/2)
		return true, v[1] + math.random(-rangex,rangex), v[2] + math.random(-rangey,rangey)
	  end
  end
  return false
end

function GetAutoBack(mapId)
  local map = 地图表[mapId]
  if map == nil then
	return 0
  end
  return map.autoback
end

function GetMapName(mapId)
  local map = 地图表[mapId]
  if map == nil then
	return ""
  end
  return map.name
end

function GetIs2DScene(mapId)
  local map = 地图表[mapId]
  if map == nil then
	return false
  end
  return map.scenetype == 0
end

function GetMoveGrid(mapId)
  local map = 地图表[mapId]
  if map == nil then
	return
  end
  if #map.movegrid == 0 then
	return
  end
  return map.movegrid
end

-- 这个函数只能取正常类型的sceneID 如果地图无效或者是副本地图 那么返回-1
-- is_check_human_full=true时，会根据地图表的humancount配置去限制场景人数
-- 
function GetSceneId(mapId, is_check_human_full)
  local map = 地图表[mapId]

  if map == nil or GetIsCopy(mapId) then
    return -1
  end

  if (is_check_human_full == nil) then
    is_check_human_full = false
  end

  local mapConfig = 地图表[mapId]
  local logicMapId = ConfigMapId2LogicMapId[mapId]

  if ((logicMapId < 0) or (mapConfig == nil)) then 
    return -1 
  end

  local Scenes = LogicMapId2SceneId[logicMapId]
  local target_scene = nil
  local max_human_per_scene = mapConfig.humancount
  assert(max_human_per_scene ~= nil)

  if (is_check_human_full and max_human_per_scene > 0) then
    local scene_count = #Scenes
    local scene_human_count = 0
    for i = 1, scene_count do
        scene_human_count = GetSceneObjCount(Scenes[i], 公共定义.OBJ_TYPE_HUMAN)
        if (scene_human_count < max_human_per_scene) then
            target_scene = Scenes[i]
            break
        end
    end 

    -- 
    if (target_scene == nil) then
        target_scene = AppendScene(mapId)
    end 
  else
    -- 如果不检测是否满人，直接返回
    target_scene = Scenes[1]
  end
  return target_scene
end

function IsNoDrug(sceneId)
  local mapConfig = GetMapconfigBySceneId(sceneId)
  return mapConfig and mapConfig.nodrug or 0
end

function IsMine(sceneId)
  local mapConfig = GetMapconfigBySceneId(sceneId)
  return mapConfig and mapConfig.mine or 0
end

function GetMapType(sceneId)
  local mapConfig = GetMapconfigBySceneId(sceneId)
  return mapConfig and mapConfig.maptype or 0
end

function IsValidMapId(configMapId)
  return 地图表[configMapId] ~= nil
end

function IsCopyscene(sceneId)
  local configMapId = SceneId2ConfigMapId[sceneId]
  if configMapId == nil then
    return false
  end
  return GetIsCopy(configMapId)
end

function IsSafeMap(sceneId)
  local configMapId = SceneId2ConfigMapId[sceneId]
  if configMapId == nil then
    return 0
  end
  local mapConfig = 地图表[configMapId]
  if mapConfig == nil then
    return 0
  end
  return mapConfig.safemap
end

function GetMapconfigBySceneId(sceneId)
  local mapId = GetMapId(sceneId)
  local mapConfig = 地图表[mapId]
  return mapConfig
end

function GetIsCopy(mapid) --判断是否副本
  local conf = 地图表[mapid]
  if conf and conf.maptype ~= 0 then
    return true
  else
	return false
  end
  --return 199 < mapid
end

function GetPosCanRun(sceneId)
	local mapheight, mapwidth = _GetHeightAndWidth(sceneId)
	local x, y
	while 1 do
		x = math.random(1,mapwidth-1)
		y = math.random(1,mapheight-1)
		if _IsPosCanRun(sceneId, x, y) then
			return x, y
		end
	end
end

--判断是否需要伤害统计
function IsNeedStatsHurt(sceneId)
  local mapid = GetMapId(sceneId)
  local conf = 地图表[mapid]
  if conf and conf.isStatsHurt == 1 then
    return true
  end
  return false
end

function AddSceneObjCount(scene_id, obj_type)
    assert(scene_id>= 0 and obj_type >= 0, "Parameter error")
	SceneObjCount[scene_id] = SceneObjCount[scene_id] or {}
	SceneObjCount[scene_id][obj_type] = (SceneObjCount[scene_id][obj_type] or 0) + 1
    --[[local key = string.format("%d_%d", scene_id, obj_type)
    local cur_count = SceneObjCount[key]
    cur_count = (cur_count == nil and 0 or cur_count) + 1
    SceneObjCount[key] = cur_count
    return cur_count]]
end

function DecSceneObjCount(scene_id, obj_type)
    assert(scene_id>= 0 and obj_type >= 0, "Parameter error")
 	if SceneObjCount[scene_id] and SceneObjCount[scene_id][obj_type] then
		SceneObjCount[scene_id][obj_type] = SceneObjCount[scene_id][obj_type] - 1
		if SceneObjCount[scene_id][obj_type] <= 0 then
			SceneObjCount[scene_id][obj_type] = nil
		end
	end
   --[[local key = string.format("%d_%d", scene_id, obj_type)
    local cur_count = SceneObjCount[key]
    cur_count = (cur_count == nil and 0 or cur_count) - 1
    -- 暂时屏蔽断言
    -- assert(cur_count >= 0, string.format("Count can't less than zero(%d, %d, %d)", scene_id, obj_type, cur_count))
    if (cur_count < 0) then
        cur_count = 0
    end
    SceneObjCount[key] = cur_count 
    return cur_count]]
end

function GetSceneObjCount(scene_id, obj_type)
    assert(scene_id>= 0 and obj_type >= 0, "Parameter error")
 	if SceneObjCount[scene_id] and SceneObjCount[scene_id][obj_type] then
		return SceneObjCount[scene_id][obj_type]
	else
		return 0
	end
    --[[local key = string.format("%d_%d", scene_id, obj_type)
    local cur_count = SceneObjCount[key]
    cur_count = (cur_count == nil) and 0 or cur_count
    return cur_count]]
end
