//
//  PauseMenu.m
//  Space-Commander
//
//  Created by Adam Mellan on 1/21/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu.h"
#import "Play.h"
#import "MainMenu.h"
#import "GameHUD.h"
#import "GameMode.h"
#import "SimpleAudioEngine.h"
#import "ResizeSprite.h"


@implementation PauseMenu
@synthesize sound;
@synthesize disablePauseMenu;
@synthesize warningLabel;
@synthesize dim;
@synthesize pauseMenu;
@synthesize resumeMenu;
@synthesize restartMenu;
@synthesize quitMenu;
@synthesize optionsMenu;
@synthesize soundONToggleMenu;
@synthesize soundOFFToggleMenu;
@synthesize yesRestartMenu;
@synthesize yesQuitMenu;
@synthesize noMenu;
@synthesize backMenu;

GameHUD *_hud;
ResizeSprite *_resizeSprite;

+(CCScene *) pauseMenuScene {
    CCScene *pauseMenuScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [pauseMenuScene addChild:hud];
    
    PauseMenu *layer = [[[PauseMenu alloc] initWithHUD:hud] autorelease];
    [pauseMenuScene addChild:layer];
    
    return pauseMenuScene;
}

-(void)pause {
    NSLog(@"\n\nPause Button Pressed");
    if (!disablePauseMenu) {
        [[CCDirector sharedDirector] pause];
        
        [_hud addChild:self.resumeMenu z:pauseMenu.zOrder + 1];
        [_hud addChild:self.restartMenu z:5];
        [_hud addChild:self.quitMenu z:5];
        [_hud addChild:self.optionsMenu z:5];
        [_hud addChild:self.dim z:4];
        
        [_hud removeChild:self.pauseMenu cleanup:YES];
    }
}

-(void)resume {
    NSLog(@"\nResume Button Pressed");
    if (!disablePauseMenu) {
        [[CCDirector sharedDirector]resume];
        
        [_hud addChild:self.pauseMenu z:resumeMenu.zOrder + 1];
        
        [_hud removeChild:self.resumeMenu cleanup:YES];
        [_hud removeChild:self.restartMenu cleanup:YES];
        [_hud removeChild:self.quitMenu cleanup:YES];
        [_hud removeChild:self.dim cleanup:YES];
        [_hud removeChild:self.optionsMenu cleanup:YES];
    }
}

-(void)restart {
    NSLog(@"\nThe Restart Button Pressed");
    disablePauseMenu = YES;
    
    [_hud addChild:self.warningLabel z:5];
    [_hud addChild:self.yesRestartMenu z:5];
    [_hud addChild:self.noMenu z:5];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
    [_hud removeChild:self.optionsMenu cleanup:YES];                                
}

-(void)quit {
    NSLog(@"\nThe Quit Button Pressed");
    disablePauseMenu = YES;
    
    [_hud addChild:self.warningLabel z:5];
    [_hud addChild:self.yesQuitMenu z:5];
    [_hud addChild:self.noMenu z:5];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
    [_hud removeChild:self.optionsMenu cleanup:YES];
}

-(void)options {
    disablePauseMenu = YES;
    
    if (!soundButtonCheck) {
        if (sound) {
            [_hud addChild:self.soundONToggleMenu z:999];
            soundButton = YES;
        }else if (!sound) {
            [_hud addChild:self.soundOFFToggleMenu z:999];
            soundButton = NO;
        }
        
        soundButtonCheck = YES;
        [_hud addChild:self.backMenu z:999];
        
        [_hud removeChild:self.restartMenu cleanup:YES];
        [_hud removeChild:self.quitMenu cleanup:YES];
        
        self.optionsMenu.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:534]);
    }
}

-(void)yesRestart {
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Play playSceneWithMode:playMode] withColor:ccBLACK]];
}

-(void)yesQuit {
    [[CCDirector sharedDirector]resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu mainMenuScene] withColor:ccBLACK]];
}

-(void)no {
    disablePauseMenu = NO;
    
    [_hud addChild:self.restartMenu];
    [_hud addChild:self.quitMenu];
    [_hud addChild:self.optionsMenu];
    
    [_hud removeChild:self.warningLabel cleanup:YES];
    [_hud removeChild:self.yesRestartMenu cleanup:YES];
    [_hud removeChild:self.yesQuitMenu cleanup:YES];
    [_hud removeChild:self.noMenu cleanup:YES];
}

