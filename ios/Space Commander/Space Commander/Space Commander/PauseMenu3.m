//
//  PauseMenu.m
//  Space Commander
//
//  Created by Adam Mellan on 11/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu3.h"
#import "Play.h"
#import "MainMenu.h"
#import "GameHUD.h"


@implementation PauseMenu3
/*
@synthesize pauseButton;
@synthesize resumeButton;
@synthesize warningLabel;
@synthesize dim;
@synthesize pauseMenu;
@synthesize resumeMenu;
@synthesize restartMenu;
@synthesize quitMenu;
@synthesize yesRestartMenu;
@synthesize yesQuitMenu;
@synthesize noMenu;

Play *_play;
GameHUD *__hud;

+(CCScene *)pauseScene {
    CCScene *pauseScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [pauseScene addChild:hud z:3];
    
    PauseMenu *layer = [[[PauseMenu alloc] initWithHUD:hud] autorelease];
    [pauseScene addChild:layer];
    
    return pauseScene;
}

-(void)preRenderAndShowPauseMenu {
    [self pauseButtonData];
    [self resumeButtonData];
    [self restartButtonData];
    [self quitButtonData];
    [self yesButtonData];
    [self noButtonData];
    [self warningLabelData];
    [self dimScreen];
    
    [self addChild:pauseMenu z:1];
}

-(void)pause {
    NSLog(@"\n\nPause Button Pressed\n\n");
    //[[CCDirector sharedDirector] pause];
    
    [__hud.delegate addChild:resumeMenu z:pauseMenu.zOrder + 1];
    [__hud.delegate addChild:restartMenu z:5];
    [__hud.delegate addChild:quitMenu z:5];
    [__hud.delegate addChild:dim z:4];
    
    [__hud.delegate removeChild:pauseMenu cleanup:YES];
}

-(void)resume {
    NSLog(@"\n\nResume Button Pressed\n\n");
    [[CCDirector sharedDirector]resume];
    
    [__hud addChild:pauseMenu z:restartMenu.zOrder + 1];
    
    [__hud removeChild:restartMenu cleanup:YES];
    [__hud removeChild:quitMenu cleanup:YES];
    [__hud removeChild:dim cleanup:YES];
}

-(void)restart {
    NSLog(@"\n\nThe Restart Button Pressed\n\n");
    
    [__hud addChild:warningLabel z:5];
    [__hud addChild:yesRestartMenu z:5];
    [__hud addChild:noMenu z:5];
    
    [__hud removeChild:restartMenu cleanup:YES];
    [__hud removeChild:quitMenu cleanup:YES];
}

-(void)quit {
    NSLog(@"\n\nThe Quit Button Pressed\n\n");
    
    [__hud addChild:warningLabel z:5];
    [__hud addChild:yesQuitMenu z:5];
    [__hud addChild:noMenu z:5];
    
    [__hud removeChild:restartMenu cleanup:YES];
    [__hud removeChild:quitMenu cleanup:YES];
}

-(void)yesRestart {
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Play playScene] withColor:ccBLACK]];
}

-(void)yesQuit {
    [[CCDirector sharedDirector]resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu mainMenuScene] withColor:ccBLACK]];
}

-(void)no {
    [__hud addChild:restartMenu];
    [__hud addChild:quitMenu];
    
    [__hud removeChild:warningLabel cleanup:YES];
    [__hud removeChild:yesRestartMenu cleanup:YES];
    [__hud removeChild:yesQuitMenu cleanup:YES];
    [__hud removeChild:noMenu cleanup:YES];
}

-(void)pauseButtonData {
     pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause_Button.png" selectedImage:@"Pause_Button.png" target:self selector:@selector(pause)];
    pauseButton.anchorPoint = ccp(1, 1);
    
    pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
    pauseMenu.position = ccp(480, 320);
}

-(void)resumeButtonData {
    resumeButton = [CCMenuItemImage itemFromNormalImage:@"Play_Button.png" selectedImage:@"Play_Button.png" target:self selector:@selector(resume)];
    resumeButton.anchorPoint = ccp(1, 1);
    
    resumeMenu = [CCMenu menuWithItems:resumeButton, nil];
    resumeMenu.position = ccp(480, 320);
}

-(void)restartButtonData {
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItemFont *restartButton = [CCMenuItemFont itemFromString:@"Restart" target:self selector:@selector(restart)];
    restartButton.position = ccp(size.width/2, size.height/2 + 30);
    
    restartMenu = [CCMenu menuWithItems:restartButton, nil];
    restartMenu.position = ccp(0, 0);
}

-(void)quitButtonData {
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItemFont *quitButton = [CCMenuItemFont itemFromString:@"Quit" target:self selector:@selector(quit)];
    quitButton.position = ccp(size.width/2, size.height/2 - 30);
    
    quitMenu = [CCMenu menuWithItems:quitButton, nil];
    quitMenu.position = ccp(0, 0);
}

-(void)yesButtonData {
    CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesRestart)];
    //CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" block:^({}];
    yesRestartButton.color = ccGREEN;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    yesRestartMenu = [CCMenu menuWithItems:yesRestartButton, nil];
    yesRestartMenu.position = ccp(size.width/2 - 40, size.height/2);
    
    CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesQuit)];
    //CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" block:^{}];
    yesQuitButton.color = ccGREEN;
    
    yesQuitMenu = [CCMenu menuWithItems:yesQuitButton, nil];
    yesQuitMenu.position = ccp(size.width/2 - 40, size.height/2);
}

-(void)noButtonData {
    CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" target:self selector:@selector(no)];
    //CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" block:^{}];
    noButton.color = ccRED;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    noMenu = [CCMenu menuWithItems:noButton, nil];
    noMenu.position = ccp(size.width/2 + 40, size.height/2);
}

-(void)warningLabelData {
    CGSize size = [[CCDirector sharedDirector] winSize];
    warningLabel = [CCLabelTTF labelWithString:@"Are You Sure?" fontName:@"Times New Roman" fontSize:32];
    warningLabel.position = ccp(size.width/2, size.height/2 + 100);
}

-(void)dimScreen {
    CGSize size = [[CCDirector sharedDirector] winSize];
    dim = [CCSprite spriteWithFile:@"Dim_Screen.png"];
    dim.position = ccp(size.width/2, size.height/2);
    [dim setOpacity:128];
}

-(id)initWithHUD:(GameHUD *)hud {
    if (self = [super init]) {
        __hud = hud;
    }
    return self;
}
*/
@end
