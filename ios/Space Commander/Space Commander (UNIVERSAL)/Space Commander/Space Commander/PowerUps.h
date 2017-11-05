//
//  PowerUps.h
//  Space-Commander
//
//  Created by Adam Mellan on 2/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpaceShip.h"
#import "UserShip.h"
#import "GameHUD.h"
#import "Play.h"

@interface PowerUps : CCLayer {
    UserShip *ship;
    NSMutableArray *enmies;
    NSMutableArray *hy;
}

@property (nonatomic, retain)NSMutableArray *healthPUArray;
@property (nonatomic, retain)NSMutableArray *manaPUArray;
@property (nonatomic, retain)NSMutableArray *totalDestructionPUArray;
@property (nonatomic, retain)NSMutableArray *totalPowerUpsArray;
@property (nonatomic, retain)NSMutableArray *speedIncreasePUArray;
@property (nonatomic, retain)NSMutableArray *enemyProjectileSpeedDecreasePUArray;
@property (nonatomic, retain)NSMutableArray *enemyProjectileDistancePUArray;
@property (nonatomic, retain)NSMutableArray *enemyProjectileDamageDecreasePUArray;
@property (nonatomic, retain)NSMutableArray *projectileSpeedIncreasePUArray;
@property (nonatomic, retain)NSMutableArray *enemySpeedDecreasePUArray;
@property (nonatomic, retain)NSMutableArray *healthRegenerationPUArray;
@property (nonatomic, retain)NSMutableArray *manaIncreasePUArray;
@property (nonatomic, retain)NSMutableArray *manaGenerationPUArray;
@property (nonatomic, retain)NSMutableArray *projectileDamageIncreasePUArray;
@property (nonatomic, retain)NSMutableArray *projectileDistanceIncreasePUArray;
@property (nonatomic, assign)id delegate;

-(id)powerUps:(UserShip *)shipy withHud:(GameHUD *)hud withPlayScene:(Play *)playScene;
-(void)deactivateSelector;
-(NSMutableArray *)destroyArray:(NSMutableArray *)enemies;
-(void)totalDestruction:(NSMutableArray *)enemiesArray;
-(void)removePower:(CCSprite *)powerUp withArray:(NSMutableArray *)array;

@end
