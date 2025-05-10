module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 宠物UI = require("宠物.宠物UI")

local targetPos = F3DVector3:new()

function GC_MERGE_PET(objid,petobjid)
	local role = g_roles[objid]
	local petrole = g_roles[petobjid]
	if role and petrole then
		targetPos:setVal(petrole:getPositionX(), petrole:getPositionY(),
			g_scene and g_scene:getTerrainHeight(petrole:getPositionX(), petrole:getPositionY()) or 0)
		if not ISMIR2D then
			role:setEffectSystem(全局设置.getEffectUrl(3646), false, targetPos, nil, 0, 0, nil, nil, -1, 2)
		end
	end
end

function GC_PET_INFO(petinfo,callinfo)
	宠物UI.setPetInfo(petinfo,callinfo)
end

function GC_STAR_UPGRADE(objid,starlevel)
	local role = g_roles[objid]
	if role and role.objtype == 全局设置.OBJTYPE_PET then
		if not ISMIR2D then
			role:setEffectSystem(全局设置.getEffectUrl(3660), false)
		end
	end
end

function GC_TRAIN_PET(result)
	if result == 0 then
		宠物UI.onTrainSuccess()
	end
end

