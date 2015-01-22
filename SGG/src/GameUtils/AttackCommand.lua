require "Helper"
require "GlobalVariables"
require "LayerManager"
require "LBulletSprite"


local CarrotMissileZorder=10


AttackManager = List.new()

local function getMonsterDistanceNearestFarm(NearestTargets)
    local function getAllMonster(sprite,list)
        local farmDitance=shortestDistanceOfFarmland(sprite)
        if farmDitance==nil then
        	return
        end
        sprite.farmDitance=farmDitance
        
        if List.getSize(list)~=0 then
            local tempSprite=list[0]
            if sprite.farmDitance<tempSprite.farmDitance then
                List.removeAll(list)
                List.pushlast(list,sprite) 
            elseif sprite.farmDitance==tempSprite.farmDitance then 
                List.pushlast(list,sprite)   
            end
        else
            List.pushlast(list,sprite)
        end            
    end
    
    for var=MonsterManager.first,MonsterManager.last do
        local sprite = MonsterManager[var]
        if sprite.isalive == true and sprite.monsterType~=EnumRaceType.NEUTRALMONSTER then
            getAllMonster(sprite,NearestTargets)    
        end
    end 

    for var = BossManager.first, BossManager.last do
        local sprite = BossManager[var]
        if sprite.isalive == true then
            getAllMonster(sprite,NearestTargets)    
        end
    end    
    
    return NearestTargets
end


local function getAnyHitMonster(NearestTargets)

    for var=MonsterManager.first,MonsterManager.last do
        local sprite = MonsterManager[var]
        if sprite.isalive == true and sprite.monsterType~=EnumRaceType.NEUTRALMONSTER then
            if isAllOutOfBound(sprite,getPosTable(sprite))==false then
                List.pushlast(NearestTargets,sprite)
            end
        end
    end 

    for var = BossManager.first, BossManager.last do
        local sprite = BossManager[var]
        if sprite.isalive == true then
            if isAllOutOfBound(sprite,getPosTable(sprite))==false then
                List.pushlast(NearestTargets,sprite)
            end
            List.pushlast(NearestTargets,sprite)
        end
    end    
end

--ratio 两个矩形碰撞的比例
local function isIntersectsRect(object1,object2,ratio)
    if object1==nil or object2==nil  then
        print("object1==nil or object2==nil")
    	return false
    end
    
    local object1Pos = cc.p(object1:getPosition())
    local object2Pos = cc.p(object2:getPosition())
    local object1Size=object1.spriteSize
    local object2Size=object2.spriteSize
    
    local object1MaxX=object1Pos.x+object1Size.width/2*ratio
    local object1MinX=object1Pos.x-object1Size.width/2*ratio
    local object1MaxY=object1Pos.y+object1Size.height/2*ratio
    local object1MinY=object1Pos.y-object1Size.height/2*ratio
    
    local object2MaxX=object2Pos.x+object2Size.width/2*ratio
    local object2MinX=object2Pos.x-object2Size.width/2*ratio
    local object2MaxY=object2Pos.y+object2Size.height/2*ratio
    local object2MinY=object2Pos.y-object2Size.height/2*ratio
    
    if (object1MaxX<object2MinX or object2MaxX<object1MinX 
    or object1MaxY<object2MinY or object2MaxY<object1MinY) then
        return false
    else
        return true
    end 
    
end

function solveAttacks(dt)
    for val = AttackManager.last, AttackManager.first, -1 do
        local attack = AttackManager[val]
        local apos = getPosTable(attack) 
        
        --目标攻击农场 
        if (attack.monsterType==EnumRaceType.MONSTER) or (attack.monsterType==EnumRaceType.BAERBOSS) then
            if attack.mask == EnumAttackType.FARMLAND then
                if attack.target then
                    attack:onCollide(attack.target)
                end
            end
        --子弹攻击目标    
        elseif (attack.monsterType==EnumRaceType.BULLET) then    
            attack:onCollide(attack.bulletTarget)
        --道具效果    
        elseif (attack.monsterType==EnumRaceType.PROPS) then 
            if attack.type==EnumPropskType.SINGLE then
                --是否追击
                if attack.isDOT==0 then
                    attack:onCollide(attack.target)
                else
                    --碰到目标触发效果
                    if isIntersectsRect(attack,attack.target,attack.ratio) then
                        attack:onCollide(attack.target)
                    end     
                end
            elseif attack.type==EnumPropskType.ANYTHING then
                if attack.isDOT==0 then
                    local targetList=List.new()
                    getAnyHitMonster(targetList)
                    attack:onCollide(targetList)   
                end          
            end               
        end
        attack.curDuration = attack.curDuration+dt
        if attack.curDuration > attack.duration then
            attack:onTimeOut()
            List.remove(AttackManager,val)
        else
            attack:onUpdate(dt)
        end
    end
