require "Helper"
require "GlobalVariables"
require "Data_Level"
require "LayerManager"

Manager={}


WeaponPool = List.new()
NuertalPool = List.new()
MonsterPool = List.new()
BatteryPool = List.new()


BossPool= List.new()
HoneyBeePool= List.new()


--getPoolByName
function getPoolByName(name)
    if name == BattleDataPool.WEAPON_POOL then
        print("BattleDataPool.WEAPON_POOL")
        return WeaponPool
    elseif name == BattleDataPool.MONSTER_POOL then
        return MonsterPool
    elseif name == BattleDataPool.NUETRAL_POOL then
        return NuertalPool
    elseif name == BattleDataPool.BOSS_POOL then
        return NuertalPool
    end
end


BossManager = List.new()
MonsterManager = List.new()
AddedManager=List.new()
BulletManager=List.new()
BatteryManager=List.new()


--删除战斗中的数据 怪物 中力怪
function Manager.removePoolWithObject(name,object)
    local pool=getPoolByName(name)
    return List.removeObj(pool,object)
end

function Manager.removePoolWithIndex(name,index)
    local pool=getPoolByName(name)
    return List.remove(pool,index)
end

function Manager.removePoolAllObject(name)
    local pool=getPoolByName(name)
    List.removeAll(pool)
end

--农场血量处理
function Manager.addPlantsHp(collider)
    gameUserDataLayer:hurt(collider)
end

function Manager.collision(object)
    for val = HeroManager.first, HeroManager.last do
        local sprite = HeroManager[val]
        if sprite._isalive and sprite ~= object then
            solveCollision(sprite, object)
        end
    end

    for val = MonsterManager.first, MonsterManager.last do
        local sprite = MonsterManager[val]
        if sprite._isalive == true and sprite ~= object then
            solveCollision(sprite, object)
        end                  
    end      
end

function Manager.neutralResult(neutarl)
    local p=getPosTable(neutarl)
    
    local neutarlTempData=neutarl.Resultdata
    print("x===",p.x,p.y)
    --我方直接扣生命值
    if neutarl.result==neutralMonsterResult.deductLife then                   
        Manager.addPlantsHp(neutarlTempData)

        --回复我方的生命值 
    elseif neutarl.result==neutralMonsterResult.recoverLife then
        local hurt=neutarlTempData.damage
        neutarlTempData.damage=-hurt
        Manager.addPlantsHp(neutarlTempData)  

        --变为近战敌人攻击我方（可被攻击杀死）
    elseif neutarl.result==neutralMonsterResult.changeMdie then
        --        addMonster(name,action,point)
        print("changeMdie")
        Manager.addMonster(neutarlTempData,p,MonsterType.Monster_Type_Normal)

        --变为近战敌人攻击我方（不可被攻击）
    elseif neutarl.result==neutralMonsterResult.changeMNotHit then
        print("changeMNotHit")
        local tempData=neutarl.Resultdata
        Manager.addMonster(neutarlTempData,p,MonsterType.Monster_Type_Invincible)

        --变为近战敌人攻击我方（不可被攻击）    
    elseif neutarl.result==neutralMonsterResult.changeMNotDie then
        print("changeMNotDie")
        local tempData=neutarl.Resultdata
        Manager.addMonster(neutarlTempData,p,MonsterType.Monster_Type_Invincible_Hit)

        --变成远程敌人攻击我方（可以被攻击杀死）
    elseif neutarl.result==neutralMonsterResult.changeWdie then
        print("changeWdie")
        Manager.addCannon(neutarlTempData,p,MonsterType.Monster_Type_Normal)
        --随机攻击一个敌人
    elseif neutarl.result==neutralMonsterResult.randomHit then

    --攻击指定的一个敌人
    elseif neutarl.result==neutralMonsterResult.hitTargetEnemy then

    --增加挡板反弹的伤害（可以设置加成数值）值
    elseif neutarl.result==neutralMonsterResult.addScratch then
        local addition=neutarlTempData.buffAddition
        local time=neutarlTempData.buffTime
        if rLayer then
            rLayer:setBuffAddition(addition,time)
        end
        --爆炸造成范围伤害(可以设置范围数值)
    elseif neutarl.result==neutralMonsterResult.blowHurt then

    end
end

function Manager.addMonster(neutarlTempData,position,type)
    neutarlTempData["refreshtime"]=gameMaster:getTotaltime()
    neutarlTempData["point"]={position.x,position.y}
    gameMaster:neutralChangeMonster(neutarlTempData,type)
end

function Manager.addCannon(neutarlTempData,position,type)
    neutarlTempData["refreshtime"]=gameMaster:getTotaltime()
    neutarlTempData["point"]={position.x,position.y}
    gameMaster:neutralChangeWeapon(neutarlTempData,type)
end

local function isMeleeMonsterAttack(object) 
    if (object:getStateType()~=EnumStateType.ATTACKING) 
        and (object:getStateType()~=EnumStateType.DYING)
        and  (object:getStateType()~=EnumStateType.DEAD) then
    	return true
    end
    
    return false
end


local function solveCollision(object1,object2)
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
        if isMeleeMonsterAttack(object1)  then
    		object1:attackMode()
            object1:normalAttack()
    	end
    end
end

