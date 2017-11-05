//
//  ZeroPlayer.h
//  Latrunculi
//
//  Created by Adam Mellan on 12/23/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ZeroPlayer : CCLayer <UITextFieldDelegate> {
    UITextField *cpu1TextField;
    UITextField *cpu2TextField;
    NSString *playerOneColor;
    NSString *playerTwoColor;
    BOOL isSwitchEnabled;
    BOOL isAI2CurrentTextField;
    CCLabelTTF *cpu1Label;
    CCLabelTTF *cpu2Label;
    CCMenu *swapMenu;
    CCMenuItemImage *redPiece;
    CCMenuItemImage *bluePiece;
}

+(CCScene *)zeroPlayerScene;

@end
