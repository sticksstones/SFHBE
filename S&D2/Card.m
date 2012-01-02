//
//  Card.m
//  S&D2
//
//  Created by VINIT AGARWAL on 12/4/11.
//  Copyright 2011 sticks+stones games. All rights reserved.
//

#import "Card.h"
#import "BoardManager.h"
#import "Board.h"
#import "Tile.h"
#import "Ship.h"
#import "GameObjectManager.h"
#import "PlayerManager.h"
#import "Player.h"
#import "AbilityHelper.h"
#import "Ability.h"

#define kRechargeLabel 1
#define kPreview 5

@implementation Card

@synthesize originalLocation, held, ready, isCaptain;

- (Card*)initWithParams:(NSDictionary*)params {
  NSString* fileName = [params valueForKey:@"imagename"];  
  self = [super initWithFile:fileName];
  rechargeTime = [[params objectForKey:@"recharge"] floatValue];
  cost = [[params objectForKey:@"cost"] intValue];
  isCaptain = [[params objectForKey:@"captain"] boolValue];
  properties = [[NSDictionary alloc] initWithDictionary:[params objectForKey:@"properties"]];
  type = [params valueForKey:@"type"];
  cardID = [params valueForKey:@"id"];
  origParams = params;
  
  CCLabelTTF* cardLabel = [[CCLabelTTF alloc] initWithString:[cardID uppercaseString] fontName:@"Helvetica" fontSize:10.0];
  [self addChild: cardLabel];
  [cardLabel setPosition:CGPointMake(self.contentSize.width/2, -12)];
  
  CCLabelTTF* cardCost = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%d",cost] fontName:@"Helvetica" fontSize:12];
  [self addChild:cardCost];
  [cardCost setPosition:CGPointMake(self.contentSize.width, self.contentSize.height)];
  
  if([type isEqualToString:@"ship"]) {
    CCLabelTTF* shipStats = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%d/%d",[[properties objectForKey:@"ap"] intValue],[[properties objectForKey:@"hp"] intValue]] fontName:@"Helvetica" fontSize:12];
    [self addChild:shipStats];
    [shipStats setPosition:CGPointMake(self.contentSize.width, 0)];
  }
  
  CCLabelTTF* rechargeLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%.1f",(rechargeTime - currentCharge)] fontName:@"Helvetica" fontSize:12];
  [self addChild:rechargeLabel z:1 tag:kRechargeLabel];
  [rechargeLabel setPosition:CGPointMake(0,0)];
  currentCharge = rechargeTime - 0.1;
  self.ready = YES;  
  return self;
}

- (NSString*)getID {
  return cardID;
}

- (void)setHeld:(bool)_held {
  Player* player = [[PlayerManager instance] getPlayer:playerNum];
  held = _held;
  if (held) {
    if([player hasEnoughMana:cost] && ready) {
      
      CCSprite* preview = [CCSprite spriteWithFile:[properties objectForKey:@"sprite"]];
      preview.rotation = playerNum == 1 ? 90 : 270;
      [[[GameObjectManager instance] gameLayer] addChild:preview z:10 tag:kPreview+playerNum];
    }
  }
  else {
    [[[GameObjectManager instance] gameLayer] removeChildByTag:kPreview+playerNum cleanup:YES];
  }
}

- (void)setReady:(_Bool)_ready {
  ready = _ready;
}

- (id)copyCard {
  return [[Card alloc] initWithParams:origParams];
}

- (void)setPlayerNum:(int)_playerNum {
  playerNum = _playerNum;
  self.position = originalLocation;  
}


- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	



