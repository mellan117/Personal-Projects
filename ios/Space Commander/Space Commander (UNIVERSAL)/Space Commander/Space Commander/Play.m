//
//  Play.m
//  Space Commander
//
//  Created by Adam Mellan on 8/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "Play.h"
#import "Ships.h"
#import "Upgrade.h"
#import "Settings.h"
#import "ZJoystick.h"
#import "GameHUD.h"
#import "Enemy.h"
#import "SimpleAudioEngine.h"
#import "SpaceShip.h"
#import "PauseMenu.h"
#import "GameMode.h"
#import "ResizeSprite.h"
#import "PowerUp.h"

#define bgWidth 1919
#define bgHeight 1224

@implementation Play
@synthesize mode = _mode;
@synthesize time;
@synthesize shootButton;
@synthesize menuArray;
@synthesize shootButtonBeenPressed;
@synthesize isGameOver;
@synthesize hi;

GameHUD *_hud;
SpaceShip *_spaceShip;
PauseMenu *_pauseMenu;
GameMode *_gameMode;
ResizeSprite *_resizeSprite;
PowerUp *_powerUp;

#pragma mark Scene Method
+(CCScene *)playSceneWithMode:(Mode)gameModeInt {
    CCScene *playScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [playScene addChild:hud z:3];
    
    PauseMenu *pauseMenu = [PauseMenu node];
    [playScene addChild:pauseMenu z:4];
    
    Play *layer = [[[Play alloc] initWithHUD:hud mode:gameModeInt] autorelease];
    [playScene addChild:layer];
    
    return playScene;
}
#pragma mark

#pragma mark Joystick Methods
- (void)joystickControlDidUpdate:(id)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio {
    ZJoystick *zJoystick = (ZJoystick *)joystick;
    CGFloat theta = ccpToAngle(zJoystick.controllerActualPoint);
    
    // the image rotates the opposite way
    theta = -radToDeg(theta);
    ship.rotation = theta;
}
#pragma mark

#pragma mark Update Methods
- (void)update:(ccTime)dt {
    [self setViewPointCenter:ship.position];
    [self collisionDetection];
    [self checkRapidFire];
    [_pauseMenu getMode:self.mode];    
}

