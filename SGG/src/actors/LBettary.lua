require "Cocos2d"
require "GameBattleUtils"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"
require "LBulletAnimate"

LBettary = class ("LBettary", function ()
    local rm = cc.Node:create()
    rm:setCascadeColorEnabled(true)
    return rm
end)

function LBettary:ctor()

    self.isalive = true
    self.monsterType=EnumRaceType.BETTARY
    self.count=0
    self.curCount=1
    self.aliveTime=0
    self.shootTime=0
    self.curAttackspeed=0
    self.Shooting=false
end

function LBettary.create(data)
    local bettary =LBettary.new() 
    copyTable(data,bettary)
    bettary.count=data.count
    bettary.curAttackspeed=data.attackspeed[1]
    
    local point=DirectorUtils.setPhoneFourPosition(cc.p(bettary.point[1],bettary.point[2]))
    bettary:setPosition(point)
    
    return bettary
end


function LBettary:normalAttack()

    self.Shooting=false
    self.curCount=self.curCount+1
    self.curAttackspeed=self.attackspeed[self.curCount]
    local bPoint=getPosTable(self)
    self.normalAtk["beginPoint"]=bPoint
    self.normalAtk["monsterSize"]={width=0,height=0}
    self.normalAtk["isRandom"]=self.normalAtk.isRandomTable[self.curCount]
    
    local info=self.normalAtk
    local bullet=LBulletAnimate.create(info)
    bullet.isBettary=true
    bullet.outBounds=0
    gameCurrentLayer:addChild(bullet,1)
     if self.curCount>self.count then
        self:removeFromParent()
        List.removeObj(BatteryManager,self)
    end
end

function LBettary:specialAttack()

end

function LBettary:remoteShootBullet(dt)
    self.aliveTime=self.aliveTime+dt
    self.shootTime=self.shootTime+dt

    if self.shootTime>self.curAttackspeed then
        if self.Shooting==false then
            self.Shooting=true
            self:normalAttack()
        end 
    end
end

return LBettary