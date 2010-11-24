//
//  ImageSwapAction.h
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/23/10.
//  Copyright 2010 Born2code.net. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Card;

@interface ImageSwapAction : CCFiniteTimeAction <NSCopying>
{
	Card* card;
}

+ (id) actionWithCard: (Card*) whichCard;
- (id) initWithCard: (Card*) whichCard;
@property (nonatomic, retain) Card* card;
@end