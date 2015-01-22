require "Cocos2d"

--type

local Pi2=6.2831852
local flyActionTag=100

Honey = class ("Honey", function ()
    local node = cc.Node:create()
    --    node:setCascadeColorEnabled(true)
    return node
end)

function Honey:ctor()

    self.flyTime=0

    --椭圆a长半轴
    self.a=0
    --椭圆b短半轴
    self.b=0
    self.angle=0
    self.movePoint=nil
    --是否逆时针运动
    self.moveInAnticlockwise=false;
    --zorder
    self.ZFirstOrder=1
    self.ZSecondOrder=2
    self.isLeft=true
    self.isShow=false
    
end

function Honey.create(data)
    local honey = Honey.new()  
    copyTable(data,honey)
    honey:setPosition(data.point)
    honey:iniWithData(data)
    
    return honey
end

function Honey:iniWithData(data)
    local png=data.m..".".."png"

    self.honeySprite=cc.Sprite:createWithSpriteFrameName(png)
    self:addChild(self.honeySprite)
    
    local name=data.m.."Bee"
    local animateName=name.."_".."atk"
    local animation=GameAU.GameAnimate(animateName,false,true,0.1)
    self.honeySprite:runAction(animation)   
    
end

function Honey:setSpriteFippedx(isF)
    self.honeySprite:setFlippedX(isF)
end

function Honey:getPositionXAtOval(t)
    if self.moveInAnticlockwise==true then
        return self.a*math.cos(Pi2*(1-t))
     else
        return self.a*math.cos(Pi2*t)
     end
end

function Honey:getPositionYAtOval(t)
    if self.moveInAnticlockwise==true then
        return self.b*math.sin(Pi2*(1-t))
    else
        return self.b*math.sin(Pi2*t)
    end
end

local function honeyMoveCallBack(sender)
    sender:restHoneyRotation()
        
end

local function honeyComeCallBack(sender)
    sender.honeySprite:setFlippedY(false)
    sender:setVisible(false)
    sender.isShow=false
    sender:restHoneyRotation()

end

function Honey:setHoneyRotation(bPoint,ePoint,angle)
    local angle=getGLAngle(bPoint.x,bPoint.y,ePoint.x,ePoint.y)
    angle=-angle-180
    self.angle=angle
    self:setRotation(angle)
end

function Honey:restHoneyRotation()
    self:setRotation(0)
end

function Honey:update(t)
--    self.flyTime=self.flyTime+0.02

    self.flyTime=t
    if self.honeySprite then
        local x=self:getPositionXAtOval(self.flyTime)
        local y=self:getPositionYAtOval(self.flyTime)
        local position=cc.p(self.point.x+x,self.point.y+y)
        self.movePoint=position
    end
end

--蜜蜂飞去目标
function Honey:moveTo(p1,p2)
    self:setVisible(true)
    self.isShow=true
    self:setHoneyRotation(p1,p2)

    local moveCall=GameAU.GameActionMoveEaseCallBack(p1,p2,120,honeyMoveCallBack,animationEaseType.SpriteEaseSineOut)
    self:runAction(moveCall)

end

--蜜蜂飞回目标之后隐藏
function Honey:comeBack(p1,p2)
    local point=self.point
    self:setHoneyRotation(p1,p2)
    
    self.honeySprite:setFlippedY(true)
    local moveCall=GameAU.GameActionMoveEaseCallBack(p1,p2,120,honeyComeCallBack,animationEaseType.SpriteEaseSineOut)
    self:runAction(moveCall)
end

return Honey