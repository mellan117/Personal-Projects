//
//  PowerUps.m
//  Space-Commander
//
//  Created by Adam Mellan on 2/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PowerUps.h"
#import "SpaceShip.h"
#import "UserShip.h"
#import "GameHUD.h"
#import "Enemy.h"
#import "Play.h"
#import "UpThePower.h"


#define bgWidth 1919
#define bgHeight 1224

@implementation PowerUps
@synthesize healthPUArray;
@synthesize manaPUArray;
@synthesize totalDestructionPUArray;
@synthesize totalPowerUpsArray;
@synthesize speedIncreasePUArray;
@synthesize enemyProjectileSpeedDecreasePUArray;
@synthesize enemyProjectileDistancePUArray;
@synthesize enemyProjectileDamageDecreasePUArray;
@synthesize enemySpeedDecreasePUArray;
@synthesize projectileDamageIncreasePUArray;
@synthesize projectileDistanceIncreasePUArray;
@synthesize projectileSpeedIncreasePUArray;
@synthesize healthRegenerationPUArray;
@synthesize manaIncreasePUArray;
@synthesize manaGenerationPUArray;
@synthesize delegate;

GameHUD *_hud;
Play *_play;

-(void)increaseHealth {
    [ship healthIncrease:ship.healthInc];
}

-(void)increaseMana:(UserShip *)shipy {
    [shipy manaIncrease:shipy.manaInc];
}

-(NSMutableArray *)destroyArray:(NSMutableArray *)enemies {
    enmies = enemies;
    return enmies;
}

-(void)totalDestruction:(NSMutableArray *)enemiesArray {
    
    /*for (Enemy *emy in enemiesArray) {
        //[emy destroyAll:enemiesArray];
        [emy destroy:enemiesArray withEnmy:emy];
    }*/
    
    /*NSMutableArray *enemiesToRemove = [[NSMutableArray alloc] init];
    
    for (Enemy *enemy in enemiesArray) {
        CCParticleSystem *system = [CCParticleFire node];
        system.position = enemy.position;
        system.scale = 0.3;
        system.life = 0.3;
        system.duration = 0.3;
        system.autoRemoveOnFinish = YES;
        [self.delegate addChild:system z:999];
        [self.delegate removeChild:enemy cleanup:YES];
        [self.delegate removeChild:enemy.projectile cleanup:YES];
        [enemiesToRemove addObject:enemy];
        [ship goldIncrease];
    }
    for (Enemy *enmy in enemiesToRemove) {
        [enemiesArray removeObject:enmy];
    }
    [enemiesToRemove release];*/
}

-(void)healthRegeneration {
    [ship healthIncrease:ship.healthRegen];
}

-(void)speedIncrease:(SpaceShip *)aShip {
    aShip.speed *= 2;
    _hud.joystick.speedRatio = aShip.speed;
    [self performSelector:@selector(returnSpeed) withObject:aShip afterDelay:10];
}

-(void)returnSpeed:(SpaceShip *)aShip {
    aShip.speed /= 2;
    _hud.joystick.speedRatio = aShip.speed;
}

-(SpaceShip *)increaseHealthRegeneration {
    ship.healthRegen *= 2;
    [self performSelector:@selector(returnHealthRegeneration) withObject:nil afterDelay:10];
    
    return ship;
}

-(SpaceShip *)returnHealthRegeneration {
    ship.healthRegen /= 2;
    
    return ship;
}

-(SpaceShip *)increaseMana {
    ship.manaInc *= 2;
    [self performSelector:@selector(returnManaInc) withObject:nil afterDelay:10];
    
    return ship;
}

-(SpaceShip *)returnManaInc {
    ship.manaInc /= 2;
    
    return ship;
}

-(SpaceShip *)increaseManaGeneration {
    ship.manaGen *= 2;
    [self performSelector:@selector(returnManaGeneration) withObject:nil afterDelay:10];
    
    return ship;
}

-(SpaceShip *)returnManaGeneration {
    ship.manaGen /= 2;
    
    return ship;
}

-(void)manaGeneration {
    [ship manaIncrease:ship.manaGen];
}

