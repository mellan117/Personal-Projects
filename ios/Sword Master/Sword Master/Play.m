//
//  Play.m
//  Latrunculi
//
//  Created by Adam Mellan on 2/26/14.
//  Copyright 2014 __Platinum Code__. All rights reserved.
//

#import "Play.h"
#import "GameHUD.h"
#import "PauseMenu.h"
#import "Enemy.h"


#pragma mark Properties
@implementation Play
@synthesize character;
@synthesize rightPlatform;
@synthesize healthBarOutline, manaBarOutline, healthBar, manaBar;
@synthesize standingStillAnimation, standingStillAction;
@synthesize walkingAnimation, walkLeftAction, walkRightAction;
@synthesize jumpAnimation, jumpRightAction, jumpLeftAction, jumpStandingStillAction;
@synthesize sAttackAction, wAttackAction;
@synthesize characterTempPostion;
@synthesize jumpVector;
@synthesize characterVelocity;
@synthesize enemies;
@synthesize health;
@synthesize mana;
#pragma mark

#pragma mark Class Variables
GameHUD *_hud;
PauseMenu *_pauseMenu;
#pragma mark

#pragma mark Scene Method
+(CCScene *)playScene {
    CCScene *playScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [playScene addChild:hud z:3];
    
    PauseMenu *pauseMenu = [PauseMenu node];
    [playScene addChild:pauseMenu z:4];
    
    Play *layer = [[[Play alloc] initWithHUD:hud] autorelease];
    [playScene addChild:layer];
    
    return playScene;
}
#pragma mark

#pragma mark Pause/Resume Methods


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    //NSLog(@"User touched %f, %f",location.x, location.y);
    
    
    // Swipe Detection Part 1 | for pause menu
    firstTouch = location;
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //Swipe Detection Part 2 | for pause menu
    NSSet *allTouches = [event allTouches];
    UITouch * touch2 = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location2 = [touch2 locationInView: [touch2 view]];
    location2 = [[CCDirector sharedDirector] convertToGL:location2];
    
    lastTouch = location2;
    
    //NSLog(@"Touch ended at %f, %f",lastTouch.x, lastTouch.y);
    
    
    
    // Minimum length of the swipe
    float swipeLength = ccpDistance(firstTouch, lastTouch);
    float deltaX = fabsf(firstTouch.x - lastTouch.x);
    float deltaY = fabsf(firstTouch.y - lastTouch.y);
    
    // Check if the swipe is a vertical swipe and is long enough
    if (deltaX < 60) {
        if ((firstTouch.y > lastTouch.y && swipeLength > 60) || (firstTouch.y < lastTouch.y && swipeLength > 60)) {
            // Pause the play scene
            if (!_pauseMenu.disablePause) {
                [_pauseMenu pause];
            }
        }
    }
}

-(void)pausePlayScene {
    [[CCDirector sharedDirector] pause];
}

-(void)resumePlayScene {
    [[CCDirector sharedDirector] resume];
}
#pragma mark

#pragma mark Update Methods
- (void)update:(ccTime)dt {
    [self checkBoundaries];
    [self gravity:dt];
    [self newWalk];
    
    // Old Walking Method
    /*
    if (leftButton.isSelected && !isWalkLeftButtonSelected && !isJumping) {
        NSLog(@"The left button was selected");
        if (isWalkRightButtonSelected) {
            isWalkRightButtonSelected = NO;
            [self stopWalkRight];
        } else if (!isWalkRightButtonSelected) {
            isWalkLeftButtonSelected = YES;
            [self walkLeft];
        }
    } else if (!leftButton.isSelected && isWalkLeftButtonSelected && !isJumping) {
        NSLog(@"The left button was deselected");
        isWalkLeftButtonSelected = NO;
        [self stopWalkLeft];
    }
    
    if (rightButton.isSelected && !isWalkRightButtonSelected && !isJumping) {
        NSLog(@"The right button was selected");
        if (isWalkLeftButtonSelected) {
            isWalkLeftButtonSelected = NO;
            [self stopWalkLeft];
        } else if (!isWalkLeftButtonSelected) {
            isWalkRightButtonSelected = YES;
            [self walkRight];
        }
    } else if (!rightButton.isSelected && isWalkRightButtonSelected && !isJumping) {
        NSLog(@"The right button was deselected");
        isWalkRightButtonSelected = NO;
        [self stopWalkRight];
    }*/
}