--判断是否出界 未判断锚点
function isOutOfBound(object,point)

    local currentPos
    if point then
        currentPos = point;  
    else 
        currentPos = cc.p(object:getPosition());   	
    end
    local mSize=object.spriteSize
    local mWidth=mSize.width/2
    local mHeight=mSize.height/2
    
    local winWidth=DirectorUtils.getWinWidth()
    local winHeight=DirectorUtils.getWinHeight()
    
    
    if currentPos.x+mWidth > winWidth then
        return true
    end    

    if currentPos.x-mWidth < 0 then
        return true
    end

    if currentPos.y+mHeight > winHeight then
        return true
    end    

--    if currentPos.y-mHeight < 0 then
--        return true
--    end

    return false
end

--判断是否完全在界外 未判断锚点
function isAllOutOfBound(object,point)

    local currentPos
    if point then
        currentPos = point;  
    else 
        currentPos = cc.p(object:getPosition());    
    end
    local mSize=object.spriteSize
    local mWidth=mSize.width/2
    local mHeight=mSize.height/2

    local winWidth=DirectorUtils.getWinWidth()
    local winHeight=DirectorUtils.getWinHeight()


    if currentPos.x-mWidth > winWidth then
        return true
    end    

    if currentPos.x+mWidth < 0 then
        return true
    end

    if currentPos.y-mHeight > winHeight then
        return true
    end    

    --    if currentPos.y-mHeight < 0 then
    --        return true
    --    end

    return false
end

--检测碰撞和销毁对象
function collisionDetect(dt)
    --cclog("collisionDetect")
    for val = MonsterManager.last, MonsterManager.first, -1 do
        local sprite = MonsterManager[val]
        if sprite.isalive == true then
            if sprite.monsterType==EnumRaceType.MONSTER then
                --是否进去攻击农场区域
--                solveCollision(sprite,farmland)
            end     
        else
            List.remove(MonsterManager, val)
        end
    end 
    
    for val = BossManager.last, BossManager.first, -1 do
        local sprite = BossManager[val]
        if sprite.isalive == true then
            if sprite.monsterType==EnumRaceType.BAERBOSS then
                --是否进去攻击农场区域
                solveCollision(sprite,farmland)
                if isOutOfBound(sprite) then
--                	sprite:stopBaerAction()
--                	sprite:movementUpdate()
                end
            end     
        else
            List.remove(BossManager, val)
        end
    end             
end

--计算农场和怪物的最短距离
function shortestDistanceOfFarmland(object)
    if farmland then
        local monsterPos = cc.p(object:getPosition())
        local FarmlandPos = cc.p(farmland:getPosition())
        
        local mSize=object.spriteSize
        local fSize=farmland:getContentSize()
        
        local distance1=monsterPos.y-mSize.height/2
        local distance2=FarmlandPos.y+fSize.height/2
        
        local distance=distance1-distance2
        return distance
    end
end

--怪物移动完回调    暂停场景的
local MoveDelete=0
local MoveNumcallback=0
local function MonsterManagerMoveCall(sender)
    sender.isalive=false
    sender:setStateType(EnumStateType.DYING)
    --List.removeObj(MonsterManager,sender) 
    if sender.monsterSprite:getPhysicsBody() then
        sender.monsterSprite:getPhysicsBody():removeFromWorld();
    end
    --sender:End()
    sender:removeFromParent()
    List.removeObj(MonsterManager,sender)

    if List.getSize(MonsterManager)==0 then
        --MessageDispatchCenter:getInstance():dispatchMessage(MessageDispatchCenter.MessageType.GAME_OVER,true)
        local data = returnLevelTable(DirectorUtils.getCurSceneLevel()).pauseTime
        if curGroup<#data then

            curGroup=curGroup+1
            print("curGroup======%d",curGroup)
            gameScene:resetGroupBulletNumber()
            gameScene:resetScratchLayer()
        else
            if isOver then
                gameScene:pausegameOver()
                isOver=false
            end

        end
    end



end

--暂停模式子弹数量控制输赢处理
function Manager.addBullet(bulnum)
    bulletNumber=bulletNumber+bulnum

    if bulletNumber<=0 then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameScene.gameControllerScheduleID)
        if (curGroup>=#returnLevelTable(DirectorUtils.getCurSceneLevel()).pauseTime) then 
            List.removeAll(MonsterManager)
            gameScene:pausegameOver()
        else
            --这里是判断是否场景上还剩下怪物进行移动完之后的删除
            if List.getSize(MonsterManager)~=0 then
                --
                MoveDelete=List.getSize(MonsterManager)
                for val = MonsterManager.first, MonsterManager.last do
                    local sprite = MonsterManager[val]
                    local p1=cc.p(sprite:getPositionX(),sprite:getPositionY())
                    local p2=cc.p(p1.x,0)
                    local action =GameAU.GameActionMoveCallBack(p1,p2,450,MonsterManagerMoveCall)
                    sprite:runAction(action)
                    --sprite:Move() 
                    sprite:playAnimation("walk", true)  
                end
                --List.removeAll(MonsterManager)
            else
                local data = returnLevelTable(DirectorUtils.getCurSceneLevel()).pauseTime
                if curGroup<#data then

                    curGroup=curGroup+1
                    gameScene:resetGroupBulletNumber()
                    gameScene:resetScratchLayer()
                else
                    if isOver then
                        isOver=false
                        gameScene:pausegameOver()

                    end
                end   
            end
        end
        --        if curGroup<3 then
        --            curGroup=curGroup+1
        --            gameScene:resetGroupBulletNumber()
        --            gameScene:resetScratchLayer()
        --        else
        --            gameScene:pausegameOver()
        --        end   
    end

end
