//
//  Card.m
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/15/10.
//  Copyright 2010 Born2code.net. All rights reserved.
//

#import "Card.h"

@implementation Card

+(id) cardWithSymbols: (SymbolList*) theSymbols{
	return [[[self alloc] initWithSymbols:theSymbols] autorelease];
}

-(Card*) initWithSymbols: (SymbolList*) theSymbols {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		currentIndex = -1;
		symbols = theSymbols;
		
        background = [CCSprite spriteWithFile:@"CardBackground.png"];
		[self setContentSize: background.contentSize];
		center = ccp(background.contentSize.width / 2, background.contentSize.height / 2);
		
		background.position = center;
		[self addChild: background];
    }
    
    return self;
}

-(void) setSymbol:(int) index{
	if(currentIndex != index){
		if(symbol != nil){
			[self removeChild: symbol cleanup:YES];
		}
		
		currentIndex = index;
		symbol = [symbols get: currentIndex];
		symbol.position = center;
		[self addChild: symbol];
	}
}

-(int) getSymbol{
	return currentIndex;
}

@end