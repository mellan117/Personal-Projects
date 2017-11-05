//
//  TwoPlayer.m
//  Latrunculi
//
//  Created by Adam Mellan on 12/2/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "TwoPlayer.h"
#import "Play.h"


@implementation TwoPlayer


#pragma mark Scene Method
+(CCScene *)twoPlayerScene {
    CCScene *twoPlayerScene = [CCScene node];
    CCLayer *twoPlayerLayer = [TwoPlayer node];
    [twoPlayerScene addChild:twoPlayerLayer];
    return twoPlayerScene;
}
#pragma mark

#pragma mark Buttons Pressed
-(void)playButtonPressed {
    NSLog(@"Play Button Pressed");
    
    if ([playerOneTextField.text isEqual:@""]) {
        playerOneTextField.text = playerOneTextField.placeholder;
    }
    
    if ([playerTwoTextField.text isEqual:@""]) {
        playerTwoTextField.text = playerTwoTextField.placeholder;
    }
    
    [playerOneTextField removeFromSuperview];
    [playerTwoTextField removeFromSuperview];
    
    CCScene* playScene = [Play playSceneWithMode:ModeP1vsP2 withPlayerOneColor:playerOneColor andPlayerTwoColor:playerTwoColor];
    [[CCDirector sharedDirector] replaceScene:playScene];
}

-(void)backButtonPressed {
    NSLog(@"Back Button Pressed");
    
    [playerOneTextField removeFromSuperview];
    [playerTwoTextField removeFromSuperview];
    
    CCScene* gameModeScene = [GameMode gameModeSceneWithGameType:GameLatrunculi];
    [[CCDirector sharedDirector] replaceScene:gameModeScene];
}

-(void)switchColor {
    NSLog(@"Switch Color Button Pressed");
    
    if (isSwitchEnabled) {
        if ([playerOneColor isEqualToString:@"Red_Piece.png"]) {
            playerOneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Player 1" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
            playerOneTextField.textColor = [UIColor blueColor];
            playerOneColor = @"Blue_Piece.png";
            redPiece.position = ccp(0, -50);
        } else if ([playerOneColor isEqualToString:@"Blue_Piece.png"]) {
            playerOneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Player 1" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
            playerOneTextField.textColor = [UIColor redColor];
            playerOneColor = @"Red_Piece.png";
            redPiece.position = ccp(0, 50);
        }
        
        if ([playerTwoColor isEqualToString:@"Red_Piece.png"]) {
            playerTwoTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Player 2" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
            playerTwoTextField.textColor = [UIColor blueColor];
            playerTwoColor = @"Blue_Piece.png";
            bluePiece.position = ccp(0, -50);
        } else if ([playerTwoColor isEqualToString:@"Blue_Piece.png"]) {
            playerTwoTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Player 2" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
            playerTwoTextField.textColor = [UIColor redColor];
            playerTwoColor = @"Red_Piece.png";
            bluePiece.position = ccp(0, 50);
        }
        //swapMenu.rotation += 180;
        //[swapMenu runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(disableSwitch)], [CCRotateBy actionWithDuration:1 angle:180], [CCCallFuncN actionWithTarget:self selector:@selector(enableSwitch)], nil]];
    }
}

-(void)disableSwitch {
    isSwitchEnabled = NO;
}

-(void)enableSwitch {
    isSwitchEnabled = YES;
}
#pragma mark

