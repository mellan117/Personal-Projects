//
//  Enemy.h
//  Scenes
//
//  Created by Chris Reddy on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "SpaceShip.h"
#import "UserShip.h"

#define radToDeg(x)     (x * (180/M_PI))
#define degToRad(x)     (x * (M_PI/180))

@protocol EnemyDelegate <NSObject>
- (void)enemyHitTarget;

@end

@interface Enemy : SpaceShip {
    //UserShip *target;
    CGFloat rate;
    ccTime interval;
    
    id <EnemyDelegate> delegate;
}

//@property (nonatomic, retain) UserShip *target;
@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, assign) float health;
@property (nonatomic, assign) float maxHealth;
@property (nonatomic, retain) id <EnemyDelegate> delegate;
@property (nonatomic, retain)id dele;
@property (nonatomic, retain)CCProgressTimer *healthBar;
@property (nonatomic, retain)CCSprite *healthBarOutline;
@property (nonatomic, retain)CCLabelTTF *healthNum;
@property (nonatomic, retain)NSMutableArray *enemiesArray;
@property (nonatomic, retain)CCSprite *projectile;

+ (Enemy *)enemyWithFile:(NSString *)file target:(CCSprite *)targ winSize:(CGSize)winSize;
- (void)activateScheduler;
- (void)deactivateScheduler;
-(void)damageTaken;
-(void)destroyAll:(NSMutableArray *)enemies;
-(void)destroy:(NSMutableArray *)enemies withEnmy:(Enemy *)enmy;

@end
