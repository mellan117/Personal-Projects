//
//  GameMode.m
//  Space-Commander
//
//  Created by Adam Mellan on 1/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameMode.h"
#import "Play.h"
#import "MainMenu.h"
#import "ResizeSprite.h"


@implementation GameMode

Play *_play;
ResizeSprite *_resizeSprite;

+(CCScene *)gameModeScene {
	CCScene *gameModeScene = [CCScene node];
	CCLayer *gameModeLayer = [GameMode node];
	[gameModeScene addChild:gameModeLayer];
	return gameModeScene;
}

-(void)backButtonPressed {
    CCScene* mainMenuScene = [MainMenu mainMenuScene];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

-(void)survivalButtonPressed {
    CCScene* playScene = [Play playSceneWithMode:ModeSurvival];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(void)normalButtonPressed {
    CCScene* playScene = [Play playSceneWithMode:ModeNormal];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(id)init {
    if((self=[super init])) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        _play = [[Play alloc] init];
        _resizeSprite = [[ResizeSprite alloc] init];
        
        NSString *backgroundFileNamePrefix = @"Black_Hole";
        NSString *backgroundFileNameSuffix = [_resizeSprite determineBackgroundImageFileSuffix];
        NSString *backgroundFileName = [backgroundFileNamePrefix stringByAppendingString:backgroundFileNameSuffix];
        
        CCSprite *background = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",backgroundFileName]];
        background.position = ccp((screenSize.width / 2), screenSize.height / 2);
        background.scale = [_resizeSprite resizeBackgroundImage];
        [self addChild:background];
        
        // Creates "Back" button
        CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
        CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
        //backButtonText.fontSize = 20;
        [backButtonText setFontName:@"Marker Felt"];
        backButton.color = ccRED;
        backButton.anchorPoint = ccp(0,0);
        backButton.scale = [_resizeSprite resizeLabel];
        backButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:50]);
        
        // Creates the "Survival" button
        CCMenuItemFont *SurvivalButtonText = [CCMenuItemFont itemFromString:@"Survival"];
        CCMenuItemToggle *SurvivalButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(survivalButtonPressed) items:SurvivalButtonText, nil];
        SurvivalButton.anchorPoint = ccp(0,0.5);
        SurvivalButton.scale = [_resizeSprite resizeLabel];
        SurvivalButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:484]);
        
        // Creates the "Normal" button
        CCMenuItemFont *NormalButtonText = [CCMenuItemFont itemFromString:@"Normal"];
        CCMenuItemToggle *NormalButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(survivalButtonPressed) items:NormalButtonText, nil];
        NormalButton.anchorPoint = ccp(0,0.5);
        NormalButton.scale = [_resizeSprite resizeLabel];
        NormalButton.position = ccp([_resizeSprite determinePositionX:50], [_resizeSprite determinePositionY:284]);
        
        CCMenu* menu = [CCMenu menuWithItems:SurvivalButton, NormalButton, backButton, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];
    }
    return self;
}

@end
