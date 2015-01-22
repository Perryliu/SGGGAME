
require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"

PRemoteMonster = class ("PRemoteMonster", function ()
    return require "Animal".create()
end)

function PRemoteMonster:ctor()

    self.monsterType=EnumRaceType.REMOTEMONSTER
    self.attackTimer=0
    self.attackFrequency=0
    self.Shooting=false
    
end
--是否开启暂停update
--pauseUpdate=false
function PRemoteMonster.create(data)
    local Rmoster =PRemoteMonster.new(data) 
    copyTable(data,Rmoster)
    Rmoster:setPosition(cc.p(Rmoster.point[1],Rmoster.point[2]))
    Rmoster.myPos=getPosTable(Rmoster)
    Rmoster:createAnimate()
    
    Rmoster.AIEnabled=true
    Rmoster:initWithData(data)
    Rmoster:initWithProgressBar()
    
    return Rmoster
end

function PRemoteMonster:initWithData(data)
    local pic=self.m..".png"
    self.monsterSprite=cc.Sprite:createWithSpriteFrameName(pic)
    self.spriteSize=self.monsterSprite:getContentSize()
    --增加碰撞刚体
    local pb=self:getMonsterPhysicsBody()
    self.monsterSprite:setPhysicsBody(pb)
    
    self:addChild(self.monsterSprite)
    self.hp=data.hp
    --ai时间
    self.AIFrequency=0.1
    self.attackFrequency=data.attackspeed
    
    --是否发射子弹
    
    self.isShooting=false
    self.isShoot=false
    if self.isMove==0 then
        self.isMove=false
        self.curSpeed=0
        self.normalSpeed=0
        self.curEndPoint=cc.p(self.point[1],self.point[2])
        self:idleMode()
        return;
    else
        self.isMove=true    
    end
    self.curSpeed=self.movespeed
    self.normalSpeed=self.movespeed  
    self.endpoint=cc.p(self.endpoint[1],self.endpoint[2])
    self.curEndPoint=self.endpoint
    
    self:walkMode()
end

function PRemoteMonster:updateState()
    local function update(dt)
        self:baseUpdate(dt)
        self:stateMachineUpdate(dt)
        self:movementUpdate(dt)
    end
    self:scheduleUpdateWithPriorityLua(update, 0)
end

function PRemoteMonster:initWithLine()
--    self.line=DrawScratchLine:create()
--    self.line:setVisible(false)
--    self.line:restDrawPoint()
--    self:addChild(self.line)
    
end

function PRemoteMonster:createAnimate()
    local animateNameunder=self.m.."_".."under"
    local animateNameroot=self.m.."_".."foot"
    local animateNamedie=self.m.."_".."die"
    local animateNameatk=self.m.."_".."atk"

    self.actionTable={
        walk = GameAU.GameBeseAnimate(animateNameroot,false,0.1),
        knocked = GameAU.GameBeseAnimate(animateNameunder,false,0.1),
        dead = GameAU.GameBeseAnimate(animateNamedie,false,0.1),
        attac = GameAU.GameBeseAnimate(animateNameatk,false,0.1),     
    }
end


function PRemoteMonster:normalAttack()
    local bPoint=getPosTable(self)
    self.normalAtk["beginPoint"]=bPoint
    self.normalAtk["monsterSize"]=self.spriteSize
    local info=self.normalAtk
    local bullet=LBulletSprite.create(info)
    
    local beginPoint=getPosTable(bullet)
    local endPoint=bullet.ePoint
--    self.line:setVisible(true)
--    self.line:setS_beginPoint(beginPoint)
--    self.line:setS_endPoint(endPoint)
    
    gameCurrentLayer:addChild(bullet,1)
--    List.pushlast(BulletManager,bullet)
end

function PRemoteMonster:specialAttack()

end

