//
//  Play.h
//  Latrunculi
//
//  Created by Adam Mellan on 2/26/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Piece.h"
#import "GameMode.h"

@interface Play : CCLayer {
    NSMutableArray *pieces;
    NSMutableArray *playerOnePieces;
    NSMutableArray *playerTwoPieces;
    NSMutableArray *gameStateScoreArray;
    NSMutableArray *gameStateScoreArrayCpuOne;
    NSMutableArray *gameStateScoreArrayCpuTwo;
    
    NSMutableArray *guideSquaresRightArray;
    NSMutableArray *guideSquaresLeftArray;
    NSMutableArray *guideSquaresUpArray;
    NSMutableArray *guideSquaresDownArray;
    NSMutableArray *guideSquaresUpRightArray;
    NSMutableArray *guideSquaresUpLeftArray;
    NSMutableArray *guideSquaresDownRightArray;
    NSMutableArray *guideSquaresDownLeftArray;
    
    CCLabelTTF *p1BoardNumberOfRemainingPlayerOnePiecesLabel;
    CCLabelTTF *p1BoardNumberOfRemainingPlayerTwoPiecesLabel;
    CCLabelTTF *p2BoardNumberOfRemainingPlayerOnePiecesLabel;
    CCLabelTTF *p2BoardNumberOfRemainingPlayerTwoPiecesLabel;
    
    int numberOfRemainingPlayerOnePiecesInt;
    int numberOfRemainingPlayerTwoPiecesInt;
    
    Piece *gameStateScorePieceWinner;
    int gameStateScore;
    int aiMoveNumber;
    
    BOOL isPieceSelected;
    BOOL isPlayerOneTurn;
    BOOL isPlayerTwoTurn;
    BOOL isPlayerOneAI;
    BOOL isPlayerTwoAI;
    BOOL didUserMove;
    BOOL isPieceMoving;
    BOOL isGuideSquares;
    BOOL isTouchForPauseMenu;
    
    int numberOfGuideSquaresRight;
    int numberOfGuideSquaresLeft;
    int numberOfGuideSquaresUp;
    int numberOfGuideSquaresDown;
    int numberOfGuideSquaresUpRight;
    int numberOfGuideSquaresUpLeft;
    int numberOfGuideSquaresDownRight;
    int numberOfGuideSquaresDownLeft;
    
    Piece *pieceSelected;
    Piece *eaglePlayerOne;
    Piece *eaglePlayerTwo;
    
    CGSize screenSize;
    CGPoint theLocation;
    
    float widthOfSquare;
    float heightOfSquare;
    
    NSString *playerOneColor;
    NSString *playerTwoColor;
    
    CGPoint firstTouch;
    CGPoint lastTouch;
    CGPoint tempGuideLinesPieceLocation;
}

@property (nonatomic, assign) Mode mode;
@property (nonatomic, retain) NSMutableArray *guideSquaresAllArray;

+(CCScene *)playSceneWithMode:(Mode)gameModeInt withPlayerOneColor:(NSString *)p1Color andPlayerTwoColor:(NSString *)p2Color;
-(BOOL)checkRules:(CGPoint)touchLocation;
-(void)pausePlayScene;
-(void)resumePlayScene;

@end
