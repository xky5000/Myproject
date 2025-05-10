module(..., package.seeall)
ProtoTemplate = ProtoTemplate or {}
ProtoContainer = ProtoContainer or {} --装载协议的可重用table
ProtoName = ProtoName or {}
ProtoHandler = ProtoHandler or {} --包含所有CG协议的handler
ProtoContainer2PacketID = {}

-- TODO 改进这个协议检测函数
__index = function(t, k)
	local packetID = ProtoContainer2PacketID[t] or ""
	print(packetID, ".", k, "get not exist key")
	-- assert(nil)
    return nil
end

__newindex = function(t, k, v)
	local packetID = ProtoContainer2PacketID[t] or ""
    t[k] = v
	print(packetID, ".", k, "set not exist key")
end

local function SetProtoContainerMetatable(tb)
	setmetatable(tb, _M)
	for k, v in pairs(tb) do
		if type(v) == "table" then
			SetProtoContainerMetatable(v)
		end
	end
end

local function InitProtoContainer(msg, template, protoName, step)
	step = step or 0
	for k, v in ipairs(template) do
		if v[3] > 1 then
			msg[v[1] .. "Len"] = 0
			msg[v[1]] = {}
			if protoName:sub(1, 2) == "GC" and v[2] == "CHAR" and (64 < v[3] or 6 < v[3] and 0 < step) then
				print(protoName, " ", v[1])
				assert()
			end
			for i = 1, v[3] do
				if type(v[2]) == "string" then
					msg[v[1]][i] = 0
				else
					msg[v[1]][i] = {}
					InitProtoContainer(msg[v[1]][i], v[2], protoName, step + 1)
				end
			end
		else
			if type(v[2]) == "string" then
				msg[v[1]] = 0
			else
				msg[v[1]] = {}
				InitProtoContainer(msg[v[1]], v[2], protoName, step + 1)
			end
		end
	end
end

local function CheckMsg(msg, template)
	for k, v in ipairs(template) do
		if v[3] > 1 then
			if type(rawget(msg, v[1] .. "Len")) ~= "number" then
				return
			end
			local tmp = type(rawget(msg, v[1]))
			if tmp == "table" then
				for i = 1, v[3] do
					if type(v[2]) == "string" then
						if type(rawget(msg[v[1]], i)) ~= "number" then
							return
						end
					else
						if type(rawget(msg[v[1]], i)) ~= "table" then
							return
						end
						if not CheckMsg(msg[v[1]][i], v[2]) then
							return
						end
					end
				end
			elseif tmp ~= "string" then
				return
			end
		else
			if type(v[2]) == "string" then
				if type(rawget(msg, v[1])) ~= "number" then
					return
				end
			else
				if type(rawget(msg, v[1])) ~= "table" then
					return
				end
				if not CheckMsg(msg[v[1]], v[2]) then
					return
				end
			end
		end
	end
	return true
end

function Register(packetID, protoTemplate, protoName, protoHandler)
	if ProtoContainer[packetID] then
		if not CheckMsg(ProtoContainer[packetID], protoTemplate) then
			print("fail msg ", packetID, protoName)
			ProtoContainer[packetID] = {}
			InitProtoContainer(ProtoContainer[packetID], protoTemplate, protoName)
			SetProtoContainerMetatable(ProtoContainer[packetID])
		end
	else
		ProtoContainer[packetID] = {}
		InitProtoContainer(ProtoContainer[packetID], protoTemplate, protoName)
		SetProtoContainerMetatable(ProtoContainer[packetID])
		_ProtoTemplateToTree(packetID, protoTemplate)
	end

	ProtoTemplate[packetID] = protoTemplate
	ProtoName[packetID] = protoName
	ProtoHandler[packetID] = protoHandler
	ProtoContainer2PacketID[ProtoContainer[packetID]] = packetID

end

local function TraceMsgDfs(msg, template, step)
	for k, v in ipairs(template) do
		if v[3] > 1 then
			print(string.rep("	", step), v[1].."Len", "=", msg[v[1].."Len"])
			if type(msg[v[1]]) == "string" then 
				print(string.rep("	", step), msg[v[1]])
			else
				for i = 1, msg[v[1].."Len"] do
					if type(v[2]) == "table" then
						TraceMsgDfs(msg[v[1]][i], v[2], step + 1)
					else
						print(string.rep("	", step), i, "=", msg[v[1]][i])
					end
				end
			end
		else
			if type(v[2]) == "table" then
				TraceMsgDfs(msg[v[1]], v[2], step + 1)
			else
				print(string.rep("	", step), v[1], "=", msg[v[1]])
			end
		end
	end
end

function TraceMsg(msg)
	local packetID = ProtoContainer2PacketID[msg]
	print(ProtoName[packetID])
	TraceMsgDfs(msg, ProtoTemplate[packetID], 0)
end

--定时器分发
TimerDispatcher = {}
function RegisterTimerHandler(nEventID, TimerHandler)
	TimerDispatcher[nEventID] = TimerHandler
end
