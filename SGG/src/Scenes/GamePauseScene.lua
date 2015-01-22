require "Cocos2d"
require "GameDirectorUtils"
require "GameBattleUtils.lua"
require "Data_Level"
require "Data_Monster"
require "Manager"
require "MessageDispatchCenter"
require "LayerManager"
require "AttackCommand"

gameScene=nil
curGroup=nil
local sp
local open=1
local GamePauseScene = class("GamePauseScene",function()
    return cc.Scene:createWithPhysics()
end)
function GamePauseScene:createBackground()
    local background=returnLevelTable(DirectorUtils.getCurSceneLevel()).backgroundJpg
    local back=cc.Sprite:create(background.jpg)
    back:setPosition(DirectorUtils.getWinWidth()/2,DirectorUtils.getWinHeight()/2)
    self:addChild(back,-1)
end


PauselayerEnum={
    touchLayerTag=1,
    rubberLayerTag=2,
    cannonLayerTag=3,
    monLayerTag=4,
    neutralTag=5,
    bossMonsterTag=6,
    setingLayerTag=10,
    gameUserData=7,
    edgeBoxTag=100,
}

local open=1

function GamePauseScene:initBattleData(level) 

    
    local weaponDatam=returnLevelTable(level).remotemonster
    local monsterDatam=returnLevelTable(level).monster;

    local enemies=#weaponDatam+#monsterDatam
    print("self._totalEnemies==",self._totalEnemies)

    self._totalEnemies=enemies
end

function GamePauseScene:createGameLayer()

    local pworld=self:getPhysicsWorld()
   -- pworld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
    --触摸层
    local touchLayer=require("PauseTouchLayer")
    local tLayer=touchLayer:create();
    self:addChild(tLayer,0,PauselayerEnum.touchLayerTag)
    --挡板层
    local PauseRubberLayer=require("PauseRubberLayer")
    rLayer=PauseRubberLayer:create();
    self:addChild(rLayer,0,PauselayerEnum.rubberLayerTag)

    --怪物层
    local currentLayer=require("GameCurrentLayer")
    gameCurrentLayer = currentLayer:create()
    gameCurrentLayer:setCascadeColorEnabled(true)
    self:addChild(gameCurrentLayer)

    --近战怪物层
    --    if #(returnLevelTable(level).monster)>0 then
    --        local MonsterManagerLayer=require("MonsterManagerLayer")
    --       local MonsterManagerLayer=require("MonsterManagerLayerPause")
    --        mLayer=MonsterManagerLayer:create();
    --        self:addChild(mLayer,0,layerEnum.monLayerTag)
    --    end

    --中立怪物层
    --    if #(returnLevelTable(level).neutralMonster)>0 then
    --        local neutralLayer=require("NeutralLayer")
    --        nLayer=neutralLayer:create();
    --        self:addChild(nLayer,0,layerEnum.neutralTag)
    --    end
    --远程炮弹层
    --    if #(returnLevelTable(level).remotemonster)>0 then
    --    local cannonLayer=require("CannonLayer")
    --    wLayer=cannonLayer:create();
    --    self:addChild(wLayer,0,layerEnum.cannonLayerTag)
    --    end

    --    self:addBossMonsterLayer();

    --玩家数据层 道具
    local GameUserDataLayerPause=require("GameUserDataLayerPause")
    gameUserDataLayer=GameUserDataLayerPause:create();
    self:addChild(gameUserDataLayer,0,PauselayerEnum.gameUserData)  
end

