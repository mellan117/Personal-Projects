//
//  GameHUD.m
//  Space Commander
//
//  Created by Adam Mellan on 8/10/12.
//
//

#import "GameHUD.h"
#import "Enemy.h"
#import "Play.h"
#import "ZJoystick.h"
#import "SpaceShip.h"

@implementation GameHUD
@synthesize delegate;
@synthesize joystick;
@synthesize levelBackground;
@synthesize healthBarOutline;
@synthesize manaBarOutline;
@synthesize healthBar;
@synthesize manaBar;
@synthesize levelText;
@synthesize levelLabel;
@synthesize goldLabel;

Enemy *_enemy;
Play *_play;


-(void)addHudLabels:(int)amountOfEnemeis withKills:(int)kills {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if (!amountOfEnemiesLabel) {
        amountOfEnemiesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Enemies: %d", amountOfEnemeis] fontName:@"Marker Felt" fontSize:35];
        amountOfEnemiesLabel.position = ccp(50, screenSize.height - amountOfEnemiesLabel.contentSize.height);
        amountOfEnemiesLabel.anchorPoint = ccp(0, 0);
        [self addChild:amountOfEnemiesLabel];
    }
    amountOfEnemiesLabel.string = [NSString stringWithFormat:@"Enemies: %d", amountOfEnemeis];
    
    if (!killsLabel) {
        killsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Kills: %d", kills] fontName:@"Marker Felt" fontSize:35];
        killsLabel.position = ccp(50, amountOfEnemiesLabel.position.y - killsLabel.contentSize.height);
        killsLabel.anchorPoint = ccp(0, 0);
        [self addChild:killsLabel];
    }
    killsLabel.string = [NSString stringWithFormat:@"Kills: %d", kills];
    
    if (!healthLabel) {
        NSString *healthText = [[NSString alloc] initWithFormat:@"Health"];
        healthLabel = [CCLabelTTF labelWithString:healthText fontName:@"Times New Roman" fontSize:25];
        healthLabel.position = healthBar.position;
        healthLabel.color = ccBLACK;
        [self addChild:healthLabel z:3];
    }
    
    if (!manaLabel) {
        NSString *manaText = [[NSString alloc] initWithFormat:@"Mana"];
        manaLabel = [CCLabelTTF labelWithString:manaText fontName:@"Times New Roman" fontSize:25];
        manaLabel.position = manaBar.position;
        manaLabel.color = ccBLACK;
        [self addChild:manaLabel z:3];
    }
    
    if (!goldLabel) {
        NSString *goldText = [[NSString alloc] initWithFormat:@"GOLD: 0"];
        goldLabel = [CCLabelTTF labelWithString:goldText fontName:@"Times New Roman" fontSize:35];
        goldLabel.position = ccp(50, killsLabel.position.y - goldLabel.contentSize.height);
        goldLabel.anchorPoint = ccp(0, 0);
        goldLabel.color = ccYELLOW;
        [self addChild:goldLabel];
    }
}

-(void)addHealthBar:(UserShip *)ship {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    healthBar = [CCProgressTimer progressWithFile:@"Health_Bar.png"];
    healthBar.type = kCCProgressTimerTypeHorizontalBarLR;
    healthBar.position = ccp(screenSize.width/2 + 50, screenSize.height - healthBar.contentSize.height);
    //healthBar.scaleX = 3;
    healthBar.percentage = ship.health;
    [self addChild:healthBar z:3];
    
    healthBarOutline = [CCSprite spriteWithFile:@"Bar_Outline.png"];
    healthBarOutline.position = healthBar.position;
    //healthBarOutline.scaleX = 3;
    [self addChild:healthBarOutline z:2];
}

-(void)addManaBar:(UserShip *)ship {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    manaBar = [CCProgressTimer progressWithFile:@"Mana_Bar.png"];
    manaBar.type = kCCProgressTimerTypeHorizontalBarLR;
    manaBar.position = ccp(screenSize.width/2 + 50, healthBar.position.y - (manaBar.contentSize.height + manaBar.contentSize.height/2));
    //manaBar.scaleX = 3;
    manaBar.percentage = ship.mana;
    [self addChild:manaBar z:3];
    
    manaBarOutline = [CCSprite spriteWithFile:@"Bar_Outline.png"];
    manaBarOutline.position = manaBar.position;
    //manaBarOutline.scaleX = 3;
    [self addChild:manaBarOutline z:2];
}

