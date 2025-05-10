module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")
local 主界面UI = require("主界面.主界面UI")
local 实用工具 = require("公用.实用工具")
local 角色逻辑 = require("主界面.角色逻辑")

CHAT_TYPE_SYSTEM = 0 --系统
CHAT_TYPE_WORLD = 1 --世界
CHAT_TYPE_NEARBY = 2 --附近
CHAT_TYPE_GUILD = 3 --帮会
CHAT_TYPE_TEAM = 4 --队伍
CHAT_TYPE_PRIVATE = 5 --私聊
CHAT_TYPE_SPEAKER = 6 --喇叭

CHANNEL = {
	txt("世界"),
	txt("附近"),
	txt("帮会"),
	txt("队伍"),
	txt("私聊"),
	txt("喇叭"),
}

colorval = {}
colorval[0] = "0xff0000"
colorval[1] = "0x00ffff"
colorval[2] = "0x00ff00"
colorval[3] = "0x0000ff"
colorval[4] = "0xffff00"
colorval[5] = "0xff00ff"
colorval[6] = "0xff9900"

m_init = false
m_strs = {}
m_history = {}
m_historyindex = 0
m_channel = 0
m_itempool = {}
m_items = {}

function popItem()
	if #m_itempool > 0 then
		local cb = m_itempool[#m_itempool]
		table.remove(m_itempool, #m_itempool)
		return cb
	end
end

function pushItem(cb)
	cb.rtf:setTitleText("")
	m_items[cb] = nil
	m_itempool[#m_itempool+1] = cb
end

function calcTextWidth(str, fontsize)
	local cnt = 0
	local s = 1
	local word = 0
	local skip = false
	local strs = {}
	for i=1,str:len() do
		if str:byte(i) == 35 then--"#"
			skip = true
		elseif skip and str:byte(i) == 35 then--"#"
			skip = false
			cnt = cnt + 1
		elseif skip and str:byte(i) == 44 then--","
			skip = false
		elseif skip and ((str:byte(i) >= 65 and str:byte(i) <= 90) or str:byte(i) == 110 or str:byte(i) == 98 or str:byte(i) == 105 or str:byte(i) == 117) and str:byte(i-1) == 35 then
			skip = false
		elseif not skip then
			if str:byte(i) > 127 then
				word = word + 1
			end
			if str:byte(i) > 127 and (__PLATFORM__ == "ANDROID" or __PLATFORM__ == "IOS") and word%3==0 then
				cnt = cnt + 2
			else
				cnt = cnt + 1
			end
		end
	end
	return cnt * fontsize / 2
end

function trimText(str, linecnt)
	local cnt = 0
	local s = 1
	local word = 0
	local skip = false
	local strs = {}
	for i=1,str:len() do
		if str:byte(i) == 35 then--"#"
			skip = true
		elseif skip and str:byte(i) == 35 then--"#"
			skip = false
			cnt = cnt + 1
		elseif skip and str:byte(i) == 44 then--","
			skip = false
		elseif skip and str:byte(i) == 110 and str:byte(i-1) == 35 then--"n"
			if #strs > 0 and cnt == 0 then
				strs[#strs] = strs[#strs]..str:sub(s,i-2)
				s = i+1
			else
				strs[#strs+1] = str:sub(s,i-2)
				s = i+1
			end
			skip = false
			cnt = 0
		elseif skip and ((str:byte(i) >= 65 and str:byte(i) <= 90) or str:byte(i) == 98 or str:byte(i) == 105 or str:byte(i) == 117) and str:byte(i-1) == 35 then
		--"A""Z""b""i""u""#"
			if #strs > 0 and cnt == 0 then
				strs[#strs] = strs[#strs]..str:sub(s,i)
				s = i+1
			end
			skip = false
		elseif not skip then
			if str:byte(i) > 127 then
				word = word + 1
			end
			if str:byte(i) > 127 and (__PLATFORM__ == "ANDROID" or __PLATFORM__ == "IOS") and word%3==0 then
			else
				cnt = cnt + 1
			end
		end
		if cnt >= linecnt then
			local aword = (__PLATFORM__ == "ANDROID" or __PLATFORM__ == "IOS") and (word%3==0 and 1 or (word%3==1 and 0 or -1)) or
				(word%2==0 and 1 or 0)
			strs[#strs+1] = str:sub(s,i-1+aword)
			cnt = 0
			s = i+aword
		end
	end
	if s <= str:len() then
		strs[#strs+1] = str:sub(s)
	end
	return 实用工具.JoinString(strs, "#n"), #strs
end

function 添加文本(rolename,objid,msgtype,msg)
	local name = rolename == 角色逻辑.m_rolename and txt("我：") or rolename ~= "" and txt(rolename)..": " or ""
	local str = (g_mobileMode and "#s16," or "").."#c"..colorval[msgtype]..txt(",【")..((msgtype == 0 and txt("系统") or CHANNEL[msgtype])..txt("】")..name.."#C"..txt(msg):gsub("\n","#n"))
	if #m_strs >= 100 then
		table.remove(m_strs, 1)
	end
	if m_init and ui.list:numItems() >= 50 then
		pushItem(ui.list:getItem(0))
		ui.list:removeItem(nil, 0)
	end
	local initlist = m_init and ui.list:getWidth() > 0
	local linecnt = g_mobileMode and (initlist and math.floor((ui.list:getWidth()-20)/8) or 55) or ISMIRUI and (initlist and math.floor((ui.list:getWidth()-20)/6) or 105) or (initlist and math.floor((ui.list:getWidth()-20)/6) or 38)
	str = trimText(str, linecnt)
	m_strs[#m_strs+1] = {msgtype,str}
	update(str)
end

function update(str)
	if not m_init then
		return
	end
	ui.list:getVScroll():setPercent(1)
	if str == nil then
		for i,v in ipairs(m_strs) do
			if m_channel == 0 or m_channel == v[1] then
				addStr(v[2])
			end
		end
	else
		addStr(str)
	end
end

function addStr(str)
	local cb = popItem() or F3DCheckBox:new()
	
	if not cb.rtf then
		cb.rtf = F3DRichTextField:new()
		cb:addChild(cb.rtf)
	end
	local line = 1
	local s = 1
	local p = str:find("#n",s)
	while p do
		if str:byte(p-1) ~= string.byte("#") then
			line = line + 1
		end
		s = p + 2
		p = str:find("#n",s)
	end
	cb:setHeight(g_mobileMode and (line*18+2) or (line*14+2))
	cb.rtf:setTitleText(str)
	ui.list:addItem(cb)
	m_items[cb] = 1
end

function onEnter(e)
	if ui.textinput:isDefault() or ui.textinput:getTitleText() == "" then
		主界面UI.showTipsMsg(1, txt("请输入聊天内容"))
		return
	end
	local str = ui.textinput:getTitleText()
	local channel = 1
	--[[for i,v in ipairs(CHANNEL) do
		if ui.combo:getTitleText() == CHANNEL[i] then
			channel = i
			break
		end
	end]]
	消息.CG_CHAT(channel,utf8(str:gsub("#","##")))
	for i,v in ipairs(m_history) do
		if v == str then
			table.remove(m_history, i)
			break
		end
	end
	m_history[#m_history+1] = str
	m_historyindex = #m_history
	ui.textinput:setTitleText("")
	e:stopPropagation()
end

function onKeyDown(e)
	if F3DTextInput.sTextInput ~= ui.textinput then return end
	if e:getKeyCode() == F3DKeyboardCode.UP then
		if m_history[m_historyindex] then
			ui.textinput:setTitleText(m_history[m_historyindex])
			m_historyindex = math.max(1, m_historyindex - 1)
		end
	elseif e:getKeyCode() == F3DKeyboardCode.DOWN then
		if m_history[m_historyindex] then
			ui.textinput:setTitleText(m_history[m_historyindex])
			m_historyindex = math.min(#m_history, m_historyindex + 1)
		end
	end
end

function onUIInit()
	ui.正常 = ui:findComponent("正常")
	ui.textinput = tt(ui:findComponent("正常,输入"),F3DTextInput)
	ui.textinput:addEventListener(F3DUIEvent.INPUT_ENTER, func_ue(onEnter))
	ui.list = tt(ui:findComponent("正常,列表"),F3DList)
	ui.enter = ui:findComponent("正常,回车")
	ui.enter:addEventListener(F3DMouseEvent.CLICK, func_me(onEnter))
	ui.combo = tt(ui:findComponent("正常,组合框"),F3DCombo)
	for i=1,6 do
		local cb = F3DCheckBox:new()
		cb:setHeight(20)
		cb:setTitleText(CHANNEL[i])
		cb:setTitleArea("5,0,0,0")
		ui.combo:getList():addItem(cb)
	end
	ui.channels = {}
	for i=1,6 do
		ui.channels[i] = tt(ui:findComponent("正常,复选框_"..i),F3DCheckBox)
		ui.channels[i]:addEventListener(F3DUIEvent.CHANGE, func_ue(function(e)
			m_channel = math.min(6,i-1)
			ui.combo:setTitleText(CHANNEL[math.max(1,m_channel)])
			ui.list:removeAllItems()
			update()
		end))
	end
	F3DTouchProcessor:instance():addEventListener(F3DKeyboardEvent.KEY_DOWN, func_ke(onKeyDown))
	
	ui.隐藏 = ui:findComponent("正常,隐藏")
	ui.隐藏:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		ui.正常:setVisible(false)
		ui.展开:setVisible(true)
	end))
	
	ui.展开 = ui:findComponent("展开")
	ui.展开:setVisible(false)
	ui.展开:addEventListener(F3DMouseEvent.CLICK, func_me(function (e)
		ui.展开:setVisible(false)
		ui.正常:setVisible(true)
	end))
	
	m_init = true
	checkResize()
	update()
end

function checkResize()
	if not ui or not 主界面UI.ui then return end
	if not g_mobileMode and ISMIRUI then return end
	if g_mobileMode then
		--ui:setPositionY(stage:getHeight()-220-ui:getHeight())
	elseif ui:getPositionX()+ui:getWidth()>主界面UI.ui:getPositionX() and ui:getPositionY()+ui:getHeight()>主界面UI.ui:getPositionY()-50 then
		ui:setPositionY(主界面UI.ui:getPositionY()-50-ui:getHeight())
	end
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if ui then
		ui:setVisible(false)
	end
end

function toggle()
	if isHided() then
		initUI()
	else
		hideUI()
	end
end

function initUI()
	if ui then
		--uiLayer:removeChild(ui)
		--uiLayer:addChild(ui)
		ui:updateParent()
		ui:setVisible(true)
		checkResize()
		return
	end
	ui = F3DLayout:new()
	uiLayer:addChild(ui)
	ui:setLoadPriority(getUIPriority())
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(g_mobileMode and UIPATH.."聊天UIm.layout" or ISMIRUI and UIPATH.."聊天UI.layout" or UIPATH.."聊天UIs.layout")
end
