//
//  Enemy.h
//  Scenes
//
//  Created by Chris Reddy on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#define radToDeg(x)     (x * (180/M_PI))
#define degToRad(x)     (x * (M_PI/180))


@interface Enemy : CCSprite {
    
}
@property (nonatomic, retain) CCSprite *target;
@property (nonatomic, assign) float maxHealth;
@property (nonatomic, assign) float health;
@property (nonatomic, assign) float projectileSpeed;
@property (nonatomic, assign) float projectileDistance;
@property (nonatomic, assign) float projectileDamage;
@property (nonatomic, assign) float projectileRotation;
@property (nonatomic, assign) int type;

+ (Enemy *)enemyWithFile:(NSString *)file target:(CCSprite *)targ winSize:(CGSize)winSize;
-(void)checkBoundariesOfNearByShips:(NSMutableArray *)enemiesArray;
- (void)activateScheduler;
- (void)deactivateScheduler;
-(void)moveEnemy;
-(void)moveEnemy2;
-(void)moveEnemy3;

@end
