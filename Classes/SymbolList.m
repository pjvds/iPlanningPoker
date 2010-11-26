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
		CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[cache addSpriteFramesWithFile:@"Symbols.plist"];
		
		innerList = [[NSMutableArray array] retain];
		
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"unknown.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"0.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"half.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"1.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"2.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"3.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"5.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"8.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"13.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"20.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"40.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"100.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"infinity.png"]];
		[innerList addObject:[CCSprite spriteWithSpriteFrameName:@"coffee.png"]];
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
