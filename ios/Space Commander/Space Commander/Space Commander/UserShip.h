//
//  UserShip.h
//  Space Commander
//
//  Created by Adam Mellan on 11/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpaceShip.h"
#import "Enemy.h"
#import "CoreDataManager.h"

@interface UserShip : SpaceShip {
    NSManagedObjectContext *mocTemp;
}

@property (nonatomic, assign)int gold;
@property (nonatomic, assign)int goldInc;
@property (nonatomic, assign)int manaNeeded;
+ (UserShip *)userShipWithFile:(NSString *)file;
-(void)goldIncrease;
-(void)manaIncrease:(float)plusMana;
-(void)healthIncrease:(float)plusHealth;
+(CCScene *) userShipScene;


@end
