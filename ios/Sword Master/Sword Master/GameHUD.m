//
//  GameHUD.m
//  Space Commander
//
//  Created by Adam Mellan on 8/10/12.
//
//

#import "GameHUD.h"
#import "ZJoystick.h"

@implementation GameHUD
@synthesize joystick;
@synthesize joystickShoot;

- (id)init {
    if (self = [super init]) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        joystick = [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" selectedSpriteFile:@"JoystickContainer_trans.png" controllerSpriteFile:@"Joystick_norm.png"];
        joystick.position = ccp(50, screenSize.height-50);
        joystick.speedRatio = 6.0f;
        joystick.joystickRadius = 150.0f;
        joystick.scale = 0.3;
        //[self addChild:joystick z:1];
        
        joystickShoot = [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" selectedSpriteFile:@"JoystickContainer_trans.png" controllerSpriteFile:@"Joystick_norm.png"];
        joystickShoot.position = ccp(50,50);
        joystickShoot.speedRatio = 6.0f;
        joystickShoot.joystickRadius = 150.0f;
        joystickShoot.scale = 0.3;
        //[self addChild:joystickShoot z:1];
        
        //countDown = 4;
    }
    return self;
}

@end
