//
//  GameMode.m
//  Space-Commander
//
//  Created by Adam Mellan on 1/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameMode.h"
#import "GameType.h"
#import "OnePlayer.h"
#import "TwoPlayer.h"
#import "ZeroPlayer.h"


@implementation GameMode

#pragma mark - Class Variables
#pragma mark

#pragma mark Scene Method
+(CCScene *)gameModeSceneWithGameType:(Game)gameTypeInt {
	CCScene *gameModeScene = [CCScene node];
    GameMode *layer = [[GameMode alloc] initWithGameType:gameTypeInt];
	[gameModeScene addChild:layer];
	return gameModeScene;
}
#pragma mark

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Swipe Detection Part 1 | for pause menu
    firstTouch = location;
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //Swipe Detection Part 2 | for pause menu
    NSSet *allTouches = [event allTouches];
    UITouch * touch2 = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location2 = [touch2 locationInView: [touch2 view]];
    location2 = [[CCDirector sharedDirector] convertToGL:location2];
    
    lastTouch = location2;
    
    // Minimum length of the swipe
    float swipeLength = ccpDistance(firstTouch, lastTouch);
    float deltaX = abs(firstTouch.x - lastTouch.x);
    float deltaY = abs(firstTouch.y - lastTouch.y);
    
    // Check if the swipe is a UP and is long enough
    if (firstTouch.y < lastTouch.y && swipeLength > 60 && deltaX < 60) {
        NSLog(@"Swipe Up");
        
        if (!swipeUp1 && !swipeRight1 && !swipeUp2 && !swipeDown && !swipeLeft && !swipeRight2) {
            NSLog(@"Up1");
            swipeUp1 = YES;
        } else if (swipeUp1 && swipeRight1 && !swipeUp2 && !swipeDown && !swipeLeft && !swipeRight2) {
            NSLog(@"Up2");
            swipeUp2 = YES;
        } else {
            NSLog(@"RESET Swipe Up");
            swipeUp1 = NO;
            swipeRight1 = NO;
            swipeUp2 = NO;
            swipeDown = NO;
            swipeLeft = NO;
            swipeRight2 = NO;
        }
    }
    
    // Check if the swipe is a DOWN and is long enough
    if (firstTouch.y > lastTouch.y && swipeLength > 60 && deltaX < 60) {
        NSLog(@"Swipe Down");
        
        if (swipeUp1 && swipeRight1 && swipeUp2 && !swipeDown && !swipeLeft && !swipeRight2) {
            NSLog(@"Down");
            swipeDown = YES;
        } else if (!swipeUp1 || !swipeRight1 || !swipeUp2 || swipeDown || swipeLeft || swipeRight2) {
            NSLog(@"RESET Swipe Down");
            swipeUp1 = NO;
            swipeRight1 = NO;
            swipeUp2 = NO;
            swipeDown = NO;
            swipeLeft = NO;
            swipeRight2 = NO;
        }
    }
    
    // Check if the swipe is a LEFT and is long enough
    if (firstTouch.x > lastTouch.x && swipeLength > 60 && deltaY < 60) {
        NSLog(@"Swipe Left");
        
        if (swipeUp1 && swipeRight1 && swipeUp2 && swipeDown && !swipeLeft && !swipeRight2) {
            NSLog(@"Left");
            swipeLeft = YES;
        } else if (!swipeUp1 || !swipeRight1 || !swipeUp2 || !swipeDown || swipeLeft || swipeRight2) {
            NSLog(@"RESET Swipe Left");
            swipeUp1 = NO;
            swipeRight1 = NO;
            swipeUp2 = NO;
            swipeDown = NO;
            swipeLeft = NO;
            swipeRight2 = NO;
        }
    }
    
    // Check if the swipe is a RIGHT and is long enough
    if (firstTouch.x < lastTouch.x && swipeLength > 60 && deltaY < 60) {
        NSLog(@"Swipe Right");
        
        if (swipeUp1 && !swipeRight1 && !swipeUp2 && !swipeDown && !swipeLeft && !swipeRight2) {
            NSLog(@"Right1");
            swipeRight1 = YES;
        } else if (swipeUp1 && swipeRight1 && swipeUp2 && swipeDown && swipeLeft && !swipeRight2) {
            NSLog(@"Right 2");
            swipeRight2 = YES;
            if (swipeRight2) {
                [self backButtonPressed];
            }
        } else {
            NSLog(@"RESET Swipe Right");
            swipeUp1 = NO;
            swipeRight1 = NO;
            swipeUp2 = NO;
            swipeDown = NO;
            swipeLeft = NO;
            swipeRight2 = NO;
        }
    }
}

#pragma mark - Buttons Pressed
-(void)onePlayerButtonPressed {
    NSLog(@"One Player Button Pressed");
    
    CCScene* onePlayerScene = [OnePlayer onePlayerScene];
    [[CCDirector sharedDirector] replaceScene:onePlayerScene];
}

