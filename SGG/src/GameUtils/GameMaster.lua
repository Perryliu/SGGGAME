require "Helper"
require "GlobalVariables"
require "Data_Level"
require "LayerManager"
require "BaerBoss"
require "HoneyBee"
require "LMonster"
require "LNeutral"
require "LRemoteMonster"
require "Manager"
require "LBettary"


local GameMaster = class("GameMaster")

local size = cc.Director:getInstance():getWinSize()

local function removeMonster(monster)
    if monster.monsterType~=EnumRaceType.NEUTRALMONSTER then
        --减少一个怪物
        gameMaster:addEnemies(-1)
    elseif  monster.monsterType==EnumRaceType.NEUTRALMONSTER then
        monster:neutralDeadtrigger()
    end
end

function GameMaster:ctor()
    self.totaltime = 0
    self.logicFrq = 1.0
    self.tatolMonster=0
    self.gameTime=0
    self.isBossType=false    
end

function GameMaster.create()
    local gm = GameMaster.new()
    gm:init()
    return gm
end

function GameMaster:init()    
    self.gameTime=returnLevelTable(DirectorUtils.getCurSceneLevel()).gameTime
end

--boss 关卡
function GameMaster:addGameboss(type)

    self.isBossType=true
    self.bossType=type
    
    if type==GameType.Game_Type_boss_1 then
        local honeyBeeData=returnLevelTable(DirectorUtils.getCurSceneLevel()).honeyBee
        local baerBossData=returnLevelTable(DirectorUtils.getCurSceneLevel()).bossMonster
        
        self:addBaerBoss(baerBossData)
        self:addHoneyBee(honeyBeeData)
    elseif type==GameType.Game_Type_boss_2 then
    
    elseif type==GameType.Game_Type_boss_3 then
    
    elseif type==GameType.Game_Type_boss_4 then
    
    end
    
end


function GameMaster:getTotaltime()
    return self.totaltime
end


--按刷新时间排序怪物
local function tableSortRefreshTme(a,b)
    return a.refreshtime<b.refreshtime
end

--增加远程怪物
function GameMaster:addWeapon(weaponDatam)
    --怪物总数量
    local count=#(weaponDatam)
    self.tatolMonster=self.tatolMonster+count
    for var=1, count do
        local weapon=LRemoteMonster.create(weaponDatam[var])
--        weapon:initWithData()
        weapon:setTag(weaponEnum.weaponTag+var)
        List.pushlast(WeaponPool,weapon)
        weapon:retain()
    end
end

--增加远程炮台
function GameMaster:addBettary(BatteryDatam)
    local count=#(BatteryDatam)
    for var=1, count do
        local bettary=LBettary.create(BatteryDatam[var])
        List.pushlast(BatteryPool,bettary)
        bettary:retain()
    end
end

--增加近战怪物
function GameMaster:addMonster(monsterDatam)
   local count=#(monsterDatam)
    self.tatolMonster=self.tatolMonster+count
   
    for var=1, count do
        local monster=LMonster.create(monsterDatam[var])
--        monster:initWithData()
        monster:setTag(monsterEnum.monsterTag+var)
        List.pushlast(MonsterPool,monster)
        monster:retain()
    end
end

--增加重力怪物
function GameMaster:addNeutral(neutralDatam)
    local count=#(neutralDatam)
    for var=1, count do
        local neutral=LNeutralMonster.create(neutralDatam[var])
        neutral:setTag(neutralEnum.neutralTag+var)
        List.pushlast(NuertalPool,neutral)
        neutral:retain()
    end
end

--增加近战怪物
function GameMaster:neutralChangeMonster(neutralDatam,type)
    self.tatolMonster=self.tatolMonster+1

    local monster=LMonster.create(neutralDatam)
    List.pushlast(MonsterPool,monster)
    monster:retain()
end

function GameMaster:neutralChangeWeapon(neutralDatam,type)
    self.tatolMonster=self.tatolMonster+1
    local weapon=LRemoteMonster.create(neutralDatam)
    weapon:initWithData()
    weapon:setMonsterHitType(type)
    List.pushlast(WeaponPool,weapon)
    weapon:retain()
end

