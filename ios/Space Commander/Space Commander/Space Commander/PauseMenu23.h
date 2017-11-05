//
//  PauseMenu.h
//  Space-Commander
//
//  Created by Adam Mellan on 1/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameHUD.h"

@interface PauseMenu : CCLayer {
    CCMenuItemImage *pauseButton;
    BOOL x;
}

@property (nonatomic, retain)CCLabelTTF *warningLabel;
@property (nonatomic, retain)CCSprite *dim;
@property (nonatomic, retain)CCMenu *pauseMenu;
@property (nonatomic, retain)CCMenu *resumeMenu;
@property (nonatomic, retain)CCMenu *restartMenu;
@property (nonatomic, retain)CCMenu *quitMenu;
@property (nonatomic, retain)CCMenu *yesRestartMenu;
@property (nonatomic, retain)CCMenu *yesQuitMenu;
@property (nonatomic, retain)CCMenu *noMenu;

+(CCScene *)pauseMenuScene;
-(id)initWithHUD:(GameHUD *)hud;

-(void)preRenderAndShowPauseMenu;
-(void)pause;
-(void)resume;
-(void)restart;
-(void)quit;
-(void)yesRestart;
-(void)yesQuit;
-(void)no;

-(void)pauseButtonData;
-(void)resumeButtonData;
-(void)restartButtonData;
-(void)quitButtonData;
-(void)yesButtonData;
-(void)noButtonData;
-(void)warningLabelData;
-(void)dimScreen;

@end
