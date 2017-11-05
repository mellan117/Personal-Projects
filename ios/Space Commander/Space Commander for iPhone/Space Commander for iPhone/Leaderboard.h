//
//  Leaderboard.h
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Leaderboard : CCNode {
    NSManagedObjectContext *mocTemp;
}
+(CCScene *)leaderboardScene;

@end