end

BasicCollider = class("BasicCollider", function()
    local node = cc.Node:create()
    node:setCascadeColorEnabled(true)
    return node
end)

function BasicCollider:ctor()
    self.mask     = 1   
    self.duration = 0
    self.curDuration = 0
    self.damage   = 0
    self.facing    = 0 
    self.speed = 0 
    self.criticalChance = 0
    self.ratio=1
end
--callback when the collider has being solved by the attack manager, 
--make sure you delete it from node tree, if say you have an effect attached to the collider node
function BasicCollider:onTimeOut()
    self:removeFromParent()
end

function BasicCollider:playHitAudio()
--    ccexp.AudioEngine:play2d(CommonAudios.hit, false,0.7)
end

function BasicCollider:hurtEffect(target)

--    local hurtAction = cc.Animate:create(animationCache:getAnimation("hurtAnimation"))
--    local hurtEffect = cc.BillBoard:create()
--    hurtEffect:setScale(1.5)
--    hurtEffect:runAction(cc.Sequence:create(hurtAction, cc.RemoveSelf:create()))
--    hurtEffect:setPosition3D(cc.V3(0,0,50))
--    target:addChild(hurtEffect)  
end

function BasicCollider:onCollide(target)

    self:hurtEffect(target)
    self:playHitAudio()    
    target:hurt(self)
end

function BasicCollider:onUpdate()
-- implement this function if this is a projectile
end

function BasicCollider:initData(pos, facing, attackInfo)
    copyTable(attackInfo, self)

    self.facing = facing or self.facing
    self:setPosition(pos)
    List.pushlast(AttackManager, self)
    gameCurrentLayer:addChild(self, -10)
end

function BasicCollider.create(pos, facing, attackInfo)
    local ret = BasicCollider.new()    
    ret:initData(pos,facing,attackInfo)
    return ret
end

--普通近战怪物攻击
LMonsterNormalAttack = class("KnightNormalAttack", function()
    return BasicCollider.new()
end)

function LMonsterNormalAttack.create(pos,tagert, attackInfo, monster)
    local ret = LMonsterNormalAttack.new()
    ret:initData(pos,0,attackInfo)
    ret.owner = monster
    ret.target=tagert
    
    return ret
end

function LMonsterNormalAttack:hurtEffect(target)
--    print("LMonsterNormalAttack:hurtEffect")
end

function LMonsterNormalAttack:onCollide(target)
    self:hurtEffect(target)
    self:playHitAudio()  
    self.owner:atkEnd()  
    target:getParent():hurt(self)
end

function LMonsterNormalAttack:onTimeOut()
--    print("LMonsterNormalAttack:onTimeOut")
--    self.owner:dyingMode()
    self:removeFromParent()
    
end

--普通远程怪物攻击
LBulletNormalAttack = class("LBulletNormalAttack", function()
    return BasicCollider.new()
end)

function LBulletNormalAttack.create(pos,facing, attackInfo, monster)
    local ret = LBulletNormalAttack.new()
    ret:initData(pos,facing,attackInfo)
    ret.bulletTarget = monster
    return ret
end

function LBulletNormalAttack:hurtEffect(target)
    local hurtEffect =cc.Sprite:create("bulletEfact.png")
    hurtEffect:setScale(0.5)
    
    local ePoint=self.addPoint
    hurtEffect:setPosition(ePoint)
    local scaleto=cc.ScaleTo:create(0.1,1)
    local fadeout=cc.FadeOut:create(0.1)
    local spawn=cc.Spawn:create(scaleto, fadeout)
    
    hurtEffect:runAction(cc.Sequence:create(spawn, cc.RemoveSelf:create()))
    gameCurrentLayer:addChild(hurtEffect)  
