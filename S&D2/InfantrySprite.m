//
//  InfantrySprite.m
//  AnimationTest
//
//  Created by Ethan Benanav on 1/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InfantrySprite.h"
#import "CCAnimationHelper.h"


#define SHIELD_DEPTH    100
#define HAND_DEPTH      90
#define WEAPON_DEPTH    80
#define HAT_DEPTH       70
#define SHLDRF_DEPTH    60
#define FACE_DEPTH      50
#define FEET_DEPTH      40
#define ARMOR_DEPTH     30
#define BODY_DEPTH      20
#define SHLDRB_DEPTH    10

#define DELAY           0.0167f

#define IDLE_COUNT      0
#define WALK_COUNT      45
#define ATTACK_COUNT    15
#define HURT_COUNT      2

@implementation InfantrySprite

-(void) addBodyPartWithFrame:(NSString*)frame atDepth:(int)z withTag:(int)tag
{
    if(frame != nil)
    {
        CCSprite* part = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@.png", frame]];
        [self addChild:part z:z tag:tag];
    }
}

-(id) initWithAnimations:(NSDictionary*)parts
{
	// Loading the Ship's sprite using a sprite frame name (eg the filename)
	if ((self = [super init]))
	{
        partNames = parts;
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:HAT_TAG]] atDepth:HAT_DEPTH withTag:HAT_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:FACE_TAG]] atDepth:FACE_DEPTH withTag:FACE_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:WEAPON_TAG]] atDepth:WEAPON_DEPTH withTag:WEAPON_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:BODY_TAG]] atDepth:BODY_DEPTH withTag:BODY_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:ARMOR_TAG]] atDepth:ARMOR_DEPTH withTag:ARMOR_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:SHIELD_TAG]] atDepth:SHIELD_DEPTH withTag:SHIELD_TAG];
        [self addBodyPartWithFrame:[parts objectForKey:[NSNumber numberWithInt:HAND_TAG]] atDepth:HAND_DEPTH withTag:HAND_TAG];
        
        //Special Cases
        
        if([parts objectForKey:[NSNumber numberWithInt:FOOTL_TAG]] != nil){
            NSString* footL = [NSString stringWithFormat:@"%@L",[parts objectForKey:[NSNumber numberWithInt:FOOTL_TAG]]];
            NSString* footR = [NSString stringWithFormat:@"%@R",[parts objectForKey:[NSNumber numberWithInt:FOOTL_TAG]]];
            [self addBodyPartWithFrame:footL atDepth:FEET_DEPTH withTag:FOOTL_TAG];
            [self addBodyPartWithFrame:footR atDepth:FEET_DEPTH withTag:FOOTR_TAG];
        }
        
        if([parts objectForKey:[NSNumber numberWithInt:SHOULDERF_TAG]] != nil){
            NSString* shoulderF = [NSString stringWithFormat:@"%@F",[parts objectForKey:[NSNumber numberWithInt:SHOULDERF_TAG]]];
            NSString* shoulderB = [NSString stringWithFormat:@"%@B",[parts objectForKey:[NSNumber numberWithInt:SHOULDERF_TAG]]];
            [self addBodyPartWithFrame:shoulderF atDepth:SHLDRF_DEPTH withTag:SHOULDERF_TAG];
            [self addBodyPartWithFrame:shoulderB atDepth:SHLDRB_DEPTH withTag:SHOULDERB_TAG];
        }
	}
	return self;
}


-(void) walk
{

}

-(void) attack
{

}

-(void) hurt
{
 
}

+(id) infantrySprite:(NSDictionary*)parts
{
	return [[[self alloc] initWithAnimations:parts] autorelease];
}


/** DEPRECATED
-(void) cacheAnimationWithFrame:(NSString*)frame forAction:(NSString*)action withCount:(int)frameCount {
    NSString* name = [NSString stringWithFormat:@"%@-%@", frame, action];
    if( [[CCAnimationCache sharedAnimationCache] animationByName:name] == nil )
    {
        CCAnimation* animation =   [CCAnimation animationWithFrame:name frameCount:frameCount delay:DELAY];
        [[CCAnimationCache sharedAnimationCache] addAnimation:animation name:name];
    }
}


-(void) runActionWithName:(NSString*)actionName loops:(BOOL)repeat
{
    for(NSNumber* key in [partNames allKeys])
    {
        int tag = [key intValue];
        NSString* partName = [partNames objectForKey:key];
        
        CCAnimation* animation = [[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"%@-%@",partName,actionName]];
        CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
        
        CCSprite* partSprite = (CCSprite*)[self getChildByTag:tag];
        if(repeat)
        {
            CCRepeatForever* repeatForever = [CCRepeatForever actionWithAction:animate];
            [partSprite runAction:repeatForever];
        } else 
        {
            [partSprite runAction:animate];
        }
        
    }
}
*/
@end
