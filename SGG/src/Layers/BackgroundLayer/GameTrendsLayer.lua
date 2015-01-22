require "Cocos2d"
require "GameBattleUtils"
require "Data_Level"
require "GameAmimationUtils"
require "GlobalVariables"


local GameTrendsLayer =class("GameTrendsLayer",function()
    return cc.Layer:create();
end)

function GameTrendsLayer:ctor()      

end


function GameTrendsLayer.create()      
    local layer=GameTrendsLayer.new()
    layer:initWithWndmill()
    layer:setLayerPosition()
    return layer
end

function GameTrendsLayer:setLayerPosition()
    
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
--        local index=(curLevel-1)/(maxLevel-1)
--        bgY=index*height
--    else
--        bgY=0-heightDifference  
--    end    
    local pos=DirectorUtils.getBackgroundPosition()
    self:setPosition(cc.p(0,pos.y))
end

function GameTrendsLayer:initWithWndmill()
    local wndmill1=Wndmill.create(EnumWndmillType.WndmillType1)
    wndmill1:setPosition(-45,280)
    wndmill1:setRotation(50)
    self:addChild(wndmill1)
    
    local wndmill2=Wndmill.create(EnumWndmillType.WndmillType2)
    wndmill2:setPosition(685,-260)
    wndmill2:setRotation(-50)
    self:addChild(wndmill2)
    
    local wndmill3=Wndmill.create(EnumWndmillType.WndmillType3)
    wndmill3:setPosition(-35,-1180)
    wndmill3:setRotation(30)
    self:addChild(wndmill3)
end

return GameTrendsLayer