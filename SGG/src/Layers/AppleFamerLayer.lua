require "Cocos2d"
require "GameDirectorUtils"
require "Data_Level"
require "Data_Monster"
require "GameAmimationUtils"
require "GameBattleUtils"
require "AppGameBattleUtils"
require "StandardFamer"
require "CommanApple"
local AppleFamerLayer =class("AppleFamerLayer",function()
    return cc.Layer:create();
end)

function AppleFamerLayer.create()      
    local layer=AppleFamerLayer.new()
    Carame=nil
    layer:addMon()
    layer:GameBox()
    return layer
end

local AppleData={}
local LAppleNum

local firstCollPoint
local curScartLenth
local famerVeX
local famerVeY
local totaldistance=0
local scheduleID


function AppleFamerLayer:addschedule()
    if scheduleID==nil then
        scheduleID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(ControlFamerOffset,0.01,false)
    end
    
end
function AppleFamerLayer:removeschedule()
    if scheduleID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scheduleID)
        scheduleID=nil
    end
   
end
function AppleFamerLayer:getAppScartLenth(sprite)
    curScartLenth=sprite:getParent():getcurScratchLenth()
    local a=1

end
function AppleFamerLayer:FamerFirstCollPoint()

    firstCollPoint=cc.p(famer:getPositionX(),famer:getPositionY())
end


local timeclock=0
function ControlFamerOffset(dt)
    timeclock=timeclock+dt
    local famerPoint={x,y}
    famerPoint.x=famer:getPositionX()
    famerPoint.y=famer:getPositionY()
    local off=getDistanceBetween(famerPoint,firstCollPoint)
    --local off = math.abs(famerPoint.y-firstCollPoint.y)
    totaldistance=totaldistance+off
    firstCollPoint=famerPoint
    local a= -60/47
    local b=200-a*550
    --位移长度
    local c=a*curScartLenth+b
    local speed = famer:getPhysicsBody():getVelocity()
    --if totaldistance>=c then
       if speed.y<0 then
        print( "timeclock===",timeclock)
        local force=cc.vertex2F(0, -500000.0);
        
        famer:getPhysicsBody():setVelocity(cc.vertex2F(0,-300))
        --famer:getPhysicsBody():applyImpulse(force)
        famer:setRotation(0)
        totaldistance=0
        if battlescheludeID then 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(battlescheludeID)
            battlescheludeID=nil
        end
        famer:getParent():removeschedule()
        --cc.Director:getInstance():getScheduler():unscheduleScriptEntry(AppGameBattleUtils.scheduleControlFamer)
    end
end

function AppleFamerLayer:setfamervec(ScratchAngle)

--    local b = 800-80*-(40/47)
--    
--    --local b =550+(35/47)*80
--    
--    local speedY=(curScartLenth*40/-47)+b
--    --local def = 200+(35/47)*550
--    local speed=famer:getPhysicsBody():getVelocity()
----    print("speed.x===",speed.x)
----    print("speed.y===",speed.y)
--    local bili
--    local newSpeed
--    if speed.y<0 then
--        newSpeed=speed
--    else
--        bili=speed.y/speed.x
--        newSpeed={x=speedY/bili,y=speedY}
--        --newSpeed={}
--    end
--    if newSpeed.x>1000 then
--    
--        newSpeed.x=1000
--        newSpeed.y=newSpeed.y*bili
--    elseif newSpeed.x<-1000 then
--        newSpeed.x=-1000
--        newSpeed.y=newSpeed.y*bili
--    end
--    
--    --local newSpeed={x=speedY/bili,y=speedY}
----    if speed.x>0 then
----        newSpeed={x=550,y=speed.y*bili}
----    else
----        newSpeed={x=-550,y=speed.y*bili}
----    end
----    
----   
----
--    famer:getPhysicsBody():setVelocity(newSpeed)
----    famer:getPhysicsBody():applyImpulse(newSpeed)
--    local speed1=famer:getPhysicsBody():getVelocity()
--    Vx=speed1.x
--    Vy=speed1.y

    --local velocity=famer:getPhysicsBody():getVelocity()
--    famerVeX=newSpeed.x
--    famerVeY=newSpeed.y

    
    
   
--    local beginpoint = spritescraft:getParent().s_beginPoint
--    local endpoint = spritescraft:getParent().s_endPoint
    --local angleA = ScratchAngle
    local newSpeed={x,y}
    
    local speed  = 1000
    
    newSpeed.x,newSpeed.y=GetFamerSpeed(ScratchAngle,speed)
   
    famer:getPhysicsBody():setVelocity(newSpeed)
    print("angle==============================",ScratchAngle)
    print("newSpeed==x",newSpeed.x)
    print("newSpeed==y",newSpeed.y)
    Vx=newSpeed.x
    Vy=newSpeed.y







