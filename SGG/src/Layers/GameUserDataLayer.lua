require "Cocos2d"
require "GameBattleUtils"
require "GameDirectorUtils"
require "GlobalVariables"
require "AttackCommand"
require "Data_Level"
require "Data_Props"

local GameUserDataLayer =class("GameUserDataLayer",function()
    return cc.Layer:create();
end)

local GameUserDataEnum={
    FarmlandTag=1,
    settingTag=10,
    lifeLabelTag=20,
    itemTag=300,
    
    lifeLabelActionTag=1000,
}
--农场
farmland=nil

local Scale1=0.65
local Scale2=0.8
local itemPadding=-25
local itemHeigth=15
local lifePadding=25
local itemCount=4
local itemInterval=15

function GameUserDataLayer.create()      
    local layer=GameUserDataLayer.new()
    layer:initWithFarmland()
    layer:initWithItem()
    layer:initWithUserData()
    return layer
end

function GameUserDataLayer:ctor()
    local plantsDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).plants
    local hp=plantsDatam.hp
    self.plantsHp=hp
end

function GameUserDataLayer:initWithFarmland()
    farmland=cc.Sprite:create("BattleFarmland1.png")
    local size=farmland:getContentSize();
    local boundBoy=cc.PhysicsBody:createEdgeBox(size)
    --农田位于碰撞第八组
    boundBoy:getShape(0):setGroup(BattleGroup.UserFarmlandGroup)

    boundBoy:setCategoryBitmask(0x0011)
    boundBoy:setCollisionBitmask(0x0011)
    boundBoy:setContactTestBitmask(0X0011)
    farmland:setPhysicsBody(boundBoy)
    
    local farmlandPoint=cc.p(size.width/2,size.height/2)
    farmland:setPosition(farmlandPoint)
    farmland:setTag(GameUserDataEnum.FarmlandTag);
    self:addChild(farmland)
end  

function GameUserDataLayer:removeAllData()
    farmland:getPhysicsBody():removeFromWorld()
end

function GameUserDataLayer:initWithPropsCeche()
    local cache = cc.SpriteFrameCache:getInstance()
    
    local propsCeche=Props_ceche.ceche
    
    for key, var in ipairs(propsCeche) do
        local pathPlist=string.format("props/%s.plist",var)
        local pathPng=string.format("props/%s.png",var)
        cache:addSpriteFrames(pathPlist, pathPng)
    end
    
    local propsAnimateKey=Props_ceche.propsAnimateKey

    local animateLevel=Props_ceche.propsAnimate
    if animateLevel then
        for type, count in pairs(animateLevel) do
            local animframes={}
            for i=1,count do
                local ImageStr
                if type=="wenyiguang" then
            	   ImageStr=string.format("%s%d.png",type,i)
            	elseif type=="fadong" then  
                    ImageStr=string.format("%s_0%d.png",type,i)
            	else
            	   ImageStr=string.format("%s_%d.png",type,i)   
                end
                local frame=cache:getSpriteFrame(ImageStr)
                animframes[i]=frame
            end
            local animation=cc.Animation:createWithSpriteFrames(animframes)
            local animationStr=string.format("%s",type)
--            print("animationStr===",animationStr)
            cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
        end
    end

end


function GameUserDataLayer:initWithItem()
         
    local cache = cc.SpriteFrameCache:getInstance()
    local pathPlist=string.format("skill0.plist",var)
    local pathPng=string.format("skill0.png",var)        
    cache:addSpriteFrames(pathPlist, pathPng)
        
    pathPlist=string.format("skill1.plist",var)
    pathPng=string.format("skill1.png",var)        
    cache:addSpriteFrames(pathPlist, pathPng)
    
    self:initWithPropsCeche();

    local function onTouchBegin(touch, event)
        local target = event:getCurrentTarget()
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        if cc.rectContainsPoint(rect, locationInNode) then
--            print(string.format("sprite began... x = %f, y = %f", locationInNode.x, locationInNode.y))
            target:setScale(Scale2)
            return true
        end
        return false
    end

    local function onTouchEnded(touch, event)
        local target = event:getCurrentTarget()
        target:setScale(Scale1)
        
        local tag=target:getTag()
        if tag==1 then
            local point=cc.p(DirectorUtils.getWinWidth()/2,0)
            local props=returnPropsTable("Props_1001")
            props.normalAtk["monsterType"]=EnumRaceType.PROPS
            CarrotMissileAttack.create(point, 0,props.normalAtk)

        elseif tag==2 then
            local point=cc.p(DirectorUtils.getWinWidth()/2,DirectorUtils.getWinHeight()/2)
            local props=returnPropsTable("Props_1002")
            props.normalAtk["monsterType"]=EnumRaceType.PROPS
            FrozenWatermelonAttack.create(point, 0,props.normalAtk)
        elseif tag==3 then
            local point=cc.p(DirectorUtils.getWinWidth()/2,DirectorUtils.getWinHeight()/2)
            local props=returnPropsTable("Props_1003")
            props.normalAtk["monsterType"]=EnumRaceType.PROPS
            CushawBomblonAttack.create(point, 0,props.normalAtk)
        elseif tag==4 then
            if farmland then
                local point=cc.p(farmland:getPosition())
                local props=returnPropsTable("Props_1004")
                props.normalAtk["monsterType"]=EnumRaceType.PROPS
                SeedSupply.create(point, 0,props.normalAtk,farmland)      
            end
        elseif tag==GameUserDataEnum.settingTag then
            if gameScene then
                gameScene:openSeting()
            end    
        end
    end
    
    local imageTable={"pesticide.png","bomp.png","chemical.png","seed.png"}
    local items={}
    
    for key, var in ipairs(imageTable) do
        local spriteItemP1=cc.Sprite:create(var)
        spriteItemP1:setScale(Scale1)
        spriteItemP1:setTag(GameUserDataEnum.itemTag+key)
        items[key]=spriteItemP1
        spriteItemP1:setTag(key)
    end
    
    local listenerItem = cc.EventListenerTouchOneByOne:create()
    listenerItem:setSwallowTouches(true)
    listenerItem:registerScriptHandler(onTouchBegin,cc.Handler.EVENT_TOUCH_BEGAN )
    listenerItem:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = self:getEventDispatcher()
    
    local bsize=items[1]:getBoundingBox()
    local fview=self:getChildByTag(GameUserDataEnum.FarmlandTag)
    local fsize=fview:getBoundingBox()

    local bx=(fsize.width-bsize.width*itemCount-itemInterval*(itemCount-1))/2
    local by=(fsize.height-bsize.height)/2+bsize.height/2

    local count=0.5
    local lter=listenerItem
    for key, var in ipairs(items) do
        if key>1 then
            lter=listenerItem:clone()
        end
        var:setPosition(bx+(count+key-1)*bsize.width+itemInterval*(count+key-1),by)    
        self:addChild(var)
        eventDispatcher:addEventListenerWithSceneGraphPriority(lter, var)
    end
      
    local spriteItemSet=cc.Sprite:create("battleSeting.png")
    spriteItemSet:setScale(Scale1)
    spriteItemSet:setTag(GameUserDataEnum.settingTag)
    spriteItemSet:setPosition(DirectorUtils.getWinWidth()-bsize.width/2-itemInterval,DirectorUtils.getWinHeight()-bsize.height/2-itemInterval)
    self:addChild(spriteItemSet)
    lter=listenerItem:clone()
    eventDispatcher:addEventListenerWithSceneGraphPriority(lter, spriteItemSet)
    
