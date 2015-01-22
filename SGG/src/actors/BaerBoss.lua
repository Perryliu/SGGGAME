require "Cocos2d"
require "GameBattleUtils"
require "Data_Level"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"
--type

local atkAngle=45

BaerBoss = class ("BaerBoss", function (data)
    return require "Animal".create()
end)

local function bulletHitEnd(sender)
    print("bulletHitEnd")
    sender.hiting=false
    sender.honeyHiting=false
    sender:movementUpdate()
end

function BaerBoss:ctor()

    self.isMove=true
    self.honeyHiting=false
    self.monsterType=EnumRaceType.BAERBOSS
    self.atking=false
end

function BaerBoss.create(data)
    local bear = BaerBoss.new()  
    copyTable(data,bear)
    
    local point=DirectorUtils.setPhoneFourPosition(cc.p(bear.point[1],bear.point[2]))
    bear:setPosition(point)

    bear.myPos=getPosTable(bear)
    bear:createAnimate()

    bear.AIEnabled=true
    bear:initWithData()
    bear:initWithProgressBar()
    bear:walkMode() 
    return bear
end

function BaerBoss:initWithData()
    local pic=self.m..".png"
    self.monsterSprite=cc.Sprite:createWithSpriteFrameName(pic)
    self:addChild(self.monsterSprite)
    self.spriteSize=self.monsterSprite:getContentSize()

    --增加碰撞刚体
    local pb=self:getMonsterPhysicsCircle()
    self.monsterSprite:setPhysicsBody(pb)

    self.curSpeed=self.movespeed
    self.normalSpeed=self.movespeed 
    local p2=cc.p(self.endpoint[1],self.endpoint[2])
    self.endpoint=p2
    self.curEndPoint=self.endpoint
    self.recoverTime=self.hitDistance/self.hitMoveSpeed
    print("self.recoverTime==",self.recoverTime)
    local atkMask = self.normalAtk["mask"]
    local target = nil
    if atkMask == EnumAttackType.FARMLAND then
        if farmland then
            self:setTarget(farmland)
        end
    else
        self:setTarget(nil)    
    end
    
--    self.line=DrawScratchLine:create()
--    self.line:setVisible(false)
--    self.line:restDrawPoint()
--    self:addChild(self.line)
    
--    self.line:setVisible(true)
--    self.line:setS_beginPoint(cc.p(0,0))
--    self.line:setS_endPoint(cc.p(0,0))
end

function BaerBoss:createAnimate()
    local animateNameunder1=self.m.."_".."under"
    local animateNameunder2=self.m.."_".."underbee"
    local animateNameroot=self.m.."_".."foot"
    local animateNamedie=self.m.."_".."die"

    local actionInterval=getMonsterInfo(self.m)        
    self.actionTable={
        walk = GameAU.GameBeseAnimate(animateNameroot,false,actionInterval.die),
        knocked = GameAU.GameBeseAnimate(animateNameunder1,false,actionInterval.under),
        knockedBee = GameAU.GameBeseAnimate(animateNameunder2,false,actionInterval.underbee),
        dead = GameAU.GameBeseAnimate(animateNamedie,false,actionInterval.foot),    
    }
end

function BaerBoss:updateState()
    local function update(dt)
        self:baseUpdate(dt)
        self:stateMachineUpdate(dt)
        self:movementUpdate(dt)
    end
    self:scheduleUpdateWithPriorityLua(update, 0)
end


function BaerBoss:attackUpdate(dt)
    if self.atking==false then
        print("attackUpdate")
        self:normalAttack()
        self.atking=true
    end
end

function BaerBoss:knockMode(collider, dirKnockMode)
    
    if self.knockAction then
        self:stopAction(self.knockAction)
    end
    

    self:setStateType(EnumStateType.KNOCKING)
    
    if collider.monsterType==EnumRaceType.HONEYBEE then
        self:playAnimation("knockedBee")
    else 
        self:playAnimation("knocked")
    end
    
    self.timeKnocked = self.aliveTime
    if dirKnockMode==false then
        return
    end
    local p = self.myPos
    local angle=collider.angle 
    local addPos=getAngleDistance(angle,self.hitDistance)
    local newPos=cc.pAdd(p,addPos)
    self:moveFlipped(newPos,p)
