//
//  MainMenu.m
//  Tank Attack
//
//  Created by Adam Mellan on 10/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "Play.h"



@implementation MainMenu

+(CCScene *)mainMenuScene {
	CCScene *mainMenuScene = [CCScene node];
	
	MainMenu *mainMenuLayer = [MainMenu node];
	[mainMenuScene addChild: mainMenuLayer];
    
	return mainMenuScene;
}

- (void)playButtonPressed {
    NSLog(@"\n\nThe Play button was pressed\n\n");
    
    CCScene* playScene = [Play playScene];
    [[CCDirector sharedDirector] replaceScene:playScene];
}
-(void)mainMenu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"Tank_Bg.png"];
    background.position = ccp(screenSize.width/2, screenSize.height/2);
    background.anchorPoint = ccp(0.5,0.5);
    [self addChild:background];
    
    // Creates the "Main Menu" title
    CCLabelTTF *mainMenuLabel = [CCLabelTTF labelWithString:@"Tank Attack" fontName:@"Arial Rounded MT Bold" fontSize:50];
    mainMenuLabel.color = ccRED;
    mainMenuLabel.position = ccp(screenSize.width/2, screenSize.height - 50);
    [self addChild:mainMenuLabel];
    
    // Creates the "Play" button
    CCMenuItemFont *playButtonText = [CCMenuItemFont itemFromString:@"Play"];
    CCMenuItemToggle *playButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(playButtonPressed) items:playButtonText, nil];
    playButton.position = ccp(50, (screenSize.height / 2) + 100);
    playButton.anchorPoint = ccp(0,0);
    playButton.color = ccBLUE;
    playButton.scale = 2;
    
    //playButton.position = [[CCDirector sharedDirector] convertToGL:playButton.position];
    
    // create the menu using the items
    CCMenu* menu = [CCMenu menuWithItems:playButton, nil];
    menu.position = ccp(0, 0);
    [self addChild:menu];
}

-(id)init {
    if (self = [super init]) {
        [self mainMenu];
    }
    return self;
}

@end
