require "Helper"
require "GlobalVariables"
require "Data_Level"
require "LayerManager"
require "BaerBoss"
require "HoneyBee"
require "BMonster"
require "LNeutral"
require "PRemoteMonster"
require "Manager"


local GameMasterPause = class("GameMasterPause")

local size = cc.Director:getInstance():getWinSize()

--暂停计时器
pauseTime=0
--local isShootEnd=false
local function removeMonsterPause(monster)
    if monster.monsterType~=EnumRaceType.NEUTRALMONSTER then
        --减少一个怪物
        Manager.addEnemies(-1)
        
            --Manager
            gameScene:addHitMonster(1)
        
    elseif  monster.monsterType==EnumRaceType.NEUTRALMONSTER then
        monster:neutralDeadtrigger()
    end

end

function GameMasterPause:ctor()
    self.totaltime = 0
    self.logicFrq = 1.0
    self.tatolMonster=0
    self.gameTime=0
    self.isBossType=false    
end

function GameMasterPause.create()
    local gm = GameMasterPause.new()
    gm:init()
    return gm
end

function GameMasterPause:init()
    
    MessageDispatchCenter:getInstance():registerCustiomEvent(MessageDispatchCenter.MessageType.REMOVE_MONSTER,removeMonster)
    
    self.gameTime=returnLevelTable(DirectorUtils.getCurSceneLevel()).gameTime
end


function GameMasterPause:getTotaltime()
    return self.totaltime
end


--按刷新时间排序怪物
local function tableSortRefreshTme(a,b)
    return a.refreshtime<b.refreshtime
end

--增加远程怪物
function GameMasterPause:addWeapon(weaponDatam)
    --怪物总数量
    local count=#(weaponDatam)
    self.tatolMonster=self.tatolMonster+count
    for var=1, count do
        local weapon=PRemoteMonster.create(weaponDatam[var])
        --weapon:initWithData()
        weapon:setTag(weaponEnum.weaponTag+var)
        List.pushlast(WeaponPool,weapon)
        weapon:retain()
    end
end

--增加近战怪物
function GameMasterPause:addMonster(monsterDatam)
   local count=#(monsterDatam)
    self.tatolMonster=self.tatolMonster+count
   
    for var=1, count do
        local monster=BMonster.create(monsterDatam[var])
       -- monster:initWithData()
        monster:setTag(monsterEnum.monsterTag+var)
        List.pushlast(MonsterPool,monster)
        monster:retain()
    end
end

--增加重力怪物
function GameMasterPause:addNeutral(neutralDatam)
    local count=#(neutralDatam)
    for var=1, count do
        local neutral=LNeutralMonster.create(neutralDatam[var])
        --neutral:initWithData()
        neutral:setTag(neutralEnum.neutralTag+var)
        List.pushlast(NuertalPool,neutral)
        neutral:retain()
    end
end

--增加近战怪物
function GameMasterPause:neutralChangeMonster(neutralDatam,type)
    self.tatolMonster=self.tatolMonster+1

    local monster=LMonster.create(neutralDatam)
    --monster:initWithData()
    monster:setMonsterHitType(type)
    List.pushlast(MonsterPool,monster)
    monster:retain()
end

function GameMasterPause:neutralChangeWeapon(neutralDatam,type)
    self.tatolMonster=self.tatolMonster+1
    local weapon=LRemoteMonster.create(neutralDatam)
    --weapon:initWithData()
    weapon:setMonsterHitType(type)
    List.pushlast(WeaponPool,weapon)
    weapon:retain()
end



function GameMasterPause:update(dt)
    self.totaltime = self.totaltime + dt
    
    --如果当前关卡设置限制时间（游戏时间大于0） 时间到游戏失败结束
--    if self.gameTime>0 then
--        if self.totaltime>=self.gameTime then
--            MessageDispatchCenter:getInstance():dispatchMessage(MessageDispatchCenter.MessageType.GAME_OVER,false)
--            return;
--        end
--    end
    
    self:logicUpdate(dt)
end

function GameMasterPause:logicUpdate(dt)
   
        if showAllMonster==false then
            self:showWeapon()
            self:showMonster()
            --self:showNeutral()
            showAllMonster=true
        end
        self:monsterAction(dt)

    
    
    
end


--近战怪物
function GameMasterPause:showMonster()
    if List.getSize(MonsterPool)~=0 then
        local tempMonsterData={}
        copyTable(MonsterPool,tempMonsterData)
        
        for var=tempMonsterData.first,tempMonsterData.last do
            local monster=List.popfirst(tempMonsterData)
            
             
                if monster.group==curGroup then
                    gameCurrentLayer:addChild(monster)
                    monster:updateState()

                    List.pushlast(MonsterManager, monster)
                    List.removeObj(MonsterPool,monster) 
                end
          
            
            
        end
    end
end

--远程怪物
function GameMasterPause:showWeapon()
    if List.getSize(WeaponPool)~=0 then
        local tempWeaponData={}
        copyTable(WeaponPool,tempWeaponData)
        
        for var=tempWeaponData.first,tempWeaponData.last do
            local weapon=List.popfirst(tempWeaponData)
            --判断是否为暂停场景
            
                if weapon.group==curGroup then
                    gameCurrentLayer:addChild(weapon)
                    weapon:updateState()
                    List.pushlast(MonsterManager, weapon)
                    List.removeObj(WeaponPool,weapon)    
                end
            
        end
        local a=1
    end
end

--中立怪物
function GameMasterPause:showNeutral()

    if List.getSize(NuertalPool)~=0 then
        local tempMonsterData={}
        copyTable(NuertalPool,tempMonsterData)

        for var=tempMonsterData.first,tempMonsterData.last do
            local nuertal=List.popfirst(tempMonsterData)
            if self.totaltime-nuertal.refreshtime>=0 then
                nuertal:LMove()
                gameCurrentLayer:addChild(nuertal)
                if nuertal.isMove==1 then
                    nuertal:Move()
                end  
                List.pushlast(MonsterManager, nuertal)
                List.removeObj(NuertalPool,nuertal)    
            end
        end
    end
end


--怪物发射子弹 中立怪物触发效果
function GameMasterPause:monsterAction(dt)
    
end


function ShootingPause(dt)
    pauseTime=pauseTime+dt
    local abc=returnLevelTable(DirectorUtils.pauseGetCurSceneLevel()).totaltime
    local totalpausetime=abc
    local grouptime=totalpausetime[curGroup]
    if pauseTime >=grouptime  then
       gameCurrentLayer:getParent():pauseAll()
       pauseMonster=true
       --pauseUpdate=false
       isNext=false
       pauseTime=0
       cc.Director:getInstance():getScheduler():unscheduleScriptEntry(gameMaster.ShootingPauseID)
       gameMaster.ShootingPauseID=nil
    end
    
end

--重新刷新暂停函数update
function GameMasterPause:resetPauseUpdateBool()
    --false为没开启  
	pauseUpdate=false
end



return GameMasterPause


