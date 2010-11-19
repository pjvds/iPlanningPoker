//
//  Card.h
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/14/10.
//  Copyright Born2code.net 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SymbolList.h"

// MainScene Layer
@interface Card : CCNode
{
@private
	CGPoint center;
	
}
+(id) init;
-(Card*) init;
-(void) setSymbol:(CCSprite*) value;
-(CCSprite*) getSymbol;
@end
