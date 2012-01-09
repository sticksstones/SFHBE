//
//  GameMenuLayer.h
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface GameMenuLayer : CCLayer

- (void)gameStartTapped:(id)sender;
- (void)deckBuildTapped:(id)sender;
+(CCScene *) scene;

@end


