require "Cocos2d"
require "GameBattleUtils"
require "Data_Level"
require "GameAmimationUtils"
require "GlobalVariables"
require "Wndmill"
require "GameDirectorUtils"


local GameBGLayer =class("GameBGLayer",function()
    return cc.Layer:create();
end)

function GameBGLayer:ctor()      

end


function GameBGLayer.create()      
    local layer=GameBGLayer.new()
    layer:createBackground()
    layer:setLayerPosition()
    return layer
end

local function BglayerMoveCallBack(sender) 
    appscene:initBattleData(DirectorUtils.getCurSceneLevel())

    appscene:createPhysicsContact()
    --scene:createPhysicsEageBox()
    appscene:createGameLayer()
end

local function LoadingSceneBgCallBack(sender)
    sender:removeFromParent() 
    local SceneTable=#returnSceneTable()
    local level=DirectorUtils.getCurLevel()
    if level>=10 then
        local move = cc.MoveBy:create(0.8,cc.p(0,DirectorUtils.getWinHeight()))
        local ease = cc.EaseSineInOut:create(move);    --让目标动作由慢到快
        local callback = cc.CallFunc:create(BglayerMoveCallBack)
        local seq=cc.Sequence:create(ease,callback)
        self:runAction(seq)
    else
        appscene:initBattleData(DirectorUtils.getCurSceneLevel())

        appscene:createPhysicsContact()
        --scene:createPhysicsEageBox()
        appscene:createGameLayer()
    end
end

function GameBGLayer:setLayerPosition()
--    local dSize={640,1136}
--    
--    local heightDifference=0
--    if DirectorUtils.isDeviceFour() then
--        heightDifference=176
--    end
--    local maxLevel=returnSceneTableCount()
--    local curLevel=DirectorUtils.getCurLevel()
--    local bgY
--    local height=dSize[2]
--    if curLevel>1 then
--        local index=curLevel/maxLevel
--        bgY=index*height
--    else
--        bgY=0-heightDifference  
--    end 
    local pos=DirectorUtils.getBackgroundPosition()
    self:setPosition(pos)
end

function GameBGLayer:createBackground()

    local background=returnLevelTable(DirectorUtils.getCurSceneLevel()).backgroundJpg
    local back1=cc.Sprite:create(background.jpg1)
    local bgSize=back1:getContentSize()
    local p1=cc.p(0,bgSize.height/2)
    back1:setPosition(p1)
    self:addChild(back1)
    
    local back2=cc.Sprite:create(background.jpg2)
    local p2=cc.p(0,-bgSize.height/2)
    back2:setPosition(p2)
    self:addChild(back2)
    
end

return GameBGLayer