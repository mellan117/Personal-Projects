//
//  PauseMenu.m
//  Space-Commander
//
//  Created by Adam Mellan on 1/21/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu.h"
#import "GameHUD.h"
#import "Play.h"
#import "MainMenu.h"
#import "SimpleAudioEngine.h"


#pragma mark - Properties
@implementation PauseMenu
@synthesize screenSize;
@synthesize dim;
@synthesize optionsLabel;
@synthesize warningLabel;
@synthesize disablePause;
@synthesize disableResume;
@synthesize isGuideSquaresON;
@synthesize sound;
@synthesize pauseMenu;
@synthesize resumeMenu;
@synthesize rotateMenu;
@synthesize restartMenu;
@synthesize yesRestartMenu;
@synthesize quitMenu;
@synthesize yesQuitMenu;
@synthesize noMenu;
@synthesize optionsMenu;
@synthesize soundONToggleMenu;
@synthesize soundOFFToggleMenu;
@synthesize guideSquaresONToggleMenu;
@synthesize guideSquaresOFFToggleMenu;
@synthesize backMenu;
#pragma mark

#pragma mark - Class Variables
GameHUD *_hud;
#pragma mark

#pragma mark Scene Method
+(CCScene *) pauseMenuScene {
    CCScene *pauseMenuScene = [CCScene node];
    
    PauseMenu *layer = [PauseMenu node];
    [pauseMenuScene addChild:layer];
    
    return pauseMenuScene;
}
#pragma mark

#pragma mark - Button Data
-(void)pauseButtonData {
    //NSLog(@"Pause button was pre-rendered");
    
    pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause_Button.png" selectedImage:@"Pause_Button.png" target:self selector:@selector(pause)];
    pauseButton.scale = 0.25;
    
    self.pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
    self.pauseMenu.position = ccp(0, 0);
}

-(void)resumeButtonData {
    //NSLog(@"Resume button was pre-rendered");
    
    resumeButton = [CCMenuItemImage itemFromNormalImage:@"Play_Button.png" selectedImage:@"Play_Button.png" target:self selector:@selector(resume)];
    resumeButton.position = ccp(screenSize.width/2, screenSize.height/2 + 200);
    resumeMenu.anchorPoint = ccp(0.5, 0.5);
    resumeButton.rotation = 90;
    resumeButton.scale = 0.25;
    
    self.resumeMenu = [CCMenu menuWithItems:resumeButton, nil];
    self.resumeMenu.position = ccp(0, 0);
}

-(void)restartButtonData {
    //NSLog(@"Restart button was pre-rendered");
    
    restartButton = [CCMenuItemFont itemFromString:@"Restart" target:self selector:@selector(restart)];
    restartButton.position = ccp(screenSize.width/2, screenSize.height/2);
    restartMenu.anchorPoint = ccp(0.5, 0.5);
    restartButton.rotation = 90;
    
    self.restartMenu = [CCMenu menuWithItems:restartButton, nil];
    self.restartMenu.position = ccp(0, 0);
}

-(void)quitButtonData {
    //NSLog(@"Quit button was pre-rendered");
    
    quitButton = [CCMenuItemFont itemFromString:@"Quit" target:self selector:@selector(quit)];
    quitButton.position = ccp(screenSize.width/2, screenSize.height/2 + 100);
    quitButton.anchorPoint = ccp(0.5, 0.5);
    quitButton.rotation = 90;
    
    self.quitMenu = [CCMenu menuWithItems:quitButton, nil];
    self.quitMenu.position = ccp(0, 0);
}

-(void)yesButtonData {
    //NSLog(@"Yes button was pre-rendered");
    
    yesRestartButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesRestart)];
    yesRestartButton.position = ccp(screenSize.width/2, screenSize.height/2);
    yesRestartButton.color = ccGREEN;
    yesRestartButton.rotation = 90;
    
    self.yesRestartMenu = [CCMenu menuWithItems:yesRestartButton, nil];
    self.yesRestartMenu.position = ccp(0, 0);
    
    yesQuitButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesQuit)];
    yesQuitButton.position = ccp(screenSize.width/2, screenSize.height/2);
    yesQuitButton.color = ccGREEN;
    yesQuitButton.rotation = 90;
    
    self.yesQuitMenu = [CCMenu menuWithItems:yesQuitButton, nil];
    self.yesQuitMenu.position = ccp(0, 0);
}

