require"Cocos2d"
require "GameDirectorUtils"

local PauseRubberLayer =class("PauseRubberLayer",function()
    return cc.Layer:create();
end)

local rubberEnum={
    scratchTag=1,
}

local scratetag

local curscratch=nil

function PauseRubberLayer.create()      
    local layer=PauseRubberLayer.new()
    layer:initWithScratch();
    return layer
end

function PauseRubberLayer:initWithScratch()
    scratetag=returnLevelTable(DirectorUtils.getCurSceneLevel()).pauseScratchNum
    curscratch=1
    
        for var=1, scratetag[curGroup] do
            local scratchDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).scratch

            local scratch = require("SpecialScratch")
            local ScratchSprite=scratch:create(scratchDatam.name)
            self:addChild(ScratchSprite,0,var)
        end
end

function PauseRubberLayer:setBeginPoint(beginPoint) 

    
       --if pauseMonster==true then
            local scratch=self:getChildByTag(curscratch)
            if scratch then
                scratch:setScratchBeginPoint(beginPoint);
            end
       -- end
  
end

function PauseRubberLayer:setEndPoint(EndPoint) 

    --if pauseMonster==true then
        local scratch=self:getChildByTag(curscratch)
        if scratch then
            scratch:setScratchEndPoint(EndPoint);
            if scratch.isShengcheng==true then
                curscratch=curscratch+1
            end

        end
    --end  
       
end

function PauseRubberLayer:setMovePoint(MovePoint) 
   -- if pauseMonster==true then
        local scratch=self:getChildByTag(rubberEnum.scratchTag)
        if scratch then
            scratch:setScratchMovePoint(MovePoint);
        end
   -- end
end

--挡板buff加成
function PauseRubberLayer:setBuffAddition(addition,time)
    local scratch=self:getChildByTag(rubberEnum.scratchTag)
    scratch:setBuffAddition(addition,time)
end

return PauseRubberLayer