end
function AppleFamerLayer.setfamerRotate()
    local velocity=famer:getPhysicsBody():getVelocity()

    local angle=getVelocityAngle(velocity.x,velocity.y)

    famer:setRotation(90-angle)



end

function AppleFamerLayer.setfamerRotateBox()
    local velocity=famer:getPhysicsBody():getVelocity()

    local angle=getVelocityAngle(velocity.x,velocity.y)
    Vx=velocity.x
    if velocity.y>0 then
        famer:setRotation(90-angle)
    else
--        local curVe=
--            famer:getPhysicsBody():setVelocity()     
    end
    --famer:setRotation(90-angle)

end


--农民伯伯碰撞挡板回调
local function actionMoveCallBack(sender)

end

--农民伯伯和苹果初始化
function AppleFamerLayer:addMon()
    local AppleDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).apple;
    local AppleNum=#AppleDatam
    local ApplePoint=AppleDatam.applepoint
    local apple
    --
    
    
--    for var=1,#AppleDatam,1 do  
--        local Aname=AppleDatam[var].n
--        local Apoint=AppleDatam[var].point
--        local appledata=AppleDatam[var]
--        --LBettary.create(BatteryDatam[var])
----        local CommanApple = require("CommanApple")
----        apple=CommanApple:create(appledata)
--        apple=CommanApple.create(Aname)
--        apple:setTag(appleEnum.appleTag+var)
--        apple:setPosition(Apoint[1],Apoint[2])
--        self:addChild(apple,-1,11)
--        --苹果加进数组
--        table.insert(AppleData,apple)
--    end
    
    
    local winSize = cc.Director:getInstance():getWinSize()
    
    math.randomseed(tostring(os.time()):reverse():sub(1,6))
    local point
    
    local apple = cc.Sprite:create("apple.png")
    local _Pointvec={}

    for var = 0,26 do
        local _is = false;
        local apoint = cc.p(math.random()*(winSize.width )- apple:getContentSize().width, 300 + math.random()*(winSize.height) - apple:getContentSize().height)
        
        while (self:ReturnPointTable(_Pointvec, apoint,apple:getContentSize().width)==false)
        do
            apoint = cc.p(math.random()*(winSize.width) - apple:getContentSize().width, 300 + math.random()*(winSize.height) - apple:getContentSize().height)
        end
        _Pointvec[var]=apoint
    end
        
    for var=1,27,1 do  
        local Aname=AppleDatam.n
        local Apoint=_Pointvec[var-1]
        --local appledata=AppleDatam[var]
        --LBettary.create(BatteryDatam[var])
        --        local CommanApple = require("CommanApple")
        --        apple=CommanApple:create(appledata)
        apple=CommanApple.create(Aname)
        apple:setTag(appleEnum.appleTag+var)
        apple:setPosition(Apoint)
        self:addChild(apple,-1,11)
        --苹果加进数组
        table.insert(AppleData,apple)
    end
    
    
    
    
    
    
    
    
    local famerData=returnLevelTable(DirectorUtils.getCurSceneLevel()).famer
    local famerpoint=cc.p(DirectorUtils.getWinSize().width/2,DirectorUtils.getWinSize().height/2)
    
--    local StandardFamer = require("StandardFamer")
    famer=StandardFamer.create(famerData.type)
    
--    famer=StandardFamer:create(famerData.type)

    famer:setPosition(famerpoint)
    self:addChild(famer,-1,10)
    --self:setfamervec(famer)
    
    
    
    