--增加蜜蜂
function GameMaster:addHoneyBee(honeyBeeDatam)
    local count=#(honeyBeeDatam)
    for var=1, count do
        local honeyBee=HoneyBee.create(honeyBeeDatam[var])
        --蜜蜂tag
        honeyBee:setTag(HoneyBeeEnum.honeyBeelTag+var)
        List.pushlast(HoneyBeePool,honeyBee)
        honeyBee:retain()
    end
end

--增加熊boss
function GameMaster:addBaerBoss(bearBossDatam)
    local count=#(bearBossDatam)
    self.tatolMonster=self.tatolMonster+count
    for var=1, count do
        local baerBoss=BaerBoss.create(bearBossDatam[var])
        --熊tag
        baerBoss:setTag(BaerBossEnum.baerBossTag+var)
        List.pushlast(BossPool,baerBoss)
        baerBoss:retain()
    end
end

function GameMaster:update(dt)
    self.totaltime = self.totaltime + dt
    
    gameUserDataLayer:setTimeLabel(self.totaltime)
    --如果当前关卡设置限制时间（游戏时间大于0） 时间到游戏失败结束
    if self.gameTime>0 then
        if self.totaltime>=self.gameTime then
            MessageDispatchCenter:getInstance():dispatchMessage(MessageDispatchCenter.MessageType.GAME_OVER,false)
            return;
        end
    end
    
    self:logicUpdate(dt)
end

-- 游戏主逻辑处理
function GameMaster:logicUpdate(dt)  
    self:showWeapon()
    self:showMonster()
    self:showNeutral()
    self:showBettary()
    if self.isBossType then
        self:showBoss()
    end
    --处理怪物特性（发射子弹/触发效果）
    self:monsterAction(dt)
    self:winGameOver()
end

--显示boss
function GameMaster:showBoss()

   if self.bossType~=nil then
        if self.bossType==GameType.Game_Type_boss_1 then
            self:showBearBoss()     
            self:showHoneyBee()
        elseif self.bossType==GameType.Game_Type_boss_2 then

        elseif self.bossType==GameType.Game_Type_boss_3 then

        elseif self.bossType==GameType.Game_Type_boss_4 then

        end
   end
end

--近战怪物
function GameMaster:showMonster()
    if List.getSize(MonsterPool)~=0 then
        local tempMonsterData={}
        copyTable(MonsterPool,tempMonsterData)
        
        for var=tempMonsterData.first,tempMonsterData.last do
            local monster=List.popfirst(tempMonsterData)
            if self.totaltime-monster.refreshtime>=0 then
                gameCurrentLayer:addChild(monster)
                monster:updateState()
                
                List.pushlast(MonsterManager, monster)
                List.removeObj(MonsterPool,monster)    
            end
        end
    end
end

--炮台
function GameMaster:showBettary()
    if List.getSize(BatteryPool)~=0 then
        local tempMonsterData={}
        copyTable(BatteryPool,tempMonsterData)

        for var=tempMonsterData.first,tempMonsterData.last do
            local bettary=List.popfirst(tempMonsterData)
            if self.totaltime-bettary.refreshtime>=0 then
                gameCurrentLayer:addChild(bettary)
                List.pushlast(BatteryManager, bettary)
                List.removeObj(BatteryPool,bettary)    
            end
        end
    end
end

--远程怪物
function GameMaster:showWeapon()
    if List.getSize(WeaponPool)~=0 then
        local tempWeaponData={}
        copyTable(WeaponPool,tempWeaponData)
        
        for var=tempWeaponData.first,tempWeaponData.last do
            local weapon=List.popfirst(tempWeaponData)
            if self.totaltime-weapon.refreshtime>=0 then
                gameCurrentLayer:addChild(weapon)
                weapon:updateState()
                List.pushlast(MonsterManager, weapon)
                List.removeObj(WeaponPool,weapon)    
            end
        end
    end
end

