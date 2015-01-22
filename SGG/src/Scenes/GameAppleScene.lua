require "Cocos2d"
require "GameDirectorUtils"
require "Data_Level"
require "GameUserDataLayerApple"
require "AppGameBattleUtils"
require "GameBattleUtils"
require "LayerManager"
local GameAppleScene = class("GameAppleScene",function()
    return cc.Scene:createWithPhysics()
end)

local layerEnum={
    touchLayerTag=1,
    rubberLayerTag=2,
    neutralLayer=3,
    gameUserDataLayerApple=4,
    AppleFamerLayer=5,
    
    gameUserData=6,
    edgeBoxTag=100,
}


local appleNum
local applemaxnum
local colliNum
local appscene
function GameAppleScene.create()
    appscene = GameAppleScene.new()
    --使用

   
    
    appscene:cacheInt()
    appscene:createBackground()
    

    
    return appscene
end

function GameAppleScene:initBattleData(level)
    --    plantsHp
    local appleData=returnLevelTable(level).apple
    colliNum=returnLevelTable(level).collingNum
    applemaxnum=#appleData
    appleNum=applemaxnum
    --local applemaxnum=#appleData
    
end

function GameAppleScene:createGameLayer()
    famer=nil
    battlescheludeID=nil
    local pworld=self:getPhysicsWorld()
    --   pworld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
    --触摸层
    local touchLayer=require("TouchLayer")
    local tLayer=touchLayer:create();
    self:addChild(tLayer,0,layerEnum.touchLayerTag)
    --挡板层
    local rubberLayer=require("RubberLayer")
    local rLayer=rubberLayer:create();
    self:addChild(rLayer,0,layerEnum.rubberLayerTag)
    
    --苹果和农民伯伯层
    local AppleFamerLayer=require("AppleFamerLayer")
    local aLayer=AppleFamerLayer:create()
    self:addChild(aLayer,3,layerEnum.AppleFamerLayer)
    
    --苹果菜单层
    local GameUserDataLayerApple=require("GameUserDataLayerApple")
    local ULayer=GameUserDataLayerApple:create()
    self:addChild(ULayer,3,layerEnum.gameUserDataLayerApple)
    
    
--    local cannonAnimation=cc.AnimationCache:getInstance():getAnimation("mogu_1")
--    cannonAnimation:setDelayPerUnit(0.1);
--    cannonAnimation:setRestoreOriginalFrame(false);
--    local cannonAnimate=cc.Animate:create(cannonAnimation);
    
    
    
--    local mogu = cc.Sprite:create("mogu_1_5.png")
--    mogu:setPosition(320,800)
--    mogu:runAction(cannonAnimate)
--    self:addChild(mogu)
--   
end

function GameAppleScene:createPhysicsContact()

    local function onContactBegin(contact)
        local spriteA,spriteB=BattleUtils.getCollisionSprite(contact)
        if (spriteA~=nil and spriteB~=nil) then
            local gA,gB=BattleUtils.getCollisionGroup(spriteA,spriteB)
            --print("ga,gb===",gA,gB)
            --农民伯伯碰到边框
          
                    
            --农民伯伯碰到苹果  预留位置
            if (AppleBattleUtils.FamerCollisionScratch(spriteA,spriteB,gA,gB)) then
--                --                print("BulletCollisionEnemies")
                return true
                
            elseif (AppleBattleUtils.FamerCollisionApple(spriteA,spriteB,gA,gB)) then
                return false
          
            elseif (AppleBattleUtils.FamerCollisionOutBorder(spriteA,spriteB,gA,gB)) then
                return true
            end
        end
        --        print("gA,gB",gA  ,  gB)
        --        print("falsefalsefalsefalsefalsefalse")
        return false
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
            --子弹弹出板子
            if (AppleBattleUtils.FamerCollisionOutScratch(spriteA,spriteB,gA,gB)) then
            --子弹反弹边框
            elseif (AppleBattleUtils.FamerCollisionBorder(spriteA,spriteB,gA,gB)) then

            

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

function GameAppleScene:createPhysicsEageBox()

    
end
local function BglayerMoveCallBack(sender) 
    appscene:initBattleData(DirectorUtils.getCurSceneLevel())

    appscene:createPhysicsContact()
    --scene:createPhysicsEageBox()
    appscene:createGameLayer()
