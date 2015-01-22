
require "GameDirectorUtils"
--
--
--1001	新手引导完成

GUIDEINFO = {}
--
GUIDEINFO["1001"]={
    ["guide1"] = {pos_x=DirectorUtils.getWinWidth()/2, pos_y=DirectorUtils.getWinHeight()/2,
        stencil="chalkLine2.png",chand="chalkLine_hand.png",chandSpeed=300,subWidth=350,strMsg="Vegetables will appear as you use your finger to draw the lines."},

    ["guide2"] = {pos_x=DirectorUtils.getWinWidth()/2, pos_y=DirectorUtils.getWinHeight()/2,
        stencil="chalkLine1.png",chand="chalkLine_hand.png",subWidth=100,chandSpeed=100,strMsg="The shorter line you draw, the vegetable you get will be stronger"},
        
    count=2,    
}


function getConfigInfo(taskId)
	if GUIDEINFO[taskId] then
		return GUIDEINFO[taskId]
	else
		return false
	end
end

function getBeginnersTask()
    local gid=cc.UserDefault:getInstance():getBoolForKey("guide1001")
    
    if gid==true then
    	return nil 
    end
    local currentId="1001"   
    
    return currentId
    
end

function setBeginnersTask()
    cc.UserDefault:getInstance():setBoolForKey("guide1001",true)
    cc.UserDefault:getInstance():flush()
end

function isBeginnersTask(taskId)
    if beginnerGuide then
        if beginnerGuide.guideId==taskId then
            return true
        end
    end
    
    return false
end


