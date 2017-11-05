//
//  PowerUp.m
//  Space Commander
//
//  Created by Adam Mellan on 1/19/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "PowerUp.h"
#import "Play.h"
#import "GameHUD.h"
#import "UserShip.h"
#import "ResizeSprite.h"

#define bgWidth 1919
#define bgHeight 1224

@implementation PowerUp
@synthesize ship;
@synthesize hud;
@synthesize incHealth;
@synthesize incMana;
@synthesize regenHealth;
@synthesize genMana;
@synthesize incSpeed;
@synthesize incProjDam;
@synthesize incProjDis;
@synthesize incProjSpeed;
@synthesize healthPUArray;
@synthesize manaPUArray;
@synthesize healthRegenerationPUArray;
@synthesize manaGenerationPUArray;
@synthesize speedIncreasePUArray;
@synthesize projectileDamageIncreasePUArray;
@synthesize projectileDistanceIncreasePUArray;
@synthesize projectileSpeedIncreasePUArray;

Play *playScene;
ResizeSprite *_resizeSprite;

-(void)increaseHealth {
    if (ship.health + incHealth >= ship.maxHealth) {
        ship.health = ship.maxHealth;
        hud.healthBar.percentage = ship.health;
    } else {
        ship.health += incHealth;
        hud.healthBar.percentage = ship.health;
    }
}

-(void)increaseMana {
    if (ship.mana + incMana >= ship.maxMana) {
        ship.mana = ship.maxMana;
        hud.manaBar.percentage = ship.mana;
    } else {
        ship.mana += incMana;
        hud.manaBar.percentage = ship.mana;
    }
}

-(void)healthRegeneration {
    static int regenXTimes = 0;
    
    if (regenXTimes <= 5) {
        if (ship.health + regenHealth >= ship.maxHealth) {
            ship.health = ship.maxHealth;
            hud.healthBar.percentage = ship.health;
        } else {
            ship.health += regenHealth;
            hud.healthBar.percentage = ship.health;
        }
        regenXTimes += 1;
        [self performSelector:@selector(healthRegeneration) withObject:nil afterDelay:0.5];
    } else {
        regenXTimes = 0;
    }
}

-(void)manaGeneration {
    static int genXTimes = 0;
    
    if (genXTimes <= 5) {
        if (ship.mana + genMana >= ship.maxMana) {
            ship.mana = ship.maxMana;
            hud.manaBar.percentage = ship.mana;
        } else {
            ship.mana += genMana;
            hud.manaBar.percentage = ship.mana;
        }
        genXTimes += 1;
        [self performSelector:@selector(manaGeneration) withObject:nil afterDelay:0.5];
    } else {
        genXTimes = 0;
    }
}

-(void)speedBoost {
    static int x = 0;
    
    if (x <= 0) {
        ship.speed += incSpeed;
        hud.joystick.speedRatio = ship.speed;
        x += 1;
        [self performSelector:@selector(speedBoost) withObject:nil afterDelay:5];
    } else {
        ship.speed -= incSpeed;
        hud.joystick.speedRatio = ship.speed;
        x = 0;
    }
}

-(void)projectileDamageIncrease {
    static int x = 0;
    
    if (x <= 0) {
        ship.projectileDamage += incProjDam;
        x += 1;
        [self performSelector:@selector(projectileDamageIncrease) withObject:nil afterDelay:5];
    } else {
        ship.projectileDamage -= incProjDam;
        x = 0;
    }
}

-(void)projectileDistanceIncrease {
    static int x = 0;
    
    if (x <= 0) {
        ship.projectileDistance += incProjDis;
        x += 1;
        [self performSelector:@selector(projectileDistanceIncrease) withObject:nil afterDelay:5];
    } else {
        ship.projectileDistance -= incProjDis;
        x = 0;
    }
}

-(void)projectileSpeedIncrease {
    static int x = 0;
    
    if (x <= 0) {
        ship.projectileSpeed += incProjSpeed;
        x += 1;
        [self performSelector:@selector(projectileSpeedIncrease) withObject:nil afterDelay:5];
    } else {
        ship.projectileSpeed -= incProjSpeed;
        x = 0;
    }
}