end
local Bglayer
local function LoadingSceneBgCallBack(sender)
    sender:removeFromParent() 
--    local SceneTable=#returnSceneTable()
    local level=DirectorUtils.getCurLevel()
    if level>=10 then
        local move = cc.MoveBy:create(0.8,cc.p(0,DirectorUtils.getWinHeight()))
        local ease = cc.EaseSineInOut:create(move);    --让目标动作由慢到快
        local callback = cc.CallFunc:create(BglayerMoveCallBack)
        local seq=cc.Sequence:create(ease,callback)
        Bglayer:runAction(seq)
    else
        appscene:initBattleData(DirectorUtils.getCurSceneLevel())

        appscene:createPhysicsContact()
        --scene:createPhysicsEageBox()
        appscene:createGameLayer()
    end
end

function GameAppleScene:createBackground()
    Bglayer=cc.Layer:create()
    
    local background=returnLevelTable(DirectorUtils.getCurSceneLevel()).backgroundJpg
    local back=cc.Sprite:create(background.jpg)
    back:setPosition(DirectorUtils.getWinWidth()/2,0)
    Bglayer:addChild(back,-3)
    
    local famer =cc.Sprite:create("famer_jump_1.png")
    famer:setPosition(0,800)
    Bglayer:addChild(famer)
    
    local move = cc.MoveBy:create(0.8,cc.p(640,0))
    
    local callback=cc.CallFunc:create(LoadingSceneBgCallBack)
    local seq =cc.Sequence:create(move,callback)
    famer:runAction(seq)
    
    self:addChild(Bglayer)
end

function GameAppleScene:setRubberBeginPoint(bp)
    local rLayer=self:getChildByTag(layerEnum.rubberLayerTag)
    rLayer:setBeginPoint(bp)

end

function GameAppleScene:setRubberEndPoint(ep)
    local rLayer=self:getChildByTag(layerEnum.rubberLayerTag)
    rLayer:setEndPoint(ep)
end

function GameAppleScene:setRubberMovePoint(mp)
    local rLayer=self:getChildByTag(layerEnum.rubberLayerTag)
    rLayer:setMovePoint(mp)
end

--游戏苹果得到的数量
function GameAppleScene:setAppleNum(num)
    
    local gameUserDataLayer=self:getChildByTag(layerEnum.gameUserDataLayerApple)
    local appleFamerLayer= self:getChildByTag(layerEnum.AppleFamerLayer)
    --苹果减少
    appleNum=appleNum-num
    gameUserDataLayer.getapple=gameUserDataLayer.getapple+num
    
   gameUserDataLayer:setAppleLabel(appleNum)
   if appleNum==0 then
        AppleBattleUtils.removerBattleScher()
        appleFamerLayer:removeschedule()
        self:gameOver(true)
   end

end
--游戏板子碰撞次数减少
function GameAppleScene:setCollNum(num)
    local gameUserDataLayer=self:getChildByTag(layerEnum.gameUserDataLayerApple)
    local appleFamerLayer= self:getChildByTag(layerEnum.AppleFamerLayer)
    --次数减少
    colliNum=colliNum-num
    if colliNum<0 then
        if appleNum==0 then
            AppleBattleUtils.removerBattleScher()
            appleFamerLayer:removeschedule()
            self:gameOver(true)
            return false
        else
            AppleBattleUtils.removerBattleScher()
            appleFamerLayer:removeschedule()
            self:gameOver(false)
            return false
        end
    end
    gameUserDataLayer:setReboundLabel(colliNum)
    --    if plantsHp1123123hen
    --        cc.SimpleAud12tInstance():213213231yer:setLifeLabel(0)
    --        asdasdsa321322131232112
    --    end
end

function GameAppleScene:setGoldLabel()
    local gameUserDataLayer=self:getChildByTag(layerEnum.gameUserDataLayerApple)
	gameUserDataLayer:addMoneyLabel()
end
function GameAppleScene:gameOver(isWin)
        