-(void)increaseProjectileDamage:(int)spaceShip {
    if (spaceShip == 1) {
        ship.projectileDamage *= 2;
    }else if (spaceShip == 2) {
        for (Enemy *enmy in enmies) {
            enmy.projectileDamage /= 2;
        }
    }
}
/*
-(SpaceShip *)returnProjectileDamage {
    
}

-(SpaceShip *)increaseProjectileDistance {
    
    return ship;
}

-(SpaceShip *)increaseProjectileSpeed {
    
    return ship;
}

-(SpaceShip *)decreaseEnemyProjectileDamage {
    
}

-(SpaceShip *)decreaseEnemyProjectileDistance {
    
}

-(SpaceShip *)decreaseEnemyProjectileSpeed {
    
}

-(SpaceShip *)decreaseEnemySpeed {
    
}
*/
-(void)removePowerUps:(CCSprite *)powerUp pUArray:(int)powerUpArray andArray:(NSMutableArray *)pu {
    [self.delegate removeChild:powerUp cleanup:YES];
    //NSMutableArray *thing = [[NSMutableArray alloc] init];
    //[powerUpArray removeObject:powerUp];
    //NSLog(@"\n\nArray is %@\n\n",powerUpArray);
    switch (powerUpArray) {
        case 1:
            for (CCSprite *sp in pu) {
                [healthPUArray removeObject:sp];
            }
            [pu release];
            //[self healthPowerUp];
            //[healthPUArray removeObject:powerUp];
            break;
        case 2:
            //[self manaPowerUp];
            break;
        case 3:
            //[self totalDestructionPowerUp];
            break;
        case 4:
            //[self speedIncreasePowerUp];
            break;
        case 5:
            //[self healthRegenerationPowerUpTemp];
            break;
        case 6:
            //[self manaIncreasePowerUpTemp];
            break;
        case 7:
            //[self projectileDamageIncreasePowerUpTemp];
            break;
        case 8:
            //[self projectileDistanceIncreasePowerUpTemp];
            break;
        case 9:
            //[self projectileSpeedIncreasePowerUpTemp];
            break;
        case 10:
            //[self  enemyProjectileDamageDecreasePowerUpTemp];
            break;
        case 11:
            //[self enemyProjectileDistanceDecreasePowerUpTemp];
            break;
        case 12:
            //[self enemyProjectileSpeedDecreasePowerUpTemp];
            break;
        case 13:
            //[self enemySpeedDecreasePowerUpTemp];
            break;
            
        default:
            break;
    }
}

-(void)removePower:(CCSprite *)powerUp withArray:(NSMutableArray *)array {
    [self.delegate removeChild:powerUp cleanup:YES];
    [array removeObject:powerUp];
    healthPUArray = array;
    [array release];
}

//-(void)removePU:(CCSprite *)sprite

-(void)usePowerUp:(UpThePower *)powerUp {
    PowerUpType type = powerUp.powerUp;
    switch (type) {
        case health:
            [self increaseHealth];
            break;
        case mana:
            [self increaseMana:ship];
            break;
        default:
            break;
    }
}

