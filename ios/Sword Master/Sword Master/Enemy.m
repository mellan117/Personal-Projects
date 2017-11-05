//
//  Enemy.m
//  Scenes
//
//  Created by Chris Reddy on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Play.h"


#pragma mark - Properties
@implementation Enemy
@synthesize target;
@synthesize type;
#pragma mark

#pragma mark - Class Variables
Play *_play;
#pragma mark


#pragma mark - Update Methods
- (void)update:(ccTime)dt {
    [self turnEnemyTowardsTarget];
}

- (void)activateScheduler {
    [self schedule:@selector(turnEnemyTowardsTarget) interval:0.1];
    if (self.type == 3) {
        [self schedule:@selector(moveEnemiesTowardsShip) interval:0.1];
    }
    //[self schedule:@selector(moveEnemiesTowardsShip) interval:0.1];
    //[self schedule:@selector(checkBoundaries) interval:0.1];
    //[self schedule:@selector(checkBoundariesOfNearByShips) interval:0.1];
    //[self schedule:@selector(shoot) interval:(arc4random() % 3)+1];
}

- (void)deactivateScheduler {
    [self unschedule:@selector(turnEnemyTowardsTarget)];
    [self unschedule:@selector(moveEnemiesTowardsShip)];
    [self unschedule:@selector(checkBoundaries)];
    [self unschedule:@selector(shoot)];
    [self stopAllActions];
}

- (void)turnEnemyTowardsTarget {
    CGPoint offset = ccpSub(self.target.position, self.position);
    self.rotation = -radToDeg(ccpToAngle(offset));
    
    self.projectileRotation = self.rotation;
}

- (void)moveEnemiesTowardsShip {
    CGFloat rate = 60.0;
    
    float distance = ccpLength(ccpSub(self.target.position, self.position));
    float time = distance / rate;
    float randomX = arc4random() % (25)-1;
    randomX = 0;
    //NSLog(@"Random X = %f",randomX);
    [self runAction:[CCMoveTo actionWithDuration:time position:ccp(self.target.position.x + randomX, self.target.position.y)]];
    //NSLog(@"The Enemy Position When Moved = %f, %f",self.position.x, self.position.y);
    //NSLog(@"Enemy CONENT SIZE = %f",self.contentSize.width);
}

-(void)moveEnemy {
    if (self.type == 1) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        /*[self runAction:[CCSequence actions:[CCJumpTo actionWithDuration:7 position:ccp(screenSize.width + self.contentSize.width, self.position.y) height:50 jumps:10], [CCJumpTo actionWithDuration:7 position:ccp(-self.contentSize.width, self.position.y) height:50 jumps:10], [CCCallFuncN actionWithTarget:self selector:@selector(moveEnemy)], nil]];*/
        
        if (self.position.y >= 0) {
            float sx1 = self.position.x;
            float sy1 = self.position.y;
            float ex1 = sx1;
            float ey1 = self.position.y - 150;
            
            ccBezierConfig bezier1;
            bezier1.controlPoint_1 = ccp(sx1 + 100, sy1 - 50);
            bezier1.controlPoint_2 = ccp(sx1 + 50, sy1 - 100);
            bezier1.endPosition = ccp(ex1, ey1);
            
            CCBezierTo *parab1 = [CCBezierTo actionWithDuration:3 bezier:bezier1];
            [self runAction:[CCSequence actions:parab1, [CCCallFuncN actionWithTarget:self selector:@selector(moveEnemy)], nil]];
        }else if (self.position.y <= 0) {
            float sx1 = self.position.x;
            float sy1 = self.position.y;
            float ex1 = sx1;
            float ey1 = self.position.y + 150;
            
            ccBezierConfig bezier1;
            bezier1.controlPoint_1 = ccp(sx1 + 100, sy1 + 50);
            bezier1.controlPoint_2 = ccp(sx1 + 50, sy1 + 100);
            bezier1.endPosition = ccp(ex1, ey1);
            
            CCBezierTo *parab1 = [CCBezierTo actionWithDuration:3 bezier:bezier1];
            [self runAction:[CCSequence actions:parab1, [CCCallFuncN actionWithTarget:self selector:@selector(moveEnemy)], nil]];
        }
    }
}

