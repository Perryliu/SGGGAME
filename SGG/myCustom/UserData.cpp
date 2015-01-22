#include "UserData.h"
#include "BattleForLuaData.h"

UserData* UserData::GetInstance()
{
	if(!p_instance)

	{
		p_instance=new UserData;
	}
	return p_instance;
}

UserData::UserData()
{

}

UserData::~UserData()
{

}

int UserData::getCurLevel()
{
	return UserDefault::getInstance()->getIntegerForKey("curLevel",-1);
}

void UserData::setCurLevel( int n )
{
	UserDefault::getInstance()->setIntegerForKey("curLevel",n);
	UserDefault::getInstance()->flush();
}

int UserData::getCurScene()
{
	return UserDefault::getInstance()->getIntegerForKey("curScene",-1);
}

void UserData::setCurScene( int n )
{
	UserDefault::getInstance()->setIntegerForKey("curScene",n);
	UserDefault::getInstance()->flush();
}

int UserData::getMaxScene()
{
	return UserDefault::getInstance()->getIntegerForKey("MaxScene",1);
}

void UserData::setMaxScene( int n )
{
	UserDefault::getInstance()->setIntegerForKey("MaxScene",n);
	UserDefault::getInstance()->flush();
}

int UserData::getMaxLevel()
{
	return UserDefault::getInstance()->getIntegerForKey("MaxLevel",1);
}

void UserData::setMaxLevel( int n )
{
	UserDefault::getInstance()->setIntegerForKey("MaxLevel",n);
}

int UserData::getSceneMaxLevel( int n )
{
	char key[30];
	sprintf(key,"SceneMaxLevel_%d",n);
	return UserDefault::getInstance()->getIntegerForKey(key);
}

int UserData::getSceneLevelGetPlants( int scene,int level )
{
	char key[30];
	sprintf(key,"Scene_%d_Level_%d_GetPlants",scene,level);
	return UserDefault::getInstance()->getIntegerForKey(key);
}

int UserData::getSceneLevelMaxPlants( int scene,int level )
{
	char key[30];
	sprintf(key,"MaxPlants_%d",level);
	return UserDefault::getInstance()->getIntegerForKey(key);
}

float UserData::getLevelGoal( int scene,int level,int targetPlants )
{
	return targetPlants/getSceneLevelMaxPlants(scene,level);
}

float UserData::getLevelGoal( int scene,int level )
{
	char key[50];
	sprintf(key,"GameScoreLevel_%d_%d",scene,level);
	//UserDefault::getInstance()->getFloatForKey(key)

	return UserDefault::getInstance()->getFloatForKey(key);
}

float UserData::getAppleLevelGoal( int getApple,int maxApple )
{
	return (float)getApple/(float)maxApple;
}

void UserData::setSceneLevelGetPlants( int scene,int level ,int plants)
{
	char key[30];
	sprintf(key,"Scene_%d_Level_%d_GetPlants",scene,level);
	UserDefault::getInstance()->setIntegerForKey(key,plants);
	UserDefault::getInstance()->flush();
}

void UserData::setLevelMaxApple( int scene,int level,int applenum )
{
	char key[30];
	sprintf(key,"MaxApple_%d",level);
	UserDefault::getInstance()->setIntegerForKey(key,applenum);
	UserDefault::getInstance()->flush();
}

int UserData::getLevelMaxApple( int scene,int level )
{
	char key[30];
	sprintf(key,"MaxApple_%d",level);
	return UserDefault::getInstance()->getIntegerForKey(key);
	
}

void UserData::setSceneLevelGetApple( int scene,int level ,int applenum )
{
	char key[30];
	sprintf(key,"Scene_%d_Level_%d_Getapplenum",scene,level);
	UserDefault::getInstance()->setIntegerForKey(key,applenum);
	UserDefault::getInstance()->flush();
}

void UserData::setGameSceneType( int scene,int level ,GameSceneType type)
{
	char key[30];
	sprintf(key,"Scene_%d_Level_%d_Type",scene,level);
	UserDefault::getInstance()->setIntegerForKey(key,type);
	UserDefault::getInstance()->flush();
}

int UserData::getGameSceneType( int scene,int level )
{
	char key[30];
	sprintf(key,"Scene_%d_Level_%d_Type",scene,level);
	return UserDefault::getInstance()->getIntegerForKey(key);
	
}

int UserData::getSceneLevelGetApple( int scene,int level )
{
	char key[30];
	sprintf(key,"Scene_%d_Level_%d_Getapplenum",scene,level);
	return UserDefault::getInstance()->getIntegerForKey(key);
	
}

void UserData::setLevelGoal( int scene,int level ,float goal)
{
	char key[50];
	sprintf(key,"GameScoreLevel_%d_%d",scene,level);
	UserDefault::getInstance()->setFloatForKey(key,goal);
	UserDefault::getInstance()->flush();
}

void UserData::setSceneLevelMaxPlants( int scene,int level,int Plants )
{
	char key[30];
	sprintf(key,"MaxPlants_%d",level);
	UserDefault::getInstance()->setIntegerForKey(key,Plants);
	UserDefault::getInstance()->flush();
}


int UserData::curlevel=1;

UserData * UserData::p_instance=NULL;