-(void)checkBoundaries {
    /*if (character.position.x - character.boundingBox.size.width/2 <= 0) {
        character.position = ccp(character.boundingBox.size.width/2, character.position.y);
    } else if (character.position.x + character.boundingBox.size.width/2 >= screenSize.width) {
        character.position = ccp(screenSize.width - character.boundingBox.size.width/2, character.position.y);
    }*/
    
    if (self.character.position.y + self.character.contentSize.width/2 >= screenSize.height) {
        self.character.position = ccp(self.character.position.x, screenSize.height - self.character.contentSize.width/2);
    }
    
    if (self.character.position.y - self.character.contentSize.width/2 <= 0) {
        //[self.character runAction:[CCMoveBy actionWithDuration:0.1 position:ccp(0,(screenSize.height/2 - 58)-self.character.position.y)]];
        self.character.position = ccp(self.character.position.x, self.character.contentSize.width/2);
    }
}

-(void)gravity:(ccTime)dt {
    // 2
    CGPoint gravity = ccp(-25.0, 0.0);
    
    // 3
    CGPoint gravityStep = ccpMult(gravity, 0.016);
    
    // 4
    self.characterVelocity = ccpAdd(self.characterVelocity, gravityStep);
    CGPoint stepVelocity = ccpMult(self.characterVelocity, dt);
    
    // 5
    self.character.position = ccpAdd(self.character.position, self.characterVelocity);
    //NSLog(@"Character's Position = %f, %f | time = %f",self.character.position.x, self.character.position.y, dt);
    
    if (CGRectIntersectsRect(self.character.boundingBoxInPixels, testBridge.boundingBoxInPixels)) {
        self.characterVelocity = ccp(0.0, self.characterVelocity.y);
        self.character.position = ccp((testBridge.position.x + testBridge.contentSize.height/2) + self.character.contentSize.height/2, self.character.position.y);
    }
}
#pragma mark

#pragma mark Jumping Methods

-(void)newWalk {
    if (leftButton.isSelected && !isWalkLeftButtonSelected && !isJumping) {
        NSLog(@"The left button was selected");
        if (isWalkRightButtonSelected) {
            isWalkRightButtonSelected = NO;
            self.characterVelocity = ccp(0.0, 0.0);
            [self stopAction:walkingAnimation];
        } else if (!isWalkRightButtonSelected) {
            isWalkLeftButtonSelected = YES;
            self.characterVelocity = ccp(0.0, 5.0);
            self.character.flipX = YES;
            [self.character runAction:walkingAnimation];
        }
    } else if (!leftButton.isSelected && isWalkLeftButtonSelected && !isJumping) {
        NSLog(@"The left button was deselected");
        isWalkLeftButtonSelected = NO;
        self.characterVelocity = ccp(0.0, 0.0);
        [self.character stopAction:walkingAnimation];
    }
    
    if (rightButton.isSelected && !isWalkRightButtonSelected && !isJumping) {
        NSLog(@"The right button was selected");
        if (isWalkLeftButtonSelected) {
            isWalkLeftButtonSelected = NO;
            self.characterVelocity = ccp(0.0, 0.0);
            [self.character stopAction:walkingAnimation];
        } else if (!isWalkLeftButtonSelected) {
            isWalkRightButtonSelected = YES;
            self.characterVelocity = ccp(0.0, -5.0);
            self.character.flipX = NO;
            [self.character runAction:walkingAnimation];
        }
    } else if (!rightButton.isSelected && isWalkRightButtonSelected && !isJumping) {
        NSLog(@"The right button was deselected");
        isWalkRightButtonSelected = NO;
        self.characterVelocity = ccp(0.0, 0.0);
        [self.character stopAction:walkingAnimation];
    }
}

