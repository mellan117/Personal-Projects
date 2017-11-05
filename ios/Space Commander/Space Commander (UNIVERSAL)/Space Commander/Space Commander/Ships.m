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
#import "ResizeSprite.h"

@implementation Ships

ResizeSprite *_resizeSprite;

+(CCScene *)shipsScene {
	CCScene *shipsScene = [CCScene node];
	CCLayer *shipsLayer = [Ships node];
	[shipsScene addChild:shipsLayer];
	return shipsScene;
}

-(void)backButtonPressed {
    CCScene* mainMenuScene = [MainMenu mainMenuScene];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

-(void)checkMelonatorShipTag {
    CCScene* playScene = [GameMode gameModeScene];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(void)checkEnemyShipTag {
    CCScene* playScene = [GameMode gameModeScene];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(void)melonatorShip {
    // Creates the "Melonator Ship" button
    CCMenuItem *melonatorShipButton = [CCMenuItemImage itemFromNormalImage:@"Melonator_Ship.png" selectedImage:@"Melonator_Ship.png" target:self selector:@selector(checkMelonatorShipTag)];
    melonatorShipButton.scale = [_resizeSprite resizeImage];
    melonatorShipButton.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:284]);
    //melonatorShipButton.position = [[CCDirector sharedDirector] convertToGL:melonatorShipButton.position];
    
    CCMenu *shipMenu = [CCMenu menuWithItems:melonatorShipButton, nil];
    shipMenu.position = ccp(0, 0);
    [self addChild:shipMenu];
}

-(void)enemyShip {
    // Creates the "Melonator Ship" button
    CCMenuItem *enemyShipButton = [CCMenuItemImage itemFromNormalImage:@"Enemy_Ship.png" selectedImage:@"Enemy_Ship.png" target:self selector:@selector(checkEnemyShipTag)];
    enemyShipButton.scale = [_resizeSprite resizeImage];
    enemyShipButton.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:484]);
    //enemyShipButton.position = [[CCDirector sharedDirector] convertToGL:enemyShipButton.position];
    
    CCMenu *shipMenu3 = [CCMenu menuWithItems:enemyShipButton, nil];
    shipMenu3.position = ccp(0, 0);
    [self addChild:shipMenu3];
}

-(void)menu {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Creates the Background
    NSString *backgroundFileNamePrefix = @"Hanger";
    NSString *backgroundFileNameSuffix = [_resizeSprite determineBackgroundImageFileSuffix];
    NSString *backgroundFileName = [backgroundFileNamePrefix stringByAppendingString:backgroundFileNameSuffix];
    
    CCSprite *background = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",backgroundFileName]];
    background.position = ccp((screenSize.width / 2), screenSize.height / 2);
    background.scale = [_resizeSprite resizeBackgroundImage];
    [self addChild:background];
    
    // Creates the "Hanger" title
    CCLabelTTF *hangerLabel = [CCLabelTTF labelWithString:@"Hanger" fontName:@"Arial Rounded MT Bold" fontSize:37.5];
    hangerLabel.color = ccGREEN;
    hangerLabel.scale = [_resizeSprite resizeLabel];
    hangerLabel.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718]);
    [self addChild:hangerLabel];
    
    // Creates "Back" button
    CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
    CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
    //backButtonText.fontSize = 20;
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
        [self melonatorShip];
        [self enemyShip];
    }
    return self;
}

@end
