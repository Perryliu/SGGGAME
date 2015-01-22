
require "GameDirectorUtils"

--游戏层
gameCurrentLayer=nil

--游戏逻辑管理
gameMaster=nil

--用户数据层
gameUserDataLayer=nil
--挡板
rLayer=nil

--boss
bLayer=nil

--新手教程
beginnerGuide=nil

LayerManager={}

gameControllerScheduleID=nil

--显示所有怪物
showAllMonster=false
--暂停
pauseMonster=false
isPauseEnd=false
isOver=true

isNext=false
pauseUpdate=false
pauseTime=0
ProgressTime=0
--条件
gameCondition=nil
gameJudge=nil

--光源
LightSpriteManager = List.new()
LightModeBullet=List.new()