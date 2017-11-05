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
#import "ResizeSprite.h"

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
ResizeSprite *_resizeSprite;


-(void)addHudLabels:(int)amountOfEnemeis withKills:(int)kills {
    
    if (!amountOfEnemiesLabel) {
        amountOfEnemiesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Enemy:%d", amountOfEnemeis] fontName:@"Marker Felt" fontSize:17.5];
        amountOfEnemiesLabel.position = ccp([_resizeSprite determinePositionX:15], [_resizeSprite determinePositionY:718]);
        amountOfEnemiesLabel.scale = [_resizeSprite resizeLabel];
        amountOfEnemiesLabel.anchorPoint = ccp(0, 0.5);
        [self addChild:amountOfEnemiesLabel];
    }
    amountOfEnemiesLabel.string = [NSString stringWithFormat:@"Enemy:%d", amountOfEnemeis];
    
    if (!killsLabel) {
        killsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Kills: %d", kills] fontName:@"Marker Felt" fontSize:17.5];
        killsLabel.position = ccp([_resizeSprite determinePositionX:15], [_resizeSprite determinePositionY:668]);
        killsLabel.scale = [_resizeSprite resizeLabel];
        killsLabel.anchorPoint = ccp(0, 0.5);
        [self addChild:killsLabel];
    }
    killsLabel.string = [NSString stringWithFormat:@"Kills: %d", kills];
    
    if (!healthLabel) {
        NSString *healthText = [[NSString alloc] initWithFormat:@"Health"];
        healthLabel = [CCLabelTTF labelWithString:healthText fontName:@"Times New Roman" fontSize:20];
        healthLabel.scale = [_resizeSprite resizeLabel];
        healthLabel.position = healthBar.position;
        healthLabel.color = ccBLACK;
        [self addChild:healthLabel z:3];
    }
    
    if (!manaLabel) {
        NSString *manaText = [[NSString alloc] initWithFormat:@"Mana"];
        manaLabel = [CCLabelTTF labelWithString:manaText fontName:@"Times New Roman" fontSize:20];
        manaLabel.scale = [_resizeSprite resizeLabel];
        manaLabel.position = manaBar.position;
        manaLabel.color = ccBLACK;
        [self addChild:manaLabel z:3];
    }
    
    if (!goldLabel) {
        NSString *goldText = [[NSString alloc] initWithFormat:@"GOLD: 0"];
        goldLabel = [CCLabelTTF labelWithString:goldText fontName:@"Times New Roman" fontSize:17.5];
        goldLabel.position = ccp([_resizeSprite determinePositionX:15], [_resizeSprite determinePositionY:618]);
        goldLabel.scale = [_resizeSprite resizeLabel];
        goldLabel.anchorPoint = ccp(0, 0.5);
        goldLabel.color = ccYELLOW;
        [self addChild:goldLabel];
    }
}

-(void)addHealthBar:(UserShip *)ship {
    healthBar = [CCProgressTimer progressWithFile:@"Health_Bar_User.png"];
    healthBar.type = kCCProgressTimerTypeHorizontalBarLR;
    healthBar.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718]);
    healthBar.scale = [_resizeSprite resizeImage];
    healthBar.percentage = ship.health;
    [self addChild:healthBar z:3];
    
    healthBarOutline = [CCSprite spriteWithFile:@"Bar_Outline_User.png"];
    healthBarOutline.position = healthBar.position;
    healthBarOutline.scale = [_resizeSprite resizeImage];
    [self addChild:healthBarOutline z:2];
}

-(void)addManaBar:(UserShip *)ship {
    manaBar = [CCProgressTimer progressWithFile:@"Mana_Bar_Blue.png"];
    manaBar.type = kCCProgressTimerTypeHorizontalBarLR;
    //manaBar.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:658]);
    manaBar.position = ccp([_resizeSprite determinePositionX:512], [_resizeSprite determinePositionY:718 - 75]);
    manaBar.scale = [_resizeSprite resizeImage];
    manaBar.percentage = ship.mana;
    [self addChild:manaBar z:3];
    
    manaBarOutline = [CCSprite spriteWithFile:@"Bar_Outline_User.png"];
    manaBarOutline.position = manaBar.position;
    manaBarOutline.scale = [_resizeSprite resizeImage];
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
        _resizeSprite = [[ResizeSprite alloc] init];
        
        joystick = [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" selectedSpriteFile:@"JoystickContainer_trans.png" controllerSpriteFile:@"Joystick_norm.png"];
        joystick.position = ccp([_resizeSprite determinePositionX:150], [_resizeSprite determinePositionY:200]);
        joystick.speedRatio = 6.0f;
        joystick.joystickRadius = 150.0f;
        joystick.scale = [_resizeSprite resizeImage];
        [self addChild:joystick z:1];
        
        countDown = 4;
    }
    return self;
}

@end
