//
//  Card.m
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/15/10.
//  Copyright 2010 Born2code.net. All rights reserved.
//

#import "Card.h"

CCSprite *background;
CCSprite *symbol;

@implementation Card

+(id) node {
	return [[[self alloc] init] autorelease];
}

-(Card*) init {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        background = [CCSprite spriteWithFile:@"CardBackground.png"];
		[self setContentSize: background.contentSize];
		center = ccp(background.contentSize.width / 2, background.contentSize.height / 2);
		
		background.position = center;
		[self addChild: background];
    }
    
    return self;
}

-(void) setSymbol:(CCSprite*) value{
	if(symbol != value){
		if(symbol != nil){
			[self removeChild: symbol cleanup: NO];
		}
		
		symbol = value;
		symbol.position = center;

		[self addChild: symbol];
	}
}

@end