end

function LBulletNormalAttack:onCollide(target)
    self:hurtEffect(target)
    self:playHitAudio()
--    print("LBulletNormalAttack:hurt")
    target:hurt(self,true)
end

function LBulletNormalAttack:onTimeOut()
--    print("LBulletNormalAttack:onTimeOut")
    self:removeFromParent()
end



-- ///////////////////////////道具／／／／／／／／／／／／／／／／／／／／／／／／／／／／
-- //////////////胡萝卜导弹/////////////////////////////////////
CarrotMissileAttack = class("CarrotMissileAttack", function()
    return BasicCollider.new()
end)


function CarrotMissileAttack.create(pos,facing,attackInfo)
    local ret = CarrotMissileAttack.new()
    ret:initData(pos,facing,attackInfo)
    ret:setLocalZOrder(CarrotMissileZorder)

    local NearestTargets=List.new()
    getMonsterDistanceNearestFarm(NearestTargets)

    local count=List.getSize(NearestTargets)
    if count==0 then
        ret:onTimeOut()
        List.removeObj(AttackManager,ret)
        return
    end

    local targer
    if count>1 then
        local var=BattleUtils.getRandomValue(count)
        var=math.floor(var)

        print("var")
        if var>count-1 then
            var=count-1
        end

        targer=NearestTargets[var]
    else
        targer=List.popfirst(NearestTargets)
    end

    ret.target = targer

    ret.sp = cc.Sprite:createWithSpriteFrameName("wenyiguang1.png")
    local animation=GameAU.GameAnimate("wenyiguang",false,true,0.1)
    ret.sp:runAction(animation)
    ret:addChild(ret.sp)
    ret.spriteSize=ret.sp:getContentSize()

    return ret
end

function CarrotMissileAttack:hurtEffect(target)
    local hurtEffect =cc.Sprite:create()
    local ePoint=getPosTable(target)
    hurtEffect:setPosition(ePoint)
    local animation=GameAU.GameAnimate("fadong",false,false,0.1)
    hurtEffect:runAction(cc.Sequence:create(animation, cc.RemoveSelf:create()))
    target:addChild(hurtEffect)  
end

function CarrotMissileAttack:onTimeOut()
    self:removeFromParent()
end

function CarrotMissileAttack:playHitAudio()

end

function CarrotMissileAttack:onCollide(target)

    self:hurtEffect(target)
    local p1=getPosTable(self)
    local p2=getPosTable(target)
    local hitAngle=getGLAngle(p2.x,p2.y,p1.x,p1.y)
    self.angle=hitAngle
    target:propsHurt(self,true)
    self.curDuration = self.duration+1
end

function CarrotMissileAttack:onUpdate(dt)
    local nextPos
    if self.target and self.target.isalive then
        local selfPos = getPosTable(self)
        local tpos = getPosTable(self.target)
        local angle = cc.pToAngleSelf(cc.pSub(tpos,selfPos))
        self:setRotation(angle)
        nextPos = cc.pRotateByAngle(cc.pAdd({x=self.speed*dt, y=0},selfPos),selfPos,angle)
        self:setPosition(nextPos)
    else
        self.curDuration = self.duration+1
    end

end
-- //////////////胡萝卜导弹/////////////////////////////////////


-- //////////////冰冻西瓜/////////////////////////////////////
FrozenWatermelonAttack = class("FrozenWatermelonAttack", function()
    return BasicCollider.new()
end)


function FrozenWatermelonAttack.create(pos,facing,attackInfo)
    local ret = FrozenWatermelonAttack.new()
    ret:initData(pos,facing,attackInfo)
    ret:setLocalZOrder(CarrotMissileZorder)
    return ret
end