- (void)setViewPointCenter:(CGPoint)position {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    int x = MAX(position.x, screenSize.width/2);
    int y = MAX(position.y, screenSize.height/2);
    x = MIN(x, (bgWidth) - screenSize.width/2);
    y = MIN(y, (bgHeight) - screenSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(screenSize.width/2, screenSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
}

-(void)timeMethod {
    if (!timeLabel) {
        timeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Time: %d", time] fontName:@"Marker Felt" fontSize:17.5];
        timeLabel.position = ccp([_resizeSprite determinePositionX:15], [_resizeSprite determinePositionY:555]);
        timeLabel.scale = [_resizeSprite resizeLabel];
        timeLabel.anchorPoint = ccp(0, 0);
        [_hud addChild:timeLabel];
    }
    timeLabel.string = [NSString stringWithFormat:@"Time: %d", time];
    time += 1;
}

-(void)checkRapidFire {
    if (!shootButtonBeenPressed) {
        if (shootButton.isSelected) {
            [self schedule:@selector(shoot) interval:0.2];
            shootButtonBeenPressed = YES;
        }
    } else if (shootButtonBeenPressed) {
        if (!shootButton.isSelected) {
            [self unschedule:@selector(shoot)];
            shootButtonBeenPressed = NO;
        }
    }
}

- (void)collisionDetection {
    NSMutableArray *projectilesToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *enemiesToRemove = [[NSMutableArray alloc] init];
    
    for (CCSprite *proj in projectiles) {
        for (Enemy *enmy in enemies) {
            if (CGRectIntersectsRect(proj.boundingBox, enmy.boundingBox)) {
                [projectilesToRemove addObject:proj];
                [enmy damageTaken];
                //[enmy damage:self];
                if (enmy.health <= 0) {
                    [enemiesToRemove addObject:enmy];
                    [self removeChild:enmy.healthBar cleanup:YES];
                    [self removeChild:enmy.healthBarOutline cleanup:YES];
                    [self removeChild:enmy.projectile cleanup:YES];
                    [totalEnemies addObject:enmy];
                    //[_hud setEnemiesKilledLabel:totalEnemies.count];
                    [_hud addHudLabels:enemies.count withKills:totalEnemies.count];
                }
            }
        }
    }
    
    for (Enemy *enmy in enemiesToRemove) {
        CCParticleSystem *system = [CCParticleFire node];
        system.position = enmy.position;
        system.scale = 0.5;
        system.life = 1;
        system.duration = 0.3;
        system.autoRemoveOnFinish = YES;
        [self addChild:system z:999];
        //[self addParticleEffect];
        
        [self removeChild:enmy cleanup:YES];
        [enemies removeObject:enmy];
        //[_hud setKillsLabel:enemies.count];
        [_hud addHudLabels:enemies.count withKills:totalEnemies.count];
        [ship manaIncrease:ship.manaInc];
        [ship goldIncrease];
        NSLog(@"\n\nYou currently have %2.f mana\n\n",ship.mana);
        
        if (enemies.count <= 0) {
            level += 1;
            //[self level:level];
        }
    }
    
    for (CCSprite *proj in projectilesToRemove) {
        [self removeChild:proj cleanup:YES];
        [projectiles removeObject:proj];
    }
}
#pragma mark
/*-(void)createShip {
 CGSize screenSize = [[CCDirector sharedDirector] winSize];
 
 // add enemy
 CCSprite *enemy2 = [CCSprite spriteWithFile:@"Enemy_Ship.png"];
 enemy2.position = ccp(screenSize.width/2+50, screenSize.height/2);
 [self addChild:enemy2 z:2];
 }*/

#pragma mark Other Methods

- (void)level:(int)levell {
    for (i = 0; i < levell; i ++) {
        [self addEnemy];
    }
    
    if (i > 1) {
        NSLog(@"\n\n\nLevel %d Completed\n\n\n",i-1);
    }
    
    NSString *levelText = [NSString stringWithFormat:@"Starting Level %d",i];
    _hud.levelText = levelText;
    [_hud showLevel:levell];
}

- (void)deleteLaser:(CCSprite *)proj {
    // could have been removed in collision detection
    [self removeChild:proj cleanup:YES];
    [projectiles removeObject:proj];
}

- (void)shoot {
    if (!isGameOver) {
        projectile = [CCSprite spriteWithFile:@"Green_Laser.png"];
        projectile.position = ship.position;
        projectile.rotation = ship.rotation;
        projectile.scale = [_resizeSprite resizeImage];
        [self addChild:projectile z:1];
        [projectiles addObject:projectile];
        
        // distance and theta of shot
        //float shotDistance = 650;
        float theta = degToRad(-ship.rotation);
        
        // calculate x and y coordinates
        CGPoint realPos;
        
        // a = h * cos(0)
        realPos.x = projectile.position.x + ship.projectileDistance * cosf(theta);
        // o = h * sin(0)
        realPos.y = projectile.position.y + ship.projectileDistance * sinf(theta);
        
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"Laser Blast.mp3"];
        
        [projectile runAction:[CCSequence actions:[CCMoveTo actionWithDuration:ship.projectileSpeed position:realPos], [CCCallFuncN actionWithTarget:self selector:@selector(deleteLaser:)], nil]];
    }
}

-(void)hitButton {
    NSLog(@"\n\nYou have %2.f mana\n | You need %2.f mana before unleashing hell ;)\n\n",ship.mana, ship.manaNeeded - ship.mana);
    
    if (destroyEnemies) {
        if (ship.mana >= ship.manaNeeded) {
            ship.mana -= ship.manaNeeded;
            _hud.manaBar.percentage = ship.mana;
        }
    }
}
#pragma mark

#pragma mark GAME OVER
-(void)gameOver {
    [self unschedule:@selector(timeMethod)];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"YOU SUCK ASS!!!" fontName:@"Times New Roman" fontSize:30];
    gameOver.position = ccp(screenSize.width/2, screenSize.height/2);
    gameOver.scale = [_resizeSprite resizeLabel];
    [_hud addChild:gameOver];
    NSLog(@"Game Over");
    
    isGameOver = YES;
    destroyEnemies = NO;
    _hud.joystick.controlledObject = nil;
    _hud.joystick.delegate = nil;
    _pauseMenu.disablePauseMenu = YES;
    [_powerUp deactivateScheduler];
    
    CCMenuItemFont *restartButton = [CCMenuItemFont itemFromString:@"Restart" target:_pauseMenu selector:@selector(yesRestart)];
    restartButton.position = ccp(screenSize.width/2, screenSize.height/2 + 75);
    restartButton.scale = [_resizeSprite resizeLabel];
    
    CCMenu *restartMenu = [CCMenu menuWithItems:restartButton, nil];
    restartMenu.position = ccp(0, 0);
    [_hud addChild:restartMenu];
    
    for (Enemy *enmy in enemies) {
        [enmy deactivateScheduler];
        [enmy stopAllActions];
        [self removeChild:enmy.projectile cleanup:YES];
    }
}

