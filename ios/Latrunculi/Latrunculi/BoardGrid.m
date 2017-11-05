//
//  BoardGrid.m
//  Latrunculi
//
//  Created by Adam Mellan on 4/15/14.
//
//

#import "BoardGrid.h"

#pragma mark Properties
@implementation BoardGrid

// Vertical lines
// Vertical Bottom Points
@synthesize lineVerticalBottomPoint1;
@synthesize lineVerticalBottomPoint2;
@synthesize lineVerticalBottomPoint3;
@synthesize lineVerticalBottomPoint4;
@synthesize lineVerticalBottomPoint5;
@synthesize lineVerticalBottomPoint6;
@synthesize lineVerticalBottomPoint7;
@synthesize lineVerticalBottomPoint8;
@synthesize lineVerticalBottomPoint9;
@synthesize lineVerticalBottomPoint10;
@synthesize lineVerticalBottomPoint11;
 
// Vertical Top Points
@synthesize lineVerticalTopPoint1;
@synthesize lineVerticalTopPoint2;
@synthesize lineVerticalTopPoint3;
@synthesize lineVerticalTopPoint4;
@synthesize lineVerticalTopPoint5;
@synthesize lineVerticalTopPoint6;
@synthesize lineVerticalTopPoint7;
@synthesize lineVerticalTopPoint8;
@synthesize lineVerticalTopPoint9;
@synthesize lineVerticalTopPoint10;
@synthesize lineVerticalTopPoint11;
 
// Horizontal Lines
// Horizontal Left Points
@synthesize lineHorizontalLeftPoint1;
@synthesize lineHorizontalLeftPoint2;
@synthesize lineHorizontalLeftPoint3;
@synthesize lineHorizontalLeftPoint4;
@synthesize lineHorizontalLeftPoint5;
@synthesize lineHorizontalLeftPoint6;
@synthesize lineHorizontalLeftPoint7;
@synthesize lineHorizontalLeftPoint8;
@synthesize lineHorizontalLeftPoint9;
@synthesize lineHorizontalLeftPoint10;
@synthesize lineHorizontalLeftPoint11;
@synthesize lineHorizontalLeftPoint12;
@synthesize lineHorizontalLeftPoint13;
 
// Horizontal Right Points
@synthesize lineHorizontalRightPoint1;
@synthesize lineHorizontalRightPoint2;
@synthesize lineHorizontalRightPoint3;
@synthesize lineHorizontalRightPoint4;
@synthesize lineHorizontalRightPoint5;
@synthesize lineHorizontalRightPoint6;
@synthesize lineHorizontalRightPoint7;
@synthesize lineHorizontalRightPoint8;
@synthesize lineHorizontalRightPoint9;
@synthesize lineHorizontalRightPoint10;
@synthesize lineHorizontalRightPoint11;
@synthesize lineHorizontalRightPoint12;
@synthesize lineHorizontalRightPoint13;

// Other Variables
@synthesize horizontalLeftArray;
@synthesize horizontalRightArray;
@synthesize verticalBottomArray;
@synthesize verticalTopArray;
@synthesize thicknessOfLine;
#pragma mark

