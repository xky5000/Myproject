module(..., package.seeall)

RankInfo = {
  { "rank", "SHORT", 1 },
  { "name", "CHAR", 2 },
  { "job", "CHAR", 1 },
  { "level", "SHORT", 1 },
  { "guild", "CHAR", 2 },
  { "power", "INT", 1 },
}

CG_RANK_QUERY = {
}

GC_RANK_LIST = {
  { "info", RankInfo, 50 },
  { "myinfo", RankInfo, 2 },
}

CG_RANK_HERO_QUERY = {
}

GC_RANK_HERO_LIST = {
  { "info", RankInfo, 50 },
  { "myinfo", RankInfo, 2 },
}

PetRankInfo = {
  { "rank", "SHORT", 1 },
  { "name", "CHAR", 2 },
  { "starlevel", "SHORT", 1 },
  { "level", "SHORT", 1 },
  { "belong", "CHAR", 2 },
  { "power", "INT", 1 },
}

CG_RANK_PET_QUERY = {
}

GC_RANK_PET_LIST = {
  { "info", PetRankInfo, 50 },
  { "myinfo", PetRankInfo, 2 },
}

VIPSpreadRankInfo = {
  { "rank", "SHORT", 1 },
  { "name", "CHAR", 2 },
  { "job", "CHAR", 1 },
  { "num", "SHORT", 1 },
  { "validnum", "SHORT", 1 },
  { "growexp", "INT", 1 },
}

CG_RANK_VIPSPREAD_QUERY = {
}

GC_RANK_VIPSPREAD_LIST = {
  { "info", VIPSpreadRankInfo, 50 },
  { "myinfo", VIPSpreadRankInfo, 2 },
}
