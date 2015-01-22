require "Cocos2d"
require "GameBattleUtils"
require "GameDirectorUtils"
require "GlobalVariables"
require "Data_Level"
require "LayerManager"
require "GuideChalkLine"
require "GuideChalkLayer"

local listener=cc.EventListenerTouchOneByOne:create()

local ENUM_STEP={
    STEP_FIRST=1,
    STEP_SECOND=2,
    STEP_THIRD=3,
    STEP_FORTH=4,
}


local colorLayerTag=100
local clippingTag=101
local chalkLineTag=102
local chalkLayerTag=103
local height=800


local BeginnerGuide =class("BeginnerGuide",function()
    return cc.Layer:create();
end)

function BeginnerGuide:ctor()
    self.isGuideEnded=false

    self.click=false
    self.chalk=false

    self.chalkBegin=false
    self.chalkMove=false
    self.chalkEnded=false

    self.beginPoint=cc.p(0,0)
    self.beginEnded=cc.p(0,0)

    self.guideCount=0
    self.guideIndex=1
    
    self.clickWidth=0
    self.isInit=false
end

function BeginnerGuide.create(data)      
    local layer=BeginnerGuide.new()
    copyTable(data,layer)
    layer:addTouchListener(layer)
    layer.guideCount=data.count
    layer:initWithData()
    return layer
    
end

function BeginnerGuide:initWithData()
    if DirectorUtils.isDeviceFour() then
    	height=650
    end
end

--初始化划线引导
function BeginnerGuide:initWithChalkLine()

--    local xx={pos_x=DirectorUtils.getWinWidth()/2, pos_y=DirectorUtils.getWinHeight()/2,
--        stencil="chalkLine2.png",chand="chalkLine_hand.png",subWidth=400,}

    local key="guide"..tostring(self.guideIndex)
  
    if self.guideIndex>self.guideCount then
    	return
    end
    
    self.guideIndex=self.guideIndex+1
    local data=self[key]

    self.clickWidth=data.subWidth
    local angle=self.bulletAngle
    self.rotateAngle=angle-90
    print("self.bulletAngle===",self.bulletAngle)
    print("self.rotateAngle===",self.rotateAngle)
    self.chalk=true
    local colorLayer=cc.LayerColor:create(cc.c4b(0,0,0,100))
 
    self.clippingNode=cc.ClippingNode:create()
--    clippingTag
    self:addChild(self.clippingNode,0,clippingTag)
    self.clippingNode:addChild(colorLayer)
    
    
    self.stencil=cc.Sprite:create(data.stencil)
    self.stencilSize=self.stencil:getContentSize()
    local width=self.stencilSize.width
    local height=self.stencilSize.height
    
    local p=cc.p(data.pos_x,data.pos_y) 
    self.stencil:setPosition(p)
    self.stencil:setRotation(self.rotateAngle)
    
    self.clippingNode:setStencil(self.stencil)
    self.clippingNode:setInverted(true)
    self.clippingNode:setAlphaThreshold(0)
 
    self.chalkLine=GuideChalkLine.create(data)
    self.chalkLine:setPosition(p)
    self.chalkLine:setRotation(self.rotateAngle)
    self:addChild(self.chalkLine,0,chalkLineTag)
end

--划出挡板
function BeginnerGuide:addTouchListener(layer)

    local function onTouchBegin(touch,event)
        if self.chalk==false then
            return true
        end
        
        local gl=self:locationConverToGl(touch)
        local beginPoint=self.stencil:convertToNodeSpace(gl)
        local width=self.stencilSize.width
        local height=self.stencilSize.height
--        print("beginPoint===",beginPoint.x,beginPoint.y)
        local rect = cc.rect(0, 0, width, height)
        if cc.rectContainsPoint(rect, beginPoint) then
            local beginX=width-self.clickWidth-(width-self.clickWidth)/2
            if beginPoint.x<beginX then
                self.beginPoint=gl
                local addPoint=getAngleDistance(self.rotateAngle,self.clickWidth/2+10)
                local point=getPosTable(self.chalkLine)
                self.beginPoint=cc.p(point.x-addPoint.x,point.y+addPoint.y)
                self.chalkBegin=true
            end
--            print(string.format("sprite began... x = %f, y = %f", beginPoint.x,beginPoint.y))
        end
        return true            
    end

    local function onTouchMoved(touch,event)
        if self.chalk==false then
            return
        end
    
        local gl=self:locationConverToGl(touch)
        local beginPoint=self.stencil:convertToNodeSpace(gl)
        local width=self.stencilSize.width
        local height=self.stencilSize.height
        local rect = cc.rect(0, 0, width, height)
        if cc.rectContainsPoint(rect, beginPoint) then
            self.chalkMove=true
            
            local EndedX=width-(width-self.clickWidth)/2
            if beginPoint.x>EndedX then
                self.chalkEnded=true
                if self:isChalkEnded() then
                    self.beginEnded=gl
                    local addPoint=getAngleDistance(self.rotateAngle,self.clickWidth/2+10)
                    local point=getPosTable(self.chalkLine)
                    self.beginEnded=cc.p(point.x+addPoint.x,point.y-addPoint.y)
                    self:ChalkEnded()
                end
            end