function GamePauseScene:createPhysicsContact()

    local function onContactBegin(contact)
        local spriteA,spriteB=BattleUtils.getCollisionSprite(contact)
        if (spriteA~=nil and spriteB~=nil) then

            local gA,gB=BattleUtils.getCollisionGroup(spriteA,spriteB)
            --            print("ga,gb======",gA,gB)
            --子弹碰到挡板
            if (BattleUtils.BulletCollisionScratchPause(spriteA,spriteB,gA,gB)) then
                return true
                    --子弹碰到农田  
            elseif (BattleUtils.BulletCollisionfarmland(spriteA,spriteB,gA,gB)) then
                return false    
                    --子弹碰到怪物       
            elseif (BattleUtils.BulletCollisionEnemyPause(spriteA,spriteB,gA,gB)) then  
                --                print("－－－－－－－BulletCollisionEnemy－－－－－－－－")
                return false
            elseif (BattleUtils.BulletInOfBounds(spriteA,spriteB,gA,gB)) then
                return true
            end
            return false
        end
        return false;
    end

    local function onContactPreSolve(contact,solve) 
        return true;
    end

    local function onContactPostSolve(contact,solve) 
    end

    local function onContactSeperate(contact)
        local spriteA,spriteB=BattleUtils.getCollisionSprite(contact)
        if (spriteA~=nil and spriteB~=nil) then
            local gA,gB=BattleUtils.getCollisionGroup(spriteA,spriteB) 
            --子弹出边框 
            if (BattleUtils.BulletOutOfBoundsPause(spriteA,spriteB,gA,gB)) then

            --子弹和挡板反弹
            elseif (BattleUtils.BulletOutOfScratchPause(spriteA,spriteB,gA,gB)) then

            end
        end
    end


    local contactListener=cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(onContactBegin,cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    contactListener:registerScriptHandler(onContactPreSolve,cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE)
    contactListener:registerScriptHandler(onContactPostSolve,cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE)
    contactListener:registerScriptHandler(onContactSeperate,cc.Handler.EVENT_PHYSICS_CONTACT_SEPERATE)
    local eventDispatcher=self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener,self)
end

function GamePauseScene:createPhysicsEageBox()
    local edgeSpace=cc.Sprite:create()
    local boundBoy=cc.PhysicsBody:createEdgeBox(cc.size(DirectorUtils.getWinSize().width,DirectorUtils.getWinSize().height))
    --位于碰撞第三组
    boundBoy:getShape(0):setGroup(BattleGroup.BoundBoyGroup)
    --摩擦力
    boundBoy:getShape(0):setFriction(0.0)
    --恢复力
    --  boundBoy:getShape(0):setRestitution(1.0)
    boundBoy:setCategoryBitmask(0x0011)
    boundBoy:setCollisionBitmask(0x0011)
    boundBoy:setContactTestBitmask(0X0011)
    edgeSpace:setPhysicsBody(boundBoy)
    edgeSpace:setPosition(DirectorUtils.getWinWidth()*0.5,DirectorUtils.getWinHeight()*0.5)
    self:addChild(edgeSpace)
    edgeSpace:setTag(PauselayerEnum.edgeBoxTag)

end



function GamePauseScene:setRubberBeginPoint(bp)
    --if pauseMonstert==true then
        local rLayer=self:getChildByTag(PauselayerEnum.rubberLayerTag)
        rLayer:setBeginPoint(bp)
   -- end
end                                     

function GamePauseScene:setRubberEndPoint(ep)
    -- if pauseMonster==true then 
        local rLayer=self:getChildByTag(PauselayerEnum.rubberLayerTag)
        rLayer:setEndPoint(ep)
   --  end
end

function GamePauseScene:setRubberMovePoint(mp)
   --  if pauseMonstert==true then
        local rLayer=self:getChildByTag(PauselayerEnum.rubberLayerTag)
        rLayer:setMovePoint(mp)
   --  end
end
function GamePauseScene:pausegameOver()
--    if open==1 then
--        if isWin then
--            --过关成功
--            MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._WINEFFECT_);
--            local curlevel=DirectorUtils.getCurLevel();
--            curlevel=curlevel+1
--            if curlevel>3 then
--                curlevel=1
--            end
--            --保存过关评分数据
--            UserData:GetInstance():setSceneLevelGetPlants(UserData:GetInstance():getCurScene(),
--                UserData:GetInstance():getCurLevel(),gameScene._plantsHp)
--
--            local plantsDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).plants
--            local maxplantsHp=plantsDatam.hp
--            UserData:setSceneLevelMaxPlants(UserData:GetInstance():getCurScene(),
--                UserData:GetInstance():getCurLevel(),maxplantsHp)
--
--            cc.UserDefault:getInstance():setBoolForKey("ispass",true)
--        else
--            --过关失败
--            MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._LOSTEFFECT_);
--            cc.UserDefault:getInstance():setBoolForKey("ispass",false) 
--        end
--        local curtype=returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
--        UserData:setGameSceneType(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel(),curtype)
--        cc.UserDefault:getInstance():flush()
--        gameScene:overClearScene();
--        open=2
--    end
    cc.SimpleAudioEngine:getInstance():stopMusic()
    local gold=gameUserDataLayer:GameOverjudge()
    if gold >0.5 then
        cc.UserDefault:getInstance():setBoolForKey("ispass",true)
        local curtype=returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
        UserData:setGameSceneType(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel(),curtype)
        
    else
        cc.UserDefault:getInstance():setBoolForKey("ispass",false)
        local curtype=returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
        UserData:setGameSceneType(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel(),curtype)
    end
    cc.UserDefault:getInstance():flush()
    gameScene:removeALLData()
    
    gameScene:overClearScene();    
    GameUIManager:openGameOverLayer()
