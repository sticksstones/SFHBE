//
//  SideBoardToken.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/31/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "SideBoardToken.h"
#import "Ability.h"
#import "AbilityManager.h"
#define PARAMS_SPRITE 0
#define PARAMS_PROPERTIES 1

@implementation SideBoardToken

@synthesize playerNum;

- (SideBoardToken*)newSideBoardToken:(NSArray*)params {
  self = [super initWithFile:[params objectAtIndex:PARAMS_SPRITE]];
  
  if(self) {
    passiveAbilities = [NSMutableDictionary new];
    
    if ([params count] > PARAMS_PROPERTIES) {
      NSDictionary* properties = [params objectAtIndex:PARAMS_PROPERTIES];
      
      for(NSString* ability in [properties objectForKey:@"passiveAbilities"]) {
        id passiveAbility = [[AbilityManager instance] getAbility:ability];
        [passiveAbility setSourceToken:self];
        [passiveAbility performAbility];
      }      
    }    
  }
  
  return self;

  
}

- (void)addPassiveAbility:(id)ability step:(NSString*)step {
  if([passiveAbilities objectForKey:step] == nil) {
    [passiveAbilities setObject:[NSMutableArray new] forKey:step];
  }
  NSMutableArray* abilityList = [passiveAbilities objectForKey:step];
  id abilityToRemove = nil;
  for(id existingAbility in abilityList) {
    if([existingAbility class] == [ability class]) {
      abilityToRemove = existingAbility;
      break;
    }
  }
  
  if(abilityToRemove) {
    [abilityList removeObject:abilityToRemove];
  }
  
  [abilityList addObject:ability];
  
}

- (BOOL)performPassiveAbilitiesForEvent:(NSString*)event {
  BOOL anAbilityPerformed = NO;
  
  for(id ability in [passiveAbilities objectForKey:event]) {
    [ability update];
    anAbilityPerformed = YES;
  }
  
  return anAbilityPerformed;  
}

- (void)update {
  [self performPassiveAbilitiesForEvent:@"onUpdate"];  
  
}

@end
