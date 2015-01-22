require "Cocos2d"
require "GameBattleUtils"
require "GameDirectorUtils"

local GameUserDataLayerApple =class("GameUserDataLayerApple",function()
    return cc.Layer:create();
end)
local AppleGameUserDataEnum={

        settingTag=10,
        appleLabelTag=20,
        reboundLabelTag=30,
        itemTag=300,
        goldLabel=40,
        appleLabelActionTag=1000,
        reboundLabelActionTag=1001,

}

function GameUserDataLayerApple.create()      
    local layer=GameUserDataLayerApple.new()
    layer:initWithUserData()
    return layer
end


local Scale1=0.65
local Scale2=0.8
local itemPadding=-25
local itemHeigth=15
local lifePadding=25
local itemCount=4
local itemInterval=15

local curGold=0

function GameUserDataLayerApple:initWithUserData()

    --    local size=self:getChildByTag(GameUserDataLayerApple.settingTag):getBoundingBox()
    local size=cc.size(50,50)
    local life=cc.Sprite:create("userLife.png")
    local lifeSize=life:getContentSize()
    local lifePosition=cc.p(DirectorUtils.getWinWidth()-size.width-lifePadding-lifeSize.width/2,DirectorUtils.getWinHeight()-lifeSize.height/2)
    life:setPosition(lifePosition)
    self:addChild(life)

    local appleData=returnLevelTable(DirectorUtils.getCurSceneLevel()).apple
    local AppleHp=#appleData
    local appleHpStr=string.format("%d",AppleHp)


    local lifeLabel = cc.Label:createWithTTF(appleHpStr, "MarkerFelt.ttf", 45)

    local lifeLabelPosition=cc.p(lifePosition.x+22,lifePosition.y-37)
    lifeLabel:setPosition(lifeLabelPosition)
    lifeLabel:setTag(AppleGameUserDataEnum.appleLabelTag)
    local a=lifeLabel:getTag()
    print("%d",lifeLabel:getTag())

    self:addChild(lifeLabel)


    --local size=self:getChildByTag(GameUserDataEnum.settingTag):getBoundingBox()
    local reboundpic=cc.Sprite:create("userLife.png")
    local reboundSize=reboundpic:getContentSize()
    local reboundPosition=cc.p(size.width+lifePadding+reboundSize.width/2,DirectorUtils.getWinHeight()-reboundSize.height/2)
    reboundpic:setPosition(reboundPosition)
    self:addChild(reboundpic)


    local reboundDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).collingNum

    local reboundNumStr=string.format("%d",reboundDatam)


    local reboundLabel = cc.Label:createWithTTF(reboundNumStr, "MarkerFelt.ttf", 45)

    local reboundLabelPosition=cc.p(reboundPosition.x+22,reboundPosition.y-37)
    reboundLabel:setPosition(reboundLabelPosition)
    reboundLabel:setTag(AppleGameUserDataEnum.reboundLabelTag)

    local b=reboundLabel:getTag()
    self:addChild(reboundLabel)







    self.getapple=0
    self.maxapple=AppleHp
    
    
    local winSize =cc.Director:getInstance():getWinSize()
    local goldnum=string.format("%d",0)


    local goldLabel = cc.Label:createWithTTF(goldnum, "MarkerFelt.ttf", 45)

    
    goldLabel:setPosition(cc.p(winSize.width/2,winSize.height-goldLabel:getContentSize().height/2-20))
    goldLabel:setTag(AppleGameUserDataEnum.goldLabel)

    local b=goldLabel:getTag()
    self:addChild(goldLabel)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
end

function GameUserDataLayerApple:setAppleLabel(num)


    local appleStr=string.format("%d",num)

    --local applelifeLabel=self:getChildByTag(AppleGameUserDataEnum.appleLableTag)
    local applelifeLabel=self:getChildByTag(20)

    local scaleAction=cc.ScaleTo:create(0.2,1.6,1.6)
    local scaleActionre=cc.ScaleTo:create(0.2,1,1)
    local seq=cc.Sequence:create(scaleAction,scaleActionre)
    seq:setTag(AppleGameUserDataEnum.appleLabelActionTag)
    applelifeLabel:runAction(seq)
    applelifeLabel:setString(appleStr)
end

function GameUserDataLayerApple:setReboundLabel(num)

    
    local CollNumStr=string.format("%d",num)
    local reboundLabel=self:getChildByTag(AppleGameUserDataEnum.reboundLabelTag)


    local scaleAction=cc.ScaleTo:create(0.2,1.6,1.6)
    local scaleActionre=cc.ScaleTo:create(0.2,1,1)
    local seq=cc.Sequence:create(scaleAction,scaleActionre)
    seq:setTag(AppleGameUserDataEnum.reboundLabelActionTag)
    reboundLabel:runAction(seq)
    reboundLabel:setString(CollNumStr)

end
function GameUserDataLayerApple:removeAllData()
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListenersForType(cc.EVENT_TOUCH_ONE_BY_ONE)
end

function GameUserDataLayerApple:addMoneyLabel()
    curGold=curGold+50
    local GoldNumStr=string.format("%d",curGold)
    local goldLabel=self:getChildByTag(AppleGameUserDataEnum.goldLabel)
    local scaleAction=cc.ScaleTo:create(0.2,1.6,1.6)
    local scaleActionre=cc.ScaleTo:create(0.2,1,1)
    local seq=cc.Sequence:create(scaleAction,scaleActionre)
    goldLabel:runAction(seq)
    goldLabel:setString(GoldNumStr)
end
return GameUserDataLayerApple
