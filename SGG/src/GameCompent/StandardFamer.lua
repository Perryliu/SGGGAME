require "Cocos2d"

StandardFamer = class ("StandardFamer", function (name)
    local node = cc.Sprite:create(name)
    return node
end)

function StandardFamer.create(name)
    local famer = StandardFamer.new(name)
    famer:init()    
    return famer
end

function StandardFamer:init()
    --self:setTexture(name)
    
    local ratieSize=self:getContentSize().width/4;
    local ballBodyOne=cc.PhysicsBody:createCircle(ratieSize,cc.PhysicsMaterial(0.1, 0.5, 0.5));
    --所有子弹同一组不发生碰撞
    ballBodyOne:getShape(0):setGroup(10);
    --设置物体的恢复力
    ballBodyOne:getShape(0):setRestitution(1);
    --设置物体的摩擦力
    ballBodyOne:getShape(0):setFriction(0.0);
    --设置物体密度
    ballBodyOne:getShape(0):setDensity(1.0);
    --local a=ballBodyOne:getShape(0):getMass()
   -- ballBodyOne:getShape(0):setMass(10000)
    --a=ballBodyOne:getShape(0):getMass()
    --设置物体密度
     local force=cc.vertex2F(0, -300);
   --    ballBodyOne:applyImpulse(force);
    ballBodyOne:setVelocity(force)
    ballBodyOne:setDynamic(true);
    ballBodyOne:setGravityEnable(true);
    --同类发生碰撞
    ballBodyOne:setCategoryBitmask(0x0110);
    ballBodyOne:setCollisionBitmask(0x0110);
    --回调函数
    ballBodyOne:setContactTestBitmask(0x0110);
    self:setPhysicsBody(ballBodyOne)
    
    self:initAnimation()
end
function StandardFamer:destroy()
    self:removeFromParent()
end
function StandardFamer:initAnimation()
    
   
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames("apple/famer.plist","apple/famer.png");
    --for i=1 ,5,1 do
        local animframes={} 
        for var=1,5,1 do
            local ImageStr=string.format("famer_jump_%s.png",var)
            local frame=cache:getSpriteFrame(ImageStr)
            animframes[var]=frame
        end
        --local annima=cc.Animation:createWithSpriteFrames(array,float,int)
        local animation=cc.Animation:createWithSpriteFrames(animframes)
        local animationStr=string.format("FamerJump")
        --                print("animationStr===",animationStr)
        cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
   -- end
    
    --for i=1 ,5,1 do
        local animframes={} 
        for var=1,3,1 do
            local ImageStr=string.format("famer_catch_%s.png",var)
            local frame=cache:getSpriteFrame(ImageStr)
            animframes[var]=frame
        end
        --local annima=cc.Animation:createWithSpriteFrames(array,float,int)
        local animation=cc.Animation:createWithSpriteFrames(animframes)
        local animationStr=string.format("FamerCatch")
        --                print("animationStr===",animationStr)
        cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
   -- end
   
end

function  StandardFamer:runJumpAction()
    
        local animation1 = cc.AnimationCache:getInstance():getAnimation("FamerJump");
        animation1:setDelayPerUnit(0.01)--一张图片跳到下一张的间隔
        animation1:setRestoreOriginalFrame(false)
        local animate1 = cc.Animate:create(animation1);
       

        local seq=cc.Sequence:create(animate1,animate1:reverse());
        famer:runAction(seq);
    
end


function StandardFamer:runCatchAction()
   
        
        local animation = cc.AnimationCache:getInstance():getAnimation("FamerCatch");
        animation:setDelayPerUnit(0.08)--一张图片跳到下一张的间隔
        animation:setRestoreOriginalFrame(false)
        local animate = cc.Animate:create(animation);
        local rep=cc.Repeat:create(animate,2);
        
        famer:runAction(rep)
   
end    
return StandardFamer