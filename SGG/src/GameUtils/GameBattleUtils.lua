
require "Cocos2d"
require "GlobalVariables"
require "GameDirectorUtils"
require "Data_Level"
require "GuideConfigInfo"

local subDistance=1
--暂停模式反弹判断
local ReboundOut=false

--战斗场景
function loadingGameCeche()
    local cache = cc.SpriteFrameCache:getInstance()
    print("DirectorUtils.getCurSceneLevel()=ff",DirectorUtils.getCurSceneLevel())
    local levelCeche=returnLevelTable("SggGameCeche").ceche

    if levelCeche then
        for key, var in pairs(levelCeche) do
            local pathPlist=string.format("%s.plist",var)
            local pathPng=string.format("%s.png",var)            
            cache:addSpriteFrames(pathPlist, pathPng)
        end
    end
    
    local animateLevel=returnLevelTable("SggGameCeche").sggAnimate
    if animateLevel then
        for key, animateData in pairs(animateLevel) do 
            if animateData  then 
                for type, count in pairs(animateData) do
                    local animframes={}
                    for i=1,count do
                        local ImageStr=string.format("%s_%s_%d.png",key,type,i)
                        local frame=cache:getSpriteFrame(ImageStr)
                        animframes[i]=frame
                    end
                    local animation=cc.Animation:createWithSpriteFrames(animframes)
                    local animationStr=string.format("%s_%s",key,type)
                    --                print("animationStr===",animationStr)
                    cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
                end
            end
        end
    end
    
    --MusicManager:GetInstance():PreLoadALlEffect()
    
    print("loadingGameCecheFinish")
end

--战斗场景
function openBattleScene()

    package.loaded["GameScene"]=nil
    package.loaded["Manager"]=nil
    package.loaded["GameMaster"]=nil
    package.loaded["LayerManager"]=nil
    package.loaded["helper"]=nil
    package.loaded["AttackCommand"]=nil
    package.loaded["GameUserDataLayer"]=nil
    package.loaded["MessageDispatchCenter"]=nil
    
        
--    local gameScene=require("GameScene").create();
--    
--    if cc.Director:getInstance():getRunningScene() then
--        cc.Director:getInstance():replaceScene(gameScene)
--    else
--        cc.Director:getInstance():runWithScene(gameScene)
--    end
    local guideId=getBeginnersTask()
    
    local type
    if guideId=="1001" then
    	type=1
    else
    	type=returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
    end
    
    if type==1 or type==100 then
        local scene = require("GameScene")
        local gameScene=scene.create();
        if cc.Director:getInstance():getRunningScene() then
            cc.Director:getInstance():replaceScene(gameScene)
            if guideId=="1001" then
            else
                CreateConditionLayer(gameScene)
            end
            
        else
            cc.Director:getInstance():runWithScene(gameScene)
            if guideId=="1001" then
            else
                CreateConditionLayer(gameScene)
            end
        end
    end
    if type==2 then
        local scene = require("GameAppleScene")
        local gameScene=scene.create();
        if cc.Director:getInstance():getRunningScene() then
            cc.Director:getInstance():replaceScene(gameScene)
        else
            cc.Director:getInstance():runWithScene(gameScene)
        end
    end
    if type==3 then
        local scene = require("GamePauseScene")
        local gameScene=scene.create();
        if cc.Director:getInstance():getRunningScene() then
            cc.Director:getInstance():replaceScene(gameScene)
        else
            cc.Director:getInstance():runWithScene(gameScene)
        end
    end
end


--创建进入关卡选择层

function CreateConditionLayer(scene)

local type=returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
    
        local layer = require "ConditionLayer"
        CONDITIONLAYER=layer.create() 
        scene:addChild(CONDITIONLAYER,20)
end


function  isMonsterAtkFarmland(object1,object2)
    if object1==nil or object2==nil  then
        print("solveCollision object1==nil or object2==nil")
    end

    local monsterPos = cc.p(object1:getPosition())
    local FarmlandPos = cc.p(object2:getPosition())
    local mSize=object1.spriteSize
    local fSize=object2:getContentSize()
    --        print("mSize.height===",mSize.height)
    --        print("monsterPos.y===",monsterPos.y)
    --        print("fSize.height===",fSize.height)
    --        print("FarmlandPos.y===",FarmlandPos.y)

    local mCollisionY=monsterPos.y+mSize.height*0.5
    local fCollisiony=FarmlandPos.y+fSize.height*0.5

    --        print("mCollisionY===",mCollisionY)
    --        print("fCollisiony===",fCollisiony)
    if mCollisionY<=fCollisiony then
       return true
    end
    
    return false
