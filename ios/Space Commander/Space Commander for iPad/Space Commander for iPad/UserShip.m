//
//  UserShip.m
//  Space Commander
//
//  Created by Adam Mellan on 11/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UserShip.h"
#import "GameHUD.h"
#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "Temp.h"


@implementation UserShip
@synthesize gold;
@synthesize goldInc;
@synthesize manaNeeded;

GameHUD *_hud;

+(CCScene *) userShipScene {
    CCScene *userShipScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [userShipScene addChild:hud];
    
    SpaceShip *layer = [[[UserShip alloc] initWithHUD:hud] autorelease];
    [userShipScene addChild:layer];
    
    return userShipScene;
}

+ (UserShip *)userShipWithFile:(NSString *)file {
    UserShip *userShip = [UserShip spriteWithFile:file];
    //userShip.scale = 0.8;
    
    return userShip;
}

-(void)healthIncrease:(float)plusHealth {
    int healthIncrease = plusHealth;
    
    if (self.health < self.maxHealth) {
        if (self.health + healthIncrease > self.maxHealth) {
            healthIncrease = self.maxHealth - self.health;
        }
        self.health += healthIncrease;
        _hud.healthBar.percentage = (self.health/self.maxHealth)*100;
    }
}

-(void)manaIncrease:(float)plusMana {
    int manaIncrease = plusMana;
    
    if (self.mana >= self.manaNeeded) {
        _hud.manaBar.sprite = [CCSprite spriteWithFile:@"Mana_Bar_Green.png"];
    }
    
    if (self.mana < self.maxMana) {
        if (self.mana + manaIncrease > self.maxMana) {
            manaIncrease = self.maxMana - self.mana;
        }
        self.mana += manaIncrease;
        _hud.manaBar.percentage = (self.mana/self.maxMana)*100;
    }
    
}

-(void)goldIncrease {
    //NSLog(@"DEBUG TEST");
    
    /*mocTemp = [[CoreDataManager shared] managedObjectContext];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Temp" inManagedObjectContext:mocTemp];
    fetchRequest.entity = entity;
    NSLog(@"DEBUG TEST");
    NSArray *tempObjects = [mocTemp executeFetchRequest:fetchRequest error:&error];
    
    for (Temp *tem in tempObjects) {
        if (tem.gold) {
            self.gold = tem.gold;
        }
    }*/
    self.gold += self.goldInc;
    NSString *gd = [[NSString alloc] initWithFormat:@"GOLD: %d",self.gold];
    _hud.goldLabel.string = gd;
    
    /*Temp *tem = (Temp *)[NSEntityDescription insertNewObjectForEntityForName:@"Temp" inManagedObjectContext:mocTemp];
    tem.gold = self.gold;
    
    if (![mocTemp save:&error]) {
        NSLog(@"Adam an error occured! ERROR: %@",error);
    }*/
}

-(id)initWithHUD:(GameHUD *)hud {
    if (self = [super init]) {
        _hud = hud;
        NSLog(@"DEBUG TEST User Tank initttttttttttttt");
        //mocTemp = [[CoreDataManager shared] managedObjectContext];
    }
    return self;
}

@end
