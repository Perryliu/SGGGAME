//
//  BattleForLuaData.cpp
//  cocos2d_libs
//
//  Created by shuaigougou on 14-9-17.
//
//

#include "BattleForLuaData.h"
#include "CCLuaEngine.h"

BattleForLuaData* BattleForLuaData::_shared;
BattleForLuaData* BattleForLuaData::getInstance()
{
    if (_shared == nullptr) {
        _shared = new BattleForLuaData();
    }
    return _shared;
}
//获取lua文件的数据
//--------------------------------------------------------lua data----------------------------------------------

//bool BattleForLuaData::getVarLuaTable(const char *luaFileName, const char *varName,map<string,string> &data){
//    
//    lua_State* LS=LuaEngine::getInstance()->getLuaStack()->getLuaState();
//    
//#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 || CC_TARGET_PLATFORM == CC_PLATFORM_MAC)
//	{
//        
//		char lua[1000];
//        
//		sprintf(lua,"%s",getWinFileFullPath(luaFileName).c_str());
//        
//		if (!luaDofile(LS,lua)) {
//			return false;
//		}
//	}
//#else
//	{
//		luaFileName=getFileFullPath(luaFileName);
//		if (!luaDofile(LS,luaFileName)) {
//			return false;
//		}
//	}
//#endif
//    
//    
//    lua_getglobal(LS, varName);
//    int statesCode =lua_istable(LS, -1);
//    if (statesCode!=1) {
//        log("not table %i for %s",statesCode,varName);
//        return false;
//    }
//    
//    int index=lua_gettop(LS);
//    popTable(LS, data, index);
//    lua_pop(LS, 1);
//    return true;
//}
//
//bool BattleForLuaData::popTable(lua_State* LS,map<string,string> &data,int index) {
//    try {
//        lua_pushnil(LS);
//        while (lua_next(LS, index)!=0) {
//            string key=lua_tostring(LS, -2);
//            string value=lua_tostring(LS, -1);
//            data.insert(pair<string, string>(key,value));
//            lua_pop(LS, 1);
//        }
//    }catch (const char*s) {
//        string errMsg=s;
//        lua_pop(LS, 1);
//        log("err %s",errMsg.c_str());
//        return false;
//    }catch(std::exception& e){
//        const char* errMsg = e.what();
//        lua_pop(LS,1);
//        log("err %s",errMsg);;
//        return false;
//    }catch(...){
//        const char* errMsg = lua_tostring(LS,-1);
//        lua_pop(LS,1);
//        log("err %s",errMsg);
//        return false;
//    }
//
//    return true;
//}
//
//bool BattleForLuaData::callLuaUtilsFunction(lua_State* LS,const char* luaFileName,const char* functionName){
//    std::string str =  StringUtils::format("%s.lua",luaFileName);
//    str=FileUtils::getInstance()->fullPathForFilename(str);
//    luaFileName=str.c_str();
//    if (!luaDofile(LS,luaFileName)) {
//        return false;
//    }
//    lua_getglobal(LS, functionName);
//    int statesCode =lua_isfunction(LS, -1);
//    if (statesCode!=1) {
//        log("not function %i for %s",statesCode,functionName);
//        return false;
//    }
//    return true;
//}


void BattleForLuaData::callLuaUtilsFunctionBattle(const char* luaFileName,const char* functionName) {
//    lua_State* LS=LuaEngine::getInstance()->getLuaStack()->getLuaState();
    std::string str = StringUtils::format("%s.lua",luaFileName);
//    long dataSize;
//    unsigned char*pFileContent=FileUtils::getInstance()->getFileData(str.c_str(), "r", &dataSize);
//    
//    if (pFileContent) {
//        luaL_loadbuffer(LS, (const char*)pFileContent, dataSize, str.c_str()) || lua_pcall(LS, 0, LUA_MULTRET, 0);
//        delete [] pFileContent;
//    }
//    lua_getglobal(LS, functionName);
//    lua_call(LS, 0, 0);
//    lua_pop(LS, 1);
    
    auto engine = LuaEngine::getInstance();
    ScriptEngineManager::getInstance()->setScriptEngine(engine);
    engine->executeScriptFile(str.c_str());
    engine->executeGlobalFunction(functionName);
}

//const float BattleForLuaData::callLuaUtilsFunction(const char* luaFileName,const char* functionName,float bPx,float bPy,float ePx,float ePy) {
//    lua_State* LS=LuaEngine::getInstance()->getLuaStack()->getLuaState();
//    if (!callLuaUtilsFunction(LS, luaFileName, functionName)) {
//        return 0;
//    }
//    lua_pushnumber(LS, bPx);
//    lua_pushnumber(LS, bPy);
//    lua_pushnumber(LS, ePx);
//    lua_pushnumber(LS, ePy);
//    lua_call(LS, 4, 1);
//    
//    float angle=lua_tonumber(LS, -1);
//    lua_pop(LS, 1);
//    return angle;
//}


