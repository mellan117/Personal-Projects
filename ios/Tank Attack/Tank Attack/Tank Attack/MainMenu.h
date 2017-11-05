//
//  MainMenu.h
//  Tank Attack
//
//  Created by Adam Mellan on 10/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainMenu : CCLayer {
    CCSprite *ccLaunchImage;
    BOOL isCCLaunchImageBeingDisplayedForTheFirstTime;
}
+(CCScene *)mainMenuScene:(BOOL)isCCLaunchImageBeingDisplayedForTheFirstTime;

@end
