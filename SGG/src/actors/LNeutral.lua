require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"

LNeutralMonster = class ("LNeutralMonster", function ()
    return require "Animal".create()
end)

function LNeutralMonster:ctor()

    self.realExitTime=0
    self.monsterType=EnumRaceType.NEUTRALMONSTER
    self.currentPointIndex=1
    self.totalPointIndex=1
    self.curSpeed=0
    self.movespeed=0
    self.jumpDistance=200
    self.timeTrigger=false
    self.recoverTime=0.8
end

function LNeutralMonster.create(data)
    local neutral =LNeutralMonster.new() 
    copyTable(data,neutral)
    neutral:setPosition(cc.p(neutral.point[1],neutral.point[2]))
    neutral.myPos=getPosTable(neutral)
    neutral:createAnimate()
    neutral.AIEnabled=true
    
    neutral:initWithData()
    neutral:initWithProgressBar()
    
    return neutral
end

function LNeutralMonster:initWithData()
    local pic=self.m..".png"
    self.monsterSprite=cc.Sprite:createWithSpriteFrameName(pic)
    self:addChild(self.monsterSprite)
    self.spriteSize=self.monsterSprite:getContentSize()
    
    if self.condition==neutralMonsterCondition.Endlife then
        self:initWithProgressBar()
    end
    --增加碰撞刚体
    local pb=self:getMonsterPhysicsBody()
    self.monsterSprite:setPhysicsBody(pb)

    if self.isMove==0 then
        self.curSpeed=0
        self.curEndPoint=cc.p(self.point[1],self.point[2])
        self:idleMode()
        return;
    end
    
    self.normalSpeed=self.movespeed 
    self.currentPointIndex=2
    self.totalPointIndex=#(self.endpointTable)
    self:getNextPoint(self.currentPointIndex)
    self:walkMode()
end

function LNeutralMonster:createAnimate()
    local animateNameunder=self.m.."_".."under"
    local animateNameroot=self.m.."_".."foot"
    local animateNamedie=self.m.."_".."die"

    local actionInterval=getMonsterInfo(self.m)        
    self.actionTable={
        walk = GameAU.GameBeseAnimate(animateNameroot,false,actionInterval.die),
        knocked = GameAU.GameBeseAnimate(animateNameunder,false,actionInterval.under),
        dead = GameAU.GameBeseAnimate(animateNamedie,false,actionInterval.foot),    
    }
end

function LNeutralMonster:updateState()
    local function update(dt)
        self:baseUpdate(dt)
        self:stateMachineUpdate(dt)
        self:movementUpdate(dt)
    end
    self:scheduleUpdateWithPriorityLua(update, 0)
end

--======State Machine switching functions
function LNeutralMonster:idleMode() --switch into idle mode
    self:setStateType(EnumStateType.IDLE)
    self:pointFlipped(self.myPos)
    self:playAnimation("walk", true)
    if isOutOfBound(self,self.myPos) then
    	self:dyingMode()
    end
end

function LNeutralMonster:jumpMode(point)
   
    self:stopAllActions()
    self:setStateType(EnumStateType.JUMPING)
    self.timejump = self.aliveTime
    local p = self.myPos
    local newPos=point
    local jumpAction=cc.JumpTo:create(self.recoverTime,newPos,25,1)
    local knockAction=cc.EaseCubicActionOut:create(jumpAction)
    self:runAction(knockAction)
end