- (CGRect)rectInPixels
{
	CGSize s = [texture_ contentSizeInPixels];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (CGRect)rect
{
	CGSize s = [texture_ contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint p = [self convertTouchToNodeSpaceAR:touch];
	CGRect r = [self rectInPixels];
  
	return CGRectContainsPoint(r, p);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (![self containsTouchLocation:touch] ) return NO;
  
  if(ready) {
    self.held = true;
  }
	return YES;
}


- (bool)isInValidSpot:(CGPoint)boardPos {
  bool isTileOccupied = [[BoardManager instance] isTileOccupiedX:boardPos.x Y:boardPos.y playerNum:playerNum enemyOnly:YES];
  
  bool onBoard = (boardPos.x != -1 && boardPos.y != -1);  
  bool isCastOnAUnit = true;
  if(![type isEqualToString:@"ship"]) { // If this is not a ship card, it must be cast on a unit
    isCastOnAUnit = isTileOccupied;
    isTileOccupied = NO;
  }
  bool isOnPlayersSide = (((playerNum == 1) && (boardPos.x <= 2)) || ((playerNum == -1) && (boardPos.x >= 6)));
  return (onBoard && !isTileOccupied && isOnPlayersSide && isCastOnAUnit);
}

- (CGPoint)getBoardPos:(CGPoint)touchPoint {
  touchPoint.y += self.contentSize.height/2;
  touchPoint.x += self.contentSize.width/2;    
  CGPoint boardPos = [[BoardManager instance] getTileLocForPoint:touchPoint];     
  return boardPos;
}

- (void)commitCard:(Player*)player {
  [player spendMana:cost];
  self.ready = NO;
  currentCharge = 0.0;
  if (!isCaptain) {
    [[[PlayerManager instance] getPlayer:playerNum] consumeCard:self];
  }  
}

- (void)playCard:(CGPoint)boardPos {
  Player* player = [[PlayerManager instance] getPlayer:playerNum];
  if ([self isPlayable]) {
    if ([type isEqualToString:@"ship"]) {
      if([self isInValidSpot:boardPos]) {
        NSString* sprite = [properties objectForKey:@"sprite"];
        
        Ship* ship = [[Ship alloc] newShip:[NSArray arrayWithObjects:[NSNumber numberWithInt:[[properties objectForKey:@"hp"] intValue]],[NSNumber numberWithInt:[[properties objectForKey:@"sp"] intValue]],[NSNumber numberWithInt:[[properties objectForKey:@"ap"] intValue]],sprite,properties,nil]];
        
        [ship setPlayerNum:playerNum];
        
        [[GameObjectManager instance] addShip:ship];        
        [[BoardManager instance] setToken:ship X:(int)boardPos.x Y:(int)boardPos.y];
        [self commitCard:player];
      }
    }
    else if ([type isEqualToString:@"armor"]) {
      Tile* tile = [[[BoardManager instance] getBoard] getTileX:boardPos.x Y:boardPos.y];
      if(tile) {
        NSArray* occupants = [[BoardManager instance] getTokensForSpot:boardPos];
        Ship* target = nil;
        
        for(Ship* occupant in occupants) {
          if([occupant isKindOfClass:[Ship class]]) {
            target = occupant;
            break;
          }
        }
        
        if(target) {          
          NSArray* abilities = [properties objectForKey:@"abilities"];
          for(NSString* ability in abilities) {
            id abilityObj = [AbilityHelper AbilityForType:ability];
            [abilityObj setSourceToken:target];
            [abilityObj performAbility];        
          }
        }
        [self commitCard:player];
        
      }
    }
  }
  
  
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {	
  CGPoint touchPoint = [touch locationInView:[touch view]];
  if (held) {
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    CGPoint boardPos = [self getBoardPos:touchPoint];
    if ([self isInValidSpot:boardPos]) {
      [self playCard:boardPos];
    }
    [self runAction:[CCMoveTo actionWithDuration:0.2 position:originalLocation]];
    self.held = false;
    self.opacity = 255;
  }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
  CGPoint touchPoint = [touch locationInView:[touch view]];
	if (held) {
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    CCSprite* preview = (CCSprite*)[[[GameObjectManager instance] gameLayer] getChildByTag:kPreview+playerNum];
    [preview setPosition:CGPointMake(touchPoint.x, touchPoint.y)];
    CGPoint boardPos = [self getBoardPos:touchPoint];
    
    if ([self isInValidSpot:boardPos]) {
      preview.opacity = 255;
    }
    else {
      preview.opacity = 128;
    }
  }
}

- (bool)isPlayable {
  Player* player = [[PlayerManager instance] getPlayer:playerNum];
  return [player hasEnoughMana:cost] && (currentCharge >= rechargeTime);
}

- (void)draw {
  [super draw];
  self.ready = [self isPlayable];
  CCLabelTTF* rechargeLabel = (CCLabelTTF*)[self getChildByTag:kRechargeLabel];  
  if (currentCharge < rechargeTime) {
    currentCharge += 1.0/60.0;
    [rechargeLabel setString:[NSString stringWithFormat:@"%.1f",rechargeTime - currentCharge]];    
    [rechargeLabel setVisible:YES];
  }
  else {
    [rechargeLabel setVisible:NO];
  }
  
  self.opacity = ready ? 255 : 100;
}



@end
