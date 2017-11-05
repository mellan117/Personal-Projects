//
//  GameMode.h
//  Space-Commander
//
//  Created by Adam Mellan on 1/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameType.h"

typedef enum {
    ModeP1vsP2 = 1,
    ModeP2vsP1 = 2,
    ModeP1vsCPU = 3,
    ModeCPUvsP1 = 4,
    ModeCPU1vsCPU2 = 5,
    ModeCPU2vsCPU1 = 6,
} Mode;

/*typedef enum {
    Swipe = 0,
    SwipeUp1 = 1,
    SwipeRight1 = 2,
    SwipeUp2 = 3,
    SwipeDown = 4,
    SwipeLeft = 5,
    SwipeRight2 = 6,
} SwipeDirection;*/

@interface GameMode : CCLayer {
    BOOL swipeUp1;
    BOOL swipeRight1;
    BOOL swipeUp2;
    BOOL swipeDown;
    BOOL swipeLeft;
    BOOL swipeRight2;
    
    CGPoint firstTouch;
    CGPoint lastTouch;
}

+(CCScene *)gameModeSceneWithGameType:(Game)gameTypeInt;

@end