--function LNeutralMonster:dyingMode(knockSource, knockAmount)
--    print("dyingMode")
--    self:setStateType(EnumStateType.DYING)
--    self.isalive=false
--    self.AIEnabled=false
--    
--    List.removeObj(MonsterManager,self) 
--    if self.monsterSprite:getPhysicsBody() then
--        self.monsterSprite:getPhysicsBody():removeFromWorld();
--    end
--    
--    local function removeMonster()
--        self:removeFromParent()
--        if self.timeTrigger==true then
--            Manager.neutralResult(self)
--        else
--            self:neutralDeadtrigger()
--        end
--    end
--    
--    local deadAction=cc.Sequence:create(self.actionTable.dead:clone(),cc.CallFunc:create(removeMonster))
--    self.monsterSprite:stopAction(self.curAnimation)
--    self.monsterSprite:runAction(deadAction)
--    
--    if knockAmount then
--        self:stopAllActions()
--        local angle=knockSource.angle 
--        local p = self.myPos
--        local addPos=getAngleDistance(angle,self.dieDistance)
--        local newPos=cc.pAdd(p,addPos)
--        self:moveFlipped(newPos,p)
--        local knockAction=cc.EaseCubicActionOut:create(cc.MoveTo:create(self.actionTable.knocked:getDuration()*1.5,newPos))
--        self:runAction(knockAction)
--    end
--end

function LNeutralMonster:AI()
    if self.isalive then
        self:neutralExitTime()
    end
end


function LNeutralMonster:jumpUpdate(dt)
    if self.aliveTime - self.timejump > self.recoverTime then
        self.timejump = nil
        self:walkMode()
    end
end


function LNeutralMonster:walkUpdate(dt)
    
    local endDistance=cc.pGetDistance(self.myPos,self.curEndPoint)
    --    print("endDistance==",endDistance)
    if endDistance<5 then
        if self.moveForever==1 then
            if self.currentPointIndex==self.totalPointIndex then
                self.currentPointIndex=1
            else    
                self.currentPointIndex=self.currentPointIndex+1
            end
            print("sender.currentPointIndex==",self.currentPointIndex)
            self:getNextPoint(self.currentPointIndex)
            self:moveFlipped(self.myPos,self.curEndPoint)
        else
            if self.currentPointIndex<self.totalPointIndex then
                self.currentPointIndex=self.currentPointIndex+1
                print("sender.currentPointIndex==",self.currentPointIndex)
                self:getNextPoint(self.currentPointIndex)
                self:moveFlipped(self.myPos,self.curEndPoint)
            else
                self:idleMode()    
            end 
        end
    else
        if isOutOfBound(self,self.myPos) then
            if endDistance<=self.jumpDistance then
                self:jumpMode(self.curEndPoint) 
            end  
        elseif  isOutOfBound(self,self.curEndPoint) then
            if endDistance<=self.jumpDistance then
                self:jumpMode(self.curEndPoint)                    
            end 
        end    
    end    
end

function LNeutralMonster:hurt(collider,dirKnockMode)
    if self.isalive == true then
        --没有生命值一击必死 
        if self.condition==neutralMonsterCondition.notlife then
            self:dyingMode(collider,true)  
            return 0
        --中立怪物有生命值     
        elseif self.condition==neutralMonsterCondition.Endlife then
         	local damage = collider.damage
            self.hp = self.hp - damage
            self.progressBar:progressTo(-damage)
            if self.hp <= 0 then
                self.hp = 0
                self:dyingMode(collider,true)  
            else
                self:knockMode(collider,dirKnockMode)    
            end
           
            return damage        
        end
    end
    return 0
end

function LNeutralMonster:neutralDeadtrigger()
    if self.ExitTime==0 then
        Manager.neutralResult(self)
    end
end

function LNeutralMonster:getNextPoint(currentPointIndex)
    local pointData=self.endpointTable[currentPointIndex]
    if pointData then
        local ep=cc.p(pointData.endpoint[1],pointData.endpoint[2])
        self.curEndPoint=ep 
        self.curSpeed=pointData.movespeed
        self.movespeed=pointData.movespeed
    end
end

function LNeutralMonster:neutralExitTime(dt)

--    self.realExitTime=self.realExitTime+dt
    if self.ExitTime>0 then
        if self.aliveTime>=self.ExitTime then  
            self:dyingMode()
            self.timeTrigger=true
        end
    end
end

function LNeutralMonster:removeFormGame()
    if self.timeTrigger==true then
        Manager.neutralResult(self)
    else
        self:neutralDeadtrigger()
    end
end

return LNeutralMonster