-(void)collisionDetectionPowerUps {
    NSMutableArray *powerUpsToRemove = [[NSMutableArray alloc] init];
    
    for (UpThePower *powerUp in totalPowerUpsArray) {
        if (CGRectIntersectsRect(ship.boundingBox, powerUp.boundingBox)) {
            [powerUpsToRemove addObject:powerUp];
            [self usePowerUp:powerUp];
        }
    }
    
    for (UpThePower *powerUp in powerUpsToRemove) {
        [self.delegate removeChild:powerUp cleanup:YES];
        [totalPowerUpsArray removeObject:powerUp];
    }
    
    [powerUpsToRemove release];
    
    /*for (CCSprite *healthPU in healthPUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, healthPU.boundingBox)) {
            //[self removePowerUps:healthPU pUArray:healthPUArray];
            [self increaseHealth];
            //[self removePowerUps:healthPU pUArray:1];
            NSMutableArray *hu = [[NSMutableArray alloc] init];
            hu = healthPUArray;
            [self removePower:healthPU withArray:hu];
            //[hu addObject:healthPU];
            //[self removePowerUps:healthPU pUArray:1 andArray:hu];
        }
    }
    
    for (CCSprite *sp in tooth) {
        
    }
    
    for (CCSprite *manaPU in manaPUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, manaPU.boundingBox)) {
            [self removePower:manaPU withArray:manaPUArray];
            [self increaseMana:ship];
            [tooth addObject:manaPU];
        }
    }
    
    for (CCSprite *totalDestru in totalDestructionPUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, totalDestru.boundingBox)) {
            //[self removePowerUps:totalDestru pUArray:totalDestructionPUArray];
            //[self totalDestructionPowerUp];
            //[self totalDestruction:enmies];
            [_play shouldDestroyEnemies:YES];
            [_play destroyAllEnemies];
        }
    }
    
    for (CCSprite *powerUp in totalPowerUpsArray) {
        
    }
    
    for (CCSprite *speedInc in speedIncreasePUArray) {
        if (CGRectIntersectsRect(ship.boundingBox, speedInc.boundingBox)) {
            //[self removePowerUps:speedInc pUArray:speedIncreasePUArray];
            //[self speedIncrease];
            [self speedIncrease:ship];
        }
    }
    
    for (CCSprite *healthRegenPU in healthRegenerationPUArray) {
        if (CGRectIntersectsRect(healthRegenPU.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:healthRegenPU pUArray:healthRegenerationPUArray];
            [self increaseHealthRegeneration];
        }
    }
    
    for (CCSprite *manaIncre in manaIncreasePUArray) {
        if (CGRectIntersectsRect(manaIncre.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:manaIncre pUArray:manaIncreasePUArray];
            [self increaseMana:ship];
        }
    }
    
    for (CCSprite *manaGener in manaGenerationPUArray) {
        if (CGRectIntersectsRect(manaGener.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:manaGener pUArray:manaGenerationPUArray];
            [self increaseManaGeneration];
        }
    }
    
    for (CCSprite *projDam in projectileDamageIncreasePUArray) {
        if (CGRectIntersectsRect(projDam.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:projDam pUArray:projectileDamageIncreasePUArray];
            int spaceShip = 1;
            [self increaseProjectileDamage:spaceShip];
        }
    }
    
    for (CCSprite *projDis in projectileDistanceIncreasePUArray) {
        if (CGRectIntersectsRect(projDis.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:projDis pUArray:projectileDistanceIncreasePUArray];
            [self increaseProjectileDistance];
        }
    }
    
    for (CCSprite *projSpd in projectileSpeedIncreasePUArray) {
        if (CGRectIntersectsRect(projSpd.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:projSpd pUArray:projectileSpeedIncreasePUArray];
            [self increaseProjectileSpeed];
        }
    }
    
    for (CCSprite *enmyProjDam in enemyProjectileDamageDecreasePUArray) {
        if (CGRectIntersectsRect(enmyProjDam.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:enmyProjDam pUArray:enemyProjectileDamageDecreasePUArray];
            int spaceShip = 2;
            [self increaseProjectileDamage:spaceShip];
            //[self decreaseEnemyProjectileDamage];
        }
    }
    
    for (CCSprite *enmyProjDis in enemyProjectileDamageDecreasePUArray) {
        if (CGRectIntersectsRect(enmyProjDis.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:enmyProjDis pUArray:enemyProjectileDistancePUArray];
            [self decreaseEnemyProjectileDistance];
        }
    }
    
    for (CCSprite *enmyProjSpeed in enemyProjectileDamageDecreasePUArray) {
        if (CGRectIntersectsRect(enmyProjSpeed.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:enmyProjSpeed pUArray:enemyProjectileSpeedDecreasePUArray];
            [self decreaseEnemyProjectileSpeed];
        }
    }
    
    for (CCSprite *enmySpeed in enemyProjectileDamageDecreasePUArray) {
        if (CGRectIntersectsRect(enmySpeed.boundingBox, ship.boundingBox)) {
            //[self removePowerUps:enmySpeed pUArray:enemySpeedDecreasePUArray];
            [self decreaseEnemySpeed];
        }
    }*/
    
    /*for (CCSprite *healthPUS in powerUpsToRemove) {
        NSLog(@"\nADAMADAMADAMADAMADAMADAMADAMADAMADAMADAMADAM\n");
        [self.delegate removeChild:healthPUS cleanup:YES];
        [healthPUArray removeObject:healthPUS];
    }
    [powerUpsToRemove release];*/
    
}