#pragma mark Level Methods
-(void)afterPlay {
    levelBackground.opacity = 0;
    levelLabel.opacity = 0;
    
    [levelBackground runAction:[CCFadeTo actionWithDuration:1 opacity:255]];
    [levelLabel runAction:[CCFadeTo actionWithDuration:1 opacity:255]];
}

-(void) aboutToPlay:(int)level {
    [self addChild:levelBackground z:50];
    [self addChild:levelLabel z:51];
    levelBackground.opacity = 0;
    levelLabel.opacity = 0;
    
    [self schedule: @selector(countDown:) interval:1];
    
    if (level > 1) {
        levelBackground.opacity = 0;
        levelLabel.opacity = 0;
        
        [levelBackground runAction:[CCFadeTo actionWithDuration:1 opacity:255]];
        [levelLabel runAction:[CCFadeTo actionWithDuration:1 opacity:255]];
    } else {
        levelBackground.opacity = 255;
        levelLabel.opacity = 255;
    }
}

-(void)showLevel:(int)level {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    levelBackground = [CCSprite spriteWithFile:@"White_Screen.png"];
    levelBackground.position = ccp(screenSize.width/2, screenSize.height/2);
    
    levelLabel = [CCLabelTTF labelWithString:levelText fontName:@"Marker Felt" fontSize:50];
    levelLabel.position = ccp(screenSize.width / 2, screenSize.height / 2);
    levelLabel.color = ccBLACK;
    
    [self aboutToPlay:level];
}

-(void)beforePlay {
    [self removeChild:levelBackground cleanup:YES];
    [self removeChild:levelLabel cleanup:YES];
}

-(void)play {
    NSLog(@"\n\nPlay Game!!!\n\n");
    countDown = 4;
    
    [levelBackground runAction:[CCSequence actions:[CCFadeTo actionWithDuration:1 opacity:0], [CCCallFuncN actionWithTarget:self selector:@selector(beforePlay)], nil]];
    [levelLabel runAction:[CCSequence actions:[CCFadeTo actionWithDuration:1 opacity:0], [CCCallFuncN actionWithTarget:self selector:@selector(beforePlay)], nil]];
    
    [self unschedule:@selector(countDown:)];
}

-(void)countDown:(ccTime) delta {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if(countDown < 1) [self play];
    else {
        countDown--;
        NSString *countStr;
        
        if(countDown < 1)
            countStr = [NSString stringWithFormat:@"GO!"];
        else
            countStr = [NSString stringWithFormat:@"%d", countDown];
        
        // Cool animation effect
        CCLabelTTF* label = [CCLabelTTF labelWithString:countStr fontName:@"Marker Felt" fontSize:60];
        label.position = ccp(screenSize.width/2, screenSize.height/2 - 100);
        label.color = ccBLACK;
        [self addChild:label z:51];
        
        id scoreAction = [CCSequence actions:[CCSpawn actions:[CCScaleBy actionWithDuration:0.4 scale:2.0], [CCEaseIn actionWithAction:[CCFadeOut actionWithDuration:0.4] rate:2], nil], [CCCallBlock actionWithBlock:^{[self removeChild:label cleanup:YES];}], nil];
        [label runAction:scoreAction];
    }
}
#pragma mark

- (id)init {
    if (self = [super init]) {
        joystick = [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" selectedSpriteFile:@"JoystickContainer_trans.png" controllerSpriteFile:@"Joystick_norm.png"];
        joystick.position = ccp(joystick.contentSize.width, joystick.contentSize.height);
        joystick.speedRatio = 6.0f;
        joystick.joystickRadius = 50.0f;
        [self addChild:joystick z:1];
        
        countDown = 4;
    }
    return self;
}

@end
