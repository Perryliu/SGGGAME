#include "lua_cocos2dx_myCustom_auto.hpp"
#include "GameUIManager.h"
#include "SGGBulletSprite.h"
#include "UserData.h"
#include "MusicManager.h"
#include "SGGShake.h"
#include "DrawScratchLine.h"
#include "ProgressBar.h"
#include "PowerSlider.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_cocos2dx_myCustom_GameUIManager_exitBattleScene(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        GameUIManager::exitBattleScene();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "exitBattleScene",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_exitBattleScene'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_GameUIManager_StopGame(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        GameUIManager::StopGame();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "StopGame",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_StopGame'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_GameUIManager_RestartGame(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        GameUIManager::RestartGame();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "RestartGame",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_RestartGame'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_GameUIManager_openGameOverLayer(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        GameUIManager::openGameOverLayer();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "openGameOverLayer",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_openGameOverLayer'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_GameUIManager_ResumeGame(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        GameUIManager::ResumeGame();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "ResumeGame",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_ResumeGame'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_GameUIManager_GameStateChoose(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        GameState arg0;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        if(!ok)
            return 0;
        cocos2d::Scene* ret = GameUIManager::GameStateChoose(arg0);
        object_to_luaval<cocos2d::Scene>(tolua_S, "cc.Scene",(cocos2d::Scene*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "GameStateChoose",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_GameStateChoose'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_GameUIManager_removeGamePlayLogo(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        GameUIManager::removeGamePlayLogo();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "removeGamePlayLogo",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_removeGamePlayLogo'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_GameUIManager_EnterBattleScene(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"GameUIManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        GameUIManager::EnterBattleScene();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "EnterBattleScene",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_GameUIManager_EnterBattleScene'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_myCustom_GameUIManager_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (GameUIManager)");
    return 0;
}

int lua_register_cocos2dx_myCustom_GameUIManager(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"GameUIManager");
    tolua_cclass(tolua_S,"GameUIManager","GameUIManager","",nullptr);

    tolua_beginmodule(tolua_S,"GameUIManager");
        tolua_function(tolua_S,"exitBattleScene", lua_cocos2dx_myCustom_GameUIManager_exitBattleScene);
        tolua_function(tolua_S,"StopGame", lua_cocos2dx_myCustom_GameUIManager_StopGame);
        tolua_function(tolua_S,"RestartGame", lua_cocos2dx_myCustom_GameUIManager_RestartGame);
        tolua_function(tolua_S,"openGameOverLayer", lua_cocos2dx_myCustom_GameUIManager_openGameOverLayer);
        tolua_function(tolua_S,"ResumeGame", lua_cocos2dx_myCustom_GameUIManager_ResumeGame);
        tolua_function(tolua_S,"GameStateChoose", lua_cocos2dx_myCustom_GameUIManager_GameStateChoose);
        tolua_function(tolua_S,"removeGamePlayLogo", lua_cocos2dx_myCustom_GameUIManager_removeGamePlayLogo);
        tolua_function(tolua_S,"EnterBattleScene", lua_cocos2dx_myCustom_GameUIManager_EnterBattleScene);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(GameUIManager).name();
    g_luaType[typeName] = "GameUIManager";
    g_typeCast["GameUIManager"] = "GameUIManager";
    return 1;
}

