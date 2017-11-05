//
//  GameHUD.h
//  Space Commander
//
//  Created by Adam Mellan on 8/10/12.
//
//

#import "cocos2d.h"
#import "ZJoystick.h"
#import "Enemy.h"

@interface GameHUD : CCLayer <ZJoystickDelegate> {
    NSMutableArray *enemies;
    CCMenuItemImage *shootButton;
    ZJoystick *joystick;
    CCSprite *healthBarOutline;
    CCSprite *manaBarOutline;
    CCLabelTTF *countDownLabel;
    CCLabelTTF *healthLabel;
    CCLabelTTF *manaLabel;
    CCLabelTTF *amountOfEnemiesLabel;
    CCLabelTTF *killsLabel;
    CCLabelTTF *levelLabel;
    int countDown;
    int m;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) ZJoystick *joystick;
@property (nonatomic, retain) CCSprite *levelBackground;
@property (nonatomic, retain) CCSprite *healthBarOutline;
@property (nonatomic, retain) CCSprite *manaBarOutline;
@property (nonatomic, retain) CCLabelTTF *levelLabel;
@property (nonatomic, retain) CCProgressTimer *healthBar;
@property (nonatomic, retain) CCProgressTimer *manaBar;
@property (nonatomic, retain) NSString *levelText;
@property (nonatomic, assign) CCLabelTTF *goldLabel;

-(void)addHudLabels:(int)amountOfEnemeis withKills:(int)kills;
-(void)aboutToPlay:(int)level;
-(void)showLevel:(int)level;
-(void)countDown:(ccTime)dt;
-(void)addHealthBar:(UserShip *)ship;
-(void)addManaBar:(UserShip *)ship;
-(void)beforePlay;
-(void)afterPlay;
-(void)play;

@end