end

function GamePauseScene:overClearScene()
    --删除内存 缓存
    --self:removeBattleData()
--    self:removeCacheInt()
    --打开结束界面
    --GameUIManager:openGameOverLayer()
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
    List.removeAll(MonsterManager)
    --List.pushlast(MonsterManager, monster)
end

--删除层对象 计时器
function GamePauseScene:removeBattleData() 
    gameMaster:removeBattleData()
end


--增加游戏怪物对象 
function GamePauseScene:initMonsterData() 
    local level=DirectorUtils.getCurSceneLevel()


    --远程炮弹层
    if #(returnLevelTable(level).remotemonster)>0 then
        local weaponDatam={}
        copyTable(returnLevelTable(level).remotemonster,weaponDatam)
        --        if #weaponDatam>1 then
        --            table.sort(weaponDatam,tableSortRefreshTme)
        --        end
        gameMaster:addWeapon(weaponDatam)
    end

    --近战怪物层
    if #(returnLevelTable(level).monster)>0 then
        local monsterDatam={}
        copyTable(returnLevelTable(level).monster,monsterDatam)
        --        if #monsterDatam>1 then
        --            table.sort(monsterDatam,tableSortRefreshTme)
        --        end
        gameMaster:addMonster(monsterDatam)
    end

    --中立怪物层
    --    if #(returnLevelTable(level).neutralMonster)>0 then
    --        local neutralDatam={}
    --        copyTable(returnLevelTable(level).neutralMonster,neutralDatam)
    --        if #neutralDatam>1 then
    --            table.sort(neutralDatam,tableSortRefreshTme)
    --        end
    --        gameMaster:addNeutral(neutralDatam)
    --    end

    local function isBossType(type) 
        if type==GameType.Game_Type_boss_1 or
            type==GameType.Game_Type_boss_2 or
            type==GameType.Game_Type_boss_3 or
            type==GameType.Game_Type_boss_4 then

            return true
        end

        return false
    end
    if isBossType(returnLevelTable(level).gametype) then
        gameMaster:addGameboss(returnLevelTable(level).gametype)
    end

end
--击中怪物增加集中率
function GamePauseScene:addHitMonster(i)
    gameUserDataLayer:setcurHitRate(i)
end

--处理游戏逻辑
local function PausegameController(dt)

    gameMaster:update(dt)

    collisionDetect(dt)
    solveAttacks(dt)
    --    moveCamera(dt)
end
local function GameBulletContriller(dt)
--    if List.getSize(BullettPool)==0 then
--       if curGroup>=#returnLevelTable(DirectorUtils.getCurSceneLevel()).pauseTime then 
--            pausegameOver()
--       end
--    end
end
--暂停场景
function GamePauseScene:pauseAll()
       gameCurrentLayer:PauseMonster()
       gameScene:pause()
       if gameScene.gameControllerScheduleID then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameScene.gameControllerScheduleID)
            gameScene.gameControllerScheduleID=nil
       end
       
       gameUserDataLayer.schedulerProID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(PauseProgressUpdate,0.01,false)
end

function GamePauseScene:SettingLayerPauseAll()
    gameCurrentLayer:PauseMonster()
    gameScene:pause()
    if gameScene.gameControllerScheduleID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameScene.gameControllerScheduleID)
        gameScene.gameControllerScheduleID=nil
    end
    
    
    if gameUserDataLayer.schedulerProID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameUserDataLayer.schedulerProID)
        gameUserDataLayer.schedulerProID=nil
    end
    if gameMaster.ShootingPauseID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameMaster.ShootingPauseID)
        gameMaster.ShootingPauseID=nil
        --pauseUpdate=true
    end
