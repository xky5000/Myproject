module(..., package.seeall)


function GetDB(roleName)
	if Config.ISGAMESVR then
		return g_oMongoDB
	else 
		local i, j = string.find(roleName, "]")
		if i ~= nil then
			local svrName = string.sub(roleName, 1, i)
			local db = g_oMongoDBs[svrName]
			assert(db)
			return db
		end
		assert(false)
		return nil
	end
end



function InitDBIndex()
  if not Config.ISGAMESVR then
    return
  end

  --建 立索引， 最后以一参数为1时，表示唯一，为nil时不唯一
  _EnsureIndex(g_oMongoDB,"char","{name:1}", 1)
  _EnsureIndex(g_oMongoDB,"char","{account:1}")
  _EnsureIndex(g_oMongoDB,"char","{lv:1}")
end