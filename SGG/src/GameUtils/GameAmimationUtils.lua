require "Cocos2d"
require "GlobalVariables"

GameAU={}


function GameAU.GameActionGetEase(action,easeType)

    local EaseAction=nil
    if easeType==animationEaseType.SpriteEaseSineOut then
        EaseAction=cc.EaseSineOut:create(action)
    end

    return EaseAction
end

function GameAU.GameActionMoveEaseCallBack(p1,p2,speed,callBack,easeType)

    local moveSpeed=getDistanceBetween(p1,p2)/speed
    local actionMove=cc.MoveTo:create(moveSpeed,p2)
    local easeMove=GameAU.GameActionGetEase(actionMove,easeType)    
    local sequence=cc.Sequence:create(actionMove,cc.CallFunc:create(callBack))

    return sequence
end

function GameAU.GameActionMoveEase(p1,p2,speed,easeType)

    local moveSpeed=getDistanceBetween(p1,p2)/speed
    local actionMove=cc.MoveTo:create(moveSpeed,p2)
    local easeMove=GameAU.GameActionGetEase(actionMove,easeType)    
    return actionMove
end

function GameAU.GameActionChalk(p1,p2,speed,isForever,isBack)

    local moveSpeed=getDistanceBetween(p1,p2)/speed
    
    local p3=cc.pSub(p2,p1)
    local actionMove=cc.MoveBy:create(moveSpeed,p3)
    
    if isBack then
        local actionBack=actionMove:reverse()
        local sequence=cc.Sequence:create(actionMove,actionBack)
        
        if isForever then
            local forever=cc.RepeatForever:create(sequence)
            return forever
        end
        return sequence
    end
    return actionMove
end


function GameAU.GameActionMoveCallBack(p1,p2,speed,callBack)

    local moveSpeed=getDistanceBetween(p1,p2)/speed
    local actionMove=cc.MoveTo:create(moveSpeed,p2)
    local sequence=cc.Sequence:create(actionMove,cc.CallFunc:create(callBack))
--    sender:runAction(seuence)
    return sequence
end




function GameAU.GameActionMove(p1,p2,speed)
    local moveSpeed=getDistanceBetween(p1,p2)/speed
    local actionMove=cc.MoveTo:create(moveSpeed,p2)
    return actionMove
end

--多点移动动作
function GameAU.GameActionMovePointTableCall(beginPoint,PointTable,isForever,callBack)
    local actionQuence={};
    local function tableSortNumber(a,b)
        return a.number<b.number
    end
    table.sort(PointTable,tableSortNumber)
    for key, var in pairs(PointTable) do
      
        local p1=cc.p(var.endpoint[1],var.endpoint[2])
        local p2
        
        if key==#PointTable then
            p2=cc.p(PointTable[1].endpoint[1],PointTable[1].endpoint[2])
        else
            p2=cc.p(PointTable[key+1].endpoint[1],PointTable[key+1].endpoint[2])
        end
        
        local mSpeed=getDistanceBetween(p1,p2)/var.movespeed
        local actionmove=cc.MoveTo:create(mSpeed,p2)
        table.insert(actionQuence,actionmove)
        table.insert(actionQuence,cc.CallFunc:create(callBack))
    end
    
    local action
    if isForever then
        local sequence=cc.Sequence:create(actionQuence)
        action=cc.RepeatForever:create(sequence)
    else
        action=cc.Sequence:create(actionQuence)
    end
    
    return action
end

--动画
function GameAU.GameAnimate(name,isROF,isRF,delay)
--    local str=name.."_"..type
    local str=name
    local cannonAnimation=cc.AnimationCache:getInstance():getAnimation(str)
    cannonAnimation:setDelayPerUnit(delay);
    cannonAnimation:setRestoreOriginalFrame(isROF);
    local cannonAnimate=cc.Animate:create(cannonAnimation);
    
    if isRF then
        local RFAction=cc.RepeatForever:create(cannonAnimate)
        return RFAction
    else 
        return cannonAnimate
    end
end

--基础动画
function GameAU.GameBeseAnimate(name,isROF,delay)
    --    local str=name.."_"..type
    local str=name
    
--    print("animate name=",name)
    local cannonAnimation=cc.AnimationCache:getInstance():getAnimation(str)
    cannonAnimation:setDelayPerUnit(delay);
    cannonAnimation:setRestoreOriginalFrame(isROF);
    local cannonAnimate=cc.Animate:create(cannonAnimation);
    cannonAnimate:retain()
    return cannonAnimate
end

--动画回调
function GameAU.GameAnimateCall(name,callFunc,isROF,isRF,delay)
--    local str=name.."_"..type
    local str=name
    local cannonAnimation=cc.AnimationCache:getInstance():getAnimation(str)
    cannonAnimation:setDelayPerUnit(delay);
    cannonAnimation:setRestoreOriginalFrame(isROF);
    local cannonAnimate=cc.Animate:create(cannonAnimation);

    if isRF then
        local action=cc.Sequence:create(cannonAnimate,cc.CallFunc:create(callFunc));
        local RFAction=cc.RepeatForever:create(action)
        return RFAction
    else 
        local action=cc.Sequence:create(cannonAnimate,cc.CallFunc:create(callFunc))
        return action
    end
end

--
function GameAU.GameActionLeftOrRight(p1,p2)
    local x1=p1.x
    local x2=p2.x
    
    if (x1<x2) then
        return true
    end
    
    return false
end

function GameAU.pointIsLeftOrRight(monster,p)
    local x=math.abs(p.x)
    local spWidth=monster.spriteSize.width
    local anchorX=monster:getAnchorPoint().x
    
    if anchorX==0 then
        x=x+spWidth
    else
        x=x-spWidth    
    end
    
    local winWith=DirectorUtils.getWinWidth()*0.5
    if x>winWith then
        return false
    end
    return true    
end
