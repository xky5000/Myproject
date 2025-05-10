function Hot()
	for k, v in pairs(package.loaded) do
		package.loaded[k] = nil
	end
	require("Main")
	collectgarbage("collect")
	print(collectgarbage("count"))
	--Renew("玩家.玩家对象类")
	--Renew("聊天.事件处理")
	日志.WriteLog(日志.LOGID_MONITOR, "Server Renewed......")
end 
Hot()
