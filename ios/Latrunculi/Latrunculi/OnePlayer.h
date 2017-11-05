//
//  OnePlayer.h
//  Latrunculi
//
//  Created by Adam Mellan on 12/2/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface OnePlayer : CCLayer <UITextFieldDelegate> {
    UITextField *playerOneTextField;
    UITextField *cpuTextField;
    NSString *playerOneColor;
    NSString *playerTwoColor;
    BOOL isSwitchEnabled;
    BOOL isAICurrentTextField;
    CCMenu *swapMenu;
    CCMenuItemImage *redPiece;
    CCMenuItemImage *bluePiece;
}

+(CCScene *)onePlayerScene;

@end
