//
//  Piece.m
//  Latrunculi
//
//  Created by Adam Mellan on 4/15/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "Piece.h"

#pragma mark Properties
@implementation Piece
@synthesize isPlayer;
@synthesize isEagle;
@synthesize isPawn;
@synthesize isAI;
@synthesize isInDanger;
@synthesize modelNumber;
@synthesize moveNumber;
@synthesize positionTemp;
@synthesize gameStateScore;
@synthesize canMoveUp;
@synthesize canMoveRight;
@synthesize canMoveDown;
@synthesize canMoveLeft;
@synthesize canMoveUpRight;
@synthesize canMoveDownRight;
@synthesize canMoveDownLeft;
@synthesize canMoveUpLeft;
@synthesize canMoveMultipleSpaces;
@synthesize canPutSelfInDanger;
@synthesize canJumpPieceHorizontally;
@synthesize canJumpPieceVertically;
#pragma mark

#pragma mark - Factory Method
+(Piece *)pawnPieceWithColor:(NSString *)color withAI:(BOOL)isPieceAI {
    Piece *pawnPiece = [Piece spriteWithFile:color];
    
    // If piece can move 90º
    pawnPiece.canMoveUp = YES;
    pawnPiece.canMoveRight = YES;
    pawnPiece.canMoveDown = YES;
    pawnPiece.canMoveLeft = YES;
    
    // If piece can move diagonally
    pawnPiece.canMoveUpRight = NO;
    pawnPiece.canMoveDownRight = NO;
    pawnPiece.canMoveUpLeft = NO;
    pawnPiece.canMoveDownLeft = NO;
    
    // Other options
    pawnPiece.canMoveMultipleSpaces = YES;
    pawnPiece.canPutSelfInDanger = NO;
    pawnPiece.canJumpPieceHorizontally = NO;
    pawnPiece.canJumpPieceVertically = NO;
    pawnPiece.isEagle = NO;
    pawnPiece.isPawn = YES;
    pawnPiece.isAI = isPieceAI;
    pawnPiece.isInDanger = NO;
    
    return pawnPiece;
}

+(Piece *)eaglePieceWithColor:(NSString *)color withAI:(BOOL)isPieceAI {
    Piece *eaglePiece = [Piece spriteWithFile:color];
    
    // If piece can move 90º
    eaglePiece.canMoveUp = YES;
    eaglePiece.canMoveRight = YES;
    eaglePiece.canMoveDown = YES;
    eaglePiece.canMoveLeft = YES;
    
    // If piece can move diagonally
    eaglePiece.canMoveUpRight = YES;
    eaglePiece.canMoveDownRight = YES;
    eaglePiece.canMoveUpLeft = YES;
    eaglePiece.canMoveDownLeft = YES;
    
    // Other options
    eaglePiece.canMoveMultipleSpaces = YES;
    eaglePiece.canPutSelfInDanger = YES;
    eaglePiece.canJumpPieceHorizontally = YES;
    eaglePiece.canJumpPieceVertically = YES;
    eaglePiece.isEagle = YES;
    eaglePiece.isPawn = NO;
    eaglePiece.isAI = isPieceAI;
    eaglePiece.isInDanger = NO;
    
    return eaglePiece;
}
#pragma mark

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
