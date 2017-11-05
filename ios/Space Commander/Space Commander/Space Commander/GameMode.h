//
//  GameMode.h
//  Space-Commander
//
//  Created by Adam Mellan on 1/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    ModeSurvival = 1,
    ModeNormal
} Mode;

@interface GameMode : CCLayer {
    NSManagedObjectContext *mocTemp;
}

+(CCScene *)gameModeScene;

@end
