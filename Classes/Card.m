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
SymbolList *symbols;
int currentIndex = -1;

@implementation Card

+(id) cardWithSymbols: (SymbolList*) theSymbols{
	return [[[self alloc] initWithSymbols:theSymbols] autorelease];
}

-(Card*) initWithSymbols: (SymbolList*) theSymbols {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
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
		if(currentIndex != -1){
			[self removeChild: [symbols get: currentIndex] cleanup: YES];
		}
		
		currentIndex = index;
		symbol = [symbols get: currentIndex];
		symbol.position = center;
		[self addChild: symbol];
	}
}

-(CCSprite*) getSymbol{
	return symbol;
}

@end