// Corresponding Sprite "+H"
-(void)healthPowerUp {
    CGPoint range;
    CGPoint position;
    UpThePower *healthPowerUp = [CCSprite spriteWithFile:@"+H.png"];
    healthPowerUp.powerUp = health;
    range.x = (bgWidth - healthPowerUp.contentSize.width) - healthPowerUp.contentSize.width;
    range.y = (bgHeight - healthPowerUp.contentSize.height) - healthPowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + healthPowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + healthPowerUp.contentSize.height;
    healthPowerUp.position = position;
    //healthPowerUp.position = ccp(350, 350);
    [self.delegate addChild:healthPowerUp z:999];
    [totalPowerUpsArray addObject:healthPowerUp];
    [healthPUArray addObject:healthPowerUp];
}

// Corresponding Sprite "+M"
-(void)manaPowerUp {
    CGPoint range;
    CGPoint position;
    UpThePower *manaPowerUp = [CCSprite spriteWithFile:@"+M.png"];
    manaPowerUp.powerUp = mana;
    range.x = (bgWidth - manaPowerUp.contentSize.width) - manaPowerUp.contentSize.width;
    range.y = (bgHeight - manaPowerUp.contentSize.height) - manaPowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + manaPowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + manaPowerUp.contentSize.height;
    manaPowerUp.position = position;
    [self.delegate addChild:manaPowerUp z:999];
    [totalPowerUpsArray addObject:manaPowerUp];
    [manaPUArray addObject:manaPowerUp];
}

// Corresponding Sprite "BOOM"
-(void)totalDestructionPowerUp {
    CGPoint range;
    CGPoint position;
    CCSprite *totalDestructionPowerUp = [CCSprite spriteWithFile:@"BOOM.png"];
    range.x = (bgWidth - totalDestructionPowerUp.contentSize.width) - totalDestructionPowerUp.contentSize.width;
    range.y = (bgHeight - totalDestructionPowerUp.contentSize.height) - totalDestructionPowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + totalDestructionPowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + totalDestructionPowerUp.contentSize.height;
    totalDestructionPowerUp.position = position;
    [self.delegate addChild:totalDestructionPowerUp z:999];
    [totalPowerUpsArray addObject:totalDestructionPowerUp];
    [totalDestructionPUArray addObject:totalDestructionPowerUp];
}

// Corresponding Sprite "+S"
-(void)speedIncreasePowerUp {
    CGPoint range;
    CGPoint position;
    CCSprite *speedIncreasePowerUp = [CCSprite spriteWithFile:@"+S.png"];
    range.x = (bgWidth - speedIncreasePowerUp.contentSize.width) - speedIncreasePowerUp.contentSize.width;
    range.y = (bgHeight - speedIncreasePowerUp.contentSize.height) - speedIncreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + speedIncreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + speedIncreasePowerUp.contentSize.height;
    speedIncreasePowerUp.position = position;
    [self.delegate addChild:speedIncreasePowerUp z:999];
    [totalPowerUpsArray addObject:speedIncreasePowerUp];
    [speedIncreasePUArray addObject:speedIncreasePowerUp];
}

// Corresponding Sprite "-ES"
-(void)enemySpeedDecreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *enemySpeedDecreasePowerUp = [CCSprite spriteWithFile:@"-ES.png"];
    range.x = (bgWidth - enemySpeedDecreasePowerUp.contentSize.width) - enemySpeedDecreasePowerUp.contentSize.width;
    range.y = (bgHeight - enemySpeedDecreasePowerUp.contentSize.height) - enemySpeedDecreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + enemySpeedDecreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + enemySpeedDecreasePowerUp.contentSize.height;
    enemySpeedDecreasePowerUp.position = position;
    [self.delegate addChild:enemySpeedDecreasePowerUp z:999];
    [totalPowerUpsArray addObject:enemySpeedDecreasePowerUp];
    [enemySpeedDecreasePUArray addObject:enemySpeedDecreasePowerUp];
}

