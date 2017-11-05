//
//  Highscores.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Highscores.h"
#import "Leaderboard.h"
#import "ResizeSprite.h"


@implementation Highscores

ResizeSprite *_resizeSprite;

+(CCScene *)highscoresScene {
	CCScene *highscoresScene = [CCScene node];
	CCLayer *highscoresLayer = [Highscores node];
	[highscoresScene addChild:highscoresLayer];
	return highscoresScene;
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
    
    // Creates the "Highscores" title
    CCLabelTTF *highscoresLabel = [CCLabelTTF labelWithString:@"Highscores" fontName:@"Arial Rounded MT Bold" fontSize:37.5];
    highscoresLabel.color = ccGREEN;
    highscoresLabel.scale = [_resizeSprite resizeLabel];
    highscoresLabel.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718]);
    [self addChild:highscoresLabel];
    
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
