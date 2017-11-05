//
//  SpaceShip.m
//  Space Commander
//
//  Created by Adam Mellan on 11/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpaceShip.h"
#import "GameHUD.h"
#import "Play.h"
#import "SimpleAudioEngine.h"


@implementation SpaceShip
@synthesize projectiles;
@synthesize delegate;
@synthesize target;
@synthesize hitTarget;
@synthesize maxMana;
@synthesize maxHealth;
@synthesize health;
@synthesize mana;
@synthesize manaInc;
@synthesize healthInc;
@synthesize speed;
@synthesize healthRegen;
@synthesize manaGen;
@synthesize projectileDamage;
@synthesize projectileDistance;
@synthesize projectileSpeed;
@synthesize projectileDamageInc;
@synthesize projectileDistanceInc;
@synthesize projectileSpeedInc;

GameHUD *_hud;
//Play *_play;


- (void)deleteLaser:(CCSprite *)proj {
    // could have been removed in collision detection
    [self.parent removeChild:proj cleanup:YES];
    [self.projectiles removeObject:proj];
}
/*
- (void)shoot {
    CCSprite *projectile = [CCSprite spriteWithFile:@"Green_Laser.png"];
    projectile.position = self.position;
    projectile.rotation = self.rotation;
    projectile.scale = 0.3;
    [self.parent addChild:projectile];
    [self.projectiles addObject:projectile];

    // distance and theta of shot
    float shotDistance = 500;
    float theta = degToRad(-self.rotation);
    
    // calculate x and y coordinates
    CGPoint realPos;
    
    // a = h * cos(0)
    realPos.x = projectile.position.x + shotDistance * cosf(theta);
    // o = h * sin(0)
    realPos.y = projectile.position.y + shotDistance * sinf(theta);
    
    SimpleAudioEngine *hi = [[SimpleAudioEngine sharedEngine] playEffect:@"Laser Blast.mp3"];
    hi.effectsVolume = 0.5;
    
    [projectile runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:realPos], [CCCallFuncN actionWithTarget:self selector:@selector(deleteLaser:)], nil]];
}*/

- (void)collisionDetection {
    NSMutableArray *lasersToRemove = [[NSMutableArray alloc] init];
    for (CCSprite *laser in self.projectiles) {
        if (CGRectIntersectsRect(laser.boundingBox, self.target.boundingBox)) {
            [lasersToRemove addObject:laser];
            hitTarget = YES;
            NSLog(@"\n\nI hit him = %c\n\n",hitTarget);
        }
    }
    
    for (CCSprite *laser in lasersToRemove) {
        [self deleteLaser:laser];
    }
    
    [lasersToRemove release];
}

-(void)damage:(id)playy {
    if (self.health >= 0) {
        self.health -= 2;
    }
        m++;
    
    if (m > 1) {
        NSLog(@"\n\nThe Melonator has been hit %d times!\n\nDamage Taken!!!\nHealth is now %2.f\n\n", m, health);
    } else {
        NSLog(@"\n\nThe Melonator has been hit %d time!\n\nDamage Taken!!!\nHealth is now %2.f\n\n", m, health);
    }

_hud.healthBar.percentage = (self.health/self.maxHealth) *100;
    
    if (self.health <= 0) {
        NSLog(@"\n\nHealth is ZERO\n\n");
        [playy unschedule:@selector(addEnemy)];
        [playy gameOver];
    }
}


-(void)update:(ccTime *)delta {
    [self collisionDetection];
}

- (void)shoot {
    CCSprite *projectile = [CCSprite spriteWithFile:@"Green_Laser.png"];
    projectile.position = self.position;
    projectile.rotation = self.rotation;
    projectile.scale = 0.3;
    [self.parent addChild:projectile];
    [self.projectiles addObject:projectile];
    
    // distance and theta of shot
    float shotDistance = 500;
    float theta = degToRad(-self.rotation);
    
    // calculate x and y coordinates
    CGPoint realPos;
    
    // a = h * cos(0)
    realPos.x = projectile.position.x + shotDistance * cosf(theta);
    // o = h * sin(0)
    realPos.y = projectile.position.y + shotDistance * sinf(theta);
    
    SimpleAudioEngine *hi = [[SimpleAudioEngine sharedEngine] playEffect:@"Laser Blast.mp3"];
    hi.effectsVolume = 0.5;
    
    [projectile runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:realPos], [CCCallFuncN actionWithTarget:self selector:@selector(deleteLaser:)], nil]];
}

-(id)initWithScene:(Play *)scene {
    if (self = [super init]) {
        
    }
    return self;
}

/*
-(id)init {
    if (self = [super init]) {
        _play = [[Play alloc] init];
        projectiles = [[NSMutableArray alloc] init];
        [self scheduleUpdate];
    }
    return self;
}*/

@end
