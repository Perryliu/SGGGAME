require "Cocos2d"
require "GameBattleUtils"
require "GameDirectorUtils"
require "GlobalVariables"

local GameUserDataLayerPause =class("GameUserDataLayerPause",function()
    return cc.Layer:create();
end)

local GameUserDataPauseEnum={
    FarmlandTag=1,
    
    settingTag=10,
    hitrateLabelTag=20,
    ProLabel=30,
 
    itemTag=300,
    
    HitallLabelActionTag=1000,
}


local Scale1=0.65
local Scale2=0.8
local itemPadding=-25
local itemHeigth=15
local lifePadding=25
local itemCount=4
local itemInterval=15
ProgressTime=0
local curhitmonster
local curAllhitmonster


local loadProgress

local GameData=returnLevelTable(DirectorUtils.getCurSceneLevel())
function PauseProgressUpdate(dt)
    ProgressTime=ProgressTime+dt
    
    local time=GameData.pauseTime[curGroup]
    
--    char buf_str[16];
--    sprintf(buf_str,"%d%%",(int)(((float)TextureManager::Getinstance()->getLoadSp() / TextureManager::Getinstance()->getNumsSp()) * 100),TextureManager::Getinstance()->getNumsSp());
--    percentLabel->setString(buf_str);
--    local percentLabel=self:getChildByTag(GameUserDataPauseEnum.ProLabel)
--    local percentStr=string:format("%d",ProgressTime/100*100)
--    percentLabel:setString()
    --更新进度条
    local timePercent=100*((time-ProgressTime)/time)
    loadProgress:setPercentage(timePercent)
    if timePercent<=0 then
        ProgressTime=0 
        isPauseEnd=true
        pauseMonster=false
        gameUserDataLayer:getParent():resumeScene()
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameUserDataLayer.schedulerProID)
    end
    
end
function GameUserDataLayerPause.create()      
    local Pauselayer=GameUserDataLayerPause.new()
    
    
    Pauselayer:initWithFarmland()
    Pauselayer:initWithUserData()
    Pauselayer:initloadProgress()
    return Pauselayer
end
function GameUserDataLayerPause:initWithFarmland()

    farmland=cc.Sprite:create("farmland.png")
    local size=farmland:getContentSize();
    local boundBoy=cc.PhysicsBody:createEdgeBox(size)
    --农田位于碰撞第八组
    boundBoy:getShape(0):setGroup(BattleGroup.UserFarmlandGroup)

    boundBoy:setCategoryBitmask(0x0000)
    boundBoy:setCollisionBitmask(0x0000)
    boundBoy:setContactTestBitmask(0X0000)
    farmland:setPhysicsBody(boundBoy)

    local farmlandPoint=cc.p(size.width/2,size.height/2)
    farmland:setPosition(farmlandPoint)
    farmland:setTag(GameUserDataPauseEnum.FarmlandTag);
    self:addChild(farmland)
end  

local function openSettingLayer()
    if gameScene then
        gameScene:settingmenu()
    end   
end
function GameUserDataLayerPause:initWithUserData()
    local winSize = cc.Director:getInstance():getWinSize()
    curhitmonster=0
    local size=cc.size(50,50)
    local life=cc.Sprite:create("userLife.png")
    local lifeSize=life:getContentSize()
    local lifePosition=cc.p(DirectorUtils.getWinWidth()-size.width-2*lifePadding-lifeSize.width,DirectorUtils.getWinHeight()-lifeSize.height/2)
    life:setPosition(lifePosition)
    self:addChild(life)
    
    curAllhitmonster=#returnLevelTable(DirectorUtils.getCurSceneLevel()).monster+#returnLevelTable(DirectorUtils.getCurSceneLevel()).remotemonster
    local plantsHpStr=string.format("%d/%d",curhitmonster,curAllhitmonster)
    local hitrate = cc.Label:createWithTTF(plantsHpStr, "MarkerFelt.ttf", 45)

    local hitrateLabelPosition=cc.p(lifePosition.x+22,lifePosition.y-37)
    hitrate:setPosition(hitrateLabelPosition)
    hitrate:setTag(GameUserDataPauseEnum.hitrateLabelTag)
    self:addChild(hitrate)
    
    
    local menu = cc.Menu:create()
    self:addChild(menu)
    local setButton=cc.MenuItemImage:create("chilun_normal.png"
        ,"chilun_select.png"
        )
    setButton:setPosition(cc.p(winSize.width/2-setButton:getContentSize().width/2,winSize.height/2-setButton:getContentSize().height/2))
    setButton:setScale(0.8);
    setButton:registerScriptTapHandler(openSettingLayer)
    menu:addChild(setButton)
end


function GameUserDataLayerPause:initloadProgress()
--    --创建显示百分比的label
--	local percentLabel = cc.LabelTTF:create("100%","Arial",20)
--    percentLabel:setPosition(cc.p(DirectorUtils.getWinSize().width/2+35,DirectorUtils.getWinSize().height/2+30))
--    percentLabel:setTag(765)
--    self:addChild(percentLabel,2)

--创建一个进程条
    loadProgress = cc.ProgressTimer:create(cc.Sprite:create("sliderProgress.png"))
    loadProgress:setBarChangeRate(cc.p(1,0))--设置进程条的变化速率
    loadProgress:setType(1)--设置进程条的类型
    loadProgress:setMidpoint(cc.p(0,1))--设置进度的运动方向
    loadProgress:setPosition(cc.p(DirectorUtils.getWinSize().width/2,DirectorUtils.getWinSize().height-50))
    loadProgress:setPercentage(100)--设置初始值为0
    loadProgress:setScale(2)
    self:addChild(loadProgress,2)
    
    --cLayer.schedulerProID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(PauseProgressUpdate,0.01,false)
end

  
function GameUserDataLayerPause:setcurHitRate(num)
    curhitmonster=curhitmonster+num
    local plantsHpStr=string.format("%d/%d",curhitmonster,curAllhitmonster)

    local lifeLabel=self:getChildByTag(GameUserDataPauseEnum.hitrateLabelTag)
    local isHasAction=lifeLabel:getActionByTag(GameUserDataPauseEnum.HitallLabelActionTag)
    if  isHasAction==nil then
        local scaleAction=cc.ScaleTo:create(0.2,1.6,1.6)
        local scaleActionre=cc.ScaleTo:create(0.2,1,1)
        local seq=cc.Sequence:create(scaleAction,scaleActionre)
        seq:setTag(GameUserDataPauseEnum.HitallLabelActionTag)
        lifeLabel:runAction(seq)
    end    
    lifeLabel:setString(plantsHpStr)
end 



function GameUserDataLayerPause:removeAllData()
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListenersForType(cc.EVENT_TOUCH_ONE_BY_ONE)
end
function GameUserDataLayerPause:GameOverjudge()
    local gold=curhitmonster/curAllhitmonster
    return gold
end
return GameUserDataLayerPause


