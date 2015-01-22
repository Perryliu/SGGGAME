require "Cocos2d"


--CC_CONTENT_SCALE_FACTOR = function()
--    return cc.Director:getInstance():getContentScaleFactor()
--end
--
--
--CC_POINT_PIXELS_TO_POINTS = function(pixels)
--    return cc.p(pixels.x/CC_CONTENT_SCALE_FACTOR(), pixels.y/CC_CONTENT_SCALE_FACTOR())
--end
--
--CC_POINT_POINTS_TO_PIXELS = function(points)
--    return cc.p(points.x*CC_CONTENT_SCALE_FACTOR(), points.y*CC_CONTENT_SCALE_FACTOR())
--end
--
--function DEGREES_TO_RADIANS(__ANGLE__) 
--    return __ANGLE__ * 0.01745329252
--end
--function RADIANS_TO_DEGREES(__ANGLE__)
--    return __ANGLE__ * 57.29577951
--end

DirectorUtils={}

function DirectorUtils.getWinWidth()
    local width=cc.Director:getInstance():getWinSize().width
    return width
end

function DirectorUtils.getWinHeight()
    local height=cc.Director:getInstance():getWinSize().height
    return height
end

function DirectorUtils.getWinSize()
    local size=cc.Director:getInstance():getWinSize()
    return size
end

function DirectorUtils.getCurScene()
    local playerScene=cc.UserDefault:getInstance():getIntegerForKey("curScene")
--    if type(playerScene)~="number" then
--    	playerScene=1
--    end
    
    local scene=tonumber(playerScene)
--    print("getCurScene====",playerScene)
    return scene
end

function DirectorUtils.getCurLevel()
    local playerLevel=cc.UserDefault:getInstance():getIntegerForKey("curLevel")
--    if type(playerLevel)~="number" then
--        playerLevel=1
--    end
    
    local level=tonumber(playerLevel)
    print("level===",level)
    return level
end

function DirectorUtils.getCurSceneLevel()
    local playerScene=cc.UserDefault:getInstance():getIntegerForKey("curScene")
    local playerLevel=cc.UserDefault:getInstance():getIntegerForKey("curLevel")
    
    local scene=tostring(playerScene)
    local level=tostring(playerLevel)
    --    print("level===",level)
    
    local current=scene.."_"..level
    print("current===",current)
    
    return current
end

function DirectorUtils.pauseGetCurSceneLevel()
    local playerScene=cc.UserDefault:getInstance():getIntegerForKey("curScene")
    local playerLevel=cc.UserDefault:getInstance():getIntegerForKey("curLevel")

    local scene=tostring(playerScene)
    local level=tostring(playerLevel)
    --    print("level===",level)

    local current=scene.."_"..level

    return current
end

--是否是iphone4
function DirectorUtils.isDeviceFour()
    local frameSize=cc.Director:getInstance():getOpenGLView():getFrameSize()
    
    if frameSize.width==640 and frameSize.height==960 then
    	return true
    end
    
    return false
end

--适配iphone4 坐标
function DirectorUtils.setPhoneFourPosition(pos)
    if DirectorUtils.isDeviceFour() then
        if type(pos)=="table" then
            --适配iphone4 怪物坐标
            local heigthDifference=176
            local newPos=cc.p(pos.x,pos.y-176)  
            return newPos
		end
	end		
    
    return pos
end

--背景层动态层坐标
function DirectorUtils.getBackgroundPosition()
    local dSize={640,1136}

    local heightDifference=0
    if DirectorUtils.isDeviceFour() then
        heightDifference=176
    end
    local maxLevel=returnSceneTableCount()
    local curLevel=DirectorUtils.getCurLevel()
    local bgY
    local height=dSize[2]
    if curLevel>1 then
        local index=(curLevel-1)/(maxLevel-1)
        bgY=index*height
    else
        bgY=0-heightDifference  
    end    
    local pos=cc.p(dSize[1]*0.5,bgY)
    
    return pos
end