-(void)back {
    disablePauseMenu = NO;
    
    if (soundButton) {
        [_hud removeChild:self.soundONToggleMenu cleanup:YES];
        soundButtonCheck = NO;
    } else if (!soundButton) {
        [_hud removeChild:self.soundOFFToggleMenu cleanup:YES];
        soundButtonCheck = NO;
    }
    self.optionsMenu.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:294]);
    [_hud addChild:self.restartMenu z:999];
    [_hud addChild:self.quitMenu z:999];
    
    [_hud removeChild:self.backMenu cleanup:YES];
}

-(void)pauseButtonData {
    NSLog(@"\nPause button was pre-rendered");
    
    pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause_Button.png" selectedImage:@"Pause_Button.png" target:self selector:@selector(pause)];
    pauseButton.position = ccp([_resizeSprite determinePositionX:974], [_resizeSprite determinePositionY:718]);
    pauseButton.scale = [_resizeSprite resizeImage];
    
    self.pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
    self.pauseMenu.position = ccp(0, 0);
}

-(void)resumeButtonData {
    NSLog(@"\nResume button was pre-rendered");
    
    CCMenuItemImage *resumeButton = [CCMenuItemImage itemFromNormalImage:@"Play_Button.png" selectedImage:@"Play_Button.png" target:self selector:@selector(resume)];
    resumeButton.position = pauseButton.position;
    resumeButton.scale = [_resizeSprite resizeImage];
    
    self.resumeMenu = [CCMenu menuWithItems:resumeButton, nil];
    self.resumeMenu.position = ccp(0, 0);
}

-(void)restartButtonData {
    NSLog(@"\nRestart button was pre-rendered");
    
    CCMenuItemFont *restartButton = [CCMenuItemFont itemFromString:@"Restart" target:self selector:@selector(restart)];
    restartButton.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:484]);
    restartButton.scale = [_resizeSprite resizeLabel];
    
    self.restartMenu = [CCMenu menuWithItems:restartButton, nil];
    self.restartMenu.position = ccp(0, 0);
}

-(void)quitButtonData {
    NSLog(@"\nQuit button was pre-rendered");
    
    CCMenuItemFont *quitButton = [CCMenuItemFont itemFromString:@"Quit" target:self selector:@selector(quit)];
    quitButton.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:384]);
    quitButton.scale = [_resizeSprite resizeLabel];
    
    self.quitMenu = [CCMenu menuWithItems:quitButton, nil];
    self.quitMenu.position = ccp(0, 0);
}

-(void)optionsButtonData {
    NSLog(@"\nOptions button was pre-rendered");
    
    CCMenuItemFont *optionsButton = [CCMenuItemFont itemFromString:@"Options" target:self selector:@selector(options)];
    //optionsButton.position = ccp([_resizeSprite determinePositionX:512], 0);
    optionsButton.scale = [_resizeSprite resizeLabel];
    
    self.optionsMenu = [CCMenu menuWithItems:optionsButton, nil];
    self.optionsMenu.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:284]);
}

-(void)backButtonData {
    
    CCMenuItemFont *backButton = [CCMenuItemFont itemFromString:@"BACK" target:self selector:@selector(back)];
    backButton.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:304]);
    backButton.color = ccRED;
    backButton.scale = [_resizeSprite resizeLabel];
    
    self.backMenu = [CCMenu menuWithItems:backButton, nil];
    self.backMenu.position = ccp(0, 0);
}

-(void)soundToggleData {
    NSLog(@"\nSound Toggle button was pre-rendered");
    
    CCLabelTTF *soundLabel = [CCLabelTTF labelWithString:@"Sound" fontName:@"Times New Roman" fontSize:32];
    soundLabel.color = ccBLACK;
    
    CCLabelTTF *ON = [CCLabelTTF labelWithString:@"ON" fontName:@"Times New Roman" fontSize:32];
    ON.color = ccGREEN;
    NSString *soundON = [[NSString alloc] initWithFormat:@"%@:%@",soundLabel.string, ON.string];
    NSLog(@"Sound is %@",soundON);
    
    CCMenuItemFont *soundToggleButtonON = [CCMenuItemFont itemFromString:soundON target:self selector:@selector(soundToggleON)];
    soundToggleButtonON.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:384]);
    soundToggleButtonON.scale = [_resizeSprite resizeLabel];
    
    CCLabelTTF *OFF = [CCLabelTTF labelWithString:@"OFF" fontName:@"Times New Roman" fontSize:32];
    OFF.color = ccRED;
    NSString *soundOFF = [[NSString alloc] initWithFormat:@"%@:%@",soundLabel.string, OFF.string];
    
    CCMenuItemFont *soundToggleButtonOFF = [CCMenuItemFont itemFromString:soundOFF target:self selector:@selector(soundToggleOFF)];
    soundToggleButtonOFF.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:384]);
    soundToggleButtonOFF.scale = [_resizeSprite resizeLabel];
    
    self.soundONToggleMenu = [CCMenu menuWithItems:soundToggleButtonON, nil];
    self.soundONToggleMenu.position = ccp(0, 0);
    
    self.soundOFFToggleMenu = [CCMenu menuWithItems:soundToggleButtonOFF, nil];
    self.soundOFFToggleMenu.position = ccp(0, 0);
}