// Corresponding Sprite "+H"
-(void)healthPowerUp {
    CGPoint range;
    CGPoint position;
    CCSprite *healthPowerUp = [CCSprite spriteWithFile:@"+H.png"];
    range.x = (bgWidth - healthPowerUp.contentSize.width) - healthPowerUp.contentSize.width;
    range.y = (bgHeight - healthPowerUp.contentSize.height) - healthPowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + healthPowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + healthPowerUp.contentSize.height;
    healthPowerUp.position = position;
    healthPowerUp.scale = [_resizeSprite resizeImage];
    //healthPowerUp.position = ccp(100, 100);
    [playScene addChild:healthPowerUp z:999];
    [healthPUArray addObject:healthPowerUp];
}

// Corresponding Sprite "+M"
-(void)manaPowerUp {
    CGPoint range;
    CGPoint position;
    CCSprite *manaPowerUp = [CCSprite spriteWithFile:@"+M.png"];
    range.x = (bgWidth - manaPowerUp.contentSize.width) - manaPowerUp.contentSize.width;
    range.y = (bgHeight - manaPowerUp.contentSize.height) - manaPowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + manaPowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + manaPowerUp.contentSize.height;
    manaPowerUp.position = position;
    manaPowerUp.scale = [_resizeSprite resizeImage];
    //manaPowerUp.position = ccp(100, 100);
    [playScene addChild:manaPowerUp z:999];
    [manaPUArray addObject:manaPowerUp];
}

// Corresponding Sprite "+HR"
-(void)healthRegenerationPowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *healthRegenerationPU = [CCSprite spriteWithFile:@"+HR.png"];
    range.x = (bgWidth - healthRegenerationPU.contentSize.width) - healthRegenerationPU.contentSize.width;
    range.y = (bgHeight - healthRegenerationPU.contentSize.height) - healthRegenerationPU.contentSize.height;
    position.x = arc4random() % (int)range.x + healthRegenerationPU.contentSize.width;
    position.y = arc4random() % (int)range.y + healthRegenerationPU.contentSize.height;
    healthRegenerationPU.position = position;
    healthRegenerationPU.scale = [_resizeSprite resizeImage];
    //healthRegenerationPU.position = ccp(100, 100);
    [playScene addChild:healthRegenerationPU z:999];
    [healthRegenerationPUArray addObject:healthRegenerationPU];
}

// Corresponding Sprite "++M"
-(void)manaGenerationPowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *manaGenerationPU = [CCSprite spriteWithFile:@"++M.png"];
    range.x = (bgWidth - manaGenerationPU.contentSize.width) - manaGenerationPU.contentSize.width;
    range.y = (bgHeight - manaGenerationPU.contentSize.height) - manaGenerationPU.contentSize.height;
    position.x = arc4random() % (int)range.x + manaGenerationPU.contentSize.width;
    position.y = arc4random() % (int)range.y + manaGenerationPU.contentSize.height;
    manaGenerationPU.position = position;
    manaGenerationPU.scale = [_resizeSprite resizeImage];
    //manaGenerationPU.position = ccp(100, 100);
    [playScene addChild:manaGenerationPU z:999];
    [manaGenerationPUArray addObject:manaGenerationPU];
}

// Corresponding Sprite "+S"
-(void)speedIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *speedIncreasePU = [CCSprite spriteWithFile:@"+S.png"];
    range.x = (bgWidth - speedIncreasePU.contentSize.width) - speedIncreasePU.contentSize.width;
    range.y = (bgHeight - speedIncreasePU.contentSize.height) - speedIncreasePU.contentSize.height;
    position.x = arc4random() % (int)range.x + speedIncreasePU.contentSize.width;
    position.y = arc4random() % (int)range.y + speedIncreasePU.contentSize.height;
    speedIncreasePU.position = position;
    speedIncreasePU.scale = [_resizeSprite resizeImage];
    //speedIncreasePU.position = ccp(100, 100);
    [playScene addChild:speedIncreasePU z:999];
    [speedIncreasePUArray addObject:speedIncreasePU];
}

// Corresponding Sprite "+PDam"
-(void)projectileDamageIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *projectileDamageIncreasePU = [CCSprite spriteWithFile:@"+PDam.png"];
    range.x = (bgWidth - projectileDamageIncreasePU.contentSize.width) - projectileDamageIncreasePU.contentSize.width;
    range.y = (bgHeight - projectileDamageIncreasePU.contentSize.height) - projectileDamageIncreasePU.contentSize.height;
    position.x = arc4random() % (int)range.x + projectileDamageIncreasePU.contentSize.width;
    position.y = arc4random() % (int)range.y + projectileDamageIncreasePU.contentSize.height;
    projectileDamageIncreasePU.position = position;
    projectileDamageIncreasePU.scale = [_resizeSprite resizeImage];
    //projectileDamageIncreasePU.position = ccp(100, 100);
    [playScene addChild:projectileDamageIncreasePU z:999];
    [projectileDamageIncreasePUArray addObject:projectileDamageIncreasePU];
}

