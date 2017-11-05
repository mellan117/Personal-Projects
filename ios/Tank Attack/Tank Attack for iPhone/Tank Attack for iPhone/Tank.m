//
//  Tank.m
//  Tank Attack
//
//  Created by Adam Mellan on 10/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Tank.h"
#import "UserTank.h"
#import "GameHUD.h"
#import "Play.h"
#import "SimpleAudioEngine.h"


@implementation Tank
@synthesize delegate;
@synthesize barrel;
@synthesize health;
@synthesize maxHealth;
@synthesize recoil;
@synthesize projectiles;
@synthesize thetaa;


/*-(void)wall {
    pointUsr = tankUser.position;
    
    if (CGRectIntersectsRect(tankUser.boundingBox, verticalWall.boundingBox)) {
        if (pointUsr.x <= verticalWall.position.x - verticalWall.contentSize.width) {
            NSLog(@"DEBUG TEST");
            pointUsr.x = verticalWall.position.x - tankUser.contentSize.width;
            tankUser.position = pointUsr;
        } else if (pointUsr.x >= verticalWall.position.x) {
           pointUsr.x = verticalWall.position.x + tankUser.contentSize.width;
           tankUser.position = pointUsr;
           } else if (pointUsr.y >= verticalWall.position.y) {
           pointUsr.y = verticalWall.position.y + tankUser.contentSize.height;
           tankUser.position = pointUsr;
           }
    }
    
    if (CGRectIntersectsRect(tankUser.boundingBox, horizontalWall.boundingBox)) {
        if (pointUsr.y <= horizontalWall.position.y - horizontalWall.contentSize.width) {
            NSLog(@"DEBUG TEST");
            pointUsr.y = horizontalWall.position.y - tankUser.contentSize.width;
            tankUser.position = pointUsr;
        } else if (pointUsr.y >= horizontalWall.position.x) {
            pointUsr.y = horizontalWall.position.y + tankUser.contentSize.width;
            tankUser.position = pointUsr;
        } else if (pointUsr.x >= horizontalWall.position.x) {
           pointUsr.x = horizontalWall.position.x + tankUser.contentSize.width;
           tankUser.position = pointUsr;
           } else if (pointUsr.x <= (horizontalWall.position.x - horizontalWall.position.x)) {
           pointUsr.x = (horizontalWall.position.x - horizontalWall.position.x) - tankUser.contentSize.width;
           tankUser.position = pointUsr;
           }
    }
    
    tankUser.position = pointUsr;
}*/

/*-(void)wallCheck:(CCSprite *)horizontalWall vert:(CCSprite *)verticalWall {
    
    CGPoint pointUsr = tankUser.position;
    
    if (CGRectIntersectsRect(tankUser.boundingBox, verticalWall.boundingBox)) {
        if (pointUsr.x <= verticalWall.position.x - verticalWall.contentSize.width) {
            NSLog(@"DEBUG TEST");
            pointUsr.x = verticalWall.position.x - tankUser.contentSize.width;
            tankUser.position = pointUsr;
        } else if (pointUsr.x >= verticalWall.position.x) {
           pointUsr.x = verticalWall.position.x + tankUser.contentSize.width;
           tankUser.position = pointUsr;
           } else if (pointUsr.y >= verticalWall.position.y) {
           pointUsr.y = verticalWall.position.y + tankUser.contentSize.height;
           tankUser.position = pointUsr;
           }
    }
    
    if (CGRectIntersectsRect(tankUser.boundingBox, horizontalWall.boundingBox)) {
        if (pointUsr.y <= horizontalWall.position.y - horizontalWall.contentSize.width) {
            NSLog(@"DEBUG TEST");
            pointUsr.y = horizontalWall.position.y - tankUser.contentSize.width;
            tankUser.position = pointUsr;
        } else if (pointUsr.y >= horizontalWall.position.x) {
            pointUsr.y = horizontalWall.position.y + tankUser.contentSize.width;
            tankUser.position = pointUsr;
        } else if (pointUsr.x >= horizontalWall.position.x) {
           pointUsr.x = horizontalWall.position.x + tankUser.contentSize.width;
           tankUser.position = pointUsr;
           } else if (pointUsr.x <= (horizontalWall.position.x - horizontalWall.position.x)) {
           pointUsr.x = (horizontalWall.position.x - horizontalWall.position.x) - tankUser.contentSize.width;
           tankUser.position = pointUsr;
           }
    }
    
    tankUser.position = pointUsr;
}*/

+(Tank *)createTank:(NSString *)tankBodyFile tankBarrelFile:(NSString*)tankBarrelFile {
    Tank *tank = [Tank spriteWithFile:tankBodyFile];
    tank.position = ccp(0.5, 0.5);
    
    tank.barrel = [CCSprite spriteWithFile:tankBarrelFile];
    tank.barrel.anchorPoint = ccp(0.2, 0.5);
    tank.barrel.position = ccp(tank.position.x, tank.position.y);
    [tank addChild:tank.barrel z:2];
    
    return tank;
}

-(void)shoot {
    CCSprite *projectile = [CCSprite spriteWithFile:@"Missle.png"];
    //projectile.position = ccp(self.barrel.position.x, self.barrel.position.y);
    CGPoint p;
    p.x = self.position.x;
    p.y = self.position.y;
    projectile.position = p;
    NSLog(@"\n\nProjectile position = %@\n\n",NSStringFromCGPoint(self.barrel.position));
    projectile.rotation = self.barrel.rotation + self.rotation;
    projectile.scale = 0.3;
    [self.delegate addChild:projectile z:self.zOrder - 1];
    [projectiles addObject:projectile];
    
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
    [projectiles removeObject:project];
}

-(void)damage:(id)playy {
    if (self.health > 0) {
        self.health -= 25;
    } else if (self.health <= 0) {
            CCParticleSystem *system = [CCParticleFire node];
            system.position = self.position;
            system.scale = 0.3;
            system.life = 0.3;
            system.duration = 0.3;
            system.autoRemoveOnFinish = YES;
            [self.delegate addChild:system z:999];
            [self.delegate removeChild:self cleanup:YES];
            [playy gameOver];
    }
    /*m++;
    
    if (m > 1) {
        NSLog(@"\n\nThe Melonator has been hit %d times!\n\nDamage Taken!!!\nHealth is now %2.f\n\n", m, health);
    } else {
        NSLog(@"\n\nThe Melonator has been hit %d time!\n\nDamage Taken!!!\nHealth is now %2.f\n\n", m, health);
    }
    
    _hud.healthBar.percentage = (self.health/self.maxHealth) *100;
    */
}

-(void)wall:(CCSprite *)verticalWall horizon:(CCSprite *)horizontalWall {
    CGPoint point;
    point = self.position;
    if (CGRectIntersectsRect(self.boundingBox, verticalWall.boundingBox)) {
        if (point.x >= verticalWall.position.x) {
            point.x = verticalWall.position.x + 35;
            self.position = point;
        }
        if (point.x <= verticalWall.position.x) {
            point.x = verticalWall.position.x - 35;
            self.position = point;
        }
    }
    
    if (CGRectIntersectsRect(self.boundingBox, horizontalWall.boundingBox)) {
        if (point.y >= horizontalWall.position.y) {
            point.y = horizontalWall.position.y + 35;
            self.position = point;
        }
        if (point.y <= horizontalWall.position.y) {
            point.y = horizontalWall.position.y - 35;
            self.position = point;
        }
    }
}

-(id)init {
    if (self = [super init]) {
        projectiles = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
