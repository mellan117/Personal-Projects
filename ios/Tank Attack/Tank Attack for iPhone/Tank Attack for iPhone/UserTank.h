//
//  UserTank.h
//  Tank Attack
//
//  Created by Adam Mellan on 10/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tank.h"

@interface UserTank : Tank {
    
}
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain)NSMutableArray *enemies;

+(UserTank *)createTank:(NSString *)tankBodyFile tankBarrelFile:(NSString*)tankBarrelFile;
-(void)takenDamage;

@end
