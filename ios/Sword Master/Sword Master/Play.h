//
//  Play.h
//  Latrunculi
//
//  Created by Adam Mellan on 2/26/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZJoystick.h"

@interface Play : CCLayer <ZJoystickDelegate> {
    CCMenuItemImage *leftButton;
    CCMenuItemImage *rightButton;
    CCMenuItemImage *jumpButton;
    CCMenuItemImage *attackButton;
    
    CCSprite *leftButton2;
    CCSprite *rightButton2;
    CCSprite *ltAndRtMovementButtons;
    CCSprite *testBridge;
    
    BOOL characterWalkedOffPlatformLeft;
    BOOL characterWalkedOffPlatformRight;
    BOOL checkingLeftButton;
    BOOL checkingRightButton;
    BOOL justMoved;
    BOOL isJumping;
    BOOL isWalkingLeft;
    BOOL isWalkingRight;
    BOOL isWalkRightButtonSelected;
    BOOL isWalkLeftButtonSelected;
    
    float characterMoveSpeed;
    float characterMoveDuration;
    float characterMoveDistance;
    float xVel;
    float yVel;
    
    int checkJumpThingy;
    
    CGPoint firstTouch;
    CGPoint lastTouch;
    
    CGSize screenSize;
    CCMenu *jumpButtonMenu;
}
@property (nonatomic, strong) CCSprite *character;
@property (nonatomic, retain) CCSprite *rightPlatform;
@property (nonatomic, retain) CCSprite *healthBarOutline;
@property (nonatomic, retain) CCSprite *manaBarOutline;
@property (nonatomic, strong) CCAction *walkingAnimation;
@property (nonatomic, retain) CCAction *standingStillAnimation;
@property (nonatomic, retain) CCAction *standingStillAction;
@property (nonatomic, retain) CCAction *walkLeftAction;
@property (nonatomic, retain) CCAction *walkRightAction;
@property (nonatomic, retain) CCAction *jumpAnimation;
@property (nonatomic, retain) CCAction *jumpRightAction;
@property (nonatomic, retain) CCAction *jumpLeftAction;
@property (nonatomic, retain) CCAction *jumpStandingStillAction;
@property (nonatomic, retain) CCAction *sAttackAction;
@property (nonatomic, retain) CCAction *wAttackAction;
@property (nonatomic, retain) CCProgressTimer *healthBar;
@property (nonatomic, retain) CCProgressTimer *manaBar;
@property (nonatomic, assign) CGPoint characterTempPostion;
@property (nonatomic, assign) CGPoint jumpVector;
@property (nonatomic, assign) CGPoint characterVelocity;
@property (nonatomic, retain) NSMutableArray *enemies;
@property (nonatomic, assign) float health;
@property (nonatomic, assign) float mana;

+(CCScene *)playScene;
-(void)pausePlayScene;
-(void)resumePlayScene;

@end