--    self.line:setS_beginPoint(p)
--    self.line:setS_endPoint(newPos)
    --    local newPos = cc.pRotateByAngle(cc.pSub({x=10,y=0}, p),p,angle)
    self.knockAction=cc.EaseCubicActionOut:create(cc.MoveTo:create(self.recoverTime,newPos))
    self:runAction(self.knockAction)
end

function BaerBoss:dyingMode(knockSource, knockAmount)
    --    print("dyingMode")
    self:setStateType(EnumStateType.DYING)
    self.isalive=false
    self.AIEnabled=false

    List.removeObj(MonsterManager,self) 
    if self.monsterSprite:getPhysicsBody() then
        self.monsterSprite:getPhysicsBody():removeFromWorld();
    end

    local function removeMonster()
        self:removeFromParent()
        
        if self.atking then
            if gameMaster then
                gameMaster:lostGameOver()
            end 
        else
            self:removeFormGame()    
        end
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
        local knockAction=cc.EaseCubicActionOut:create(cc.MoveTo:create(self.actionTable.knockedBee:getDuration()*1.5,newPos))
        self:runAction(knockAction)
    end
end

--一般攻击
function BaerBoss:normalAttack()
    self.normalAtk["monsterType"]=self.monsterType
    LMonsterNormalAttack.create(getPosTable(self), self.target,self.normalAtk, self)
end

function BaerBoss:AI()
    if self.isalive then
        --加速处理
        if self.slowdownTime>0 then
            if self.aliveTime>self.slowdownTime then
                self.movespeed=self.normalSpeed 
                self.slowdownTime=0
            end     
        end
    
        if self.target then
            if isMonsterAtkFarmland(self,self.target) then
                self:attackMode()
            end
        end
    end
end

function BaerBoss:knockingUpdate(dt)
    if self.aliveTime - self.timeKnocked > self.recoverTime then
        --i have recovered from a knock
        self.timeKnocked = nil

        self:walkMode()
        self.honeyHiting=false
    end
end

function BaerBoss:movementUpdate(dt)

    if self:getStateType() ~= EnumStateType.WALKING then
        --不是走路状态减速
        self.curSpeed = cc.clampf(self.curSpeed - self.decceleration*dt, 0, self.movespeed)
        if isOutOfBound(self,self.myPos) then
            if self.knockAction then
                self:stopAction(self.knockAction)
            end
            self:walkMode()
        end
        
    elseif self.curSpeed < self.movespeed then
        --走路状态加速
        self.curSpeed = cc.clampf(self.curSpeed + self.acceleration*dt, 0, self.movespeed)
    end
    
    if self.curSpeed > 0 then
        local p1 = self.myPos
        local angle = cc.pToAngleSelf(cc.pSub(self.curEndPoint,p1))
        --        print("angle====",angle)
        local nextPos = cc.pRotateByAngle(cc.pAdd({x=self.curSpeed*dt,y=0},p1),p1,angle)
        self:setPosition(nextPos)
        --        print("nextPos===",nextPos.x.."y=="..nextPos.y)
    end
    --    print("self.curSpeed===",self.curSpeed)
end

function BaerBoss:atkEnd()
    self:dyingMode()
end

function BaerBoss:hurt(collider,dirKnockMode)
    if self.isalive == true then 
        self.honeyHiting=true
--        self.line:setS_beginPoint(cc.p(0,0))
--        self.line:setS_endPoint(cc.p(0,0))
        
        if collider.monsterType==EnumRaceType.BULLET then
            local targetPos=self.myPos
            local cPoint=getPosTable(collider)           
            local angle=getGLAngle(targetPos.x,targetPos.y,cPoint.x,cPoint.y)
            collider.angle=angle
            
        	self:knockMode(collider,dirKnockMode)
        	return 0   
        end
        local isLeft = collider.isLeft
        local angle=-BattleUtils.getRandomValue(atkAngle)
        
        if isLeft==false then
            angle=angle-90
        end  
        collider["angle"]=angle    
        local damage = collider.damage
        self.hp = self.hp - damage
        self.progressBar:progressTo(-damage)
        if self.hp > 0 then
            self:knockMode(collider,dirKnockMode)    
        else
            self.hp = 0
            self.isalive = false
            self:dyingMode(collider,dirKnockMode)  
        end

        return damage        
    end
    return 0
end

function BaerBoss:removeFormGame()
    --减少一个怪物
    gameMaster:addEnemies(-1)
end

return BaerBoss