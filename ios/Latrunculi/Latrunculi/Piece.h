//
//  Piece.h
//  Latrunculi
//
//  Created by Adam Mellan on 4/15/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Piece : CCSprite {
    
}

@property (nonatomic, assign) int isPlayer;
@property (nonatomic, assign) BOOL isEagle;
@property (nonatomic, assign) BOOL isPawn;
@property (nonatomic, assign) BOOL isAI;
@property (nonatomic, assign) BOOL isInDanger;
@property (nonatomic, assign) int modelNumber;
@property (nonatomic, assign) int moveNumber;
@property (nonatomic, assign) CGPoint positionTemp;
@property (nonatomic, assign) int gameStateScore;

@property (nonatomic, assign) BOOL canMoveUp;
@property (nonatomic, assign) BOOL canMoveRight;
@property (nonatomic, assign) BOOL canMoveDown;
@property (nonatomic, assign) BOOL canMoveLeft;

@property (nonatomic, assign) BOOL canMoveUpRight;
@property (nonatomic, assign) BOOL canMoveDownRight;
@property (nonatomic, assign) BOOL canMoveDownLeft;
@property (nonatomic, assign) BOOL canMoveUpLeft;

@property (nonatomic, assign) BOOL canMoveMultipleSpaces;
@property (nonatomic, assign) BOOL canPutSelfInDanger;
@property (nonatomic, assign) BOOL canJumpPieceHorizontally;
@property (nonatomic, assign) BOOL canJumpPieceVertically;

+(Piece *)pawnPieceWithColor:(NSString *)color withAI:(BOOL)isPieceAI;
+(Piece *)eaglePieceWithColor:(NSString *)color withAI:(BOOL)isPieceAI;

@end