// Corresponding Sprite "+HR"
-(void)healthRegenerationPowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *healthRegenerationPowerUp = [CCSprite spriteWithFile:@"+HR.png"];
    range.x = (bgWidth - healthRegenerationPowerUp.contentSize.width) - healthRegenerationPowerUp.contentSize.width;
    range.y = (bgHeight - healthRegenerationPowerUp.contentSize.height) - healthRegenerationPowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + healthRegenerationPowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + healthRegenerationPowerUp.contentSize.height;
    healthRegenerationPowerUp.position = position;
    [self.delegate addChild:healthRegenerationPowerUp z:999];
    [totalPowerUpsArray addObject:healthRegenerationPowerUp];
    [healthRegenerationPUArray addObject:healthRegenerationPowerUp];
}

// Corresponding Sprite "++M"
-(void)manaIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *manaIncreasePowerUp = [CCSprite spriteWithFile:@"++M.png"];
    range.x = (bgWidth - manaIncreasePowerUp.contentSize.width) - manaIncreasePowerUp.contentSize.width;
    range.y = (bgHeight - manaIncreasePowerUp.contentSize.height) - manaIncreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + manaIncreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + manaIncreasePowerUp.contentSize.height;
    manaIncreasePowerUp.position = position;
    [self.delegate addChild:manaIncreasePowerUp z:999];
    [totalPowerUpsArray addObject:manaIncreasePowerUp];
    [manaIncreasePUArray addObject:manaIncreasePowerUp];
}

// Corresponding Sprite "+PDam"
-(void)projectileDamageIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *projectileDamageIncreasePowerUp = [CCSprite spriteWithFile:@"+PDam.png"];
    range.x = (bgWidth - projectileDamageIncreasePowerUp.contentSize.width) - projectileDamageIncreasePowerUp.contentSize.width;
    range.y = (bgHeight - projectileDamageIncreasePowerUp.contentSize.height) - projectileDamageIncreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + projectileDamageIncreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + projectileDamageIncreasePowerUp.contentSize.height;
    projectileDamageIncreasePowerUp.position = position;
    [self.delegate addChild:projectileDamageIncreasePowerUp z:999];
    [totalPowerUpsArray addObject:projectileDamageIncreasePowerUp];
    [projectileDamageIncreasePUArray addObject:projectileDamageIncreasePowerUp];
}

// Corresponding Sprite "+PDis"
-(void)projectileDistanceIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *projectileDistanceIncreasePowerUp = [CCSprite spriteWithFile:@"+PDis.png"];
    range.x = (bgWidth - projectileDistanceIncreasePowerUp.contentSize.width) - projectileDistanceIncreasePowerUp.contentSize.width;
    range.y = (bgHeight - projectileDistanceIncreasePowerUp.contentSize.height) - projectileDistanceIncreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + projectileDistanceIncreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + projectileDistanceIncreasePowerUp.contentSize.height;
    projectileDistanceIncreasePowerUp.position = position;
    [self.delegate addChild:projectileDistanceIncreasePowerUp z:999];
    [totalPowerUpsArray addObject:projectileDistanceIncreasePowerUp];
    [projectileDistanceIncreasePUArray addObject:projectileDistanceIncreasePowerUp];
}

// Corresponding Sprite "+PS"
-(void)projectileSpeedIncreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *projectileSpeedIncreasePowerUp = [CCSprite spriteWithFile:@"+PS.png"];
    range.x = (bgWidth - projectileSpeedIncreasePowerUp.contentSize.width) - projectileSpeedIncreasePowerUp.contentSize.width;
    range.y = (bgHeight - projectileSpeedIncreasePowerUp.contentSize.height) - projectileSpeedIncreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + projectileSpeedIncreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + projectileSpeedIncreasePowerUp.contentSize.height;
    projectileSpeedIncreasePowerUp.position = position;
    [self.delegate addChild:projectileSpeedIncreasePowerUp z:999];
    [totalPowerUpsArray addObject:projectileSpeedIncreasePowerUp];
    [projectileSpeedIncreasePUArray addObject:projectileSpeedIncreasePowerUp];
}

