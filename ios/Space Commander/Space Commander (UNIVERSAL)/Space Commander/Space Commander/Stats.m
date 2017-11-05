//
//  Stats.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Stats.h"
#import "Leaderboard.h"
#import "ResizeSprite.h"


@implementation Stats

ResizeSprite *_resizeSprite;

+(CCScene *)statsScene {
	CCScene *statsScene = [CCScene node];
	CCLayer *statsLayer = [Stats node];
	[statsScene addChild:statsLayer];
	return statsScene;
}


-(void)backButtonPressed {
    CCScene* leaderboardScene = [Leaderboard leaderboardScene];
    [[CCDirector sharedDirector] replaceScene:leaderboardScene];
}

-(void)menu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the Background
    NSString *backgroundFileNamePrefix = @"Black_Hole";
    NSString *backgroundFileNameSuffix = [_resizeSprite determineBackgroundImageFileSuffix];
    NSString *backgroundFileName = [backgroundFileNamePrefix stringByAppendingString:backgroundFileNameSuffix];
    
    CCSprite *background = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",backgroundFileName]];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    background.scale = [_resizeSprite resizeBackgroundImage];
    [self addChild:background];
    
    // Creates the "Stats" title
    CCLabelTTF *statsLabel = [CCLabelTTF labelWithString:@"Stats" fontName:@"STHeitiJ-Light" fontSize:37.5];
    statsLabel.color = ccGREEN;
    statsLabel.scale = [_resizeSprite resizeLabel];
    statsLabel.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718]);
    [self addChild:statsLabel];
    
    // Creates the "Total Games Played" title
    //              T.    G.    P.
    CCLabelTTF *TGPLabel = [CCLabelTTF labelWithString:@"Total Games Played" fontName:@"Times New Roman" fontSize:10];
    TGPLabel.anchorPoint = ccp(0, 0);
    TGPLabel.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:584]);
    TGPLabel.scale = [_resizeSprite resizeLabel];
    //TGPLabel.position = [[CCDirector sharedDirector] convertToGL:TGPLabel.position];
    [self addChild:TGPLabel];
    
    // Creates the "Total Play Time" title
    //              T.    P.   T.
    CCLabelTTF *TPTLabel = [CCLabelTTF labelWithString:@"Total Play Time" fontName:@"Times New Roman" fontSize:10];
    TPTLabel.anchorPoint = ccp(0, 0);
    TPTLabel.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:484]);
    TPTLabel.scale = [_resizeSprite resizeLabel];
    //TPTLabel.position = [[CCDirector sharedDirector] convertToGL:TPTLabel.position];
    [self addChild:TPTLabel];
    
    // Creates the "Longest Play Time" title
    //              L.      P.   T.
    CCLabelTTF *LPTLabel = [CCLabelTTF labelWithString:@"Longest Play Time" fontName:@"Times New Roman" fontSize:10];
    LPTLabel.anchorPoint = ccp(0, 0);
    LPTLabel.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:384]);
    LPTLabel.scale = [_resizeSprite resizeLabel];
    //LPTLabel.position = [[CCDirector sharedDirector] convertToGL:LPTLabel.position];
    [self addChild:LPTLabel];
    
    // Creates the "Top Score" title
    //              T.  S.
    CCLabelTTF *TSLabel = [CCLabelTTF labelWithString:@"Top Score" fontName:@"Times New Roman" fontSize:10];
    TSLabel.anchorPoint = ccp(0, 0);
    TSLabel.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:284]);
    TSLabel.scale = [_resizeSprite resizeLabel];
    //TSLabel.position = [[CCDirector sharedDirector] convertToGL:TSLabel.position];
    [self addChild:TSLabel];
    
    // Creates the "Number of Enemy Ships Destroyed" title
    //              N.     o. E.    S.    D.
    CCLabelTTF *NoESDLabel = [CCLabelTTF labelWithString:@"Number of Enemy Ships Destroyed" fontName:@"Times New Roman" fontSize:10];
    NoESDLabel.anchorPoint = ccp(0, 0);
    NoESDLabel.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:184]);
    NoESDLabel.scale = [_resizeSprite resizeLabel];
    //NoESDLabel.position = [[CCDirector sharedDirector] convertToGL:NoESDLabel.position];
    [self addChild:NoESDLabel];
    
    // Creates "Back" button
    CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
    CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
    //[backButtonText setFontSize:20];
    [backButtonText setFontName:@"Marker Felt"];
    backButton.color = ccRED;
    backButton.anchorPoint = ccp(0,0);
    backButton.scale = [_resizeSprite resizeLabel];
    backButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:50]);
    //backButton.position = [[CCDirector sharedDirector] convertToGL:backButton.position];
    
    // create the menu using the items
    CCMenu* menu2 = [CCMenu menuWithItems:backButton, nil];
    menu2.position = ccp(0, 0);
    [self addChild:menu2];
}

-(id)init {
    if (self = [super init]) {
        _resizeSprite = [[ResizeSprite alloc] init];
        
        [self menu];
    }
    return self;
}

@end