function PRemoteMonster:attackUpdate(dt)     
    self.aliveTime=self.aliveTime+dt
    self.attackTimer=self.attackTimer+dt
    
    local function shootBullet()
        --            print("self.Shooting=false")
        self:normalAttack()
        --self:playAnimation("walk", true)
        self.Shooting=false
    end
    
    
    if List.getSize(MonsterManager)~=0 then
        local tempMonsterData={}
        copyTable(MonsterManager,tempMonsterData)

        for var=tempMonsterData.first,tempMonsterData.last do
            local monster=tempMonsterData[var]
            --远程怪物发射子弹
            if monster.monsterType==EnumRaceType.REMOTEMONSTER then

                for val = MonsterManager.first, MonsterManager.last do
                    local sprite = MonsterManager[val]
                    if sprite.isMove==true then
                        return
                    end                  
                end
                
                if self.isShoot==false then
                    local attackAction=cc.Sequence:create(self.actionTable.attac:clone(),cc.CallFunc:create(shootBullet))
                    self.monsterSprite:stopAction(self.curAnimation)
                    self.monsterSprite:runAction(attackAction)
                    self.curAnimationName="attac"
                    self.curAnimation = attackAction
                    self.Shooting=true
                    self.isShoot=true
                    self:idleMode()
                end
                --  monster:PauseremoteShootBullet(dt)
                --isShootEnd=true
                if  pauseUpdate ==false then
                    gameMaster.ShootingPauseID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(ShootingPause,0.01,false)
                    isNext=true
                    pauseUpdate=true
                end
                

            end
        end
    end
    
         
        
--        print("self.Shooting=true")
    
end
function PRemoteMonster:idleMode() --switch into idle mode
    self:setStateType(EnumStateType.IDLE)
    self:pointFlipped(self.myPos)
    --self:playAnimation("walk", true)
end
function PRemoteMonster:AI()
    if self.isalive then
        if self.slowdownTime>0 then
            if self.aliveTime>self.slowdownTime then
                self.movespeed=self.normalSpeed 
                self.slowdownTime=0
            end     
        end
    
        if self:getStateType() == EnumStateType.IDLE then
            self:attackMode()
            self.isMove=false
        end
    end
end


function PRemoteMonster:removeFormGame()
    --减少一个怪物
    --gameMaster:addEnemies(-1)
end

function PRemoteMonster:dyingMode(bullet, knockAmount)
    --    print("dyingMode")
    
    self:BackMove(bullet)
    
    bullet._velocity=bullet:getPhysicsBody():getVelocity()
    bullet._aVelocity=bullet:getPhysicsBody():getAngularVelocity()
 --local bulletspeed = bullet:getPhysicsBody():getVelocity()
 --local bulletrotatespeed=bullet:getPhysicsBody():getAngularVelocity()



    bullet:getPhysicsBody():setVelocity(cc.vertex2F(0,0))
    bullet:getPhysicsBody():setAngularVelocity(0)
    
    
    self:setStateType(EnumStateType.DYING)
    self.isalive=false
    self.AIEnabled=false

    List.removeObj(MonsterManager,self) 
    if self.monsterSprite:getPhysicsBody() then
        self.monsterSprite:getPhysicsBody():removeFromWorld();
    end

    local function removeMonster()
        bullet:getPhysicsBody():setVelocity(bullet._velocity)
        print("bullet._velocityx",bullet._velocity.x)
        print("bullet._velocityy",bullet._velocity.y)
        bullet:getPhysicsBody():setAngularVelocity(bullet._aVelocity)
        print("bullet._aVelocity",bullet._aVelocity)
        
        self:removeFormGame()
        self:removeFromParent()
        
        
    end

    local deadAction=cc.Sequence:create(self.actionTable.dead:clone(),cc.CallFunc:create(removeMonster))
    self.monsterSprite:stopAction(self.curAnimation)
    self.monsterSprite:runAction(deadAction)

end
function PRemoteMonster:BackMove(bullet)
    local speed=bullet:getPhysicsBody():getVelocity()
    local angle=getVelocityAngle(speed.x,speed.y)
    

    local p = self.myPos
    
    --    if dirKnockMode then
    --        angle = collider.facing
    --    else
    --        angle = cc.pToAngleSelf(cc.pSub(p, getPosTable(collider)))
    --    end
    local addPos=getAngleDistance(angle,20)
    local newPos=cc.pAdd(p,addPos)
    self:moveFlipped(newPos,p)

    --    local newPos = cc.pRotateByAngle(cc.pSub({x=10,y=0}, p),p,angle)
    self.knockAction=cc.EaseCubicActionOut:create(cc.MoveTo:create(self.actionTable.knocked:getDuration()*0.8,newPos))
    self:runAction(self.knockAction)
end


return PRemoteMonster