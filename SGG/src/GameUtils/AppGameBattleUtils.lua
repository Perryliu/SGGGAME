
require "Cocos2d"
require "GameDirectorUtils"
require "Data_Level"



appleEnum={
    appleTag=10000,
}

AppleBattleUtils={}


isbord=true
bordpanduan=false

Vx=nil
Vy=nil
local lastspeed=0

local famermaxhigh=500

local boudScratchLength=0

local ReboudTouchPoint



local timeNum=0
function famerupdate(dt)

    
    timeNum=timeNum+dt
--     local speed=famer:getPhysicsBody():getVelocity()
--
--    if speed.y>0 then
--          --local newSpeed={x=speed.x,y=speed.y-30}
--       --famer:getPhysicsBody():setVelocity(newSpeed)
--        
--        local rota=getVelocityAngle(speed.x,speed.y)
--        print("speedX===",speed.x)
--        print("speedY===",speed.y)
--        local newSpeed={x=0,y=0}
--        newSpeed.x,newSpeed.y =getBulletVelocityRatio(-rota-45,10)
--        print("newSpeedX===",newSpeed.x)
--        print("newSpeedY===",newSpeed.y)
--        newSpeed.x=speed.x-newSpeed.x
--        newSpeed.y=speed.y-newSpeed.y
--        famer:getPhysicsBody():setVelocity(newSpeed)
--
--    else
--        if battlescheludeID then 
--            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(battlescheludeID)
--            --cc.Director:getInstance():getScheduler():unscheduleScriptFunc(battlescheludeID)
--            
--        end
--        
--        battlescheludeID=nil
--        
--        if bordpanduan==true then
--            isbord=true
--            bordpanduan=false
--        end
--        --local newSpeed={x=speed.x,y=speed.y-30}
--        local rota=getVelocityAngle(speed.x,speed.y)
--        print("speedX===",speed.x)
--        print("speedY===",speed.y)
--        local newSpeed={x=0,y=0}
--        newSpeed.x,newSpeed.y=getBulletVelocityRatio(225-rota,-10)
--        print("newSpeedX===",newSpeed.x)
--        print("newSpeedY===",newSpeed.y)
--        newSpeed.x=speed.x-newSpeed.x
--        newSpeed.y=speed.y-newSpeed.y
--        famer:getPhysicsBody():setVelocity(newSpeed)
--        if isbord==true then
--            if  newSpeed.x>0  then
--                
--                local antionRotate=cc.RotateTo:create(0.1,-rota-45)
--                famer:runAction(antionRotate)
--            else
--                
--
--                local antionRotate=cc.RotateTo:create(0.1,225-rota)
--                famer:runAction(antionRotate)
--            end
--            isbord=false        
--        end
--
--
--
--    end
--   
--    lastspeed=speed.y
    
    local speed=famer:getPhysicsBody():getVelocity()
    
    local curPoint={x,y}
    curPoint.x,curPoint.y= famer:getPosition()
    if speed.y>0  then
        local a= -60/47
        local b=200-a*550
        --位移长度
        local c=a*boudScratchLength+b
        --加速度
        local AspeedX =(c-Vx*2)/2
        local AspeedY=(c-Vy*2)/20
        local AvgY=550+AspeedY*2
        local AvgX=speed.x+AspeedX*2
        local newSpeed={x,y}
        
        
        
        
        if (speed.x/AspeedX)>0 then
            newSpeed={x=speed.x,y=speed.y+AspeedY*timeNum}
        else
            newSpeed={x=speed.x+AspeedX*timeNum,y=speed.y+AspeedY*timeNum}
          
        end
        local Ax=Vx/1
        local Ay=Vy/1
        
        newSpeed={x=speed.x-Ax*dt,y=speed.y-Ay*dt}
        famer:getPhysicsBody():setVelocity(newSpeed)

        --print("timeNum===",timeNum)
    else
        timeNum=0
        
--        if bordpanduan==true then
--            isbord=true
--            bordpanduan=false
--        end
--        
----        local newSpeed={x=speed.x,y=speed.y-3}
--        local rota=getVelocityAngle(speed.x,speed.y)
----        famer:getPhysicsBody():setVelocity(newSpeed)
--        if isbord==true then
--            if  speed.x>0  then
--                local antionRotate=cc.RotateTo:create(0.1,-rota-25)
--                famer:runAction(antionRotate)
--            else
--                local antionRotate=cc.RotateTo:create(0.1,205-rota)
--                famer:runAction(antionRotate)
--            end
--            isbord=false        
--        end



    end

    lastspeed=speed.y


end



--农民伯伯和边框碰撞    10是农民  3是边框
function AppleBattleUtils.FamerCollisionOutBorder(spriteA,spriteB,gA,gB)
    if (((gA==10) and (gB==3)) or ((gB==3) and (gA==10))) then

        if gA==10 then
            if spriteA:getPositionY()>80 then
                --print("%s",spriteA:getPositionY())
                
                spriteA:runJumpAction()
                --print("FamerCollisionOutBorder::spriteA:runJumpAction()")
                return true
            else
                AppleBattleUtils.removerBattleScher()
                spriteA:getParent():removeschedule()
                spriteA:getParent():getParent():gameOver(true)
                return false
            end
            
        else 

            spriteB:runJumpAction()

        end
        return true
    end

