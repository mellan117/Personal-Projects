//
//  GameHUD.h
//  Space Commander
//
//  Created by Adam Mellan on 8/10/12.
//
//

#import "cocos2d.h"
#import "ZJoystick.h"

@interface GameHUD : CCLayer {
    ZJoystick *joystick;
}
@property (nonatomic, retain) ZJoystick *joystick;
@property (nonatomic, retain) ZJoystick *joystickShoot;


@end