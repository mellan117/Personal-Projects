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
//#import "Temp.h"
//#import "CoreDataManager.h"


@implementation GameMode

Play *_play;

+(CCScene *)gameModeScene {
	CCScene *gameModeScene = [CCScene node];
	CCLayer *gameModeLayer = [GameMode node];
	[gameModeScene addChild:gameModeLayer];
	return gameModeScene;
}

-(void)backButtonPressed {
    NSLog(@"The Back button was pressed");
    CCScene* mainMenuScene = [MainMenu mainMenuScene];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

-(void)survivalButtonPressed {
    NSLog(@"\n\nThe Survival button was pressed\n\n");
    /*NSError *error;
    
    Temp *a = (Temp *)[NSEntityDescription insertNewObjectForEntityForName:@"Temp" inManagedObjectContext:mocTemp];
    a.buttonCheck = ModeSurvival;
    NSLog(@"\n\nButton check = %hd\n\n",a.buttonCheck);
    if (![mocTemp save:&error]) {
        NSLog(@"Adam an error occured! ERROR: %@",error);
    }*/
    
    CCScene* playScene = [Play playSceneWithMode:ModeSurvival];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(void)normalButtonPressed {
    NSLog(@"\n\nThe Normal button was pressed\n\n");
    /*NSError *error;
    
    Temp *a = (Temp *)[NSEntityDescription insertNewObjectForEntityForName:@"Temp" inManagedObjectContext:mocTemp];
    a.buttonCheck = ModeNormal;
    
    if (![mocTemp save:&error]) {
        NSLog(@"Adam an error occured! ERROR: %@",error);
    }*/
    
    CCScene* playScene = [Play playSceneWithMode:ModeNormal];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(id)init {
    if((self=[super init])) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        _play = [[Play alloc] init];
        
        // Creates "Back" button
        CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
        CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
        backButtonText.fontSize = 20;
        [backButtonText setFontName:@"Marker Felt"];
        backButton.color = ccRED;
        backButton.scale = 2;
        backButton.position = ccp(50, (screenSize.height / 2) - 300);
        
        // Creates the "Survival" button
        CCMenuItemFont *SurvivalButtonText = [CCMenuItemFont itemFromString:@"Survival"];
        CCMenuItemToggle *SurvivalButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(survivalButtonPressed) items:SurvivalButtonText, nil];
        SurvivalButton.anchorPoint = ccp(0,0.5);
        SurvivalButton.scale = 2;
        SurvivalButton.position = ccp(50, (screenSize.height / 2) + 100);
        
        // Creates the "Normal" button
        CCMenuItemFont *NormalButtonText = [CCMenuItemFont itemFromString:@"Normal"];
        CCMenuItemToggle *NormalButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(survivalButtonPressed) items:NormalButtonText, nil];
        NormalButton.anchorPoint = ccp(0,0.5);
        NormalButton.scale = 2;
        NormalButton.position = ccp(50, (screenSize.height / 2) - 100);
        
        CCMenu* menu = [CCMenu menuWithItems:SurvivalButton, NormalButton, backButton, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];
        
        //mocTemp = [[CoreDataManager shared] managedObjectContext];
    }
    return self;
}

@end
