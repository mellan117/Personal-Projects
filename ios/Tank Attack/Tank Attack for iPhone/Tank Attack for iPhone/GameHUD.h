//
//  GameHUD.h
//  Tank Attack
//
//  Created by Adam Mellan on 10/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZJoyStick.h"

@interface GameHUD : CCLayer {
    
}
@property (nonatomic, retain) ZJoystick *joystickTankBody;
@property (nonatomic, retain) ZJoystick *joystickTankBarrel;

@end
