require "Cocos2d"

CommanApple = class ("CommanApple", function (name)
    local node = cc.Sprite:create(name)
    return node
end)



function CommanApple.create(name)
    local apple = CommanApple.new(name)
    apple:init()    
    return apple
end

function CommanApple:init()
   --self:setTexture(name)
--    self._appleSprite= cc.Sprite:create("apple.png")
--    --self:setPosition(cc.p(data.point[1],data.point[2]))
--    
--    self:addChild(self._appleSprite)
    local ratieSize=self:getContentSize().width/2;
    local ballBodyOne=cc.PhysicsBody:createCircle(ratieSize,cc.PhysicsMaterial(0.1, 0.5, 0.5));
    --所有子弹同一组不发生碰撞
    ballBodyOne:getShape(0):setGroup(11);
    --设置物体的恢复力
    ballBodyOne:getShape(0):setRestitution(1.0);
    --设置物体的摩擦力
    ballBodyOne:getShape(0):setFriction(0.0);
    --设置物体密度
    ballBodyOne:getShape(0):setDensity(1.0);
    --设置物体密度
    ballBodyOne:setDynamic(false);
    ballBodyOne:setGravityEnable(false);
    --同类发生碰撞
    ballBodyOne:setCategoryBitmask(0x0110);
    ballBodyOne:setCollisionBitmask(0x0110);
    --回调函数
    ballBodyOne:setContactTestBitmask(0x0110);
    self:setPhysicsBody(ballBodyOne)
end
function CommanApple:destroy()
	self:removeFromParent()
end

return CommanApple