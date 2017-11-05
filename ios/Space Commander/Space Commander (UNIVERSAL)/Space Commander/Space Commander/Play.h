//
//  Play.h
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZJoystick.h"
#import "Enemy.h"
#import "GameMode.h"
#import "UserShip.h"

@class GameHUD;

#define radToDeg(x) (x * (180/M_PI))
#define degToRad(x) (x * (M_PI/180))

@interface Play : CCLayer <ZJoystickDelegate, EnemyDelegate> {
    //CCSprite *ship;
    UserShip *ship;
    CCSprite *projectile;
    CCSprite *speedPowerUp;
    CCLabelTTF *timeLabel;
    NSMutableArray *projectiles;
    NSMutableArray *enemies;
    NSMutableArray *totalEnemies;
    NSMutableArray *powerUps;
    int numberOfEnemies;
    int level;
    int i;
    NSManagedObjectContext *mocTemp;
    NSManagedObjectContext *mocUsers;
    BOOL destroyEnemies;
}
@property (nonatomic, assign) Mode mode;
@property (nonatomic, assign)int time;
@property (nonatomic, retain)CCMenuItemImage *shootButton;
@property (nonatomic, retain)NSMutableArray *menuArray;
@property (nonatomic, assign)BOOL shootButtonBeenPressed;
@property (nonatomic, assign)BOOL isGameOver;
@property (nonatomic, assign)BOOL hi;

+(CCScene *)playSceneWithMode:(Mode)gameModeInt;
-(id)initWithHUD:(GameHUD *)hud mode:(Mode)gameMode;
-(void)enemyHitTarget;
-(void)level:(int)levell;
-(BOOL)shouldDestroyEnemies:(BOOL)destroy;
-(void)destroyAllEnemies;
-(void)addEnemy;
-(void)gameOver;

@end