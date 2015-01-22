require"Cocos2d"
require "Cocos2dConstants"

local TouchLayer =class("TouchLayer",function()
	return cc.Layer:create();
end)

local listener=cc.EventListenerTouchOneByOne:create()

function TouchLayer:ctor()
    self.touchBegin=false
end

function TouchLayer.create()      
	local layer=TouchLayer.new()
	layer:addTouchListener(layer)
	return layer
end


function TouchLayer:addTouchListener(touchLayer)
    local function onTouchBegan(touch,event)
        if self.touchBegin==true then
            return
        end

        self.touchBegin=true
    
        local gl=self:locationConverToGl(touch)
        local parent=self:getParent()
        parent:setRubberBeginPoint(gl)
--        print("onTouchBegan: %0.2f, %0.2f", gl.x,"    ", gl.y)	
        return true
    end
    
    local function onTouchMoved(touch,event)
        local gl=self:locationConverToGl(touch)
        local parent=self:getParent()
        parent:setRubberMovePoint(gl)
--        print("onTouchMoved: %0.2f, %0.2f", gl.x,"    ", gl.y)
    end
   
    local function onTouchEnded(touch,event)
        local gl=self:locationConverToGl(touch)
        local parent=self:getParent()
        parent:setRubberEndPoint(gl)
        
        --划线完成
        self.touchBegin=false
--        print("onTouchEnded: %0.2f, %0.2f", gl.x, "    ",gl.y)
    end
    listener=cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher=touchLayer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,touchLayer)
end

function TouchLayer:touchLayerEnabled(enabled)
	listener:setEnabled(enabled)
end

function TouchLayer:locationConverToGl(touch)
    local location=touch:getLocation()
--    local glp=cc.Director:getInstance():convertToGL(location)
    return location
end

return TouchLayer