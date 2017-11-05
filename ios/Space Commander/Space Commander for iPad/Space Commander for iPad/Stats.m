//
//  Stats.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Stats.h"
#import "Leaderboard.h"


@implementation Stats

+(CCScene *)statsScene {
	CCScene *statsScene = [CCScene node];
	CCLayer *statsLayer = [Stats node];
	[statsScene addChild:statsLayer];
	return statsScene;
}


-(void)backButtonPressed {
    NSLog(@"The Back button was pressed");
    CCScene* leaderboardScene = [Leaderboard leaderboardScene];
    [[CCDirector sharedDirector] replaceScene:leaderboardScene];
}

-(void)menu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the Background
    CCSprite *background = [CCSprite spriteWithFile:@"Blue_Space.png"];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    [self addChild:background];
    
    // Creates the "Stats" title
    CCLabelTTF *statsLabel = [CCLabelTTF labelWithString:@"Stats" fontName:@"STHeitiJ-Light" fontSize:75];
    statsLabel.color = ccGREEN;
    statsLabel.position = ccp(screenSize.width/2, screenSize.height - 50);
    [self addChild:statsLabel];
    
    // Creates the "Total Games Played" title
    //              T.    G.    P.
    CCLabelTTF *TGPLabel = [CCLabelTTF labelWithString:@"Total Games Played" fontName:@"Times New Roman" fontSize:20];
    TGPLabel.anchorPoint = ccp(0, 0);
    TGPLabel.position = ccp(10, 100);
    TGPLabel.position = [[CCDirector sharedDirector] convertToGL:TGPLabel.position];
    [self addChild:TGPLabel];
    
    // Creates the "Total Play Time" title
    //              T.    P.   T.
    CCLabelTTF *TPTLabel = [CCLabelTTF labelWithString:@"Total Play Time" fontName:@"Times New Roman" fontSize:20];
    TPTLabel.anchorPoint = ccp(0, 0);
    TPTLabel.position = ccp(10, 140);
    TPTLabel.position = [[CCDirector sharedDirector] convertToGL:TPTLabel.position];
    [self addChild:TPTLabel];
    
    // Creates the "Longest Play Time" title
    //              L.      P.   T.
    CCLabelTTF *LPTLabel = [CCLabelTTF labelWithString:@"Longest Play Time" fontName:@"Times New Roman" fontSize:20];
    LPTLabel.anchorPoint = ccp(0, 0);
    LPTLabel.position = ccp(10, 180);
    LPTLabel.position = [[CCDirector sharedDirector] convertToGL:LPTLabel.position];
    [self addChild:LPTLabel];
    
    // Creates the "Top Score" title
    //              T.  S.
    CCLabelTTF *TSLabel = [CCLabelTTF labelWithString:@"Top Score" fontName:@"Times New Roman" fontSize:20];
    TSLabel.anchorPoint = ccp(0, 0);
    TSLabel.position = ccp(10, 220);
    TSLabel.position = [[CCDirector sharedDirector] convertToGL:TSLabel.position];
    [self addChild:TSLabel];
    
    // Creates the "Number of Enemy Ships Destroyed" title
    //              N.     o. E.    S.    D.
    CCLabelTTF *NoESDLabel = [CCLabelTTF labelWithString:@"Number of Enemy Ships Destroyed" fontName:@"Times New Roman" fontSize:20];
    NoESDLabel.anchorPoint = ccp(0, 0);
    NoESDLabel.position = ccp(10, 260);
    NoESDLabel.position = [[CCDirector sharedDirector] convertToGL:NoESDLabel.position];
    [self addChild:NoESDLabel];
    
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
    
    // create the menu using the items
    CCMenu* menu2 = [CCMenu menuWithItems:backButton, nil];
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
