//
//  Highscores.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Highscores.h"
#import "Leaderboard.h"


@implementation Highscores

+(CCScene *)highscoresScene {
	CCScene *highscoresScene = [CCScene node];
	CCLayer *highscoresLayer = [Highscores node];
	[highscoresScene addChild:highscoresLayer];
	return highscoresScene;
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
    
    // Creates the "Highscores" title
    CCLabelTTF *highscoresLabel = [CCLabelTTF labelWithString:@"Highscores" fontName:@"Arial Rounded MT Bold" fontSize:75];
    highscoresLabel.color = ccGREEN;
    highscoresLabel.position = ccp(screenSize.width/2, screenSize.height - 50);
    [self addChild:highscoresLabel];
    
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