end

--远程怪物坐标
function getRemoteWeaponPoint(tag)
    local point=cc.p(0,0);
--
    local weapon=gameCurrentLayer:getChildByTag(tag)
    if (weapon._isRandom==0) then
        point=cc.p(weapon.endpoint[1],weapon.endpoint[2])
    end
   
    return point.x,point.y
end

--获取近战怪物攻击坐标
function getMonsterPoint(tag)
    local point=cc.p(0,0);
    local monster=gameCurrentLayer:getChildByTag(tag)
    point=monster.endpoint
   
    return point.x,point.y
end

--获取中立怪物的行走坐标
function getNeutralMonsterPoint(tag,index)
--    print("index==",index)
    local point=cc.p(0,0);
    local neutral=gameCurrentLayer:getChildByTag(tag)
    local pointTable=neutral._endpointTable
    point=cc.p(pointTable[index].endpoint[1],pointTable[index].endpoint[2])
    return point.x,point.y
end


function getGLAngle(bPointx,bPointy,ePointx,ePointy)
    local angle=math.deg(math.atan2(bPointy-ePointy,bPointx-ePointx))   
    return angle
end

--radiansNormalizer
function radNormalize(rad)
    local pi2 = 2*math.pi
    rad = rad % pi2
    rad = (rad + pi2)%pi2
    if rad > math.pi then
        rad = rad - math.pi
    end
    return rad
end

function getVelocityAngle(x,y)
    local angle=math.deg(math.atan2(y,x))
    --   angle=angle*57.29577951
    return angle                                          
end

function getBulletVelocityRatio(angle,speed)
	local force=cc.p(0,speed)
    if (angle==90) then
--        print("----------angle==90")
        force=cc.p(0,-speed)
    elseif (angle>0 and angle<90) then
--        print("angle>0 and angle<90")
        local ratio=math.tan(math.rad(90.0-angle))
        force=cc.p(speed*ratio,-speed)
    elseif (angle>90 and angle<180) then
--        print("angle>0 and angle<90")
        local ratio=math.tan(math.rad(angle-90.0))
        force=cc.p(-speed*ratio,-speed)
    end
--    print("angle=========aaaa"..angle.."force.x==="..force.x.."    force.y==="..force.y)
    return force.x,force.y
end

function getAngleDistance(angle,distance)
    local force=cc.p(0,0)
    local y=math.sin(math.rad(angle))*distance
    local x=math.cos(math.rad(angle))*distance
    
    force=cc.p(x,y)
    return force
end

function getDistanceBetween(pointA,pointB)
    return math.sqrt((pointA.x-pointB.x)^2+(pointA.y-pointB.y)^2)
end

--圆形和矩形接触
function circleIntersectRect(circlePoint,circleR,Rect)
    local cx=nil
    local cy=nil
    
    --圆在方形左边
    if circlePoint.x < Rect.x then
        cx = Rect.x
    elseif circlePoint.x > Rect.x + Rect.width then
        cx = Rect.x + Rect.width
    else
        cx = circlePoint.x
    end
 
    if circlePoint.y < Rect.y then
        cy = Rect.y
    elseif circlePoint.y > Rect.y + Rect.height then
        cy = Rect.y + Rect.height
    else
        cy = circlePoint.y
    end
        
    if cc.pGetDistance(circlePoint, cc.p(cx, cy)) < circleR then
        return true
    end
 
    return false

end

--锚点为 0.5 0.5 A子弹 B挡板
--给出碰撞时挡板的实际Rect
function isContainRect(pointA,pointB,sizeA,sizeB,angle2)

--    print("pointAx=====",pointA.x)
--    print("pointAy=====",pointA.y)
--    
--    print("pointBx=====",pointB.x)
--    print("pointBy=====",pointB.y)
    
    local kWidth=(sizeA.width/2+sizeB.width/2-subDistance)
    local kHeight=(sizeA.width/2+sizeB.height/2-subDistance)
