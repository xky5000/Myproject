module(..., package.seeall)

local 全局设置 = require("公用.全局设置")
local 消息 = require("网络.消息")

m_init = false
m_winteam = 0
m_teaminfo = nil
m_score1 = 0
m_score2 = 0

function setScoreNumber(score, scorenumber, width)
	local clips = F3DPointVector:new()
	clips:clear()
	if score == 0 then
		clips:push(0, -clips:size()*width)
	else
		while score >= 1 do
			clips:push(math.floor(score%10), -clips:size()*width)
			score = score / 10
		end
	end
	scorenumber:setBatchClips(10, clips)
	scorenumber:setOffset(-width+clips:size()*width/2, 0)
	scorenumber:setVisible(true)
end

function update()
	if not m_init or not m_teaminfo then
		return
	end
	setScoreNumber(m_score1, ui.scorenumber_1, 35)
	setScoreNumber(m_score2, ui.scorenumber_2, 35)
	ui.win:setVisible(m_winteam == g_role.teamid)
	ui.fail:setVisible(m_winteam == -1 or (m_winteam ~= 0 and m_winteam ~= g_role.teamid))
	ui.draw:setVisible(m_winteam == 0)
	local index = 0
	local space = 0
	local teamid = 0
	for i,v in ipairs(m_teaminfo) do
		if teamid == 0 then
			teamid = v[8]
		elseif teamid ~= 0 and teamid ~= v[8] then
			teamid = v[8]
			for ii=i,5 do
				ui.wanjia[ii]:setVisible(false)
			end
			space = 6-i
		end
		if i <= 10 then
			ui.wanjia[i+space].ziji:setVisible(v[1]==g_role.objid)
			ui.wanjia[i+space].head:setBackground(全局设置.getHeadIconUrl(v[4]))
			ui.wanjia[i+space].mingzi:setTitleText(txt(v[2]))
			ui.wanjia[i+space].dengji:setTitleText(txt(v[3].."级"))
			ui.wanjia[i+space].jisha:setTitleText(v[5])
			ui.wanjia[i+space].siwang:setTitleText(v[6])
			ui.wanjia[i+space].score:setTitleText(v[7])
			ui.wanjia[i+space].mvp:setVisible(v[9]==1)
			ui.wanjia[i+space]:setVisible(true)
			index = i+space
		end
	end
	for i=index+1,10 do
		ui.wanjia[i]:setVisible(false)
	end
end

function onQuit(e)
	ui:setVisible(false)
	ui.quit:releaseMouse()
	e:stopPropagation()
	消息.CG_QUIT_COPYSCENE()
end

function onMouseDown(e)
	uiLayer:removeChild(ui)
	uiLayer:addChild(ui)
	e:stopPropagation()
end

function onZhezhaoDown(e)
	e:stopPropagation()
end

function onUIInit()
	ui.zhezhao = ui:findComponent("zhezhao")
	ui.zhezhao:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onZhezhaoDown))
	ui.quit = ui:findComponent("zhong,quit")
	ui.quit:addEventListener(F3DMouseEvent.CLICK, func_me(onQuit))
	ui:addEventListener(F3DMouseEvent.MOUSE_DOWN, func_me(onMouseDown))
	ui.win = ui:findComponent("zhong,win")
	ui.fail = ui:findComponent("zhong,fail")
	ui.draw = ui:findComponent("zhong,draw")
	ui.score_1 = ui:findComponent("zhong,score_1")
	ui.score_1:setVisible(false)
	ui.scorenumber_1 = F3DImage:new()
	ui.scorenumber_1:setTextureFile(UIPATH.."结算/Bluenumber.png")
	ui.scorenumber_1:setWidth(35)
	ui.scorenumber_1:setPositionX(ui.score_1:getPositionX()+18)
	ui.scorenumber_1:setPositionY(ui.score_1:getPositionY())
	ui:findComponent("zhong"):addChild(ui.scorenumber_1)
	ui.score_2 = ui:findComponent("zhong,score_2")
	ui.score_2:setVisible(false)
	ui.scorenumber_2 = F3DImage:new()
	ui.scorenumber_2:setTextureFile(UIPATH.."结算/Rednumber.png")
	ui.scorenumber_2:setWidth(35)
	ui.scorenumber_2:setPositionX(ui.score_2:getPositionX()+18)
	ui.scorenumber_2:setPositionY(ui.score_2:getPositionY())
	ui:findComponent("zhong"):addChild(ui.scorenumber_2)
	ui.wanjia = {}
	for i=1,10 do
		ui.wanjia[i] = ui:findComponent("zhong,wanjia_"..i)
		ui.wanjia[i]:setVisible(false)
		ui.wanjia[i].ziji = ui:findComponent("zhong,wanjia_"..i..",ziji")
		ui.wanjia[i].head = ui:findComponent("zhong,wanjia_"..i..",head")
		ui.wanjia[i].mingzi = ui:findComponent("zhong,wanjia_"..i..",mingzi")
		ui.wanjia[i].dengji = ui:findComponent("zhong,wanjia_"..i..",dengji")
		ui.wanjia[i].jisha = ui:findComponent("zhong,wanjia_"..i..",jisha")
		ui.wanjia[i].siwang = ui:findComponent("zhong,wanjia_"..i..",siwang")
		ui.wanjia[i].score = ui:findComponent("zhong,wanjia_"..i..",score")
		ui.wanjia[i].mvp = ui:findComponent("zhong,wanjia_"..i..",mvp")
		ui.wanjia[i].mvp:setVisible(false)
	end
	m_init = true
	update()
end

function isHided()
	return not ui or not ui:isVisible()
end

function hideUI()
	if ui then
		ui:setVisible(false)
	end
end

function initUI()
	if ui then
		uiLayer:removeChild(ui)
		uiLayer:addChild(ui)
		ui:updateParent()
		ui:setVisible(true)
		return
	end
	ui = F3DLayout:new()
	uiLayer:addChild(ui)
	ui:setLoadPriority(getUIPriority())
	ui:addEventListener(F3DObjEvent.OBJ_INITED, func_e(onUIInit))
	ui:setLayout(UIPATH.."结算UI2.layout")
end