--        if isWin then
--            
--            cc.UserDefault:getInstance():setBoolForKey("ispass",true)
--            --UserData:setLevelMaxApple(applemaxnum)
--            --UserData:setLevelMaxApple(applemaxnum)
--        UserData:setGameSceneType(DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),2)
--        else
--            cc.UserDefault:getInstance():setBoolForKey("ispass",false)
--        end
--        cc.UserDefault:getInstance():flush()
--        local gameover = require("OverLayer")
--        Olayer=gameover.create()
        
        
--    local scene = require("OverLayer")
--    local la =cc.Layer:create()
--    local a=scene.create();
--    self:addChild(Olayer)
    cc.SimpleAudioEngine:getInstance():stopMusic()
    if isWin then
        --过关成功
        MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._WINEFFECT_);
        local curlevel=DirectorUtils.getCurLevel();
        curlevel=curlevel+1
        --保存过关评分数据
        
        local gameUserDataLayer=self:getChildByTag(layerEnum.gameUserDataLayerApple)
        
        UserData:setSceneLevelGetApple(UserData:GetInstance():getCurScene(),
            UserData:GetInstance():getCurLevel(),gameUserDataLayer.getapple)

        
        UserData:setLevelMaxApple(UserData:GetInstance():getCurScene(),
            UserData:GetInstance():getCurLevel(),gameUserDataLayer.maxapple)

        cc.UserDefault:getInstance():setBoolForKey("ispass",true)
    else
        --过关失败
        MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._LOSTEFFECT_);
        cc.UserDefault:getInstance():setBoolForKey("ispass",false) 
    end
--    if famer:getPhysicsBody() then
--        famer:getPhysicsBody():removeFromWorld()
--    end
    local curtype=returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
    UserData:setGameSceneType(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel(),curtype)
    AppleBattleUtils.removerBattleScher()
    cc.UserDefault:getInstance():flush()
    GameUIManager:openGameOverLayer()
    self:pause()
end




--加载战斗素材
function GameAppleScene:cacheInt()
    
--    cc.SpriteFrameCache:getInstance():addSpriteFrames("scratch/scratchmogu.plist","scratch/scratchmogu.png");
--    cc.SpriteFrameCache:getInstance():addSpriteFrames("scratch/scratchmogutan.plist","scratch/scratchmogutan.png")
    
--    cc.Director:getInstance():getTextureCache():
    --cc.SimpleAudioEngine:getInstance():playBackgroundMusic("bgm.mp3",true)
    local cache = cc.SpriteFrameCache:getInstance()
    local levelCeche=returnLevelTable(DirectorUtils.getCurSceneLevel()).ceche
    for key, var in ipairs(levelCeche) do
        local pathPlist=string.format("apple/%s.plist",var)
        local pathPng=string.format("apple/%s.png",var)
        print("=====",pathPlist,pathPng)

        cache:addSpriteFrames(pathPlist, pathPng)
--        local animateLevel=returnLevelTable(DirectorUtils.getCurLevel()).sggAnimate[var]
--        if animateLevel then
--            for type, count in pairs(animateLevel) do
--                local animframes={}
--                for i=1,count do
--                    local ImageStr=string.format("%s_%s_%d.png",var,type,i)
--                    local frame=cache:getSpriteFrame(ImageStr)
--                    animframes[i]=frame
--                end
--                local animation=cc.Animation:createWithSpriteFrames(animframes)
--                local animationStr=string.format("%s_%s",var,type)
--                print("animationStr===",animationStr)
--                cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
--            end
--        end
    end

    
    
end

--卸载战斗素材
function GameAppleScene:removeCacheInt()
    cc.SimpleAudioEngine:getInstance():stopMusic()
    local weaponDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).ceche
    for key, var in ipairs(weaponDatam) do
        local pathPlist=string.format("battle/%s.plist",var)
        cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(pathPlist)
    end
end

--卸载战斗素材
function GameAppleScene:removeBattleData()
    local MonsterManagerLayer=self:getChildByTag(layerEnum.monLayerTag)
    MonsterManagerLayer:removeAllData();

    local MonsterManagerLayer=self:getChildByTag(layerEnum.cannonLayerTag)
    MonsterManagerLayer:removeAllData();
end


return GameAppleScene