--    print("kWidth=====",kWidth)
--    print("kHeight=====",kHeight)
    local angle=getGLAngle(pointA.x,pointA.y,pointB.x,pointB.y)
--    print("angle222222=====",angle2)
--    print("angle1111=====",angle)
   
--    angle=math.abs(angle)
    local newAngle=math.abs(angle+angle2)
    local distance=getDistanceBetween(pointA,pointB)
    
    local newWidth=math.abs(distance*math.cos(math.rad(newAngle)))
    local newHeight=math.abs(distance*math.sin(math.rad(newAngle)))
    
--    print("distance====",distance)
--    print("isContainRectangle====",newAngle)
--    print("newWidth=====",newWidth)
--    print("newHeight=====",newHeight)
    
    if (newWidth<kWidth and newHeight<kHeight) then
    	return false
    end
    return true
    
end

-- --------------------------------------------战斗－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

--随机稻草坐标
function BattleUtils.getRandomWarriorrPoint(size)
    local newWidth=DirectorUtils.getWinWidth()-size.width
    local newHeight=-(size.height+10)
	math.randomseed(tostring(os.time()):reverse():sub(1,6))
    local newRW=newWidth*math.random()
    newRW=newRW+size.width*0.5
    local p=cc.p(newRW,newHeight)
    return p
end

--随机数
function BattleUtils.getRandomValue(value)
    math.randomseed(tostring(os.time()):reverse():sub(1,6))
    local value=value*math.random()
    
    return value
end 

--销毁子弹
function BattleUtils.bulletEnd(sender)
--    List.removeObj(BulletManager,sender)
    sender:removeEndBullet()
end

--子弹反弹设置反弹速度加成
function BattleUtils.bulletReboundVelocity(scratchSprite,bulletSprite)
    --飞行速度 旋转速度
    local velocity=bulletSprite:getPhysicsBody():getVelocity();
    --速度加成
    
    print("velocity.x",velocity.x)
    print("velocity.Y",velocity.y)
    local speedAddition=scratchSprite:getParent():getSpeedAddition()
--    local speedAddition=1
    local newSpeed=cc.p(velocity.x*speedAddition,velocity.y*speedAddition)
    bulletSprite:getPhysicsBody():setVelocity(newSpeed)
    print("newSpeed.x",newSpeed.x)
    print("newSpeed.Y",newSpeed.y)
    return newSpeed
end

--子弹反弹设置反弹速度加成
function BattleUtils.bulletReboundAngularVelocity(scratchSprite,bulletSprite)
    --旋转速度
    local avelocity=bulletSprite:getPhysicsBody():getAngularVelocity();
    --旋转速度加成
    local AvelocityAddition=scratchSprite:getParent():getSpeedAddition()
--    local AvelocityAddition=1
    local newAvelocity=avelocity*AvelocityAddition
    bulletSprite:getPhysicsBody():setAngularVelocity(newAvelocity)
    
    
    return newAvelocity
end

--销毁怪物
function BattleUtils.monsterEnd(sender)
    sender:getParent():End(sender)
end

function BattleUtils.End(sender)
    sender:getParent():End(sender)
end


--击中远程怪物
function BattleUtils.weaponHit(sender,hurt)
    local byHurt=sender:getParent():hit(hurt)
    return byHurt
end

--击中近战怪物
function BattleUtils.monsterHit(sender,hurt)
    return sender:getParent():hitByBullet(hurt)
end

--击中boss
function BattleUtils.bossMonsterHit(spriteA,spriteB)
    local hurt=spriteA:getHurt()
    return spriteB:getParent():bulletHit(hurt,spriteA)
end

--挡板反弹挡板承受次数
function BattleUtils.ScratchCollision(sender)
    sender:getParent():setThichness(-1);
    if (sender:getParent():getThichness()<=0) then
        sender:getParent():reset();
        return false
    end
    return true
end

--子弹反弹之后的刚体配置
function BattleUtils.setBulletReboundHurt(sender)
    sender:getPhysicsBody():getShape(0):setGroup(BattleGroup.BulletReboundGroup)
    sender:getPhysicsBody():setCategoryBitmask(0x0001);
    sender:getPhysicsBody():setCollisionBitmask(0x0001);
    sender:getPhysicsBody():setContactTestBitmask(0x0001);
end