end
--农民伯伯和边框碰撞    10是农民  3是边框
function AppleBattleUtils.FamerCollisionBorder(spriteA,spriteB,gA,gB)
    if (((gA==10) and (gB==3)) or ((gB==3) and (gA==10))) then

        if gA==10 then
           
            spriteA:getParent():setfamerRotateBox()
            

        else 
            
            spriteB:getParent():setfamerRotateBox()

        end
        bordpanduan=true
        return true
    end

end
--农民伯伯和苹果碰撞      10农民    11苹果
function AppleBattleUtils.FamerCollisionApple(spriteA,spriteB,gA,gB)
    if (((gA==10) and (gB==11)) or ((gB==11) and (gA==10))) then
        if gA==10 then
            spriteA:getParent():getParent():setAppleNum(1)
            spriteA:getParent():addMoneyAction(spriteB)
            spriteA:runCatchAction()
            --print("FamerCollisionApple::spriteA:runCatchAction()")
            spriteB:getParent():removeApple(spriteB)
            spriteB:destroy()
            --11是苹果  做销毁  预留位置
        else
            spriteB:getParent():getParent():setAppleNum(1)
            spriteB:runCatchAction()
            --print("FamerCollisionApple::spriteA:runCatchAction()")
            spriteA:getParent():removeApple(spriteA)
            spriteA:destroy()
            --11是苹果  做销毁  预留位置
        end
        return false
    end

end
--农民伯伯和板子碰撞反弹
function AppleBattleUtils.FamerCollisionOutScratch(spriteA,spriteB,gA,gB)
    if (((gA==10) and (gB==2)) or ((gB==10) and (gA==2)) ) then
        if gA==10 then
            --
            
            if spriteA:getParent():getParent():setCollNum(1)==false then
                return false
            end
            boudScratchLength=spriteB:getParent():getcurScratchLenth()
            local ScratchAngle = spriteB:getParent():getAppleAngle()          
            spriteA:getParent():getAppScartLenth(spriteB)
            spriteA:getParent():setfamervec(ScratchAngle)
            spriteA:getParent():setfamerRotate()
            spriteA:getParent():FamerFirstCollPoint()
            --spriteA:getParent():
            
            spriteA:getParent():addschedule()
            
            --scheduleControlFamer=cc.Director:getInstance():getScheduler():scheduleScriptFunc(ControlFamerOffset,0.1,true);

            spriteB:getParent():setScratchStatus(1)
            BattleUtils.ScratchCollision(spriteB)
            
            
            --加速  开启定时器
        else
            if spriteA:getParent():getParent():setCollNum(1)==false then
                return false
            end
            boudScratchLength=spriteA:getParent():getcurScratchLenth()
            local abc = spriteA:getParent():getAngle()          
            spriteB:getParent():getAppScartLenth(spriteA)
            spriteB:getParent():setfamervec(abc)
            spriteB:getParent():setfamerRotate()
            spriteB:getParent():FamerFirstCollPoint()
            --spriteA:getParent():

            spriteA:getParent():addschedule()

            --scheduleControlFamer=cc.Director:getInstance():getScheduler():scheduleScriptFunc(ControlFamerOffset,0.1,true);

            spriteA:getParent():setScratchStatus(1)
            BattleUtils.ScratchCollision(spriteA)

        end 
        return true
    end

    return false
end
--农民伯伯和板子碰撞时刻           2是板子
function AppleBattleUtils.FamerCollisionScratch(spriteA,spriteB,gA,gB)
    if (((gA==10) and (gB==2)) or ((gB==10) and (gA==2)) ) then
        if gA==10 then
--           
            ReboudTouchPoint={x,y}
            ReboudTouchPoint.x,ReboudTouchPoint.y=famer:getPosition()
            spriteA:runJumpAction()
            --print("FamerCollisionScratch::spriteA:runJumpAction()")
            bordpanduan=true
            if battlescheludeID==nil then 
                battlescheludeID=cc.Director:getInstance():getScheduler():scheduleScriptFunc(famerupdate,0.1,false)
            end
            return true


        else
            
            return true

        end
    end

    return false
end


function AppleBattleUtils.removerBattleScher()
    if battlescheludeID then 
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(battlescheludeID)
   --cc.Director:getInstance():getScheduler():unscheduleScriptFunc(battlescheludeID)
    end
    battlescheludeID=nil
end

function GetFamerSpeed(angle,speed)
    local force=cc.p(0,speed)
    if (angle==180) then
        --        print("----------angle==90")
        force=cc.p(0,speed)
    elseif (angle>0 and angle<90) then
        --        print("angle>0 and angle<90")
        
        local ratio = math.tan(math.rad(90+angle))
        --local ratio=math.tan(90+angle)
        force=cc.p(speed/ratio,speed)
    elseif (angle>90 and angle<180) then
        --        print("angle>0 and angle<90")
        local ratio=math.tan(math.rad(angle-90))
        
        
        force=cc.p(speed/ratio,speed)
    end
    --    print("angle=========aaaa"..angle.."force.x==="..force.x.."    force.y==="..force.y)
    return force.x,force.y

end