-(void)twoPlayerButtonPressed {
    NSLog(@"Two Player Button Pressed");
    
    CCScene* twoPlayerScene = [TwoPlayer twoPlayerScene];
    [[CCDirector sharedDirector] replaceScene:twoPlayerScene];
}

-(void)zeroPlayerButtonPressed {
    NSLog(@"Zero Player Button Pressed");
    
    CCScene* zeroPlayerScene = [ZeroPlayer zeroPlayerScene];
    [[CCDirector sharedDirector] replaceScene:zeroPlayerScene];
}

-(void)backButtonPressed {
    NSLog(@"Back Button Pressed");
    
    [[CCDirector sharedDirector] setDisplayFPS:YES];
    
    CCScene* gameTypeScene = [GameType gameTypeScene];
    [[CCDirector sharedDirector] replaceScene:gameTypeScene];
}
#pragma mark

-(void)determineAndCreateGameType:(Game)gameTypeInt {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    NSString *errorMessage = [[NSString alloc] initWithFormat:@"An error occured while displaying the previous error."];
    NSString *errorMessage2 = [[NSString alloc] initWithFormat:@"Error: 0x800f0906"];
    
    if (gameTypeInt == 1) {
        [[CCDirector sharedDirector] setDisplayFPS:NO];
        
        CCLabelTTF *fpsLabel = [CCLabelTTF labelWithString:@"00.0fps" fontName:@"Times New Roman" fontSize:15];
        fpsLabel.position = ccp(30, 10);
        [self addChild:fpsLabel];
        
        // Creates the "Dots" title
        CCLabelTTF *dotsLabel = [CCLabelTTF labelWithString:@"Dots" fontName:@"Arial Rounded MT Bold" fontSize:25];
        dotsLabel.color = ccBLUE;
        dotsLabel.position = ccp(screenSize.width/2 + 30, screenSize.height-30);
        //[self addChild:dotsLabel];
        
        /*CCLabelBMFont *warningErrorLabel = [CCLabelBMFont labelWithString:string fntFile:@"bitmapFontTest3.fnt"];
         warningErrorLabel.color = ccGREEN;
         warningErrorLabel.position = ccp(screenSize.width/2, screenSize.height/2);
         [self addChild:warningErrorLabel];*/
        
        // Hacked Error Message
        CCLabelTTF *warningErrorLabel = [CCLabelTTF labelWithString:errorMessage fontName:@"Arial Rounded MT Bold" fontSize:12.5];
        warningErrorLabel.color = ccGREEN;
        warningErrorLabel.position = ccp(screenSize.width/2, screenSize.height/2 + 100);
        [self addChild:warningErrorLabel];
        
        // Hacked Error Message2
        CCLabelTTF *warningErrorLabel2 = [CCLabelTTF labelWithString:errorMessage2 fontName:@"Arial Rounded MT Bold" fontSize:10];
        warningErrorLabel2.color = ccGREEN;
        warningErrorLabel2.position = ccp(screenSize.width/2, screenSize.height/2 - 50);
        [self addChild:warningErrorLabel2];
        
        // Creates "Back" button
        /*CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
        CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
        //backButtonText.fontSize = 20;
        [backButtonText setFontName:@"Marker Felt"];
        backButton.color = ccRED;
        backButton.position = ccp(50, 35);
        
        CCMenu* menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];*/
        
    } else if (gameTypeInt == 2) {
        [[CCDirector sharedDirector] setDisplayFPS:NO];
        
        CCLabelTTF *fpsLabel = [CCLabelTTF labelWithString:@"00.0fps" fontName:@"Times New Roman" fontSize:15];
        fpsLabel.position = ccp(30, 10);
        [self addChild:fpsLabel];
        
        // Creates the "Chess" title
        CCLabelTTF *chessLabel = [CCLabelTTF labelWithString:@"Chess" fontName:@"Arial Rounded MT Bold" fontSize:25];
        chessLabel.color = ccBLUE;
        chessLabel.position = ccp(screenSize.width/2 + 30, screenSize.height-30);
        //[self addChild:chessLabel];
        
        // Hacked Error Message
        CCLabelTTF *warningErrorLabel = [CCLabelTTF labelWithString:errorMessage fontName:@"Arial Rounded MT Bold" fontSize:12.5];
        warningErrorLabel.color = ccGREEN;
        warningErrorLabel.position = ccp(screenSize.width/2, screenSize.height/2 + 100);
        [self addChild:warningErrorLabel];
        
        // Hacked Error Message2
        CCLabelTTF *warningErrorLabel2 = [CCLabelTTF labelWithString:errorMessage2 fontName:@"Arial Rounded MT Bold" fontSize:10];
        warningErrorLabel2.color = ccGREEN;
        warningErrorLabel2.position = ccp(screenSize.width/2, screenSize.height/2 - 50);
        [self addChild:warningErrorLabel2];
        
        // Creates "Back" button
        /*CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
        CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
        //backButtonText.fontSize = 20;
        [backButtonText setFontName:@"Marker Felt"];
        backButton.color = ccRED;
        backButton.position = ccp(50, 35);
        
        CCMenu* menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];*/
        
    } else if (gameTypeInt == 3) {
        [[CCDirector sharedDirector] setDisplayFPS:NO];
        
        CCLabelTTF *fpsLabel = [CCLabelTTF labelWithString:@"00.0fps" fontName:@"Times New Roman" fontSize:15];
        fpsLabel.position = ccp(30, 10);
        [self addChild:fpsLabel];
        
        // Creates the "Checkers" title
        CCLabelTTF *checkersLabel = [CCLabelTTF labelWithString:@"Checkers" fontName:@"Arial Rounded MT Bold" fontSize:25];
        checkersLabel.color = ccBLUE;
        checkersLabel.position = ccp(screenSize.width/2 + 30, screenSize.height-30);
        //[self addChild:checkersLabel];
        
        // Hacked Error Message
        CCLabelTTF *warningErrorLabel = [CCLabelTTF labelWithString:errorMessage fontName:@"Arial Rounded MT Bold" fontSize:12.5];
        warningErrorLabel.color = ccGREEN;
        warningErrorLabel.position = ccp(screenSize.width/2, screenSize.height/2 + 100);
        [self addChild:warningErrorLabel];
        
        // Hacked Error Message2
        CCLabelTTF *warningErrorLabel2 = [CCLabelTTF labelWithString:errorMessage2 fontName:@"Arial Rounded MT Bold" fontSize:10];
        warningErrorLabel2.color = ccGREEN;
        warningErrorLabel2.position = ccp(screenSize.width/2, screenSize.height/2 - 50);
        [self addChild:warningErrorLabel2];
        
        // Creates "Back" button
        /*CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
        CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
        //backButtonText.fontSize = 20;
        [backButtonText setFontName:@"Marker Felt"];
        backButton.color = ccRED;
        backButton.position = ccp(50, 35);
        
        CCMenu* menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];*/
        
    }else if (gameTypeInt == 4) {
        // Create background
        CCSprite *background = [CCSprite spriteWithFile:@"Background@2x.png"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:background];
        
        // Creates the "Latrunculi" title
        CCLabelTTF *latrunculiLabel = [CCLabelTTF labelWithString:@"Latrunculi" fontName:@"Arial Rounded MT Bold" fontSize:25];
        latrunculiLabel.color = ccBLUE;
        latrunculiLabel.position = ccp(screenSize.width/2 + 30, screenSize.height-30);
        [self addChild:latrunculiLabel];
        
        // Creates the "One Player" button
        CCMenuItemFont *onePlayerButtonText = [CCMenuItemFont itemFromString:@"One Player"];
        CCMenuItemToggle *onePlayerButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(onePlayerButtonPressed) items:onePlayerButtonText, nil];
        onePlayerButton.position = ccp(screenSize.width/2, screenSize.height/2+50);
        
        // Creates the "Two Player" button
        CCMenuItemFont *twoPlayerButtonText = [CCMenuItemFont itemFromString:@"Two Player"];
        CCMenuItemToggle *twoPlayerButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(twoPlayerButtonPressed) items:twoPlayerButtonText, nil];
        twoPlayerButton.position = ccp(screenSize.width/2, screenSize.height/2-50);
        
        // Creates the "Zero Player" button
        CCMenuItemFont *zeroPlayerButtonText = [CCMenuItemFont itemFromString:@"Zero Player"];
        CCMenuItemToggle *zeroPlayerButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(zeroPlayerButtonPressed) items:zeroPlayerButtonText, nil];
        zeroPlayerButton.position = ccp(screenSize.width/2, screenSize.height/2-150);
        
        // Creates "Back" button
        CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
        CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
        //backButtonText.fontSize = 20;
        [backButtonText setFontName:@"Marker Felt"];
        backButton.color = ccRED;
        backButton.position = ccp(50, 35);
        
        CCMenu* menu = [CCMenu menuWithItems:onePlayerButton, twoPlayerButton, zeroPlayerButton, backButton, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];
    }
}

-(id)initWithGameType:(Game)gameTypeInt {
    if((self=[super init])) {
        self.isTouchEnabled = YES;
        swipeUp1 = NO;
        swipeRight1 = NO;
        swipeUp2 = NO;
        swipeDown = NO;
        swipeLeft = NO;
        swipeRight2 = NO;
        [self determineAndCreateGameType:gameTypeInt];
    }
    return self;
}

@end
