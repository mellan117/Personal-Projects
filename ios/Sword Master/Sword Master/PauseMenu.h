//
//  PauseMenu.h
//  Space-Commander
//
//  Created by Adam Mellan on 1/21/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameHUD.h"
#import "Play.h"

@interface PauseMenu : CCLayer {
    CCMenuItemImage *pauseButton;
    CCMenuItemImage *resumeButton;
    CCMenuItemImage *rotateButton;
    
    CCMenuItemFont *restartButton;
    CCMenuItemFont *yesRestartButton;
    CCMenuItemFont *quitButton;
    CCMenuItemFont *yesQuitButton;
    CCMenuItemFont *noButton;
    CCMenuItemFont *optionsButton;
    CCMenuItemFont *soundToggleButtonON;
    CCMenuItemFont *soundToggleButtonOFF;
    CCMenuItemFont *backButton;
    
    Play *playScene;
    
    BOOL soundButtonCheck;
    BOOL soundButton;
}

@property (nonatomic, assign) CGSize screenSize;

@property (nonatomic, retain) CCSprite *dim;

@property (nonatomic, retain) CCLabelTTF *optionsLabel;
@property (nonatomic, retain) CCLabelTTF *warningLabel;

@property (nonatomic, assign) BOOL disablePause;
@property (nonatomic, assign) BOOL disableResume;
@property (nonatomic, assign) BOOL sound;

@property (nonatomic, retain) CCMenu *pauseMenu;
@property (nonatomic, retain) CCMenu *resumeMenu;
@property (nonatomic, retain) CCMenu *rotateMenu;
@property (nonatomic, retain) CCMenu *restartMenu;
@property (nonatomic, retain) CCMenu *yesRestartMenu;
@property (nonatomic, retain) CCMenu *quitMenu;
@property (nonatomic, retain) CCMenu *yesQuitMenu;
@property (nonatomic, retain) CCMenu *noMenu;
@property (nonatomic, retain) CCMenu *optionsMenu;
@property (nonatomic, retain) CCMenu *soundONToggleMenu;
@property (nonatomic, retain) CCMenu *soundOFFToggleMenu;
@property (nonatomic, retain) CCMenu *backMenu;

+(CCScene *)pauseMenuScene;
-(void)getGameInfo:(Play *)scene withHud:(GameHUD *)hud;
-(void)preRenderAndShowPauseMenu;
-(void)pause;


@end
