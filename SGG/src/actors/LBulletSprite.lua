require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"

LBulletSprite = class ("LBulletSprite", function (name)
    local bullet = SGGBulletSprite:create(name)
    bullet:setCascadeColorEnabled(true)
    return bullet
end)

function LBulletSprite:ctor()
    --暂停模式反弹次数
    self.reboundTimes=1
    
    self.hitDistance=20
    self.changeDamage=0
    self.monsterType=EnumRaceType.BULLET
end

function LBulletSprite.create(data)
    local lbullet = LBulletSprite.new(data.bulletInfo.pic)
    local Info={bulletInfo=data}  
    copyTable(Info,lbullet)
    lbullet:initWithData(data)
    local tempWidth=lbullet:getContentSize().width/2
    local distance=data.monsterSize.height/2
    local point=cc.p(data.beginPoint.x,data.beginPoint.y-distance)
    lbullet:setPosition(point)
    return lbullet
end

function LBulletSprite:initWithData(data)
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
    
    self._velocity=velocity
    self._aVelocity=aVelocity
    
    
    local bulletAngle=-(getGLAngle(ePoint.x,ePoint.y,bPoint.x,bPoint.y))
    self.bulletAngle=bulletAngle
    local force=cc.p(getBulletVelocityRatio(bulletAngle,velocity))
--    local offsetImpulse=cc.p(tempData.rotatex,tempData.rotatey)
--    boundBoy:applyImpulse(force,offsetImpulse)ss
    boundBoy:setVelocity(force)
    boundBoy:setAngularVelocity(aVelocity)

    self:setPhysicsBody(boundBoy)
    
    
    local lp=require("LightSprite")
    self._LightSprite=lp.create(2)
    List.pushlast(LightSpriteManager,self._LightSprite)
    List.pushlast(LightModeBullet,self)
end

function LBulletSprite:attackUpdate(hurtTarget)
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

function LBulletSprite:reboundEnd()
    
end

function LBulletSprite:normalAttack(hurtTarget,collider)
    LBulletNormalAttack.create(getPosTable(self), 0,collider, hurtTarget)
end

function LBulletSprite:specialAttack(hurtTarget)

end

function LBulletSprite:removeEndBullet()
    --self:createBulletAction(self)
    List.removeObj(LightSpriteManager,self._LightSprite)
    List.removeObj(LightModeBullet,self)
    self._LightSprite:destroySelf()
    
    self:removeBullet()
    self:getPhysicsBody():removeFromWorld()
    self:removeFromParent()
    
end

function LBulletSprite:createBulletAction(sender)
    local function SPremoveCallBack(sender)
        sender:removeFromParent()
    end
    local sp = cc.Sprite:create("apple/123/baozha_1 (1).png")
    sp:setPosition(self:getPositionX(),self:getPositionY())
    self:getParent():addChild(sp)
    local cache=cc.SpriteFrameCache:getInstance()
    local animframes = {}
    for var=1,49 do
        
        local ImageStr=string.format("apple/123/baozha_1 (%d).png",var)
        local sp = cc.SpriteFrame:create(ImageStr,cc.rect(0,0,320,240))
        --local frame=cache:get(ImageStr)
        animframes[var-1]=sp
    
    end
    local animation=cc.Animation:createWithSpriteFrames(animframes)
    cc.AnimationCache:getInstance():addAnimation(animation,"AppleEffect")
    local act = cc.AnimationCache:getInstance():getAnimation("AppleEffect")
    local animantion=cc.AnimationCache:getInstance():getAnimation("AppleEffect")
    animantion:setDelayPerUnit(0.01)--一张图片跳到下一张的间隔
    animantion:setRestoreOriginalFrame(false)

    local action_mogu=cc.Animate:create(animantion);
    
    local seq = cc.Sequence:create(action_mogu,cc.CallFunc:create(SPremoveCallBack))
    sp:runAction(seq)
end

function LBulletSprite:updateLightSpritePoint(point)
    self._LightSprite:InitTexture(point)
end
return LBulletSprite