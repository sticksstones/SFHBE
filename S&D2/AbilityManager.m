//
//  AbilityManager.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/10/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import "AbilityManager.h"
#import "Ability.h"
#import "AbilityHelper.h"

@implementation AbilityManager

static AbilityManager *gInstance = NULL;

+ (AbilityManager *)instance
{
  @synchronized(self)
  {
    if (gInstance == NULL) {
      gInstance = [[self alloc] init];
      [gInstance initManager];
    }
  }
  return(gInstance);
}

- (void)initManager {
  abilities = [NSMutableDictionary new];
  
  NSBundle* bundle = [NSBundle mainBundle];
  NSString* plistFile = [bundle pathForResource:@"AbilityData" ofType:@"plist"];
  
  NSMutableDictionary* plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFile];
    
  NSArray *keys;
  int i, count;
  id key;

  keys = [plist allKeys];
  count = [keys count];
  for (i = 0; i < count; i++)
  {
    key = [keys objectAtIndex: i];
    NSDictionary* ability = [plist objectForKey: key];
    id abilityObj = [AbilityHelper AbilityForType:[ability valueForKey:@"ability"]];
    
    [abilityObj initialize:[NSArray arrayWithObjects:self,self,[ability objectForKey:@"charges"], [ability objectForKey:@"rechargeTime"], [ability objectForKey:@"level"],key,nil]];
    [abilities setObject:abilityObj forKey:(NSString*)key];
  }

}

- (id)getAbility:(NSString *)ability {
  return [[abilities objectForKey:ability] copyAbility];
}


@end
