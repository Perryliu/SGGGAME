require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"

LMonster = class ("LMonster", function ()
    return require "Animal".create()
end)

function LMonster:ctor()

    self.isMove=true
    self.atking=false
    self.monsterType=EnumRaceType.MONSTER
    
--    self:setMonsterState(1)
end

function LMonster.create(data)
    local lmonster = LMonster.new()  
    copyTable(data,lmonster)
    
    --转换坐标
    local point=DirectorUtils.setPhoneFourPosition(cc.p(lmonster.point[1],lmonster.point[2]))
    lmonster:setPosition(point)
    
    lmonster.myPos=getPosTable(lmonster)
    lmonster:createAnimate()
    lmonster.AIEnabled=true
    lmonster:initWithData()
    lmonster:initWithProgressBar()
    lmonster:walkMode() 
    return lmonster
end

function LMonster:initWithData()
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
    if (self.isRandom==0) then
        p2=cc.p(self.endpoint[1],self.endpoint[2])
    else
        p2=BattleUtils.getRandomWarriorrPoint(self.spriteSize);
    end
    self.endpoint=p2
    self.curEndPoint=self.endpoint
    local atkMask = self.normalAtk["mask"]
    local target = nil
    
    if atkMask == EnumAttackType.FARMLAND then
        if farmland then
            self:setTarget(farmland)
        end
    else
        self:setTarget(nil)    
    end
end

function LMonster:createAnimate()
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

function LMonster:updateState()
   local function update(dt)
        self:baseUpdate(dt)
        self:stateMachineUpdate(dt)
        self:movementUpdate(dt)
    end
    self:scheduleUpdateWithPriorityLua(update, 0)
end

function LMonster:attackUpdate(dt)
    if self.atking==false then
        self:normalAttack()
        self.atking=true
    end
end

--一般攻击
function LMonster:normalAttack()
    self.normalAtk["monsterType"]=self.monsterType
    LMonsterNormalAttack.create(getPosTable(self),self.target,self.normalAtk, self)
--    ccexp.AudioEngine:play2d(Archerproperty.normalAttackShout, false,1)
--    AUDIO_ID.ARCHERATTACK = ccexp.AudioEngine:play2d(Archerproperty.attack1, false,1)
--    ccexp.AudioEngine:setFinishCallback(AUDIO_ID.ARCHERATTACK,ArcherlAttackCallback)
end

--特殊攻击
function LMonster:specialAttack()

end

function LMonster:AI()
    if self.isalive then
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

function LMonster:atkEnd()
    self:dyingMode()
end

function LMonster:removeFormGame()
    --减少一个怪物
    gameMaster:addEnemies(-1)
end


return LMonster