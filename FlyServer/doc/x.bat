set ConfigPath=..\..\FlyServer\scripts\配置
set ClientConfigPath=..\..\Flying3D\scripts\配置
for %%a in (
	地图
	怪物
	刷新
	技能
	技能信息
	Npc
	任务
	物品
	玩家属性
	Buff
	宠物
	名字
	商城
	物品内观
	充值礼包
	活动奖励
	福利抽奖
	套装
	物品使用
)do (
unzip -j -o "%%a.xlsx" xl\sharedStrings.xml xl\workbook.xml xl\worksheets\sheet*.xml
myxml "%ConfigPath%/%%~na表.lua"
)
for %%a in (
	地图
	刷新
	名字
	商城
	物品内观
	充值礼包
	活动奖励
	福利抽奖
	物品使用
)do (
copy %ConfigPath%\%%~na表.lua %ClientConfigPath%\%%~na表.lua
)
del *.xml