function FrozenWatermelonAttack:hurtEffect(targetList)
    local hurtEffect =cc.Sprite:create()
    local ePoint=getPosTable(self)
    hurtEffect:setPosition(ePoint)
    local animation=GameAU.GameAnimate("reborn",false,false,0.1)
    
    hurtEffect:runAction(cc.Sequence:create(animation, cc.RemoveSelf:create()))
    hurtEffect:setScale(2.0)
    
    gameCurrentLayer:addChild(hurtEffect)  
end

function FrozenWatermelonAttack:onTimeOut()
    self:removeFromParent()
end

function FrozenWatermelonAttack:playHitAudio()
--    ccexp.AudioEngine:play2d(MageProperty.ice_normalAttackHit, false,1)
end

function FrozenWatermelonAttack:onCollide(targetList)
    print("FrozenWatermelonAttack")
    self:hurtEffect(targetList)
--    normalHit
--    target:hurt(self)
    for var=targetList.first,targetList.last do
        local sprite = targetList[var]
        if sprite.isalive == true then
            self.angle=90
            sprite:propsHurt(self,true)
        end
    end
end

function FrozenWatermelonAttack:onUpdate(dt)

end
-- //////////////冰冻西瓜/////////////////////////////////////

-- //////////////南瓜炸弹/////////////////////////////////////
CushawBomblonAttack = class("CushawBomblonAttack", function()
    return BasicCollider.new()
end)


function CushawBomblonAttack.create(pos,facing,attackInfo)
    local ret = CushawBomblonAttack.new()
    ret:initData(pos,facing,attackInfo)
    ret:setLocalZOrder(CarrotMissileZorder)
    return ret
end

function CushawBomblonAttack:hurtEffect(targetList)
    local hurtEffect =cc.Sprite:create()
    local ePoint=getPosTable(self)
    hurtEffect:setPosition(ePoint)
    local animation=GameAU.GameAnimate("expl",false,false,0.1)

    hurtEffect:runAction(cc.Sequence:create(animation, cc.RemoveSelf:create()))
    hurtEffect:setScale(4.0)
    local shakeAction=SGGShake:create(0.15,10);
    gameCurrentLayer:addChild(hurtEffect)  
    gameScene:runAction(shakeAction)
end

function CushawBomblonAttack:onTimeOut()
    self:removeFromParent()
end

function CushawBomblonAttack:playHitAudio()
--    ccexp.AudioEngine:play2d(MageProperty.ice_normalAttackHit, false,1)
end

function CushawBomblonAttack:onCollide(targetList)
    print("CushawBomblonAttack")
    self:hurtEffect(targetList)
    for var=targetList.first,targetList.last do
        local sprite = targetList[var]
        if sprite.isalive == true then
            self.angle=90
            sprite:propsHurt(self,true)
        end
    end
end

function CushawBomblonAttack:onUpdate(dt)

end
-- //////////////南瓜炸弹/////////////////////////////////////

-- //////////////种子/////////////////////////////////////
SeedSupply = class("SeedSupply", function()
    return BasicCollider.new()
end)


function SeedSupply.create(pos,facing,attackInfo,target)
    local ret = SeedSupply.new()
    ret:initData(pos,facing,attackInfo)
    ret:setLocalZOrder(CarrotMissileZorder)
    ret.target = target

    return ret
end

function SeedSupply:hurtEffect(target)
    local hurtEffect =cc.Sprite:create()
    local ePoint=getPosTable(target)
    hurtEffect:setPosition(ePoint)
    local animation=GameAU.GameAnimate("fuze",false,false,0.1)
    hurtEffect:setScale(2.0)
    hurtEffect:runAction(cc.Sequence:create(animation, cc.RemoveSelf:create()))
    target:getParent():addChild(hurtEffect)  
end

function SeedSupply:onTimeOut()
    self:removeFromParent()
end

function SeedSupply:playHitAudio()

end

function SeedSupply:onCollide(target)
    self:hurtEffect(target)
    target:getParent():hurt(self)
end

function SeedSupply:onUpdate(dt)

end