-(void)moveEnemy2 {
    if (self.type == 2) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        /*[self runAction:[CCSequence actions:[CCJumpBy actionWithDuration:7 position:ccp(screenSize.width + self.contentSize.width/2, 0) height:-150 jumps:1], [CCJumpBy actionWithDuration:7 position:ccp(-(screenSize.width + self.contentSize.width/2), 0) height:-150 jumps:1], [CCCallFuncN actionWithTarget:self selector:@selector(moveEnemy2)], nil]];
        */
        
        float sx1 = screenSize.width + self.contentSize.height;
        float sy1 = screenSize.height + self.contentSize.width;
        float ex1 = sx1;
        float ey1 = -self.contentSize.width;
        
        ccBezierConfig bezier1;
        bezier1.controlPoint_1 = ccp(sx1 - 300, screenSize.height/2);
        bezier1.controlPoint_2 = ccp(sx1 - 150, screenSize.height/4);
        bezier1.endPosition = ccp(ex1, ey1);
        
        CCBezierTo *parab1 = [CCBezierTo actionWithDuration:7 bezier:bezier1];
        //[self runAction:parab1];
        
        float sx2 = screenSize.width + self.contentSize.height;
        float sy2 = -self.contentSize.width;
        float ex2 = sx2;
        float ey2 = screenSize.height + self.contentSize.width;
        
        ccBezierConfig bezier2;
        bezier2.controlPoint_1 = ccp(sx2 - 300, screenSize.height/2);
        bezier2.controlPoint_2 = ccp(sx2 - 150, screenSize.height/4);
        bezier2.endPosition = ccp(ex2, ey2);
        
        CCBezierTo *parab2 = [CCBezierTo actionWithDuration:7 bezier:bezier2];
        //[self runAction:parab2];
        
        [self runAction:[CCSequence actions:parab1, parab2, [CCCallFuncN actionWithTarget:self selector:@selector(moveEnemy2)], nil]];
    }
}

-(void)moveEnemy3 {
    if (self.type == 3) {
        [self runAction:[CCMoveTo actionWithDuration:4 position:self.target.position]];
    }
}

-(void)checkBoundariesOfNearByShips:(NSMutableArray *)enemiesArray {
    NSLog(@"HELLO WORLD %@",enemiesArray);
    for (CCSprite *mainEnemy in enemiesArray) {
        NSLog(@"The Main Enemy Position = %f, %f", mainEnemy.position.x, mainEnemy.position.y);
        for (CCSprite *otherEnemy in enemiesArray) {
            if (otherEnemy.position.x > mainEnemy.position.x - mainEnemy.contentSize.width && otherEnemy.position.x < mainEnemy.position.x) {
                if (mainEnemy.position.x == otherEnemy.position.x && mainEnemy.position.y == otherEnemy.position.y) {
                    break;
                }
                otherEnemy.position = ccp(otherEnemy.position.x - mainEnemy.contentSize.width, otherEnemy.position.y);
                NSLog(@"The Enemy Position When Checking LEFT Boundaries = %f, %f",otherEnemy.position.x, otherEnemy.position.y);
            }
            if (otherEnemy.position.x < mainEnemy.position.x + mainEnemy.contentSize.width && otherEnemy.position.x > mainEnemy.position.x) {
                if (mainEnemy.position.x == otherEnemy.position.x && mainEnemy.position.y == otherEnemy.position.y) {
                    break;
                }
                otherEnemy.position = ccp(otherEnemy.position.x + mainEnemy.contentSize.width, otherEnemy.position.y);
                NSLog(@"The Enemy Position When Checking RIGHT Boundaries = %f, %f",otherEnemy.position.x, otherEnemy.position.y);
            }
        }
    }
}

-(void)shoot {
    
}

#pragma mark

#pragma mark - Factory Method
+ (Enemy *)enemyWithFile:(NSString *)file target:(CCSprite *)targ winSize:(CGSize)winSize {
    Enemy *enemy = [Enemy spriteWithFile:file];
    enemy.maxHealth = 100.0;
    enemy.health = 100.0;
    enemy.projectileSpeed = 0.5;
    enemy.projectileDistance = 600.0;
    enemy.projectileDamage = 2.0;
    enemy.projectileRotation = enemy.rotation;
    enemy.target = targ;
    
    CGPoint range;
    range.x = (winSize.width - enemy.contentSize.width) - enemy.contentSize.width;
    range.y = (winSize.height - enemy.contentSize.height) - enemy.contentSize.height;
    
    /*CGPoint position;
    position.x = arc4random() % (int)range.x + enemy.contentSize.width;
    position.y = arc4random() % (int)range.y + enemy.contentSize.height;
    enemy.position = position;*/
    
    enemy.position = ccp(-enemy.contentSize.width/2, winSize.height/2 - 58);
    //enemy.position = ccp(-enemy.contentSize.width/2, winSize.height + enemy.contentSize.height/2);
    
    //NSLog(@"The Enemy Position = %f, %f",position.x, position.y);
    //[enemy activateScheduler];
    
    return enemy;
}
#pragma mark

-(id)init {
    if (self = [super init]) {
        _play = [[Play alloc] init];
    }
    return self;
}


@end
