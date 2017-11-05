//
//  ResizeSprite.m
//  Space Commander
//
//  Created by Adam Mellan on 1/6/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "ResizeSprite.h"


@implementation ResizeSprite


-(float)determinePositionX:(float)x {
    NSString *deviceType = [UIDevice currentDevice].model;
    BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    
    if ([deviceType  isEqual: @"iPhone"]) {
        if (isRetina) {
            x *= 1.109;
            x /= 2;
        } else if (!isRetina) {
            
        }
    } else if ([deviceType isEqual:@"iPad"]) {
        if (isRetina) {
            x *= 2;
        } else if (!isRetina) {
            x = x;
        }
    }
    return x;
}

-(float)determinePositionY:(float)y {
    NSString *deviceType = [UIDevice currentDevice].model;
    BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    
    if ([deviceType  isEqual: @"iPhone"]) {
        if (isRetina) {
            y *= 0.833;
            y /= 2;
        } else if (!isRetina) {
            
        }
    } else if ([deviceType isEqual:@"iPad"]) {
        if (isRetina) {
            y *= 2;
        } else if (!isRetina) {
            y = y;
        }
    }
    return y;
}

-(float)resizeImage {
    NSString *deviceType = [UIDevice currentDevice].model;
    BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    float scale;
    
    if ([deviceType  isEqual: @"iPhone"]) {
        if (isRetina) {
            //y = 0.277;
            //y = 0.416;
            scale = 0.312;
        } else if (!isRetina) {
            //y = 0.46875;
        }
    } else if ([deviceType isEqual:@"iPad"]) {
        if (isRetina) {
            scale = 1;
        } else if (!isRetina) {
            scale = 0.5;
        }
    }
    return scale;
}

-(float)resizeLabel {
    NSString *deviceType = [UIDevice currentDevice].model;
    BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    float scale;
    
    if ([deviceType  isEqual: @"iPhone"]) {
        if (isRetina) {
            scale = 1;
        } else if (!isRetina) {
            
        }
    } else if ([deviceType isEqual:@"iPad"]) {
        if (isRetina) {
            scale = 4;
        } else if (!isRetina) {
            scale = 2;
        }
    }
    return scale;
}

-(float)resizeBackgroundImage {
    NSString *deviceType = [UIDevice currentDevice].model;
    BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    float scale;
    
    if ([deviceType  isEqual: @"iPhone"]) {
        if (isRetina) {
            scale = 1;
        } else if (!isRetina) {
            scale = 0.5;
        }
    } else if ([deviceType isEqual:@"iPad"]) {
        if (isRetina) {
            scale = 1;
        } else if (!isRetina) {
            scale = 0.5;
        }
    }
    return scale;
}

-(NSString *)determineBackgroundImageFileSuffix {
    NSString *deviceType = [UIDevice currentDevice].model;
    BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    NSString *imageSuffix;
    
    if ([deviceType  isEqual: @"iPhone"]) {
        if (isRetina) {
            imageSuffix = @"_iPhone_RW";
        } else if (!isRetina) {
            
        }
    } else if ([deviceType isEqual:@"iPad"]) {
        if (isRetina) {
            imageSuffix = @"_iPad_R";
        } else if (!isRetina) {
            imageSuffix = @"_iPad_R";
        }
    }
    return imageSuffix;
}

-(id) init {
	if( (self=[super init])) {
        
    }
    return self;
}

@end