-(void)newJump2 {
    if (!leftButton.isSelected && !rightButton.isSelected && !isJumping) {
        isJumping = YES;
        self.characterVelocity = ccp(5.0, 0.0);
        self.character.position = ccpAdd(self.character.position, self.characterVelocity);
    } else if (leftButton.isSelected && !isJumping) {
        isJumping = YES;
        self.characterVelocity = ccp(5.0, 5.0);
        self.character.position = ccpAdd(self.character.position, self.characterVelocity);
    } else if (rightButton.isSelected && !isJumping) {
        isJumping = YES;
        self.characterVelocity = ccp(5.0, -5.0);
        self.character.position = ccpAdd(self.character.position, self.characterVelocity);
    }
    
    if (self.characterVelocity.x == 0.0) {
        isJumping = NO;
        [self unschedule:@selector(newJump2)];
    }
}

-(void)newJump {
    if (!isJumping) {
        [self schedule:@selector(newJump2)];
    }
}


#pragma mark

#pragma mark - User Interface
-(void)addHealthBar {
    self.healthBarOutline = [CCSprite spriteWithFile:@"Bar_Outline_User.png"];
    //self.healthBarOutline.position = ccp(screenSize.width/2, screenSize.height - self.healthBarOutline.contentSize.height/2);
    self.healthBarOutline.position = ccp(screenSize.width - 25, screenSize.height/2);
    self.healthBarOutline.scale = 0.35;
    self.healthBarOutline.rotation = 90;
    [_hud addChild:self.healthBarOutline z:2];
    
    self.healthBar = [CCProgressTimer progressWithFile:@"Health_Bar_User.png"];
    self.healthBar.type = kCCProgressTimerTypeHorizontalBarLR;
    self.healthBar.position = self.healthBarOutline.position;
    self.healthBar.percentage = self.health;
    self.healthBar.scale = 0.35;
    self.healthBar.rotation = 90;
    [_hud addChild:self.healthBar z:3];
}

-(void)addManaBar {
    self.manaBarOutline = [CCSprite spriteWithFile:@"Bar_Outline_User.png"];
    //self.manaBarOutline.position = ccp(healthBarOutline.position.x, healthBarOutline.position.y - manaBarOutline.contentSize.height);
    self.manaBarOutline.position = ccp(healthBarOutline.position.x - 65, screenSize.height/2);
    self.manaBarOutline.scale = 0.35;
    self.manaBarOutline.rotation = 90;
    //[_hud addChild:self.manaBarOutline z:2];
    
    self.manaBar = [CCProgressTimer progressWithFile:@"Mana_Bar_Blue.png"];
    self.manaBar.type = kCCProgressTimerTypeHorizontalBarLR;
    self.manaBar.position = self.manaBarOutline.position;
    self.manaBar.percentage = self.mana;
    self.manaBar.scale = 0.35;
    self.manaBar.rotation = 90;
    //[_hud addChild:self.manaBar z:3];
}
#pragma mark

#pragma mark Information Methods

-(void)createCharacter {
    // Create Sprite Sheet for Character Animations
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"man.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"man.png"];
    [self addChild:spriteSheet];
    
    // Create Running Character Animation
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=18; i++) {
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"run%d.png",i]]];
    }
    CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f];
    
    // Create Standing Still Character Animation
    NSMutableArray *standingStillFrames = [NSMutableArray array];
    for (int i=1; i<=18; i++) {
        [standingStillFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"run%d.png",i]]];
    }
    CCAnimation *standingStillAnim = [CCAnimation animationWithFrames:standingStillFrames delay:0.1f];
    
    // Create Jumping Character Animation
    NSMutableArray *jumpingFrames = [NSMutableArray array];
    for (int i=1; i<=8; i++) {
        [jumpingFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"jump%d.png",i]]];
    }
    CCAnimation *jumpingAnim =[CCAnimation animationWithFrames:jumpingFrames delay:0.1f];
    
    // Create Strong Attack Character Animation
    NSMutableArray *sAttackFrames = [NSMutableArray array];
    for (int i=1; i<=8; i++) {
        [sAttackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"sAttack%d.png",i]]];
    }
    CCAnimation *sAttackAnim = [CCAnimation animationWithFrames:sAttackFrames delay:0.1f];
    
    // Create Weak Attack Character Animation
    NSMutableArray *wAttackFrames = [NSMutableArray array];
    for (int i=1; i<=2; i++) {
        [wAttackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"wAttack%d.png",i]]];
    }
    CCAnimation *wAttackAnim = [CCAnimation animationWithFrames:wAttackFrames delay:0.1f];
    
    // Create Character
    self.character = [CCSprite spriteWithSpriteFrameName:@"run1.png"];
    self.character.rotation = 90;
    self.character.position = ccp(screenSize.width - 50, screenSize.height/2 + 158);
    self.walkingAnimation = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    self.standingStillAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:standingStillAnim]];
    self.jumpAnimation = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:jumpingAnim]];
    self.sAttackAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:sAttackAnim] times:1];
    self.wAttackAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:wAttackAnim] times:1];
    [spriteSheet addChild:self.character];
    //[self.character runAction:self.standingStillAction];
    //self.character.scale = 0.065;
    characterMoveSpeed = screenSize.width/3.0;
    self.health = 100;
    self.mana = 50;
    [self addHealthBar];
    [self addManaBar];
    
    testBridge = [CCSprite spriteWithFile:@"clearFloor.png"];
    testBridge.position = ccp(screenSize.width/2 - 80, screenSize.height/2);
    testBridge.rotation = 90;
    [self addChild:testBridge];
}

