//
//  EnemyTank.h
//  Tank Attack
//
//  Created by Adam Mellan on 10/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tank.h"
#import "UserTank.h"

@protocol EnemyDelegate <NSObject>
- (void)enemyHitTarget;

@end

@interface EnemyTank : Tank {
    CGFloat rate;
    ccTime interval;
    EnemyTank *enemy;
}

@property (nonatomic, retain)UserTank *target;
@property (nonatomic, assign)CGFloat rate;
@property (nonatomic, assign)BOOL hitMe;
@property (nonatomic, retain)CCSprite *projectile;

+(EnemyTank *)createTank:(NSString *)tankBodyFile tankBarrelFile:(NSString*)tankBarrelFile;
+(EnemyTank *)createTank:(NSString *)tankBodyFile withTankBarrelFile:(NSString*)tankBarrelFile withTarget:(UserTank *)targ withSize:(CGSize)screenSize;
-(void)activateScheduler;
-(void)deactivateSchuduler;
-(void)takenDamage;
-(id)initWithEnemy:(EnemyTank *)enmy;

@end
