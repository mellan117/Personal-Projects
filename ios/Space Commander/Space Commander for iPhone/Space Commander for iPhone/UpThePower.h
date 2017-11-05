//
//  UpThePower.h
//  Space-Commander
//
//  Created by Adam Mellan on 3/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    health,
    mana
    }PowerUpType;

@interface UpThePower : CCSprite {
    
}
@property (nonatomic, assign) PowerUpType *powerUp;

@end