-(void)restartGame:(BOOL)gameOver {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemFont *restartButton = [CCMenuItemFont itemFromString:@"Restart" target:_pauseMenu selector:@selector(yesRestart)];
    restartButton.position = ccp(screenSize.width/2, screenSize.height/2 + 50);
    restartButton.scale = 2;
    
    CCMenu *restartMenu = [CCMenu menuWithItems:restartButton, nil];
    restartMenu.position = ccp(0, 0);
    [_hud addChild:restartMenu];
}
#pragma mark

#pragma mark Enemy Methods
-(void)addEnemy {
    Enemy *enemy = [Enemy enemyWithFile:@"Enemy_Ship.png" target:ship winSize:CGSizeMake(bgWidth, bgHeight)];
    enemy.delegate = self;
    enemy.maxHealth = 100.0;
    enemy.health = 100.0;
    enemy.dele = self;
    [self addChild:enemy z:2];
    [enemies addObject:enemy];
    [_hud addHudLabels:enemies.count withKills:totalEnemies.count];
}

-(void)enemyHitTarget {
    [ship damage:self];
}

-(void)destroyAllEnemies {
    NSLog(@"\n\nYou have %2.f mana\nYou need %2.f mana before unleashing hell ;)\n\n",ship.mana, ship.manaNeeded - ship.mana);
    NSMutableArray *enemiesToRemove = [[NSMutableArray alloc] init];
    
    if (destroyEnemies) {
        destroyEnemies = NO;
        for (Enemy *enmy in enemies) {
            CCParticleSystem *system = [CCParticleFire node];
            system.position = enmy.position;
            system.scale = 0.3;
            system.life = 0.3;
            system.duration = 0.3;
            system.autoRemoveOnFinish = YES;
            [self addChild:system z:999];
            [enemiesToRemove addObject:enmy];
            //[ship goldIncrease];
            [self removeChild:enmy.healthBar cleanup:YES];
            [self removeChild:enmy.healthBarOutline cleanup:YES];
            //[totalEnemies addObject:enmy];
            //[_hud setEnemiesKilledLabel:totalEnemies.count];
            [_hud addHudLabels:enemies.count withKills:totalEnemies.count];
        }
        for (Enemy *enmy in enemiesToRemove) {
            [self removeChild:enmy cleanup:YES];
            [self removeChild:enmy.projectile cleanup:YES];
            [enemies removeObject:enmy];
        }
    } else if (!destroyEnemies) {
        if (ship.mana >= ship.manaNeeded) {
            ship.mana -= ship.manaNeeded;
            _hud.manaBar.sprite = [CCSprite spriteWithFile:@"Mana_Bar_Blue.png"];
            _hud.manaBar.percentage = ship.mana;
            
            for (Enemy *enmy in enemies) {
                CCParticleSystem *system = [CCParticleFire node];
                system.position = enmy.position;
                system.scale = 0.3;
                system.life = 0.3;
                system.duration = 0.3;
                system.autoRemoveOnFinish = YES;
                [self addChild:system z:999];
                [enemiesToRemove addObject:enmy];
                //[ship goldIncrease];
                [self removeChild:enmy.healthBar cleanup:YES];
                [self removeChild:enmy.healthBarOutline cleanup:YES];
                //[totalEnemies addObject:enmy];
                //[_hud setEnemiesKilledLabel:totalEnemies.count];
                [_hud addHudLabels:enemies.count withKills:totalEnemies.count];
            }
            for (Enemy *enmy in enemiesToRemove) {
                [self removeChild:enmy cleanup:YES];
                [self removeChild:enmy.projectile cleanup:YES];
                [enemies removeObject:enmy];
            }
        }
    }
    [enemiesToRemove release];
}

-(BOOL)shouldDestroyEnemies:(BOOL)destroy {
    destroyEnemies = destroy;
    
    return destroyEnemies;
}
#pragma mark

