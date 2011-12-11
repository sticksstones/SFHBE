//
//  CardManager.h
//  S&D2
//
//  Created by VINIT AGARWAL on 12/6/11.
//  Copyright (c) 2011 sticks+stones games. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface CardManager : NSObject {
  NSDictionary* cards;
}

@property (nonatomic, retain) NSDictionary* cards;

+ (CardManager *)instance;
- (Card*)getCard:(NSString*)cardID;


@end
