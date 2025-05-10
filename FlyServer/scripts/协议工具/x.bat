set serverPath=..\..\..\FlyServer\scripts
set clientPath=..\..\..\Flying3D\scripts\网络

::TortoiseProc.exe /command:update /path:"%serverPath%\common\PacketID.lua" /closeonend:2
::TortoiseProc.exe /command:update /path:"%clientPath%\" /closeonend:2

SET names=协议,场景,玩家,怪物,技能,物品,宠物,锻造,聊天,副本,排行榜,寄售,队伍,行会

call :ServerToClient 玩家 场景
call :ServerToClient 怪物 场景
call :ServerToClient 技能 技能
call :ServerToClient 物品 物品
call :ServerToClient 宠物 宠物
call :ServerToClient 锻造 锻造
call :ServerToClient 聊天 聊天
call :ServerToClient 副本 场景
call :ServerToClient 排行榜 排行榜
call :ServerToClient 寄售 寄售
call :ServerToClient 队伍 队伍
call :ServerToClient 行会 行会

消息生成.lua
copy Message.lua %clientPath%\消息.lua
copy %serverPath%\公用\协议ID.lua PacketID.lua
消息类型生成.lua PacketID %clientPath%\消息类型.lua
del Message.lua
del CGMethod.lua
del PacketID.lua

rem TortoiseProc.exe /command:commit /path:"%serverPath%\common\PacketID.lua" /logmsg:"【开发】服务器协议id更新" /closeonend:2
rem TortoiseProc.exe /command:add /path:"%clientPath%\" /logmsg:"【开发】客户端协议更新" /closeonend:2
rem TortoiseProc.exe /command:commit /path:"%clientPath%\" /logmsg:"【开发】客户端协议更新" /closeonend:2

exit/b

:ServerToClient
	协议生成.lua %serverPath%\模块\?.lua %1 %2 %names% "消息处理.lua"
	消息处理合并.lua %clientPath%\消息处理\%2消息处理.lua %2消息处理.lua %clientPath%\消息处理\%2消息处理.lua
	del %2消息处理.lua
exit/b
