//
//  TwoPlayer.h
//  Latrunculi
//
//  Created by Adam Mellan on 12/2/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TwoPlayer : CCLayer <UITextFieldDelegate> {
    UITextField *playerOneTextField;
    UITextField *playerTwoTextField;
    NSString *playerOneColor;
    NSString *playerTwoColor;
    BOOL isSwitchEnabled;
    BOOL isP2CurrentTextField;
    CCMenu *swapMenu;
    CCMenuItemImage *redPiece;
    CCMenuItemImage *bluePiece;
}

+(CCScene *)twoPlayerScene;

@end
