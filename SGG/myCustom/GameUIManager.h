#ifndef _GameUIManager_H
#define _GameUIManager_H
#include "cocos2d.h"
USING_NS_CC;

typedef enum
{
    _FIRSTLOGOLAYER_=1,
    _CREATEGAMESCENE_=2,
    _CREATELODINGLAYER_=3,
    _CREATEGAMELEVELCHOOSE_=4,
    _STOPGAME_=5,
    _RESUMEGAME_=6,
    _RESTARTGAME_=7,
    _GAMEBAttLE_=8,
}GameState;

class GameUIManager
{
public:
	static Scene * GameStateChoose(GameState state);

	static void StopGame();

	static void ResumeGame();

	static void RestartGame();
    
    static void EnterBattleScene();
    
    static void openGameOverLayer();
    
    static void exitBattleScene();
    
    static void removeGamePlayLogo();
private:
	static GameUIManager *p_instance;
	GameUIManager();
	
};

#endif