#pragma mark Initialize Board
-(void)createGrid {
    float lineWidthSpacingConstant = screenSize.width / 10;
    float lineHeightSpacingConstant = screenSize.height / 12;
    thicknessOfLine = 6.0;
    
    // Vertical lines
    // Vertical Bottom Points
    lineVerticalBottomPoint1 = ccp(0, 0);
    lineVerticalBottomPoint2 = ccp(lineVerticalBottomPoint1.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint3 = ccp(lineVerticalBottomPoint2.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint4 = ccp(lineVerticalBottomPoint3.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint5 = ccp(lineVerticalBottomPoint4.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint6 = ccp(lineVerticalBottomPoint5.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint7 = ccp(lineVerticalBottomPoint6.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint8 = ccp(lineVerticalBottomPoint7.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint9 = ccp(lineVerticalBottomPoint8.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint10 = ccp(lineVerticalBottomPoint9.x + lineWidthSpacingConstant, 0);
    lineVerticalBottomPoint11 = ccp(lineVerticalBottomPoint10.x + lineWidthSpacingConstant, 0);
    
    // Vertical Top Points
    lineVerticalTopPoint1 = ccp(lineVerticalBottomPoint1.x, screenSize.height);
    lineVerticalTopPoint2 = ccp(lineVerticalBottomPoint2.x, screenSize.height);
    lineVerticalTopPoint3 = ccp(lineVerticalBottomPoint3.x, screenSize.height);
    lineVerticalTopPoint4 = ccp(lineVerticalBottomPoint4.x, screenSize.height);
    lineVerticalTopPoint5 = ccp(lineVerticalBottomPoint5.x, screenSize.height);
    lineVerticalTopPoint6 = ccp(lineVerticalBottomPoint6.x, screenSize.height);
    lineVerticalTopPoint7 = ccp(lineVerticalBottomPoint7.x, screenSize.height);
    lineVerticalTopPoint8 = ccp(lineVerticalBottomPoint8.x, screenSize.height);
    lineVerticalTopPoint9 = ccp(lineVerticalBottomPoint9.x, screenSize.height);
    lineVerticalTopPoint10 = ccp(lineVerticalBottomPoint10.x, screenSize.height);
    lineVerticalTopPoint11 = ccp(lineVerticalBottomPoint11.x, screenSize.height);
    
    // Horizontal Lines
    // Horizontal Left Points
    lineHorizontalLeftPoint1 = ccp(0, 0);
    lineHorizontalLeftPoint2 = ccp(0, lineHorizontalLeftPoint1.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint3 = ccp(0, lineHorizontalLeftPoint2.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint4 = ccp(0, lineHorizontalLeftPoint3.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint5 = ccp(0, lineHorizontalLeftPoint4.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint6 = ccp(0, lineHorizontalLeftPoint5.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint7 = ccp(0, lineHorizontalLeftPoint6.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint8 = ccp(0, lineHorizontalLeftPoint7.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint9 = ccp(0, lineHorizontalLeftPoint8.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint10 = ccp(0, lineHorizontalLeftPoint9.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint11 = ccp(0, lineHorizontalLeftPoint10.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint12 = ccp(0, lineHorizontalLeftPoint11.y + lineHeightSpacingConstant);
    lineHorizontalLeftPoint13 = ccp(0, lineHorizontalLeftPoint12.y + lineHeightSpacingConstant);
    
    // Horizontal Right Points
    lineHorizontalRightPoint1 = ccp(screenSize.width, lineHorizontalLeftPoint1.y);
    lineHorizontalRightPoint2 = ccp(screenSize.width, lineHorizontalLeftPoint2.y);
    lineHorizontalRightPoint3 = ccp(screenSize.width, lineHorizontalLeftPoint3.y);
    lineHorizontalRightPoint4 = ccp(screenSize.width, lineHorizontalLeftPoint4.y);
    lineHorizontalRightPoint5 = ccp(screenSize.width, lineHorizontalLeftPoint5.y);
    lineHorizontalRightPoint6 = ccp(screenSize.width, lineHorizontalLeftPoint6.y);
    lineHorizontalRightPoint7 = ccp(screenSize.width, lineHorizontalLeftPoint7.y);
    lineHorizontalRightPoint8 = ccp(screenSize.width, lineHorizontalLeftPoint8.y);
    lineHorizontalRightPoint9 = ccp(screenSize.width, lineHorizontalLeftPoint9.y);
    lineHorizontalRightPoint10 = ccp(screenSize.width, lineHorizontalLeftPoint10.y);
    lineHorizontalRightPoint11 = ccp(screenSize.width, lineHorizontalLeftPoint11.y);
    lineHorizontalRightPoint12 = ccp(screenSize.width, lineHorizontalLeftPoint12.y);
    lineHorizontalRightPoint13 = ccp(screenSize.width, lineHorizontalLeftPoint13.y);
    
    // Create the static line arrays
    horizontalLeftArray = [[NSArray alloc] initWithObjects:
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint1],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint2],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint3],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint4],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint5],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint6],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint7],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint8],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint9],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint10],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint11],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint12],
                           [NSValue valueWithCGPoint:lineHorizontalLeftPoint13], nil];
    
    horizontalRightArray = [[NSArray alloc] initWithObjects:
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint1],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint2],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint3],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint4],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint5],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint6],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint7],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint8],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint9],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint10],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint11],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint12],
                            [NSValue valueWithCGPoint:lineHorizontalRightPoint13], nil];
    
    verticalBottomArray = [[NSArray alloc] initWithObjects:
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint1],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint2],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint3],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint4],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint5],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint6],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint7],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint8],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint9],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint10],
                           [NSValue valueWithCGPoint:lineVerticalBottomPoint11], nil];
    
    verticalTopArray = [[NSArray alloc] initWithObjects:
                        [NSValue valueWithCGPoint:lineVerticalTopPoint1],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint2],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint3],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint4],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint5],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint6],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint7],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint8],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint9],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint10],
                        [NSValue valueWithCGPoint:lineVerticalTopPoint11], nil];
}

- (id)init
{
    self = [super init];
    if (self) {
        screenSize = [[CCDirector sharedDirector] winSize];
        [self createGrid];
    }
    return self;
}
#pragma mark

@end
