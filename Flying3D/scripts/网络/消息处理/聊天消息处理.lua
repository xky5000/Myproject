module(..., package.seeall)

local 聊天UI = require("主界面.聊天UI")

function GC_CHAT(rolename,objid,msgtype,msg)
	聊天UI.添加文本(rolename,objid,msgtype,msg)
	if objid ~= -1 then
		local role = g_roles[objid]
		if role and role.hpbar then
			local tf = role.hpbar.tf
			if not tf then
				tf = F3DTextField:new()
				role.hpbar.tf = tf
				role.hpbar:addChild(tf)
			end
			if g_mobileMode then
				tf:setTextFont("宋体",16,false,false,false)
			end
			if msg:sub(1,2) == "#c" then
				tf:setTextColor(tonumber(msg:sub(3,msg:find(",")-1),16) or 0xffffff, 0)
				msg = msg:sub(msg:find(",")+1)
			end
			tf:setText(txt(role.name..": "..msg))
			tf:setPivot(0.5,0.5)
			tf:setPositionX(0)
			tf:setPositionY(-15)
			local prop = F3DTweenProp:new()
			F3DTween:fromPool():start(tf, prop, 3, func_n(function()
				tf:setText("")
			end))
		end
	end
end