// Corresponding Sprite "+PDis"
-(void)projectileDistanceIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *projectileDistanceIncreasePU = [CCSprite spriteWithFile:@"+PDis.png"];
    range.x = (bgWidth - projectileDistanceIncreasePU.contentSize.width) - projectileDistanceIncreasePU.contentSize.width;
    range.y = (bgHeight - projectileDistanceIncreasePU.contentSize.height) - projectileDistanceIncreasePU.contentSize.height;
    position.x = arc4random() % (int)range.x + projectileDistanceIncreasePU.contentSize.width;
    position.y = arc4random() % (int)range.y + projectileDistanceIncreasePU.contentSize.height;
    projectileDistanceIncreasePU.position = position;
    projectileDistanceIncreasePU.scale = [_resizeSprite resizeImage];
    //projectileDistanceIncreasePU.position = ccp(100, 100);
    [playScene addChild:projectileDistanceIncreasePU z:999];
    [projectileDistanceIncreasePUArray addObject:projectileDistanceIncreasePU];
}

// Corresponding Sprite "+PS"
-(void)projectileSpeedIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *projectileSpeedIncreasePU = [CCSprite spriteWithFile:@"+PS.png"];
    range.x = (bgWidth - projectileSpeedIncreasePU.contentSize.width) - projectileSpeedIncreasePU.contentSize.width;
    range.y = (bgHeight - projectileSpeedIncreasePU.contentSize.height) - projectileSpeedIncreasePU.contentSize.height;
    position.x = arc4random() % (int)range.x + projectileSpeedIncreasePU.contentSize.width;
    position.y = arc4random() % (int)range.y + projectileSpeedIncreasePU.contentSize.height;
    projectileSpeedIncreasePU.position = position;
    projectileSpeedIncreasePU.scale = [_resizeSprite resizeImage];
    //projectileSpeedIncreasePU.position = ccp(100, 100);
    [playScene addChild:projectileSpeedIncreasePU z:999];
    [projectileSpeedIncreasePUArray addObject:projectileSpeedIncreasePU];
}

- (void)update {
    [self collisionDetectionPowerUps];
}

