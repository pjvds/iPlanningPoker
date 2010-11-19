//
//  SymbolList.h
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/17/10.
//  Copyright 2010 Born2code.net. All rights reserved.
//

#import "cocos2d.h"


@interface SymbolList : NSObject {
@private
	NSMutableArray *innerList;
}

-(SymbolList *) init;
-(CCSprite *) get: (int)index;
-(CCSprite *) getBefore: (int)index;
-(CCSprite *) getAfter: (int)index;
-(int) indexOf: (CCSprite*) symbol;
-(int) size;
-(int) maxIndex;
-(int) minIndex;

@end