-(void)noButtonData {
    //NSLog(@"No button was pre-rendered");
    
    noButton = [CCMenuItemFont itemFromString:@"NO" target:self selector:@selector(no)];
    noButton.position = ccp(yesRestartButton.position.x - 50, yesRestartButton.position.y);
    noButton.color = ccRED;
    noButton.rotation = 90;
    
    self.noMenu = [CCMenu menuWithItems:noButton, nil];
    self.noMenu.position = ccp(0, 0);
}

-(void)backButtonData {
    //NSLog(@"Back button was pre-rendered");
    
    backButton = [CCMenuItemFont itemFromString:@"BACK" target:self selector:@selector(back)];
    backButton.position = ccp(screenSize.width/2 - 50, screenSize.height/2);
    backButton.color = ccRED;
    backButton.rotation = 90;
    
    self.backMenu = [CCMenu menuWithItems:backButton, nil];
    self.backMenu.position = ccp(0, 0);
}

-(void)optionsButtonData {
    //NSLog(@"Options button was pre-rendered");
    
    self.optionsLabel = [CCLabelTTF labelWithString:@"Options" fontName:@"Times New Roman" fontSize:32];
    self.optionsLabel.position = ccp(screenSize.width/2 + 100, screenSize.height/2);
    self.optionsLabel.rotation = 90;
    
    optionsButton = [CCMenuItemFont itemFromString:@"Options" target:self selector:@selector(options)];
    optionsButton.position = ccp(screenSize.width/2, screenSize.height/2 - 125);
    optionsButton.rotation = 90;
    
    self.optionsMenu = [CCMenu menuWithItems:optionsButton, nil];
    self.optionsMenu.position = ccp(0, 0);
}

-(void)soundToggleData {
    //NSLog(@"Sound Toggle button was pre-rendered");
    
    CCLabelTTF *soundLabel = [CCLabelTTF labelWithString:@"Sound" fontName:@"Times New Roman" fontSize:32];
    soundLabel.color = ccBLACK;
    
    CCLabelTTF *ON = [CCLabelTTF labelWithString:@"ON" fontName:@"Times New Roman" fontSize:32];
    ON.color = ccGREEN;
    NSString *soundON = [[NSString alloc] initWithFormat:@"%@:%@",soundLabel.string, ON.string];
    
    soundToggleButtonON = [CCMenuItemFont itemFromString:soundON target:self selector:@selector(soundToggleON)];
    soundToggleButtonON.position = ccp(screenSize.width/2, screenSize.height/2);
    soundToggleButtonON.rotation = 90;

    self.soundONToggleMenu = [CCMenu menuWithItems:soundToggleButtonON, nil];
    self.soundONToggleMenu.position = ccp(0, 0);
    
    CCLabelTTF *OFF = [CCLabelTTF labelWithString:@"OFF" fontName:@"Times New Roman" fontSize:32];
    OFF.color = ccRED;
    NSString *soundOFF = [[NSString alloc] initWithFormat:@"%@:%@",soundLabel.string, OFF.string];
    
    soundToggleButtonOFF = [CCMenuItemFont itemFromString:soundOFF target:self selector:@selector(soundToggleOFF)];
    soundToggleButtonOFF.position = ccp(screenSize.width/2, screenSize.height/2);
    soundToggleButtonOFF.rotation = 90;
    
    self.soundOFFToggleMenu = [CCMenu menuWithItems:soundToggleButtonOFF, nil];
    self.soundOFFToggleMenu.position = ccp(0, 0);
}