// Corresponding Sprite "-EPDam"
-(void)enemyProjectileDamageDecreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *enemyProjectileDamageDecreasePowerUp = [CCSprite spriteWithFile:@"-EPDam.png"];
    range.x = (bgWidth - enemyProjectileDamageDecreasePowerUp.contentSize.width) - enemyProjectileDamageDecreasePowerUp.contentSize.width;
    range.y = (bgHeight - enemyProjectileDamageDecreasePowerUp.contentSize.height) - enemyProjectileDamageDecreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + enemyProjectileDamageDecreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + enemyProjectileDamageDecreasePowerUp.contentSize.height;
    enemyProjectileDamageDecreasePowerUp.position = position;
    [self.delegate addChild:enemyProjectileDamageDecreasePowerUp z:999];
    [totalPowerUpsArray addObject:enemyProjectileDamageDecreasePowerUp];
    [enemyProjectileDamageDecreasePUArray addObject:enemyProjectileDamageDecreasePowerUp];
}

// Corresponding Sprite "-EPDis"
-(void)enemyProjectileDistanceDecreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *enemyProjectileDistancePowerUp = [CCSprite spriteWithFile:@"-EPDis.png"];
    range.x = (bgWidth - enemyProjectileDistancePowerUp.contentSize.width) - enemyProjectileDistancePowerUp.contentSize.width;
    range.y = (bgHeight - enemyProjectileDistancePowerUp.contentSize.height) - enemyProjectileDistancePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + enemyProjectileDistancePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + enemyProjectileDistancePowerUp.contentSize.height;
    enemyProjectileDistancePowerUp.position = position;
    [self.delegate addChild:enemyProjectileDistancePowerUp z:999];
    [totalPowerUpsArray addObject:enemyProjectileDistancePowerUp];
    [enemyProjectileDistancePUArray addObject:enemyProjectileDistancePowerUp];
}

// Corresponding Sprite "-EPS"
-(void)enemyProjectileSpeedDecreasePowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *enemyProjectileSpeedDecreasePowerUp = [CCSprite spriteWithFile:@"-EPS.png"];
    range.x = (bgWidth - enemyProjectileSpeedDecreasePowerUp.contentSize.width) - enemyProjectileSpeedDecreasePowerUp.contentSize.width;
    range.y = (bgHeight - enemyProjectileSpeedDecreasePowerUp.contentSize.height) - enemyProjectileSpeedDecreasePowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + enemyProjectileSpeedDecreasePowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + enemyProjectileSpeedDecreasePowerUp.contentSize.height;
    enemyProjectileSpeedDecreasePowerUp.position = position;
    [self.delegate addChild:enemyProjectileSpeedDecreasePowerUp z:999];
    [totalPowerUpsArray addObject:enemyProjectileSpeedDecreasePowerUp];
    [enemyProjectileSpeedDecreasePUArray addObject:enemyProjectileSpeedDecreasePowerUp];
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
            [self totalDestructionPowerUp];
            break;
        case 4:
            [self speedIncreasePowerUp];
            break;
        case 5:
            [self healthRegenerationPowerUpTemp];
            break;
        case 6:
            [self manaIncreasePowerUpTemp];
            break;
        case 7:
            [self projectileDamageIncreasePowerUpTemp];
            break;
        case 8:
            [self projectileDistanceIncreasePowerUpTemp];
            break;
        case 9:
            [self projectileSpeedIncreasePowerUpTemp];
            break;
        case 10:
            [self  enemyProjectileDamageDecreasePowerUpTemp];
            break;
        case 11:
            [self enemyProjectileDistanceDecreasePowerUpTemp];
            break;
        case 12:
            [self enemyProjectileSpeedDecreasePowerUpTemp];
            break;
        case 13:
            [self enemySpeedDecreasePowerUpTemp];
            break;
            
        default:
            break;
    }
}

-(void)selPowerUp {
    int randomSelection = (arc4random() % 2)+1;
    [self performSelector:@selector(selectPowerUp:) withObject:randomSelection];
}

-(void)deactivateSelector {
    [self unschedule:@selector(updatey)];
    [self unschedule:@selector(selPowerUp)];
    [self unschedule:@selector(healthRegeneration)];
    [self unschedule:@selector(manaGeneration)];
}

-(void)updatey {
    [self collisionDetectionPowerUps];
}