int lua_cocos2dx_myCustom_SGGBulletSprite_hideParticle(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_hideParticle'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->hideParticle(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "hideParticle",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_hideParticle'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_removeBullet(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_removeBullet'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->removeBullet();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "removeBullet",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_removeBullet'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_setBulletScale(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setBulletScale'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setBulletScale(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setBulletScale",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setBulletScale'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_setIsRebound(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setIsRebound'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        bool arg0;

        ok &= luaval_to_boolean(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setIsRebound(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setIsRebound",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setIsRebound'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_setHurt(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setHurt'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setHurt(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setHurt",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setHurt'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_getBulletSize(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getBulletSize'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Size ret = cobj->getBulletSize();
        size_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getBulletSize",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getBulletSize'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_init(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_init'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->init(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "init",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_init'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_showParticle(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_showParticle'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        double arg0;
        double arg1;

        ok &= luaval_to_number(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        cobj->showParticle(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "showParticle",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_showParticle'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_setBulletSize(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setBulletSize'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Size arg0;

        ok &= luaval_to_size(tolua_S, 2, &arg0);
        if(!ok)
            return 0;
        cobj->setBulletSize(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setBulletSize",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_setBulletSize'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_getHurt(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getHurt'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getHurt();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getHurt",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getHurt'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_getBulletScale(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getBulletScale'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getBulletScale();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getBulletScale",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getBulletScale'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_getIsRebound(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGBulletSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getIsRebound'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        bool ret = cobj->getIsRebound();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getIsRebound",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_getIsRebound'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"SGGBulletSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        SGGBulletSprite* ret = SGGBulletSprite::create(arg0);
        object_to_luaval<SGGBulletSprite>(tolua_S, "SGGBulletSprite",(SGGBulletSprite*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_create'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_SGGBulletSprite_constructor(lua_State* tolua_S)
{
    int argc = 0;
    SGGBulletSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new SGGBulletSprite();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"SGGBulletSprite");
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "SGGBulletSprite",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGBulletSprite_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_cocos2dx_myCustom_SGGBulletSprite_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (SGGBulletSprite)");
    return 0;
}

int lua_register_cocos2dx_myCustom_SGGBulletSprite(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"SGGBulletSprite");
    tolua_cclass(tolua_S,"SGGBulletSprite","SGGBulletSprite","cc.Sprite",nullptr);

    tolua_beginmodule(tolua_S,"SGGBulletSprite");
        tolua_function(tolua_S,"new",lua_cocos2dx_myCustom_SGGBulletSprite_constructor);
        tolua_function(tolua_S,"hideParticle",lua_cocos2dx_myCustom_SGGBulletSprite_hideParticle);
        tolua_function(tolua_S,"removeBullet",lua_cocos2dx_myCustom_SGGBulletSprite_removeBullet);
        tolua_function(tolua_S,"setBulletScale",lua_cocos2dx_myCustom_SGGBulletSprite_setBulletScale);
        tolua_function(tolua_S,"setIsRebound",lua_cocos2dx_myCustom_SGGBulletSprite_setIsRebound);
        tolua_function(tolua_S,"setHurt",lua_cocos2dx_myCustom_SGGBulletSprite_setHurt);
        tolua_function(tolua_S,"getBulletSize",lua_cocos2dx_myCustom_SGGBulletSprite_getBulletSize);
        tolua_function(tolua_S,"init",lua_cocos2dx_myCustom_SGGBulletSprite_init);
        tolua_function(tolua_S,"showParticle",lua_cocos2dx_myCustom_SGGBulletSprite_showParticle);
        tolua_function(tolua_S,"setBulletSize",lua_cocos2dx_myCustom_SGGBulletSprite_setBulletSize);
        tolua_function(tolua_S,"getHurt",lua_cocos2dx_myCustom_SGGBulletSprite_getHurt);
        tolua_function(tolua_S,"getBulletScale",lua_cocos2dx_myCustom_SGGBulletSprite_getBulletScale);
        tolua_function(tolua_S,"getIsRebound",lua_cocos2dx_myCustom_SGGBulletSprite_getIsRebound);
        tolua_function(tolua_S,"create", lua_cocos2dx_myCustom_SGGBulletSprite_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(SGGBulletSprite).name();
    g_luaType[typeName] = "SGGBulletSprite";
    g_typeCast["SGGBulletSprite"] = "SGGBulletSprite";
    return 1;
}

int lua_cocos2dx_myCustom_UserData_getCurScene(lua_State* tolua_S)
{
    int argc = 0;
    UserData* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (UserData*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_UserData_getCurScene'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getCurScene();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCurScene",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getCurScene'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_UserData_getMaxLevel(lua_State* tolua_S)
{
    int argc = 0;
    UserData* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (UserData*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_UserData_getMaxLevel'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getMaxLevel();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getMaxLevel",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getMaxLevel'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_UserData_setSceneLevelGetPlants(lua_State* tolua_S)
{
    int argc = 0;
    UserData* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (UserData*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_UserData_setSceneLevelGetPlants'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 3) 
    {
        int arg0;
        int arg1;
        int arg2;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);

        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);

        ok &= luaval_to_int32(tolua_S, 4,(int *)&arg2);
        if(!ok)
            return 0;
        cobj->setSceneLevelGetPlants(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setSceneLevelGetPlants",argc, 3);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setSceneLevelGetPlants'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_UserData_getCurLevel(lua_State* tolua_S)
{
    int argc = 0;
    UserData* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (UserData*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_UserData_getCurLevel'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getCurLevel();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCurLevel",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getCurLevel'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_UserData_getSceneMaxLevel(lua_State* tolua_S)
{
    int argc = 0;
    UserData* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (UserData*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_UserData_getSceneMaxLevel'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        int arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        if(!ok)
            return 0;
        int ret = cobj->getSceneMaxLevel(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getSceneMaxLevel",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getSceneMaxLevel'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_UserData_getMaxScene(lua_State* tolua_S)
{
    int argc = 0;
    UserData* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (UserData*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_UserData_getMaxScene'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getMaxScene();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getMaxScene",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getMaxScene'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_UserData_getSceneLevelMaxPlants(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        int arg0;
        int arg1;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        int ret = UserData::getSceneLevelMaxPlants(arg0, arg1);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getSceneLevelMaxPlants",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getSceneLevelMaxPlants'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setGameSceneType(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        int arg0;
        int arg1;
        GameSceneType arg2;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        ok &= luaval_to_int32(tolua_S, 4,(int *)&arg2);
        if(!ok)
            return 0;
        UserData::setGameSceneType(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setGameSceneType",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setGameSceneType'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_GetInstance(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        UserData* ret = UserData::GetInstance();
        object_to_luaval<UserData>(tolua_S, "UserData",(UserData*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "GetInstance",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_GetInstance'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_getSceneLevelGetApple(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        int arg0;
        int arg1;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        int ret = UserData::getSceneLevelGetApple(arg0, arg1);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getSceneLevelGetApple",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getSceneLevelGetApple'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setCurLevel(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        int arg0;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        if(!ok)
            return 0;
        UserData::setCurLevel(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setCurLevel",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setCurLevel'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setCurScene(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        int arg0;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        if(!ok)
            return 0;
        UserData::setCurScene(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setCurScene",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setCurScene'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setLevelGoal(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        int arg0;
        int arg1;
        double arg2;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        ok &= luaval_to_number(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        UserData::setLevelGoal(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setLevelGoal",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setLevelGoal'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setSceneLevelMaxPlants(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        int arg0;
        int arg1;
        int arg2;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        ok &= luaval_to_int32(tolua_S, 4,(int *)&arg2);
        if(!ok)
            return 0;
        UserData::setSceneLevelMaxPlants(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setSceneLevelMaxPlants",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setSceneLevelMaxPlants'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setMaxScene(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        int arg0;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        if(!ok)
            return 0;
        UserData::setMaxScene(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setMaxScene",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setMaxScene'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_getGameSceneType(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        int arg0;
        int arg1;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        int ret = UserData::getGameSceneType(arg0, arg1);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getGameSceneType",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getGameSceneType'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_getLevelGoal(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S)-1;

    do 
    {
        if (argc == 2)
        {
            int arg0;
            ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
            if (!ok) { break; }
            int arg1;
            ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
            if (!ok) { break; }
            double ret = UserData::getLevelGoal(arg0, arg1);
            tolua_pushnumber(tolua_S,(lua_Number)ret);
            return 1;
        }
    } while (0);
    ok  = true;
    do 
    {
        if (argc == 3)
        {
            int arg0;
            ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
            if (!ok) { break; }
            int arg1;
            ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
            if (!ok) { break; }
            int arg2;
            ok &= luaval_to_int32(tolua_S, 4,(int *)&arg2);
            if (!ok) { break; }
            double ret = UserData::getLevelGoal(arg0, arg1, arg2);
            tolua_pushnumber(tolua_S,(lua_Number)ret);
            return 1;
        }
    } while (0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d", "getLevelGoal",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getLevelGoal'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_getLevelMaxApple(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        int arg0;
        int arg1;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        int ret = UserData::getLevelMaxApple(arg0, arg1);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getLevelMaxApple",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getLevelMaxApple'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_getAppleLevelGoal(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        int arg0;
        int arg1;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        double ret = UserData::getAppleLevelGoal(arg0, arg1);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getAppleLevelGoal",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getAppleLevelGoal'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setLevelMaxApple(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        int arg0;
        int arg1;
        int arg2;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        ok &= luaval_to_int32(tolua_S, 4,(int *)&arg2);
        if(!ok)
            return 0;
        UserData::setLevelMaxApple(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setLevelMaxApple",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setLevelMaxApple'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setSceneLevelGetApple(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        int arg0;
        int arg1;
        int arg2;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        ok &= luaval_to_int32(tolua_S, 4,(int *)&arg2);
        if(!ok)
            return 0;
        UserData::setSceneLevelGetApple(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setSceneLevelGetApple",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setSceneLevelGetApple'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_getSceneLevelGetPlants(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        int arg0;
        int arg1;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        int ret = UserData::getSceneLevelGetPlants(arg0, arg1);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getSceneLevelGetPlants",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_getSceneLevelGetPlants'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_setMaxLevel(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"UserData",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        int arg0;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        if(!ok)
            return 0;
        UserData::setMaxLevel(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "setMaxLevel",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_setMaxLevel'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_UserData_constructor(lua_State* tolua_S)
{
    int argc = 0;
    UserData* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new UserData();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"UserData");
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "UserData",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_UserData_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_cocos2dx_myCustom_UserData_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (UserData)");
    return 0;
}

int lua_register_cocos2dx_myCustom_UserData(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"UserData");
    tolua_cclass(tolua_S,"UserData","UserData","cc.Ref",nullptr);

    tolua_beginmodule(tolua_S,"UserData");
        tolua_function(tolua_S,"new",lua_cocos2dx_myCustom_UserData_constructor);
        tolua_function(tolua_S,"getCurScene",lua_cocos2dx_myCustom_UserData_getCurScene);
        tolua_function(tolua_S,"getMaxLevel",lua_cocos2dx_myCustom_UserData_getMaxLevel);
        tolua_function(tolua_S,"setSceneLevelGetPlants",lua_cocos2dx_myCustom_UserData_setSceneLevelGetPlants);
        tolua_function(tolua_S,"getCurLevel",lua_cocos2dx_myCustom_UserData_getCurLevel);
        tolua_function(tolua_S,"getSceneMaxLevel",lua_cocos2dx_myCustom_UserData_getSceneMaxLevel);
        tolua_function(tolua_S,"getMaxScene",lua_cocos2dx_myCustom_UserData_getMaxScene);
        tolua_function(tolua_S,"getSceneLevelMaxPlants", lua_cocos2dx_myCustom_UserData_getSceneLevelMaxPlants);
        tolua_function(tolua_S,"setGameSceneType", lua_cocos2dx_myCustom_UserData_setGameSceneType);
        tolua_function(tolua_S,"GetInstance", lua_cocos2dx_myCustom_UserData_GetInstance);
        tolua_function(tolua_S,"getSceneLevelGetApple", lua_cocos2dx_myCustom_UserData_getSceneLevelGetApple);
        tolua_function(tolua_S,"setCurLevel", lua_cocos2dx_myCustom_UserData_setCurLevel);
        tolua_function(tolua_S,"setCurScene", lua_cocos2dx_myCustom_UserData_setCurScene);
        tolua_function(tolua_S,"setLevelGoal", lua_cocos2dx_myCustom_UserData_setLevelGoal);
        tolua_function(tolua_S,"setSceneLevelMaxPlants", lua_cocos2dx_myCustom_UserData_setSceneLevelMaxPlants);
        tolua_function(tolua_S,"setMaxScene", lua_cocos2dx_myCustom_UserData_setMaxScene);
        tolua_function(tolua_S,"getGameSceneType", lua_cocos2dx_myCustom_UserData_getGameSceneType);
        tolua_function(tolua_S,"getLevelGoal", lua_cocos2dx_myCustom_UserData_getLevelGoal);
        tolua_function(tolua_S,"getLevelMaxApple", lua_cocos2dx_myCustom_UserData_getLevelMaxApple);
        tolua_function(tolua_S,"getAppleLevelGoal", lua_cocos2dx_myCustom_UserData_getAppleLevelGoal);
        tolua_function(tolua_S,"setLevelMaxApple", lua_cocos2dx_myCustom_UserData_setLevelMaxApple);
        tolua_function(tolua_S,"setSceneLevelGetApple", lua_cocos2dx_myCustom_UserData_setSceneLevelGetApple);
        tolua_function(tolua_S,"getSceneLevelGetPlants", lua_cocos2dx_myCustom_UserData_getSceneLevelGetPlants);
        tolua_function(tolua_S,"setMaxLevel", lua_cocos2dx_myCustom_UserData_setMaxLevel);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(UserData).name();
    g_luaType[typeName] = "UserData";
    g_typeCast["UserData"] = "UserData";
    return 1;
}

int lua_cocos2dx_myCustom_MusicManager_loadMusicOrEffect(lua_State* tolua_S)
{
    int argc = 0;
    MusicManager* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"MusicManager",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (MusicManager*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_MusicManager_loadMusicOrEffect'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        const char* arg0;
        MusicType arg1;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();

        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        cobj->loadMusicOrEffect(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "loadMusicOrEffect",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_MusicManager_loadMusicOrEffect'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_MusicManager_PlayMusicOrEffect(lua_State* tolua_S)
{
    int argc = 0;
    MusicManager* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"MusicManager",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (MusicManager*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_MusicManager_PlayMusicOrEffect'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        MusicType arg0;
        int arg1;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);

        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        cobj->PlayMusicOrEffect(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "PlayMusicOrEffect",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_MusicManager_PlayMusicOrEffect'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_MusicManager_changeEffectState(lua_State* tolua_S)
{
    int argc = 0;
    MusicManager* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"MusicManager",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (MusicManager*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_MusicManager_changeEffectState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        bool arg0;

        ok &= luaval_to_boolean(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->changeEffectState(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "changeEffectState",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_MusicManager_changeEffectState'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_MusicManager_changeMusicState(lua_State* tolua_S)
{
    int argc = 0;
    MusicManager* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"MusicManager",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (MusicManager*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_MusicManager_changeMusicState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        bool arg0;

        ok &= luaval_to_boolean(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->changeMusicState(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "changeMusicState",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_MusicManager_changeMusicState'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_MusicManager_PreLoadALlEffect(lua_State* tolua_S)
{
    int argc = 0;
    MusicManager* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"MusicManager",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (MusicManager*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_MusicManager_PreLoadALlEffect'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->PreLoadALlEffect();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "PreLoadALlEffect",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_MusicManager_PreLoadALlEffect'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_MusicManager_GetInstance(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"MusicManager",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        MusicManager* ret = MusicManager::GetInstance();
        object_to_luaval<MusicManager>(tolua_S, "MusicManager",(MusicManager*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "GetInstance",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_MusicManager_GetInstance'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_myCustom_MusicManager_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (MusicManager)");
    return 0;
}

int lua_register_cocos2dx_myCustom_MusicManager(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"MusicManager");
    tolua_cclass(tolua_S,"MusicManager","MusicManager","cc.Ref",nullptr);

    tolua_beginmodule(tolua_S,"MusicManager");
        tolua_function(tolua_S,"loadMusicOrEffect",lua_cocos2dx_myCustom_MusicManager_loadMusicOrEffect);
        tolua_function(tolua_S,"PlayMusicOrEffect",lua_cocos2dx_myCustom_MusicManager_PlayMusicOrEffect);
        tolua_function(tolua_S,"changeEffectState",lua_cocos2dx_myCustom_MusicManager_changeEffectState);
        tolua_function(tolua_S,"changeMusicState",lua_cocos2dx_myCustom_MusicManager_changeMusicState);
        tolua_function(tolua_S,"PreLoadALlEffect",lua_cocos2dx_myCustom_MusicManager_PreLoadALlEffect);
        tolua_function(tolua_S,"GetInstance", lua_cocos2dx_myCustom_MusicManager_GetInstance);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(MusicManager).name();
    g_luaType[typeName] = "MusicManager";
    g_typeCast["MusicManager"] = "MusicManager";
    return 1;
}

int lua_cocos2dx_myCustom_SGGShake_initWithDuration(lua_State* tolua_S)
{
    int argc = 0;
    SGGShake* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SGGShake",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SGGShake*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_SGGShake_initWithDuration'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 3) 
    {
        double arg0;
        double arg1;
        double arg2;

        ok &= luaval_to_number(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        bool ret = cobj->initWithDuration(arg0, arg1, arg2);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "initWithDuration",argc, 3);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGShake_initWithDuration'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_SGGShake_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"SGGShake",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        double arg0;
        double arg1;
        ok &= luaval_to_number(tolua_S, 2,&arg0);
        ok &= luaval_to_number(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        SGGShake* ret = SGGShake::create(arg0, arg1);
        object_to_luaval<SGGShake>(tolua_S, "SGGShake",(SGGShake*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGShake_create'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_SGGShake_createWithStrength(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"SGGShake",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        double arg0;
        double arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0);
        ok &= luaval_to_number(tolua_S, 3,&arg1);
        ok &= luaval_to_number(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        SGGShake* ret = SGGShake::createWithStrength(arg0, arg1, arg2);
        object_to_luaval<SGGShake>(tolua_S, "SGGShake",(SGGShake*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "createWithStrength",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGShake_createWithStrength'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_SGGShake_constructor(lua_State* tolua_S)
{
    int argc = 0;
    SGGShake* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new SGGShake();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"SGGShake");
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "SGGShake",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_SGGShake_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_cocos2dx_myCustom_SGGShake_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (SGGShake)");
    return 0;
}

int lua_register_cocos2dx_myCustom_SGGShake(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"SGGShake");
    tolua_cclass(tolua_S,"SGGShake","SGGShake","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"SGGShake");
        tolua_function(tolua_S,"new",lua_cocos2dx_myCustom_SGGShake_constructor);
        tolua_function(tolua_S,"initWithDuration",lua_cocos2dx_myCustom_SGGShake_initWithDuration);
        tolua_function(tolua_S,"create", lua_cocos2dx_myCustom_SGGShake_create);
        tolua_function(tolua_S,"createWithStrength", lua_cocos2dx_myCustom_SGGShake_createWithStrength);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(SGGShake).name();
    g_luaType[typeName] = "SGGShake";
    g_typeCast["SGGShake"] = "SGGShake";
    return 1;
}

int lua_cocos2dx_myCustom_DrawScratchLine_setS_endPoint(lua_State* tolua_S)
{
    int argc = 0;
    DrawScratchLine* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (DrawScratchLine*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_DrawScratchLine_setS_endPoint'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Point arg0;

        ok &= luaval_to_point(tolua_S, 2, &arg0);
        if(!ok)
            return 0;
        cobj->setS_endPoint(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setS_endPoint",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_setS_endPoint'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_DrawScratchLine_getS_endPoint(lua_State* tolua_S)
{
    int argc = 0;
    DrawScratchLine* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (DrawScratchLine*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_DrawScratchLine_getS_endPoint'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Point ret = cobj->getS_endPoint();
        point_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getS_endPoint",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_getS_endPoint'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_DrawScratchLine_restDrawPoint(lua_State* tolua_S)
{
    int argc = 0;
    DrawScratchLine* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (DrawScratchLine*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_DrawScratchLine_restDrawPoint'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->restDrawPoint();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "restDrawPoint",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_restDrawPoint'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_DrawScratchLine_onDraw(lua_State* tolua_S)
{
    int argc = 0;
    DrawScratchLine* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (DrawScratchLine*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_DrawScratchLine_onDraw'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        cocos2d::Mat4 arg0;
        unsigned int arg1;

        ok &= luaval_to_mat4(tolua_S, 2, &arg0);

        ok &= luaval_to_uint32(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        cobj->onDraw(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "onDraw",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_onDraw'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_DrawScratchLine_init(lua_State* tolua_S)
{
    int argc = 0;
    DrawScratchLine* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (DrawScratchLine*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_DrawScratchLine_init'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        bool ret = cobj->init();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "init",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_init'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_DrawScratchLine_setS_beginPoint(lua_State* tolua_S)
{
    int argc = 0;
    DrawScratchLine* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (DrawScratchLine*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_DrawScratchLine_setS_beginPoint'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Point arg0;

        ok &= luaval_to_point(tolua_S, 2, &arg0);
        if(!ok)
            return 0;
        cobj->setS_beginPoint(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setS_beginPoint",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_setS_beginPoint'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_DrawScratchLine_getS_beginPoint(lua_State* tolua_S)
{
    int argc = 0;
    DrawScratchLine* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (DrawScratchLine*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_DrawScratchLine_getS_beginPoint'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Point ret = cobj->getS_beginPoint();
        point_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getS_beginPoint",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_getS_beginPoint'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_DrawScratchLine_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"DrawScratchLine",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        DrawScratchLine* ret = DrawScratchLine::create();
        object_to_luaval<DrawScratchLine>(tolua_S, "DrawScratchLine",(DrawScratchLine*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_DrawScratchLine_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_myCustom_DrawScratchLine_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (DrawScratchLine)");
    return 0;
}

int lua_register_cocos2dx_myCustom_DrawScratchLine(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"DrawScratchLine");
    tolua_cclass(tolua_S,"DrawScratchLine","DrawScratchLine","cc.Node",nullptr);

    tolua_beginmodule(tolua_S,"DrawScratchLine");
        tolua_function(tolua_S,"setS_endPoint",lua_cocos2dx_myCustom_DrawScratchLine_setS_endPoint);
        tolua_function(tolua_S,"getS_endPoint",lua_cocos2dx_myCustom_DrawScratchLine_getS_endPoint);
        tolua_function(tolua_S,"restDrawPoint",lua_cocos2dx_myCustom_DrawScratchLine_restDrawPoint);
        tolua_function(tolua_S,"onDraw",lua_cocos2dx_myCustom_DrawScratchLine_onDraw);
        tolua_function(tolua_S,"init",lua_cocos2dx_myCustom_DrawScratchLine_init);
        tolua_function(tolua_S,"setS_beginPoint",lua_cocos2dx_myCustom_DrawScratchLine_setS_beginPoint);
        tolua_function(tolua_S,"getS_beginPoint",lua_cocos2dx_myCustom_DrawScratchLine_getS_beginPoint);
        tolua_function(tolua_S,"create", lua_cocos2dx_myCustom_DrawScratchLine_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(DrawScratchLine).name();
    g_luaType[typeName] = "DrawScratchLine";
    g_typeCast["DrawScratchLine"] = "DrawScratchLine";
    return 1;
}

int lua_cocos2dx_myCustom_ProgressBar_progressBy(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_progressBy'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->progressBy(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "progressBy",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_progressBy'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_setC_Hp(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_setC_Hp'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setC_Hp(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setC_Hp",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_setC_Hp'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_initWithBarSprite(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_initWithBarSprite'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Sprite* arg0;

        ok &= luaval_to_object<cocos2d::Sprite>(tolua_S, 2, "cc.Sprite",&arg0);
        if(!ok)
            return 0;
        bool ret = cobj->initWithBarSprite(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "initWithBarSprite",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_initWithBarSprite'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_getC_Hp(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_getC_Hp'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getC_Hp();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getC_Hp",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_getC_Hp'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_progressTo(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_progressTo'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->progressTo(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "progressTo",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_progressTo'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_setBackground(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_setBackground'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Node* arg0;

        ok &= luaval_to_object<cocos2d::Node>(tolua_S, 2, "cc.Node",&arg0);
        if(!ok)
            return 0;
        cobj->setBackground(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setBackground",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_setBackground'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_setCurcentHp(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_setCurcentHp'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setCurcentHp(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setCurcentHp",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_setCurcentHp'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_getBackground(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_getBackground'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Node* ret = cobj->getBackground();
        object_to_luaval<cocos2d::Node>(tolua_S, "cc.Node",(cocos2d::Node*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getBackground",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_getBackground'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_getCurcentHp(lua_State* tolua_S)
{
    int argc = 0;
    ProgressBar* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ProgressBar*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_ProgressBar_getCurcentHp'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getCurcentHp();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCurcentHp",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_getCurcentHp'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_ProgressBar_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"ProgressBar",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        cocos2d::Sprite* arg0;
        ok &= luaval_to_object<cocos2d::Sprite>(tolua_S, 2, "cc.Sprite",&arg0);
        if(!ok)
            return 0;
        ProgressBar* ret = ProgressBar::create(arg0);
        object_to_luaval<ProgressBar>(tolua_S, "ProgressBar",(ProgressBar*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_ProgressBar_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_myCustom_ProgressBar_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (ProgressBar)");
    return 0;
}

int lua_register_cocos2dx_myCustom_ProgressBar(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"ProgressBar");
    tolua_cclass(tolua_S,"ProgressBar","ProgressBar","cc.ProgressTimer",nullptr);

    tolua_beginmodule(tolua_S,"ProgressBar");
        tolua_function(tolua_S,"progressBy",lua_cocos2dx_myCustom_ProgressBar_progressBy);
        tolua_function(tolua_S,"setC_Hp",lua_cocos2dx_myCustom_ProgressBar_setC_Hp);
        tolua_function(tolua_S,"initWithBarSprite",lua_cocos2dx_myCustom_ProgressBar_initWithBarSprite);
        tolua_function(tolua_S,"getC_Hp",lua_cocos2dx_myCustom_ProgressBar_getC_Hp);
        tolua_function(tolua_S,"progressTo",lua_cocos2dx_myCustom_ProgressBar_progressTo);
        tolua_function(tolua_S,"setBackground",lua_cocos2dx_myCustom_ProgressBar_setBackground);
        tolua_function(tolua_S,"setCurcentHp",lua_cocos2dx_myCustom_ProgressBar_setCurcentHp);
        tolua_function(tolua_S,"getBackground",lua_cocos2dx_myCustom_ProgressBar_getBackground);
        tolua_function(tolua_S,"getCurcentHp",lua_cocos2dx_myCustom_ProgressBar_getCurcentHp);
        tolua_function(tolua_S,"create", lua_cocos2dx_myCustom_ProgressBar_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(ProgressBar).name();
    g_luaType[typeName] = "ProgressBar";
    g_typeCast["ProgressBar"] = "ProgressBar";
    return 1;
}

int lua_cocos2dx_myCustom_PowerSlider_getMinRealLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_getMinRealLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getMinRealLength();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getMinRealLength",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_getMinRealLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_getCritLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_getCritLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getCritLength();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCritLength",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_getCritLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_setCritMark(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_setCritMark'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setCritMark(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setCritMark",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_setCritMark'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_setCritLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_setCritLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setCritLength(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setCritLength",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_setCritLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_getMaxLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_getMaxLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getMaxLength();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getMaxLength",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_getMaxLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_getMinLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_getMinLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getMinLength();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getMinLength",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_getMinLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_setMinLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_setMinLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setMinLength(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setMinLength",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_setMinLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_getMaxRealLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_getMaxRealLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getMaxRealLength();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getMaxRealLength",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_getMaxRealLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_restSlider(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_restSlider'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->restSlider();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "restSlider",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_restSlider'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_setMinRealLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_setMinRealLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setMinRealLength(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setMinRealLength",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_setMinRealLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_setMaxRealLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_setMaxRealLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setMaxRealLength(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setMaxRealLength",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_setMaxRealLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_progressTo(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_progressTo'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->progressTo(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "progressTo",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_progressTo'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_setBackground(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_setBackground'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Node* arg0;

        ok &= luaval_to_object<cocos2d::Node>(tolua_S, 2, "cc.Node",&arg0);
        if(!ok)
            return 0;
        cobj->setBackground(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setBackground",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_setBackground'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_setMaxLength(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_setMaxLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setMaxLength(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setMaxLength",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_setMaxLength'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_getBackground(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_getBackground'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Node* ret = cobj->getBackground();
        object_to_luaval<cocos2d::Node>(tolua_S, "cc.Node",(cocos2d::Node*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getBackground",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_getBackground'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_initWithSprite(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (PowerSlider*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_myCustom_PowerSlider_initWithSprite'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Sprite* arg0;

        ok &= luaval_to_object<cocos2d::Sprite>(tolua_S, 2, "cc.Sprite",&arg0);
        if(!ok)
            return 0;
        bool ret = cobj->initWithSprite(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "initWithSprite",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_initWithSprite'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"PowerSlider",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        cocos2d::Sprite* arg0;
        ok &= luaval_to_object<cocos2d::Sprite>(tolua_S, 2, "cc.Sprite",&arg0);
        if(!ok)
            return 0;
        PowerSlider* ret = PowerSlider::create(arg0);
        object_to_luaval<PowerSlider>(tolua_S, "PowerSlider",(PowerSlider*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_create'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_myCustom_PowerSlider_constructor(lua_State* tolua_S)
{
    int argc = 0;
    PowerSlider* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new PowerSlider();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"PowerSlider");
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "PowerSlider",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_myCustom_PowerSlider_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_cocos2dx_myCustom_PowerSlider_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (PowerSlider)");
    return 0;
}

int lua_register_cocos2dx_myCustom_PowerSlider(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"PowerSlider");
    tolua_cclass(tolua_S,"PowerSlider","PowerSlider","cc.ProgressTimer",nullptr);

    tolua_beginmodule(tolua_S,"PowerSlider");
        tolua_function(tolua_S,"new",lua_cocos2dx_myCustom_PowerSlider_constructor);
        tolua_function(tolua_S,"getMinRealLength",lua_cocos2dx_myCustom_PowerSlider_getMinRealLength);
        tolua_function(tolua_S,"getCritLength",lua_cocos2dx_myCustom_PowerSlider_getCritLength);
        tolua_function(tolua_S,"setCritMark",lua_cocos2dx_myCustom_PowerSlider_setCritMark);
        tolua_function(tolua_S,"setCritLength",lua_cocos2dx_myCustom_PowerSlider_setCritLength);
        tolua_function(tolua_S,"getMaxLength",lua_cocos2dx_myCustom_PowerSlider_getMaxLength);
        tolua_function(tolua_S,"getMinLength",lua_cocos2dx_myCustom_PowerSlider_getMinLength);
        tolua_function(tolua_S,"setMinLength",lua_cocos2dx_myCustom_PowerSlider_setMinLength);
        tolua_function(tolua_S,"getMaxRealLength",lua_cocos2dx_myCustom_PowerSlider_getMaxRealLength);
        tolua_function(tolua_S,"restSlider",lua_cocos2dx_myCustom_PowerSlider_restSlider);
        tolua_function(tolua_S,"setMinRealLength",lua_cocos2dx_myCustom_PowerSlider_setMinRealLength);
        tolua_function(tolua_S,"setMaxRealLength",lua_cocos2dx_myCustom_PowerSlider_setMaxRealLength);
        tolua_function(tolua_S,"progressTo",lua_cocos2dx_myCustom_PowerSlider_progressTo);
        tolua_function(tolua_S,"setBackground",lua_cocos2dx_myCustom_PowerSlider_setBackground);
        tolua_function(tolua_S,"setMaxLength",lua_cocos2dx_myCustom_PowerSlider_setMaxLength);
        tolua_function(tolua_S,"getBackground",lua_cocos2dx_myCustom_PowerSlider_getBackground);
        tolua_function(tolua_S,"initWithSprite",lua_cocos2dx_myCustom_PowerSlider_initWithSprite);
        tolua_function(tolua_S,"create", lua_cocos2dx_myCustom_PowerSlider_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(PowerSlider).name();
    g_luaType[typeName] = "PowerSlider";
    g_typeCast["PowerSlider"] = "PowerSlider";
    return 1;
}
TOLUA_API int register_all_cocos2dx_myCustom(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_cocos2dx_myCustom_UserData(tolua_S);
	lua_register_cocos2dx_myCustom_PowerSlider(tolua_S);
	lua_register_cocos2dx_myCustom_GameUIManager(tolua_S);
	lua_register_cocos2dx_myCustom_SGGShake(tolua_S);
	lua_register_cocos2dx_myCustom_ProgressBar(tolua_S);
	lua_register_cocos2dx_myCustom_MusicManager(tolua_S);
	lua_register_cocos2dx_myCustom_DrawScratchLine(tolua_S);
	lua_register_cocos2dx_myCustom_SGGBulletSprite(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