--碰撞中的两个精灵
function BattleUtils.getCollisionSprite(contact)
    local spriteA=contact:getShapeA():getBody():getNode();
    local spriteB=contact:getShapeB():getBody():getNode();
    return spriteA,spriteB
end

--碰撞中的两个精灵的组
function BattleUtils.getCollisionGroup(s1,s2)
    local gA=s1:getPhysicsBody():getShape(0):getGroup();
    local gB=s2:getPhysicsBody():getShape(0):getGroup();
    return gA,gB
end

--子弹碰撞挡板
function BattleUtils.BulletCollisionScratch(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletGroup) and (gB==BattleGroup.ScratchGroup)) then
        if gA==BattleGroup.BulletGroup then
            local sizeA=spriteA.spriteSize;
            local sizeB=spriteB:getParent():getScratchSize();
            
            local pointA=spriteA:getParent():convertToWorldSpace(cc.p(spriteA:getPosition()))
            local pointB=cc.p(spriteB:getPosition())
            local angleB=spriteB:getParent():getAngle();

            if not (isContainRect(pointA,pointB,sizeA,sizeB,angleB)) then
                print("isContainRect")
                spriteA:setIsRebound(false)
--                BattleUtils.bulletEnd(spriteA)
            	return false
            end
            gameJudge:addScratchMainTimes()
            gameJudge:BeUseSratchLength(spriteB:getParent():getcurScratchLenth())
            
            spriteB:getParent():setScratchStatus(2)  
            spriteA:setIsRebound(true)
        end
        return true
    end
    return false
end

--子弹碰撞农田
function BattleUtils.BulletCollisionfarmland(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.UserFarmlandGroup)) then
        if (gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup) then
--            print("BulletCollisionfarmland")
            spriteA:attackUpdate(spriteB:getParent())
            BattleUtils.bulletEnd(spriteA)
        else
            spriteB:attackUpdate(spriteA:getParent())
            BattleUtils.bulletEnd(spriteB)    
        end
        return true
    end
    return false
end

--反弹子弹与怪物碰撞
function BattleUtils.BulletCollisionEnemy(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.MonsterGroup)) 
        or ((gB==BattleGroup.BulletReboundGroup) and (gA==BattleGroup.MonsterGroup)) then
        if gA==BattleGroup.BulletReboundGroup then
            local type= spriteB:getParent().m
            gameJudge:addScratchHitRate()
            spriteA:attackUpdate(spriteB:getParent())
            BattleUtils.bulletEnd(spriteA)
        else
            spriteB:attackUpdate(spriteA:getParent())
            BattleUtils.bulletEnd(spriteB)    
        end
        return true    
    end
    return false
end

--反弹子弹与蜂巢碰撞
function BattleUtils.BulletCollisionHoneyBee(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.HoneyBeeGroup)) 
        or ((gB==BattleGroup.BulletReboundGroup) and (gA==BattleGroup.HoneyBeeGroup)) then
        if gA==BattleGroup.BulletReboundGroup then
            spriteA:attackUpdate(spriteB:getParent())
            BattleUtils.bulletEnd(spriteA)
        else
            spriteB:attackUpdate(spriteA:getParent())
            BattleUtils.bulletEnd(spriteB)    
        end
        return true    
    end
    return false
end

--子弹跳出屏幕
function BattleUtils.BulletOutOfBounds(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.BoundBoyGroup)) then
        if gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup then
            --炮台第一次进入屏幕
            if spriteA.isBettary==true then
                if spriteA.outBounds==0 then
                    spriteA.outBounds=spriteA.outBounds+1
                    return;
                end
            end

            BattleUtils.bulletEnd(spriteA)
        else
            --炮台第一次进入屏幕
            if spriteA.isBettary==true then
                if spriteA.outBounds==0 then
                    spriteA.outBounds=spriteA.outBounds+1
                    return;    
                end
            end
            BattleUtils.bulletEnd(spriteB)    
        end
            return true
        end
    return false
end

