//
//  BoardGrid.h
//  Latrunculi
//
//  Created by Adam Mellan on 4/15/14.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BoardGrid : CCSprite {
    CGSize screenSize;
}

// Vertical lines
// Vertical Bottom Points
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint1;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint2;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint3;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint4;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint5;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint6;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint7;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint8;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint9;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint10;
@property (nonatomic, assign) CGPoint lineVerticalBottomPoint11;

// Vertical Top Points
@property (nonatomic, assign) CGPoint lineVerticalTopPoint1;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint2;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint3;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint4;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint5;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint6;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint7;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint8;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint9;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint10;
@property (nonatomic, assign) CGPoint lineVerticalTopPoint11;

// Horizontal Lines
// Horizontal Left Points
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint1;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint2;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint3;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint4;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint5;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint6;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint7;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint8;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint9;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint10;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint11;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint12;
@property (nonatomic, assign) CGPoint lineHorizontalLeftPoint13;

// Horizontal Right Points
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint1;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint2;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint3;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint4;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint5;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint6;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint7;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint8;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint9;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint10;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint11;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint12;
@property (nonatomic, assign) CGPoint lineHorizontalRightPoint13;

// Arrays
@property (nonatomic, assign) NSArray *horizontalLeftArray;
@property (nonatomic, assign) NSArray *horizontalRightArray;
@property (nonatomic, assign) NSArray *verticalBottomArray;
@property (nonatomic, assign) NSArray *verticalTopArray;

// Other Variables
@property (nonatomic, assign) float thicknessOfLine;

-(void)createGrid;

@end