-- ///////////////////////////道具end／／／／／／／／／／／／／／／／／／／／／／／／／／／／
--
--
--BossNormal = class("BossNormal", function()
--    return BasicCollider.new()
--end)
--
--function BossNormal.create(pos,facing,attackInfo)
--    local ret = BossNormal.new()
--    ret:initData(pos,facing,attackInfo)
--
--    ret.sp = cc.BillBoard:create("FX/FX.png", RECTS.fireBall)
--    ret.sp:setPosition3D(cc.V3(0,0,48))
--    ret.sp:setScale(1.7)
--    ret:addChild(ret.sp)
--
--    return ret
--end
--
--function BossNormal:onTimeOut()
--    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5),cc.RemoveSelf:create()))
--
--    local magic = cc.ParticleSystemQuad:create(ParticleManager:getInstance():getPlistData("magic"))
--    local magicf = cc.SpriteFrameCache:getInstance():getSpriteFrame("particle.png")
--    magic:setTextureWithRect(magicf:getTexture(), magicf:getRect())
--    magic:setScale(1.5)
--    magic:setRotation3D({x=90, y=0, z=0})
--    self:addChild(magic)
--    magic:setGlobalZOrder(-self:getPositionY()*2+FXZorder)
--    magic:setPositionZ(0)
--    magic:setEndColor({r=1,g=0.5,b=0})
--
--    local fireballAction = cc.Animate:create(animationCache:getAnimation("fireBallAnim"))
--    self.sp:runAction(fireballAction)
--    self.sp:setScale(2)
--
--    Nova.create(getPosTable(self), self._curFacing)
--end
--
--function BossNormal:playHitAudio()
--    ccexp.AudioEngine:play2d(MonsterDragonValues.fireHit, false,0.6)    
--end
--
--function BossNormal:onCollide(target)
--    --set cur duration to its max duration, so it will be removed when checking time out
--    self.curDuration = self.duration+1
--end
--
--function BossNormal:onUpdate(dt)
--    local selfPos = getPosTable(self)
--    local nextPos = cc.pRotateByAngle(cc.pAdd({x=self.speed*dt, y=0},selfPos),selfPos,self.facing)
--    self:setPosition(nextPos)
--end
--
--BossSuper = class("BossSuper", function()
--    return BasicCollider.new()
--end)
--
--function BossSuper.create(pos,facing,attackInfo)
--    local ret = BossSuper.new()
--    ret:initData(pos,facing,attackInfo)
--
--    ret.sp = cc.BillBoard:create("FX/FX.png", RECTS.fireBall)
--    ret.sp:setPosition3D(cc.V3(0,0,48))
--    ret.sp:setScale(1.7)
--    ret:addChild(ret.sp)
--
--    return ret
--end
--
--function BossSuper:onTimeOut()
--    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5),cc.RemoveSelf:create()))
--
--    local magic = cc.ParticleSystemQuad:create(ParticleManager:getInstance():getPlistData("magic"))
--    local magicf = cc.SpriteFrameCache:getInstance():getSpriteFrame("particle.png")
--    magic:setTextureWithRect(magicf:getTexture(), magicf:getRect())
--    magic:setScale(1.5)
--    magic:setRotation3D({x=90, y=0, z=0})
--    self:addChild(magic)
--    magic:setGlobalZOrder(-self:getPositionY()*2+FXZorder)
--    magic:setPositionZ(0)
--    magic:setEndColor({r=1,g=0.5,b=0})
--
--    local fireballAction = cc.Animate:create(animationCache:getAnimation("fireBallAnim"))
--    self.sp:runAction(fireballAction)
--    self.sp:setScale(2)
--
--    Nova.create(getPosTable(self), self._curFacing)
--end
--
--function BossSuper:playHitAudio()
--    ccexp.AudioEngine:play2d(MonsterDragonValues.fireHit, false,0.6)    
--end
--
--function BossSuper:onCollide(target)
--    --set cur duration to its max duration, so it will be removed when checking time out
--    self.curDuration = self.duration+1
--end
--
--function BossSuper:onUpdate(dt)
--    local selfPos = getPosTable(self)
--    local nextPos = cc.pRotateByAngle(cc.pAdd({x=self.speed*dt, y=0},selfPos),selfPos,self.facing)
--    self:setPosition(nextPos)
--end

return AttackManager