-(BOOL)hi:(BOOL)huy {
    sound = huy;
    return huy;
}

-(void)soundToggle {
    //[self fetchSoundPref];
    
    if (sound) {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"I-Still-Can't-Stop.mp3" loop:YES];
    } else if (!sound) {
        [[SimpleAudioEngine sharedEngine] setMute:YES];
    }
}

-(BOOL)soundToggleON {
    sound = NO;
    //[self saveSoundPref:sound];
    //[self soundToggle:sound];
    [self soundToggle];
    //[self addChild:self.soundOFFToggleMenu z:5];
    [_hud addChild:self.soundOFFToggleMenu z:999];
    soundButton = NO;
    
    [_hud removeChild:self.soundONToggleMenu cleanup:YES];
    
    return sound;
}

-(BOOL)soundToggleOFF {
    sound = YES;
    [self soundToggle];
    [_hud addChild:self.soundONToggleMenu z:999];
    soundButton = YES;
    
    [_hud removeChild:self.soundOFFToggleMenu cleanup:YES];
    
    return sound;
}

-(void)yesButtonData {
    NSLog(@"\nYes button was pre-rendered");
    
    CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesRestart)];
    //CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" block:^({}];
    yesRestartButton.color = ccGREEN;
    yesRestartButton.scale = [_resizeSprite resizeLabel];
    
    self.yesRestartMenu = [CCMenu menuWithItems:yesRestartButton, nil];
    self.yesRestartMenu.position = ccp([_resizeSprite determinePositionX:512- (yesRestartButton.contentSize.width * 2)], [_resizeSprite determinePositionY:384]);
    
    CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesQuit)];
    //CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" block:^{}];
    yesQuitButton.color = ccGREEN;
    yesQuitButton.scale = [_resizeSprite resizeLabel];
    
    self.yesQuitMenu = [CCMenu menuWithItems:yesQuitButton, nil];
    self.yesQuitMenu.position = ccp([_resizeSprite determinePositionX:512 - (yesQuitButton.contentSize.width * 2)], [_resizeSprite determinePositionY:384]);
}

-(void)noButtonData {
    NSLog(@"\nNo button was pre-rendered");
    
    CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" target:self selector:@selector(no)];
    //CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" block:^{}];
    noButton.color = ccRED;
    noButton.scale = [_resizeSprite resizeLabel];
    
    self.noMenu = [CCMenu menuWithItems:noButton, nil];
    self.noMenu.position = ccp([_resizeSprite determinePositionX:512 + (noButton.contentSize.width * 2)], [_resizeSprite determinePositionY:384]);
}

-(void)warningLabelData {
    NSLog(@"\nWarning Label was pre-rendered");
    
    self.warningLabel = [CCLabelTTF labelWithString:@"Are You Sure?" fontName:@"Times New Roman" fontSize:32];
    self.warningLabel.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:484]);
    self.warningLabel.scale = [_resizeSprite resizeLabel];
}

-(void)dimScreen {
    NSLog(@"\nDim screen was pre-rendered");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.dim = [CCSprite spriteWithFile:@"Dim_Screen.png"];
    dim.position = ccp(screenSize.width/2, screenSize.height/2);
    dim.opacity = 128;
}

-(void)preRenderAndShowPauseMenu {
    NSLog(@"\nPause Menu was pre-rendered");
    disablePauseMenu = NO;
    
    [self pauseButtonData];
    [self resumeButtonData];
    [self restartButtonData];
    [self quitButtonData];
    [self optionsButtonData];
    [self soundToggleData];
    [self yesButtonData];
    [self noButtonData];
    [self warningLabelData];
    [self dimScreen];
    [self backButtonData];
    
    [_hud addChild:self.pauseMenu z:10];
}

-(Mode)getMode:(Mode)modey {
    playMode = modey;
    return modey;
}

-(id)initWithHUD:(GameHUD *)hud {
    if (self = [super init]) {
        _hud = hud;
        _resizeSprite = [[ResizeSprite alloc] init];
    }
    return self;
}

@end
