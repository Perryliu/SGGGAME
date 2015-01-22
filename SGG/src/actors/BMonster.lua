require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"

BMonster = class ("BMonster", function ()
    return require "Animal".create()
end)

function BMonster:ctor()

    --self.isMove=true
    self.atking=false
    self.monsterType=EnumRaceType.MONSTER
    
--    self:setMonsterState(1)
end

function BMonster.create(data)
    local bmonster = BMonster.new()  
    copyTable(data,bmonster)
    bmonster:setPosition(cc.p(bmonster.point[1],bmonster.point[2]))
    
    bmonster.curBeginpoint=cc.p(bmonster.point[1],bmonster.point[2])
    bmonster.myPos=getPosTable(bmonster)
    bmonster:createAnimate()
    
    bmonster.AIEnabled=true
    bmonster:initWithData()
    bmonster:initWithProgressBar()
    --bmonster:walkMode() 
    return bmonster
end

function BMonster:initWithData()
    local pic=self.m..".png"
    self.monsterSprite=cc.Sprite:createWithSpriteFrameName(pic)
    self:addChild(self.monsterSprite)
    self.spriteSize=self.monsterSprite:getContentSize()
    
    --增加碰撞刚体
    local pb=self:getMonsterPhysicsBody()
    self.monsterSprite:setPhysicsBody(pb)
    
    self.curSpeed=self.movespeed
    self.normalSpeed=self.movespeed 
    local p2
    
    if self.isMove ==1 then 
        if (self.isRandom==0) then
            p2=cc.p(self.endpoint[1],self.endpoint[2])
            
        else
            p2=BattleUtils.getRandomWarriorrPoint(self.spriteSize);
        end
        self.endpoint=p2
        self.curEndPoint=self.endpoint
        self.isMove=true
    else 
        self.endpoint=self.curBeginpoint
        self.curEndPoint=self.endpoint
        self.isMove=false
    end
    
    
    local atkMask = self.normalAtk["mask"]
    local target = nil
    
    if atkMask == EnumAttackType.FARMLAND and self.isMove then
        if farmland then
            self:setTarget(farmland)
            self:walkMode()
        end
    else
        self:setTarget(nil)
        self:idleMode()    
    end
end

function BMonster:createAnimate()
    local animateNameunder=self.m.."_".."under"
    local animateNameroot=self.m.."_".."foot"
    local animateNamedie=self.m.."_".."die"
        
    self.actionTable={
        walk = GameAU.GameBeseAnimate(animateNameroot,false,0.1),
        knocked = GameAU.GameBeseAnimate(animateNameunder,false,0.1),
        dead = GameAU.GameBeseAnimate(animateNamedie,false,0.1),    
    }
end

function BMonster:updateState()
   local function update(dt)
        self:baseUpdate(dt)
        self:stateMachineUpdate(dt)
        self:movementUpdate(dt)
    end
    self:scheduleUpdateWithPriorityLua(update, 0)
end

function BMonster:attackUpdate(dt)
    if self.atking==false then
        self:normalAttack()
        self.atking=true
    end
end

--一般攻击
function BMonster:normalAttack()
--    self.normalAtk["monsterType"]=self.monsterType
--    LMonsterNormalAttack.create(getPosTable(self),self.target,self.normalAtk, self)
--    ccexp.AudioEngine:play2d(Archerproperty.normalAttackShout, false,1)
--    AUDIO_ID.ARCHERATTACK = ccexp.AudioEngine:play2d(Archerproperty.attack1, false,1)
--    ccexp.AudioEngine:setFinishCallback(AUDIO_ID.ARCHERATTACK,ArcherlAttackCallback)
end

--特殊攻击
function BMonster:specialAttack()

end

function BMonster:AI()
    if self.isalive then
       if self.slowdownTime>0 then
            if self.aliveTime>self.slowdownTime then
                self.movespeed=self.normalSpeed 
                self.slowdownTime=0
            end	    
       end
        
--       if self.target then
--            if isMonsterAtkFarmland(self,self.target) then
--                self:attackMode()
--            end
--       end
        if self:getStateType() == EnumStateType.IDLE then
            --self:attackMode()
            self.isMove=false
        end
    end
end

function BMonster:atkEnd()
    self:dyingMode()
end

function BMonster:removeFormGame()
    --减少一个怪物
    --gameMaster:addEnemies(-1)
end
function BMonster:idleMode() --switch into idle mode
    self:setStateType(EnumStateType.IDLE)
    self:pointFlipped(self.myPos)
    self.monsterSprite:stopAction(self.curAnimation)
    self.curAnimation=nil
    self.curAnimationName=nil
    --self:playAnimation("walk", true)
end

function BMonster:walkUpdate(dt)

    local endDistance=cc.pGetDistance(self.myPos,self.curEndPoint)
    --    print("endDistance==",endDistance)
    if endDistance<5 then
        self.move=false
        self:idleMode()

    end    
end




function BMonster:dyingMode(bullet, knockAmount)
    --    print("dyingMode")
    self:BackMove(bullet)
    --bullet:getParent():pause()
    
    
    
    
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
        bullet:getPhysicsBody():setAngularVelocity(bullet._aVelocity)
        
        self:removeFormGame()
        self:removeFromParent()
        
        
        
    end

    local deadAction=cc.Sequence:create(self.actionTable.dead:clone(),cc.CallFunc:create(removeMonster))
    self.monsterSprite:stopAction(self.curAnimation)
    self.monsterSprite:runAction(deadAction)

end

function BMonster:BackMove(bullet)
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


return BMonster