require "Cocos2d"
require "GameDirectorUtils"
require "GameBattleUtils.lua"
require "Data_Level"
require "Data_Monster"
require "Manager"
require "MessageDispatchCenter"
require "LayerManager"
require "AttackCommand"
require "GuideConfigInfo"


gameScene=nil
gameControllerScheduleID=nil
local BeginnersId=nil

local GameScene = class("GameScene",function()
    return cc.Scene:createWithPhysics()
end)

layerEnum={
   touchLayerTag=1,
   rubberLayerTag=1000,
   cannonLayerTag=3,
   monLayerTag=4,
   neutralTag=5,
   bossMonsterTag=6,
   
   gameUserData=7,
   
   setingLayerTag=8,
   edgeBoxTag=100,
}

local open=1

function GameScene:createGameLayer()
    
   local pworld=self:getPhysicsWorld()
  -- pworld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
    --触摸层
    local touchLayer=require("TouchLayer")
    local tLayer=touchLayer:create();
    self:addChild(tLayer,0,layerEnum.touchLayerTag)
    --挡板层
    local rubberLayer=require("RubberLayer")
    rLayer=rubberLayer:create();
    self:addChild(rLayer,0,layerEnum.rubberLayerTag)
    
    --怪物层
    local currentLayer=require("GameCurrentLayer")
    gameCurrentLayer = currentLayer:create()
    gameCurrentLayer:setCascadeColorEnabled(true)
    self:addChild(gameCurrentLayer)
       
    --玩家数据层 道具
    local gudl= gameUserDataLayer
    local userDataLayer=require("GameUserDataLayer")
    gameUserDataLayer=userDataLayer:create();
    self:addChild(gameUserDataLayer,0,layerEnum.gameUserData)  
    
    
    local night=require("NightLayer")
    nightlayer=night:create()
    self:addChild(nightlayer,2,100)
    local pointone = cc.p(320,0)
    local pointtwo = cc.p(200,700)
    local pointtable={pointone,pointtwo}
    for var =1 ,1 do 
        local lightone = require("LightSprite")
        lightone=lightone.create(8)
        lightone:InitTexture(pointtable[var])
        List.pushlast(LightSpriteManager,lightone)
    end
    
end

function GameScene:createPhysicsContact()
    
    local function onContactBegin(contact)
        local spriteA,spriteB=BattleUtils.getCollisionSprite(contact)
        if (spriteA~=nil and spriteB~=nil) then
        
            local gA,gB=BattleUtils.getCollisionGroup(spriteA,spriteB)
--            print("ga,gb======",gA,gB)
            --子弹碰到挡板
            if (BattleUtils.BulletCollisionScratch(spriteA,spriteB,gA,gB)) then
                return true
            --子弹碰到农田  
            elseif (BattleUtils.BulletCollisionfarmland(spriteA,spriteB,gA,gB)) then
                return false    
            --子弹碰到子弹
            elseif (gA==BattleGroup.BulletGroup and gB==BattleGroup.BulletGroup) or(gA==BattleGroup.BulletReboundGroup  and gB==BattleGroup.BulletReboundGroup) then
                return false
            --子弹碰到怪物       
            elseif (BattleUtils.BulletCollisionEnemy(spriteA,spriteB,gA,gB)) then  
--                print("－－－－－－－BulletCollisionEnemy－－－－－－－－")
                return false
            end
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
            if (BattleUtils.BulletOutOfBounds(spriteA,spriteB,gA,gB)) then
        
            --子弹和挡板反弹
            elseif (BattleUtils.BulletOutOfScratch(spriteA,spriteB,gA,gB)) then
                                      
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

function GameScene:createPhysicsEageBox()
	local edgeSpace=cc.Sprite:create()
	local boundBoy=cc.PhysicsBody:createEdgeBox(DirectorUtils.getWinSize())
	--位于碰撞第三组
    boundBoy:getShape(0):setGroup(BattleGroup.BoundBoyGroup)
	--摩擦力
	boundBoy:getShape(0):setFriction(0.0)
	--恢复力