-(void)collisionDetectionPowerUps {
    NSMutableArray *healthPowerUpToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *manaPowerUpToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *healthRegenerationPowerUpToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *manaGenerationPowerUpToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *speedIncreasePowerUpToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *projectileDamagePowerUpToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *projectileDistancePowerUpToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *projectileSpeedPowerUpToRemove = [[NSMutableArray alloc] init];
    
    for (CCSprite *healthPU in healthPUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, healthPU.boundingBox)) {
            [self increaseHealth];
            [healthPowerUpToRemove addObject:healthPU];
        }
    }
    for (CCSprite *healthPU in healthPowerUpToRemove) {
        [playScene removeChild:healthPU cleanup:YES];
        [healthPUArray removeObject:healthPU];
    }
    
    for (CCSprite *manaPU in manaPUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, manaPU.boundingBox)) {
            [self increaseMana];
            [manaPowerUpToRemove addObject:manaPU];
        }
    }
    for (CCSprite *manaPU in manaPowerUpToRemove) {
        [playScene removeChild:manaPU cleanup:YES];
        [manaPUArray removeObject:manaPU];
    }
    
    for (CCSprite *healthRegenerationPU in healthRegenerationPUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, healthRegenerationPU.boundingBox)) {
            [self healthRegeneration];
            [healthRegenerationPowerUpToRemove addObject:healthRegenerationPU];
        }
    }
    for (CCSprite *healthRegenerationPU in healthRegenerationPowerUpToRemove) {
        [playScene removeChild:healthRegenerationPU cleanup:YES];
        [healthRegenerationPUArray removeObject:healthRegenerationPU];
    }
    
    for (CCSprite *manaGenerationPU in manaGenerationPUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, manaGenerationPU.boundingBox)) {
            [self manaGeneration];
            [manaGenerationPowerUpToRemove addObject:manaGenerationPU];
        }
    }
    for (CCSprite *manaGenerationPU in manaGenerationPowerUpToRemove) {
        [playScene removeChild:manaGenerationPU cleanup:YES];
        [manaGenerationPUArray removeObject:manaGenerationPU];
    }
    
    for (CCSprite *speedIncreasePU in speedIncreasePUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, speedIncreasePU.boundingBox)) {
            [self speedBoost];
            [speedIncreasePowerUpToRemove addObject:speedIncreasePU];
        }
    }
    for (CCSprite *speedIncreasePU in speedIncreasePowerUpToRemove) {
        [playScene removeChild:speedIncreasePU cleanup:YES];
        [speedIncreasePUArray removeObject:speedIncreasePU];
    }
    
    for (CCSprite *projectileDamageIncreasePU in projectileDamageIncreasePUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, projectileDamageIncreasePU.boundingBox)) {
            [self projectileDamageIncrease];
            [projectileDamagePowerUpToRemove addObject:projectileDamageIncreasePU];
        }
    }
    for (CCSprite *projectileDamageIncreasePU in projectileDamagePowerUpToRemove) {
        [playScene removeChild:projectileDamageIncreasePU cleanup:YES];
        [projectileDamageIncreasePUArray removeObject:projectileDamageIncreasePU];
    }
    
    for (CCSprite *projectileDistanceIncreasePU in projectileDistanceIncreasePUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, projectileDistanceIncreasePU.boundingBox)) {
            [self projectileDistanceIncrease];
            [projectileDistancePowerUpToRemove addObject:projectileDistanceIncreasePU];
        }
    }
    for (CCSprite *projectileDistanceIncreasePU in projectileDistancePowerUpToRemove) {
        [playScene removeChild:projectileDistanceIncreasePU cleanup:YES];
        [projectileDistanceIncreasePUArray removeObject:projectileDistanceIncreasePU];
    }
    
    for (CCSprite *projectileSpeedIncreasePU in projectileSpeedIncreasePUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, projectileSpeedIncreasePU.boundingBox)) {
            [self projectileSpeedIncrease];
            [projectileSpeedPowerUpToRemove addObject:projectileSpeedIncreasePU];
        }
    }
    for (CCSprite *projectileSpeedIncreasePU in projectileSpeedPowerUpToRemove) {
        [playScene removeChild:projectileSpeedIncreasePU cleanup:YES];
        [projectileSpeedIncreasePUArray removeObject:projectileSpeedIncreasePU];
    }
}

-(void)selectPowerUp:(int)PU {
    switch (PU) {
        case 1:
            [self healthPowerUp];
            break;
        case 2:
            [self manaPowerUp];
            break;
        case 3:
            [self healthRegenerationPowerUpTemp];
            break;
        case 4:
            [self manaGenerationPowerUpTemp];
            break;
        case 5:
            [self projectileDamageIncreasePowerUpTemp];
            break;
        case 6:
            [self projectileDistanceIncreasePowerUpTemp];
            break;
        case 7:
            [self projectileSpeedIncreasePowerUpTemp];
            break;
        case 8:
            [self speedIncreasePowerUpTemp];
            break;
            
        default:
            break;
    }
}

-(void)selPowerUp {
    int randomSelection = (arc4random() % 8)+1;
    [self performSelector:@selector(selectPowerUp:) withObject:randomSelection];
}

-(void)activateScheduler {
    [self schedule:@selector(update)];
    [self schedule:@selector(selPowerUp) interval:5];
}

-(void)deactivateScheduler {
    [self unschedule:@selector(update)];
    [self unschedule:@selector(selPowerUp)];
}

-(void)initWithPowerUps:(UserShip *)userShip withHUD:(GameHUD *)HUD withScene:(Play *)scene {
    playScene = scene;
    ship = userShip;
    hud = HUD;
    
    _resizeSprite = [[ResizeSprite alloc] init];
    
    healthPUArray = [[NSMutableArray alloc] init];
    manaPUArray = [[NSMutableArray alloc] init];
    healthRegenerationPUArray = [[NSMutableArray alloc] init];
    manaGenerationPUArray = [[NSMutableArray alloc] init];
    speedIncreasePUArray = [[NSMutableArray alloc] init];
    projectileDamageIncreasePUArray = [[NSMutableArray alloc] init];
    projectileDistanceIncreasePUArray = [[NSMutableArray alloc] init];
    projectileSpeedIncreasePUArray = [[NSMutableArray alloc] init];
    incHealth = 5.0;
    incMana = 5.0;
    regenHealth = 2.0;
    genMana = 5.0;
    incSpeed = 55.0;
    incProjDam = 50.0;
    incProjDis = 1000.0;
    incProjSpeed = -0.3;
    isRunning_ = YES;
    
    [self activateScheduler];
}


@end
