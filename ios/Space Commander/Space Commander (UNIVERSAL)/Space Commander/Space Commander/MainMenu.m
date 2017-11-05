//
//  MainMenu.m
//  Space Commander
//
//  Created by Adam Mellan on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "MainMenu.h"
#import "Play.h"
#import "Ships.h"
#import "Upgrade.h"
#import "Settings.h"
#import "Leaderboard.h"
#import "Highscores.h"
#import "Stats.h"
#import "GameMode.h"
#import "ResizeSprite.h"

@implementation MainMenu

ResizeSprite *_resizeSprite;

+(CCScene *)mainMenuScene {
	CCScene *mainMenuScene = [CCScene node];
	MainMenu *mainMenuLayer = [MainMenu node];
	[mainMenuScene addChild: mainMenuLayer];
	return mainMenuScene;
}

- (void)playButtonPressed {
    CCScene* gameModeScene = [GameMode gameModeScene];
    [[CCDirector sharedDirector] replaceScene:gameModeScene];
}

-(void)shipsButtonPressed {
    NSLog(@"\n\nThe Ships button was pressed\n\n");
    CCScene* shipsScene = [Ships shipsScene];
    [[CCDirector sharedDirector] replaceScene:shipsScene];
}

-(void)upgradeButtonPressed {
    NSLog(@"\n\nThe Upgrade button was pressed\n\n");
    CCScene* upgradeScene = [Upgrade upgradeScene];
    [[CCDirector sharedDirector] replaceScene:upgradeScene];
}

-(void)settingsButtonPressed {
    NSLog(@"\n\nThe Settings button was pressed\n\n");
    CCScene* settingsScene = [Settings settingsScene];
    [[CCDirector sharedDirector] replaceScene:settingsScene];
}

-(void)leaderboardButtonPressed {
    NSLog(@"\n\nThe Leaderboard button was pressed\n\n");
    CCScene* leaderboardScene = [Leaderboard leaderboardScene];
    [[CCDirector sharedDirector] replaceScene:leaderboardScene];
}

-(void)mainMenu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the Background
    NSString *backgroundFileNamePrefix = @"Black_Hole";
    NSString *backgroundFileNameSuffix = [_resizeSprite determineBackgroundImageFileSuffix];
    NSString *backgroundFileName = [backgroundFileNamePrefix stringByAppendingString:backgroundFileNameSuffix];
    
    CCSprite *background = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",backgroundFileName]];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    background.scale = [_resizeSprite resizeBackgroundImage];
    [self addChild:background];
    
    // Creates the "Main Menu" title
    CCLabelTTF *mainMenuLabel = [CCLabelTTF labelWithString:@"Space Commander" fontName:@"Arial Rounded MT Bold" fontSize:25];
    mainMenuLabel.color = ccORANGE;
    mainMenuLabel.scale = [_resizeSprite resizeLabel];
    mainMenuLabel.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718]);
    [self addChild:mainMenuLabel];
    
    // Creates the "Play" button
    CCMenuItemFont *playButtonText = [CCMenuItemFont itemFromString:@"Play"];
    CCMenuItemToggle *playButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(playButtonPressed) items:playButtonText, nil];
    playButton.anchorPoint = ccp(0,0.5);
    playButton.scale = [_resizeSprite resizeLabel];
    playButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:484]);
    
    // Creates the "Ships" button
    CCMenuItemFont *shipsButtonText = [CCMenuItemFont itemFromString:@"Ships"];
    CCMenuItemToggle *shipsButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(shipsButtonPressed) items:shipsButtonText, nil];
    shipsButton.anchorPoint = ccp(0,0.5);
    shipsButton.scale = [_resizeSprite resizeLabel];
    shipsButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:384]);
    
    // Creates the "Upgrade" button
    CCMenuItemFont *upgradeButtonText = [CCMenuItemFont itemFromString:@"Upgrade"];
    CCMenuItemToggle *upgradeButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(upgradeButtonPressed) items:upgradeButtonText, nil];
    upgradeButton.anchorPoint = ccp(0, 0.5);
    upgradeButton.scale = [_resizeSprite resizeLabel];
    upgradeButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:284]);
    
    // Creates the "Settings" button
    CCMenuItemFont *settingsButtonText = [CCMenuItemFont itemFromString:@"Settings"];
    CCMenuItemToggle *settingsButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(settingsButtonPressed) items:settingsButtonText, nil];
    settingsButton.anchorPoint = ccp(0, 0.5);
    settingsButton.scale = [_resizeSprite resizeLabel];
    settingsButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:184]);
    
    // Creates the "Leaderboard" button
    CCMenuItemFont *leaderboardButtonText = [CCMenuItemFont itemFromString:@"Leaderboard"];
    CCMenuItemToggle *leaderboardButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(leaderboardButtonPressed) items:leaderboardButtonText, nil];
    leaderboardButton.anchorPoint = ccp(0, 0.5);
    leaderboardButton.scale = [_resizeSprite resizeLabel];
    leaderboardButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:84]);
    
    
    // create the menu using the items
    CCMenu* menu = [CCMenu menuWithItems:playButton, shipsButton, upgradeButton, settingsButton, leaderboardButton, nil];
    menu.position = ccp(0, 0);
    [self addChild:menu];
}

-(id) init {
	if( (self=[super init])) {
        _resizeSprite = [[ResizeSprite alloc] init];
        [self mainMenu];
    }
    return self;
}

@end
