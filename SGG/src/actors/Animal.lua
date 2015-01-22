require "Helper"
require "AttackCommand"
--type
require "Cocos2d"
require "Data_Monster"

Animal = class ("Animal", function ()
    local node = cc.Node:create()
    node:setCascadeColorEnabled(true)
    return node
end)

local knockActionTag=200

function Animal:ctor()
    self.actionTable = {}
    self.isalive = true
    self.monsterHeight = 70
    self.heroHeight = 150
    self.acceleration=9999
    self.decceleration=9999
    self.AIFrequency=1.0
    self.AITimer=0
    self.aliveTime=0
    self.timeKnocked=0
    self.recoverTime=0.8
    self.hitDistance=20
    self.dieDistance=60
    self.normalSpeed=0
    self.slowdownTime=0
    self.flippedRigth=false
end

function Animal.create()
    local base = Animal.new()    
    return base
end

function Animal:playAnimation(name, loop)
    local actionTable=self.actionTable

    if self.actionTable==nil then
    	return
    end
    if self.curAnimationName ~= name then --using name to check which animation is playing
        self.monsterSprite:stopAllActions()
        if loop then
            self.curAnimation=cc.RepeatForever:create(self.actionTable[name]:clone())
        else
            self.curAnimation = self.actionTable[name]:clone()
        end
        self.monsterSprite:runAction(self.curAnimation)
        self.curAnimationName = name
    end
end

function Animal:initWithProgressBar()
    local progressBg = cc.Sprite:create("SGprogressbg.png");
    local progress=cc.Sprite:create("SGprogrss.png");

    self.progressBar= ProgressBar:create(progress);
    self.progressBar:setScaleX(self.spriteSize.width/progress:getContentSize().width);
    self.progressBar:setBackground(progressBg);

    self.progressBar:setC_Hp(self.hp);
    self.progressBar:setCurcentHp(self.hp);

    local pbPoint=cc.p(0,self.spriteSize.height/2+8);
    self.progressBar:setPosition(pbPoint);
    self.progressBar:setPercentage(100);
    self:addChild(self.progressBar);

end

--矩形刚体
function Animal:getMonsterPhysicsBody()
    
    local ratieSize=cc.size(self.spriteSize.width*0.65,self.spriteSize.height*0.65)
    local boundBoy=cc.PhysicsBody:createBox(ratieSize,cc.PhysicsMaterial(0.1, 0.5, 0.5))
    
    boundBoy:setDynamic(false);
    boundBoy:setGravityEnable(false);
    boundBoy:getShape(0):setGroup(BattleGroup.MonsterGroup)

    boundBoy:getShape(0):setRestitution(1.0)
    --设置物体的摩擦力
    boundBoy:getShape(0):setFriction(0.0)
    --设置物体密度
    boundBoy:getShape(0):setDensity(1.0)
    boundBoy:setCategoryBitmask(0x0001)
    boundBoy:setCollisionBitmask(0x0001)
    boundBoy:setContactTestBitmask(0x0001)
--    boundBoy:retain()
   
    return boundBoy
end

--圆形刚体
function Animal:getMonsterPhysicsCircle()

--    local ratieSize=cc.size(self.spriteSize.width*0.65,self.spriteSize.height*0.65)
    local boundBoy=cc.PhysicsBody:createCircle(self.spriteSize.width/2*0.65)

    boundBoy:setDynamic(false);
    boundBoy:setGravityEnable(false);
    boundBoy:getShape(0):setGroup(BattleGroup.MonsterGroup)

    boundBoy:getShape(0):setRestitution(1.0)
    --设置物体的摩擦力
    boundBoy:getShape(0):setFriction(0.0)
    --设置物体密度
    boundBoy:getShape(0):setDensity(1.0)
    boundBoy:setCategoryBitmask(0x0001)
    boundBoy:setCollisionBitmask(0x0001)
    boundBoy:setContactTestBitmask(0x0001)
    --    boundBoy:retain()

    return boundBoy
end

-- get hero type
function Animal:getRaceType()
    return self.racetype
end

function Animal:setRaceType(type)
    self.racetype = type
end

function Animal:getStateType()
    return self.statetype
end


function Animal:setStateType(type)
    self.statetype = type
end


function Animal:setTarget(target)
    if self.target ~= target then
        self.target = target
    end
end


function Animal:getAIEnabled()
    return self.AIEnabled
end

function Animal:setAIEnabled(enable)
    self.AIEnabled = enable
end

function Animal:hurtSoundEffects()
-- to override
end

function Animal:normalAttackSoundEffects()
-- to override
end

function Animal:specialAttackSoundEffects()
-- to override
end

--======attacking collision check
function Animal:normalAttack()

