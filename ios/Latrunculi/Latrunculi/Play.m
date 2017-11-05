//
//  Play.m
//  Latrunculi
//
//  Created by Adam Mellan on 2/26/14.
//  Copyright 2014 __Platinum Code__. All rights reserved.
//

#import "Play.h"
#import "Piece.h"
#import "BoardGrid.h"
#import "GameMode.h"
#import "GameHUD.h"
#import "PauseMenu.h"


#pragma mark Properties
@implementation Play
@synthesize mode;
@synthesize guideSquaresAllArray;
#pragma mark

#pragma mark Class Variables
BoardGrid *_boardGrid;
PauseMenu *_pauseMenu;
GameHUD *_hud;
#pragma mark

#pragma mark Scene Method
+(CCScene *)playSceneWithMode:(Mode)gameModeInt withPlayerOneColor:(NSString *)p1Color andPlayerTwoColor:(NSString *)p2Color {
    CCScene *playScene = [CCScene node];
    GameHUD *hud = [GameHUD node];
    [playScene addChild:hud z:3];
    
    PauseMenu *pauseMenu = [PauseMenu node];
    [playScene addChild:pauseMenu z:4];
    
    Play *layer = [[[Play alloc] initWithHUD:hud mode:gameModeInt andPlayerOneColor:p1Color andPlayerTwoColor:p2Color] autorelease];
    [playScene addChild:layer];
    
    return playScene;
}
#pragma mark

#pragma mark Update Methods
// Create Board
- (void)draw {
    // set line smoothing
    glEnable(GL_LINE_SMOOTH);
    
    // set line width
    glLineWidth(_boardGrid.thicknessOfLine);
    
    // set line color.
    glColor4f(0.0, 0.0, 0.0, 1.0);
    
    // Draw Vertical Lines
    ccDrawLine(_boardGrid.lineVerticalBottomPoint1, _boardGrid.lineVerticalTopPoint1);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint2, _boardGrid.lineVerticalTopPoint2);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint3, _boardGrid.lineVerticalTopPoint3);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint4, _boardGrid.lineVerticalTopPoint4);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint5, _boardGrid.lineVerticalTopPoint5);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint6, _boardGrid.lineVerticalTopPoint6);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint7, _boardGrid.lineVerticalTopPoint7);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint8, _boardGrid.lineVerticalTopPoint8);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint9, _boardGrid.lineVerticalTopPoint9);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint10, _boardGrid.lineVerticalTopPoint10);
    ccDrawLine(_boardGrid.lineVerticalBottomPoint11, _boardGrid.lineVerticalTopPoint11);
    
    // Draw Horizontal Lines
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint1, _boardGrid.lineHorizontalRightPoint1);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint2, _boardGrid.lineHorizontalRightPoint2);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint3, _boardGrid.lineHorizontalRightPoint3);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint4, _boardGrid.lineHorizontalRightPoint4);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint5, _boardGrid.lineHorizontalRightPoint5);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint6, _boardGrid.lineHorizontalRightPoint6);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint7, _boardGrid.lineHorizontalRightPoint7);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint8, _boardGrid.lineHorizontalRightPoint8);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint9, _boardGrid.lineHorizontalRightPoint9);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint10, _boardGrid.lineHorizontalRightPoint10);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint11, _boardGrid.lineHorizontalRightPoint11);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint12, _boardGrid.lineHorizontalRightPoint12);
    ccDrawLine(_boardGrid.lineHorizontalLeftPoint13, _boardGrid.lineHorizontalRightPoint13);
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
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
    
    // Minimum length of the swipe
    float swipeLength = ccpDistance(firstTouch, lastTouch);
    float deltaX = abs(firstTouch.x - lastTouch.x);
    float deltaY = abs(firstTouch.y - lastTouch.y);
    
    // Check if the swipe is a vertical swipe and is long enough
    if (deltaX < 60) {
        if ((firstTouch.y > lastTouch.y && swipeLength > 60) || (firstTouch.y < lastTouch.y && swipeLength > 60)) {
            // Pause the play scene
            if (!_pauseMenu.disablePause) {
                [_pauseMenu pause];
            }
        }
    }
    
    // Determine the center of the square the user touched
    if (![[CCDirector sharedDirector] isPaused]) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [self convertTouchToNodeSpace:touch];
        if (!pieceSelected.isAI) {
            [self determineCenterOfSquareThatUserTouched:location];
        }
    }
}
#pragma mark

#pragma mark Add Pieces
// Add player one's pieces
-(void)addPlayerOnePiecesWithAI:(BOOL)isAI {
    NSLog(@"Player One's pieces have been added");
    
    CGPoint originSquareCenter;
    CGPoint centerForFrontRow;
    CGPoint centerForBackRow;
    
    // Setting the center of the origin square
    originSquareCenter = [self determineOriginSquare];
    
    // Setting the center of front row and back row
    centerForFrontRow = ccp(originSquareCenter.x + (2*widthOfSquare), originSquareCenter.y);
    centerForBackRow = ccp(originSquareCenter.x + widthOfSquare, originSquareCenter.y);
    
    // Add player one's eagle to the front row
    eaglePlayerOne = [Piece eaglePieceWithColor:playerOneColor withAI:isAI];
    eaglePlayerOne.isPlayer = 1;
    eaglePlayerOne.modelNumber = 0;
    eaglePlayerOne.opacity = 75;
    eaglePlayerOne.position = ccp(centerForFrontRow.x, centerForFrontRow.y + (5*heightOfSquare));
    [self addChild:eaglePlayerOne];
    [playerOnePieces addObject:eaglePlayerOne];
    [pieces addObject:eaglePlayerOne];
    
    // Add player one's pawns to the back row
    for (int x = 1; x <= 12; x+=1) {
        Piece *pawnPlayerOne = [Piece pawnPieceWithColor:playerOneColor withAI:isAI];
        pawnPlayerOne.isPlayer = 1;
        pawnPlayerOne.modelNumber = x;
        pawnPlayerOne.position = ccp(centerForBackRow.x, centerForBackRow.y);
        pawnPlayerOne.positionTemp = ccp(centerForBackRow.x, centerForBackRow.y);
        if (isPlayerOneAI) {
            pawnPlayerOne.isAI = YES;
        } else {
            pawnPlayerOne.isAI = NO;
        }
        [self addChild:pawnPlayerOne];
        [playerOnePieces addObject:pawnPlayerOne];
        [pieces addObject:pawnPlayerOne];
        
        centerForBackRow.y += (heightOfSquare);
    }
}

// Add player two's pieces
-(void)addPlayerTwoPiecesWithAI:(BOOL)isAI {
    NSLog(@"Player Two's pieces have been added");
    
    CGPoint originSquareCenter;
    CGPoint centerForFrontRow;
    CGPoint centerForBackRow;
    
    // Setting the center of the origin square
    originSquareCenter = [self determineOriginSquare];
    
    // Setting the center of front row and back row
    centerForFrontRow = ccp(originSquareCenter.x + (7 * widthOfSquare), originSquareCenter.y);
    centerForBackRow = ccp(originSquareCenter.x + (8 * widthOfSquare), originSquareCenter.y);
    
    // Add player two's eagle to the front row
    eaglePlayerTwo = [Piece eaglePieceWithColor:playerTwoColor withAI:isAI];
    eaglePlayerTwo.isPlayer = 2;
    eaglePlayerTwo.modelNumber = 0;
    eaglePlayerTwo.opacity = 75;
    eaglePlayerTwo.position = ccp(centerForFrontRow.x, centerForFrontRow.y + (6*heightOfSquare));
    [self addChild:eaglePlayerTwo];
    [playerTwoPieces addObject:eaglePlayerTwo];
    [pieces addObject:eaglePlayerTwo];
    
    // Add player two's pawns to the back row
    for (int x = 1; x <= 12; x+=1) {
        Piece *pawnPlayerTwo = [Piece pawnPieceWithColor:playerTwoColor withAI:isAI];
        pawnPlayerTwo.isPlayer = 2;
        pawnPlayerTwo.modelNumber = x;
        pawnPlayerTwo.position = ccp(centerForBackRow.x, centerForBackRow.y);
        pawnPlayerTwo.positionTemp = ccp(centerForBackRow.x, centerForBackRow.y);
        if (isPlayerTwoAI) {
            pawnPlayerTwo.isAI = YES;
        } else {
            pawnPlayerTwo.isAI = NO;
        }
        [self addChild:pawnPlayerTwo];
        [playerTwoPieces addObject:pawnPlayerTwo];
        [pieces addObject:pawnPlayerTwo];
        
        centerForBackRow.y += (heightOfSquare);
    }
}
#pragma mark

#pragma mark Check if User...
// Check the game mode
-(void)checkGameMode {
    if (self.mode == ModeP1vsCPU) {
        // P1 vs CPU2
        isPlayerOneAI = NO;
        isPlayerTwoAI = YES;
        
        isPlayerOneTurn = YES;
        isPlayerTwoTurn = NO;
        
        [self addPlayerOnePiecesWithAI:isPlayerOneAI];
        [self addPlayerTwoPiecesWithAI:isPlayerTwoAI];
        isPieceMoving = NO;
        didUserMove = NO;
        [self checkTurn2];
    } else if (self.mode == ModeP1vsP2) {
        // P1 vs P2
        isPlayerOneAI = NO;
        isPlayerTwoAI = NO;
        
        isPlayerOneTurn = YES;
        isPlayerTwoTurn = NO;
        
        [self addPlayerOnePiecesWithAI:isPlayerOneAI];
        [self addPlayerTwoPiecesWithAI:isPlayerTwoAI];
        isPieceMoving = NO;
        didUserMove = NO;
        [self checkTurn2];
    } else if (self.mode == ModeCPU1vsCPU2) {
        // CPU1 vs CPU2
        isPlayerOneAI = YES;
        isPlayerTwoAI = YES;
        
        isPlayerOneTurn = YES;
        isPlayerTwoTurn = NO;
        
        [self addPlayerOnePiecesWithAI:isPlayerOneAI];
        [self addPlayerTwoPiecesWithAI:isPlayerTwoAI];
        isPieceMoving = NO;
        [self checkTurn2];
        //[self schedule:@selector(checkTurn) interval:2];
    }
}

// Check if user selected a piece
-(BOOL)checkIfUserSelectedAPiece:(Piece *)piece withTouch:(CGPoint)touchLocation {
    if (piece.position.x == touchLocation.x && piece.position.y == touchLocation.y) {
        
        // Check whose turn it is
        if (isPlayerOneTurn && piece.isPlayer == 1) {
            isPieceSelected = YES;
            pieceSelected = piece;
            pieceSelected.scale = 2;
            [self determineGuideSquares:pieceSelected];
            
            return YES;
        } else if (isPlayerTwoTurn && piece.isPlayer == 2) {
            isPieceSelected = YES;
            pieceSelected = piece;
            pieceSelected.scale = 2;
            [self determineGuideSquares:pieceSelected];
            
            return YES;
        }
    }
    
    return NO;
}

// Check if user touched a square 90˚
-(BOOL)checkIfUserTouchedSquare90Degrees:(CGPoint)touchLocation {
    // Check if user can move up
    if (pieceSelected.canMoveUp) {
        if (pieceSelected.position.x == touchLocation.x && touchLocation.y >= pieceSelected.position.y) {
            return YES;
        }
    }
    
    // Check if user can move down
    if (pieceSelected.canMoveDown) {
        if (pieceSelected.position.x == touchLocation.x && touchLocation.y <= pieceSelected.position.y) {
            return YES;
        }
    }
    
    // Check if user can move left
    if (pieceSelected.canMoveLeft) {
        if (pieceSelected.position.y == touchLocation.y && touchLocation.x <= pieceSelected.position.x) {
            return YES;
        }
    }
    
    // Check if user can move right
    if (pieceSelected.canMoveRight) {
        if (pieceSelected.position.y == touchLocation.y && touchLocation.x >= pieceSelected.position.x) {
            return YES;
        }
    }
    
    return NO;
}

