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
	//��ȡ���������ͨ�عؿ�������ؿ����Ѿ�ͨ����
	int getMaxScene();
	static void setMaxScene(int n);

	//��ȡ���������ͨ�عؿ�����С�ؿ����Ѿ�ͨ����
	int getMaxLevel();
	static void setMaxLevel(int n);

	int getSceneMaxLevel(int n);

	//��ùؿ�ͨ����  ������յ���ʳ��
	void setSceneLevelGetPlants(int scene,int level ,int plants);
	//��ȡ
	static int getSceneLevelGetPlants(int scene,int level);
	//��øùؿ������ʳ��
	static int getSceneLevelMaxPlants(int scene,int level);
	//��ͨ�ؿ�����
	static float getLevelGoal(int scene,int level,int targetPlants);
        
	//���ͨ�ص�ƻ����
	static void setSceneLevelGetApple(int scene,int level ,int applenum);
	static int getSceneLevelGetApple(int scene,int level);
	//�����ƻ��
	static void setLevelMaxApple(int scene,int level,int applenum);
	//��ȡ
	static int getLevelMaxApple(int scene,int level);
	//��ȡ����
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