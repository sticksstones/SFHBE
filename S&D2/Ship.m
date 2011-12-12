//
//  Ship.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import "Ship.h"
#import "CCSprite.h"
#import "GameObjectManager.h"
#import "GameBoardHelper.h"
#import "AbilityManager.h"
#import "BoardManager.h"
#import "Ability.h"
#import "AbilityBlink.h"
#import "AbilityMissile.h"
#import "AbilityHeal.h"

#import "AbilityChainStrike.h"
#import "AbilityFirstStrike.h"
#import "AbilityFog.h"

#define PARAMS_HP 0
#define PARAMS_SP 1
#define PARAMS_AP 2
#define PARAMS_SPRITE 3
#define PARAMS_PROPERTIES 4

#define SHOT_DELAY 2.0

#define ATTACK_DISTANCE 2
#define MOVE_DISTANCE 1
#define kHealthTag 1
#define kAPTag 2
#define kAbilityChargeTag 3

@implementation Ship

@synthesize attackTarget;

- (Ship*)newShip:(NSArray*)params {
  self = [super initWithFile:[params objectAtIndex:PARAMS_SPRITE]];
  if(self) {
    passiveAbilities = [NSMutableDictionary new];
    passiveAbilitiesToRemove = [NSMutableDictionary new];
    
    
    maxHP = [[params objectAtIndex:PARAMS_HP] intValue];
    [self setHp:maxHP];
    [self setSp:[[params objectAtIndex:PARAMS_SP] intValue]];
    [self setAp:[[params objectAtIndex:PARAMS_AP] intValue]];
    
    shotReady = NO;
    performTapAbility = NO;    
    CCLabelTTF* label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d/%d",ap,hp] fontName:@"Helvetica" fontSize:12];
    label.position = CGPointMake(self.contentSize.width, 0);
    [label setTag:kHealthTag];    
    [self addChild:label];
    
    if ([params count] > PARAMS_PROPERTIES) {
      NSDictionary* properties = [params objectAtIndex:PARAMS_PROPERTIES];
      
      for(NSString* ability in [properties objectForKey:@"passiveAbilities"]) {
        id passiveAbility = [[AbilityManager instance] getAbility:ability];
        [passiveAbility setSourceToken:self];
        [passiveAbility performAbility];
      }
      
      tapAbility = [[AbilityManager instance] getAbility:[properties valueForKey:@"tapAbility"]];
      if(tapAbility) {
        [tapAbility setSourceToken:self];
        CCLabelTTF* label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%f",[tapAbility getCurrentCharge]] fontName:@"Helvetica" fontSize:10];
        label.position = CGPointMake(0, 0);
        [label setTag:kAbilityChargeTag];    
        [self addChild:label];
        
      }
    }    
  }
  
  return self;
}

- (void)setAttackTarget:(Ship *)_attackTarget {
  if (attackTarget == _attackTarget) {
    
  }
  else {
    attackTarget = _attackTarget;
    shotReady = NO;    
    
    if(attackTarget) {
      [self performSelector:@selector(resetShot) withObject:nil afterDelay:SHOT_DELAY];      
    }
    [self performPassiveAbilitiesForEvent:@"onEncounter"];
  }
}

- (void)setSp:(int)_sp {
  sp = _sp;
}

- (int)getAp {
  return ap;
}


- (void)setAp:(int)_ap {
  ap = _ap;
  CCLabelTTF* attackLabel = (CCLabelTTF*)[self getChildByTag:kHealthTag];
  [attackLabel setString:[NSString stringWithFormat:@"%d/%d",ap,hp]];
  
}


- (void)setHp:(int)_hp {
  hp = _hp;
  hp = hp > maxHP ? maxHP : hp;  
  CCLabelTTF* healthLabel = (CCLabelTTF*)[self getChildByTag:kHealthTag];
  [healthLabel setString:[NSString stringWithFormat:@"%d/%d",ap,hp]];
}


- (void)setPlayerNum:(int)num {
  playerNum = num;
  self.rotation = num == 1 ? 90 : 270;
  self.color = ccc3(255 * (playerNum == 1 ? 1 : 0), 0, 255 * (playerNum == -1 ? 1 : 0));
  
}

- (void)damage:(int)amount {
  [self setHp:hp-amount];
  [self runAction:[CCSequence actions:[CCActionTween actionWithDuration:0.25 key:@"opacity" from:255 to:128],[CCActionTween actionWithDuration:0.25 key:@"opacity" from:128 to:255],nil]];
}