// Check if user touched a square diagonally
-(BOOL)checkIfUserTouchedSquareDiagonally:(CGPoint)touchLocation {
    int squaresAwayWidth;
    int squaresAwayHeight;
    int squaresAway;
    
    // Determine how many diagonal spaces the selected piece could potentially go
    if (10 - (pieceSelected.position.x / widthOfSquare) >= pieceSelected.position.x / widthOfSquare) {
        squaresAwayWidth = 10 - (pieceSelected.position.x / widthOfSquare);
    } else (squaresAwayWidth = pieceSelected.position.x / widthOfSquare);
    
    if (12 - (pieceSelected.position.y / heightOfSquare) >= pieceSelected.position.y / heightOfSquare) {
        squaresAwayHeight = 12 - (pieceSelected.position.y / heightOfSquare);
    } else (squaresAwayHeight = pieceSelected.position.y / heightOfSquare);
    
    if (squaresAwayWidth >= squaresAwayHeight) {
        squaresAway = squaresAwayWidth;
    } else (squaresAway = squaresAwayHeight);
    
    // Check if user selected a space the is up | left
    if (pieceSelected.canMoveUpLeft) {
        for (int squaresUpLeft = 1; squaresUpLeft <= squaresAway; squaresUpLeft += 1) {
            if (touchLocation.x == pieceSelected.position.x - squaresUpLeft*widthOfSquare && touchLocation.y == pieceSelected.position.y + squaresUpLeft*heightOfSquare) {
                
                return YES;
            }
        }
    }
    
    // Check if user selected a space the is up | right
    if (pieceSelected.canMoveUpRight) {
        for (int squaresUpRight = 1; squaresUpRight <= squaresAway; squaresUpRight += 1) {
            if (touchLocation.x == pieceSelected.position.x + squaresUpRight*widthOfSquare && touchLocation.y == pieceSelected.position.y + squaresUpRight*heightOfSquare) {
                
                return YES;
            }
        }
    }
    
    // Check if user selected a space the is down | left
    if (pieceSelected.canMoveDownLeft) {
        for (int squaresDownLeft = 1; squaresDownLeft <= squaresAway; squaresDownLeft += 1) {
            if (touchLocation.x == pieceSelected.position.x - squaresDownLeft*widthOfSquare && touchLocation.y == pieceSelected.position.y - squaresDownLeft*heightOfSquare) {
                
                return YES;
            }
        }
    }
    
    // Check if user selected a space the is down | right
    if (pieceSelected.canMoveDownRight) {
        for (int squaresDownRight = 1; squaresDownRight <= squaresAway; squaresDownRight += 1) {
            if (touchLocation.x == pieceSelected.position.x + squaresDownRight*widthOfSquare && touchLocation.y == pieceSelected.position.y - squaresDownRight*heightOfSquare) {
                
                return YES;
            }
        }
    }
    
    return NO;
}

// Check if user touched an occupied square
-(BOOL)checkIfUserTouchedAnOccupiedSquare:(Piece *)piece withTouch:(CGPoint)touchLocation {
    if (piece.position.x == touchLocation.x && piece.position.y == touchLocation.y) {
        return YES;
    }
    
    return NO;
}

// Check if user jumped a piece by calling 2 seperate methods
-(BOOL)checkIfUserJumpedAPiece:(Piece *)piece withTouch:(CGPoint)touchLocation {
    if ([self checkIfUserJumpedLeftToRight:piece withTouch:touchLocation] && !pieceSelected.canJumpPieceHorizontally) {
        return YES;
    }
    
    if ([self checkIfUserJumpedUptoDown:piece withTouch:touchLocation] && !pieceSelected.canJumpPieceVertically) {
        return YES;
    }
    
    return NO;
}

// Check if user jumped a piece vertically
-(BOOL)checkIfUserJumpedUptoDown:(Piece *)piece withTouch:(CGPoint)touchLocation {
    if (piece.position.x == touchLocation.x) {
        if (piece.position.y > pieceSelected.position.y && touchLocation.y > piece.position.y) {
            return YES;
        } else if (piece.position.y < pieceSelected.position.y && touchLocation.y < piece.position.y) {
            return YES;
        }
    }
    
    return NO;
}

// Check if user jumped a piece horizontally
-(BOOL)checkIfUserJumpedLeftToRight:(Piece *)piece withTouch:(CGPoint)touchLocation {
    if (piece.position.y == touchLocation.y) {
        if (piece.position.x > pieceSelected.position.x && piece.position.x < touchLocation.x) {
            return YES;
        } else if (piece.position.x < pieceSelected.position.x && piece.position.x > touchLocation.x) {
            return YES;
        }
    }
    
    return NO;
}

// Check if user put himself in danger, aka in between 2 enemy pieces
-(BOOL)checkIfUserPutHimselfInDanger:(Piece *)differentPiece withTouch:(CGPoint)touchLocation {
    if (!pieceSelected.canPutSelfInDanger) {
        if (pieceSelected.isPlayer != differentPiece.isPlayer) {
            // Check vertically
            if (differentPiece.position.x == touchLocation.x && differentPiece.position.y == touchLocation.y + heightOfSquare) {
                for (Piece *anotherDifferentPiece in pieces) {
                    if (differentPiece.isPlayer == anotherDifferentPiece.isPlayer) {
                        if (anotherDifferentPiece.position.x == touchLocation.x && anotherDifferentPiece.position.y == touchLocation.y - heightOfSquare) {
                            return YES;
                        }
                    }
                }
            }
            // Check horizontally
            if (differentPiece.position.y == touchLocation.y && differentPiece.position.x == touchLocation.x + widthOfSquare) {
                for (Piece *anotherDifferentPiece in pieces) {
                    if (differentPiece.isPlayer == anotherDifferentPiece.isPlayer) {
                        if (anotherDifferentPiece.position.y == touchLocation.y && anotherDifferentPiece.position.x == touchLocation.x - widthOfSquare) {
                            return YES;
                        }
                    }
                }
            }
        }
    }
    
    return NO;
}

// Check Rules
-(BOOL)checkRules:(CGPoint)touchLocation {
    BOOL didMove = NO;
    
    for (Piece *piece in pieces) {
        if (isPieceSelected) {
            // Check if user touched a square 90˚
            if (![self checkIfUserTouchedSquare90Degrees:touchLocation]) {
                
                // Check if user touched a square diagonally
                if (![self checkIfUserTouchedSquareDiagonally:touchLocation]) {
                    if (!isGuideSquares) {
                        [self deselectPiece];
                    }
                    didMove = NO;
                    
                    break;
                }
            }
            
            // Check if user touched the player 1 origin square (1st square) or the player 2 origin square (last square)
            if (touchLocation.x == widthOfSquare/2 || touchLocation.x == (9*widthOfSquare) + (widthOfSquare/2)) {
                if (!isGuideSquares) {
                    [self deselectPiece];
                }
                didMove = NO;
                
                break;
            }
            
            // Check if user touched an occupied square
            if ([self checkIfUserTouchedAnOccupiedSquare:piece withTouch:touchLocation]) {
                if (!isGuideSquares) {
                    [self deselectPiece];
                }
                didMove = NO;
                
                break;
            }
            
            // Check if user jumped a piece
            if ([self checkIfUserJumpedAPiece:piece withTouch:touchLocation]) {
                if (!isGuideSquares) {
                    [self deselectPiece];
                }
                didMove = NO;
                
                break;
            }
            
            // Check if user put himself in danger, or in between 2 enemy pieces
            if ([self checkIfUserPutHimselfInDanger:piece withTouch:touchLocation]) {
                if (!isGuideSquares) {
                    [self deselectPiece];
                }
                didMove = NO;
                
                break;
            }
            //NSLog(@"2 : isPieceMoving = %d | isPlayerOneTurn = %d | isPlayerTwoTurn = %d | didUserMove = %d | isGuideSquares = %d",isPieceMoving, isPlayerOneTurn, isPlayerTwoTurn, didUserMove, isGuideSquares);
            // If user passed all rules then...
            // move selected piece to touch location
            if ([pieces indexOfObject:piece] == [pieces indexOfObject:[pieces lastObject]]) {
                /*if (!pieceSelected.isAI && !isGuideSquares) {
                    NSLog(@"Passed Rules");
                    [self movePieceIfRulesPassed:touchLocation];
                }*/
                didMove = YES;
            }
        }
    }
    
    return didMove;
}

// Move piece if rules passed
-(void)movePieceIfRulesPassed:(CGPoint)toLocation {
    NSLog(@"Moving Piece");
    //didUserMove = YES;
    NSLog(@"2 : isPieceMoving = %d | isPlayerOneTurn = %d | isPlayerTwoTurn = %d | didUserMove = %d | isGuideSquares = %d",isPieceMoving, isPlayerOneTurn, isPlayerTwoTurn, didUserMove, isGuideSquares);
    [pieceSelected runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(disablePlayerAbilityToMove)], [CCMoveTo actionWithDuration:1 position:toLocation], [CCCallFuncN actionWithTarget:self selector:@selector(checkIfAPlayerCapturedAPiece2)], [CCCallFuncN actionWithTarget:self selector:@selector(enableUserAbilityToMove)], [CCCallFuncN actionWithTarget:self selector:@selector(checkTurn2)], nil]];
    NSLog(@"3 : isPieceMoving = %d | isPlayerOneTurn = %d | isPlayerTwoTurn = %d | didUserMove = %d | isGuideSquares = %d",isPieceMoving, isPlayerOneTurn, isPlayerTwoTurn, didUserMove, isGuideSquares);
    
    pieceSelected.scale = 1;
    
    //pieceSelected.position = ccp(toLocation.x, toLocation.y);
    //[self checkIfAPlayerCapturedAPiece2];
}

// New Capture Detection Function
-(void)checkIfAPlayerCapturedAPiece2 {
    BOOL deleteAPiece = NO;
    Piece *removePiece;
    
    // New function idea for all pieces
    for (Piece *differentPiece in pieces) {
        if (pieceSelected.isPlayer != differentPiece.isPlayer) {
            if (pieceSelected.position.x == differentPiece.position.x) {
                // Check when selected piece moves under a potential capturee
                if (pieceSelected.position.y == differentPiece.position.y + heightOfSquare) {
                    for (Piece *likePiece in pieces) {
                        if (pieceSelected.isPlayer == likePiece.isPlayer) {
                            if (pieceSelected.position.y == likePiece.position.y + 2*heightOfSquare && pieceSelected.position.x == likePiece.position.x) {
                                //NSLog(@"DELETE THE PIECE 1");
                                deleteAPiece = YES;
                                removePiece = differentPiece;
                                goto outerMostForLoop;
                            }
                        }
                    }
                }
                // Check when selected piece moves above a potential capturee
                if (pieceSelected.position.y == differentPiece.position.y - heightOfSquare) {
                    for (Piece *likePiece in pieces) {
                        if (pieceSelected.isPlayer == likePiece.isPlayer) {
                            if (pieceSelected.position.y == likePiece.position.y - 2*heightOfSquare && pieceSelected.position.x == likePiece.position.x) {
                                //NSLog(@"DELETE THE PIECE 2");
                                deleteAPiece = YES;
                                removePiece = differentPiece;
                                goto outerMostForLoop;
                            }
                        }
                    }
                }
            }
            // Check when selected piece moves left of a potential capturee
            if (pieceSelected.position.y == differentPiece.position.y) {
                if (pieceSelected.position.x == differentPiece.position.x + widthOfSquare) {
                    for (Piece *likePiece in pieces) {
                        if (pieceSelected.isPlayer == likePiece.isPlayer) {
                            if (pieceSelected.position.x == likePiece.position.x + 2*widthOfSquare && pieceSelected.position.y == likePiece.position.y) {
                                //NSLog(@"DELETE THE PIECE 3");
                                deleteAPiece = YES;
                                removePiece = differentPiece;
                                goto outerMostForLoop;
                            }
                        }
                    }
                }
                // Check when selected piece moves right of a potential capturee
                if (pieceSelected.position.x == differentPiece.position.x - widthOfSquare) {
                    for (Piece *likePiece in pieces) {
                        if (pieceSelected.isPlayer == likePiece.isPlayer) {
                            if (pieceSelected.position.x == likePiece.position.x - 2*widthOfSquare && pieceSelected.position.y == likePiece.position.y) {
                                //NSLog(@"DELETE THE PIECE 4");
                                deleteAPiece = YES;
                                removePiece = differentPiece;
                                goto outerMostForLoop;
                            }
                        }
                    }
                }
            }
        }
    }outerMostForLoop:;
    
    // Delete Captured Piece
    if (deleteAPiece) {
        [self deletePiece:removePiece];
        deleteAPiece = NO;
        removePiece = nil;
    }
    
    // Deselct the selected piece
    [self deselectPiece];
}