--	boundBoy:getShape(0):setRestitution(1.0)
	boundBoy:setCategoryBitmask(0x0011)
	boundBoy:setCollisionBitmask(0x0011)
	boundBoy:setContactTestBitmask(0X0011)
	edgeSpace:setPhysicsBody(boundBoy)
	edgeSpace:setPosition(DirectorUtils.getWinWidth()*0.5,DirectorUtils.getWinHeight()*0.5)
	self:addChild(edgeSpace)
    edgeSpace:setTag(layerEnum.edgeBoxTag)
	
end

function GameScene:createBackground()
--    local background=returnLevelTable(DirectorUtils.getCurSceneLevel()).backgroundJpg
    local back=require("GameBGLayer").create()
    self:addChild(back,-10)
    
    local trends=require("GameTrendsLayer").create()
    self:addChild(trends,10)
end

-- ／／／／／／／／／／／／／／／／／／设置挡板／／／／／／／／／／／／／／／／／／／
function GameScene:setRubberBeginPoint(bp)
    local rLayer=self:getChildByTag(layerEnum.rubberLayerTag)
    rLayer:setBeginPoint(bp)
    
end

function GameScene:setRubberEndPoint(ep) 
    local rLayer=self:getChildByTag(layerEnum.rubberLayerTag)
    rLayer:setEndPoint(ep)
end

function GameScene:setRubberMovePoint(mp)
    local rLayer=self:getChildByTag(layerEnum.rubberLayerTag)
    rLayer:setMovePoint(mp)
end
-- ／／／／／／／／／／／／／／／／／／设置挡板／／／／／／／／／／／／／／／／／／／

local function gameOver(isWin)
    
    cc.SimpleAudioEngine:getInstance():stopMusic()
    --新手指引
    if isBeginnersTask(BeginnersId) then
        beginnerGuide:closeGuide()
        setBeginnersTask()
        gameScene:overClearScene();
        GameUIManager:exitBattleScene()
        return
    end

    if open==1 then
        if isWin then
            --过关成功
            MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._WINEFFECT_);
            local curlevel=DirectorUtils.getCurLevel();
            curlevel=curlevel+1
            --保存过关评分数据
            UserData:GetInstance():setSceneLevelGetPlants(UserData:GetInstance():getCurScene(),
                UserData:GetInstance():getCurLevel(),gameUserDataLayer.plantsHp)
            
            local plantsDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).plants
            local maxplantsHp=plantsDatam.hp
            UserData:setSceneLevelMaxPlants(UserData:GetInstance():getCurScene(),
                UserData:GetInstance():getCurLevel(),maxplantsHp)
                
            cc.UserDefault:getInstance():setBoolForKey("ispass",true)
        else
            --过关失败
            MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._LOSTEFFECT_);
            cc.UserDefault:getInstance():setBoolForKey("ispass",false) 
        end
        gameJudge:DisposeCondition()
        local curtype=returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
        UserData:setGameSceneType(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel(),curtype)
        cc.UserDefault:getInstance():flush()
        gameScene:overClearScene();
        GameUIManager:openGameOverLayer()  
        open=2
    end
end

function GameScene:overClearScene()
    --删除内存 缓存
    self:removeBattleData()
    self:pauseAll()
end

--删除层对象 计时器
function GameScene:removeBattleData()
    if gameControllerScheduleID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameControllerScheduleID)
    end
    
    if farmland then
        if farmland:getPhysicsBody() then
            farmland:getPhysicsBody():removeFromWorld();
        end 	
    end
         
    gameMaster:removeBattleData()
end


--新手指引
function GameScene:addBeginnerGuide()
    BeginnersId=getBeginnersTask()    
    if type(BeginnersId)=="string" then
        local data=getConfigInfo(BeginnersId)
        beginnerGuide=require("BeginnerGuide").create(data)
        beginnerGuide:setVisible(false)
        beginnerGuide.guideId=BeginnersId
        beginnerGuide:scheduleGuide()
        self:addChild(beginnerGuide)
    end

end

--按刷新时间排序怪物
local function tableSortRefreshTme(a,b)
    return a.refreshtime<b.refreshtime
end