- (void)heal:(int)amount {
  [self damage:-amount];
}



- (void)boundsCheckPosition {
  
}

- (void)deploy {
  direction = playerNum == 1 ? 1 : -1;  
}



- (void)move {
  [self setPosition:CGPointMake(self.position.x + 0.5*sp * direction, self.position.y)];
  [self boundsCheckPosition];  
}

- (void)attack {
  if (attackTarget != nil && shotReady) {
    [attackTarget damage:ap];
    shotReady = NO;
    [self performSelector:@selector(resetShot) withObject:nil afterDelay:SHOT_DELAY];        
  }
}

- (void)resetShot {
  shotReady = YES;
}

- (bool)checkMoveOK {
  GameToken* closestToken = [[GameObjectManager instance] getClosestGameTokenTo:self enemyOnly:false];
  if (closestToken != nil) {
    if(fabs(closestToken.position.x - self.position.x) <= [[BoardManager instance] getTileSize]) {
      nearestGameToken = closestToken;
      return NO;
    }
  }
  return YES;
  
}

- (bool)checkAttackAvailable {
  GameToken* closestToken = [[GameObjectManager instance] getClosestGameTokenTo:self enemyOnly:true];
  
  if (closestToken != nil) {
    if([self positionRelativeToToken:closestToken] <= ATTACK_DISTANCE) {
      self.attackTarget = (Ship*)closestToken;
      return YES;
    }
    else {
      self.attackTarget = nil;
      return NO;
    }
  }
  else {
    self.attackTarget = nil;
  }
  return NO;
}

- (void)killShip {
  [[GameObjectManager instance] killShip:self];  
}

- (void)update {
  [self purgeExpiredPassiveAbilities];
  
  CGSize winSize = [[CCDirector sharedDirector] winSize];
  if(hp <= 0 || self.position.x < 0 || self.position.x > winSize.width) {
    [self killShip];
  }
  
  if(performTapAbility && tapAbility) {
    [tapAbility performAbility];
    performTapAbility = NO;    
  }
  
  if(tapAbility) {
    CCLabelTTF* label = (CCLabelTTF*)[self getChildByTag:kAbilityChargeTag];
    float currentCharge = [tapAbility getCurrentCharge];
    if(currentCharge <= 0.0) {
      [label setString:[[tapAbility abilityName] uppercaseString]];      
    }
    else {
      [label setString:[NSString stringWithFormat:@"%.1f", currentCharge]];
    }
  }
  
  [self performPassiveAbilitiesForEvent:@"onUpdate"];  
  
  if(![self performPassiveAbilitiesForEvent:@"controlBehavior"]) {
    if([self checkAttackAvailable]) {
      [self attack];    
    }
    if([self checkMoveOK]) {
      [self move];
    }
  }
  
}


- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{	
  CGPoint endPoint = [self convertTouchToNodeSpace:touch];
  
  if (endPoint.y >= 100 && direction == 0) {
    [self deploy];
  }
  else {
    if(endPoint.y <= 20) {
      performTapAbility = YES;
    }
  }
  
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

- (void)purgeExpiredPassiveAbilities {
  NSArray *keys;
  int i, count;
  id key;
  
  keys = [passiveAbilitiesToRemove allKeys];
  count = [keys count];
  for (i = 0; i < count; i++)
  {
    key = [keys objectAtIndex: i];
    NSMutableArray* abilityList = [passiveAbilitiesToRemove objectForKey: key];
    for(id ability in abilityList) {
      [[passiveAbilities objectForKey:key] removeObject:ability];
    }
    
  }
  
  [passiveAbilitiesToRemove removeAllObjects];
}

- (void)removePassiveAbility:(id)ability step:(NSString*)step {
  if([passiveAbilitiesToRemove objectForKey:step] == nil) {
    [passiveAbilitiesToRemove setObject:[NSMutableArray new] forKey:step];
  }
  
  NSMutableArray* abilityList = [passiveAbilitiesToRemove objectForKey:step];
  if(abilityList) {
    [abilityList addObject:ability];
  }
}

- (BOOL)performPassiveAbilitiesForEvent:(NSString*)event {
  BOOL anAbilityPerformed = NO;
  
  for(id ability in [passiveAbilities objectForKey:event]) {
    [ability update];
    anAbilityPerformed = YES;
  }
  
  return anAbilityPerformed;  
}

@end