-(void)guideSquaresToggleData {
    CCLabelTTF *guideSquaresLabel = [CCLabelTTF labelWithString:@"Guide Squares" fontName:@"Times New Roman" fontSize:32];
    guideSquaresLabel.color = ccBLACK;
    
    CCLabelTTF *ON = [CCLabelTTF labelWithString:@"ON" fontName:@"Times New Roman" fontSize:32];
    ON.color = ccGREEN;
    NSString *guideSquaresON = [[NSString alloc] initWithFormat:@"%@:%@",guideSquaresLabel.string, ON.string];
    
    guideSquaresButtonON = [CCMenuItemFont itemFromString:guideSquaresON target:self selector:@selector(guideSquaresToggleON)];
    guideSquaresButtonON.position = ccp(screenSize.width/2 + 50, screenSize.height/2);
    guideSquaresButtonON.rotation = 90;
    
    self.guideSquaresONToggleMenu = [CCMenu menuWithItems:guideSquaresButtonON, nil];
    self.guideSquaresONToggleMenu.position = ccp(0, 0);
    
    CCLabelTTF *OFF = [CCLabelTTF labelWithString:@"OFF" fontName:@"Times New Roman" fontSize:32];
    OFF.color = ccRED;
    NSString *guideSquaresOFF = [[NSString alloc] initWithFormat:@"%@:%@",guideSquaresLabel.string, OFF.string];
    
    guideSquaresButtonOFF = [CCMenuItemFont itemFromString:guideSquaresOFF target:self selector:@selector(guideSquaresToggleOFF)];
    guideSquaresButtonOFF.position = ccp(screenSize.width/2 + 50, screenSize.height/2);
    guideSquaresButtonOFF.rotation = 90;
    
    self.guideSquaresOFFToggleMenu = [CCMenu menuWithItems:guideSquaresButtonOFF, nil];
    self.guideSquaresOFFToggleMenu.position = ccp(0, 0);
}

-(void)rotateButtonData {
    //NSLog(@"Rotate Button was pre-rendered");
    
    rotateButton = [CCMenuItemImage itemFromNormalImage:@"Rotate_Button.png" selectedImage:@"Rotate_Button.png" target:self selector:@selector(rotateButtons)];
    rotateButton.position = ccp(screenSize.width/2 + 40, screenSize.height/2 + 200);
    rotateButton.scale = 0.12;
    
    self.rotateMenu = [CCMenu menuWithItems:rotateButton, nil];
    self.rotateMenu.position = ccp(0, 0);
}

-(void)warningLabelData {
    //NSLog(@"Warning Label was pre-rendered");
    
    self.warningLabel = [CCLabelTTF labelWithString:@"Are You Sure?" fontName:@"Times New Roman" fontSize:32];
    self.warningLabel.position = ccp(screenSize.width/2 + 100, screenSize.height/2);
    self.warningLabel.rotation = 90;
}
#pragma mark

#pragma mark - Operation Methods
-(void)pause {
    NSLog(@"Pause Button Pressed");
    if (!disableResume) {
        [_hud addChild:self.dim];
        [_hud addChild:self.resumeMenu];
        [_hud addChild:self.restartMenu];
        [_hud addChild:self.quitMenu];
        [_hud addChild:self.optionsMenu];
        [_hud addChild:self.rotateMenu];
        
        disablePause = YES;
        [playScene pausePlayScene];
    }
}

-(void)resume {
    NSLog(@"Resume Button Pressed");
    if (!disableResume) {
        [_hud removeChild:self.resumeMenu cleanup:YES];
        [_hud removeChild:self.restartMenu cleanup:YES];
        [_hud removeChild:self.quitMenu cleanup:YES];
        [_hud removeChild:self.dim cleanup:YES];
        [_hud removeChild:self.optionsMenu cleanup:YES];
        [_hud removeChild:self.rotateMenu cleanup:YES];
        
        disablePause = NO;
        [playScene resumePlayScene];
    }
}

-(void)restart {
    NSLog(@"The Restart Button Pressed");
    
    [_hud addChild:self.warningLabel];
    [_hud addChild:self.yesRestartMenu];
    [_hud addChild:self.noMenu];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
    [_hud removeChild:self.optionsMenu cleanup:YES];
    
    disableResume = YES;
}

-(void)quit {
    NSLog(@"The Quit Button Pressed");
    
    [_hud addChild:self.warningLabel];
    [_hud addChild:self.yesQuitMenu];
    [_hud addChild:self.noMenu];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
    [_hud removeChild:self.optionsMenu cleanup:YES];
    
    disableResume = YES;
}

