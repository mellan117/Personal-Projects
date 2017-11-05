//
//  ResizeSprite.m
//  Space Commander
//
//  Created by Adam Mellan on 1/6/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "ResizeSprite.h"


@implementation ResizeSprite


#pragma mark - Position
-(float)determinePositionX:(float)x {
    NSString *deviceType = [UIDevice currentDevice].model;
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat deviceWidthInPixel = screen.size.width * scaleFactor;
    CGFloat deviceHeightInPixel = screen.size.height * scaleFactor;
    //BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    
    if ([deviceType isEqual:@"iPhone"]) {
        if (iPhone.width == deviceWidthInPixel && iPhone.height == deviceHeightInPixel) {
            
        } else if (iPhoneR.width == deviceWidthInPixel && iPhoneR.height == deviceHeightInPixel) {
            
        } else if (iPhoneRW.width == deviceWidthInPixel && iPhoneRW.height == deviceHeightInPixel) {
            //x *= 1.109;
            //x /= 2;
            x *= 0.554;
        }
    }
    
    if ([deviceType isEqual:@"iPad"]) {
        if (iPad.width == deviceWidthInPixel && iPad.height == deviceHeightInPixel) {
            x = x;
        } else if (iPadR.width == deviceWidthInPixel && iPadR.height == deviceHeightInPixel) {
            x *= 2;
        }
    }
    
    /*
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
    } */
    
    return x;
}

-(float)determinePositionY:(float)y {
    NSString *deviceType = [UIDevice currentDevice].model;
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat deviceWidthInPixel = screen.size.width * scaleFactor;
    CGFloat deviceHeightInPixel = screen.size.height * scaleFactor;
    //BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    
    if ([deviceType isEqual:@"iPhone"]) {
        if (iPhone.width == deviceWidthInPixel && iPhone.height == deviceHeightInPixel) {
            
        } else if (iPhoneR.width == deviceWidthInPixel && iPhoneR.height == deviceHeightInPixel) {
            
        } else if (iPhoneRW.width == deviceWidthInPixel && iPhoneRW.height == deviceHeightInPixel) {
            //y *= 0.833;
            //y /= 2;
            y *= 0.416;
        }
    }
    
    if ([deviceType isEqual:@"iPad"]) {
        if (iPad.width == deviceWidthInPixel && iPad.height == deviceHeightInPixel) {
            y = y;
        } else if (iPadR.width == deviceWidthInPixel && iPadR.height == deviceHeightInPixel) {
            y *= 2;
        }
    }
    
    /*
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
    } */
    
    return y;
}
#pragma mark

#pragma mark - Resize Label
-(float)resizeLabel {
    NSString *deviceType = [UIDevice currentDevice].model;
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGRect screen = [[UIScreen mainScreen] bounds];
    int deviceWidthInPixel = screen.size.width * scaleFactor;
    int deviceHeightInPixel = screen.size.height * scaleFactor;
    float scale;
    //BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    NSLog(@"!!! The device type = %@, the device = %@, its resolution = %d,%d",deviceType,[UIDevice currentDevice],deviceWidthInPixel,deviceHeightInPixel);
    NSLog(@"Ya Know = %d,%d",iPhoneRW.width,iPhoneRW.height);
    if ([deviceType isEqual:@"iPhone"]) {
        if (iPhone.width == deviceWidthInPixel && iPhone.height == deviceHeightInPixel) {
            NSLog(@"DEBUG TEST");
        } else if (iPhoneR.width == deviceWidthInPixel && iPhoneR.height == deviceHeightInPixel) {
            NSLog(@"DEBUG TEST");
        } else if (iPhoneRW.width == deviceWidthInPixel && iPhoneRW.height == deviceHeightInPixel) {
            scale = 1;
            NSLog(@"DEBUG TEST");
        } else if (iPhone6P.width == deviceWidthInPixel && iPhone6P.height == deviceHeightInPixel) {
            NSLog(@"DEBUG TEST");
        }
    }
    
    if ([deviceType isEqual:@"iPad"]) {
        if (iPad.width == deviceWidthInPixel && iPad.height == deviceHeightInPixel) {
            scale = 2;
        } else if (iPadR.width == deviceWidthInPixel && iPadR.height == deviceHeightInPixel) {
            scale = 4;
        }
    }
    
    /*
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
    } */
    
    return scale;
}
#pragma mark