/*
// Original Capture Detection
-(void)checkIfAPlayerCapturedAPiece {
    for (Piece *player1 in playerOnePieces) {
        for (Piece *player2 in playerTwoPieces) {
            
            // Capture Detection for Player 1
            if (pieceSelected.isPlayer == player1.isPlayer) {
                if (pieceSelected.position.x == player2.position.x) {
                    if (pieceSelected.position.y == player2.position.y + heightOfSquare) {
                        if (pieceSelected.position.y == player1.position.y + 2*heightOfSquare && pieceSelected.position.x == player1.position.x) {
                            NSLog(@"DELETE THE PIECE 1");
                            [self deletePiece:player2];
                            goto outerMostForLoop;
                        }
                    }
                    if (pieceSelected.position.y == player2.position.y - heightOfSquare) {
                        if (pieceSelected.position.y == player1.position.y - 2*heightOfSquare && pieceSelected.position.x == player1.position.x) {
                            NSLog(@"DELETE THE PIECE 2");
                            [self deletePiece:player2];
                            goto outerMostForLoop;
                        }
                    }
                }
                if (pieceSelected.position.y == player2.position.y) {
                    if (pieceSelected.position.x == player2.position.x + widthOfSquare) {
                        if (pieceSelected.position.x == player1.position.x + 2*widthOfSquare && pieceSelected.position.y == player1.position.y) {
                            NSLog(@"DELETE THE PIECE 3");
                            [self deletePiece:player2];
                            goto outerMostForLoop;
                        }
                    }
                    if (pieceSelected.position.x == player2.position.x - widthOfSquare) {
                        if (pieceSelected.position.x == player1.position.x - 2*widthOfSquare && pieceSelected.position.y == player1.position.y) {
                            NSLog(@"DELETE THE PIECE 4");
                            [self deletePiece:player2];
                            goto outerMostForLoop;
                        }
                    }
                }
            }
            
            // Capture Detection for Player 2
            if (pieceSelected.isPlayer == player2.isPlayer) {
                if (pieceSelected.position.x == player1.position.x) {
                    if (pieceSelected.position.y == player1.position.y + heightOfSquare) {
                        if (pieceSelected.position.y == player2.position.y + 2*heightOfSquare && pieceSelected.position.x == player2.position.x) {
                            NSLog(@"DELETE THE PIECE 1");
                            [self deletePiece:player1];
                            goto outerMostForLoop;
                        }
                    }
                    if (pieceSelected.position.y == player1.position.y - heightOfSquare) {
                        if (pieceSelected.position.y == player2.position.y - 2*heightOfSquare && pieceSelected.position.x == player2.position.x) {
                            NSLog(@"DELETE THE PIECE 2");
                            [self deletePiece:player1];
                            goto outerMostForLoop;
                        }
                    }
                }
                if (pieceSelected.position.y == player1.position.y) {
                    if (pieceSelected.position.x == player1.position.x + widthOfSquare) {
                        if (pieceSelected.position.x == player2.position.x + 2*widthOfSquare && pieceSelected.position.y == player2.position.y) {
                            NSLog(@"DELETE THE PIECE 3");
                            [self deletePiece:player1];
                            goto outerMostForLoop;
                        }
                    }
                    if (pieceSelected.position.x == player1.position.x - widthOfSquare) {
                        if (pieceSelected.position.x == player2.position.x - 2*widthOfSquare && pieceSelected.position.y == player2.position.y) {
                            NSLog(@"DELETE THE PIECE 4");
                            [self deletePiece:player1];
                            goto outerMostForLoop;
                        }
                    }
                }
            }
            
        }
        
        // Capture Detection for ai pieces
        for (Piece *aiPiece in aiPieces) {
            if (pieceSelected.position.x == player1.position.x) {
                if (pieceSelected.position.y == player1.position.y + heightOfSquare) {
                    if (pieceSelected.position.y == aiPiece.position.y + 2*heightOfSquare && pieceSelected.position.x == aiPiece.position.x) {
                        NSLog(@"DELETE THE PIECE 1");
                        [self deletePiece:player1];
                        goto outerMostForLoop;
                    }
                }
                if (pieceSelected.position.y == player1.position.y - heightOfSquare) {
                    if (pieceSelected.position.y == aiPiece.position.y - 2*heightOfSquare && pieceSelected.position.x == aiPiece.position.x) {
                        NSLog(@"DELETE THE PIECE 2");
                        [self deletePiece:player1];
                        goto outerMostForLoop;
                    }
                }
            }
            if (pieceSelected.position.y == player1.position.y) {
                if (pieceSelected.position.x == player1.position.x + widthOfSquare) {
                    if (pieceSelected.position.x == aiPiece.position.x + 2*widthOfSquare && pieceSelected.position.y == aiPiece.position.y) {
                        NSLog(@"DELETE THE PIECE 3");
                        [self deletePiece:player1];
                        goto outerMostForLoop;
                    }
                }
                if (pieceSelected.position.x == player1.position.x - widthOfSquare) {
                    if (pieceSelected.position.x == aiPiece.position.x - 2*widthOfSquare && pieceSelected.position.y == aiPiece.position.y) {
                        NSLog(@"DELETE THE PIECE 4");
                        [self deletePiece:player1];
                        goto outerMostForLoop;
                    }
                }
            }
        }
        
    }outerMostForLoop:;
}*/

-(void)checkTurn2 {
    NSLog(@"1 : isPieceMoving = %d | isPlayerOneTurn = %d | isPlayerTwoTurn = %d | didUserMove = %d | isGuideSquares = %d",isPieceMoving, isPlayerOneTurn, isPlayerTwoTurn, didUserMove, isGuideSquares);
    if (isPlayerOneAI && isPlayerTwoAI) {
        if (isPlayerOneTurn) {
            if (!isPieceMoving) {
                [self createTheoreticalGameTree];
                isPlayerOneTurn = NO;
                isPlayerTwoTurn = YES;
            }
            //[self checkTurn2];
        } else if (isPlayerTwoTurn) {
            if (!isPieceMoving) {
                [self createTheoreticalGameTree];
                isPlayerOneTurn = YES;
                isPlayerTwoTurn = NO;
            }
            //[self checkTurn2];
        }
    } else if (isPlayerOneAI || isPlayerTwoAI) {
        //NSLog(@"1 : isPieceMoving = %d | isPlayerOneTurn = %d | isPlayerTwoTurn = %d | didUserMove = %d | isGuideSquares = %d",isPieceMoving, isPlayerOneTurn, isPlayerTwoTurn, didUserMove, isGuideSquares);
        if (isPlayerOneTurn) {
            if (!isPieceMoving) {
                if (isPlayerOneAI) {
                    [self createTheoreticalGameTree];
                    isPlayerOneTurn = NO;
                    isPlayerTwoTurn = YES;
                } else if (!isPlayerOneAI) {
                    if (didUserMove) {
                        isPlayerOneTurn = NO;
                        isPlayerTwoTurn = YES;
                        didUserMove = NO;
                        [self checkTurn2];
                    } else if (!didUserMove) {
                        isGuideSquares = NO;
                    }
                }
            }
        } else if (isPlayerTwoTurn) {
            if (!isPieceMoving) {
                if (isPlayerTwoAI) {
                    [self createTheoreticalGameTree];
                    isPlayerOneTurn = YES;
                    isPlayerTwoTurn = NO;
                } else if (!isPlayerTwoAI) {
                    if (didUserMove) {
                        isPlayerOneTurn = YES;
                        isPlayerTwoTurn = NO;
                        didUserMove = NO;
                        [self checkTurn2];
                    } else if (!didUserMove) {
                        isGuideSquares = NO;
                    }
                }
            }
        }
    } else if (!isPlayerOneAI && !isPlayerTwoAI) {
        //NSLog(@"1 : isPieceMoving = %d | isPlayerOneTurn = %d | isPlayerTwoTurn = %d | didUserMove = %d | isGuideSquares = %d",isPieceMoving, isPlayerOneTurn, isPlayerTwoTurn, didUserMove, isGuideSquares);
        if (!isPieceMoving) {
            if (isPlayerOneTurn) {
                if (didUserMove) {
                    isPlayerOneTurn = NO;
                    isPlayerTwoTurn = YES;
                    didUserMove = NO;
                } else if (!didUserMove) {
                    isGuideSquares = NO;
                }
            } else if (isPlayerTwoTurn) {
                if (didUserMove) {
                    isPlayerOneTurn = YES;
                    isPlayerTwoTurn = NO;
                    didUserMove = NO;
                } else if (!didUserMove) {
                    isGuideSquares = NO;
                }
            }
        }
    }
    
    
}

-(void)checkTurn {
    if (!isPieceMoving) {
        // Check if it's player 1's turn
        if (isPlayerOneTurn) {
            // Check if player 1 is an ai
            if (isPlayerOneAI) {
                [self createTheoreticalGameTree];
                isPlayerOneTurn = NO;
                isPlayerTwoTurn = YES;
                // Check if player 1 is a user
            } else if (!isPlayerOneAI) {
                if (!didUserMove) {
                    // If user did NOT move
                    isGuideSquares = NO;
                    [self checkRules:theLocation];
                } else if (didUserMove) {
                    // If user moved
                    isPlayerOneTurn = NO;
                    isPlayerTwoTurn = YES;
                    didUserMove = NO;
                    
                    // Check if opponet is an ai
                    if (isPlayerTwoAI) {
                        [self checkTurn];
                    }
                }
                // Old method
                /*if ([self checkRules:theLocation]) {
                 isPlayerOneTurn = NO;
                 isPlayerTwoTurn = YES;
                 if (isPlayerTwoAI) {
                 [self checkTurn];
                 }
                 }*/
            }
            // Check if it's player 2's turn
        } else if (isPlayerTwoTurn) {
            // Check if player 2 is an ai
            if (isPlayerTwoAI) {
                [self createTheoreticalGameTree];
                isPlayerOneTurn = YES;
                isPlayerTwoTurn = NO;
                // Check if player 2 is a user
            } else if (!isPlayerTwoAI) {
                if (!didUserMove) {
                    // If user did NOT move
                    isGuideSquares = NO;
                    [self checkRules:theLocation];
                } else if (didUserMove) {
                    // If user moved
                    isPlayerOneTurn = YES;
                    isPlayerTwoTurn = NO;
                    didUserMove = NO;
                    
                    // Check if opponent is an ai
                    if (isPlayerOneAI) {
                        [self checkTurn];
                    }
                }
                // Old method
                /*if ([self checkRules:theLocation]) {
                 isPlayerOneTurn = YES;
                 isPlayerTwoTurn = NO;
                 if (isPlayerOneAI) {
                 [self checkTurn];
                 }
                 }*/
            }
        }
    }
}
#pragma mark

#pragma mark Enable & Disable Methods
// Pause the play scene
-(void)pausePlayScene {
    [[CCDirector sharedDirector] pause];
}

// Resume the play scene
-(void)resumePlayScene {
    [[CCDirector sharedDirector] resume];
}

// If a piece is NOT currently moving, this function WILL allow the next USER to take their turn
-(void)enableUserAbilityToMove {
    didUserMove = YES;
    isPieceMoving = NO;
}

// If a piece is NOT currently moving, this function WILL allow the next AI to take their turn
-(void)enableAiAbilityToMove {
    //didUserMove = YES;
    isPieceMoving = NO;
}

// If a piece IS currently moving, this function WILL NOT allow the next player to take their turn
-(void)disablePlayerAbilityToMove {
    didUserMove = NO;
    isPieceMoving = YES;
}
#pragma mark

#pragma mark Deselect or Delete Piece
// Deselect the piece
-(void)deselectPiece {
    if (![[CCDirector sharedDirector] isPaused]) {
        [self removeGuideSquares:pieceSelected];
        isPieceSelected = NO;
        pieceSelected.scale = 1;
        
        pieceSelected = nil;
    }
}

// Delete a captured piece
-(void)deletePiece:(Piece *)capturedPiece {
    if (capturedPiece.isPawn) {
        if (capturedPiece.isPlayer == 1) {
            NSLog(@"Deleted P1's Piece");
            [self removeChild:capturedPiece cleanup:YES];
            [playerOnePieces removeObject:capturedPiece];
            [pieces removeObject:capturedPiece];
            
            numberOfRemainingPlayerOnePiecesInt -= 1;
            p1BoardNumberOfRemainingPlayerOnePiecesLabel.string = [NSString stringWithFormat:@"%d",numberOfRemainingPlayerOnePiecesInt];
            p2BoardNumberOfRemainingPlayerOnePiecesLabel.string = [NSString stringWithFormat:@"%d",numberOfRemainingPlayerOnePiecesInt];
        }else if (capturedPiece.isPlayer == 2) {
            NSLog(@"Deleted P2's Piece");
            [self removeChild:capturedPiece cleanup:YES];
            [playerTwoPieces removeObject:capturedPiece];
            [pieces removeObject:capturedPiece];
            
            numberOfRemainingPlayerTwoPiecesInt -= 1;
            p1BoardNumberOfRemainingPlayerTwoPiecesLabel.string = [NSString stringWithFormat:@"%d",numberOfRemainingPlayerTwoPiecesInt];
            p2BoardNumberOfRemainingPlayerTwoPiecesLabel.string = [NSString stringWithFormat:@"%d",numberOfRemainingPlayerTwoPiecesInt];
        }
    }
}
#pragma mark