-(void)yesRestart {
    NSLog(@"Yes Restart Button Pressed");
    
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Play playSceneWithMode:playMode withPlayerOneColor:p1Color andPlayerTwoColor:p2Color] withColor:ccBLACK]];
}

-(void)yesQuit {
    NSLog(@"Yes Quit Button Pressed");
    
    [[CCDirector sharedDirector]resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu mainMenuScene:NO] withColor:ccBLACK]];
}

-(void)no {
    NSLog(@"No Button Pressed");
    
    disableResume = NO;
    
    [_hud addChild:self.restartMenu];
    [_hud addChild:self.quitMenu];
    [_hud addChild:self.optionsMenu];
    
    [_hud removeChild:self.warningLabel cleanup:YES];
    [_hud removeChild:self.yesRestartMenu cleanup:YES];
    [_hud removeChild:self.yesQuitMenu cleanup:YES];
    [_hud removeChild:self.noMenu cleanup:YES];
}

-(void)back {
    NSLog(@"Back Button Pressed");
    
    if (soundButton) {
        [_hud removeChild:self.soundONToggleMenu cleanup:YES];
        soundButtonCheck = NO;
    } else if (!soundButton) {
        [_hud removeChild:self.soundOFFToggleMenu cleanup:YES];
        soundButtonCheck = NO;
    }
    
    if (guideSquaresButton) {
        [_hud removeChild:self.guideSquaresONToggleMenu cleanup:YES];
    } else if (!guideSquaresButton) {
        [_hud removeChild:self.guideSquaresOFFToggleMenu cleanup:YES];
    }
    
    [_hud addChild:self.restartMenu];
    [_hud addChild:self.quitMenu];
    [_hud addChild:self.optionsMenu];
    
    [_hud removeChild:self.optionsLabel cleanup:YES];
    [_hud removeChild:self.backMenu cleanup:YES];
    
    disableResume = NO;
}

-(void)options {
    if (!soundButtonCheck) {
        if (sound) {
            [_hud addChild:self.soundONToggleMenu];
            soundButton = YES;
        }else if (!sound) {
            [_hud addChild:self.soundOFFToggleMenu];
            soundButton = NO;
        }
        
        if (guideSquaresButton) {
            [_hud addChild:self.guideSquaresONToggleMenu];
            guideSquaresButton = YES;
        } else if (!guideSquaresButton) {
            [_hud addChild:self.guideSquaresOFFToggleMenu];
            guideSquaresButton = NO;
        }
        
        
        [_hud addChild:self.optionsLabel];
        [_hud addChild:self.backMenu];
        
        [_hud removeChild:self.restartMenu cleanup:YES];
        [_hud removeChild:self.quitMenu cleanup:YES];
        [_hud removeChild:self.optionsMenu cleanup:YES];
        
        soundButtonCheck = YES;
        disableResume = YES;
    }
}

-(void)soundToggle {
    if (sound) {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"I-Still-Can't-Stop.mp3" loop:YES];
    } else if (!sound) {
        [[SimpleAudioEngine sharedEngine] setMute:YES];
    }
}

-(BOOL)soundToggleON {
    NSLog(@"Sound:ON Button Pressed");
    
    soundButton = NO;
    sound = NO;
    
    [self soundToggle];
    [_hud addChild:self.soundOFFToggleMenu];
    [_hud removeChild:self.soundONToggleMenu cleanup:YES];
    
    return sound;
}

-(BOOL)soundToggleOFF {
    NSLog(@"Sound:OFF Button Pressed");
    
    soundButton = YES;
    sound = YES;
    
    [self soundToggle];
    [_hud addChild:self.soundONToggleMenu];
    [_hud removeChild:self.soundOFFToggleMenu cleanup:YES];
    
    return sound;
}

-(void)guideSquaresToggleON {
    isGuideSquaresON = NO;
    guideSquaresButton = NO;
    
    [_hud addChild:self.guideSquaresOFFToggleMenu];
    [_hud removeChild:self.guideSquaresONToggleMenu cleanup:YES];
    
    for (CCSprite *guideSquares in playScene.guideSquaresAllArray) {
        guideSquares.opacity = 0;
    }
}

