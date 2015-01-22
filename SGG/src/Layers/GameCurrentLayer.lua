require "Cocos2d"
require "GameBattleUtils"
require "Data_Level"
require "GameAmimationUtils"
require "GlobalVariables"
require "Manager"
require "Helper"
require "MessageDispatchCenter"

local GameCurrentLayer =class("GameCurrentLayer",function()
    return cc.Layer:create();
end)

function GameCurrentLayer:ctor()      
    
end


function GameCurrentLayer.create()      
    local layer=GameCurrentLayer.new()
    return layer
end

function GameCurrentLayer:GuidePauseMonster()
    if List.getSize(MonsterManager)~=0 then
        for var=MonsterManager.first,MonsterManager.last do
            local monster= MonsterManager[var]
            monster:pause()    
        end
    end
end

function GameCurrentLayer:GuideResumeMonster()
    if List.getSize(MonsterManager)~=0 then
        for var=MonsterManager.first,MonsterManager.last do
            local monster= MonsterManager[var]
            monster:resume()    
        end
    end
end

--/////////////////////////////////////pasue/////////////////////////////////////
--暂停关卡  暂停 
function GameCurrentLayer:PauseMonster()
    if List.getSize(MonsterManager)~=0 then
        local tempWeaponData={}
        copyTable(MonsterManager,tempWeaponData)

        for var=tempWeaponData.first,tempWeaponData.last do
            local monster=List.popfirst(tempWeaponData)
            if monster.group==curGroup then
                monster:pause()    
            end
        end
    end

end
--暂停关卡  恢复
function GameCurrentLayer:resumeMonster()
    if List.getSize(MonsterManager)~=0 then
        local tempWeaponData={}
        copyTable(MonsterManager,tempWeaponData)

        for var=tempWeaponData.first,tempWeaponData.last do
            local monster=List.popfirst(tempWeaponData)
            if monster.group==curGroup then
                monster:resume()    
            end
        end
    end
end
--/////////////////////////////////////pasue/////////////////////////////////////

--/////////////////////////////////////pasue/////////////////////////////////////
--暂停关卡  暂停 
function GameCurrentLayer:PauseGameMonster()
    if List.getSize(MonsterManager)~=0 then
        for var=MonsterManager.first,MonsterManager.last do
            local monster=MonsterManager[var]
                monster:pause()    
        end
    end
    
    if List.getSize(BossManager)~=0 then
        for var=BossManager.first,BossManager.last do
            local monster=BossManager[var]
            monster:pause()    
        end
    end

end
--暂停关卡  恢复
function GameCurrentLayer:resumeGameMonster()

    if List.getSize(MonsterManager)~=0 then
        for var=MonsterManager.first,MonsterManager.last do
            local monster=MonsterManager[var]
            monster:resume()    
        end
    end
    
    if List.getSize(BossManager)~=0 then
        for var=BossManager.first,BossManager.last do
            local monster=BossManager[var]
            monster:resume()    
        end
    end
end
--/////////////////////////////////////pasue/////////////////////////////////////

return GameCurrentLayer