#pragma mark Other
-(void)determineGuideSquares:(Piece *)selectedPiece {
    NSMutableArray *newArray;
    NSMutableArray *opponentArray;
    NSMutableArray *allPiecesArray;
    
    tempGuideLinesPieceLocation = ccp(-1, -1);
    
    numberOfGuideSquaresRight = 80;
    numberOfGuideSquaresLeft = 80;
    numberOfGuideSquaresUp = 80;
    numberOfGuideSquaresDown = 80;
    
    numberOfGuideSquaresUpRight = 80;
    numberOfGuideSquaresUpLeft = 80;
    numberOfGuideSquaresDownRight = 80;
    numberOfGuideSquaresDownLeft = 80;
    
    // Check what team the selected piece belongs to
    if (selectedPiece.isPlayer == 1) {
        newArray = [[NSMutableArray alloc] initWithArray:playerOnePieces];
        opponentArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces];
    } else if (selectedPiece.isPlayer == 2) {
        newArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces];
        opponentArray = [[NSMutableArray alloc] initWithArray:playerOnePieces];
    }
    allPiecesArray = [[NSMutableArray alloc] initWithArray:pieces];
    
    // Check Guide Right
    for (Piece *opponentPiece in allPiecesArray) {
        if (selectedPiece.isEagle) {
            numberOfGuideSquaresRight = ((((8*widthOfSquare) + widthOfSquare/2) - selectedPiece.position.x)/widthOfSquare);
        } else if (selectedPiece.isPawn) {
            if (opponentPiece.position.y == selectedPiece.position.y && opponentPiece.position.x > selectedPiece.position.x) {
                if (tempGuideLinesPieceLocation.x == -1 && tempGuideLinesPieceLocation.y == -1) {
                    tempGuideLinesPieceLocation.x = (8*widthOfSquare) + (widthOfSquare/2);
                }
                
                if (opponentPiece.position.x <= tempGuideLinesPieceLocation.x) {
                    tempGuideLinesPieceLocation = opponentPiece.position;
                    numberOfGuideSquaresRight = ((tempGuideLinesPieceLocation.x - selectedPiece.position.x)/widthOfSquare) - 1;
                    //NSLog(@"Temp Guide Piece = %f, %f | #: %d",tempGuideLinesPieceLocation.x, tempGuideLinesPieceLocation.y,numberOfGuideSquaresRight);
                    
                    //break;
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresRight == 80) {
                numberOfGuideSquaresRight = ((((8*widthOfSquare) + widthOfSquare/2) - selectedPiece.position.x)/widthOfSquare);
            }
        }
    }
    tempGuideLinesPieceLocation = ccp(-1, -1);
    
    // Check Guide Left
    for (Piece *opponentPiece in allPiecesArray) {
        if (selectedPiece.isEagle) {
            numberOfGuideSquaresLeft = (((selectedPiece.position.x - (widthOfSquare + widthOfSquare/2))/widthOfSquare));
        } else if (selectedPiece.isPawn) {
            if (opponentPiece.position.y == selectedPiece.position.y && opponentPiece.position.x < selectedPiece.position.x) {
                if (tempGuideLinesPieceLocation.x == -1 && tempGuideLinesPieceLocation.y == -1) {
                    tempGuideLinesPieceLocation.x = widthOfSquare + widthOfSquare/2;
                }
                
                if (opponentPiece.position.x >= tempGuideLinesPieceLocation.x) {
                    tempGuideLinesPieceLocation.x = opponentPiece.position.x;
                    numberOfGuideSquaresLeft = ((selectedPiece.position.x - tempGuideLinesPieceLocation.x)/widthOfSquare) - 1;
                    //NSLog(@"Temp Guide Piece = %f, %f | #: %d",tempGuideLinesPieceLocation.x, tempGuideLinesPieceLocation.y,numberOfGuideSquaresRight);
                    
                    //break;
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresLeft == 80) {
                numberOfGuideSquaresLeft = (((selectedPiece.position.x - (widthOfSquare + widthOfSquare/2))/widthOfSquare));
            }
        }
    }
    tempGuideLinesPieceLocation = ccp(-1, -1);
    
    // Check Guide Up
    for (Piece *opponentPiece in allPiecesArray) {
        if (selectedPiece.isEagle) {
            numberOfGuideSquaresUp = (((11*heightOfSquare) + heightOfSquare/2) - selectedPiece.position.y)/heightOfSquare;
        } else if (selectedPiece.isPawn) {
            if (opponentPiece.position.x == selectedPiece.position.x && opponentPiece.position.y > selectedPiece.position.y) {
                if (tempGuideLinesPieceLocation.x == -1 && tempGuideLinesPieceLocation.y == -1) {
                    tempGuideLinesPieceLocation.y = (11*heightOfSquare) + (heightOfSquare/2);
                }
                
                if (opponentPiece.position.y <= tempGuideLinesPieceLocation.y) {
                    tempGuideLinesPieceLocation.y = opponentPiece.position.y;
                    numberOfGuideSquaresUp = ((tempGuideLinesPieceLocation.y - selectedPiece.position.y)/heightOfSquare) - 1;
                    //NSLog(@"Temp Guide Piece = %f, %f | #: %d",tempGuideLinesPieceLocation.x, tempGuideLinesPieceLocation.y,numberOfGuideSquaresUp);
                    //break;
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresUp == 80) {
                numberOfGuideSquaresUp = (((11*heightOfSquare) + heightOfSquare/2) - selectedPiece.position.y)/heightOfSquare;
            }
        }
    }
    tempGuideLinesPieceLocation = ccp(-1, -1);
    
    // Check Guide Down
    for (Piece *opponentPiece in allPiecesArray) {
        if (selectedPiece.isEagle) {
            numberOfGuideSquaresDown = ((selectedPiece.position.y - heightOfSquare/2)/heightOfSquare);
        } else if (selectedPiece.isPawn) {
            if (opponentPiece.position.x == selectedPiece.position.x && opponentPiece.position.y < selectedPiece.position.y) {
                if (tempGuideLinesPieceLocation.x == -1 && tempGuideLinesPieceLocation.y == -1) {
                    tempGuideLinesPieceLocation.y = heightOfSquare/2;
                }
                
                if (opponentPiece.position.y >= tempGuideLinesPieceLocation.y) {
                    tempGuideLinesPieceLocation.y = opponentPiece.position.y;
                    numberOfGuideSquaresDown = ((selectedPiece.position.y - tempGuideLinesPieceLocation.y)/heightOfSquare) - 1;
                    //NSLog(@"Temp Guide Piece = %f, %f | #: %d",tempGuideLinesPieceLocation.x, tempGuideLinesPieceLocation.y,numberOfGuideSquaresRight);
                    
                    //break;
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresDown == 80) {
                numberOfGuideSquaresDown = ((selectedPiece.position.y - heightOfSquare/2)/heightOfSquare);
            }
        }
    }
    tempGuideLinesPieceLocation = ccp(-1, -1);
    
    // Check Guide for Eagle
    if (selectedPiece.isEagle) {
        // Check Guide Up-Right
        tempGuideLinesPieceLocation = selectedPiece.position;
        for (int x = 1; x <= 8; x+=1) {
            tempGuideLinesPieceLocation = ccp(selectedPiece.position.x + (x*widthOfSquare), selectedPiece.position.y + (x*heightOfSquare));
            if (tempGuideLinesPieceLocation.x == ((8*widthOfSquare) + widthOfSquare/2) || tempGuideLinesPieceLocation.y == (11*heightOfSquare) + heightOfSquare/2) {
                numberOfGuideSquaresUpRight = x;
                break;
            }
        }
        /*for (Piece *opponentPiece in allPiecesArray) {
            if (opponentPiece.position.x > selectedPiece.position.x && opponentPiece.position.y > selectedPiece.position.y) {
                for (int x = 1; x <= 8; x += 1) {
                    opponentPiece.positionTemp = ccp(opponentPiece.position.x - (x*widthOfSquare), opponentPiece.position.y - (x*heightOfSquare));
                    if (opponentPiece.positionTemp.x == selectedPiece.position.x && opponentPiece.positionTemp.y == selectedPiece.position.y) {
                        //There the same, opponent is diagonal
                        // The opponent is X squares diagonally
                        numberOfGuideSquaresUpRight = x - 1;
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    } else if (opponentPiece.positionTemp.x < selectedPiece.position.x || opponentPiece.positionTemp.y < selectedPiece.position.y) {
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    }
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresUpRight == 80) {
                tempGuideLinesPieceLocation = selectedPiece.position;
                for (int x = 1; x <= 8; x+=1) {
                    tempGuideLinesPieceLocation = ccp(selectedPiece.position.x + (x*widthOfSquare), selectedPiece.position.y + (x*heightOfSquare));
                    if (tempGuideLinesPieceLocation.x == ((8*widthOfSquare) + widthOfSquare/2) || tempGuideLinesPieceLocation.y == (11*heightOfSquare) + heightOfSquare/2) {
                        numberOfGuideSquaresUpRight = x;
                        break;
                    }
                }
            }
        }*/
        tempGuideLinesPieceLocation = ccp(-1, -1);
        
        // Check Guide Up-Left
        tempGuideLinesPieceLocation = selectedPiece.position;
        for (int x = 1; x <= 8; x+=1) {
            tempGuideLinesPieceLocation = ccp(selectedPiece.position.x - (x*widthOfSquare), selectedPiece.position.y + (x*heightOfSquare));
            if (tempGuideLinesPieceLocation.x == (widthOfSquare + widthOfSquare/2) || tempGuideLinesPieceLocation.y == (11*heightOfSquare) + heightOfSquare/2) {
                numberOfGuideSquaresUpLeft = x;
                break;
            }
        }
        /*for (Piece *opponentPiece in allPiecesArray) {
            if (opponentPiece.position.x < selectedPiece.position.x && opponentPiece.position.y > selectedPiece.position.y) {
                for (int x = 1; x <= 8; x += 1) {
                    opponentPiece.positionTemp = ccp(opponentPiece.position.x + (x*widthOfSquare), opponentPiece.position.y - (x*heightOfSquare));
                    if (opponentPiece.positionTemp.x == selectedPiece.position.x && opponentPiece.positionTemp.y == selectedPiece.position.y) {
                        //There the same, opponent is diagonal
                        // The opponent is X squares diagonally
                        numberOfGuideSquaresUpLeft = x - 1;
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    } else if (opponentPiece.positionTemp.x > selectedPiece.position.x || opponentPiece.positionTemp.y < selectedPiece.position.y) {
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    }
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresUpLeft == 80) {
                tempGuideLinesPieceLocation = selectedPiece.position;
                for (int x = 1; x <= 8; x+=1) {
                    tempGuideLinesPieceLocation = ccp(selectedPiece.position.x - (x*widthOfSquare), selectedPiece.position.y + (x*heightOfSquare));
                    if (tempGuideLinesPieceLocation.x == (widthOfSquare + widthOfSquare/2) || tempGuideLinesPieceLocation.y == (11*heightOfSquare) + heightOfSquare/2) {
                        numberOfGuideSquaresUpLeft = x;
                        break;
                    }
                }
            }
        }*/
        tempGuideLinesPieceLocation = ccp(-1, -1);
        
        // Check Guide Down-Right
        tempGuideLinesPieceLocation = selectedPiece.position;
        for (int x = 1; x <= 8; x+=1) {
            tempGuideLinesPieceLocation = ccp(selectedPiece.position.x + (x*widthOfSquare), selectedPiece.position.y - (x*heightOfSquare));
            if (tempGuideLinesPieceLocation.x == ((8*widthOfSquare) + widthOfSquare/2) || tempGuideLinesPieceLocation.y == heightOfSquare/2) {
                numberOfGuideSquaresDownRight = x;
                break;
            }
        }
        /*for (Piece *opponentPiece in allPiecesArray) {
            if (opponentPiece.position.x > selectedPiece.position.x && opponentPiece.position.y < selectedPiece.position.y) {
                for (int x = 1; x <= 8; x += 1) {
                    opponentPiece.positionTemp = ccp(opponentPiece.position.x - (x*widthOfSquare), opponentPiece.position.y + (x*heightOfSquare));
                    if (opponentPiece.positionTemp.x == selectedPiece.position.x && opponentPiece.positionTemp.y == selectedPiece.position.y) {
                        //There the same, opponent is diagonal
                        // The opponent is X squares diagonally
                        numberOfGuideSquaresDownRight = x - 1;
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    } else if (opponentPiece.positionTemp.x < selectedPiece.position.x || opponentPiece.positionTemp.y > selectedPiece.position.y) {
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    }
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresDownRight == 80) {
                tempGuideLinesPieceLocation = selectedPiece.position;
                for (int x = 1; x <= 8; x+=1) {
                    tempGuideLinesPieceLocation = ccp(selectedPiece.position.x + (x*widthOfSquare), selectedPiece.position.y - (x*heightOfSquare));
                    if (tempGuideLinesPieceLocation.x == ((8*widthOfSquare) + widthOfSquare/2) || tempGuideLinesPieceLocation.y == heightOfSquare/2) {
                        numberOfGuideSquaresDownRight = x;
                        break;
                    }
                }
            }
        }*/
        tempGuideLinesPieceLocation = ccp(-1, -1);
        
        // Check Guide Down-Left
        tempGuideLinesPieceLocation = selectedPiece.position;
        for (int x = 1; x <= 8; x+=1) {
            tempGuideLinesPieceLocation = ccp(selectedPiece.position.x - (x*widthOfSquare), selectedPiece.position.y - (x*heightOfSquare));
            if (tempGuideLinesPieceLocation.x == (widthOfSquare + widthOfSquare/2) || tempGuideLinesPieceLocation.y == heightOfSquare/2) {
                numberOfGuideSquaresDownLeft = x;
                break;
            }
        }
        /*for (Piece *opponentPiece in allPiecesArray) {
            if (opponentPiece.position.x < selectedPiece.position.x && opponentPiece.position.y < selectedPiece.position.y) {
                for (int x = 1; x <= 8; x += 1) {
                    opponentPiece.positionTemp = ccp(opponentPiece.position.x + (x*widthOfSquare), opponentPiece.position.y + (x*heightOfSquare));
                    if (opponentPiece.positionTemp.x == selectedPiece.position.x && opponentPiece.positionTemp.y == selectedPiece.position.y) {
                        //There the same, opponent is diagonal
                        // The opponent is X squares diagonally
                        numberOfGuideSquaresDownLeft = x -1;
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    } else if (opponentPiece.positionTemp.x > selectedPiece.position.x || opponentPiece.positionTemp.y > selectedPiece.position.y) {
                        opponentPiece.positionTemp = opponentPiece.position;
                        break;
                    }
                }
            }
            if (opponentPiece == [allPiecesArray lastObject] && numberOfGuideSquaresDownLeft == 80) {
                tempGuideLinesPieceLocation = selectedPiece.position;
                for (int x = 1; x <= 8; x+=1) {
                    tempGuideLinesPieceLocation = ccp(selectedPiece.position.x - (x*widthOfSquare), selectedPiece.position.y - (x*heightOfSquare));
                    if (tempGuideLinesPieceLocation.x == (widthOfSquare + widthOfSquare/2) || tempGuideLinesPieceLocation.y == heightOfSquare/2) {
                        numberOfGuideSquaresDownLeft = x;
                        break;
                    }
                }
            }
        }*/
        tempGuideLinesPieceLocation = ccp(-1, -1);
    }
    
    newArray = nil;
    opponentArray = nil;
    allPiecesArray = nil;
    [self addGuideSquares:selectedPiece];
}

-(void)addGuideSquares:(Piece *)selectedPiece {
    // Add Guide Squares Right
    for (int x = 1; x <= numberOfGuideSquaresRight; x+=1) {
        CCSprite *guideSquaresRight = [CCSprite spriteWithFile:@"Guide_Square.png"];
        guideSquaresRight.position = ccp(selectedPiece.position.x + (x*widthOfSquare), selectedPiece.position.y);
        [self addChild:guideSquaresRight z:-1];
        [guideSquaresRightArray addObject:guideSquaresRight];
        [guideSquaresAllArray addObject:guideSquaresRight];
        isGuideSquares = YES;
        if (![self checkRules:guideSquaresRight.position]) {
            guideSquaresRight.opacity = 0;
        }
        
        if (!_pauseMenu.isGuideSquaresON) {
            guideSquaresRight.opacity = 0;
        }
    }
    
    // Add Guide Squares Left
    for (int x = 1; x <= numberOfGuideSquaresLeft; x+=1) {
        CCSprite *guideSquaresLeft = [CCSprite spriteWithFile:@"Guide_Square.png"];
        guideSquaresLeft.position = ccp(selectedPiece.position.x - (x*widthOfSquare), selectedPiece.position.y);
        [self addChild:guideSquaresLeft z:-1];
        [guideSquaresLeftArray addObject:guideSquaresLeft];
        [guideSquaresAllArray addObject:guideSquaresLeft];
        isGuideSquares = YES;
        if (![self checkRules:guideSquaresLeft.position]) {
            guideSquaresLeft.opacity = 0;
        }
        
        if (!_pauseMenu.isGuideSquaresON) {
            guideSquaresLeft.opacity = 0;
        }
    }
    
    // Add Guide Squares Up
    for (int x = 1; x<= numberOfGuideSquaresUp; x+=1) {
        CCSprite *guideSquaresUp = [CCSprite spriteWithFile:@"Guide_Square.png"];
        guideSquaresUp.position = ccp(selectedPiece.position.x, selectedPiece.position.y + (x*heightOfSquare));
        [self addChild:guideSquaresUp z:-1];
        [guideSquaresUpArray addObject:guideSquaresUp];
        [guideSquaresAllArray addObject:guideSquaresUp];
        isGuideSquares = YES;
        if (![self checkRules:guideSquaresUp.position]) {
            guideSquaresUp.opacity = 0;
        }
        
        if (!_pauseMenu.isGuideSquaresON) {
            guideSquaresUp.opacity = 0;
        }
    }
    
    // Add Guide Squares Down
    for (int x = 1; x<= numberOfGuideSquaresDown; x+=1) {
        CCSprite *guideSquaresDown = [CCSprite spriteWithFile:@"Guide_Square.png"];
        guideSquaresDown.position = ccp(selectedPiece.position.x, selectedPiece.position.y - (x*heightOfSquare));
        [self addChild:guideSquaresDown z:-1];
        [guideSquaresDownArray addObject:guideSquaresDown];
        [guideSquaresAllArray addObject:guideSquaresDown];
        isGuideSquares = YES;
        if (![self checkRules:guideSquaresDown.position]) {
            guideSquaresDown.opacity = 0;
        }
        
        if (!_pauseMenu.isGuideSquaresON) {
            guideSquaresDown.opacity = 0;
        }
    }
    
    if (selectedPiece.isEagle) {
        // Add Guide Squares Up-Right
        for (int x = 1; x <= numberOfGuideSquaresUpRight; x+=1) {
            CCSprite *guideSquaresUpRight = [CCSprite spriteWithFile:@"Guide_Square.png"];
            guideSquaresUpRight.position = ccp(selectedPiece.position.x + (x*widthOfSquare), selectedPiece.position.y + (x*heightOfSquare));
            [self addChild:guideSquaresUpRight z:-1];
            [guideSquaresUpRightArray addObject:guideSquaresUpRight];
            [guideSquaresAllArray addObject:guideSquaresUpRight];
            isGuideSquares = YES;
            if (![self checkRules:guideSquaresUpRight.position]) {
                guideSquaresUpRight.opacity = 0;
            }
            
            if (!_pauseMenu.isGuideSquaresON) {
                guideSquaresUpRight.opacity = 0;
            }
        }
        
        // Add Guide Squares Up-Left
        for (int x = 1; x <= numberOfGuideSquaresUpLeft; x+=1) {
            CCSprite *guideSquaresUpLeft = [CCSprite spriteWithFile:@"Guide_Square.png"];
            guideSquaresUpLeft.position = ccp(selectedPiece.position.x - (x*widthOfSquare), selectedPiece.position.y + (x*heightOfSquare));
            [self addChild:guideSquaresUpLeft z:-1];
            [guideSquaresUpLeftArray addObject:guideSquaresUpLeft];
            [guideSquaresAllArray addObject:guideSquaresUpLeft];
            isGuideSquares = YES;
            if (![self checkRules:guideSquaresUpLeft.position]) {
                guideSquaresUpLeft.opacity = 0;
            }
            
            if (!_pauseMenu.isGuideSquaresON) {
                guideSquaresUpLeft.opacity = 0;
            }
        }
        
        // Add Guide Squares Down-Right
        for (int x = 1; x <= numberOfGuideSquaresDownRight; x+=1) {
            CCSprite *guideSquaresDownRight = [CCSprite spriteWithFile:@"Guide_Square.png"];
            guideSquaresDownRight.position = ccp(selectedPiece.position.x + (x*widthOfSquare), selectedPiece.position.y - (x*heightOfSquare));
            [self addChild:guideSquaresDownRight z:-1];
            [guideSquaresDownRightArray addObject:guideSquaresDownRight];
            [guideSquaresAllArray addObject:guideSquaresDownRight];
            isGuideSquares = YES;
            if (![self checkRules:guideSquaresDownRight.position]) {
                guideSquaresDownRight.opacity = 0;
            }
            
            if (!_pauseMenu.isGuideSquaresON) {
                guideSquaresDownRight.opacity = 0;
            }
        }
        
        // Add Guide Squares Down-Left
        for (int x = 1; x <= numberOfGuideSquaresDownLeft; x+=1) {
            CCSprite *guideSquaresDownLeft = [CCSprite spriteWithFile:@"Guide_Square.png"];
            guideSquaresDownLeft.position = ccp(selectedPiece.position.x - (x*widthOfSquare), selectedPiece.position.y - (x*heightOfSquare));
            [self addChild:guideSquaresDownLeft z:-1];
            [guideSquaresDownLeftArray addObject:guideSquaresDownLeft];
            [guideSquaresAllArray addObject:guideSquaresDownLeft];
            isGuideSquares = YES;
            if (![self checkRules:guideSquaresDownLeft.position]) {
                guideSquaresDownLeft.opacity = 0;
            }
            
            if (!_pauseMenu.isGuideSquaresON) {
                guideSquaresDownLeft.opacity = 0;
            }
        }
    }
}

-(void)removeGuideSquares:(Piece *)selectedPiece {
    // Remove Guide Squares Right
    for (CCSprite *guideSquaresRight in guideSquaresRightArray) {
        [self removeChild:guideSquaresRight cleanup:YES];
    }
    guideSquaresRightArray = nil;
    guideSquaresRightArray = [[NSMutableArray alloc] init];
    
    // Remove Guide Squares Left
    for (CCSprite *guideSquaresLeft in guideSquaresLeftArray) {
        [self removeChild:guideSquaresLeft cleanup:YES];
    }
    guideSquaresLeftArray = nil;
    guideSquaresLeftArray = [[NSMutableArray alloc] init];
    
    // Remove Guide Squares Up
    for (CCSprite *guideSquaresUp in guideSquaresUpArray) {
        [self removeChild:guideSquaresUp cleanup:YES];
    }
    guideSquaresUpArray = nil;
    guideSquaresUpArray = [[NSMutableArray alloc] init];
    
    // Remove Guide Squares Down
    for (CCSprite *guideSquaresDown in guideSquaresDownArray) {
        [self removeChild:guideSquaresDown cleanup:YES];
    }
    guideSquaresDownArray = nil;
    guideSquaresDownArray = [[NSMutableArray alloc] init];
    
    if (selectedPiece.isEagle) {
        // Remove Guide Squares Up-Right
        for (CCSprite *guideSquaresUpRight in guideSquaresUpRightArray) {
            [self removeChild:guideSquaresUpRight cleanup:YES];
        }
        guideSquaresUpRightArray = nil;
        guideSquaresUpRightArray = [[NSMutableArray alloc] init];
        
        // Remove Guide Squares Up-Left
        for (CCSprite *guideSquaresUpLeft in guideSquaresUpLeftArray) {
            [self removeChild:guideSquaresUpLeft cleanup:YES];
        }
        guideSquaresUpLeftArray = nil;
        guideSquaresUpLeftArray = [[NSMutableArray alloc] init];
        
        // Remove Guide Squares Down-Right
        for (CCSprite *guideSquaresDownRight in guideSquaresDownRightArray) {
            [self removeChild:guideSquaresDownRight cleanup:YES];
        }
        guideSquaresDownRightArray = nil;
        guideSquaresDownRightArray = [[NSMutableArray alloc] init];
        
        // Remove Guide Squares Down-Left
        for (CCSprite *guideSquaresDownLeft in guideSquaresDownLeftArray) {
            [self removeChild:guideSquaresDownLeft cleanup:YES];
        }
        guideSquaresDownLeftArray = nil;
        guideSquaresDownLeftArray = [[NSMutableArray alloc] init];
    }
    guideSquaresAllArray = nil;
    guideSquaresAllArray = [[NSMutableArray alloc] init];
}
#pragma mark

#pragma mark Information Methods
// Determine center of square that the user has touched
-(void)determineCenterOfSquareThatUserTouched:(CGPoint)usersTouchLocation {
    CGPoint topLeft;
    CGPoint topRight;
    CGPoint center;
    CGPoint bottomLeft;
    CGPoint bottomRight;
    
    // Top-Left Point of Touched Square
    // Y Position
    for (NSValue *horizontalLeftPoint in _boardGrid.horizontalLeftArray) {
        if ([horizontalLeftPoint CGPointValue].y > usersTouchLocation.y) {
            topLeft.y = [horizontalLeftPoint CGPointValue].y;
            
            break;
        }
    }
    // X Position
    for (NSValue *verticalBottomPoint in [_boardGrid.verticalBottomArray reverseObjectEnumerator]) {
        if ([verticalBottomPoint CGPointValue].x < usersTouchLocation.x) {
            topLeft.x = [verticalBottomPoint CGPointValue].x;
            
            break;
        }
    }
    
    // Top-Right Point of Touched Square
    // Y Position
    for (NSValue *horizontalLeftPoint in _boardGrid.horizontalLeftArray) {
        if ([horizontalLeftPoint CGPointValue].y > usersTouchLocation.y) {
            topRight.y = [horizontalLeftPoint CGPointValue].y;
            
            break;
        }
    }
    // X Position
    for (NSValue *verticalBottomPoint in _boardGrid.verticalBottomArray) {
        if ([verticalBottomPoint CGPointValue].x > usersTouchLocation.x) {
            topRight.x = [verticalBottomPoint CGPointValue].x;
            
            break;
        }
    }
    
    // Bottom-Left Point of Touched Square
    // Y Position
    for (NSValue *horizontalLeftPoint in [_boardGrid.horizontalLeftArray reverseObjectEnumerator]) {
        if ([horizontalLeftPoint CGPointValue].y < usersTouchLocation.y) {
            bottomLeft.y = [horizontalLeftPoint CGPointValue].y;
            
            break;
        }
    }
    // X Position
    for (NSValue *verticalBottomPoint in [_boardGrid.verticalBottomArray reverseObjectEnumerator]) {
        if ([verticalBottomPoint CGPointValue].x < usersTouchLocation.x) {
            bottomLeft.x = [verticalBottomPoint CGPointValue].x;
            
            break;
        }
    }
    
    // Bottom-Right Point of Touched Square
    // Y Position
    for (NSValue *horizontalLeftPoint in [_boardGrid.horizontalLeftArray reverseObjectEnumerator]) {
        if ([horizontalLeftPoint CGPointValue].y < usersTouchLocation.y) {
            bottomRight.y = [horizontalLeftPoint CGPointValue].y;
            
            break;
        }
    }
    // X Position
    for (NSValue *verticalBottomPoint in _boardGrid.verticalBottomArray) {
        if ([verticalBottomPoint CGPointValue].x > usersTouchLocation.x) {
            bottomRight.x = [verticalBottomPoint CGPointValue].x;
            
            break;
        }
    }
    
    // Setting the center of the square the user touched
    center.x = bottomLeft.x + (bottomRight.x - bottomLeft.x)/2;
    center.y = bottomLeft.y + (topLeft.y - bottomLeft.y)/2;
    
    //NSLog(@"User touched square with center: %f, %f, %f, %f",center.x, center.y, bottomRight.x - bottomLeft.x, topLeft.y - bottomLeft.y);
    
    for (Piece *piece in pieces) {
        // If a piece is not currently selected, check if user just selected a piece
        if (!isPieceSelected) {
            if ([self checkIfUserSelectedAPiece:piece withTouch:center]) {
                break;
            }
            // If the user did select a piece, then check whos turn it is
        } else if (isPieceSelected) {
            theLocation = center;
            if ([self checkRules:theLocation]) {
                [self movePieceIfRulesPassed:theLocation];
            } else if (![self checkRules:theLocation]) {
                [self deselectPiece];
            }
            
            break;
        }
    }
}

// Determine the square that will be used as the "Square of Origin"
-(CGPoint)determineOriginSquare {
    CGPoint originSquareTopLeft;
    CGPoint originSquareTopRight;
    CGPoint originSquareCenter;
    CGPoint originSquareBottomLeft;
    CGPoint originSquareBottomRight;
    
    // Bottom-Left Point of Origin Square
    for (NSValue *bottomLeftPoint in _boardGrid.verticalBottomArray) {
        if ([_boardGrid.verticalBottomArray indexOfObject:bottomLeftPoint] == 0) {
            originSquareBottomLeft = [bottomLeftPoint CGPointValue];
            
            break;
        }
    }
    
    // Bottom-Right Point of Origin Square
    for (NSValue *bottomRightPoint in _boardGrid.verticalBottomArray) {
        if ([_boardGrid.verticalBottomArray indexOfObject:bottomRightPoint] == 1) {
            originSquareBottomRight = [bottomRightPoint CGPointValue];
            
            break;
        }
    }
    
    // Top-Left Point of Origin Square
    for (NSValue *topLeftPoint in _boardGrid.horizontalLeftArray) {
        if ([_boardGrid.horizontalLeftArray indexOfObject:topLeftPoint] == 1) {
            originSquareTopLeft = [topLeftPoint CGPointValue];
            
            break;
        }
    }
    
    // Top-Right Point of Origin Square
    for (NSValue *topRightPoint in _boardGrid.horizontalLeftArray) {
        if ([_boardGrid.horizontalLeftArray indexOfObject:topRightPoint] == 2) {
            originSquareTopRight = [topRightPoint CGPointValue];
            
            break;
        }
    }
    
    // Set Origin Square Center
    originSquareCenter.x = originSquareBottomLeft.x + (originSquareBottomRight.x - originSquareBottomLeft.x)/2;
    originSquareCenter.y = originSquareBottomLeft.y + (originSquareTopLeft.y - originSquareBottomLeft.y)/2;
    
    // Set width & height of all squares
    widthOfSquare = originSquareBottomRight.x - originSquareBottomLeft.x;
    heightOfSquare = originSquareTopLeft.y - originSquareBottomLeft.y;
    
    return originSquareCenter;
}

-(void)createPlayerScoreBoard:(NSString *)player1Color andPlayerTwoColor:(NSString *)player2Color {
    CGPoint originSquareCenter;
    
    // Setting the center of the origin square
    originSquareCenter = [self determineOriginSquare];
    
    // Create Player One's Score Board
    CCSprite *p1BoardPlayerOnesRemainingPiecesSprite = [CCSprite spriteWithFile:player1Color];
    p1BoardPlayerOnesRemainingPiecesSprite.position = ccp(originSquareCenter.x + (9*widthOfSquare), originSquareCenter.y);
    p1BoardPlayerOnesRemainingPiecesSprite.scale = 2;
    [self addChild:p1BoardPlayerOnesRemainingPiecesSprite z:2];
    
    if (!p1BoardNumberOfRemainingPlayerOnePiecesLabel) {
        numberOfRemainingPlayerOnePiecesInt = 13;
        p1BoardNumberOfRemainingPlayerOnePiecesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",numberOfRemainingPlayerOnePiecesInt] fontName:@"Marker Felt" fontSize:17.5];
        p1BoardNumberOfRemainingPlayerOnePiecesLabel.position = ccp(originSquareCenter.x + (9*widthOfSquare), originSquareCenter.y);
        p1BoardNumberOfRemainingPlayerOnePiecesLabel.rotation = 90;
        [self addChild:p1BoardNumberOfRemainingPlayerOnePiecesLabel z:2];
    }
    
    CCSprite *p1BoardPlayerTwosRemainingPiecesSprite = [CCSprite spriteWithFile:player2Color];
    p1BoardPlayerTwosRemainingPiecesSprite.position = ccp(originSquareCenter.x + (9*widthOfSquare), originSquareCenter.y + (11*heightOfSquare));
    p1BoardPlayerTwosRemainingPiecesSprite.scale = 2;
    [self addChild:p1BoardPlayerTwosRemainingPiecesSprite z:2];
    
    if (!p1BoardNumberOfRemainingPlayerTwoPiecesLabel) {
        numberOfRemainingPlayerTwoPiecesInt = 13;
        p1BoardNumberOfRemainingPlayerTwoPiecesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",numberOfRemainingPlayerTwoPiecesInt] fontName:@"Marker Felt" fontSize:17.5];
        p1BoardNumberOfRemainingPlayerTwoPiecesLabel.position = ccp(originSquareCenter.x + (9*widthOfSquare), originSquareCenter.y + (11*heightOfSquare));
        p1BoardNumberOfRemainingPlayerTwoPiecesLabel.rotation = 90;
        [self addChild:p1BoardNumberOfRemainingPlayerTwoPiecesLabel z:2];
    }
    
    // Create Player Two's Score Board
    CCSprite *p2BoardPlayerOnesRemainingPiecesSprite = [CCSprite spriteWithFile:player1Color];
    p2BoardPlayerOnesRemainingPiecesSprite.position = originSquareCenter;
    p2BoardPlayerOnesRemainingPiecesSprite.scale = 2;
    [self addChild:p2BoardPlayerOnesRemainingPiecesSprite z:2];
    
    if (!p2BoardNumberOfRemainingPlayerOnePiecesLabel) {
        numberOfRemainingPlayerOnePiecesInt = 13;
        p2BoardNumberOfRemainingPlayerOnePiecesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",numberOfRemainingPlayerOnePiecesInt] fontName:@"Marker Felt" fontSize:17.5];
        p2BoardNumberOfRemainingPlayerOnePiecesLabel.position = originSquareCenter;
        p2BoardNumberOfRemainingPlayerOnePiecesLabel.rotation = -90;
        [self addChild:p2BoardNumberOfRemainingPlayerOnePiecesLabel z:2];
    }
    
    CCSprite *p2BoardPlayerTwosRemainingPiecesSprite = [CCSprite spriteWithFile:player2Color];
    p2BoardPlayerTwosRemainingPiecesSprite.position = ccp(originSquareCenter.x, originSquareCenter.y + (11*heightOfSquare));
    p2BoardPlayerTwosRemainingPiecesSprite.scale = 2;
    [self addChild:p2BoardPlayerTwosRemainingPiecesSprite z:2];
    
    if (!p2BoardNumberOfRemainingPlayerTwoPiecesLabel) {
        numberOfRemainingPlayerTwoPiecesInt = 13;
        p2BoardNumberOfRemainingPlayerTwoPiecesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",numberOfRemainingPlayerTwoPiecesInt] fontName:@"Marker Felt" fontSize:17.5];
        p2BoardNumberOfRemainingPlayerTwoPiecesLabel.position = ccp(originSquareCenter.x, originSquareCenter.y + (11*heightOfSquare));
        p2BoardNumberOfRemainingPlayerTwoPiecesLabel.rotation = -90;
        [self addChild:p2BoardNumberOfRemainingPlayerTwoPiecesLabel z:2];
    }
    
    // Add brown score board line thingy for the left side
    CCSprite *leftScoreBoardPlank = [CCSprite spriteWithFile:@"ScoreBoardBackground.png"];
    leftScoreBoardPlank.position = ccp(widthOfSquare/2, 0);
    leftScoreBoardPlank.anchorPoint = ccp(0.5, 0);
    leftScoreBoardPlank.color = ccBLACK;
    leftScoreBoardPlank.scaleY = 12;
    [self addChild:leftScoreBoardPlank z:1];
    
    /*for (int x=0; x<=11; x+=1) {
        CCSprite *sprite = [CCSprite spriteWithFile:@"ScoreBoardBackground.png"];
        sprite.position = ccp(widthOfSquare/2, (x*heightOfSquare) + heightOfSquare/2);
        //sprite.color = ccBLACK;
        //[self addChild:sprite z:1];
    }*/
    
    // Add brown score board line thingy for the right side
    CCSprite *rightScoreBoardPlank = [CCSprite spriteWithFile:@"ScoreBoardBackground.png"];
    rightScoreBoardPlank.position = ccp((9*widthOfSquare) + widthOfSquare/2, 0);
    rightScoreBoardPlank.anchorPoint = ccp(0.5, 0);
    rightScoreBoardPlank.color = ccBLACK;
    rightScoreBoardPlank.scaleY = 12;
    [self addChild:rightScoreBoardPlank z:1];
    
    /*for (int x=0; x<=11; x+=1) {
        CCSprite *sprite = [CCSprite spriteWithFile:@"ScoreBoardBackground.png"];
        sprite.position = ccp((9*widthOfSquare) + widthOfSquare/2, (x*heightOfSquare) + heightOfSquare/2);
        //sprite.color = ccBLACK;
        //[self addChild:sprite z:1];
    }*/
}

-(void)generalInformation:(GameHUD *)hud mode:(Mode)gameMode andPlayerOneColor:(NSString *)player1Color andPlayerTwoColor:(NSString *)player2Color {
    // Initalize Arrays and other Objects
    playerOneColor = [[NSString alloc] initWithString:player1Color];
    playerTwoColor = [[NSString alloc] initWithString:player2Color];
    gameStateScoreArrayCpuOne = [[NSMutableArray alloc] init];
    gameStateScoreArrayCpuTwo = [[NSMutableArray alloc] init];
    gameStateScoreArray = [[NSMutableArray alloc] init];
    playerOnePieces = [[NSMutableArray alloc] init];
    playerTwoPieces = [[NSMutableArray alloc] init];
    pieces = [[NSMutableArray alloc] init];
    _boardGrid = [[BoardGrid alloc] init];
    _pauseMenu = [[PauseMenu alloc] init];
    pieceSelected = [[Piece alloc] init];
    
    guideSquaresAllArray = [[NSMutableArray alloc] init];
    guideSquaresRightArray = [[NSMutableArray alloc] init];
    guideSquaresLeftArray = [[NSMutableArray alloc] init];
    guideSquaresUpArray = [[NSMutableArray alloc] init];
    guideSquaresDownArray = [[NSMutableArray alloc] init];
    guideSquaresUpRightArray = [[NSMutableArray alloc] init];
    guideSquaresUpLeftArray = [[NSMutableArray alloc] init];
    guideSquaresDownRightArray = [[NSMutableArray alloc] init];
    guideSquaresDownLeftArray = [[NSMutableArray alloc] init];
    
    // Set Boolean Variables
    self.isTouchEnabled = YES;
    _pauseMenu.sound = NO;
    isPieceSelected = NO;
    isGuideSquares = NO;
    isPieceMoving = NO;
    didUserMove = NO;
    
    // Set Inital Value
    screenSize = [[CCDirector sharedDirector] winSize];
    self.mode = gameMode;
    gameStateScore = 0;
    _hud = hud;
    
    // Add background
    CCSprite *whiteSolid = [[[CCSprite alloc] init] autorelease];
    [whiteSolid setTextureRect:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    whiteSolid.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild: whiteSolid z:-1];
}

-(id)initWithHUD:(GameHUD *)hud mode:(Mode)gameMode andPlayerOneColor:(NSString *)player1Color andPlayerTwoColor:(NSString *)player2Color {
    self = [super init];
    if (self) {
        [self generalInformation:hud mode:gameMode andPlayerOneColor:player1Color andPlayerTwoColor:player2Color];
        [_pauseMenu getGameInfo:self.mode withScene:self andHud:_hud andP1Color:player1Color andP2Color:player2Color];
        [_pauseMenu preRenderAndShowPauseMenu];
        [self draw];
        [self createPlayerScoreBoard:player1Color andPlayerTwoColor:player2Color];
        [self checkGameMode];
    }
    return self;
}
#pragma mark

#pragma mark - AI
-(NSMutableArray *)aiArray {
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces copyItems:YES];
    
    return newArray;
}
//NSMutableArray *theTempAiArray = [self aiArray];
-(void)createTheoritcalGameTree2:(NSMutableArray *)tempAiArry {
    
    for (CCSprite *ai in tempAiArry) {
        
    }
}

-(int)retrieveGameStateScore:(CGPoint)tempLocation withModelNumber:(int)modelNumber {
    int scoreOfGameState = 0;
    CGPoint hello;
    NSMutableArray *newArray;
    NSMutableArray *opponentArray;
    if (isPlayerOneAI && isPlayerOneTurn) {
        newArray = [[NSMutableArray alloc] initWithArray:playerOnePieces];
        opponentArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces];
    }else if (isPlayerTwoAI && isPlayerTwoTurn) {
        newArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces];
        opponentArray = [[NSMutableArray alloc] initWithArray:playerOnePieces];
    }
    //NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces];
    
    // Change this piece's positionTemp to the temp location
    for (Piece *piece in newArray) {
        if (piece.modelNumber == modelNumber) {
            hello = piece.positionTemp;
            piece.positionTemp = tempLocation;
        }
    }
    
    for (Piece *pieceAi in newArray) {
        // Check if piece is in middle of board
        // If it is, the score of the game state += 1
        //if (pieceAi.positionTemp.x >= (4*widthOfSquare) && pieceAi.positionTemp.x <= (6*widthOfSquare)) {
        //    scoreOfGameState += 1;
        //}
        
        int pieceTile;
        pieceTile = (pieceAi.positionTemp.x / widthOfSquare);
        switch (pieceTile) {
            case 1:
                scoreOfGameState += 0;
                break;
            case 2:
                scoreOfGameState += 1;
                break;
            case 3:
                scoreOfGameState += 2;
                break;
            case 4:
                scoreOfGameState += 3;
                break;
            case 5:
                scoreOfGameState += 3;
                break;
            case 6:
                scoreOfGameState += 3;
                break;
            case 7:
                scoreOfGameState += 2;
                break;
            case 8:
                scoreOfGameState += 1;
                break;
            case 9:
                scoreOfGameState += 0;
                break;
                
            default:
                break;
        }
        
        // Check if piece is 2 spaces away from an opponent piece
        // If it is, the score of the game state += 2
        for (Piece *piecePlayer1 in opponentArray) {
            if (pieceAi.positionTemp.y == piecePlayer1.position.y && (pieceAi.positionTemp.x == piecePlayer1.position.x + (2*widthOfSquare) || pieceAi.positionTemp.x == piecePlayer1.position.x - (2*widthOfSquare))) {
                scoreOfGameState += 2;
                
                break;
            }
            if (pieceAi.positionTemp.x == piecePlayer1.position.x && (pieceAi.positionTemp.y == piecePlayer1.position.y + (2*heightOfSquare) || pieceAi.positionTemp.y == piecePlayer1.position.y - (2*heightOfSquare))) {
                scoreOfGameState += 2;
                
                break;
            }
        }
        
        // Check if piece is next to an opponent piece
        // If it is, the score of the game state += 3
        for (Piece *piecePlayer1 in opponentArray) {
            // Check to the right
            if (pieceAi.positionTemp.y == piecePlayer1.positionTemp.y && pieceAi.positionTemp.x == piecePlayer1.positionTemp.x + widthOfSquare) {
                scoreOfGameState += 3;
                if (pieceAi.positionTemp.x == pieceAi.position.x && pieceAi.positionTemp.y == pieceAi.position.y) {
                    pieceAi.isInDanger = YES;
                }
                
                for (Piece *piecePlayer12 in opponentArray) {
                    if (piecePlayer12.positionTemp.y == pieceAi.positionTemp.y && piecePlayer12.positionTemp.x > pieceAi.positionTemp.x) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                    if (piecePlayer12.positionTemp.x == pieceAi.positionTemp.x + widthOfSquare) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                }
                
                break;
            }
            // Check to the left
            if (pieceAi.positionTemp.y == piecePlayer1.positionTemp.y && pieceAi.positionTemp.x == piecePlayer1.positionTemp.x - widthOfSquare) {
                scoreOfGameState += 3;
                if (pieceAi.positionTemp.x == pieceAi.position.x && pieceAi.positionTemp.y == pieceAi.position.y) {
                    pieceAi.isInDanger = YES;
                }
                
                for (Piece *piecePlayer12 in opponentArray) {
                    if (piecePlayer12.positionTemp.y == pieceAi.positionTemp.y && piecePlayer12.positionTemp.x < pieceAi.positionTemp.x) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                    if (piecePlayer12.positionTemp.x == pieceAi.positionTemp.x - widthOfSquare) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                }
                
                break;
            }
            // Check above
            if (pieceAi.positionTemp.x == piecePlayer1.positionTemp.x && pieceAi.positionTemp.y == piecePlayer1.positionTemp.y + heightOfSquare) {
                scoreOfGameState += 3;
                if (pieceAi.positionTemp.x == pieceAi.position.x && pieceAi.positionTemp.y == pieceAi.position.y) {
                    pieceAi.isInDanger = YES;
                }
                
                for (Piece *piecePlayer12 in opponentArray) {
                    if (piecePlayer12.positionTemp.x == pieceAi.positionTemp.x && piecePlayer12.positionTemp.y > pieceAi.positionTemp.y) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                    if (piecePlayer12.positionTemp.y == pieceAi.positionTemp.y + heightOfSquare) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                }
                
                break;
            }
            // Check below
            if (pieceAi.positionTemp.x == piecePlayer1.positionTemp.x && pieceAi.positionTemp.y == piecePlayer1.positionTemp.y - heightOfSquare) {
                scoreOfGameState += 3;
                if (pieceAi.positionTemp.x == pieceAi.position.x && pieceAi.positionTemp.y == pieceAi.position.y) {
                    pieceAi.isInDanger = YES;
                }
                
                for (Piece *piecePlayer12 in opponentArray) {
                    if (piecePlayer12.positionTemp.x == pieceAi.positionTemp.x && piecePlayer12.positionTemp.y < pieceAi.positionTemp.y) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                    if (piecePlayer12.positionTemp.y == pieceAi.positionTemp.y - heightOfSquare) {
                        scoreOfGameState -= 5;
                        
                        break;
                    }
                }
                
                break;
            }
        }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        for (Piece *player1 in opponentArray) {
            for (Piece *player2 in newArray) {
                
                // Capture Detection for Player AI
                // If ai temp captured an opponent piece, the score of the game state += 4
                if (pieceAi.positionTemp.x == player1.position.x) {
                    if (pieceAi.positionTemp.y == player1.position.y + heightOfSquare) {
                        if (pieceAi.positionTemp.y == player2.position.y + 2*heightOfSquare && pieceAi.positionTemp.x == player2.position.x) {
                            scoreOfGameState += 4;
                        }
                    }
                    if (pieceAi.positionTemp.y == player1.position.y - heightOfSquare) {
                        if (pieceAi.positionTemp.y == player2.position.y - 2*heightOfSquare && pieceAi.positionTemp.x == player2.position.x) {
                            scoreOfGameState += 4;
                        }
                    }
                }
                if (pieceAi.positionTemp.y == player1.position.y) {
                    if (pieceAi.positionTemp.x == player1.position.x + widthOfSquare) {
                        if (pieceAi.positionTemp.x == player2.position.x + 2*widthOfSquare && pieceAi.positionTemp.y == player2.position.y) {
                            scoreOfGameState += 4;
                        }
                    }
                    if (pieceAi.positionTemp.x == player1.position.x - widthOfSquare) {
                        if (pieceAi.positionTemp.x == player2.position.x - 2*widthOfSquare && pieceAi.positionTemp.y == player2.position.y) {
                            scoreOfGameState += 4;
                        }
                    }
                }
            }
        }
    }
    
    // Reset this piece's positionTemp to the original
    for (Piece *piece in newArray) {
        if (piece.modelNumber == modelNumber) {
            piece.positionTemp = hello;
        }
    }
    newArray = nil;
    
    return scoreOfGameState;
}