-(id)powerUps:(UserShip *)shipy withHud:(GameHUD *)hud withPlayScene:(Play *)playScene {
    ship = shipy;
    _hud = hud;
    _play = playScene;
    NSLog(@"\n\nThe power up method was called\n\n");
    
    isRunning_ = YES;
    [self schedule:@selector(updatey) interval:0.1];
    //[self schedule:@selector(selPowerUp) interval:(arc4random() % 4)+1];
    [self schedule:@selector(selPowerUp) interval:1];
    [self schedule:@selector(healthRegeneration) interval:3];
    [self schedule:@selector(manaGeneration) interval:5];
    
    hy = [[NSMutableArray alloc] init];
    
    healthPUArray = [[NSMutableArray alloc] init];
    manaPUArray = [[NSMutableArray alloc] init];
    totalDestructionPUArray = [[NSMutableArray alloc] init];
    speedIncreasePUArray = [[NSMutableArray alloc] init];
    totalPowerUpsArray = [[NSMutableArray alloc] init];
    projectileDamageIncreasePUArray = [[NSMutableArray alloc] init];
    projectileDistanceIncreasePUArray = [[NSMutableArray alloc] init];
    projectileSpeedIncreasePUArray = [[NSMutableArray alloc] init];
    healthRegenerationPUArray = [[NSMutableArray alloc] init];
    manaIncreasePUArray = [[NSMutableArray alloc] init];
    manaGenerationPUArray = [[NSMutableArray alloc] init];
    enemyProjectileDamageDecreasePUArray = [[NSMutableArray alloc] init];
    enemyProjectileDistancePUArray = [[NSMutableArray alloc] init];
    enemyProjectileSpeedDecreasePUArray = [[NSMutableArray alloc] init];
    enemySpeedDecreasePUArray = [[NSMutableArray alloc] init];
    
    return self;
}

// NEW METHOD NEEDS A SPRITE MADE AND PROPER PLACEMENT IN THIS CLASS
-(void)manaGenerationPowerUpTemp {
    CGPoint range;
    CGPoint position;
    CCSprite *manaGenerationPowerUp = [CCSprite spriteWithFile:@"++M.png"];
    range.x = (bgWidth - manaGenerationPowerUp.contentSize.width) - manaGenerationPowerUp.contentSize.width;
    range.y = (bgHeight - manaGenerationPowerUp.contentSize.height) - manaGenerationPowerUp.contentSize.height;
    position.x = arc4random() % (int)range.x + manaGenerationPowerUp.contentSize.width;
    position.y = arc4random() % (int)range.y + manaGenerationPowerUp.contentSize.height;
    manaGenerationPowerUp.position = position;
    [self.delegate addChild:manaGenerationPowerUp z:999];
    [totalPowerUpsArray addObject:manaGenerationPowerUp];
    [manaGenerationPUArray addObject:manaGenerationPowerUp];
}

- (id)init
{
    self = [super init];
    if (self) {
        /*healthPUArray = [[NSMutableArray alloc] init];
        manaPUArray = [[NSMutableArray alloc] init];
        totalDestructionPUArray = [[NSMutableArray alloc] init];
        speedIncreasePUArray = [[NSMutableArray alloc] init];
        totalPowerUpsArray = [[NSMutableArray alloc] init];
        projectileDamageIncreasePUArray = [[NSMutableArray alloc] init];
        projectileDistanceIncreasePUArray = [[NSMutableArray alloc] init];
        projectileSpeedIncreasePUArray = [[NSMutableArray alloc] init];
        healthRegenerationPUArray = [[NSMutableArray alloc] init];
        manaIncreasePUArray = [[NSMutableArray alloc] init];
        manaGenerationPUArray = [[NSMutableArray alloc] init];
        enemyProjectileDamageDecreasePUArray = [[NSMutableArray alloc] init];
        enemyProjectileDistancePUArray = [[NSMutableArray alloc] init];
        enemyProjectileSpeedDecreasePUArray = [[NSMutableArray alloc] init];
        enemySpeedDecreasePUArray = [[NSMutableArray alloc] init];*/
        //_hud = [[GameHUD alloc] init];
    }
    return self;
}

@end
