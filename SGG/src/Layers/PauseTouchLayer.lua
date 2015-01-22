require"Cocos2d"
require "Cocos2dConstants"

local PauseTouchLayer =class("PauseTouchLayer",function()
	return cc.Layer:create();
end)

local listener=cc.EventListenerTouchOneByOne:create()

function PauseTouchLayer:ctor()
    self.touchBegin=false
end

function PauseTouchLayer.create()      
    local layer=PauseTouchLayer.new()
	layer:addTouchListener(layer)
	return layer
end


function PauseTouchLayer:addTouchListener(touchLayer)
    local function onTouchBegan(touch,event)
        if pauseMonster==true then
            local gl=self:locationConverToGl(touch)
            local parent=self:getParent()
            parent:setRubberBeginPoint(gl)
            --        print("onTouchBegan: %0.2f, %0.2f", gl.x,"    ", gl.y)    
            return true
        else
            return false
        
        end
        
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
        
--        print("onTouchEnded: %0.2f, %0.2f", gl.x, "    ",gl.y)
    end
    listener=cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher=touchLayer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,touchLayer)
end

function PauseTouchLayer:touchLayerEnabled(enabled)
	listener:setEnabled(enabled)
end

function PauseTouchLayer:locationConverToGl(touch)
    local location=touch:getLocation()
--    local glp=cc.Director:getInstance():convertToGL(location)
    return location
end

return PauseTouchLayer