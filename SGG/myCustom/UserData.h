#ifndef _UserData_H
#define _UserData_H
#include "cocos2d.h"
USING_NS_CC;

typedef enum {
	_GameCommonScene_=1,
	_GameAppleScene_,
}GameSceneType;


class UserData:public Ref
{
public:
	static UserData* GetInstance();
    
    UserData();
	~UserData();
	

	static int curlevel;

	int getCurLevel();
	static void setCurLevel(int n);

	int getCurScene();

	static void setCurScene(int n);
	//获取和设置最大通关关卡数（大关卡）已经通过的
	int getMaxScene();
	static void setMaxScene(int n);

	//获取和设置最大通关关卡数（小关卡）已经通过的
	int getMaxLevel();
	static void setMaxLevel(int n);

	int getSceneMaxLevel(int n);

	//存该关卡通过后  玩家最终的粮食数
	void setSceneLevelGetPlants(int scene,int level ,int plants);
	//获取
	static int getSceneLevelGetPlants(int scene,int level);
	//获得该关卡最大粮食数
	static int getSceneLevelMaxPlants(int scene,int level);
	//普通关卡评价
	static float getLevelGoal(int scene,int level,int targetPlants);
        
	//获得通关的苹果数
	static void setSceneLevelGetApple(int scene,int level ,int applenum);
	static int getSceneLevelGetApple(int scene,int level);
	//存最大苹果
	static void setLevelMaxApple(int scene,int level,int applenum);
	//获取
	static int getLevelMaxApple(int scene,int level);
	//获取评价
	static float getAppleLevelGoal(int getApple,int maxApple);

	static void setGameSceneType(int scene,int level,GameSceneType type);

	static int getGameSceneType(int scene,int level);
    static void setSceneLevelMaxPlants(int scene,int level,int Plants);

	static void setLevelGoal(int scene,int level,float goal);
	static float getLevelGoal(int scene,int level);

private:
	static UserData * p_instance;
    
};



#endif 