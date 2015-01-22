
require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"

LRemoteMonster = class ("LRemoteMonster", function ()
    return require "Animal".create()
end)

function LRemoteMonster:ctor()

    self.monsterType=EnumRaceType.REMOTEMONSTER
    self.attackTimer=0
    self.attackFrequency=0
    self.Shooting=false
    self.oneceShoot=true
    self.leaveTime=0
    self.isLeave=false
end

function LRemoteMonster.create(data)
    local Rmoster =LRemoteMonster.new(data) 
    copyTable(data,Rmoster)
    
    --转换坐标
    local point=DirectorUtils.setPhoneFourPosition(cc.p(Rmoster.point[1],Rmoster.point[2]))
    Rmoster:setPosition(point)
    
    Rmoster.myPos=getPosTable(Rmoster)
    Rmoster:createAnimate()
    Rmoster.AIEnabled=true
    Rmoster:initWithData(data)
    Rmoster:initWithProgressBar()
    
    return Rmoster
end

function LRemoteMonster:initWithData(data)
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
        
    if self.isMove==0 then
        self.curSpeed=0
        self.normalSpeed=0
        --适配坐标
        local point=DirectorUtils.setPhoneFourPosition(cc.p(self.point[1],self.point[2]))
        self.curEndPoint=point
        self:idleMode()
        return;
    end
    self.curSpeed=self.movespeed
    self.normalSpeed=self.movespeed  
    
    local ePoint=DirectorUtils.setPhoneFourPosition(cc.p(self.endpoint[1],self.endpoint[2]))
    self.endpoint=ePoint
    self.curEndPoint=ePoint
    
    self:walkMode()
end

function LRemoteMonster:updateState()
    local function update(dt)
        self:baseUpdate(dt)
        self:stateMachineUpdate(dt)
        self:movementUpdate(dt)
    end
    self:scheduleUpdateWithPriorityLua(update, 0)
end

function LRemoteMonster:initWithLine()
--    self.line=DrawScratchLine:create()
--    self.line:setVisible(false)
--    self.line:restDrawPoint()
--    self:addChild(self.line)
    
end

function LRemoteMonster:createAnimate()
    local animateNameunder=self.m.."_".."under"
    local animateNameroot=self.m.."_".."foot"
    local animateNamedie=self.m.."_".."die"
    local animateNameatk=self.m.."_".."atk"
    
    local actionInterval=getMonsterInfo(self.m)
    self.actionTable={
        walk = GameAU.GameBeseAnimate(animateNameroot,false,actionInterval.die),
        knocked = GameAU.GameBeseAnimate(animateNameunder,false,actionInterval.under),
        dead = GameAU.GameBeseAnimate(animateNamedie,false,actionInterval.foot),   
        attac = GameAU.GameBeseAnimate(animateNameatk,false,actionInterval.atk),     
    }
    
    if self.m=="arm0011" then
        local animateNameidle=self.m.."_".."idle"
        self.actionTable.idle=GameAU.GameBeseAnimate(animateNameidle,false,actionInterval.idle)
    end
end


function LRemoteMonster:normalAttack()
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

function LRemoteMonster:specialAttack()

end

function LRemoteMonster:attackUpdate(dt)     
    self.attackTimer=self.attackTimer+dt
    if self.attackTimer>self.attackFrequency or self.oneceShoot then
        self.attackTimer=self.attackTimer-self.attackFrequency
        local function shootBullet()
--            print("self.Shooting=false")
            self:normalAttack()
            if self.m=="arm0011" then
                self:playAnimation("idle", true)
            else
                self:playAnimation("walk", true)    
            end   
            self.Shooting=false
        end
        
        self.oneceShoot=false
        local attackAction=cc.Sequence:create(self.actionTable.attac:clone(),cc.CallFunc:create(shootBullet))
        self.monsterSprite:stopAction(self.curAnimation)
        self.monsterSprite:runAction(attackAction)
        self.curAnimationName="attac"
        self.curAnimation = attackAction
        self.Shooting=true
     end
end

function LRemoteMonster:AI()
    if self.isalive then
        --离开
        if self.leaveTime>0 then
            if self.aliveTime>self.leaveTime then
                if self.Shooting==false then
                    self.curEndPoint=DirectorUtils.setPhoneFourPosition(cc.p(self.leavePoint[1],self.leavePoint[2]))
                    self.isLeave=true
                    self:walkMode()
                    self.leaveTime=0
                end
            end    
        end
    
        if self.slowdownTime>0 then
            if self.aliveTime>self.slowdownTime then
                self.movespeed=self.normalSpeed 
                self.slowdownTime=0
            end     
        end
    
        if self:getStateType() == EnumStateType.IDLE then
            if self.isLeave==true then
                self:LeaveRemoveFormGame()
            else
                self:attackMode()    
            end
        end
    end
end


function LRemoteMonster:removeFormGame()
    --减少一个怪物
    print("removeFormGame")
    gameMaster:addEnemies(-1)
end


return LRemoteMonster