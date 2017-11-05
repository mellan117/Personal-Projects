//
//  UserTank.m
//  Tank Attack
//
//  Created by Adam Mellan on 10/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UserTank.h"
#import "Tank.h"
#import "Play.h"


@implementation UserTank
@synthesize delegate;
@synthesize enemies;

Play *_play;

+(UserTank *)createTank:(NSString *)tankBodyFile tankBarrelFile:(NSString*)tankBarrelFile {
    UserTank *tankUser = [UserTank spriteWithFile:tankBodyFile];
    tankUser.position = ccp(0, 0);
    tankUser.anchorPoint = ccp(0.5, 0.5);
    tankUser.scale = 0.7;
    
    tankUser.barrel = [CCSprite spriteWithFile:tankBarrelFile];
    tankUser.barrel.anchorPoint = ccp(0.2, 0.5);
    tankUser.barrel.position = ccp(tankUser.contentSize.width/2, tankUser.contentSize.height/2);
    
    return tankUser;
}

-(void)takenDamage {
    if (self.health > 0) {
        self.health -= 50;
    } else if (self.health <= 0) {
        [self removeChild:self cleanup:YES];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        [self setHealth:100.0];
    }
    return self;
}

@end
