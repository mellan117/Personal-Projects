//
//  ResizeSprite.h
//  Space Commander
//
//  Created by Adam Mellan on 1/6/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResizeSprite : CCSprite {
    
}

-(float)resizeImage;
-(float)resizeLabel;
-(float)resizeBackgroundImage;
-(float)determinePositionX:(float)x;
-(float)determinePositionY:(float)y;
-(NSString *)determineBackgroundImageFileSuffix;

@end
