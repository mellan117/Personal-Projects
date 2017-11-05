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
#import "Temp.h"
#import "CoreDataManager.h"
#import <CoreData/CoreData.h>


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
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

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
    NSLog(@"\n\nResume Button Pressed\n\n");
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
    NSLog(@"\n\nThe Restart Button Pressed\n\n");
    disablePauseMenu = YES;
    
    [_hud addChild:self.warningLabel z:5];
    [_hud addChild:self.yesRestartMenu z:5];
    [_hud addChild:self.noMenu z:5];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
    [_hud removeChild:self.optionsMenu cleanup:YES];                                
}

-(void)quit {
    NSLog(@"\n\nThe Quit Button Pressed\n\n");
    disablePauseMenu = YES;
    
    [_hud addChild:self.warningLabel z:5];
    [_hud addChild:self.yesQuitMenu z:5];
    [_hud addChild:self.noMenu z:5];
    
    [_hud removeChild:self.restartMenu cleanup:YES];
    [_hud removeChild:self.quitMenu cleanup:YES];
    [_hud removeChild:self.optionsMenu cleanup:YES];
}

-(void)options {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    disablePauseMenu = YES;
    //[self fetchSoundPref];
    
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
        
        self.optionsMenu.position = ccp(0, screenSize.height/2 + 100);
    }
}

-(void)deleteTempObjects:(Temp *)tempy {
    [mocTemp deleteObject:tempy];
}

-(void)yesRestart {
    /*NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Temp" inManagedObjectContext:mocTemp];
    fetchRequest.entity = entity;*/
    
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Play playSceneWithMode:playMode] withColor:ccBLACK]];
    
    /*for (Temp *tem in tempObjects) {
        if (tem.buttonCheck) {
            [[CCDirector sharedDirector] resume];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Play playSceneWithMode:tem.buttonCheck] withColor:ccBLACK]];
            NSLog(@"\n\nThe restart stufff %u\n\n", tem.buttonCheck);
            [array addObject:tem];
        }
    }*/
    /*for (Temp *t in array) {
        if (t.buttonCheck) {
            [self deleteTempObjects:t];
            [array delete:t];
        }
    }*/
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
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    disablePauseMenu = NO;
    
    if (soundButton) {
        [_hud removeChild:self.soundONToggleMenu cleanup:YES];
        soundButtonCheck = NO;
    } else if (!soundButton) {
        [_hud removeChild:self.soundOFFToggleMenu cleanup:YES];
        soundButtonCheck = NO;
    }
    self.optionsMenu.position = ccp(0, screenSize.height/2 - 90);
    [_hud addChild:self.restartMenu z:999];
    [_hud addChild:self.quitMenu z:999];
    
    [_hud removeChild:self.backMenu cleanup:YES];
}

-(void)pauseButtonData {
    NSLog(@"\n\nPause button was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause_Button.png" selectedImage:@"Pause_Button.png" target:self selector:@selector(pause)];
    pauseButton.position = ccp(screenSize.width - 50, screenSize.height - 50);
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
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *restartButton = [CCMenuItemFont itemFromString:@"Restart" target:self selector:@selector(restart)];
    restartButton.position = ccp(screenSize.width/2, screenSize.height/2 + 30);
    restartButton.scale = 2;
    
    self.restartMenu = [CCMenu menuWithItems:restartButton, nil];
    self.restartMenu.position = ccp(0, 0);
}

