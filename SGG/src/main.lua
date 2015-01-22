require "Cocos2d"


-- cclog
local cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    local fileTb={
        "src",
        "res",
        "src/Scenes",
        "src/Layers",
        "src/GameUtils",
        "src/GameData",
        "src/GameConfig",
        "src/GameCompent",
        "src/Layers/BackgroundLayer",
        "res/battle",
        "res/UserData",
        "res/fonts",
        "res/gold",
        "res/shop",
        "res/ui",
        "res/xin",
        "res/comic",
        "res/Level",
        "res/Scene",
        "src/actors",
        "res/bullet",
        "res/Props",
        "res/batttleBG",
        "res/Guide",
        "res/music",
        "res/firstLogo",
        "res/apple",
        "res/gameover",
        "res/apple/123",
        "res/CondLayer",
        "res/Light",
    }
    cc.FileUtils:getInstance():setSearchPaths(fileTb);
    
    require "GameDirectorUtils"
    if DirectorUtils.isDeviceFour() then
        cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(640, 960, 0)
    else
        cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(640, 1136, 0)    
    end
   
    --local a = math.sin(math.rad(30))
    print("local gameScene = GameUIManager:GameStateChoose(1)")
    --create scene

    --加载资源
    print("loadingGameCecheloadingGameCecheloadingGameCecheloadingGameCeche")
    require "GameBattleUtils"
    loadingGameCeche()
    GameUIManager:removeGamePlayLogo() 
    
    local gameScene = GameUIManager:GameStateChoose(1)

    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(gameScene)
    else
        cc.Director:getInstance():runWithScene(gameScene)
    end
    
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end