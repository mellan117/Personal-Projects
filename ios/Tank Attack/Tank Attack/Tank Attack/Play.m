//
//  Play.m
//  Tank Attack
//
//  Created by Adam Mellan on 10/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Play.h"
#import "GameHUD.h"
#import "ZJoystick.h"
#import "Tank.h"
#import "UserTank.h"
#import "EnemyTank.h"
#import "PauseMenu.h"
#import "SimpleAudioEngine.h"

#define bgWidth     1024
#define bgHeight    768

@implementation Play
@synthesize delegatePlay;
@synthesize isShooting;
@synthesize amountOfEnemies;

GameHUD *_hud;
PauseMenu *_pauseMenu;

+(CCScene *)playScene {
    CCScene *playScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [playScene addChild:hud z:1];
    
    Play *layer = [[[Play alloc] initWithHUD:hud] autorelease];
    [playScene addChild:layer];
    
    return playScene;
}

#pragma mark - Joystick Delegate Methods
-(void)setViewPointCenter:(CGPoint)position {
    CGSize size = [[CCDirector sharedDirector] winSize];
    int x = MAX(position.x, size.width/2);
    int y = MAX(position.y, size.height/2);
    x = MIN(x, (bgWidth) - size.width/2);
    y = MIN(y, (bgHeight) - size.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(size.width/2, size.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
}

-(void)joystickControlDidUpdate:(id)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio {
    ZJoystick *zJoystick = (ZJoystick *)joystick;
    CGFloat theta = ccpToAngle(zJoystick.controllerActualPoint);
    
    // the image rotates the opposite way
    theta = -radToDeg(theta);
    if (joystick == _hud.joystickTankBody) {
        tankUser.rotation = theta;
    } else if (joystick == _hud.joystickTankBarrel) {
        tankUser.barrel.rotation = theta - tankUser.rotation;
    }
}
#pragma mark

-(void)addEnemy:(NSString *)tankBodyFile withBarrel:(NSString *)tankBarrelFile withTarg:(UserTank *)usrTank withAmount:(int)amountOfEnemy {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    for (int x = 0; x < amountOfEnemy; x++) {
        //tankEnemy = [EnemyTank createTank:tankBodyFile tankBarrelFile:tankBarrelFile];
        //[tankEnemy setEnemyTanksPosition:screenSize target:tankUser];
        tankEnemy = [EnemyTank createTank:tankBodyFile withTankBarrelFile:tankBarrelFile withTarget:usrTank withSize:screenSize];
        tankEnemy.delegate = self;
        tankEnemy.health = 100;
        [tankEnemy addChild:tankEnemy.barrel z:1];
        [self addChild:tankEnemy z:1];
        [enemies addObject:tankEnemy];
        NSLog(@"\n\nEnemy health: %f\naddEnemy method\n\n",tankEnemy.health);
    }
}

-(void)checkProjectileHitWall {
    NSMutableArray *projectilesToRemove = [[NSMutableArray alloc] init];
    
    // Check User Projectile
        for (CCSprite *proj in projectiles) {
            // Vertical Walls
                for (CCSprite *verticalWall in verticalWallsArray) {
                    if (CGRectIntersectsRect(proj.boundingBox, verticalWall.boundingBox)) {
                        [projectilesToRemove addObject:proj];
                    }
                }
            // Horizontal Walls
                for (CCSprite *horizontalWall in horizontalWallsArray) {
                    if (CGRectIntersectsRect(proj.boundingBox, horizontalWall.boundingBox)) {
                        [projectilesToRemove addObject:proj];
                    }
                }
            }
    
    // Check Enemy Projectile
    for (EnemyTank *enemy in enemies) {
        for (CCSprite *proj in enemy.projectiles) {
            // Vertical Walls
                for (CCSprite *verticalWall in verticalWallsArray) {
                    if (CGRectIntersectsRect(proj.boundingBox, verticalWall.boundingBox)) {
                        [projectilesToRemove addObject:proj];
                    }
                }
            // Horizontal Walls
                for (CCSprite *horizontalWall in horizontalWallsArray) {
                    if (CGRectIntersectsRect(proj.boundingBox, horizontalWall.boundingBox)) {
                        [projectilesToRemove addObject:proj];
                    }
                }
            }
        }
    
    
    for (CCSprite *proj in projectilesToRemove) {
        for (EnemyTank *enemy in enemies) {
            [enemy.projectiles removeObject:proj];
        }
        
        [self removeChild:proj cleanup:YES];
        [projectiles removeObject:proj];
        
        CCParticleSystem *system = [CCParticleFire node];
        system.position = proj.position;
        system.scale = 0.3;
        system.life = 0.3;
        system.duration = 0.3;
        system.autoRemoveOnFinish = YES;
        [self addChild:system z:999];
    }
    [projectilesToRemove release];
}

-(void)collisionDetection {
    NSMutableArray *projectileToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *enemiesToRemove = [[NSMutableArray alloc] init];
    
    for (CCSprite *proj in projectiles) {
        for (EnemyTank *enemy in enemies) {
            if (CGRectIntersectsRect(proj.boundingBox, enemy.boundingBox)) {
                [enemy takenDamage];
                if (enemy.health <= 0) {
                    [enemiesToRemove addObject:enemy];
                }
                NSLog(@"\n\nEnemy health: %f\ncollistoinDetection method\n\n",enemy.health);
                //[enemy damage:self];
                [projectileToRemove addObject:proj];
            }
        }
    }
    
    for (CCSprite *proj in projectileToRemove) {
        [self removeChild:proj cleanup:YES];
        [projectiles removeObject:proj];
        CCParticleSystem *system = [CCParticleFire node];
        system.position = proj.position;
        system.scale = 0.3;
        system.life = 0.3;
        system.duration = 0.3;
        system.autoRemoveOnFinish = YES;
        [self addChild:system z:999];
    }
    
    for (EnemyTank *enmy in enemiesToRemove) {
        [self removeChild:enmy cleanup:YES];
        [enemies removeObject:enmy];
        self.amountOfEnemies = 2;
        [self addEnemy:tankBodyFile withBarrel:tankBarrelFile withTarg:tankUser withAmount:self.amountOfEnemies];
    }
    
    [projectileToRemove release];
    [enemiesToRemove release];
}

-(void)enemyHitTarget {
    [tankUser damage:self];
    CCParticleSystem *system = [CCParticleFire node];
    system.position = tankUser.position;
    system.scale = 0.3;
    system.life = 0.3;
    system.duration = 0.3;
    system.autoRemoveOnFinish = YES;
    [self addChild:system z:999];
}

-(void)wallCheckVertical:(Tank *)tank {
    CGPoint pointTank = tank.position;
    
    for (CCSprite *verticalWall in verticalWallsArray) {
        if (CGRectIntersectsRect(tank.boundingBox, verticalWall.boundingBox)) {
            if (pointTank.x >  verticalWall.position.x + verticalWall.contentSize.width/2) {
                pointTank.x = ((verticalWall.position.x + verticalWall.contentSize.width/2) + tank.contentSize.height/2);
                tank.position = pointTank;
            } else if (pointTank.x < verticalWall.position.x - verticalWall.contentSize.width/2) {
                pointTank.x = ((verticalWall.position.x - verticalWall.contentSize.width/2) - tank.contentSize.height/2);
                tank.position = pointTank;
            }
            
            if (pointTank.y > verticalWall.position.y + verticalWall.contentSize.height/2) {
                pointTank.y = (verticalWall.position.y + verticalWall.contentSize.height/2) + tank.contentSize.height/2;
                tank.position = pointTank;
            } else if (pointTank.y < verticalWall.position.y - verticalWall.contentSize.height/2) {
                pointTank.y = (verticalWall.position.y - verticalWall.contentSize.height/2) - tank.contentSize.height/2;
                tank.position = pointTank;
            }
        }
    }
}

-(void)wallCheckHorizontal:(Tank *)tank {
    CGPoint pointTank = tank.position;
    
    for (CCSprite *horizontalWall in horizontalWallsArray) {
        if (CGRectIntersectsRect(tank.boundingBox, horizontalWall.boundingBox)) {
            if (pointTank.x > horizontalWall.position.x + horizontalWall.contentSize.width/2) {
                pointTank.x = (horizontalWall.position.x + horizontalWall.contentSize.width/2) + tank.contentSize.height/2;
                tank.position = pointTank;
            } else if (pointTank.x < horizontalWall.position.x - horizontalWall.contentSize.width/2) {
                pointTank.x = (horizontalWall.position.x - horizontalWall.contentSize.width/2) - tank.contentSize.height/2;
                tank.position = pointTank;
            }
            
            if (pointTank.y > horizontalWall.position.y + horizontalWall.contentSize.height/2) {
                pointTank.y = (horizontalWall.position.y + horizontalWall.contentSize.height/2) + tank.contentSize.height/2;
                tank.position = pointTank;
            } else if (pointTank.y < horizontalWall.position.y - horizontalWall.contentSize.height/2) {
                pointTank.y = (horizontalWall.position.y - horizontalWall.contentSize.height/2) - tank.contentSize.height/2;
                tank.position = pointTank;
            }
        }
    }
}

-(void)boundaryCheck {
// User Tank Walls Check
    // Inner Walls: Vertical
        [self wallCheckVertical:tankUser];
    // Inner Walls: Horizontal
        [self wallCheckHorizontal:tankUser];
    // Outer Walls: Vertical
        [self wallCheckVertical:tankUser];
        [self wallCheckVertical:tankUser];
        [self wallCheckVertical:tankUser];
        [self wallCheckVertical:tankUser];
    // Outer Walls: Horizontal
        [self wallCheckHorizontal:tankUser];
        [self wallCheckHorizontal:tankUser];
        [self wallCheckHorizontal:tankUser];
        [self wallCheckHorizontal:tankUser];
    
// Enemy Tank Walls Check
    for (EnemyTank *enemy in enemies) {
        // Inner Walls: Vertical
        [self wallCheckVertical:enemy];
        // Inner Walls: Horizontal
        [self wallCheckHorizontal:enemy];
        // Outer Walls: Vertical
        [self wallCheckVertical:enemy];
        [self wallCheckVertical:enemy];
        [self wallCheckVertical:enemy];
        [self wallCheckVertical:enemy];
        // Outer Walls: Horizontal
        [self wallCheckHorizontal:enemy];
        [self wallCheckHorizontal:enemy];
        [self wallCheckHorizontal:enemy];
        [self wallCheckHorizontal:enemy];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    CGPoint offset = ccp(location.x - tankUser.position.x, location.y - tankUser.position.y);
    float theta = -radToDeg(ccpToAngle(offset));
    float time = 1.0;
    
    [tankUser.barrel runAction:[CCRotateTo actionWithDuration:time angle:theta - tankUser.rotation]];
}

-(void)createWalls {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Inner Vertical Walls
    CCSprite *verticalInnerWall1 = [CCSprite spriteWithFile:@"wallVertical.png"];
    verticalInnerWall1.position = ccp(screenSize.width/2 + 100, screenSize.height/2);
    [self addChild:verticalInnerWall1];
    [verticalWallsArray addObject:verticalInnerWall1];
    
    CCSprite *verticalInnerWall2 = [CCSprite spriteWithFile:@"wallVertical.png"];
    verticalInnerWall2.position = ccp(screenSize.width/2 - 100, screenSize.height/2);
    [self addChild:verticalInnerWall2];
    [verticalWallsArray addObject:verticalInnerWall2];
    
    // Inner Horizontal Walls
    CCSprite *horizontalInnerWall1 = [CCSprite spriteWithFile:@"wallHorizontal.png"];
    horizontalInnerWall1.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:horizontalInnerWall1];
    [horizontalWallsArray addObject:horizontalInnerWall1];
    
    // Outer Vertical Walls (Left)
    CCSprite *verticalOuterWall1 = [CCSprite spriteWithFile:@"wallVertical.png"];
    verticalOuterWall1.position = ccp(verticalOuterWall1.contentSize.width/2, verticalOuterWall1.contentSize.height/2);
    [self addChild:verticalOuterWall1];
    [verticalWallsArray addObject:verticalOuterWall1];
    
    CCSprite *verticalOuterWall2 = [CCSprite spriteWithFile:@"wallVertical.png"];
    verticalOuterWall2.position = ccp(verticalOuterWall2.contentSize.width/2, verticalOuterWall1.position.y + verticalOuterWall1.contentSize.height);
    [self addChild:verticalOuterWall2];
    [verticalWallsArray addObject:verticalOuterWall2];
    
    // Outer Vertical Walls (Right)
    CCSprite *verticalOuterWall3 = [CCSprite spriteWithFile:@"wallVertical.png"];
    verticalOuterWall3.position = ccp(screenSize.width - verticalOuterWall3.contentSize.width/2, verticalOuterWall3.contentSize.height/2);
    [self addChild:verticalOuterWall3];
    [verticalWallsArray addObject:verticalOuterWall3];
    
    CCSprite *verticalOuterWall4 = [CCSprite spriteWithFile:@"wallVertical.png"];
    verticalOuterWall4.position = ccp(screenSize.width - verticalOuterWall4.contentSize.width/2, verticalOuterWall3.position.y + verticalOuterWall3.contentSize.height);
    [self addChild:verticalOuterWall4];
    [verticalWallsArray addObject:verticalOuterWall4];
    
    // Outer Horizontal Walls (Bottom)
    CCSprite *horizontalOuterWall1 = [CCSprite spriteWithFile:@"wallHorizontal.png"];
    horizontalOuterWall1.position = ccp(horizontalOuterWall1.contentSize.width/2, horizontalOuterWall1.contentSize.height/2);
    [self addChild:horizontalOuterWall1];
    [horizontalWallsArray addObject:horizontalOuterWall1];
    
    CCSprite *horizontalOuterWall2 = [CCSprite spriteWithFile:@"wallHorizontal.png"];
    horizontalOuterWall2.position = ccp(horizontalOuterWall1.position.x + horizontalOuterWall1.contentSize.width, horizontalOuterWall2.contentSize.height/2);
    [self addChild:horizontalOuterWall2];
    [horizontalWallsArray addObject:horizontalOuterWall2];
    
    // Outer Horizontal Walls (Top)
    CCSprite *horizontalOuterWall3 = [CCSprite spriteWithFile:@"wallHorizontal.png"];
    horizontalOuterWall3.position = ccp(horizontalOuterWall3.contentSize.width/2, screenSize.height - horizontalOuterWall3.contentSize.height/2);
    [self addChild:horizontalOuterWall3];
    [horizontalWallsArray addObject:horizontalOuterWall3];
    
    CCSprite *horizontalOuterWall4 = [CCSprite spriteWithFile:@"wallHorizontal.png"];
    horizontalOuterWall4.position = ccp(horizontalOuterWall3.position.x + horizontalOuterWall3.contentSize.width, screenSize.height - horizontalOuterWall4.contentSize.height/2);
    [self addChild:horizontalOuterWall4];
    [horizontalWallsArray addObject:horizontalOuterWall4];
}

-(void)shoot {
    if (isShooting) {
        CCSprite *projectile = [CCSprite spriteWithFile:@"Missle.png"];
        //projectile.position = ccp(self.barrel.position.x, self.barrel.position.y);
        CGPoint p;
        p.x = tankUser.position.x;
        p.y = tankUser.position.y;
        projectile.position = p;
        projectile.rotation = tankUser.barrel.rotation + tankUser.rotation;
        projectile.scale = 0.3;
        [self addChild:projectile z:tankUser.zOrder - 1];
        [projectiles addObject:projectile];
        
        float shotDistance = 400;
        float theta = degToRad(-tankUser.barrel.rotation - tankUser.rotation);
        
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
}

-(void)deleteProjectile:(CCSprite *)project {
    [self removeChild:project cleanup:YES];
    [projectiles removeObject:project];
}

-(void)gameOver {
    [self unschedule:@selector(gameOver)];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    self.isShooting = NO;
    
    CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"GAME OVER" fontName:@"Times New Roman" fontSize:60];
    gameOver.position = ccp(screenSize.width/2, screenSize.height/2);
    [_hud addChild:gameOver];
    NSLog(@"GameOvererrrrrrrrrrrrrrrrrrrrrrrrr");
    
    _hud.joystickTankBody.controlledObject = nil;
    _hud.joystickTankBody.delegate = nil;
    _hud.joystickTankBarrel.controlledObject = nil;
    _hud.joystickTankBarrel.delegate = nil;
    _pauseMenu.disablePauseMenu = YES;
    
    CCMenuItemFont *restartButton = [CCMenuItemFont itemFromString:@"Restart" target:_pauseMenu selector:@selector(yesRestart)];
    restartButton.position = ccp(screenSize.width/2, screenSize.height/2 + 100);
    restartButton.scale = 2;
    
    CCMenu *restartMenu = [CCMenu menuWithItems:restartButton, nil];
    restartMenu.position = ccp(0, 0);
    [_hud addChild:restartMenu];
    
    for (EnemyTank *enemy in enemies) {
        [enemy deactivateSchuduler];
        [enemy stopAllActions];
        [self removeChild:enemy.projectile cleanup:YES];
    }
}

-(void)update:(ccTime)delta {
    [self collisionDetection];
    [self setViewPointCenter:tankUser.position];
    [self boundaryCheck];
    [self checkProjectileHitWall];
}

-(id)initWithHUD:(GameHUD *)hud {
    if (self = [super init]) {
        tankBarrelFile = [[NSString alloc] initWithString:@"Tank_Barrel.png"];
        tankBodyFile = [[NSString alloc] initWithString:@"Tank_Body.png"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        projectiles = [[NSMutableArray alloc] init];
        enemies = [[NSMutableArray alloc] init];
        verticalWallsArray = [[NSMutableArray alloc] init];
        horizontalWallsArray = [[NSMutableArray alloc] init];
        _pauseMenu = [[PauseMenu alloc] init];
        self.isTouchEnabled = YES;
        self.isShooting = YES;
        self.amountOfEnemies = 1;
        _hud = hud;
        
        CCSprite *background = [CCSprite spriteWithFile:@"Sand.png"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        background.anchorPoint = ccp(0.5,0.5);
        [self addChild:background];
        
        tankUser = [[UserTank alloc] init];
        //tankUser = (UserTank *)[Tank createTank:tankBodyFile tankBarrelFile:tankBarrelFile];
        tankUser = [UserTank createTank:tankBodyFile tankBarrelFile:tankBarrelFile];
        tankUser.position = ccp(200, 200);
        tankUser.delegate = self;
        tankUser.health = 100;
        [tankUser addChild:tankUser.barrel z:3];
        [self addChild:tankUser z:1];
        _hud.joystickTankBody.controlledObject = tankUser;
        _hud.joystickTankBody.delegate = self;
        _hud.joystickTankBarrel.delegate = self;
        
        /*tankEnemy = [EnemyTank createTank:tankBodyFile tankBarrelFile:tankBarrelFile];
        [tankEnemy setEnemyTanksPosition:screenSize target:tankUser];
        tankEnemy.delegate = self;
        tankEnemy.health = 5;
        [tankEnemy addChild:tankEnemy.barrel z:1];
        [self addChild:tankEnemy];
        [enemies addObject:tankEnemy];
        //[tankEnemy initWithEnemy:tankEnemy];*/
        
        [self addEnemy:@"Tank_Body.png" withBarrel:@"Tank_Barrel.png" withTarg:tankUser withAmount:self.amountOfEnemies];
        
        CCMenuItemImage *shootButton = [CCMenuItemImage itemFromNormalImage:@"Shoot.png" selectedImage:@"Shoot.png" target:self selector:@selector(shoot)];
        shootButton.position = ccp(screenSize.width - shootButton.contentSize.width/4, _hud.joystickTankBarrel.position.y + shootButton.contentSize.height/2);
        shootButton.scale = 0.4;
        
        CCMenu *menu = [CCMenu menuWithItems:shootButton, nil];
        menu.position = ccp(0, 0);
        [_hud addChild:menu z:_hud.zOrder];
        
        [_pauseMenu preRenderAndShowPauseMenu];
        [self setViewPointCenter:tankUser.position];
        [self scheduleUpdate];
        [self createWalls];
    }
    return self;
}

@end
