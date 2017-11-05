//
//  PauseMenu2.m
//  Air-Control
//
//  Created by Adam Mellan on 1/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu.h"
#import "Play.h"
#import "MainMenu.h"
#import "GameHUD.h"
#import "GameMode.h"

@implementation PauseMenu
@synthesize warningLabel;
@synthesize dim;
@synthesize pauseMenu;
@synthesize resumeMenu;
@synthesize restartMenu;
@synthesize quitMenu;
@synthesize yesRestartMenu;
@synthesize yesQuitMenu;
@synthesize noMenu;

GameHUD *_hud;

+(CCScene *) pauseMenuScene {
    CCScene *pauseMenuScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [pauseMenuScene addChild:hud];
    
    PauseMenu *layer = [[[PauseMenu alloc] initWithHUD:hud] autorelease];
    [pauseMenuScene addChild:layer];
    
    return pauseMenuScene;
}

-(void)pause {
    NSLog(@"\n\nPause Button Pressed\n\n");
    [[CCDirector sharedDirector] pause];
    
    [_hud addChild:self.resumeMenu z:pauseMenu.zOrder + 1];
    [_hud addChild:self.restartMenu z:5];
    [_hud addChild:self.quitMenu z:5];
    [_hud addChild:self.dim z:4];
    
    [_hud removeChild:self.pauseMenu cleanup:YES];
}

-(void)resume {
    NSLog(@"\n\nResume Button Pressed\n\n");
    if (!x) {
        [[CCDirector sharedDirector]resume];
        
        [_hud addChild:self.pauseMenu z:resumeMenu.zOrder + 1];
        
        [_hud removeChild:self.resumeMenu cleanup:YES];
        [_hud removeChild:self.restartMenu cleanup:YES];
        [_hud removeChild:self.quitMenu cleanup:YES];
        [_hud removeChild:self.dim cleanup:YES];
    }
}

-(void)restart {
    NSLog(@"\n\nThe Restart Button Pressed\n\n");
    x = YES;
    
    [_hud addChild:self.warningLabel z:5];
    [_hud addChild:self.yesRestartMenu z:5];
    [_hud addChild:self.noMenu z:5];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
}

-(void)quit {
    NSLog(@"\n\nThe Quit Button Pressed\n\n");
    x = YES;
    
    [_hud addChild:self.warningLabel z:5];
    [_hud addChild:self.yesQuitMenu z:5];
    [_hud addChild:self.noMenu z:5];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
}

-(void)yesRestart {
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Play playSceneWithMode:((Play *)_hud.delegate).mode] withColor:ccBLACK]];
}

-(void)yesQuit {
    [[CCDirector sharedDirector]resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu mainMenuScene] withColor:ccBLACK]];
}

-(void)no {
    x = NO;
    
    [_hud addChild:self.restartMenu];
    [_hud addChild:self.quitMenu];
    
    [_hud removeChild:self.warningLabel cleanup:YES];
    [_hud removeChild:self.yesRestartMenu cleanup:YES];
    [_hud removeChild:self.yesQuitMenu cleanup:YES];
    [_hud removeChild:self.noMenu cleanup:YES];
}

-(void)pauseButtonData {
    NSLog(@"\n\nPause button was pre-rendered\n\n");
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause_Button.png" selectedImage:@"Pause_Button.png" target:self selector:@selector(pause)];
    pauseButton.position = ccp(size.width - 50, size.height - 50);
    pauseButton.scale = 0.5;
    
    self.pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
    self.pauseMenu.position = ccp(0, 0);
}

-(void)resumeButtonData {
    NSLog(@"\n\nResume button was pre-rendered\n\n");
    
    CCMenuItemImage *resumeButton = [CCMenuItemImage itemFromNormalImage:@"Play_Button.png" selectedImage:@"Play_Button.png" target:self selector:@selector(resume)];
    resumeButton.position = pauseButton.position;
    resumeButton.scale = 0.5;
    
    self.resumeMenu = [CCMenu menuWithItems:resumeButton, nil];
    self.resumeMenu.position = ccp(0, 0);
}

-(void)restartButtonData {
    NSLog(@"\n\nRestart button was pre-rendered\n\n");
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *restartButton = [CCMenuItemFont itemFromString:@"Restart" target:self selector:@selector(restart)];
    restartButton.position = ccp(size.width/2, size.height/2 + 30);
    restartButton.scale = 2;
    
    self.restartMenu = [CCMenu menuWithItems:restartButton, nil];
    self.restartMenu.position = ccp(0, 0);
}

-(void)quitButtonData {
    NSLog(@"\n\nQuit button was pre-rendered\n\n");
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItemFont *quitButton = [CCMenuItemFont itemFromString:@"Quit" target:self selector:@selector(quit)];
    quitButton.position = ccp(size.width/2, size.height/2 - 30);
    quitButton.scale = 2;
    
    self.quitMenu = [CCMenu menuWithItems:quitButton, nil];
    self.quitMenu.position = ccp(0, 0);
}

-(void)yesButtonData {
    NSLog(@"\n\nYes button was pre-rendered\n\n");
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesRestart)];
    //CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" block:^({}];
    yesRestartButton.color = ccGREEN;
    yesRestartButton.scale = 2;
    
    self.yesRestartMenu = [CCMenu menuWithItems:yesRestartButton, nil];
    self.yesRestartMenu.position = ccp(size.width/2 - (yesRestartButton.contentSize.width * 2), size.height/2);
    
    CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesQuit)];
    //CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" block:^{}];
    yesQuitButton.color = ccGREEN;
    yesQuitButton.scale = 2;
    
    self.yesQuitMenu = [CCMenu menuWithItems:yesQuitButton, nil];
    self.yesQuitMenu.position = ccp(size.width/2 - (yesQuitButton.contentSize.width * 2), size.height/2);
}

-(void)noButtonData {
    NSLog(@"\n\nNo button was pre-rendered\n\n");
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" target:self selector:@selector(no)];
    //CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" block:^{}];
    noButton.color = ccRED;
    noButton.scale = 2;
    
    self.noMenu = [CCMenu menuWithItems:noButton, nil];
    self.noMenu.position = ccp(size.width/2 + (noButton.contentSize.width * 2), size.height/2);
}

-(void)warningLabelData {
    NSLog(@"\n\nWarning Label was pre-rendered\n\n");
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    self.warningLabel = [CCLabelTTF labelWithString:@"Are You Sure?" fontName:@"Times New Roman" fontSize:32];
    self.warningLabel.position = ccp(size.width/2, size.height/2 + 100);
    self.warningLabel.scale = 2;
}

-(void)dimScreen {
    NSLog(@"\n\nDim screen was pre-rendered\n\n");
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    self.dim = [CCSprite spriteWithFile:@"Dim_Screen.png"];
    dim.position = ccp(size.width/2, size.height/2);
    dim.opacity = 128;
}

-(void)preRenderAndShowPauseMenu {
    NSLog(@"\n\nPause Menu was pre-rendered\n\n");
    x = NO;
    
    [self pauseButtonData];
    [self resumeButtonData];
    [self restartButtonData];
    [self quitButtonData];
    [self yesButtonData];
    [self noButtonData];
    [self warningLabelData];
    [self dimScreen];
    
    [_hud addChild:self.pauseMenu z:10];
}

-(id)initWithHUD:(GameHUD *)hud {
    if (self = [super init]) {
        _hud = hud;
    }
    return self;
}

@end
