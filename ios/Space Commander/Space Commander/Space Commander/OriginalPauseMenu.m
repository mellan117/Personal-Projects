//
//  OriginalPauseMenu.m
//  Space-Commander
//
//  Created by Adam Mellan on 1/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "OriginalPauseMenu.h"


@implementation OriginalPauseMenu

/*
 -(void)noButtonPressed {
 [_hud hideWarningLabel];
 [_hud hideYesButton];
 [_hud hideNoButton];
 
 [_hud showRestartButton];
 [_hud showQuitButton];
 }
 
 -(void)quitYesButtonPressed {
 [[CCDirector sharedDirector]resume];
 [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MainMenu mainMenuScene] withColor:ccBLACK]];
 }
 
 -(void)quitButtonPressed {
 NSLog(@"\n\nThe Quit Button Pressed\n\n");
 [_hud hideQuitButton];
 [_hud hideRestartButton];
 CCMenuItemFont *yesText = [CCMenuItemFont itemFromString:@"YES"];
 CCMenuItemToggle *yesButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(quitYesButtonPressed) items:yesText, nil];
 yesButton.color = ccGREEN;
 _hud.yes = yesButton;
 
 CCMenuItemFont *noText = [CCMenuItemFont itemFromString:@"NO"];
 CCMenuItemToggle *noButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(noButtonPressed) items:noText, nil];
 noButton.color = ccRED;
 _hud.no = noButton;
 
 [_hud showWarningLabel];
 [_hud showYesButton];
 [_hud showNoButton];
 }
 
 -(void)restartYesButtonPressed {
 [[CCDirector sharedDirector] resume];
 [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Play playScene] withColor:ccBLACK]];
 }
 
 -(void)restartButtonPressed {
 NSLog(@"\n\nThe Restart Button Pressed\n\n");
 [_hud hideQuitButton];
 [_hud hideRestartButton];
 CCMenuItemFont *yesText = [CCMenuItemFont itemFromString:@"YES"];
 CCMenuItemToggle *yesButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(restartYesButtonPressed) items:yesText, nil];
 yesButton.color = ccGREEN;
 _hud.yes = yesButton;
 
 CCMenuItemFont *noText = [CCMenuItemFont itemFromString:@"NO"];
 CCMenuItemToggle *noButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(noButtonPressed) items:noText, nil];
 noButton.color = ccRED;
 _hud.no = noButton;
 
 [_hud showWarningLabel];
 [_hud showYesButton];
 [_hud showNoButton];
 
 }
 
 -(void)resumeMenu {
 NSLog(@"\n\nResume Button Pressed\n\n");
 [[CCDirector sharedDirector]resume];
 CCMenuItemImage *pause = [CCMenuItemImage itemFromNormalImage:@"Pause_Button.png" selectedImage:@"Pause_Button.png" target:self selector:@selector(pauseMenu)];
 pause.anchorPoint = ccp(1, 1);
 _hud.pause = pause;
 [_hud showPauseButton];
 
 [_hud hideYesButton];
 [_hud hideNoButton];
 [_hud hideWarningLabel];
 [_hud hideRestartButton];
 [_hud hideQuitButton];
 [_hud hideDimScreen];
 }
 
 -(void)pauseMenu {
 [[CCDirector sharedDirector] pause];
 
 NSLog(@"\n\nPause Button Pressed\n\n");
 
 CCMenuItemFont *restartText = [CCMenuItemFont itemFromString:@"Restart"];
 CCMenuItemToggle *restartButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(restartButtonPressed) items:restartText, nil];
 restartButton.position = ccp(screenSize.width/2, screenSize.height/2 + 30);
 _hud.restart = restartButton;
 [_hud showRestartButton];
 
 CCMenuItemImage *resume = [CCMenuItemImage itemFromNormalImage:@"Play_Button.png" selectedImage:@"Play_Button.png" target:self selector:@selector(resumeMenu)];
 resume.anchorPoint = ccp(1, 1);
 _hud.resume = resume;
 [_hud showResumeButton];
 
 CCMenuItemFont *quitText = [CCMenuItemFont itemFromString:@"Quit"];
 CCMenuItemToggle *quitButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(quitButtonPressed) items:quitText, nil];
 quitButton.position = ccp(screenSize.width/2, screenSize.height/2 - 30);
 _hud.quit = quitButton;
 [_hud showQuitButton];
 
 CCSprite *dim = [CCSprite spriteWithFile:@"Dim_Screen.png"];
 
 _hud.dim = dim;
 [_hud showDimScreen];
 }
 */

@end