end
function Animal:specialAttack()

end
--======State Machine switching functions
function Animal:idleMode() --switch into idle mode
    self:setStateType(EnumStateType.IDLE)
    self:pointFlipped(self.myPos)
    if self.m=="arm0011" then
        self:playAnimation("idle", true)
    else
        self:playAnimation("walk", true)    
    end    
end
function Animal:walkMode() --switch into walk mode
    self:setStateType(EnumStateType.WALKING)
    self:moveFlipped(self.myPos,self.curEndPoint)
    self:playAnimation("walk", true)
end
function Animal:attackMode() --switch into walk mode
    self:setStateType(EnumStateType.ATTACKING)
--    self:playAnimation("idle", true)
end

function Animal:deadMode()
--    print("deadMode")
    self:setStateType(EnumStateType.DEAD)
    self.isalive=false
    self.AIEnabled=false
end

function Animal:dyingMode(knockSource, knockAmount)
--    print("dyingMode")
    self:setStateType(EnumStateType.DYING)
    self.isalive=false
    self.AIEnabled=false
    
    List.removeObj(MonsterManager,self) 
    if self.monsterSprite:getPhysicsBody() then
        self.monsterSprite:getPhysicsBody():removeFromWorld();
    end
    
    local function removeMonster()
        --gameJudge:addMonsterDeadNum(self)
        
        if gameJudge.isKillMonsterCondition then
            gameJudge:addTargetMonsterDeadNum(self)
        end

        if gameJudge.isNotKillMonsterCondition then
            gameJudge:addNotKillMonsterDeadNum(self)
        end
        gameJudge:addMainMonsterDeadNum(self)
        
        
        
        self:removeFromParent()
        self:removeFormGame()
    end
    
    local deadAction=cc.Sequence:create(self.actionTable.dead:clone(),cc.CallFunc:create(removeMonster))
    self.monsterSprite:stopAction(self.curAnimation)
    self.monsterSprite:runAction(deadAction)
    
    if knockAmount then
        self:stopAllActions()
        local angle=knockSource.angle 
        local p = self.myPos
        local addPos=getAngleDistance(angle,self.dieDistance)
        local newPos=cc.pAdd(p,addPos)
        self:moveFlipped(newPos,p)
        local knockAction=cc.EaseCubicActionOut:create(cc.MoveTo:create(self.actionTable.knocked:getDuration()*1.5,newPos))
        self:runAction(knockAction)
    end
end


function Animal:knockMode(collider, dirKnockMode)

    if self.knockAction then
        self:stopAction(self.knockAction)
    end
    
    self:setStateType(EnumStateType.KNOCKING)
    self:playAnimation("knocked")
    self.timeKnocked = self.aliveTime
    if dirKnockMode==false then
    	return
    end
    local p = self.myPos
    local angle=collider.angle 
--    if dirKnockMode then
--        angle = collider.facing
--    else
--        angle = cc.pToAngleSelf(cc.pSub(p, getPosTable(collider)))
--    end
    local addPos=getAngleDistance(angle,self.hitDistance)
    local newPos=cc.pAdd(p,addPos)
    self:moveFlipped(newPos,p)
    
--    local newPos = cc.pRotateByAngle(cc.pSub({x=10,y=0}, p),p,angle)
    self.knockAction=cc.EaseCubicActionOut:create(cc.MoveTo:create(self.actionTable.knocked:getDuration()*0.8,newPos))
    self:runAction(self.knockAction)
end

function Animal:jumpMode(point)
    self:setStateType(EnumStateType.JUMPING)
--    self:playAnimation("knocked")
end

function Animal:playDyingEffects()
-- override
end

function Animal:findEnemy()
    local atkMask = self.normalAtk["mask"]
    local target = nil
    local allDead = true
    local manager = nil

    --    if atkMask == EnumAttackType.FARMLAND then
    --        target = farmland
    --    end
    return target, allDead
end

function Animal:AI()

end

function Animal:stateMachineUpdate(dt)
    local state = self:getStateType()
    if state == EnumStateType.WALKING  then
        self:walkUpdate(dt)
        
    elseif state == EnumStateType.IDLE then
    
    elseif state == EnumStateType.ATTACKING then
        self:attackUpdate(dt)
        
    elseif state == EnumStateType.DEFENDING then
    
    elseif state == EnumStateType.JUMPING then
        self:jumpUpdate(dt)
    elseif state == EnumStateType.KNOCKING then
        self:knockingUpdate(dt)
        
    elseif state == EnumStateType.DYING then

    end
end