-(void)attack {
    NSLog(@"ATTACK!!!");
}

-(void)createMovementButtons {
    // Create Left Button
    leftButton = [CCMenuItemImage itemFromNormalImage:@"unnamed.png" selectedImage:@"unnamed.png" target:self selector:nil];
    leftButton.position = ccp(50, screenSize.height - 50);
    leftButton.rotation = 90;
    
    // Create Right Button
    rightButton = [CCMenuItemImage itemFromNormalImage:@"unnamed-2.png" selectedImage:@"unnamed-2.png" target:self selector:nil];
    rightButton.position = ccp(50, leftButton.position.y - leftButton.contentSize.width/2 - rightButton.contentSize.width/2);
    rightButton.rotation = 90;
    
    // Create Jump Button
    jumpButton = [CCMenuItemImage itemFromNormalImage:@"jumpyButton.png" selectedImage:@"jumpyButton.png" target:self selector:@selector(newJump)];
    jumpButton.position = ccp(50, 150);
    jumpButton.rotation = 90;
    
    // Create Attack Button
    attackButton = [CCMenuItemImage itemFromNormalImage:@"attackyButton.png" selectedImage:@"attackyButton.png" target:self selector:@selector(attack)];
    attackButton.position = ccp(50, 50);
    attackButton.rotation = 90;
    
    CCMenu *movementButtonsMenu = [CCMenu menuWithItems:leftButton, rightButton, nil];
    movementButtonsMenu.position = ccp(0, 0);
    [self addChild:movementButtonsMenu];
    
    jumpButtonMenu = [CCMenu menuWithItems:jumpButton, nil];
    jumpButtonMenu.position = ccp(0, 0);
    [self addChild:jumpButtonMenu];
    
    CCMenu *attackButtonMenu = [CCMenu menuWithItems:attackButton, nil];
    attackButtonMenu.position = ccp(0, 0);
    [self addChild:attackButtonMenu z:999];
}

