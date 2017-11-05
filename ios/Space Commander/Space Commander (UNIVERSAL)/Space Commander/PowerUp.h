//
//  PowerUp.h
//  Space Commander
//
//  Created by Adam Mellan on 1/19/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Play.h"
#import "GameHUD.h"
#import "UserShip.h"

@interface PowerUp : CCLayer {
    
}

@property (nonatomic, retain)UserShip *ship;
@property (nonatomic, retain)GameHUD *hud;
@property (nonatomic, assign)float incHealth;
@property (nonatomic, assign)float incMana;
@property (nonatomic, assign)float regenHealth;
@property (nonatomic, assign)float genMana;
@property (nonatomic, assign)float incSpeed;
@property (nonatomic, assign)float incProjDam;
@property (nonatomic, assign)float incProjDis;
@property (nonatomic, assign)float incProjSpeed;
@property (nonatomic, retain)NSMutableArray *healthPUArray;
@property (nonatomic, retain)NSMutableArray *manaPUArray;
@property (nonatomic, retain)NSMutableArray *healthRegenerationPUArray;
@property (nonatomic, retain)NSMutableArray *manaGenerationPUArray;
@property (nonatomic, retain)NSMutableArray *speedIncreasePUArray;
@property (nonatomic, retain)NSMutableArray *projectileDamageIncreasePUArray;
@property (nonatomic, retain)NSMutableArray *projectileDistanceIncreasePUArray;
@property (nonatomic, retain)NSMutableArray *projectileSpeedIncreasePUArray;

-(void)initWithPowerUps:(UserShip *)userShip withHUD:(GameHUD *)HUD withScene:(Play *)scene;
-(void)deactivateScheduler;

@end