-(void)createTheoreticalGameTree {
    NSMutableArray *aiArray;
    NSMutableArray *opponentArray;
    
    if (isPlayerOneAI && isPlayerOneTurn) {
        aiArray = [[NSMutableArray alloc] initWithArray:playerOnePieces];
        opponentArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces];
        gameStateScoreArray = gameStateScoreArrayCpuOne;
    }else if (isPlayerTwoAI && isPlayerTwoTurn) {
        aiArray = [[NSMutableArray alloc] initWithArray:playerTwoPieces];
        opponentArray = [[NSMutableArray alloc] initWithArray:playerOnePieces];
        gameStateScoreArray = gameStateScoreArrayCpuTwo;
    }
    
    for (Piece *pieceAi in aiArray) {
        
        int squaresAwayWidth;
        int squaresAwayHeight;
        
        if (10 - (pieceAi.positionTemp.x / widthOfSquare) >= pieceAi.positionTemp.x / widthOfSquare) {
            squaresAwayWidth = 10 - (pieceAi.positionTemp.x / widthOfSquare);
        } else (squaresAwayWidth = pieceAi.positionTemp.x / widthOfSquare);
        
        if (12 - (pieceAi.positionTemp.y / heightOfSquare) >= pieceAi.positionTemp.y / heightOfSquare) {
            squaresAwayHeight = 12 - (pieceAi.positionTemp.y / heightOfSquare);
        } else (squaresAwayHeight = pieceAi.positionTemp.y / heightOfSquare);
        
        CGPoint tempPieceLocation = pieceAi.position;
        
        // Check the piece's original position
        // Create a copy of the temp piece in a new memory location
        Piece *pieceAiTemp = [Piece pawnPieceWithColor:playerTwoColor withAI:YES];
        if (isPlayerOneAI) {
            pieceAiTemp.isPlayer = 1;
        } else if (isPlayerTwoAI) {
            pieceAiTemp.isPlayer = 2;
        }
        pieceAiTemp.modelNumber = pieceAi.modelNumber;
        pieceAiTemp.position = ccp(pieceAi.position.x, pieceAi.position.y);
        
        // Set the new temp piece's score and positionTemp
        pieceAiTemp.positionTemp = ccp(tempPieceLocation.x, pieceAiTemp.position.y);
        pieceAiTemp.gameStateScore = [self retrieveGameStateScore:pieceAiTemp.positionTemp withModelNumber:pieceAiTemp.modelNumber];
        aiMoveNumber += 1;
        pieceAiTemp.moveNumber = aiMoveNumber;
        //NSLog(@"pieceAi.positionTemp = %f,%f with score %d",pieceAiTemp.positionTemp.x,pieceAiTemp.positionTemp.y,pieceAiTemp.gameStateScore);
        
        [gameStateScoreArray addObject:pieceAiTemp];
        
        // Check Left Squares
        for (int squaresLeft = 1; squaresLeft <= squaresAwayWidth; squaresLeft += 1) {
            CGPoint tempPieceLocation = pieceAi.position;
            tempPieceLocation.x -= (squaresLeft*widthOfSquare);
            
            for (Piece *piecePlayer1 in opponentArray) {
                for (Piece *piecePlayerAI in aiArray) {
                    if ((tempPieceLocation.x == piecePlayer1.position.x && tempPieceLocation.y == piecePlayer1.position.y) || (tempPieceLocation.x == piecePlayerAI.position.x && tempPieceLocation.y == piecePlayerAI.position.y)) {
                        goto breakOutOfMovingLeftForLoop;
                    }
                    if (pieceAi.positionTemp.x <= 0) {
                        goto breakOutOfMovingLeftForLoop;
                    }
                }
            }
            
            // Create a copy of the temp piece in a new memory location
            Piece *pieceAiTemp = [Piece pawnPieceWithColor:playerTwoColor withAI:YES];
            if (isPlayerOneAI) {
                pieceAiTemp.isPlayer = 1;
            } else if (isPlayerTwoAI) {
                pieceAiTemp.isPlayer = 2;
            }
            pieceAiTemp.modelNumber = pieceAi.modelNumber;
            pieceAiTemp.position = ccp(pieceAi.position.x, pieceAi.position.y);
            
            // Set the new temp piece's score and positionTemp
            pieceAiTemp.positionTemp = ccp(tempPieceLocation.x, pieceAiTemp.position.y);
            pieceAiTemp.gameStateScore = [self retrieveGameStateScore:pieceAiTemp.positionTemp withModelNumber:pieceAiTemp.modelNumber];
            aiMoveNumber += 1;
            pieceAiTemp.moveNumber = aiMoveNumber;
            //NSLog(@"pieceAi.positionTemp = %f,%f with score %d",pieceAiTemp.positionTemp.x,pieceAiTemp.positionTemp.y,pieceAiTemp.gameStateScore);
            
            [gameStateScoreArray addObject:pieceAiTemp];
            
        }breakOutOfMovingLeftForLoop:;
        
        
        // Check Right Squares
        for (int squaresRight = 1; squaresRight <= squaresAwayWidth; squaresRight += 1) {
            CGPoint tempPieceLocation = pieceAi.position;
            tempPieceLocation.x += (squaresRight*widthOfSquare);
            
            for (Piece *piecePlayer1 in opponentArray) {
                for (Piece *piecePlayerAI in aiArray) {
                    if ((tempPieceLocation.x == piecePlayer1.position.x && tempPieceLocation.y == piecePlayer1.position.y) || (tempPieceLocation.x == piecePlayerAI.position.x && tempPieceLocation.y == piecePlayerAI.position.y)) {
                        goto breakOutOfMovingRightForLoop;
                    }
                    if (tempPieceLocation.x >= screenSize.width) {
                        goto breakOutOfMovingRightForLoop;
                    }
                }
            }
            
            // Create a copy of the temp piece in a new memory location
            Piece *pieceAiTemp = [Piece pawnPieceWithColor:playerTwoColor withAI:YES];
            if (isPlayerOneAI) {
                pieceAiTemp.isPlayer = 1;
            } else if (isPlayerTwoAI) {
                pieceAiTemp.isPlayer = 2;
            }
            pieceAiTemp.modelNumber = pieceAi.modelNumber;
            pieceAiTemp.position = ccp(pieceAi.position.x, pieceAi.position.y);
            
            // Set the new temp piece's score and positionTemp
            pieceAiTemp.positionTemp = ccp(tempPieceLocation.x, pieceAiTemp.position.y);
            pieceAiTemp.gameStateScore = [self retrieveGameStateScore:pieceAiTemp.positionTemp withModelNumber:pieceAiTemp.modelNumber];
            aiMoveNumber += 1;
            pieceAiTemp.moveNumber = aiMoveNumber;
            //NSLog(@"pieceAi.positionTemp = %f,%f with score %d",pieceAiTemp.positionTemp.x,pieceAiTemp.positionTemp.y,pieceAiTemp.gameStateScore);
            
            [gameStateScoreArray addObject:pieceAiTemp];
            
        }breakOutOfMovingRightForLoop:;
        
        
        // Check Up Squares
        for (int squaresUp = 1; squaresUp <= squaresAwayHeight; squaresUp += 1) {
            CGPoint tempPieceLocation = pieceAi.position;
            tempPieceLocation.y += (squaresUp*heightOfSquare);
            
            for (Piece *piecePlayer1 in opponentArray) {
                for (Piece *piecePlayerAI in aiArray) {
                    if ((tempPieceLocation.x == piecePlayer1.position.x && tempPieceLocation.y == piecePlayer1.position.y) || (tempPieceLocation.x == piecePlayerAI.position.x && tempPieceLocation.y == piecePlayerAI.position.y)) {
                        goto breakOutOfMovingUpForLoop;
                    }
                    if (tempPieceLocation.y >= screenSize.height) {
                        goto breakOutOfMovingUpForLoop;
                    }
                }
            }
            
            // Create a copy of the temp piece in a new memory location
            Piece *pieceAiTemp = [Piece pawnPieceWithColor:playerTwoColor withAI:YES];
            if (isPlayerOneAI) {
                pieceAiTemp.isPlayer = 1;
            } else if (isPlayerTwoAI) {
                pieceAiTemp.isPlayer = 2;
            }
            pieceAiTemp.modelNumber = pieceAi.modelNumber;
            pieceAiTemp.position = ccp(pieceAi.position.x, pieceAi.position.y);
            
            // Set the new temp piece's score and positionTemp
            pieceAiTemp.positionTemp = ccp(pieceAiTemp.position.x, tempPieceLocation.y);
            pieceAiTemp.gameStateScore = [self retrieveGameStateScore:pieceAiTemp.positionTemp withModelNumber:pieceAiTemp.modelNumber];
            aiMoveNumber += 1;
            pieceAiTemp.moveNumber = aiMoveNumber;
            //NSLog(@"pieceAi.positionTemp = %f,%f with score %d",pieceAiTemp.positionTemp.x,pieceAiTemp.positionTemp.y,pieceAiTemp.gameStateScore);
            
            [gameStateScoreArray addObject:pieceAiTemp];
            
        }breakOutOfMovingUpForLoop:;
        
        
        // Check Down Squares
        for (int squaresDown = 1; squaresDown <= squaresAwayHeight; squaresDown += 1) {
            CGPoint tempPieceLocation = pieceAi.position;
            tempPieceLocation.y -= (squaresDown*heightOfSquare);
            
            for (Piece *piecePlayer1 in opponentArray) {
                for (Piece *piecePlayerAI in aiArray) {
                    if ((tempPieceLocation.x == piecePlayer1.position.x && tempPieceLocation.y == piecePlayer1.position.y) || (tempPieceLocation.x == piecePlayerAI.position.x && tempPieceLocation.y == piecePlayerAI.position.y)) {
                        goto breakOutOfMovingDownForLoop;
                    }
                    if (tempPieceLocation.y <= 0) {
                        goto breakOutOfMovingDownForLoop;
                    }
                }
            }
            
            // Create a copy of the temp piece in a new memory location
            Piece *pieceAiTemp = [Piece pawnPieceWithColor:playerTwoColor withAI:YES];
            if (isPlayerOneAI) {
                pieceAiTemp.isPlayer = 1;
            } else if (isPlayerTwoAI) {
                pieceAiTemp.isPlayer = 2;
            }
            pieceAiTemp.modelNumber = pieceAi.modelNumber;
            pieceAiTemp.position = ccp(pieceAi.position.x, pieceAi.position.y);
            
            // Set the new temp piece's score and positionTemp
            pieceAiTemp.positionTemp = ccp(pieceAiTemp.position.x, tempPieceLocation.y);
            pieceAiTemp.gameStateScore = [self retrieveGameStateScore:pieceAiTemp.positionTemp withModelNumber:pieceAiTemp.modelNumber];
            aiMoveNumber += 1;
            pieceAiTemp.moveNumber = aiMoveNumber;
            //NSLog(@"pieceAi.positionTemp = %f,%f with score %d",pieceAiTemp.positionTemp.x,pieceAiTemp.positionTemp.y,pieceAiTemp.gameStateScore);
            
            [gameStateScoreArray addObject:pieceAiTemp];
            
        }breakOutOfMovingDownForLoop:;
    }
    
    //NSArray *helloWorld = [[NSArray alloc] initWithArray:[gameStateScoreArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"gameStateScorees" ascending:YES]]]];
    NSMutableArray *goodByeWorld = [[NSMutableArray alloc] initWithArray:gameStateScoreArray];
    
    [goodByeWorld sortUsingComparator: ^NSComparisonResult(id a, id b) {
        Piece *pie1 = (Piece *)a;
        Piece *pie2 = (Piece *)b;
        if (pie1.gameStateScore > pie2.gameStateScore) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if (pie1.gameStateScore < pie2.gameStateScore) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    for (Piece *thePiece in goodByeWorld) {
        //NSLog(@"This is hello world array = %d, %d",thePiece.gameStateScore, thePiece.modelNumber);
    }
    
    for (Piece *aiWinner in goodByeWorld) {
        for (Piece *aiPiece in aiArray) {
            //NSLog(@"THIS SHOULD FUCKING WORK ASSHOLE! %d,%d",aiPiece.modelNumber, aiPiece.gameStateScore);
            //NSLog(@"This should fucking work asshole! %d,%d",aiWinner.modelNumber, aiWinner.gameStateScore);
            if (aiWinner.modelNumber == aiPiece.modelNumber) {
                //NSLog(@"THIS SHOULD FUCKING WORK ASSHOLE!!!");
                pieceSelected = aiPiece;
                isPieceSelected = YES;
                if ([self checkRules:aiWinner.positionTemp]) {
                    //NSLog(@"Ai should have moved... %d,%d",aiWinner.gameStateScore,aiWinner.modelNumber);
                    //NSLog(@"Ai222 should have moved... %f,%f | %f,%f",aiWinner.positionTemp.x,aiWinner.positionTemp.y,aiWinner.position.x,aiWinner.position.y);
                    //aiPiece.position = aiWinner.positionTemp;
                    //aiPiece.positionTemp = aiWinner.position;
                    //NSLog(@"Ai333 should have moved... %f,%f | %f,%f",aiWinner.positionTemp.x,aiWinner.positionTemp.y,aiWinner.position.x,aiWinner.position.y);
                    
                    [aiPiece runAction:[CCSequence actions:[CCCallFuncN actionWithTarget:self selector:@selector(disablePlayerAbilityToMove)], [CCMoveTo actionWithDuration:1 position:aiWinner.positionTemp], [CCCallFuncN actionWithTarget:self selector:@selector(checkIfAPlayerCapturedAPiece2)], [CCCallFuncN actionWithTarget:self selector:@selector(enableAiAbilityToMove)], [CCCallFuncN actionWithTarget:self selector:@selector(checkTurn2)], nil]];
                    aiPiece.positionTemp = aiWinner.position;
                    pieceSelected.scale = 1;
                    goto breakOutOfForLoop;
                }
            }
        }
        
    }breakOutOfForLoop:;
    /*
    gameStateScorePieceWinner = [goodByeWorld firstObject];
    pieceSelected = gameStateScorePieceWinner;
    isPieceSelected = YES;
    //NSLog(@"Ai should have moved... %d,%d",gameStateScorePieceWinner.gameStateScore,gameStateScorePieceWinner.modelNumber);
    if ([self checkRules:gameStateScorePieceWinner.positionTemp]) {
        NSLog(@"Ai should have moved... %d,%d",gameStateScorePieceWinner.gameStateScore,gameStateScorePieceWinner.modelNumber);
        NSLog(@"Ai222 should have moved... %f,%f | %f,%f",gameStateScorePieceWinner.positionTemp.x,gameStateScorePieceWinner.positionTemp.y,gameStateScorePieceWinner.position.x,gameStateScorePieceWinner.position.y);
        gameStateScorePieceWinner.position = gameStateScorePieceWinner.positionTemp;
        gameStateScorePieceWinner.positionTemp = gameStateScorePieceWinner.position;
        NSLog(@"Ai333 should have moved... %f,%f | %f,%f",gameStateScorePieceWinner.positionTemp.x,gameStateScorePieceWinner.positionTemp.y,gameStateScorePieceWinner.position.x,gameStateScorePieceWinner.position.y);
        //[gameStateScorePieceWinner runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:gameStateScorePieceWinner.positionTemp], [CCCallFuncN actionWithTarget:self selector:@selector(checkIfAPlayerCapturedAPiece2)], [CCCallFuncN actionWithTarget:self selector:@selector(checkTurn)], nil]];
        //gameStateScorePieceWinner.positionTemp = gameStateScorePieceWinner.position;
        pieceSelected.scale = 1;
    }*/ /*else if (![self checkRules:gameStateScorePieceWinner.positionTemp]) {
        gameStateScorePieceWinner = [gameStateScoreArray objectAtIndex:1];
        pieceSelected = gameStateScorePieceWinner;
        isPieceSelected = YES;
        if ([self checkRules:gameStateScorePieceWinner.positionTemp]) {
            [gameStateScorePieceWinner runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:gameStateScorePieceWinner.positionTemp], [CCCallFuncN actionWithTarget:self selector:@selector(checkIfAPlayerCapturedAPiece2)], [CCCallFuncN actionWithTarget:self selector:@selector(checkTurn)], nil]];
            gameStateScorePieceWinner.positionTemp = gameStateScorePieceWinner.position;
            pieceSelected.scale = 1;
        }
    }*/
    
    for (Piece *hello in goodByeWorld) {
        if (hello.isInDanger) {
            gameStateScorePieceWinner = hello;
        }
    }
    /*
    // Determine the winning piece
    for (Piece *tempPieceX in gameStateScoreArray) {
        NSLog(@"Game State Score = %d, Cooresponding Object = %d, with temp position %f,%f, and real position %f,%f",tempPieceX.gameStateScore, tempPieceX.modelNumber,tempPieceX.positionTemp.x, tempPieceX.positionTemp.y, tempPieceX.position.x, tempPieceX.position.y);
        if (tempPieceX.gameStateScore >= gameStateScore) {
            gameStateScorePieceWinner = tempPieceX;
            gameStateScore = tempPieceX.gameStateScore;
            NSLog(@"The Winner is %d, with game state score %d",gameStateScorePieceWinner.modelNumber, gameStateScorePieceWinner.gameStateScore);
        }
    }*/
    gameStateScore = 0;
    gameStateScoreArray = nil;
    gameStateScoreArray = [[NSMutableArray alloc] init];
    
    /*
    // Move winning piece and check if it captured another piece
    for (Piece *theAiPiece in aiArray) {
        if (theAiPiece.modelNumber == gameStateScorePieceWinner.modelNumber) {
            pieceSelected = theAiPiece;
            isPieceSelected = YES;
            [self determineGuideSquares:pieceSelected];
            if ([self checkRules:gameStateScorePieceWinner.positionTemp]) {
                //isPlayerOneTurn = YES;
                //isPlayerTwoTurn = NO;
                //theAiPiece.position = gameStateScorePieceWinner.positionTemp;
                //[theAiPiece runAction:[CCMoveTo actionWithDuration:1 position:gameStateScorePieceWinner.positionTemp]];
                [theAiPiece runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:gameStateScorePieceWinner.positionTemp], [CCCallFuncN actionWithTarget:self selector:@selector(checkIfAPlayerCapturedAPiece2)], [CCCallFuncN actionWithTarget:self selector:@selector(checkTurn)], nil]];
                theAiPiece.positionTemp = theAiPiece.position;
                pieceSelected.scale = 1;
            } else if (![self checkRules:gameStateScorePieceWinner.positionTemp]) {
                [self deselectPiece];
                isPlayerOneTurn = NO;
                isPlayerTwoTurn = YES;
                [self checkTurn];
            }
            
            break;
        }
    }
    */
    if (isPlayerOneAI && isPlayerOneTurn) {
        playerOnePieces = aiArray;
        aiArray = nil;
        opponentArray = nil;
        gameStateScoreArrayCpuOne = gameStateScoreArray;
    }else if (isPlayerTwoAI && isPlayerTwoTurn) {
        playerTwoPieces = aiArray;
        aiArray = nil;
        opponentArray = nil;
        gameStateScoreArrayCpuTwo = gameStateScoreArray;
    }
    
}

@end
