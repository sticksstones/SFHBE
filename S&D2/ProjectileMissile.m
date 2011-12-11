//
//  ProjectileMissile.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "ProjectileMissile.h"

@implementation ProjectileMissile

- (void)onContact {
  [attackTarget damage:ap];
  [self killShip];
}

@end