-(void)generalInformation:(GameHUD *)hud {
    // Initalize Arrays and other Objects
    _pauseMenu = [[PauseMenu alloc] init];
    enemies = [[NSMutableArray alloc] init];
    
    // Set Boolean Variables
    characterWalkedOffPlatformLeft = NO;
    characterWalkedOffPlatformRight = NO;
    checkingLeftButton = YES;
    checkingRightButton = YES;
    self.isTouchEnabled = YES;
    _pauseMenu.sound = NO;
    justMoved = NO;
    isJumping = NO;
    isWalkingLeft = NO;
    isWalkingRight = NO;
    isWalkLeftButtonSelected = NO;
    isWalkRightButtonSelected = NO;
    
    // Set Inital Value
    screenSize = [[CCDirector sharedDirector] winSize];
    checkJumpThingy = 0;
    _hud = hud;
    xVel = 0;
    yVel = 0;
    
    // Create Background
    CCSprite *background = [[CCSprite alloc] initWithFile:@"background2.png"];
    background.position = ccp(screenSize.width/2 + 10, screenSize.height/2);
    background.scaleX = 0.15;
    background.scaleY = 0.15;
    background.rotation = 90;
    [self addChild:background z:-1];
    
    // Create The Main Character
    [self createCharacter];
    
    // Create Floating Platform
    /*self.rightPlatform = [CCSprite spriteWithFile:@"reds.jpg"];
    self.rightPlatform.position = ccp(screenSize.width - 250, (self.character.position.y + self.character.contentSize.height/2 + (self.rightPlatform.contentSize.height/2)));
    self.rightPlatform.anchorPoint = ccp(0, 0.5);
    [self addChild:rightPlatform];*/
    
    // Check if player walked off platform
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(checkIfCharacterWalkedOffFloatingPlatform) userInfo:nil repeats:YES];
    
    for (int x = 0; x<=1; x+=1) {
        Enemy *theEnemy = [Enemy enemyWithFile:@"Enemy_Ship_Small.png" target:self.character winSize:screenSize];
        theEnemy.position = ccp(100, screenSize.height + theEnemy.contentSize.width);
        theEnemy.type = 1;
        [self addChild:theEnemy];
        [enemies addObject:theEnemy];
        [theEnemy performSelector:@selector(moveEnemy) withObject:theEnemy afterDelay:1];
        [theEnemy performSelector:@selector(activateScheduler) withObject:theEnemy afterDelay:1];
    }
    for (int x = 0; x<=1; x+=1) {
        Enemy *theEnemy = [Enemy enemyWithFile:@"Enemy_Ship_Small.png" target:self.character winSize:screenSize];
        theEnemy.position = ccp(screenSize.width + theEnemy.contentSize.height, screenSize.height + theEnemy.contentSize.width);
        theEnemy.type = 2;
        [self addChild:theEnemy];
        [enemies addObject:theEnemy];
        [theEnemy performSelector:@selector(moveEnemy2) withObject:theEnemy afterDelay:2];
        [theEnemy performSelector:@selector(activateScheduler) withObject:theEnemy afterDelay:2];
    }
    for (int x = 0; x<=1; x+=1) {
        Enemy *theEnemy = [Enemy enemyWithFile:@"Enemy_Ship_Small.png" target:self.character winSize:screenSize];
        theEnemy.position = ccp(100, screenSize.height + theEnemy.contentSize.width);
        theEnemy.type = 3;
        [self addChild:theEnemy];
        [enemies addObject:theEnemy];
        [theEnemy performSelector:@selector(moveEnemy3) withObject:theEnemy afterDelay:3];
        [theEnemy performSelector:@selector(activateScheduler) withObject:theEnemy afterDelay:3];
    }
}

-(id)initWithHUD:(GameHUD *)hud {
    self = [super init];
    if (self) {
        _hud = hud;
        [self generalInformation:hud];
        [self createMovementButtons];
        characterVelocity = ccp(0, 0);
        [self schedule:@selector(update:)];
        [_pauseMenu getGameInfo:self withHud:hud];
        [_pauseMenu preRenderAndShowPauseMenu];
    }
    return self;
}
#pragma mark

#pragma mark Old Methods
-(void)walkRight {
    isWalkingRight = YES;
    justMoved = YES;
    self.character.flipX = NO;
    [self.character runAction:self.walkingAnimation];
    
    CGPoint moveDistance = ccpSub(self.character.position, ccp(self.character.position.x, 0));
    characterMoveDistance = ccpLength(moveDistance);
    characterMoveDuration = characterMoveDistance/characterMoveSpeed;
    self.walkRightAction = [CCMoveBy actionWithDuration:characterMoveDuration position:ccp(0, -self.character.position.y)];
    [self.character runAction:self.walkRightAction];
}

-(void)stopWalkRight {
    isWalkingRight = NO;
    justMoved = NO;
    [self.character stopAction:self.walkingAnimation];
    [self.character stopAction:self.walkRightAction];
}

-(void)walkLeft {
    isWalkingLeft = YES;
    justMoved = YES;
    self.character.flipX = YES;
    [self.character runAction:self.walkingAnimation];
    
    CGPoint moveDistance = ccpSub(self.character.position, ccp(self.character.position.x, screenSize.height));
    characterMoveDistance = ccpLength(moveDistance);
    characterMoveDuration = characterMoveDistance/characterMoveSpeed;
    self.walkLeftAction = [CCMoveBy actionWithDuration:characterMoveDuration position:ccp(0, screenSize.height - self.character.position.y)];
    [self.character runAction:self.walkLeftAction];
}