--中立怪物
function GameMaster:showNeutral()

    if List.getSize(NuertalPool)~=0 then
        local tempMonsterData={}
        copyTable(NuertalPool,tempMonsterData)

        for var=tempMonsterData.first,tempMonsterData.last do
            local nuertal=List.popfirst(tempMonsterData)
            if self.totaltime-nuertal.refreshtime>=0 then
                gameCurrentLayer:addChild(nuertal)
                nuertal:updateState()
                List.pushlast(MonsterManager, nuertal)
                List.removeObj(NuertalPool,nuertal)    
            end
        end
    end
end

--熊boss
function GameMaster:showBearBoss()
    if List.getSize(BossPool)~=0 then
        local tempData={}
        copyTable(BossPool,tempData)

        for var=tempData.first,tempData.last do
            local boss=List.popfirst(tempData)
            if self.totaltime-boss.refreshtime>=0 then
                print("showBearBossshowBearBossshowBearBoss")
                gameCurrentLayer:addChild(boss)
                boss:updateState()
                self:initWithAdded()  
                List.pushlast(BossManager, boss)
                List.removeObj(BossPool,boss)    
            end
        end
    end
end

--显示蜂巢
function GameMaster:showHoneyBee()
    if List.getSize(HoneyBeePool)~=0 then
        local tempData={}
        copyTable(HoneyBeePool,tempData)

        for var=tempData.first,tempData.last do
            local honeyBee=List.popfirst(tempData)
            if self.totaltime-honeyBee.refreshtime>=0 then
                gameCurrentLayer:addChild(honeyBee,1)

                List.pushlast(AddedManager, honeyBee)
                List.removeObj(HoneyBeePool,honeyBee)    
            end
        end
    end
end

--初始化组件(蜂巢...)
function GameMaster:initWithAdded()
    if List.getSize(AddedManager)~=0 then
        for var=AddedManager.first,AddedManager.last do
            local added=List.popfirst(AddedManager)
            if added.monsterType==EnumRaceType.HONEYBEE then
                added:showOneHoney(added)
            end    
        end
    end
end

--初始化组件(蜂巢...)
function GameMaster:removeAddedData()
    if List.getSize(AddedManager)~=0 then
        for var=AddedManager.first,AddedManager.last do
            local added=List.popfirst(AddedManager)
            if added.monsterType==EnumRaceType.HONEYBEE then
                added:removeData()
            end    
        end
    end
end


--怪物发射子弹 中立怪物触发效果
function GameMaster:monsterAction(dt)
--    if List.getSize(MonsterManager)~=0 then    
--        for var=MonsterManager.first,MonsterManager.last do
--            local monster=MonsterManager[var]
--            --远程怪物发射子弹
--            if monster.monsterType==EnumRaceType.REMOTEMONSTER then
--                monster:remoteShootBullet(dt)
--            --中立怪物触发时间
--            elseif  monster.monsterType==EnumRaceType.NEUTRALMONSTER then    
--                monster:neutralExitTime(dt)
--            end
--        end
--    end
--    
    if List.getSize(BatteryManager)~=0 then
        for var=BatteryManager.first,BatteryManager.last do
            local monster=BatteryManager[var]
            --远程炮台发射子弹
            if monster==nil then
            	return
            end
            
            if monster.monsterType==EnumRaceType.BETTARY then
                monster:remoteShootBullet(dt)
            end
        end
    end
end

--怪物数量的处理 赢利判断
function GameMaster:addEnemies(eIndex)
    local enemies=self.tatolMonster
    print("_totalEnemies==",self.tatolMonster) 
    self.tatolMonster=enemies+eIndex
    print("_totalEnemies==",self.tatolMonster)    
end

function GameMaster:winGameOver()
    if self.tatolMonster<=0 then
        print("_totalEnemies<=0==",self.tatolMonster) 
        MessageDispatchCenter:getInstance():dispatchMessage(MessageDispatchCenter.MessageType.GAME_OVER,true)
        print("_totalEnemies<=0aaaa",self.tatolMonster) 
    end
end

function GameMaster:lostGameOver()
    print("hp<=0==",self.tatolMonster) 
    MessageDispatchCenter:getInstance():dispatchMessage(MessageDispatchCenter.MessageType.GAME_OVER,false)
end

function GameMaster:removeBattleData()
    --清楚游戏附件中内存 计时器
    self:removeAddedData()
    
end


return GameMaster


