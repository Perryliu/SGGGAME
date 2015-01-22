require "Cocos2d"
require "GameBattleUtils"
require "Data_Level"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"
require "Honey"
--type

local honeyBeeSpriteZOrder=1
--local honeyList=List.new()
--local showHoneyList=List.new()


HoneyBee = class ("HoneyBee", function ()
    local node = cc.Node:create()
    node:setCascadeColorEnabled(true)
    return node
end)

function HoneyBee:ctor()

    self.isMove=false
    self.hiting=false
    self.isalive=true
    self.monsterType=EnumRaceType.HONEYBEE
    self.curHoneyCount=0
    self.tatolHoney=0
    
    self.patrolTime=0
    self.tatolTime=0
    self.addData=false
    
    self.honeyList=List.new()
    self.showHoneyList=List.new()
    
end

function HoneyBee.create(data)
    local honeyBee = HoneyBee.new()  
    copyTable(data,honeyBee)
    
    honeyBee:iniWithData(data)
    local point=DirectorUtils.setPhoneFourPosition(cc.p(honeyBee.point[1],honeyBee.point[2]))
    honeyBee:setPosition(point)
    
    honeyBee:addHoney()
    honeyBee:addPhysicsBody()
        
    return honeyBee
end

function HoneyBee:chedulerTime()
    local function update(dt)
        self:comeBack(dt)
        self:solveCollision()
    end

    self:scheduleUpdateWithPriorityLua(update, 0)	
end

function  HoneyBee:showOneHoney(honeyBee)
    if self.addData==false then
        self.curHoneyCount=1
        self:showHoney()
        self:chedulerTime()
        self.addData=true
    end

end

function HoneyBee:iniWithData(data)

--    self.line=DrawScratchLine:create()
----    self.line:setVisible(false)
--    self.line:restDrawPoint()
--    self:addChild(self.line)
--    
----    self.line:setVisible(true)
--    self.line:setS_beginPoint(cc.p(0,0))
--    self.line:setS_endPoint(cc.p(500,500))

    local png=data.m..".".."png"

    self.honeyBeeSprite=cc.Sprite:createWithSpriteFrameName(png)
    self:addChild(self.honeyBeeSprite)
    
    local name=data.m.."_".."foot"
    local animation=GameAU.GameAnimate(name,false,true,0.1)
    self.honeyBeeSprite:runAction(animation)    
    if self.isLeft==false then
       self.honeyBeeSprite:setFlippedX(true) 
    end
    
    self.spriteSize=self.honeyBeeSprite:getContentSize()
end

function HoneyBee:addPhysicsBody()
    local boundBoy=cc.PhysicsBody:createCircle(self.spriteSize.width/2)
    --农田位于碰撞第八组
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
    
    self.honeyBeeSprite:setPhysicsBody(boundBoy)
end

function HoneyBee:addHoney()
        
    local tempData=self.honey
    local honeyData={}
    copyTable(tempData,honeyData)
    local honeyCountData=self.honeyCount
    local count=#honeyCountData
    
    for var=1,count do

        local honeyIndex=honeyCountData[var]

        local point=cc.p(0,0)
        honeyData["point"]=point
        for tempvar=1,honeyIndex do
            local honey=Honey.create(honeyData)
            if self.isLeft==false then
                honey:setSpriteFippedx(true)
                honey.isLeft=false
            end
            
            self:addChild(honey)
            honey:setVisible(false)
            List.pushlast(self.honeyList,honey)
        end
   end
end

function HoneyBee:showHoney()
    
    local honeyCountData=self.honeyCount
    local count=honeyCountData[self.curHoneyCount]
    
    if count>List.getSize(self.honeyList) then
    	return
    end
