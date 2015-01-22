#ifndef _MusicManager_H
#define _MusicManager_H
#include "cocos2d.h"

using namespace CocosDenshion;
USING_NS_CC;
enum MusicType
{
	_BACKGROUNDMUSIC_=0,
	_EFFECTMUSIC_
};
enum ENUMEFFECT
{
	_DIANJIBUTTON_=1,
	_GONGJISUCAI_,
	_LOSTEFFECT_,
	_WINEFFECT_,
	_JIZHONG_,
    _LOGO_,
    _FANTAN_,
};
enum ENUMBACKGROUND
{
	_BGM_=0,
};
class MusicManager:public Ref
{
public:
	static MusicManager* GetInstance();
	~MusicManager();

	void loadMusicOrEffect(const char *path,MusicType type);

	void PlayMusicOrEffect(MusicType type,int n);
	static bool MusicState;
	static bool EffectState;
    
    void PreLoadALlEffect();
	void changeMusicState(bool is);

	void changeEffectState(bool is);
private:
	static MusicManager * p_instance;
	MusicManager();
};

#endif