#pragma mark General Info Methods
-(void)createUserShip {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    ship = [UserShip userShipWithFile:@"Melonator_Ship.png"];
    ship.position = ccp(screenSize.width/2, screenSize.height/2);
    ship.delegate = self;
    ship.scale = [_resizeSprite resizeImage];
    ship.health = 100.0;
    ship.maxHealth = 100.0;
    ship.mana = 0.0;
    ship.maxMana = 100.0;
    ship.manaNeeded = 75.0;
    ship.speed = 25.0;
    ship.healthRegen = 2.0;
    ship.healthInc = 5.0;
    ship.manaGen = 2.0;
    ship.manaInc = 1.0;
    ship.goldInc = 2;
    ship.projectileSpeed = 0.5;
    ship.projectileDistance = 650.0;
    ship.projectileDamage = 50.0;
    _hud.joystick.controlledObject = ship;
    _hud.joystick.delegate = self;
    _hud.joystick.speedRatio = ship.speed;
    [self addChild:ship z:2];
}

-(void)createButtons {
    shootButton = [CCMenuItemImage itemFromNormalImage:@"Shoot.png" selectedImage:@"Shoot.png" target:self selector:@selector(shoot)];
    shootButton.position = ccp([_resizeSprite determinePositionX:874], [_resizeSprite determinePositionY:200]);
    
    shootButton.scale = [_resizeSprite resizeImage];
    [menuArray addObject:shootButton];
    
    CCMenuItemImage *damButton = [CCMenuItemImage itemFromNormalImage:@"Mana.png" selectedImage:@"Mana.png" target:self selector:@selector(destroyAllEnemies)];
    damButton.position = ccp([_resizeSprite determinePositionX:874], [_resizeSprite determinePositionY:400]);
    damButton.scale = [_resizeSprite resizeImage];
    
    CCMenu *menu = [CCMenu menuWithItems:shootButton, damButton, nil];
    menu.position = ccp(0, 0);
    [_hud addChild:menu];
}

-(void)generalInformation:(GameHUD *)hud mode:(Mode)gameMode {
    CCSprite *background = [CCSprite spriteWithFile:@"Red_Space.png"];
    background.anchorPoint = ccp(0,0);
    [self addChild:background];
    
    totalEnemies = [[NSMutableArray alloc] init];
    enemies = [[NSMutableArray alloc] init];
    projectiles = [[NSMutableArray alloc] init];
    _pauseMenu = [[PauseMenu alloc] init];
    _spaceShip = [[SpaceShip alloc] init];
    _resizeSprite = [[ResizeSprite alloc] init];
    _powerUp = [[PowerUp alloc] init];
    
    _spaceShip.delegate = self;
    _hud.delegate = self;
    
    self.isTouchEnabled = YES;
    _pauseMenu.sound = YES;
    destroyEnemies = NO;
    
    self.mode = gameMode;
    _hud = hud;
    level = 1;
    time = 0;
    
    [self timeMethod];
}

-(void)checkGameMode:(Mode)gameModeyy {
    if (gameModeyy == 1) {
        self.mode = gameModeyy;
        [self schedule:@selector(addEnemy) interval:0.5];
        [self schedule:@selector(timeMethod) interval:1];
    } else if (gameModeyy == 2) {
        self.mode = gameModeyy;
        //[self level:level];
    }
}
#pragma mark

-(id)initWithHUD:(GameHUD *)hud mode:(Mode)gameMode {
	if( (self=[super init])) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"I-Still-Can't-Stop.mp3" loop:YES];
        
        menuArray = [[NSMutableArray alloc] init];
        shootButtonBeenPressed = NO;
        isGameOver = NO;
        hi = YES;
        
        [self generalInformation:hud mode:gameMode];
        [self createUserShip];
        [self createButtons];
        [self setViewPointCenter:ship.position];
        [self schedule:@selector(update:)];
        [self checkGameMode:self.mode];
        
        [_powerUp initWithPowerUps:ship withHUD:hud withScene:self];
        [_pauseMenu preRenderAndShowPauseMenu];
        [_hud addHealthBar:ship];
        [_hud addManaBar:ship];
        [_hud addHudLabels:enemies.count withKills:totalEnemies.count];
        
        
        
        // Haha :) This was quite the accomplishment when I first started coding 
            /*ship = [CCSprite spriteWithFile:@"Melonator_Ship_Big.png"];
             ship.position = ccp(screenSize.width/2, screenSize.height/2);
             ship.anchorPoint = ccp(0.5, 0.5);
             ship.scale = 0.8;
             [self addChild:ship z:2];
             [self createShip]; */
    }
	return self;
}

@end
