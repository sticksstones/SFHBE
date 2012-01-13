//
//  InfantrySprite.h
//  AnimationTest
//
//  Created by Ethan Benanav on 1/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define WEAPON_TAG      0
#define HAT_TAG         1
#define FACE_TAG        2
#define FOOTL_TAG       3
#define FOOTR_TAG       4
#define BODY_TAG        5
#define ARMOR_TAG       6
#define SHIELD_TAG      7
#define SHOULDERF_TAG   8
#define SHOULDERB_TAG   9
#define HAND_TAG        10

@interface InfantrySprite : CCNode
{
    NSDictionary* partNames;
}

/**
 * Initialize the infantry sprite with a dictionary of parts.
 */
+(id) infantrySprite:(NSDictionary*)parts;
-(void) reset;
-(void) walk;
-(void) attack;
-(void) hurt;

@end
