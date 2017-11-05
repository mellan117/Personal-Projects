//
//  Play.h
//  Tank Attack
//
//  Created by Adam Mellan on 10/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZJoyStick.h"
#import "Tank.h"
#import "UserTank.h"
#import "EnemyTank.h"
#import "GameHUD.h"

#define radToDeg(x)((x) * (180/M_PI))
#define degToRad(x)((x) * (M_PI/180))

@interface Play : CCLayer <ZJoystickDelegate, EnemyDelegate> {
    //CCSprite *projectile;
    EnemyTank *tankEnemy;
    UserTank *tankUser;
    NSString *tankBarrelFile;
    NSString *tankBodyFile;
    NSMutableArray *projectiles;
    NSMutableArray *enemies;
    NSMutableArray *verticalWallsArray;
    NSMutableArray *horizontalWallsArray;
    NSManagedObjectContext *mocTemp;
}
@property (nonatomic, assign) id delegatePlay;
@property (nonatomic, assign)BOOL isShooting;
@property (nonatomic, assign)int amountOfEnemies;

+(CCScene *)playScene;
-(id)initWithHUD:(GameHUD *)hud;
-(void)deleteEnemyFromEnemiesArray;
-(void)enemyHitTarget;
-(void)gameOver;

@end
