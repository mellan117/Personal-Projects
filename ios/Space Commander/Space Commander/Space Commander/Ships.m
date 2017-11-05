//
//  Ships.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Ships.h"
#import "MainMenu.h"
#import "Play.h"
#import "Upgrade.h"
#import "Settings.h"
#import "GameMode.h"

@implementation Ships

+(CCScene *)shipsScene {
	CCScene *shipsScene = [CCScene node];
	CCLayer *shipsLayer = [Ships node];
	[shipsScene addChild:shipsLayer];
	return shipsScene;
}

-(void)backButtonPressed {
    NSLog(@"The Back button was pressed");
    CCScene* mainMenuScene = [MainMenu mainMenuScene];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

-(void)checkMelonatorShipTag {
    NSLog(@"The Melonator Ship Button was pressed");
    CCScene* playScene = [GameMode gameModeScene];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(void)checkEnemyShipTag {
    NSLog(@"The Enemy Ship Button was pressed");
    CCScene* playScene = [GameMode gameModeScene];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(void)melonatorShip {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the "Melonator Ship" button
    CCMenuItem *melonatorShipButton = [CCMenuItemImage itemFromNormalImage:@"Melonator_Ship_Big.png" selectedImage:@"Melonator_Ship_Big.png" target:self selector:@selector(checkMelonatorShipTag)];
    melonatorShipButton.position = ccp(80, screenSize.height / 2);
    melonatorShipButton.position = [[CCDirector sharedDirector] convertToGL:melonatorShipButton.position];
    
    CCMenu *shipMenu = [CCMenu menuWithItems:melonatorShipButton, nil];
    shipMenu.position = ccp(0, 0);
    [self addChild:shipMenu];
}

-(void)enemyShip {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the "Melonator Ship" button
    CCMenuItem *enemyShipButton = [CCMenuItemImage itemFromNormalImage:@"Enemy_Ship_Big.png" selectedImage:@"Enemy_Ship_Big.png" target:self selector:@selector(checkEnemyShipTag)];
    enemyShipButton.position = ccp(280, screenSize.height / 2);
    enemyShipButton.position = [[CCDirector sharedDirector] convertToGL:enemyShipButton.position];
    
    CCMenu *shipMenu3 = [CCMenu menuWithItems:enemyShipButton, nil];
    shipMenu3.position = ccp(0, 0);
    [self addChild:shipMenu3];
}

-(void)menu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the Background
    CCSprite *background = [CCSprite spriteWithFile:@"Hanger.jpg"];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    [self addChild:background];
    
    // Creates the "Hanger" title
    CCLabelTTF *hangerLabel = [CCLabelTTF labelWithString:@"Hanger" fontName:@"Arial Rounded MT Bold" fontSize:75];
    hangerLabel.color = ccGREEN;
    hangerLabel.position = ccp(screenSize.width/2, screenSize.height - 50);
    [self addChild:hangerLabel];
    
    // Creates "Back" button
    CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
    CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
    //backButtonText.fontSize = 20;
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
        [self melonatorShip];
        [self enemyShip];
    }
    return self;
}

@end
