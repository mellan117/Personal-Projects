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

@implementation MainMenu

+(CCScene *)mainMenuScene {
	CCScene *mainMenuScene = [CCScene node];
	MainMenu *mainMenuLayer = [MainMenu node];
	[mainMenuScene addChild: mainMenuLayer];
	return mainMenuScene;
}

- (void)playButtonPressed {
    NSLog(@"\n\nThe Play button was pressed\n\n");
    
    CCScene* gameModeScene = [GameMode gameModeScene];
    [[CCDirector sharedDirector] replaceScene:gameModeScene];
    
    //CCScene* playScene = [Play playScene];
    //[[CCDirector sharedDirector] replaceScene:playScene];
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
    CCSprite *background = [CCSprite spriteWithFile:@"Black_Hole.png"];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    [self addChild:background];
    
    // Creates the "Main Menu" title
    CCLabelTTF *mainMenuLabel = [CCLabelTTF labelWithString:@"Space Commander" fontName:@"Arial Rounded MT Bold" fontSize:50];
    mainMenuLabel.color = ccORANGE;
    mainMenuLabel.position = ccp(screenSize.width / 2, screenSize.height - 50);
    [self addChild:mainMenuLabel];
    
    // Creates the "Play" button
    CCMenuItemFont *playButtonText = [CCMenuItemFont itemFromString:@"Play"];
    CCMenuItemToggle *playButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(playButtonPressed) items:playButtonText, nil];
    playButton.anchorPoint = ccp(0,0.5);
    playButton.scale = 2;
    playButton.position = ccp(50, (screenSize.height / 2) + 100);
    
    // Creates the "Ships" button
    CCMenuItemFont *shipsButtonText = [CCMenuItemFont itemFromString:@"Ships"];
    CCMenuItemToggle *shipsButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(shipsButtonPressed) items:shipsButtonText, nil];
    shipsButton.anchorPoint = ccp(0,0.5);
    shipsButton.scale = 2;
    shipsButton.position = ccp(50, playButton.position.y - 100);
    
    // Creates the "Upgrade" button
    CCMenuItemFont *upgradeButtonText = [CCMenuItemFont itemFromString:@"Upgrade"];
    CCMenuItemToggle *upgradeButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(upgradeButtonPressed) items:upgradeButtonText, nil];
    upgradeButton.anchorPoint = ccp(0, 0.5);
    upgradeButton.scale = 2;
    upgradeButton.position = ccp(50, shipsButton.position.y - 100);
    
    // Creates the "Settings" button
    CCMenuItemFont *settingsButtonText = [CCMenuItemFont itemFromString:@"Settings"];
    CCMenuItemToggle *settingsButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(settingsButtonPressed) items:settingsButtonText, nil];
    settingsButton.anchorPoint = ccp(0, 0.5);
    settingsButton.scale = 2;
    settingsButton.position = ccp(50, upgradeButton.position.y - 100);
    
    // Creates the "Leaderboard" button
    CCMenuItemFont *leaderboardButtonText = [CCMenuItemFont itemFromString:@"Leaderboard"];
    CCMenuItemToggle *leaderboardButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(leaderboardButtonPressed) items:leaderboardButtonText, nil];
    leaderboardButton.anchorPoint = ccp(0, 0.5);
    leaderboardButton.scale = 2;
    leaderboardButton.position = ccp(50, settingsButton.position.y - 100);
    
    
    // create the menu using the items
    CCMenu* menu = [CCMenu menuWithItems:playButton, shipsButton, upgradeButton, settingsButton, leaderboardButton, nil];
    menu.position = ccp(0, 0);
    [self addChild:menu];
}

-(id) init {
	if( (self=[super init])) {
        [self mainMenu];
    }
    return self;
}

@end
