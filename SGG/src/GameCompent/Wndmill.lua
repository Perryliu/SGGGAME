require "Cocos2d"

--//////////////////////攻击类型/////////////////////////////////////
EnumWndmillType = 
    { 
        "WndmillType1",          --只能攻击农场
        "WndmillType2",             --攻击所有敌人和中立怪
        "WndmillType3",              --只攻击boss
    }

EnumWndmillType = CreateEnumTable(EnumWndmillType)     
--//////////////////////攻击类型/////////////////////////////////////

Wndmill = class ("Wndmill", function ()
    local node = cc.Node:create()
    node:setCascadeColorEnabled(true)
    return node
end)


function Wndmill:ctor()

end

function Wndmill.create(type)
    local wndmill = Wndmill.new()   
    wndmill:initWithData(type)
    return wndmill
end


function Wndmill:initWithData(type)

    local wndmillBlades
    local house=cc.Sprite:create("battleHouse.png")
   
    if type==EnumWndmillType.WndmillType1 then
        wndmillBlades=cc.Sprite:create("windmillBlades2.png")
        house:setScale(0.9)
        wndmillBlades:setPosition(cc.p(0,100))
    elseif type==EnumWndmillType.WndmillType2 then
         wndmillBlades=cc.Sprite:create("windmillBlades3.png")
        house:setScale(0.9)
        wndmillBlades:setPosition(cc.p(0,100))
    elseif type==EnumWndmillType.WndmillType3 then
        wndmillBlades=cc.Sprite:create("windmillBlades1.png")
        house:setScale(1.1)
        wndmillBlades:setPosition(cc.p(0,120))           
    end
    local rotateAction=cc.RotateBy:create(4,360)
    local rf=cc.RepeatForever:create(rotateAction)
        
    wndmillBlades:runAction(rf)
    self:addChild(wndmillBlades,1)
    self:addChild(house,-1)
    
end