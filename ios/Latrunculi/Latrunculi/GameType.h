//
//  GameType.h
//  Latrunculi
//
//  Created by Adam Mellan on 12/1/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    GameDots = 1,
    GameChess = 2,
    GameCheckers = 3,
    GameLatrunculi = 4,
} Game;

@interface GameType : CCLayer {
    
}

+(CCScene *)gameTypeScene;

@end