--    showHoneyList
    local updataInterval=0.5/count
    local tempData=self.honey
    for var=1,count do
        local honey=List.popfirst(self.honeyList)
        if honey.isShow==false then 
        
            local honeyData={}
            copyTable(tempData,honeyData)
            
            local a=honeyData.a
            local b=honeyData.b
            local aDistance=honeyData.aDistance
            local bDistance=honeyData.bDistance
            local maxA=honeyData.maxA
            local maxB=honeyData.maxB
    
            a=a+aDistance*(self.curHoneyCount-1)
            b=b+bDistance*(self.curHoneyCount-1)
    
            if a>maxA then
                a=maxA
            end
    
            if b>maxB then
                b=maxB
            end
            
            honey.a=a
            honey.b=b
            
            local argument=2.0
            if self.isLeft==false then
                argument=1.9
            end
            honey:update(argument-((var-1)*updataInterval))
            honey:moveTo(honey.point,honey.movePoint)
            honey.curHoneyCount=self.curHoneyCount
            
            List.pushlast(self.showHoneyList,honey)  
        end 
        
    end
end

function HoneyBee:comeBack(dt) 
    self.tatolTime=self.tatolTime+dt
    if self.tatolTime>self.patrolTime then
        self.tatolTime=self.tatolTime-self.patrolTime
        
        if self.curHoneyCount<=1 then
            return;
        end
        
        local honeyCountData=self.honeyCount
        local count=honeyCountData[self.curHoneyCount]
        
        if count>List.getSize(self.showHoneyList) then
            return
        end
        
        for var=1,count do
            local honey=List.poplast(self.showHoneyList)
            if honey.isShow==true and honey.curHoneyCount==self.curHoneyCount then   
                honey:comeBack(honey.movePoint,honey.point)
            end 
            List.pushlast(self.honeyList,honey)  
        end

        self.curHoneyCount=self.curHoneyCount-1
    end
end

local function underEnd(sender)
    sender:getParent():setHiting(false)
end

function HoneyBee:setHiting(isHit)
    self.hiting=isHit
end

function HoneyBee:hurt(collider)
    if self.isalive == true then 
        print("HoneyBee:hurt")
        
        if self.hiting==false then
            local name=self.m.."_".."under"
            local animate=GameAU.GameAnimateCall(name,underEnd,true,false,0.1)
            self.honeyBeeSprite:runAction(animate)
            self.hiting=true
        end

        self.tatolTime=0
        local honeyCountData=self.honeyCount
        local count=#honeyCountData
        
        if self.curHoneyCount==count then
            return;
        end
        self.curHoneyCount=self.curHoneyCount+1
        self:showHoney()
    end
end

function HoneyBee:solveCollision()
    for val = BossManager.last, BossManager.first, -1 do
        local sprite = BossManager[val]
        if sprite.isalive == true then
            if sprite.monsterType==EnumRaceType.BAERBOSS then
                --熊是否和蜂巢接触
                local circlePoint=getPosTable(self)
                
                --蜜蜂巡逻的半径
                local tempData=self.honey
                local aDistance=tempData.aDistance
                local circleR=self.honey.a+aDistance*(self.curHoneyCount-1)
                
--                print("circleR===",circleR)
                local RectPoint=getPosTable(sprite)
                local RectWidth=sprite.spriteSize.width
                local RectHeight=sprite.spriteSize.height
                local rect={x=(RectPoint.x-RectWidth/2),y=(RectPoint.y-RectHeight/2),
                    width=RectWidth,height=RectHeight}

--                local rect=sprite:getSpriteBoundingBox()
                if circleIntersectRect(circlePoint,circleR,rect) then
                    
                    if  sprite.honeyHiting==false then
                        print("circleIntersectRect")
                        local normalAtk=self.normalAtk
                        normalAtk["isLeft"]=self.isLeft
                        normalAtk["monsterType"]=EnumRaceType.HONEYBEE
                        sprite:hurt(normalAtk,true)
                    end
                end  
            end     
        end
    end             
end


function HoneyBee:removeData()
--    if(self.schedulerTimeID) then
--        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerTimeID)
--    end

end



return HoneyBee