//
//  Tank.h
//  Tank Attack
//
//  Created by Adam Mellan on 10/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZJoyStick.h"

#define radToDeg(x)((x) * (180/M_PI))
#define degToRad(x)((x) * (M_PI/180))

@interface Tank : CCSprite <ZJoystickDelegate> {
    NSManagedObjectContext *mocTemp;
}
@property (nonatomic, retain)NSMutableArray *projectiles;
@property (nonatomic, retain)Tank *barrel;
@property (nonatomic, assign)float maxHealth;
@property (nonatomic, assign)float health;
@property (nonatomic, assign)float recoil;
@property (nonatomic, assign)id delegate;
@property (nonatomic, assign)CGFloat thetaa;

//+(Tank *)createTank:(NSString *)tankBodyFile tankBarrelFile:(NSString*)tankBarrelFile;
-(void)wall:(CCSprite *)verticalWall horizon:(CCSprite *)horizontalWall;
-(void)shoot;
-(void)damage:(id)playy;

@end
