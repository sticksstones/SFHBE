//
//  Ship.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/3/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameToken.h"

@class Ability;

@interface Ship : GameToken {
  int hp;
  int sp;
  int ap;
  int maxHP;
  Ship* attackTarget;
  GameToken* nearestGameToken;
  id tapAbility;
  bool shotReady;
  bool performTapAbility;
  
  NSMutableDictionary* passiveAbilities;
  NSMutableDictionary* passiveAbilitiesToRemove;
  
}

@property (nonatomic, retain) Ship* attackTarget;

- (void)setHp:(int)_hp;
- (void)setSp:(int)_sp;
- (void)setAp:(int)_ap;
- (int)getAp;
- (void)killShip;
- (Ship*)newShip:(NSArray*)params;
- (bool)checkMoveOK;
- (void)move;
- (void)damage:(int)amount;
- (void)heal:(int)amount;
- (bool)checkAttackAvailable;
- (void)attack;
- (void)update;
- (void)resetShot;
- (void)deploy;
- (void)addPassiveAbility:(id)ability step:(NSString*)step;
- (void)purgeExpiredPassiveAbilities;
- (void)removePassiveAbility:(id)ability step:(NSString*)step;
- (BOOL)performPassiveAbilitiesForEvent:(NSString*)event;

@end
