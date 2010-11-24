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
		
        foreground = [CCSprite spriteWithFile:@"CardForeground.png"];
		[self addChild: foreground];
		
		background = [CCSprite spriteWithFile:@"CardBackground.png"];
		background.visible = NO;
		[self addChild: background];
		
		[self setContentSize: foreground.contentSize];
		center = ccp(foreground.contentSize.width / 2, foreground.contentSize.height / 2);
		self.position = center;
		
    }
    
    return self;
}

-(void) setSymbol:(int) index{
	if(currentIndex != index){
		BOOL visibleState = YES;
		
		if(symbol != nil){
			visibleState = symbol.visible;
			[self removeChild: symbol cleanup:YES];
		}
		
		currentIndex = index;
		symbol = [symbols get: currentIndex];
		symbol.visible = visibleState;
		[self addChild: symbol];
	}
}

-(void) flip{
	float d = 0.25f;
	id firstAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
	id secondAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
	[self runAction: [CCSequence actions:
					  firstAction,
					  [CCCallFunc actionWithTarget: self selector:@selector(swapSprites)],//[ImageSwapAction actionWithCard: selectedCard],
					  secondAction,
					  nil]];
}

-(void) swapSprites{
	if(flipped){
		[self swapToForeground];
	}else {
		[self swapToBackground];
	}

}

-(void) swapToBackground{
	foreground.visible = NO;
	symbol.visible = NO;
	background.visible = YES;
	flipped = YES;
}

-(void) swapToForeground{
	foreground.visible = YES;
	symbol.visible = YES;
	background.visible = NO;
	flipped = NO;
}

-(int) getSymbol{
	return currentIndex;
}

@end