//const char* BattleForLuaData::getValueForMap(map<string,string>& data,const char* key) {
//    const string* value;
//    map<string,string>::iterator it=data.find(key);
//    CCASSERT(it!=data.end(), "not find key in the battle data");
//    value=&it->second;
//    return value->c_str();
//}
//
//float BattleForLuaData::getValueOfFloatForMap(map<string,string>& data,const char* key) {
//    string value=this->getValueForMap(data, key);
//    if (!value.empty()) {
//        float fValue=atof(value.c_str());
//        return fValue;
//    }
//    return 0.0f;
//}
//
//
//bool BattleForLuaData::luaDofile(lua_State* ls,const char *luaFileName) {
//    luaL_openlibs(ls);
//    int isOpen = luaL_dofile(ls, luaFileName);
//    
//    if (isOpen != 0) {
//        log("Open Lua Error:%i for %s",isOpen,luaFileName);
//        return false;
//    }
//    return true;
//}

const char* BattleForLuaData::getFileFullPath(const char *fileName)
{
    //是指我的lua文件放在src这个目录下
    std::string str =  StringUtils::format("%s.lua",fileName);
    str=FileUtils::getInstance()->fullPathForFilename(str);
    return str.c_str();
}

//Scale9Sprite *BattleForLuaData::getScale9Sprite(const char* name) {
//    Scale9Sprite *scratchSprite = Scale9Sprite::create("scratch001.png");
//    return scratchSprite;
//}

std::string BattleForLuaData::getWinFileFullPath( const char *fileName )
{
	//是指我的lua文件放在src这个目录下
	std::string str =  StringUtils::format("%s.lua",fileName);
	str=FileUtils::getInstance()->fullPathForFilename(str);
	return str;
}

//--------------------------------------------------------lua data end----------------------------------------------



//获取lua缓存的动画帧
//--------------------------------------------------------lua animate----------------------------------------------
//Action* BattleForLuaData::getMonsterAction(std::map<std::string,std::string>& data,const char* monsterType,bool isROF,bool isRF)
//{
//    const char* monsterName=getValueForMap(data, "name");
//    string str=StringUtils::format("%s_%s",monsterName,monsterType);
//    auto cannonAnimation=AnimationCache::getInstance()->getAnimation(str.c_str());
//    float delay=this->getValueOfFloatForMap(data, monsterType);
//    cannonAnimation->setDelayPerUnit(delay);
//    cannonAnimation->setRestoreOriginalFrame(isROF);
//    auto cannonAnimate=Animate::create(cannonAnimation);
//    if (isRF) {
//        auto action=Sequence::create(cannonAnimate, NULL);
//        auto RFAction=RepeatForever::create(action);
//        return RFAction;
//    }else {
//        auto action=Sequence::create(cannonAnimate, NULL);
//        return action;
//    }
//}
//
//Action* BattleForLuaData::getMonsterAction(std::map<std::string,std::string>& data,const char* monsterType,CallFunc *func,bool isROF,bool isRF)
//{
//    const char* monsterName=getValueForMap(data, "name");
//    string str=StringUtils::format("%s_%s",monsterName,monsterType);
//    auto cannonAnimation=AnimationCache::getInstance()->getAnimation(str.c_str());
//    float delay=this->getValueOfFloatForMap(data, monsterType);
//    cannonAnimation->setDelayPerUnit(delay);
//    cannonAnimation->setRestoreOriginalFrame(isROF);
//    auto cannonAnimate=Animate::create(cannonAnimation);
//    if (isRF) {
//        auto action=Sequence::create(cannonAnimate,func, NULL);
//        auto RFAction=RepeatForever::create(action);
//        return RFAction;
//    }else {
//        auto action=Sequence::create(cannonAnimate,func, NULL);
//        return action;
//    }
//}

//--------------------------------------------------------lua animate end----------------------------------------------


//判断怪物是左右 左为false  右为true
//bool BattleForLuaData::pointIsLeftOrRight(Sprite *sp,Point p) {
//    p=sp->getParent()->convertToNodeSpace(sp->getPosition());
//    float x=abs(p.x);
//    Size spContenSize=sp->getContentSize();
//    float anchorX=sp->getAnchorPoint().x;
//    float spWith=spContenSize.width*0.5;
//    if (anchorX==0.0) {
//        x=+spWith;
//    }else if (anchorX==1.0f) {
//        x=-spWith;
//    }
//    float winWith=WINSIZE.width*0.5;
//    //判断怪物是左右 左为true  右为false
//    if (x>winWith) {
//        return true;
//    }
//    return false;
//}

//bool BattleForLuaData::pointIsMoveLeftOrRight(Point p1,Point p2){
//    float x1=abs(p1.x);
//    float x2=abs(p2.x);
//    if (x1<x2) {
//        return false;
//    }
//    return true;
//    
//}
//--------------------------------------------------------battle utils end----------------------------------------------
