//
//  EnemyTank.m
//  Tank Attack
//
//  Created by Adam Mellan on 10/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyTank.h"
#import "Tank.h"
#import "UserTank.h"
#import "Play.h"

@implementation EnemyTank
@synthesize target;
@synthesize rate;
@synthesize hitMe;
@synthesize projectile;


-(void)moveEnemyTowardsUser {
    CGPoint offset = ccpSub(self.target.position, self.position);
    self.rotation = -radToDeg(ccpToAngle(offset));
    
    float distance = ccpLength(ccpSub(self.target.position, self.position));
    float time = distance / 70;
    [self runAction:[CCMoveTo actionWithDuration:time position:self.target.position]];
}

-(void)rotateEnemyBarrel {
    CGPoint offset = ccpSub(self.target.position, self.position);
    float theta = -radToDeg(ccpToAngle(offset));
    [self.barrel runAction:[CCRotateTo actionWithDuration:0.5 angle:theta]];
}

+(EnemyTank *)createTank:(NSString *)tankBodyFile withTankBarrelFile:(NSString*)tankBarrelFile withTarget:(UserTank *)targ withSize:(CGSize)screenSize {
    EnemyTank *enemyTank = [EnemyTank spriteWithFile:tankBodyFile];
    enemyTank.position = ccp(0, 0);
    enemyTank.scale = 0.7;
    
    enemyTank.barrel = [CCSprite spriteWithFile:tankBarrelFile];
    enemyTank.barrel.position = ccp(enemyTank.contentSize.width/2, enemyTank.contentSize.height/2);
    enemyTank.barrel.anchorPoint = ccp(0.2, 0.5);
    
    CGPoint range;
    range.x = (screenSize.width - enemyTank.contentSize.width) - enemyTank.contentSize.width;
    range.y = (screenSize.height - enemyTank.contentSize.height) - enemyTank.contentSize.height;
    
    CGPoint position;
    position.x = arc4random() %(int)range.x + enemyTank.contentSize.width;
    position.y = arc4random() %(int)range.y + enemyTank.contentSize.height;
    enemyTank.position = position;
    
    enemyTank.target = targ;
    [enemyTank activateScheduler];
    
    return enemyTank;
}

-(void)setEnemyTanksPosition:(CGSize)screenSize target:(UserTank *)targ {
    CGPoint range;
    range.x = (screenSize.width - self.contentSize.width) - self.contentSize.width;
    range.y = (screenSize.height - self.contentSize.height) - self.contentSize.height;
    
    CGPoint position;
    position.x = arc4random() %(int)range.x + self.contentSize.width;
    position.y = arc4random() %(int)range.y + self.contentSize.height;
    self.position = position;
    
    self.target = targ;
    [self activateScheduler];
}

-(void)takenDamage {
    NSLog(@"\n\nEnemy health: %f\takenDamage method & before the if statement\n\n",self.health);
    if (self.health > 0) {
        NSLog(@"\n\nEnemy health: %f\takenDamage method & in the if statement\n\n",self.health);
        self.health -= 25;
    } else if (self.health <= 0) {
        NSLog(@"\n\nEnemy health: %f\ntakenDamage method & in the if statement 2\n\n",self.health);
        [self.delegate removeChild:self cleanup:YES];
    }
}

- (void)enemyCollisionDetection {
    NSMutableArray *lasersToRemove = [[NSMutableArray alloc] init];
    for (CCSprite *laser in self.projectiles) {
        if (CGRectIntersectsRect(laser.boundingBox, self.target.boundingBox)) {
            [lasersToRemove addObject:laser];
            if ([self.delegate conformsToProtocol:@protocol(EnemyDelegate)]) {
                [self.delegate enemyHitTarget];
            }
        }
    }
    
    for (CCSprite *laser in lasersToRemove) {
        [self.delegate removeChild:laser cleanup:YES];
        [self.projectiles removeObject:laser];
    }
    
    [lasersToRemove release];
}

-(void)shoot {
    projectile = [CCSprite spriteWithFile:@"Missle.png"];
    //projectile.position = ccp(self.barrel.position.x, self.barrel.position.y);
    CGPoint p;
    p.x = self.position.x;
    p.y = self.position.y;
    projectile.position = p;
    projectile.rotation = self.barrel.rotation + self.rotation;
    projectile.scale = 0.3;
    [self.delegate addChild:projectile z:self.zOrder - 1];
    [self.projectiles addObject:projectile];
    
    float shotDistance = 400;
    float theta = degToRad(-self.barrel.rotation - self.rotation);
    
    CGPoint realPos;
    realPos.x = projectile.position.x + shotDistance * cosf(theta);
    realPos.y = projectile.position.y + shotDistance * sinf(theta);
    //[[SimpleAudioEngine sharedEngine] playEffect:@"Laser Blast.mp3"];
    [projectile runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:realPos], [CCCallFuncN actionWithTarget:self selector:@selector(deleteProjectile:)], nil]];
    
    /*CGPoint hu;
     CGPoint bu;
     hu = self.barrel.position;
     bu = self.barrel.position;
     NSLog(@"%f",self.barrel.rotation);
     hu.x -= 5;
     //hu.y -= 5; 
     [self.barrel runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 position:hu], [CCMoveTo actionWithDuration:0.1 position:bu],nil]];
     hu.x += 5;*/
}

-(void)deleteProjectile:(CCSprite *)project {
    [self.delegate removeChild:project cleanup:YES];
    [self.projectiles removeObject:project];
}

-(void)activateScheduler {
    [self schedule:@selector(enemyCollisionDetection) interval:0.1f];
    [self schedule:@selector(moveEnemyTowardsUser) interval:0.1f];
    //[self schedule:@selector(rotateEnemyBarrel) interval:0.1f];
    [self schedule:@selector(shoot) interval:3];
}

-(void)deactivateSchuduler {
    NSLog(@"\n\nDeactivated\n\n");
    
    [self unschedule:@selector(enemyCollisionDetection)];
    [self unschedule:@selector(moveEnemyTowardsUser)];
    //[self unschedule:@selector(rotateEnemyBarrel)];
    [self unschedule:@selector(shoot)];
}

- (id)initWithEnemy:(EnemyTank *)enmy {
    self = [super init];
    if (self) {
        //[self setHealth:100.0];
        
        enemy = enmy;
        
    }
    return self;
}

@end