-(void)stopWalkLeft {
    isWalkingLeft = NO;
    justMoved = NO;
    [self.character stopAction:self.walkingAnimation];
    [self.character stopAction:self.walkLeftAction];
}

-(void)determineIfCharacterWalkedOffPlatform {
    int theCharacterYCoordinate = (int) roundf(self.character.position.y);
    int theCharacterHeight = (int) roundf(self.character.contentSize.height);
    int theRightPlatformYCoordinate = (int) roundf(self.rightPlatform.position.y);
    int theRightPlatformHeight = (int) roundf(self.rightPlatform.contentSize.height);
    
    /*NSLog(@"Character Position = %f, %f", self.character.position.x, self.character.position.y);
     NSLog(@"Character Content Size = %f, %f", self.character.contentSize.width, self.character.contentSize.height);
     NSLog(@"Right Platform Position = %f, %f", self.rightPlatform.position.x, self.rightPlatform.position.y);
     NSLog(@"Right Platform Content Size = %f, %f", self.rightPlatform.contentSize.width, self.rightPlatform.contentSize.height);
     */
    
    //if ((theCharacterYCoordinate - (theCharacterHeight/2)) >= (theRightPlatformYCoordinate + (theRightPlatformHeight/2)) || (theCharacterYCoordinate - (theCharacterHeight/2)) <= (theRightPlatformYCoordinate + (theRightPlatformHeight/2) + 5)) {
    if ((theCharacterYCoordinate - (theCharacterHeight/2)) >= (theRightPlatformYCoordinate - (theRightPlatformHeight/2))) {
        if (self.character.position.x <= self.rightPlatform.position.x) {
            leftButton.isEnabled = NO;
            [self.character stopAction:self.walkLeftAction];
            if (justMoved) {
                characterWalkedOffPlatformLeft = YES;
                yVel = -0.2;
            }
        } else if (self.character.position.x >= self.rightPlatform.position.x + self.rightPlatform.contentSize.width) {
            rightButton.isEnabled = NO;
            [self.character stopAction:self.walkRightAction];
            if (justMoved) {
                characterWalkedOffPlatformRight = YES;
                yVel = -0.2;
            }
        }
    }
}

-(void)checkIfJumpedOnAPlatform {
    //NSLog(@"Character = %f, %f | Platform = %f, %f",self.character.position.x, self.character.position.y, self.rightPlatform.position.x, self.rightPlatform.position.y);
    if (self.character.position.x >= self.rightPlatform.position.x && self.character.position.x <= (self.rightPlatform.position.x + self.rightPlatform.contentSize.width)) {
        if ((int) roundf(self.character.position.y - (self.character.contentSize.height/2)) >= (int) roundf(self.rightPlatform.position.y + (self.rightPlatform.contentSize.height/2)) && (int) roundf(self.character.position.y - (self.character.contentSize.height/2)) <= (int) roundf(self.rightPlatform.position.y + (self.rightPlatform.contentSize.height/2) + 3)) {
            NSLog(@"DEBUG!!!!!");
            checkJumpThingy += 1;
            if (checkJumpThingy == 2 && jumpVector.x == 0) {
                checkJumpThingy = 0;
                [self.character stopAction:self.jumpAnimation];
                [self.character stopAction:self.jumpStandingStillAction];
                //[self.character runAction:[CCJumpBy actionWithDuration:0.01 position:ccp(0, 0) height:0 jumps:0]];
                self.character.position = ccp(self.character.position.x, self.rightPlatform.position.y + (self.character.contentSize.height/2));
            } else if (checkJumpThingy == 1 && jumpVector.x < 0) {
                NSLog(@"HELLO WORLD");
                checkJumpThingy = 0;
                [self.character stopAction:self.jumpAnimation];
                [self.character stopAction:self.jumpLeftAction];
                [self.character runAction:[CCJumpBy actionWithDuration:0.3 position:ccp(0, 0) height:0 jumps:0]];
                self.character.position = ccp(self.character.position.x, self.rightPlatform.position.y + (self.character.contentSize.height/2));
            } else if (checkJumpThingy == 1 && jumpVector.x > 0) {
                NSLog(@"HELLO WORLD 222");
                checkJumpThingy = 0;
                [self.character stopAction:self.jumpAnimation];
                [self.character stopAction:self.jumpRightAction];
                [self.character runAction:[CCJumpBy actionWithDuration:0.3 position:ccp(0, 0) height:0 jumps:0]];
                self.character.position = ccp(self.character.position.x, self.rightPlatform.position.y + (self.character.contentSize.height/2));
            }
        }
    }
}