--    if  pauseUpdate ==false then
--        gameMaster.ShootingPauseID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(ShootingPause,0.01,false)
--        isNext=true
--        pauseUpdate=true
--    end
    
end


function GamePauseScene:SettingLayerResumeScene()
     
	 
	 if pauseMonster==false then
        gameCurrentLayer:resumeMonster()
        gameScene:resume()
	 end
	 
    if pauseMonster ==true then
        if isPauseEnd ==false then
            gameScene.gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(PausegameController, 0, false)
            gameUserDataLayer.schedulerProID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(PauseProgressUpdate,0.01,false)
        end


    end
    if isPauseEnd==false then
        if pauseMonster ==false then
            if isNext==true and pauseUpdate then
                gameMaster.ShootingPauseID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(ShootingPause,0.01,false)
            end
           
            
        end

    end
     
    if gameScene.gameControllerScheduleID==nil then
        gameScene.gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(PausegameController, 0, false)
    end
end
--恢复暂停场景
function GamePauseScene:resumeScene()
    
    gameCurrentLayer:resumeMonster()
    gameScene:resume()
    --gameScene.gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(PausegameController, 0.1, false)
    if gameScene.gameControllerScheduleID==nil then
        gameScene.gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(PausegameController, 0, false)
    end
    
end
--重置板的使用次数
function GamePauseScene:resetGroupBulletNumber()
    --bulletNumber=returnLevelTable(DirectorUtils.getCurSceneLevel()).pauseTime[curGroup]
    bulletNumber=returnLevelTable(DirectorUtils.getCurSceneLevel()).pauseScratchNum[curGroup]
    isOver=true
end

--重新开始前的删除数据

function GamePauseScene:removeALLData()
	self:resetGroupBulletNumber()
    --cc.Director:getInstance():getScheduler():unscheduleScriptFunc(gameScene.gameControllerScheduleID)
    showAllMonster=false
    gameMaster:resetPauseUpdateBool()
end
--重置板子滑动
function GamePauseScene:resetScratchLayer()
    rLayer:removeFromParent()
    rLayer=nil
    
    local RubberLayer=require("PauseRubberLayer")
    rLayer=RubberLayer:create();
    self:addChild(rLayer,0,PauselayerEnum.rubberLayerTag)
    gameScene.gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(PausegameController, 0, false)
    showAllMonster=false
    pauseMonster=false
    isPauseEnd=false
    gameMaster:resetPauseUpdateBool()
end
function GamePauseScene.create()
    gameScene = GamePauseScene.new()
    open=1
    curGroup=1
    gameScene:initBattleData(DirectorUtils.getCurSceneLevel())
    gameScene:createBackground()
    gameScene:createPhysicsContact()
    gameScene:createPhysicsEageBox()
    gameScene:createGameLayer()
    gameScene:resetGroupBulletNumber()
    gameMaster = require("GameMasterPause").create()
    --增加怪物
    gameScene:initMonsterData()

    --处理游戏逻辑 计时器
    gameScene.gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(PausegameController, 0, false)
    --cc.SimpleAudioEngine:getInstance():playBackgroundMusic("bgm.mp3",true)
    --MessageDispatchCenter:getInstance():registerMessage(MessageDispatchCenter.MessageType.GAME_OVER, pausegameOver)
    


    return gameScene
end

function GamePauseScene:settingmenu()
    self:SettingLayerPauseAll()
    local setLayer=require"GameSettingLayer"
    local setingLayer = setLayer.create()
    self:addChild(setingLayer,11,PauselayerEnum.setingLayerTag)
end

function GamePauseScene:closeSeting()
    self:SettingLayerResumeScene()
    if self:getChildByTag(PauselayerEnum.setingLayerTag) then
        self:removeChildByTag(PauselayerEnum.setingLayerTag)
    end
end
function GamePauseScene:resetPauseUpdateBool()
    pauseUpdate=false
    --这个是暂停才能化板子

end

return GamePauseScene
