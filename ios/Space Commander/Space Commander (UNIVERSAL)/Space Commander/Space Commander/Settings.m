//
//  Settings.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "MainMenu.h"
#import "ResizeSprite.h"

@implementation Settings

ResizeSprite *_resizeSprite;

+(CCScene *)settingsScene {
	CCScene *settingsScene = [CCScene node];
	CCLayer *settingsLayer = [Settings node];
	[settingsScene addChild:settingsLayer];
	return settingsScene;
}

-(void)backButtonPressed {
    CCScene* mainMenuScene = [MainMenu mainMenuScene];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

-(void)menu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the Background
    NSString *backgroundFileNamePrefix = @"Gears";
    NSString *backgroundFileNameSuffix = [_resizeSprite determineBackgroundImageFileSuffix];
    NSString *backgroundFileName = [backgroundFileNamePrefix stringByAppendingString:backgroundFileNameSuffix];
    
    CCSprite *background = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",backgroundFileName]];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    background.scale = [_resizeSprite resizeBackgroundImage];
    [self addChild:background];
    
    // Creates the "Settings" title
    CCLabelTTF *settingsLabel = [CCLabelTTF labelWithString:@"Settings" fontName:@"Times New Roman" fontSize:37.5];
    settingsLabel.color = ccGREEN;
    settingsLabel.scale = [_resizeSprite resizeLabel];
    settingsLabel.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718]);
    [self addChild:settingsLabel];
    
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
