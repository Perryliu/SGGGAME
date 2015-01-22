require"Cocos2d"
require "GameDirectorUtils"

local RubberLayer =class("RubberLayer",function()
    return cc.Layer:create();
end)

local rubberEnum={
    scratchTag=1,
}


function RubberLayer.create()      
    local layer=RubberLayer.new()
    layer:initWithScratch();
    return layer
end

function RubberLayer:initWithScratch()
    local scratchDatam=returnLevelTable(DirectorUtils.getCurSceneLevel()).scratch
--    local scratch=curveScratch:createCurveScratch(scratchDatam.name);
    local scratch=require("Scratch").create(scratchDatam.name)
    self:addChild(scratch,0,rubberEnum.scratchTag)
end

function RubberLayer:setBeginPoint(beginPoint) 
    local scratch=self:getChildByTag(rubberEnum.scratchTag)
    scratch:setScratchBeginPoint(beginPoint);
end

function RubberLayer:setEndPoint(EndPoint) 
    local scratch=self:getChildByTag(rubberEnum.scratchTag)
    scratch:setScratchEndPoint(EndPoint);
end

function RubberLayer:setMovePoint(MovePoint) 
    local scratch=self:getChildByTag(rubberEnum.scratchTag)
    scratch:setScratchMovePoint(MovePoint);
end

--挡板buff加成
function RubberLayer:setBuffAddition(addition,time)
    local scratch=self:getChildByTag(rubberEnum.scratchTag)
    scratch:setBuffAddition(addition,time)
end

function RubberLayer:removeAllData()
    self:removeChildByTag(rubberEnum.scratchTag,false)
end

return RubberLayer