--子弹反弹之后
function BattleUtils.BulletOutOfScratch(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletGroup) and (gB==BattleGroup.ScratchGroup)) then
            
        if gA==BattleGroup.BulletGroup then
            if not (spriteA:getIsRebound()) then
                print("spriteA:getIsRebound()")
                return false
            end
            
            if spriteA.isBettary==true then
            	spriteA:reboundEnd()
            end
            --伤害加成
            local hurtAddition=spriteB:getParent():getHurtAddition()
            spriteA.changeDamage=spriteA.bulletInfo.damage*hurtAddition
            --飞行速度
            local speed=BattleUtils.bulletReboundVelocity(spriteB,spriteA)
            --速度加成
            BattleUtils.bulletReboundAngularVelocity(spriteB,spriteA)
            --子弹反弹攻击力 组
            BattleUtils.setBulletReboundHurt(spriteA)
            local speedAddition=spriteB:getParent():getSpeedAddition()
            --速度大于100%有效果
            if speedAddition>1.0 then
                local angle=getVelocityAngle(speed.x,speed.y)
                local maxReboundSpeed=spriteB:getParent():getMaxReboundSpeed()
                local rateRatio=(speedAddition-1.0)/(maxReboundSpeed-1.0)
                spriteA:showParticle(angle,rateRatio)
            end
--            
            spriteB:getParent():setScratchStatus(1)
            BattleUtils.ScratchCollision(spriteB)
            MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._FANTAN_);
         end
         
         return true
    end
    return false
end

--/////////////////////////////////////pause//////////////////////////////////
--反弹子弹与怪物碰撞     暂停
function BattleUtils.BulletCollisionEnemyPause(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.MonsterGroup)) 
        or ((gB==BattleGroup.BulletReboundGroup) and (gA==BattleGroup.MonsterGroup)) then
        if gA==BattleGroup.BulletReboundGroup then
            
            spriteB:getParent():dyingMode(spriteA)
            gameScene:addHitMonster(1)
            List.removeObj(MonsterManager,spriteB:getParent())
            
        else
            
            spriteA:getParent():dyingMode(spriteB)
            gameScene:addHitMonster(1)
            List.removeObj(MonsterManager,spriteA:getParent())
            
        end
        return true
    end
    return false
end
--子弹弹到屏幕 暂停模式用到了

function BattleUtils.BulletInOfBounds(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.BoundBoyGroup)) then
        if gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup then

            return BattleUtils.bulletcolling(spriteA)
        else

            --if isPauseScene() then 
            return BattleUtils.bulletcolling(spriteB)
                -- else
                -- return BattleUtils.bulletcolling(spriteB)
                -- end

        end
        return true
    end
    return false
end


--子弹跳出屏幕
function BattleUtils.BulletOutOfBoundsPause(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.BoundBoyGroup)) then
        ReboundOut=true
        if gA==BattleGroup.BulletGroup or gA==BattleGroup.BulletReboundGroup then
            local a=BattleUtils.BulletInOfBounds(spriteA,spriteB,gA,gB)
            if a then 
                BattleUtils.bulletEnd(spriteA)
--                Manager.addBullet(-1)
            else
            end

        else
            local b=BattleUtils.BulletInOfBounds(spriteA,spriteB,gA,gB)
            if b then 

            else
                BattleUtils.bulletEnd(spriteB)
--                Manager.addBullet(-1)
            end

        end
        ReboundOut=false
        return true
    end
    return false
end

--子弹碰撞
function BattleUtils.bulletcolling(sprite)
    if  sprite:getPositionY()<=DirectorUtils.getWinHeight()-sprite:getContentSize().height and 
        (sprite:getPositionY()>=sprite:getContentSize().height) then

        if ReboundOut==false then
            if sprite.reboundTimes<=0 then 
                BattleUtils.bulletEnd(sprite)
                Manager.addBullet(-1)
                return false
            else

                sprite.reboundTimes=sprite.reboundTimes-1
                return true

            end
        end
    else
        BattleUtils.bulletEnd(sprite)
        Manager.addBullet(-1)
        return false
    end
end
local test=0
--子弹反弹之后 暂停
function BattleUtils.BulletOutOfScratchPause(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletReboundGroup) and (gB==BattleGroup.ScratchGroup)) then

        if gA==BattleGroup.BulletReboundGroup then
            if not (spriteA:getIsRebound()) then
                return false
            end
            
            BattleUtils.bulletReboundAngularVelocityPasue(spriteA)
            BattleUtils.bulletReboundVelocityPause(spriteA)        
            
            MusicManager:GetInstance():PlayMusicOrEffect(MusicType._EFFECTMUSIC_,playEffectConstant._FANTAN_);
            spriteB:getParent()._bulletNum=spriteB:getParent()._bulletNum-1
            if spriteB:getParent()._bulletNum==0 then
                BattleUtils.ScratchCollision(spriteB)
            end
        end

        return true
    end
    return false
