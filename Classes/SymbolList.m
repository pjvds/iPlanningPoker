//
//  SymbolList.m
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/17/10.
//  Copyright 2010 Born2code.net. All rights reserved.
//

#import "SymbolList.h"

@implementation SymbolList

-(SymbolList*) init {
	self = [super init];
	
	if(self) {
		NSMutableArray *buffer = [NSMutableArray array];
		
		CCSprite *symbolsSprite = [CCSprite spriteWithFile:@"Symbols.png"];
		CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[cache addSpriteFramesWithFile:@"Symbols.plist" texture: symbolsSprite];

		
		
		[buffer addObject:[[CCSprite spriteWithSpriteFrameName:@"unknown.png"] retain]];
		[buffer addObject:[[CCSprite spriteWithSpriteFrameName:@"0.png"] retain]];
		[buffer addObject:[cache createSpriteWithFrameName:@"half.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"1.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"2.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"3.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"5.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"8.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"13.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"20.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"40.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"100.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"infinity.png"]];
		[buffer addObject:[cache createSpriteWithFrameName:@"coffee.png"]];
		
		innerList = buffer;
		[innerList retain];
	}
    
    return self;
}

-(CCSprite*) get: (int)index {
	return [innerList objectAtIndex:index];
}

-(CCSprite*) getBefore: (int)index{
	int newIndex = index+1;
	
	if(newIndex > [innerList count]){
		newIndex = 0;
	}
	
	return [self get:newIndex];
}

-(CCSprite*) getAfter: (int)index{
	int newIndex = index-1;
	
	if(newIndex < 0){
		newIndex = [innerList count]-1;
	}
	
	return [self get:newIndex];
}

-(int) indexOf: (CCSprite*) symbol{
	return [innerList indexOfObject: symbol];
}

-(int) size {
	return [innerList count];
}

-(int) maxIndex {
	return [innerList count]-1;
}

-(int) minIndex {
	return 0;
}
@end