-(void)guideSquaresToggleOFF {
    isGuideSquaresON = YES;
    guideSquaresButton = YES;
    
    [_hud addChild:self.guideSquaresONToggleMenu];
    [_hud removeChild:self.guideSquaresOFFToggleMenu cleanup:YES];
    
    for (CCSprite *guideSquares in playScene.guideSquaresAllArray) {
        if ([playScene checkRules:guideSquares.position]) {
            guideSquares.opacity = 200;
        }
    }
}

-(void)rotateButtons {
    NSLog(@"Rotate Button Pressed");
    
    CGPoint rotateButtonOriginalPosition = ccp(screenSize.width/2 + 40, screenSize.height/2 + 200);
    
    if (rotateButton.position.x == rotateButtonOriginalPosition.x && rotateButton.position.y == rotateButtonOriginalPosition.y) {
        rotateButton.position = ccp(screenSize.width/2 - 40, screenSize.height/2 - 200);
        resumeButton.position = ccp(screenSize.width/2, screenSize.height/2 - 200);
        quitButton.position = ccp(screenSize.width/2, screenSize.height/2 - 100);
        optionsButton.position = ccp(screenSize.width/2, screenSize.height/2 + 125);
        noButton.position = ccp(screenSize.width/2 + 50, screenSize.height/2);
        warningLabel.position = ccp(screenSize.width/2 - 100, screenSize.height/2);
        optionsLabel.position = ccp(screenSize.width/2 - 100, screenSize.height/2);
        backButton.position = ccp(screenSize.width/2 + 50, screenSize.height/2);
    } else {
        rotateButton.position = ccp(screenSize.width/2 + 40, screenSize.height/2 + 200);
        resumeButton.position = ccp(screenSize.width/2, screenSize.height/2 + 200);
        quitButton.position = ccp(screenSize.width/2, screenSize.height/2 + 100);
        optionsButton.position = ccp(screenSize.width/2, screenSize.height/2 - 125);
        noButton.position = ccp(screenSize.width/2 - 50, screenSize.height/2);
        warningLabel.position = ccp(screenSize.width/2 + 100, screenSize.height/2);
        optionsLabel.position = ccp(screenSize.width/2 + 100, screenSize.height/2);
        backButton.position = ccp(screenSize.width/2 - 50, screenSize.height/2);
    }
    
    resumeButton.rotation += 180;
    quitButton.rotation += 180;
    restartButton.rotation += 180;
    optionsButton.rotation += 180;
    yesRestartButton.rotation += 180;
    yesQuitButton.rotation += 180;
    noButton.rotation += 180;
    warningLabel.rotation += 180;
    optionsLabel.rotation += 180;
    backButton.rotation += 180;
    soundToggleButtonON.rotation += 180;
    soundToggleButtonOFF.rotation += 180;
}

-(void)dimScreen {
    //NSLog(@"Dim screen was pre-rendered");
    
    self.dim = [CCSprite spriteWithFile:@"Dim_Screen.png"];
    dim.position = ccp(screenSize.width/2, screenSize.height/2);
    dim.opacity = 128;
}
#pragma mark

#pragma mark - Initialize Pause Menu
-(void)preRenderAndShowPauseMenu {
    NSLog(@"Pause Menu elements were pre-rendered");
    screenSize = [[CCDirector sharedDirector] winSize];
    disableResume = NO;
    isGuideSquaresON = YES;
    guideSquaresButton = YES;
    
    [self resumeButtonData];
    [self restartButtonData];
    [self quitButtonData];
    [self optionsButtonData];
    [self soundToggleData];
    [self guideSquaresToggleData];
    [self yesButtonData];
    [self noButtonData];
    [self rotateButtonData];
    [self warningLabelData];
    [self dimScreen];
    [self backButtonData];
}

-(void)getGameInfo:(Mode)mode withScene:(Play *)scene andHud:(GameHUD *)hud andP1Color:(NSString *)P1Color andP2Color:(NSString *)P2Color {
    playMode = mode;
    playScene = scene;
    _hud = hud;
    p1Color = P1Color;
    p2Color = P2Color;
}
#pragma mark

@end