--            print(string.format("sprite onTouchMoved... x = %f, y = %f", beginPoint.x,beginPoint.y))
        else
            self:setChalkFalse()     
        end
    end

    local function onTouchEnded(touch,event)
        if self.chalk==false then
            return
        end
    
--        local gl=self:locationConverToGl(touch)
--        local EndedPoint=self.stencil:convertToNodeSpace(gl)
--        local width=self.stencilSize.width
--        local height=self.stencilSize.height
--        local rect = cc.rect(0, 0, width, height)
--        if cc.rectContainsPoint(rect, EndedPoint) then
--            local EndedX=width-(width-self.clickWidth)/2
--            if EndedPoint.x>EndedX then
--                self.chalkEnded=true
--                if self:isChalkEnded() then
--                    self.beginEnded=gl
--                    local addPoint=getAngleDistance(self.rotateAngle,self.clickWidth/2+10)
--                    local point=getPosTable(self.chalkLine)
--                    self.beginEnded=cc.p(point.x+addPoint.x,point.y-addPoint.y)
--                	self:ChalkEnded()
--                end
--            end
--            print(string.format("sprite onTouchEnded... x = %f, y = %f", EndedPoint.x,EndedPoint.y))
--        end
--        self:setChalkFalse()  
    end
    
    
    self.listener=cc.EventListenerTouchOneByOne:create()
    self.listener:setSwallowTouches(true)
    self.listener:registerScriptHandler(onTouchBegin,cc.Handler.EVENT_TOUCH_BEGAN)
    self.listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    self.listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher=layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener,layer)
end

--检测子弹触发引导
local function pauseController()
--    if List.getSize(BulletManager)~=0 then
--        for var=BulletManager.first,BulletManager.last do
        local child=gameCurrentLayer:getChildren()
        local bullet
        local i=1
        if child then
        	while child[i] do
        	if child[i].monsterType==EnumRaceType.BULLET then
        		bullet=child[i]
        		break
        	end
        	i=i+1
        end
        if bullet then
        	local bulletPoint=getPosTable(bullet)

            if bulletPoint.y<height then
                beginnerGuide.bulletAngle=bullet.bulletAngle
                beginnerGuide:pauseAll()
                beginnerGuide:strikeGuide()
            end
        end
    end
end

--指引计时器
function BeginnerGuide:scheduleGuide()
    self.pauseScheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(pauseController, 0, false)
end

--触发指引
function BeginnerGuide:strikeGuide()
    print("strikeGuide")
    self:setVisible(true)
    
    local key="guide"..tostring(self.guideIndex)
    if self.guideIndex>self.guideCount then
        return
    end
    local data=self[key]
    self:addChild(GuideChalkLayer.create(data),0,chalkLayerTag) 
end

function BeginnerGuide:initWithGuide()
    if self:getChildByTag(chalkLayerTag) then
        self:removeChildByTag(chalkLayerTag,false)
    end
    self:initWithChalkLine()
end

--清除任务
function BeginnerGuide:clearGuide()
    self.chalk=false

    self:removeChildByTag(clippingTag,false)
    self:removeChildByTag(chalkLineTag,false)
end

--重置滑动
function BeginnerGuide:setChalkFalse()
    self.chalkBegin=false
    self.chalkMove=false
--    self.chalkEnded=false
end

--是否滑动结束
function BeginnerGuide:isChalkEnded()
    if self.chalkBegin and self.chalkMove then
    	return true
    else
        return false	
    end
end

--滑动成功
function BeginnerGuide:ChalkEnded()
    print("ChalkEndedChalkEndedChalkEndedChalkEnded")    
    rLayer:setBeginPoint(self.beginPoint)
    rLayer:setEndPoint(self.beginEnded)
    
    self:resumeAll()
end

--暂停
function BeginnerGuide:pauseAll()
    if self.pauseScheduleID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.pauseScheduleID)
    end
    gameScene:pauseAll()
end

--开启
function BeginnerGuide:resumeAll()
    self:clearGuide()
    gameScene:resumeScene()
    self:setVisible(false)
end

--外部开启计时器检测引导模式
function BeginnerGuide:openGuide()
    self:scheduleGuide()
end

--关闭计时器
function BeginnerGuide:closeGuide()
    if self.pauseScheduleID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.pauseScheduleID)
    end
end

--禁止点击
function BeginnerGuide:touchLayerEnabled(enabled)
    listener:setEnabled(enabled)
end
--点击坐标
function BeginnerGuide:locationConverToGl(touch)
    local location=touch:getLocation()
    return location
end

return BeginnerGuide