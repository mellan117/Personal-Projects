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
    NSManagedObjectContext *mocTemp;
    BOOL bye;
    Mode playMode;
    BOOL soundButton;
    BOOL soundButtonCheck;
}

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
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

- (NSManagedObjectContext *)managedObjectContext;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSURL *)storeDirectory;

-(void)preRenderAndShowPauseMenu;
-(void)pause;
-(void)resume;
-(void)restart;
-(void)quit;
-(void)options;
-(void)soundToggle:(BOOL)sound;
-(void)yesRestart;
-(void)yesQuit;
-(void)no;

-(void)pauseButtonData;
-(void)resumeButtonData;
-(void)restartButtonData;
-(void)quitButtonData;
-(void)optionsButtonData;
-(void)soundToggleData;
-(void)yesButtonData;
-(void)noButtonData;
-(void)warningLabelData;
-(void)dimScreen;

-(Mode)getMode:(Mode)modey;

@end
