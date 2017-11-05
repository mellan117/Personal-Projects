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
#import "ResizeSprite.h"

@implementation Leaderboard

ResizeSprite *_resizeSprite;

+(CCScene *)leaderboardScene {
	CCScene *leaderboardScene = [CCScene node];
	CCLayer *leaderboardLayer = [Leaderboard node];
	[leaderboardScene addChild:leaderboardLayer];
	return leaderboardScene;
}

-(void)highscoresButtonPressed {
    CCScene *highscoreScene = [Highscores highscoresScene];
    [[CCDirector sharedDirector] replaceScene:highscoreScene];
}

-(void)statsButtonPressed {
    CCScene *statsScene = [Stats statsScene];
    [[CCDirector sharedDirector] replaceScene:statsScene];
}

-(void)backButtonPressed {
    CCScene* mainMenuScene = [MainMenu mainMenuScene];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
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
    
    // Creates the "Leaderboards" title
    CCLabelTTF *leaderboardsLabel = [CCLabelTTF labelWithString:@"Leaderboards" fontName:@"Arial Rounded MT Bold" fontSize:37.5];
    leaderboardsLabel.color = ccGREEN;
    leaderboardsLabel.scale = [_resizeSprite resizeLabel];
    leaderboardsLabel.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718]);
    [self addChild:leaderboardsLabel];
    
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
    
    // Creates the "Highscores" button
    CCMenuItemFont *highscoresButtonText = [CCMenuItemFont itemFromString:@"Highscores"];
    CCMenuItemToggle *highscoresButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(highscoresButtonPressed) items:highscoresButtonText, nil];
    highscoresButton.scale = [_resizeSprite resizeLabel];
    highscoresButton.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:284]);
    //highscoresButton.position = [[CCDirector sharedDirector] convertToGL:highscoresButton.position];
    
    // Creates the "Stats" button
    CCMenuItemFont *statsButtonText = [CCMenuItemFont itemFromString:@"Stats"];
    CCMenuItemToggle *statsButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(statsButtonPressed) items:statsButtonText, nil];
    statsButton.scale = [_resizeSprite resizeLabel];
    statsButton.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:484]);
    //statsButton.position = [[CCDirector sharedDirector] convertToGL:statsButton.position];
    
    // create the menu using the items
    CCMenu* menu2 = [CCMenu menuWithItems:backButton, highscoresButton, statsButton, nil];
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