-(void)checkIfJumpedDownAPlatform {
    if (self.character.position.y >= self.rightPlatform.position.y + 20 && self.character.position.y <= self.rightPlatform.position.y + 25) {
        if (self.character.position.x <= self.rightPlatform.position.x) {
            //if (self.character.position.y == self.rightPlatform.position.y + (self.character.contentSize.height/2)) {
            if (leftButton.isSelected && justMoved) {
                //leftButton.isEnabled = NO;
                //[self.character stopAction:self.walkLeftAction];
                [self.character runAction:[CCMoveBy actionWithDuration:0.5 position:ccp(-100, -(self.character.position.y - 25))]];
                //[self.character runAction:[CCJumpBy actionWithDuration:1 position:ccp(-100, -(self.character.position.y - 25)) height:0 jumps:1]];
            }
        }
        if (self.character.position.x >= (self.rightPlatform.position.x + self.rightPlatform.contentSize.width)) {
            if (rightButton.isSelected && justMoved) {
                //leftButton.isEnabled = NO;
                //[self.character stopAction:self.walkLeftAction];
                [self.character runAction:[CCMoveBy actionWithDuration:0.5 position:ccp(100, -(self.character.position.y - 25))]];
                //[self.character runAction:[CCJumpBy actionWithDuration:1 position:ccp(-100, -(self.character.position.y - 25)) height:0 jumps:1]];
            }
        }
    }
}

-(void) checkIfCharacterWalkedOffFloatingPlatform {
    if (characterWalkedOffPlatformLeft) {
        if (yVel <= -0.1) {
            xVel = -1.0;
            yVel -= 0.2;
        }
    }
    
    if (characterWalkedOffPlatformRight) {
        if (yVel <= -0.1) {
            xVel = 1.0;
            yVel -= 0.2;
        }
    }
    
    if ((int) roundf(self.character.position.y) <= character.boundingBox.size.height/2 + 25) {
        yVel = 0;
        xVel = 0;
        if (characterWalkedOffPlatformLeft) {
            leftButton.isEnabled = YES;
            characterWalkedOffPlatformLeft = NO;
        } else if (characterWalkedOffPlatformRight) {
            rightButton.isEnabled = YES;
            characterWalkedOffPlatformRight = NO;
        }
    }
    self.character.position = ccp(self.character.position.x + xVel, self.character.position.y + yVel);
}

