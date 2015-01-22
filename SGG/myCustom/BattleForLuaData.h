//
//  BattleForLuaData.h
//  cocos2d_libs
//
//  Created by shuaigougou on 14-9-17.
//
//

#ifndef __cocos2d_libs__BattleForLuaData__
#define __cocos2d_libs__BattleForLuaData__

/*#include <iostream>*/
#include "cocos2d.h"

//#include <map>
//#include "extensions/cocos-ext.h"

USING_NS_CC;
//USING_NS_CC_EXT;

using namespace std;

//extern "C"{
//    #include <lua.h>
//    #include <lualib.h>
//    #include <lauxlib.h>
//}


#define WINSIZE Director::getInstance()->getWinSize()

class BattleForLuaData{
public:
    static BattleForLuaData* getInstance();
    
    /*
     *  getLuaVarTable:����luaȫ��table
     luaFileName = lua�ļ���
     varName = ��Ҫȡ��table������
     */
//    bool getVarLuaTable(const char* luaFileName,const char* varName,map<string,string> &data);
//    bool popTable(lua_State* LS,map<string,string> &data,int index);
    //ȡ����Ӧ������
//    const char* getValueForMap(map<string,string> &data,const char* key);
//    float getValueOfFloatForMap(map<string,string> &data,const char* key);
    
    //ս������
    void callLuaUtilsFunctionBattle(const char* luaFileName,const char* functionName);
//    bool callLuaUtilsFunction(lua_State* LS,const char* luaFileName,const char* functionName);

//    const float callLuaUtilsFunction(const char* luaFileName,const char* functionName,float bPx,float bPy,float ePx,float ePy);
    
//    Scale9Sprite *getScale9Sprite(const char*name);
//    //��ȡ����֮ǰgl�Ƕ�
//    float getAngle(const Point Begin,const Point End);
//    //���ӵ��ĽǶȺ��ٶ�
//    Vec2 getBulletVelocityRatio(float angle,float speed);
    
    //�жϹ��������� ��Ϊfalse  ��Ϊture
//    bool pointIsLeftOrRight(Sprite *sp,Point p);
//    bool pointIsMoveLeftOrRight(Point p1,Point p2);
    
    //��ȡ���ﶯ��
    
//    Action* getMonsterAction(std::map<std::string,std::string>& data,const char* monsterType,bool isROF,bool isRF);
//    
//    Action* getMonsterAction(std::map<std::string,std::string>& data,const char* monsterType,CallFunc *func,bool isROF,bool isRF);
    
private:
//    static int cppFunction(lua_State* ls);
    static BattleForLuaData* _shared;
    const char* getFileFullPath(const char* fileName);
//    bool luaDofile(lua_State* ls,const char* luaFileName);
    std::string getWinFileFullPath(const char *fileName);
};


#endif /* defined(__cocos2d_libs__BattleForLuaData__) */
