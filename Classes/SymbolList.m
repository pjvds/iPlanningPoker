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
		
		[buffer addObject:[CCSprite spriteWithFile:@"unknown.png"]];
		[buffer addObject:[CCSprite spriteWithFile:@"0.png"]];
		[buffer addObject:[CCSprite spriteWithFile:@"half.png"]];
		[buffer addObject:[CCSprite spriteWithFile:@"1.png"]];
		[buffer addObject:[CCSprite spriteWithFile:@"2.png"]];
		[buffer addObject:[CCSprite spriteWithFile:@"3.png"]];
		[buffer addObject:[CCSprite spriteWithFile:@"5.png"]];
		
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
-(int) size {
	return [innerList count];
}

@end