-(void)quitButtonData {
    NSLog(@"\n\nQuit button was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *quitButton = [CCMenuItemFont itemFromString:@"Quit" target:self selector:@selector(quit)];
    quitButton.position = ccp(screenSize.width/2, screenSize.height/2 - 30);
    quitButton.scale = 2;
    
    self.quitMenu = [CCMenu menuWithItems:quitButton, nil];
    self.quitMenu.position = ccp(0, 0);
}

-(void)optionsButtonData {
    NSLog(@"\n\nOptions button was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *optionsButton = [CCMenuItemFont itemFromString:@"Options" target:self selector:@selector(options)];
    optionsButton.position = ccp(screenSize.width/2, 0);
    optionsButton.scale = 2;
    
    self.optionsMenu = [CCMenu menuWithItems:optionsButton, nil];
    self.optionsMenu.position = ccp(0, screenSize.height/2 - 90);
}

-(void)backButtonData {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *backButton = [CCMenuItemFont itemFromString:@"BACK" target:self selector:@selector(back)];
    backButton.position = ccp(screenSize.width/2, screenSize.height/2 - 60);
    backButton.color = ccRED;
    backButton.scale = 1.5;
    
    self.backMenu = [CCMenu menuWithItems:backButton, nil];
    self.backMenu.position = ccp(0, 0);
}

-(void)soundToggleData {
    NSLog(@"\n\nSound Toggle button was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *soundLabel = [CCLabelTTF labelWithString:@"Sound" fontName:@"Times New Roman" fontSize:32];
    soundLabel.color = ccBLACK;
    
    CCLabelTTF *ON = [CCLabelTTF labelWithString:@"ON" fontName:@"Times New Roman" fontSize:32];
    ON.color = ccGREEN;
    NSString *soundON = [[NSString alloc] initWithFormat:@"%@:%@",soundLabel.string, ON.string];
    NSLog(@"\n\nSound is %@\n\n",soundON);
    
    CCMenuItemFont *soundToggleButtonON = [CCMenuItemFont itemFromString:soundON target:self selector:@selector(soundToggleON)];
    soundToggleButtonON.position = ccp(screenSize.width/2, screenSize.height/2);
    soundToggleButtonON.scale = 2;
    
    CCLabelTTF *OFF = [CCLabelTTF labelWithString:@"OFF" fontName:@"Times New Roman" fontSize:32];
    OFF.color = ccRED;
    NSString *soundOFF = [[NSString alloc] initWithFormat:@"%@:%@",soundLabel.string, OFF.string];
    
    CCMenuItemFont *soundToggleButtonOFF = [CCMenuItemFont itemFromString:soundOFF target:self selector:@selector(soundToggleOFF)];
    soundToggleButtonOFF.position = ccp(screenSize.width/2, screenSize.height/2);
    soundToggleButtonOFF.scale = 2;
    
    self.soundONToggleMenu = [CCMenu menuWithItems:soundToggleButtonON, nil];
    self.soundONToggleMenu.position = ccp(0, 0);
    
    self.soundOFFToggleMenu = [CCMenu menuWithItems:soundToggleButtonOFF, nil];
    self.soundOFFToggleMenu.position = ccp(0, 0);
}

-(void)saveSoundPref:(BOOL)soundy {
    NSError *error;
    
    Temp *a = (Temp *)[NSEntityDescription insertNewObjectForEntityForName:@"Temp" inManagedObjectContext:[self managedObjectContext]];
    a.sound = soundy;
    
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Adam an error occured! ERROR: %@",error);
    }
}

-(BOOL)hi:(BOOL)huy {
    sound = huy;
    return huy;
}

-(void)fetchSoundPref {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Temp" inManagedObjectContext:[self managedObjectContext]];
    fetchRequest.entity = entity;
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    for (Temp *tem in fetchedObjects) {
        [self hi:tem.sound];
    }
}

/*-(void)soundToggle:(BOOL)sound {
    sound = bye;
    
    if (sound) {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Breath-Machine.mp3" loop:YES];
        [self saveSoundPref:sound];
    } else if (!sound) {
        [[SimpleAudioEngine sharedEngine] setMute:YES];
        [self saveSoundPref:sound];
    }
}*/

-(void)soundToggle {
    //[self fetchSoundPref];
    
    if (sound) {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Breath-Machine.mp3" loop:YES];
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
    //[self saveSoundPref:sound];
    //[self soundToggle:sound];
    [self soundToggle];
    [_hud addChild:self.soundONToggleMenu z:999];
    soundButton = YES;
    
    [_hud removeChild:self.soundOFFToggleMenu cleanup:YES];
    
    return sound;
}

-(void)yesButtonData {
    NSLog(@"\n\nYes button was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesRestart)];
    //CCMenuItemFont *yesRestartButton = [CCMenuItemFont itemFromString:@"YES" block:^({}];
    yesRestartButton.color = ccGREEN;
    yesRestartButton.scale = 2;
    
    self.yesRestartMenu = [CCMenu menuWithItems:yesRestartButton, nil];
    self.yesRestartMenu.position = ccp(screenSize.width/2 - (yesRestartButton.contentSize.width * 2), screenSize.height/2);
    
    CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" target:self selector:@selector(yesQuit)];
    //CCMenuItemFont *yesQuitButton = [CCMenuItemFont itemFromString:@"YES" block:^{}];
    yesQuitButton.color = ccGREEN;
    yesQuitButton.scale = 2;
    
    self.yesQuitMenu = [CCMenu menuWithItems:yesQuitButton, nil];
    self.yesQuitMenu.position = ccp(screenSize.width/2 - (yesQuitButton.contentSize.width * 2), screenSize.height/2);
}

-(void)noButtonData {
    NSLog(@"\n\nNo button was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" target:self selector:@selector(no)];
    //CCMenuItemFont *noButton = [CCMenuItemFont itemFromString:@"NO" block:^{}];
    noButton.color = ccRED;
    noButton.scale = 2;
    
    self.noMenu = [CCMenu menuWithItems:noButton, nil];
    self.noMenu.position = ccp(screenSize.width/2 + (noButton.contentSize.width * 2), screenSize.height/2);
}

-(void)warningLabelData {
    NSLog(@"\n\nWarning Label was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.warningLabel = [CCLabelTTF labelWithString:@"Are You Sure?" fontName:@"Times New Roman" fontSize:32];
    self.warningLabel.position = ccp(screenSize.width/2, screenSize.height/2 + 100);
    self.warningLabel.scale = 2;
}

-(void)dimScreen {
    NSLog(@"\n\nDim screen was pre-rendered\n\n");
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.dim = [CCSprite spriteWithFile:@"Dim_Screen.png"];
    dim.position = ccp(screenSize.width/2, screenSize.height/2);
    dim.opacity = 128;
}

-(void)preRenderAndShowPauseMenu {
    NSLog(@"\n\nPause Menu was pre-rendered\n\n");
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
/*
- (NSURL *)storeDirectory {
    // applications document directory
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -
#pragma mark Getters

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil){
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self storeDirectory] URLByAppendingPathComponent:@"CoreData.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) return _managedObjectContext;
    
    if (self.persistentStoreCoordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
    }
    return _managedObjectContext;
}*/

-(id)initWithHUD:(GameHUD *)hud {
    if (self = [super init]) {
        _hud = hud;
        mocTemp = [[CoreDataManager shared] managedObjectContext];
    }
    return self;
}

@end
