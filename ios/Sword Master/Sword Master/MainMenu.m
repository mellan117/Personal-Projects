//
//  MainMenu.m
//  Space Commander
//
//  Created by Adam Mellan on 8/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "MainMenu.h"
#import "Play.h"

@implementation MainMenu

#pragma mark Scene Method
+(CCScene *)mainMenuScene:(BOOL)isccLaunchImageBeingDisplayedForTheFirstTime {
	CCScene *mainMenuScene = [CCScene node];
    MainMenu *mainMenuLayer = [[[MainMenu alloc] initWithCCLaunchImageBOOL:isccLaunchImageBeingDisplayedForTheFirstTime] autorelease];
	[mainMenuScene addChild: mainMenuLayer];
	return mainMenuScene;
}
#pragma mark

#pragma mark - Buttons Pressed
- (void)gamesButtonPressed {
    NSLog(@"Games Button Pressed");
    CCScene* playScene = [Play playScene];
    [[CCDirector sharedDirector] replaceScene:playScene];
}
#pragma mark

-(void)removeCCLaunchImage {
    ccLaunchImage.opacity = 0;
}

-(void)mainMenu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Create Cocos2d launch image
    if (isCCLaunchImageBeingDisplayedForTheFirstTime) {
        ccLaunchImage = [CCSprite spriteWithFile:@"2Default.png"];
        ccLaunchImage.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:ccLaunchImage z:1];
        [self performSelector:@selector(removeCCLaunchImage) withObject:ccLaunchImage afterDelay:3];
        isCCLaunchImageBeingDisplayedForTheFirstTime = NO;
    }
    
    // Create background
    CCSprite *background = [CCSprite spriteWithFile:@"ex4.jpg"];
    background.position = ccp(screenSize.width/2, screenSize.height/2);
    //background.scaleX = 0.3;
    //background.scaleY = 0.7;
    background.scale = 0.3;
    background.rotation = 90;
    [self addChild:background];
    
    // Creates the "Main Menu" title
    CCLabelTTF *mainMenuLabel = [CCLabelTTF labelWithString:@"Platinum Code" fontName:@"Arial Rounded MT Bold" fontSize:25];
    mainMenuLabel.color = ccBLUE;
    mainMenuLabel.position = ccp(screenSize.width - 30, screenSize.height/2);
    //mainMenuLabel.position = ccp(screenSize.width/2, screenSize.height/2);
    mainMenuLabel.rotation = 90;
    [self addChild:mainMenuLabel];
    
    // Creates the "Games" button
    CCMenuItemFont *gamesButtonText = [CCMenuItemFont itemFromString:@"Games"];
    CCMenuItemToggle *gamesButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(gamesButtonPressed) items:gamesButtonText, nil];
    gamesButton.position = ccp(screenSize.width/2, screenSize.height/2);
    gamesButton.color = ccBLUE;
    gamesButton.rotation = 90;
    
    // Create the menu using the items
    CCMenu* menu = [CCMenu menuWithItems:gamesButton, nil];
    menu.position = ccp(0, 0);
    [self addChild:menu];
}

-(id) initWithCCLaunchImageBOOL:(BOOL)isccLaunchImageBeingDisplayedForTheFirstTime {
	if( (self=[super init])) {
        isCCLaunchImageBeingDisplayedForTheFirstTime = isccLaunchImageBeingDisplayedForTheFirstTime;
        /*if (isCCLaunchImageBeingDisplayedForTheFirstTime) {
            [self performSelector:@selector(mainMenu) withObject:self afterDelay:3];
        } else {
        [self mainMenu];
        }*/
        [self mainMenu];
    }
    return self;
}

@end