end

--/////////////////////////////////////pause//////////////////////////////////

--子弹反弹设置反弹速度加成 暂停
function BattleUtils.bulletReboundAngularVelocityPasue(bulletSprite)
    --旋转速度
    local avelocity=bulletSprite:getPhysicsBody():getAngularVelocity();
    --旋转速度加成

    --    local AvelocityAddition=1
    local newAvelocity=avelocity*2
    bulletSprite:getPhysicsBody():setAngularVelocity(newAvelocity)
    bulletSprite._aVelocity=newAvelocity
    return newAvelocity
end

--子弹反弹设置反弹速度加成 暂停场景
function BattleUtils.bulletReboundVelocityPause(bulletSprite)
    --飞行速度 
    local velocity=bulletSprite:getPhysicsBody():getVelocity();
    --速度加成
    print("velocityX=====",velocity.x)
    print("velocityY=====",velocity.y)
    
    local newSpeed=cc.vertex2F(velocity.x*2,velocity.y*2)
    bulletSprite:getPhysicsBody():setVelocity(newSpeed)
    bulletSprite._velocity=newSpeed
    print("newSpeedX=====",newSpeed.x)
    print("newSpeedY=====",newSpeed.y)
    print("bulletSprite._velocityX=====",bulletSprite._velocity.x)
    print("bulletSprite._velocityY=====",bulletSprite._velocity.y)
    return newSpeed
end

--子弹碰撞挡板
function BattleUtils.BulletCollisionScratchPause(spriteA,spriteB,gA,gB)
    if ((gA==BattleGroup.BulletGroup) and (gB==BattleGroup.ScratchGroup)) then
        if gA==BattleGroup.BulletGroup then
            local sizeA=spriteA.spriteSize;
            local sizeB=spriteB:getParent():getScratchSize();
            local sizeC=cc.size(spriteB:getParent():getScratchSize().width,spriteB:getParent():getScratchSize().height/8)
            local pointA=spriteA:getParent():convertToWorldSpace(cc.p(spriteA:getPosition()))
            local pointB=cc.p(spriteB:getPosition())
            local angleB=spriteB:getParent():getAngle();

            if not (isContainRect(pointA,pointB,sizeA,sizeC,angleB)) then
                print("isContainRect")
                spriteA:setIsRebound(false)
                --                BattleUtils.bulletEnd(spriteA)
                return false
            end
            print("test before====",test)
            BattleUtils.setBulletReboundHurt(spriteA)
            test=test+1
            print("BattleUtils.setBulletReboundHurt(spriteA)")
            print("test hou====",test)
            
            spriteA:setIsRebound(true)
            
            spriteB:getParent():setScratchStatus(2)
--            spriteB:getParent():setScratchStatus(1)
           
            spriteB:getParent()._bulletNum=spriteB:getParent()._bulletNum+1
            print("spriteB:getParent():setScratchStatus(2)") 
            
        end
        return true
    end
    return false
end
--狸猫am0001
--兔子am0002
--猴子arm0011
--松鼠arm0012
--青蛙arm0013
--羊sheep
--熊boss bear
function BattleUtils.ReturnMonsterTypeForConditionLayer(name)
    if name=="arm0011" then
        return "Monkey".." Killed"
    elseif name=="am0001" then
        return "LiMao".." Killed"
    elseif name=="am0002" then
        return "am0002".." Killed"
    elseif name=="arm0012" then
        return "arm0012".." Killed"
    elseif name=="arm0013" then
        return "arm0013".." Killed"
    elseif name=="sheep" then
        return "sheep".." Killed"
    end
end

--不杀怪物文字字符串
function BattleUtils.ReturnNotMonsterTypeForConditionLayer(name)
    if name=="arm0011" then
        return "Monkey".." unKilled"
    elseif name=="am0001" then
        return "LiMao".." unKilled"
    elseif name=="am0002" then
        return "am0002".." unKilled"
    elseif name=="arm0012" then
        return "arm0012".." unKilled"
    elseif name=="arm0013" then
        return "arm0013".." unKilled"
    elseif name=="sheep" then
        return "sheep".." unKilled"
    end
end