--增加游戏怪物对象 
function GameScene:initMonsterData() 

    --新手引导
    if isBeginnersTask(BeginnersId) then
            --远程怪物层
        if #(returnLevelTable("1001").remotemonster)>0 then
            local weaponDatam={}
            copyTable(returnLevelTable("1001").remotemonster,weaponDatam)
            if #weaponDatam>1 then
                table.sort(weaponDatam,tableSortRefreshTme)
            end
            gameMaster:addWeapon(weaponDatam)
        end
        return 
    end


    local level=DirectorUtils.getCurSceneLevel()
    --远程怪物层
    if #(returnLevelTable(level).remotemonster)>0 then
        local weaponDatam={}
        copyTable(returnLevelTable(level).remotemonster,weaponDatam)
        if #weaponDatam>1 then
            table.sort(weaponDatam,tableSortRefreshTme)
        end
        gameMaster:addWeapon(weaponDatam)
    end
    
    --远程炮弹层
    if #(returnLevelTable(level).battery)>0 then
        local batteryDatam={}
        copyTable(returnLevelTable(level).battery,batteryDatam)
        if #batteryDatam>1 then
            table.sort(batteryDatam,tableSortRefreshTme)
        end
        gameMaster:addBettary(batteryDatam)
    end

   --近战怪物层
   if #(returnLevelTable(level).monster)>0 then
        local monsterDatam={}
        copyTable(returnLevelTable(level).monster,monsterDatam)
        if #monsterDatam>1 then
            table.sort(monsterDatam,tableSortRefreshTme)
        end
        gameMaster:addMonster(monsterDatam)
   end
   
   --中立怪物层
    if #(returnLevelTable(level).neutralMonster)>0 then
        local neutralDatam={}
        copyTable(returnLevelTable(level).neutralMonster,neutralDatam)
        if #neutralDatam>1 then
            table.sort(neutralDatam,tableSortRefreshTme)
        end
        gameMaster:addNeutral(neutralDatam)
    end
    
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

--处理游戏逻辑
local function gameController(dt)
    gameMaster:update(dt)
--    collisionDetect(dt)
    solveAttacks(dt)
    nightlayer:update(dt)
end

function GameScene.create()
    gameScene = GameScene.new()
    
    --玩家数据层 道具
--    gameScene:cacheInit();
    gameScene:createBackground()
    gameScene:createPhysicsContact()
    gameScene:createPhysicsEageBox()
    gameScene:createGameLayer()
    
    --处理游戏逻辑
    gameMaster = require("GameMaster").create()
    
    --新手引导
    gameScene:addBeginnerGuide() 
    
    --增加怪物
    gameScene:initMonsterData()   
    local isGuide = cc.UserDefault:getInstance():getBoolForKey("guide1001")
    if isGuide==false then
        
        gameScene:openAllSchedule()
    else
        gameJudge=require("GameJudge").create()
        gameJudge:setCurJudgeData()
    end
--    --处理游戏逻辑 计时器
--    gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(gameController, 0, false)
--    MessageDispatchCenter:getInstance():registerMessage(MessageDispatchCenter.MessageType.GAME_OVER, gameOver)
    local Musicstate=cc.UserDefault:getInstance():getBoolForKey("MusicState")
    if Musicstate then
        cc.SimpleAudioEngine:getInstance():playBackgroundMusic("bgm.mp3",true)
    end
    
    return gameScene
end

function GameScene:openSeting()
    self:pauseAll()
    local setLayer=require"GameSettingLayer"
    local setingLayer = setLayer.create()
    self:addChild(setingLayer,11,layerEnum.setingLayerTag)
end

function GameScene:closeSeting()
    self:resumeScene()
    if self:getChildByTag(layerEnum.setingLayerTag) then
        self:removeChildByTag(layerEnum.setingLayerTag,false)
    end    
end

--游戏计时器开启

function GameScene:openAllSchedule()
    --处理游戏逻辑 计时器
    gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(gameController, 0.05, false)
    MessageDispatchCenter:getInstance():registerMessage(MessageDispatchCenter.MessageType.GAME_OVER, gameOver)
end

function GameScene:pauseAll()
    if gameControllerScheduleID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameControllerScheduleID)
    end
    gameScene:pause()
    gameCurrentLayer:PauseGameMonster()

end

function GameScene:resumeScene()
    gameScene:resume()
    gameControllerScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(gameController,  0.05, false)
    gameCurrentLayer:resumeGameMonster()

end

return GameScene
