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
		
		CCSprite* one = [CCSprite spriteWithFile:@"20.png"];
		CCSprite* two = [CCSprite spriteWithFile:@"40.png"];
		
		[buffer addObject:one];
		[buffer addObject:two];
	
		symbols = buffer;
	}
    
    return self;
}

-(CCSprite*) get: (int)index {
	return [symbols objectAtIndex:index];
}

-(CCSprite*) getBefore: (int)index{
	int newIndex = index++;
	
	if(newIndex > [self size]){
		newIndex = 0;
	}
	
	return [self get:newIndex];
}

-(CCSprite*) getAfter: (int)index{
	int newIndex = index--;
	
	if(newIndex < 0){
		newIndex = [self size]-1;
	}
	
	return [self get:newIndex];
}
-(int) size {
	return [symbols count];
}

@end