#pragma mark - Resize Image
-(float)resizeImage {
    NSString *deviceType = [UIDevice currentDevice].model;
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat deviceWidthInPixel = screen.size.width * scaleFactor;
    CGFloat deviceHeightInPixel = screen.size.height * scaleFactor;
    float scale;
    //BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    
    /*
     typedef enum {
     width,
     height,
     }device;
     
     device iPhone;
     */
    
    if ([deviceType isEqual:@"iPhone"]) {
        if (iPhone.width == deviceWidthInPixel && iPhone.height == deviceHeightInPixel) {
            scale = 0.156;
        } else if (iPhoneR.width == deviceWidthInPixel && iPhoneR.height == deviceHeightInPixel) {
            scale = 0.312;
        } else if (iPhoneRW.width == deviceWidthInPixel && iPhoneRW.height == deviceHeightInPixel) {
            scale = 0.312;
        }
    }
    
    if ([deviceType isEqual:@"iPad"]) {
        if (iPad.width == deviceWidthInPixel && iPad.height == deviceHeightInPixel) {
            scale = 0.5;
        } else if (iPadR.width == deviceWidthInPixel && iPadR.height == deviceHeightInPixel) {
            scale = 1;
        }
    }
    
    
    /*
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
    }*/
    
    return scale;
}

-(float)resizeBackgroundImage {
    NSString *deviceType = [UIDevice currentDevice].model;
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat deviceWidthInPixel = screen.size.width * scaleFactor;
    CGFloat deviceHeightInPixel = screen.size.height * scaleFactor;
    float scale;
    //BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    
    if ([deviceType isEqual:@"iPhone"]) {
        if (iPhone.width == deviceWidthInPixel && iPhone.height == deviceHeightInPixel) {
            
        } else if (iPhoneR.width == deviceWidthInPixel && iPhoneR.height == deviceHeightInPixel) {
            
        } else if (iPhoneRW.width == deviceWidthInPixel && iPhoneRW.height == deviceHeightInPixel) {
            scale = 1;
        }
    }
    
    if ([deviceType isEqual:@"iPad"]) {
        if (iPad.width == deviceWidthInPixel && iPad.height == deviceHeightInPixel) {
            scale = 0.5;
        } else if (iPadR.width == deviceWidthInPixel && iPadR.height == deviceHeightInPixel) {
            scale = 1;
        }
    }
    
    /*
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
    } */
    
    return scale;
}
#pragma mark

#pragma mark - Background File Suffix
-(NSString *)determineBackgroundImageFileSuffix {
    NSString *deviceType = [UIDevice currentDevice].model;
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat deviceWidthInPixel = screen.size.width * scaleFactor;
    CGFloat deviceHeightInPixel = screen.size.height * scaleFactor;
    NSString *imageSuffix;
    //BOOL isRetina = [[UIScreen mainScreen] scale] >= 2;
    
    if ([deviceType isEqual:@"iPhone"]) {
        if (iPhone.width == deviceWidthInPixel && iPhone.height == deviceHeightInPixel) {
            
        } else if (iPhoneR.width == deviceWidthInPixel && iPhoneR.height == deviceHeightInPixel) {
            
        } else if (iPhoneRW.width == deviceWidthInPixel && iPhoneRW.height == deviceHeightInPixel) {
            imageSuffix = @"_iPhone_RW";
        }
    }
    
    if ([deviceType isEqual:@"iPad"]) {
        if (iPad.width == deviceWidthInPixel && iPad.height == deviceHeightInPixel) {
            imageSuffix = @"_iPad_R";
        } else if (iPadR.width == deviceWidthInPixel && iPadR.height == deviceHeightInPixel) {
            imageSuffix = @"_iPad_R";
        }
    }
    
    /*
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
    } */
    
    return imageSuffix;
}
#pragma mark

-(id) init {
	if( (self=[super init])) {
        iPhone.height = 320.0;
        iPhone.width = 480.0;
        
        iPhoneR.height = 640.0;
        iPhoneR.width = 960.0;
        
        iPhoneRW.height = 640.000000;
        iPhoneRW.width = 1136.000000;
        
        iPhone6P.height = 1080.0;
        iPhone6P.width = 1920.0;
        
        iPad.height = 768.0;
        iPad.width = 1024;
        
        iPadR.height = 1536;
        iPadR.width = 2048.0;
    }
    return self;
}

@end