--    Carame=cc.Camera:createPerspective(60.0,640/1136, 10.0, 4000.0)
--    
--    self:addChild(Carame)
    
    
    
    
    
    
    
    
end
function AppleFamerLayer:GameBox()

    local left=cc.Sprite:create("dian2.png")
    self:addChild(left)
    left:setScaleX(50)
    left:setScaleY(DirectorUtils.getWinHeight()*2)
    left:setContentSize(cc.size(50,DirectorUtils.getWinHeight()*2))
    left:setPosition(0,DirectorUtils.getWinHeight()/2)
    local leftbody=cc.PhysicsBody:createBox(left:getContentSize())

    leftbody:setDynamic(false)

    leftbody:getShape(0):setRestitution(1)
    leftbody:getShape(0):setGroup(3)
    leftbody:getShape(0):setFriction(1)

    leftbody:getShape(0):setDensity(1)

    leftbody:setCategoryBitmask(0x0110)
    leftbody:setCollisionBitmask(0x0110)
    leftbody:setContactTestBitmask(0x0110)
    leftbody:setGravityEnable(false)


    left:setPhysicsBody(leftbody)



    local right=cc.Sprite:create("dian2.png")
    right:setScaleX(50)
    right:setScaleY(DirectorUtils.getWinHeight()*2)
    right:setContentSize(cc.size(50,DirectorUtils.getWinHeight()*2))
    right:setPosition(DirectorUtils.getWinWidth(),DirectorUtils.getWinHeight()/2)
    local rightbody=cc.PhysicsBody:createBox(right:getContentSize())

    rightbody:setDynamic(false)
    rightbody:getShape(0):setGroup(3)
    rightbody:getShape(0):setRestitution(1)

    rightbody:getShape(0):setFriction(1) 

    rightbody:getShape(0):setDensity(1)

    rightbody:setCategoryBitmask(0x0110)
    rightbody:setCollisionBitmask(0x0110)
    rightbody:setContactTestBitmask(0x0110)
    rightbody:setGravityEnable(false) 


    right:setPhysicsBody(rightbody)

    self:addChild(right)
    
    
    
    local bottle=cc.Sprite:create("dian2.png")
    bottle:setScaleX(DirectorUtils.getWinWidth())
    bottle:setScaleY(50)
    bottle:setContentSize(cc.size(DirectorUtils.getWinWidth(),50))
    bottle:setPosition(DirectorUtils.getWinWidth()/2,0)
    local bottlebody=cc.PhysicsBody:createBox(bottle:getContentSize())

    bottlebody:setDynamic(false)
    bottlebody:getShape(0):setGroup(3)
    bottlebody:getShape(0):setRestitution(0.2)

    bottlebody:getShape(0):setFriction(1) 

    bottlebody:getShape(0):setDensity(1)

    bottlebody:setCategoryBitmask(0x0110)
    bottlebody:setCollisionBitmask(0x0110)
    bottlebody:setContactTestBitmask(0x0110)
    bottlebody:setGravityEnable(false) 


    bottle:setPhysicsBody(bottlebody)

    self:addChild(bottle)
    

end
function AppleFamerLayer:removeApple(ap)

    local hitapple=ap:getTag()-appleEnum.appleTag
    print("monster MTag=====",hitapple);
    --纪录删除怪物下标
    local removeCount=0;
    --  从后面往前删除  
    for i=#AppleData, 1, -1 do
        if AppleData[i]==hitapple then
            removeCount=i
        end
    end
    print("MonsterremoveCount====",removeCount)
    --如有删除怪物 删除全局怪物变量
    if removeCount>0 then
        table.remove(AppleData,removeCount)
        LAppleNum=LAppleNum+1

    end
end


function AppleFamerLayer:addMoneyAction(sp)
    local function GoldMoveCallBack(sender)
        sender:getParent():getParent():setGoldLabel()
    	sender:removeFromParent()
    end
    local abc= BattleUtils.getRandomValue(1)
    local winSize = cc.Director:getInstance():getWinSize()
    local n=0
    local Target={x,y}
    Target.x=sp:getPositionX()
    Target.y=sp:getPositionY()
    for var =1,3 do
        local gold = cc.Sprite:create("gold.png");
        local bezierCon={}
        if (n%2==0) then
            local randX=math.random()
            local randY=math.random()
            bezierCon[1] = cc.p(400 * randX + Target.x, Target.y + (winSize.height-Target.y)*randY)
            bezierCon[2] = cc.p(-400 * randX + Target.x, Target.y + (winSize.height-Target.y + (winSize.height-Target.y)*randY)*randY)
        
        else
        
            local randX=math.random()
            local randY=math.random()
            bezierCon[1] = cc.p(-400 * randX + Target.x, Target.y + (winSize.height-Target.y)*randY)
            bezierCon[2] = cc.p(400 * randX + Target.x, Target.y + (winSize.height-Target.y + (winSize.height-Target.y)*randY)*randY)
        end
       
        bezierCon[3] = cc.p(winSize.width/2,winSize.height)
        n=n+1
        
        
--    
    local bezier2 ={
        cc.p(100, 100 / 2),
        cc.p(200, - 100 / 2),
        cc.p(240, 160)
    }

    local bezierTo1 = cc.BezierTo:create(2, bezier2)
        local time=math.random()*0.5+1
        local action = cc.BezierTo:create(time, bezierCon);
        
        local callback = cc.CallFunc:create(GoldMoveCallBack)
        local action1 = cc.EaseSineIn:create(action)
        gold:runAction(cc.Sequence:create(action1,callback))
        gold:setPosition(Target);
        self:addChild(gold);
    end
end




function AppleFamerLayer:removeAllData()
    if (self.schedulerID) then
        self:removeschedule()
    end
    for i=#AppleData, 1, -1 do
        AppleData[i]:removeFromParent()
        table.remove(AppleData,i)
    end
end

function AppleFamerLayer:getAppleData()
    return AppleData
end

function AppleFamerLayer:ReturnPointTable(Pointtable,point,changdu)
	if #Pointtable>0 then
    
        local _is = false;
        for var= 0,#Pointtable do
       
            if getDistanceBetween(point,Pointtable[var])<changdu then
            
                return false
            end
            _is = true;
            
        end
        return true;
     else
        return true
    end
    
end

return AppleFamerLayer