-(void)jump {
    
    if (!isWalkingLeft && !isWalkingRight) {
        /*self.jumpVector = ccp(self.character.contentSize.height * 1.5, 0);
         self.characterTempPostion = self.character.position;
         self.jumpStandingStillAction = [CCJumpBy actionWithDuration:0.75 position:self.jumpVector height:(0) jumps:1];
         [self.character runAction:self.jumpAnimation];
         [self.character runAction:self.jumpStandingStillAction];
         [self schedule:@selector(checkReturnJump) interval:0.1];
         //yVel = 0;
         //xVel = -0.5;
         */
        
        //[self.character runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(disableJump2)], [CCJumpBy actionWithDuration:0.75 position:ccp(self.character.contentSize.height * 1.5, 0) height:0 jumps:1], [CCCallFuncN actionWithTarget:self selector:@selector(enableJump2)], nil]];
        
        //[character runAction:[CCSequence actions:[CCJumpBy actionWithDuration:0.75 position:self.jumpVector height:(self.character.contentSize.height * 1.5) jumps:1], [CCCallFuncN actionWithTarget:self selector:@selector(enableJump)], nil]];
    } else if (isWalkingLeft) {
        /*self.jumpVector = ccp(self.character.contentSize.height * 1.5, characterSpeed * 0.5);
         self.characterTempPostion = self.character.position;
         self.jumpLeftAction = [CCJumpBy actionWithDuration:0.5 position:self.jumpVector height:(0) jumps:1];
         [self.character runAction:self.jumpAnimation];
         [self.character runAction:self.jumpLeftAction];
         [self schedule:@selector(checkReturnJump) interval:0.1];*/
        
        
        //[self.character runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(disableJump2)], [CCJumpBy actionWithDuration:0.75 position:ccp(self.character.contentSize.height * 1.5, characterMoveSpeed * 0.5) height:1 jumps:1], [CCCallFuncN actionWithTarget:self selector:@selector(enableJump2)], nil]];
        
        [self.character runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(disableJump2)], [CCCallFuncN actionWithTarget:self selector:@selector(createLeftParabola)], [CCCallFuncN actionWithTarget:self selector:@selector(enableJump2)], nil]];
    } else if (isWalkingRight) {
        /*self.jumpVector = ccp(self.character.contentSize.height * 1.5, -characterMoveSpeed * 0.5);
         self.characterTempPostion = self.character.position;
         self.jumpRightAction = [CCJumpBy actionWithDuration:0.5 position:self.jumpVector height:(0) jumps:1];
         [self.character runAction:self.jumpAnimation];
         [self.character runAction:self.jumpRightAction];
         [self schedule:@selector(checkReturnJump) interval:0.1];*/
        
        [self.character runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(disableJump2)], [CCCallFuncN actionWithTarget:self selector:@selector(createRightParabola)], [CCCallFuncN actionWithTarget:self selector:@selector(enableJump2)], nil]];
    }
    //[character runAction:[CCJumpBy actionWithDuration:0.5 position:ccp(0, 0) height:50 jumps:1]];
    //[self.character runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(stopRightWalkAction)], [CCMoveBy actionWithDuration:0.5 position:ccp(30, 50)], [CCMoveBy actionWithDuration:0.5 position:ccp(0, -50)], [CCCallFuncN actionWithTarget:self selector:@selector(walkRight)], nil]];
}

-(void)enableJump2 {
    jumpButton.isEnabled = YES;
    isJumping = NO;
}

-(void)disableJump2 {
    jumpButton.isEnabled = NO;
    isJumping = YES;
}

-(void)checkReturnJump {
    if (self.character.position.y == self.characterTempPostion.y || self.character.position.y == self.rightPlatform.position.y + (self.character.contentSize.height/2)) {
        [self enableJump];
        [self unschedule:@selector(checkReturnJump)];
    }
}

-(void)enableJump {
    if (self.jumpVector.y < 0) {
        [self.character stopAction:self.jumpAnimation];
    } else if (self.jumpVector.y == 0) {
        [self.character stopAction:self.jumpAnimation];
    } else if (self.jumpVector.y > 0) {
        [self.character stopAction:self.jumpAnimation];
    }
    jumpButton.isEnabled = YES;
    isJumping = NO;
}

-(void)createLeftParabola {
    float sx = self.character.position.x;
    float sy = self.character.position.y;
    float ex = sx;
    float ey = sy + (characterMoveSpeed * characterMoveDuration);
    
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(sx + (self.character.contentSize.height * 1.5), sy + ((characterMoveSpeed * characterMoveDuration)/2));
    bezier.controlPoint_2 = ccp(ex, ey);
    bezier.endPosition = ccp(ex, ey);
    
    CCBezierTo *parab = [CCBezierTo actionWithDuration:0.75 bezier:bezier];
    [self.character runAction:parab];
}

-(void)createRightParabola {
    float sx = self.character.position.x;
    float sy = self.character.position.y;
    float ex = sx;
    float ey = sy - (characterMoveSpeed * characterMoveDuration);
    
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(sx + (self.character.contentSize.height * 1.5), sy - ((characterMoveSpeed * characterMoveDuration)/2));
    bezier.controlPoint_2 = ccp(sx, ey);
    bezier.endPosition = ccp(ex, ey);
    
    
    CCBezierTo *parab = [CCBezierTo actionWithDuration:0.75 bezier:bezier];
    [self.character runAction:parab];
}
#pragma mark

@end
