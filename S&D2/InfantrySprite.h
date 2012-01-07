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
#define FEET_TAG        3
#define BODY_TAG        4

@interface InfantrySprite : CCNode
{
    NSDictionary* partNames;
}


+(id) infantrySprite:(NSDictionary*)parts;
-(void) walk;
-(void) attack;
-(void) hurt;

@end
