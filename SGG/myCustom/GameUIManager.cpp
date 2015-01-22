#include "GameUIManager.h"

#include "GameMenuLayer.h"
#include "FirstLogoLayer.h"

#include "GameChooseScene.h"
#include "LoadingLayer.h"
#include "BattleForLuaData.h"
#include "MusicManager.h"
#include "GameOverLayer.h"
//#include "AppDelegate.h"

Scene * GameUIManager::GameStateChoose(GameState state )
{
    Scene *scene;
	switch (state)
	{
        case _FIRSTLOGOLAYER_:
        {
            scene=FirstLogoLayer::CreateScene();
            MusicManager::GetInstance()->PlayMusicOrEffect(_BACKGROUNDMUSIC_, _BGM_);
        }
            break;
        case _CREATEGAMESCENE_:
            {
            
            }
            break;
        case _CREATELODINGLAYER_:
            {
                //scene =LoadingLayer::createWithScene();
            }
            
            break;
        case _CREATEGAMELEVELCHOOSE_:
            {
                scene =Scene::create();
                scene->addChild(GameChooseScene::create());
            }
            
            break;
        default:
            scene=FirstLogoLayer::CreateScene();
            break;
	}
    return scene;
}


void GameUIManager::StopGame()
{
	Director::sharedDirector()->pause();
}

void GameUIManager::ResumeGame()
{
	Director::sharedDirector()->resume();
}

void GameUIManager::RestartGame()
{
    BattleForLuaData::getInstance()->callLuaUtilsFunctionBattle("GameBattleUtils", "openBattleScene");
}

void GameUIManager::EnterBattleScene() {
    
   // BattleForLuaData::getInstance()->callLuaUtilsFunctionBattle("GameBattleUtils", "openBattleScene");
	BattleForLuaData::getInstance()->callLuaUtilsFunctionBattle("GameBattleUtils", "openBattleScene");
}

void GameUIManager::openGameOverLayer() {
    Scene *scene=Director::getInstance()->getRunningScene();
    Layer *layer=GameOverLayer::create();
    scene->addChild(layer,5);
}

void GameUIManager::exitBattleScene() {
    SimpleAudioEngine::getInstance()->stopAllEffects();
        // MusicManager::GetInstance()->PlayMusicOrEffect("music/bgm.mp3",MusicType::_BACKGROUNDMUSIC_);
    Director::getInstance()->replaceScene(GameUIManager::GameStateChoose(_CREATEGAMELEVELCHOOSE_));
}

void GameUIManager::removeGamePlayLogo() {
    //AppDelegate::removeLogoPlayer();
}



