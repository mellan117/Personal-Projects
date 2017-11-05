//
//  GameType.m
//  Latrunculi
//
//  Created by Adam Mellan on 12/1/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "GameType.h"
#import "GameMode.h"
#import "MainMenu.h"


@implementation GameType

#pragma mark Scene Method
+(CCScene *)gameTypeScene {
    CCScene *gameTypeScene = [CCScene node];
    CCLayer *gameTypeLayer = [GameType node];
    [gameTypeScene addChild:gameTypeLayer];
    return gameTypeScene;
}
#pragma mark

#pragma mark - Buttons Pressed
-(void)dotsButtonPressed {
    NSLog(@"Dots Button Pressed");
    
    CCScene* gameTypeScene = [GameMode gameModeSceneWithGameType:GameDots];
    [[CCDirector sharedDirector] replaceScene:gameTypeScene];
}

-(void)chessButtonPressed {
    NSLog(@"Chess Button Pressed");
    
    CCScene* gameTypeScene = [GameMode gameModeSceneWithGameType:GameChess];
    [[CCDirector sharedDirector] replaceScene:gameTypeScene];
}

-(void)checkersButtonPressed {
    NSLog(@"Checkers Button Pressed");
    
    CCScene* gameTypeScene = [GameMode gameModeSceneWithGameType:GameCheckers];
    [[CCDirector sharedDirector] replaceScene:gameTypeScene];
}

-(void)latrunculiButtonPressed {
    NSLog(@"Latrunculi Button Pressed");
    
    CCScene* gameTypeScene = [GameMode gameModeSceneWithGameType:GameLatrunculi];
    [[CCDirector sharedDirector] replaceScene:gameTypeScene];
}

-(void)backButtonPressed {
    NSLog(@"Back Button Pressed");
    
    CCScene* mainMenuScene = [MainMenu mainMenuScene:NO];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

#pragma mark

-(void)gameSelection {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Create background
    CCSprite *background = [CCSprite spriteWithFile:@"Background@2x.png"];
    background.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:background];
    
    // Creates the "Games" title
    CCLabelTTF *gamesLabel = [CCLabelTTF labelWithString:@"Games" fontName:@"Arial Rounded MT Bold" fontSize:25];
    gamesLabel.color = ccBLUE;
    gamesLabel.position = ccp(screenSize.width/2 + 30, screenSize.height-30);
    //mainMenuLabel.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:gamesLabel];
    
    // Creates the "Dots" button
    CCMenuItemFont *dotsButtonText = [CCMenuItemFont itemFromString:@"Dots"];
    CCMenuItemToggle *dotsButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(dotsButtonPressed) items:dotsButtonText, nil];
    dotsButton.position = ccp(screenSize.width/2, screenSize.height/2 + 75);
    
    // Creates the "Chess" button
    CCMenuItemFont *chessButtonText = [CCMenuItemFont itemFromString:@"Chess"];
    CCMenuItemToggle *chessButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(chessButtonPressed) items:chessButtonText, nil];
    chessButton.position = ccp(screenSize.width/2, screenSize.height/2 + 25);
    
    // Creates the "Checkers" button
    CCMenuItemFont *checkersButtonText = [CCMenuItemFont itemFromString:@"Checkers"];
    CCMenuItemToggle *checkersButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(checkersButtonPressed) items:checkersButtonText, nil];
    checkersButton.position = ccp(screenSize.width/2, screenSize.height/2 - 25);
    
    // Creates the "Latrunculi" button
    CCMenuItemFont *latrunculiButtonText = [CCMenuItemFont itemFromString:@"Latrunculi"];
    CCMenuItemToggle *latrunculiButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(latrunculiButtonPressed) items:latrunculiButtonText, nil];
    latrunculiButton.position = ccp(screenSize.width/2, screenSize.height/2 - 75);
    
    // Creates "Back" button
    CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
    CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
    //backButtonText.fontSize = 20;
    [backButtonText setFontName:@"Marker Felt"];
    backButton.color = ccRED;
    backButton.position = ccp(50, 35);
    
    // create the menu using the items
    CCMenu* menu = [CCMenu menuWithItems:dotsButton, chessButton, checkersButton, latrunculiButton, backButton, nil];
    menu.position = ccp(0, 0);
    [self addChild:menu];
}

-(id) init {
    if( (self=[super init])) {
        [self gameSelection];
    }
    return self;
}

@end
