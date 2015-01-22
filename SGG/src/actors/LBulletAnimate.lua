require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"

LBulletAnimate = class ("LBulletAnimate", function (name)
    local bullet = SGGBulletSprite:create(name)
    bullet:setCascadeColorEnabled(true)
    return bullet
end)

function LBulletAnimate:ctor()
    self.actionTable={}
    self.hitDistance=20
    self.changeDamage=0
    self.monsterType=EnumRaceType.BULLET
end

function LBulletAnimate.create(data)
    local lbullet = LBulletAnimate.new(data.bulletInfo.pic)
    local Info={bulletInfo=data}  
    copyTable(Info,lbullet)
    lbullet:createAnimate(data)
    lbullet:initWithData(data)
    
    local tempWidth=lbullet:getContentSize().width/2
    local distance=data.monsterSize.height/2
    local point=cc.p(data.beginPoint.x,data.beginPoint.y-distance)
    lbullet:setPosition(point)
    return lbullet
end

function LBulletAnimate:initWithData(data)
    local size=self:getContentSize()
    self.spriteSize=size
    local boundBoy=cc.PhysicsBody:createCircle(self.spriteSize.width/2)
    --农田位于碰撞第八组
    boundBoy:setDynamic(true);
    boundBoy:setGravityEnable(false);
    boundBoy:getShape(0):setGroup(BattleGroup.BulletGroup)

    boundBoy:getShape(0):setRestitution(1.0)
    --设置物体的摩擦力
    boundBoy:getShape(0):setFriction(0.0)
    --设置物体密度
    boundBoy:getShape(0):setDensity(1.0)
    boundBoy:setCategoryBitmask(0x0010)
    boundBoy:setCollisionBitmask(0x0010)
    boundBoy:setContactTestBitmask(0x0010)

    local distance=data.monsterSize.height/2
    local bPoint=cc.p(data.beginPoint.x,data.beginPoint.y-distance)
    local ePoint

    if data.isRandom==1 then
        ePoint=BattleUtils.getRandomWarriorrPoint(self.spriteSize)
        --        ePoint=cc.p(ePoint.x,ePoint.y-distance)
    else
        ePoint=cc.p(data.targetPoint[1],data.targetPoint[2])    
    end
    self.ePoint=ePoint
    local tempData=data.bulletInfo
    local velocity=tempData.velocity
    local aVelocity=tempData.angularVelocity

    local bulletAngle=-(getGLAngle(ePoint.x,ePoint.y,bPoint.x,bPoint.y))
    self.bulletAngle=bulletAngle
    local force=cc.p(getBulletVelocityRatio(bulletAngle,velocity))
    --    local offsetImpulse=cc.p(tempData.rotatex,tempData.rotatey)
    --    boundBoy:applyImpulse(force,offsetImpulse)ss
    boundBoy:setVelocity(force)
    boundBoy:setAngularVelocity(aVelocity)
    
    local rAngle=getVelocityAngle(force.x,force.y)
    
    self:setRotation(bulletAngle-90)
    self:playAnimation("fly",true)
    self:setPhysicsBody(boundBoy)
end


function LBulletAnimate:playAnimation(name, loop)
    local actionTable=self.actionTable

    if self.actionTable==nil then
        return
    end
    if self.curAnimationName ~= name then --using name to check which animation is playing
        self:stopAllActions()
        if loop then
            self.curAnimation=cc.RepeatForever:create(self.actionTable[name]:clone())
        else
            self.curAnimation = self.actionTable[name]:clone()
        end
        self:runAction(self.curAnimation)
        self.curAnimationName = name
    end
end

function LBulletAnimate:createAnimate(data)
    local name=data.bulletInfo.name
    local animateNamefly=name.."_".."fly"
    local animateNamehit=name.."_".."hit"
    local animateNameplume=name.."_".."plume"

    self.actionTable={
        fly = GameAU.GameBeseAnimate(animateNamefly,false,0.1),
        hit = GameAU.GameBeseAnimate(animateNamehit,false,0.1),
        plume = GameAU.GameBeseAnimate(animateNameplume,false,0.1),    
    }
end



function LBulletAnimate:attackUpdate(hurtTarget)
    local velocity=self:getPhysicsBody():getVelocity();
    local angle=getVelocityAngle(velocity.x,velocity.y)
    local distance=self.spriteSize.width/2+self.hitDistance
    local addPoint=getAngleDistance(angle,distance)

    local moveToP=cc.pAdd(getPosTable(self),addPoint)
    --动画的终点坐标
    local newbulletInfo={}
    copyTable(self.bulletInfo,newbulletInfo)
    if self.changeDamage~=0 then
        newbulletInfo["damage"]=self.changeDamage
        self.changeDamage=0
    end

    newbulletInfo["angle"]=angle
    newbulletInfo["addPoint"]=moveToP
    newbulletInfo["mask"]=EnumAttackType.ENEMY
    newbulletInfo["monsterType"]=self.monsterType
    self:normalAttack(hurtTarget,newbulletInfo)
end

function LBulletAnimate:reboundEnd()
    self:playAnimation("hit",true)
    if self.bulletInfo.bulletInfo.isAnimate==true then
        local hurtEffect =cc.Sprite:create()
        local animation=self.actionTable.plume:clone()
        hurtEffect:runAction(cc.Sequence:create(animation, cc.RemoveSelf:create()))
--        local p=cc.p(self.spriteSize.width/2,self.spriteSize.height/2)
        local p=getPosTable(self)
        hurtEffect:setPosition(p)
        gameCurrentLayer:addChild(hurtEffect)
    end
    
    local aVelocity=self.bulletInfo.bulletInfo.reboundangularVelocity
    local boundBoy=self:getPhysicsBody()
    boundBoy:setAngularVelocity(aVelocity)
end

function LBulletAnimate:normalAttack(hurtTarget,collider)
    LBulletNormalAttack.create(getPosTable(self), 0,collider, hurtTarget)
end

function LBulletAnimate:specialAttack(hurtTarget)

end

function LBulletAnimate:removeEndBullet()
    self:removeBullet()
    self:getPhysicsBody():removeFromWorld()
    self:removeFromParent()
end

return LBulletAnimate