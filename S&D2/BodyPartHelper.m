//
//  BodyPartHelper.m
//  S&D2
//
//  Created by VINIT AGARWAL on 1/7/12.
//  Copyright (c) 2012 sticks+stones games. All rights reserved.
//

#import "BodyPartHelper.h"
#import "InfantrySprite.h"

@implementation BodyPartHelper

+ (int)TagForBodyPart:(NSString*)part {
  if([part isEqualToString:@"weapon"]) {
    return WEAPON_TAG;
  }
  else if([part isEqualToString:@"hat"]) {
    return HAT_TAG;
  }
  else if([part isEqualToString:@"face"]) {
    return FACE_TAG;
  }
  else if([part isEqualToString:@"feet"]) {
    return FOOTL_TAG;
  }
  else if([part isEqualToString:@"body"]) {
    return BODY_TAG;
  }
  else if([part isEqualToString:@"shoulders"]){
      return SHOULDERF_TAG;
  }
  else if([part isEqualToString:@"shield"]){
      return SHIELD_TAG;
  }
  else if([part isEqualToString:@"armor"]){
      return ARMOR_TAG;
  }
  else if([part isEqualToString:@"hand"]){
      return HAND_TAG;
  }
  //TODO: throw an exception instead of returning -1
  return -1;
}

@end
