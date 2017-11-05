//
//  Leaderboard.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Leaderboard.h"
#import "MainMenu.h"
#import "Highscores.h"
#import "Stats.h"

@implementation Leaderboard

+(CCScene *)leaderboardScene {
	CCScene *leaderboardScene = [CCScene node];
	CCLayer *leaderboardLayer = [Leaderboard node];
	[leaderboardScene addChild:leaderboardLayer];
	return leaderboardScene;
}

-(void)highscoresButtonPressed {
    NSLog(@"The Highscores button was pressed");
    CCScene *highscoreScene = [Highscores highscoresScene];
    [[CCDirector sharedDirector] replaceScene:highscoreScene];
}

-(void)statsButtonPressed {
    NSLog(@"The Stats button was pressed");
    CCScene *statsScene = [Stats statsScene];
    [[CCDirector sharedDirector] replaceScene:statsScene];
}

-(void)backButtonPressed {
    NSLog(@"The Back button was pressed");
    CCScene* mainMenuScene = [MainMenu mainMenuScene];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

-(void)menu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the Background
    CCSprite *background = [CCSprite spriteWithFile:@"Blue_Space.png"];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    [self addChild:background];
    
    // Creates the "Leaderboards" title
    CCLabelTTF *leaderboardsLabel = [CCLabelTTF labelWithString:@"Leaderboards" fontName:@"Arial Rounded MT Bold" fontSize:75];
    leaderboardsLabel.color = ccGREEN;
    leaderboardsLabel.position = ccp(screenSize.width/2, screenSize.height - 50);
    [self addChild:leaderboardsLabel];
    
    // Creates "Back" button
    CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
    CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
    //[backButtonText setFontSize:20];
    [backButtonText setFontName:@"Marker Felt"];
    backButton.color = ccRED;
    backButton.scale = 2;
    backButton.anchorPoint = ccp(0,0);
    backButton.position = ccp(50, 50);
    //backButton.position = [[CCDirector sharedDirector] convertToGL:backButton.position];
    
    // Creates the "Highscores" button
    CCMenuItemFont *highscoresButtonText = [CCMenuItemFont itemFromString:@"Highscores"];
    CCMenuItemToggle *highscoresButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(highscoresButtonPressed) items:highscoresButtonText, nil];
    [highscoresButtonText setFontSize:30];
    highscoresButton.position = ccp(screenSize.width / 2, 125);
    //highscoresButton.position = [[CCDirector sharedDirector] convertToGL:highscoresButton.position];
    
    // Creates the "Stats" button
    CCMenuItemFont *statsButtonText = [CCMenuItemFont itemFromString:@"Stats"];
    CCMenuItemToggle *statsButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(statsButtonPressed) items:statsButtonText, nil];
    [statsButtonText setFontSize:30];
    statsButton.position = ccp(screenSize.width / 2, 225);
    statsButton.position = [[CCDirector sharedDirector] convertToGL:statsButton.position];
    
    // create the menu using the items
    CCMenu* menu2 = [CCMenu menuWithItems:backButton, highscoresButton, statsButton, nil];
    menu2.position = ccp(0, 0);
    [self addChild:menu2];
}

-(id)init {
    if (self = [super init]) {
        [self menu];
    }
    return self;
}

@end
