//
//  Mana.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "GameToken.h"

@interface Mana : GameToken {
  int amount;
  float elapsedTime;
}
- (void)initialize;
- (void)setManaAmount:(int)_amount;

@end