#pragma mark Button Methods
-(void)createButtons {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Create background
    CCSprite *background = [CCSprite spriteWithFile:@"Background@2x.png"];
    background.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:background];
    
    // Creates Player Two Title
    CCLabelTTF *twoPlayerLabel = [CCLabelTTF labelWithString:@"Two Player" fontName:@"Arial Rounded MT Bold" fontSize:25];
    twoPlayerLabel.color = ccBLUE;
    twoPlayerLabel.position = ccp(screenSize.width/2 + 30, screenSize.height-30);
    [self addChild:twoPlayerLabel];
    
    // Creates Player 1 Label
    CCLabelTTF *player1Label = [CCLabelTTF labelWithString:@"Player 1" fontName:@"Arial Rounded MT Bold" fontSize:20];
    player1Label.color = ccWHITE;
    player1Label.position = ccp(screenSize.width/2-75, screenSize.height/2 + 80);
    [self addChild:player1Label];
    
    // Creates Player 2 Label
    CCLabelTTF *player2Label = [CCLabelTTF labelWithString:@"Player 2" fontName:@"Arial Rounded MT Bold" fontSize:20];
    player2Label.color = ccWHITE;
    player2Label.position = ccp(screenSize.width/2-85, screenSize.height/2 - 20);
    [self addChild:player2Label];
    
    // Creates "Play" button
    CCMenuItemFont *playButtonText = [CCMenuItemFont itemFromString:@"Play"];
    CCMenuItemToggle *playButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(playButtonPressed) items:playButtonText, nil];
    //backButtonText.fontSize = 20;
    [playButtonText setFontName:@"Marker Felt"];
    playButton.color = ccGREEN;
    playButton.position = ccp(screenSize.width/2, 50);
    
    // Creates "Back" button
    CCMenuItemFont *backButtonText = [CCMenuItemFont itemFromString:@"Back"];
    CCMenuItemToggle *backButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(backButtonPressed) items:backButtonText, nil];
    //backButtonText.fontSize = 20;
    [backButtonText setFontName:@"Marker Felt"];
    backButton.color = ccRED;
    backButton.position = ccp(50, 35);
    
    CCMenu* menu = [CCMenu menuWithItems:playButton, backButton, nil];
    menu.position = ccp(0, 0);
    [self addChild:menu];
    
    redPiece = [CCMenuItemImage itemFromNormalImage:@"Red_Piece.png" selectedImage:@"Red_Piece.png"];
    redPiece.position = ccp(0, 50);
    redPiece.scale = 1.5;
    bluePiece = [CCMenuItemImage itemFromNormalImage:@"Blue_Piece.png" selectedImage:@"Blue_Piece.png"];
    bluePiece.position = ccp(0, -50);
    bluePiece.scale = 1.5;
    
    CCMenuItemImage *switchButton2 = [CCMenuItemImage itemFromNormalImage:@"Swap_Button4.png" selectedImage:@"Swap_Button4.png" target:self selector:@selector(switchColor)];
    switchButton2.position = ccp(0, 0);
    //switchButton2.rotation = 90;
    //switchButton2.scaleX = 0.07;
    //switchButton2.scaleY = 0.07;
    switchButton2.color = ccORANGE;
    
    CCMenuItemFont *switchButtonFont = [CCMenuItemFont itemFromString:@"Switch"];
    CCMenuItemToggle *switchButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(switchColor) items:switchButtonFont, nil];
    switchButton.position = ccp(0, 0);
    
    swapMenu = [CCMenu menuWithItems:redPiece, switchButton2, bluePiece, nil];
    swapMenu.position = ccp(screenSize.width/2 + 140, screenSize.height/2 + 25);
    swapMenu.anchorPoint = ccp(0, 0);
    [self addChild:swapMenu];
    
    [self createTextFields];
    
}
#pragma mark

#pragma mark Textfield Methods
-(void)createTextFields {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    playerOneTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenSize.width/2 - 35, screenSize.height/2 - 95, 150, 30)];
    playerOneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Player 1" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
    playerOneTextField.borderStyle = UITextBorderStyleRoundedRect;
    playerOneTextField.backgroundColor = [UIColor lightGrayColor];
    playerOneTextField.textColor = [UIColor redColor];
    playerOneTextField.returnKeyType = UIReturnKeyDone;
    playerOneTextField.delegate = self;
    playerOneTextField.alpha = 0.75;
    [[[CCDirector sharedDirector] openGLView] addSubview:playerOneTextField];
    
    playerTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenSize.width/2 - 35, screenSize.height/2 + 5, 150, 30)];
    playerTwoTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Player 2" attributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    playerTwoTextField.borderStyle = UITextBorderStyleRoundedRect;
    playerTwoTextField.backgroundColor = [UIColor lightGrayColor];
    playerTwoTextField.textColor = [UIColor blueColor];
    playerTwoTextField.returnKeyType = UIReturnKeyDone;
    playerTwoTextField.delegate = self;
    playerTwoTextField.alpha = 0.75;
    [[[CCDirector sharedDirector] openGLView] addSubview:playerTwoTextField];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self.parent
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.parent
                                             selector:@selector(keyboardDidHide:)
                                                 name:@"UIKeyboardDidHideNotification"
                                               object:nil];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[[CCDirector sharedDirector] openGLView] endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [playerOneTextField resignFirstResponder];
    [playerTwoTextField resignFirstResponder];
    
    // move the view back to the origin
    CGRect frame = [[CCDirector sharedDirector] openGLView].frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [[CCDirector sharedDirector] openGLView].frame = frame;
    }];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == playerOneTextField) {
        isP2CurrentTextField = NO;
    } else if (textField == playerTwoTextField) {
        isP2CurrentTextField = YES;
        
        // move the view up by 30 pts
        CGRect frame = [[CCDirector sharedDirector] openGLView].frame;
        //CGRect frame = self.view.frame;
        frame.origin.y = -60;
        
        [UIView animateWithDuration:0.3 animations:^{
            [[CCDirector sharedDirector] openGLView].frame = frame;
        }];
    }
}

- (void) keyboardWillShow:(NSNotification *)note {
    if (isP2CurrentTextField) {
        NSDictionary *userInfo = [note userInfo];
        CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        NSLog(@"Keyboard Height: %f Width: %f", kbSize.height, kbSize.width);
    }
}

- (void) keyboardDidHide:(NSNotification *)note {
    if (isP2CurrentTextField) {
        
    }
}
#pragma mark


- (id)init
{
    self = [super init];
    if (self) {
        playerOneColor = [[NSString alloc] initWithString:@"Red_Piece.png"];
        playerTwoColor = [[NSString alloc] initWithString:@"Blue_Piece.png"];
        
        isTouchEnabled_ = YES;
        isSwitchEnabled = YES;
        isP2CurrentTextField = NO;
        
        [self createButtons];
    }
    return self;
}

@end
