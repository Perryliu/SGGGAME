require "Cocos2d"


MessageDispatchCenter={}


MessageDispatchCenter.MessageType = {
    
    REMOVE_MONSTER = "REMOVE_MONSTER",
    --GameOver
    GAME_OVER = "GAME_OVER",
}


MessageDispatchCenter.MessageQue = {}
MessageDispatchCenter.EventQue = {}

function MessageDispatchCenter:new(o)
	o=o or {}
	setmetatable(o,self)
	self.__index=self
	return o
end 

function MessageDispatchCenter:getInstance()  
    if self.instance == nil then  
        self.instance = self:new()  
    end  
    return self.instance  
end  

--/////////////////////////////注册回调函数处理战斗数据/////////////////////////////////
function MessageDispatchCenter:registerMessage(messageType,callback)
    --if param is valid
    if self.MessageType[messageType] == nil or type(callback) ~= "function" then
        print("param is invalid")
        return
    end
    
    --add message to messageQue
    if self.MessageQue[messageType] == nil then
        self.MessageQue[messageType] = {}
    end
    local index = table.getn(self.MessageQue[messageType])
    self.MessageQue[messageType][index+1] = callback
end

function MessageDispatchCenter:dispatchMessage(messageType,param)
    --if param is valid
    if self.MessageType[messageType] == nil then
        print("param is invalid")
        return
    end

    --callback
    if self.MessageQue[messageType] == nil then
        return
    end
    for i,v in pairs(self.MessageQue[messageType]) do
        v(param)
    end
end

function MessageDispatchCenter:removeMessage(messageType,callback)
    --if param is valid
    if self.MessageType[messageType] == nil or type(callback) ~= "function" then
        print("param is invalid")
        return
    end

    --remove callback
    for i,v in pairs(self.MessageQue[messageType]) do
        if callback == v then
            table.remove(self.MessageQue[messageType],i)
            return
        end
    end
end

--/////////////////////////////注册回调函数处理战斗数据/////////////////////////////////

--/////////////////////////////注册监听事件 c++ 回调/////////////////////////////////

local function dispatchCustiomEvent(event)
    local messageType=event:getEventName()
    local param=event:getObject()
    MessageDispatchCenter:getInstance():dispatchMessage(messageType,param)
end

function MessageDispatchCenter:registerCustiomEvent(messageType,callback)
    --if param is valid
    if self.MessageType[messageType] == nil or type(callback) ~= "function" then
        print("registerCustiomEvent param is invalid")
        return
    end

    --add message to messageQue
    local listener=cc.EventListenerCustom:create(messageType,dispatchCustiomEvent)
    self.EventQue[messageType]=listener
    
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithFixedPriority(listener, 1)
    
    self:registerMessage(messageType,callback)
end

function MessageDispatchCenter:removeCustiomEvent(messageType,callback)
    --if param is valid
    if self.EventQue[messageType] == nil then
        print("removeCustiomEvent messageType is invalid")
        return
    end
    --remove CustiomEvent
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:removeEventListener(self.EventQue[messageType])
    self.EventQue[messageType] = nil
    self:removeMessage(messageType,callback)
end
--/////////////////////////////注册坚挺事件 c++ 回调/////////////////////////////////
