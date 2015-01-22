#include "MusicManager.h"
#include "SimpleAudioEngine.h"


MusicManager * MusicManager::p_instance=NULL;

const char *bgm="bgm.mp3";
const char *dianji="dianji.wav";
const char *gongjisucai="gongjishucai.wav";
const char *lost="lost.mp3";
const char *win="win2.mp3";
const char *jizhong="jizhong1.wav";
const char *logo="logo.wav";
const char *fantan="fantan1.wav";

MusicManager* MusicManager::GetInstance()
{

	if(NULL==p_instance)
	{
        MusicState=UserDefault::getInstance()->getBoolForKey("MusicState");
        EffectState=UserDefault::getInstance()->getBoolForKey("EffectState");
		p_instance=new MusicManager;
	}
	return p_instance;
}

void MusicManager::loadMusicOrEffect(const char *path,MusicType type)
{
	if(0==type)
	{
		char loadkey[1000];
		sprintf(loadkey, "%s", CCFileUtils::sharedFileUtils()->fullPathForFilename(path).c_str());

		SimpleAudioEngine::sharedEngine()->preloadBackgroundMusic(loadkey);
	}
	else if(1==type)
	{
		char loadkey[1000];
		sprintf(loadkey, "%s", CCFileUtils::sharedFileUtils()->fullPathForFilename(path).c_str());
		SimpleAudioEngine::sharedEngine()->preloadEffect(loadkey);
	}
}

void MusicManager::PlayMusicOrEffect(MusicType type,int n )
{

	if(_BACKGROUNDMUSIC_==type)
	{
		char key[30];
		switch (n)
		{
		case _BGM_:
			sprintf(key,"%s",bgm);
			break;
		default:
			break;
		}
		if(MusicState)
		{
			char loadkey[1000];
			sprintf(loadkey, "%s", CCFileUtils::sharedFileUtils()->fullPathForFilename(key).c_str());
			//SimpleAudioEngine::sharedEngine()->preloadEffect(loadkey);


			SimpleAudioEngine::sharedEngine()->playBackgroundMusic(loadkey, true);
		}
		else
		{
			//char loadkey[1000];
			//sprintf(loadkey, "%s", CCFileUtils::sharedFileUtils()->fullPathForFilename(key).c_str());
			//SimpleAudioEngine::sharedEngine()->preloadEffect(loadkey);


			//SimpleAudioEngine::sharedEngine()->playBackgroundMusic(loadkey, true);

			//SimpleAudioEngine::sharedEngine()->playBackgroundMusic(CCFileUtils::sharedFileUtils()->fullPathForFilename(key).c_str(),true);
			SimpleAudioEngine::sharedEngine()->stopBackgroundMusic();
		}
		
	}
	else if(_EFFECTMUSIC_==type)
	{
		char key[30];
		switch (n)
		{
			//点击
		case _DIANJIBUTTON_:
			sprintf(key,"%s",dianji);
			break;
			//攻击音效
		case _GONGJISUCAI_:
			sprintf(key,"%s",gongjisucai);
			break;
			//输的音效
		case _LOSTEFFECT_:
			sprintf(key,"%s",lost);
			break;
			//赢的音效
		case _WINEFFECT_:
			sprintf(key,"%s",win);
			break;
			//击中
		case _JIZHONG_:
			sprintf(key,"%s",jizhong);
			break;
        //开始游戏 展示logo 声音
        case _LOGO_:
            sprintf(key,"res/music/%s",logo);
        break;
        //子弹反弹声音
        case _FANTAN_:
            sprintf(key,"%s",fantan);
            break;
		default:
			break;
		}
		if(EffectState)
		{
			char loadkey[1000];
			sprintf(loadkey, "%s", CCFileUtils::sharedFileUtils()->fullPathForFilename(key).c_str());

			SimpleAudioEngine::sharedEngine()->preloadEffect(loadkey);

			//SimpleAudioEngine::sharedEngine()->playEffect(CCFileUtils::sharedFileUtils()->fullPathForFilename(key).c_str());

		}
	}
}

void MusicManager::PreLoadALlEffect()
{
	for (int n =1;n<=7;n++)
	{
		char key[30];
		switch (n)
		{
                //点击
            case _DIANJIBUTTON_:
                sprintf(key,"%s",dianji);
                break;
                //攻击音效
            case _GONGJISUCAI_:
                sprintf(key,"%s",gongjisucai);
                break;
                //输的音效
            case _LOSTEFFECT_:
                sprintf(key,"%s",lost);
                break;
                //赢的音效
            case _WINEFFECT_:
                sprintf(key,"%s",win);
                break;
                //击中
            case _JIZHONG_:
                sprintf(key,"%s",jizhong);
                break;
                //开始游戏 展示logo 声音
            case _LOGO_:
                sprintf(key,"%s",logo);
                break;
                //子弹反弹声音
            case _FANTAN_:
                sprintf(key,"%s",fantan);
                break;
            default:
                break;
		}
		char loadkey[1000];
		sprintf(loadkey,"%s",CCFileUtils::sharedFileUtils()->fullPathForFilename(key).c_str());
		SimpleAudioEngine::sharedEngine()->preloadEffect(loadkey);
	}

}

MusicManager::~MusicManager()
{

}

MusicManager::MusicManager()
{

}

void MusicManager::changeMusicState(bool is)
{
	UserDefault::getInstance()->setBoolForKey("MusicState",is);
	UserDefault::getInstance()->flush();
	MusicState=is;
}

void MusicManager::changeEffectState(bool is)
{
	UserDefault::getInstance()->setBoolForKey("EffectState",is);
	UserDefault::getInstance()->flush();
	EffectState=is;
}

bool MusicManager::EffectState;

bool MusicManager::MusicState;

