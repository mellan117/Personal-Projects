//
//  GameHUD.m
//  Tank Attack
//
//  Created by Adam Mellan on 10/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameHUD.h"


@implementation GameHUD
@synthesize joystickTankBody;
@synthesize joystickTankBarrel;

-(id)init {
    if (self = [super init]) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        joystickTankBody = [[ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" /////>>> recreated here<<<<////
                                             selectedSpriteFile:@"JoystickContainer_trans.png"
                                           controllerSpriteFile:@"Joystick_norm.png"] retain];
        joystickTankBody.position = ccp(joystickTankBody.contentSize.width, joystickTankBody.contentSize.height);
        joystickTankBody.speedRatio = 4.0f;
        joystickTankBody.joystickRadius = 50.0f;
        joystickTankBody.scale = 1.5;
        [self addChild:joystickTankBody z:1 tag:1];
        
        joystickTankBarrel = [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" selectedSpriteFile:@"JoystickContainer_trans.png" controllerSpriteFile:@"Joystick_norm.png"];
        joystickTankBarrel.position = ccp(screenSize.width - joystickTankBarrel.contentSize.width/2, joystickTankBarrel.contentSize.height/2);
        joystickTankBarrel.speedRatio = 4.0f;
        joystickTankBarrel.joystickRadius = 50.0f;
        joystickTankBarrel.scale = 1.1;
        [self addChild:joystickTankBarrel z:2 tag:2];
    }
    return self;
}

@end