end  

function GameUserDataLayer:initWithUserData()

    local size=self:getChildByTag(GameUserDataEnum.settingTag):getBoundingBox()
    local life=cc.Sprite:create("userLife.png")
    local lifeSize=life:getContentSize()
    local lifePosition=cc.p(DirectorUtils.getWinWidth()-size.width-lifePadding-lifeSize.width/2,DirectorUtils.getWinHeight()-lifeSize.height/2)
    life:setPosition(lifePosition)
    self:addChild(life)
    
    local plantsDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).plants
    local plantsHp=plantsDatam.hp
    local plantsHpStr=string.format("%d",plantsHp)
    local lifeLabel = cc.Label:createWithTTF(plantsHpStr, "QuicksandBold-Regular.otf", 45)

    local lifeLabelPosition=cc.p(lifePosition.x+22,lifePosition.y-37)
    lifeLabel:setPosition(lifeLabelPosition)
    lifeLabel:setTag(GameUserDataEnum.lifeLabelTag)
    self:addChild(lifeLabel)
    
    
    local timeLabel = cc.Label:createWithTTF("0", "QuicksandBold-Regular.otf", 45)

    local lifeLabelPosition=cc.p(lifePosition.x-200,lifePosition.y-37)
    timeLabel:setPosition(lifeLabelPosition)
    timeLabel:setTag(30)
    self:addChild(timeLabel)
end

--游戏农场的血量
function GameUserDataLayer:hurt(collider)
    local damage = collider.damage
    
    local plantsHp=self.plantsHp
    self.plantsHp=plantsHp-damage
    gameJudge:PlantsSubHp(damage)
    if self.plantsHp<=0 then      
        self:setLifeLabel(0)
        --游戏失败 
--        MessageDispatchCenter:getInstance():dispatchMessage(MessageDispatchCenter.MessageType.GAME_OVER,false)
         if gameMaster then
         	gameMaster:lostGameOver()
         end 
    else        
        self:setLifeLabel(self.plantsHp)
    end
end


function GameUserDataLayer:setLifeLabel(life)

--    cc.SimpleAudioEngine:getInstance():playEffect("gongjishucai.wav");
    MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._GONGJISUCAI_);
    local plantsHpStr=string.format("%d",life)
    local lifeLabel=self:getChildByTag(GameUserDataEnum.lifeLabelTag)
    
    local isHasAction=lifeLabel:getActionByTag(GameUserDataEnum.lifeLabelActionTag)
    if  isHasAction==nil then
        local scaleAction=cc.ScaleBy:create(0.2,1.6,1.6)
        local seq=cc.Sequence:create(scaleAction,scaleAction:reverse())
        seq:setTag(GameUserDataEnum.lifeLabelActionTag)
        lifeLabel:runAction(seq)
    end    
    lifeLabel:setString(plantsHpStr)
end  

function GameUserDataLayer:setTimeLabel(life)

    --    cc.SimpleAudioEngine:getInstance():playEffect("gongjishucai.wav");
    local plantsHpStr=string.format("%d",life)
    local lifeLabel=self:getChildByTag(30)
    lifeLabel:setString(plantsHpStr)
end  

function GameUserDataLayer:removeAllData()
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListenersForType(cc.EVENT_TOUCH_ONE_BY_ONE)
end

return GameUserDataLayer


