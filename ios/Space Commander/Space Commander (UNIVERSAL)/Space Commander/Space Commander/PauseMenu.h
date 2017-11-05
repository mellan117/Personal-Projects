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
#import "GameMode.h"

@interface PauseMenu : CCLayer {
    CCMenuItemImage *pauseButton;
    BOOL bye;
    Mode playMode;
    BOOL soundButton;
    BOOL soundButtonCheck;
}

@property (nonatomic, assign)BOOL sound;
@property (nonatomic, assign)BOOL disablePauseMenu;
@property (nonatomic, retain)CCLabelTTF *warningLabel;
@property (nonatomic, retain)CCSprite *dim;
@property (nonatomic, retain)CCMenu *pauseMenu;
@property (nonatomic, retain)CCMenu *resumeMenu;
@property (nonatomic, retain)CCMenu *restartMenu;
@property (nonatomic, retain)CCMenu *quitMenu;
@property (nonatomic, retain)CCMenu *optionsMenu;
@property (nonatomic, retain)CCMenu *soundONToggleMenu;
@property (nonatomic, retain)CCMenu *soundOFFToggleMenu;
@property (nonatomic, retain)CCMenu *yesRestartMenu;
@property (nonatomic, retain)CCMenu *yesQuitMenu;
@property (nonatomic, retain)CCMenu *noMenu;
@property (nonatomic, retain)CCMenu *backMenu;

+(CCScene *)pauseMenuScene;
-(id)initWithHUD:(GameHUD *)hud;

-(void)preRenderAndShowPauseMenu;
-(void)pause;
-(void)resume;
-(void)restart;
-(void)quit;
-(void)options;
-(void)soundToggleData;
-(void)yesRestart;
-(void)yesQuit;
-(void)no;

-(void)pauseButtonData;
-(void)resumeButtonData;
-(void)restartButtonData;
-(void)quitButtonData;
-(void)optionsButtonData;
-(void)yesButtonData;
-(void)noButtonData;
-(void)warningLabelData;
-(void)dimScreen;

-(Mode)getMode:(Mode)modey;

@end