function Animal:baseUpdate(dt)
    self.myPos = getPosTable(self)
    self.aliveTime = self.aliveTime+dt
    if self.AIEnabled then
        self.AITimer = self.AITimer+dt
        if self.AITimer > self.AIFrequency then
            self.AITimer = self.AITimer-self.AIFrequency
            self:AI()
        end
    end
end

function Animal:knockingUpdate(dt)
    if self.aliveTime - self.timeKnocked > self.recoverTime then
        --i have recovered from a knock
        self.timeKnocked = nil
--            if self:_inRange() then
--                self:attackMode()
--            else
            self:walkMode()
--            end
    end
end

function Animal:walkUpdate(dt)

    local endDistance=cc.pGetDistance(self.myPos,self.curEndPoint)
--    print("endDistance==",endDistance)
    if endDistance<5 then
    	self.move=false
    	self:idleMode()
    end    
end

function Animal:attackUpdate(dt)

end

function Animal:jumpUpdate(dt)

end


function Animal:hurt(collider,dirKnockMode)
    if self.isalive == true then 
        --        if self:getMonsterHitType()==EnumMonsterTypeHit.K_Monster_Type_Invincible_Hit then
        --            self:progressPercentageSetter(0.0,false);
        --            return 0;
        --        end

        local damage = collider.damage
--        print("damage===",damage)
        
        self.hp = self.hp - damage
        self.progressBar:progressTo(-damage)
        if self.hp > 0 then
            if self.monsterType==EnumRaceType.REMOTEMONSTER then
                --指引
                if beginnerGuide then
                    if beginnerGuide.guideId=="1001" then
                        beginnerGuide:openGuide()
                    end
                end
            
                if self.Shooting==false then
                    self:knockMode(collider,dirKnockMode)
                end
            else
                self:knockMode(collider,dirKnockMode)    
            end
        else
            self.hp = 0
            self.isalive = false
            self:dyingMode(collider,dirKnockMode)  
        end

        return damage        
    end
    return 0
end

function Animal:movementUpdate(dt)

    if self:getStateType() ~= EnumStateType.WALKING then
        --不是走路状态减速
        self.curSpeed = cc.clampf(self.curSpeed - self.decceleration*dt, 0, self.movespeed)
    elseif self.curSpeed < self.movespeed then
        --走路状态加速
        self.curSpeed = cc.clampf(self.curSpeed + self.acceleration*dt, 0, self.movespeed)
    end

    if self.curSpeed > 0 then
        local p1 = self.myPos
        local angle = cc.pToAngleSelf(cc.pSub(self.curEndPoint,p1))
        local nextPos = cc.pRotateByAngle(cc.pAdd({x=self.curSpeed*dt,y=0},p1),p1,angle)
        self:setPosition(nextPos)
    end
--    print("self.curSpeed===",self.curSpeed)
end

--翻转精灵
function Animal:setFlippedXWithSprite(isFlipped)

    if self.flippedRigth~=isFlipped then
        self.flippedRigth=isFlipped
        self.monsterSprite:setFlippedX(self.flippedRigth)
    end
end

function Animal:propsHurt(collider,dirKnockMode)
    if self.isalive == true then 
        local damage = collider.damage
        
            
        self.hp = self.hp - damage
        self.progressBar:progressTo(-damage)
        if self.hp > 0 then
--            slowdown=0.5,delay=5
            print(type(collider.slowdown))
            print(type(collider.delay))
            
            
            if type(collider.slowdown)=="number" and type(collider.delay)=="number"  then
                self.movespeed=self.normalSpeed*collider.slowdown
                self.slowdownTime=self.aliveTime+collider.delay
            end
                        
            if self.monsterType==EnumRaceType.REMOTEMONSTER then
                if self.Shooting==false then
                    self:knockMode(collider,dirKnockMode)
                end
            else
                self:knockMode(collider,dirKnockMode)    
            end
        else
            self.hp = 0
            self.isalive = false
            self:dyingMode(collider,dirKnockMode)  
        end

        return damage        
    end
    return 0
end


function Animal:removeFormGame()
    
end

function Animal:pointFlipped(pos)
    local rigth=GameAU.pointIsLeftOrRight(self,pos)
    self:setFlippedXWithSprite(rigth)        
end


function Animal:moveFlipped(bPos,ePos)
    local rigth=GameAU.GameActionLeftOrRight(bPos,ePos)
    self:setFlippedXWithSprite(rigth)        
end

function Animal:LeaveRemoveFormGame()

    self:setStateType(EnumStateType.DYING)
    self.isalive=false
    self.AIEnabled=false

    List.removeObj(MonsterManager,self) 

    if self.monsterSprite:getPhysicsBody() then
        self.monsterSprite:getPhysicsBody():removeFromWorld();
    end

    --离开减少怪物
    self:removeFromParent()
    self:removeFormGame()

end



return Animal