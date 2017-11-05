//
//  SpaceShip.h
//  Space Commander
//
//  Created by Adam Mellan on 11/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define radToDeg(x) (x * (180/M_PI))
#define degToRad(x) (x * (M_PI/180))

@interface SpaceShip : CCSprite {
    int m;
}
@property (nonatomic, retain)NSMutableArray *projectiles;
@property (nonatomic, retain)id delegate;
@property (nonatomic, retain)SpaceShip *target;
@property (nonatomic, assign)BOOL hitTarget;
@property (nonatomic, assign)float maxMana;
@property (nonatomic, assign)float maxHealth;
@property (nonatomic, assign)float health;
@property (nonatomic, assign)float mana;
@property (nonatomic, assign)float manaInc;
@property (nonatomic, assign)float healthInc;
@property (nonatomic, assign)float speed;
@property (nonatomic, assign)float healthRegen;
@property (nonatomic, assign)float manaGen;
@property (nonatomic, assign)float projectileDamage;
@property (nonatomic, assign)float projectileDistance;
@property (nonatomic, assign)float projectileSpeed;
@property (nonatomic, assign)float projectileDamageInc;
@property (nonatomic, assign)float projectileDistanceInc;
@property (nonatomic, assign)float projectileSpeedInc;


-(void)shoot;
-(void)damage:(id)playy;
-(void)collisionDetection;

@end
