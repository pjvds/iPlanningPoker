//
//  MainSceneLayer.h
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/14/10.
//  Copyright Born2code.net 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "card.h";
#import "SymbolList.h";

// MainScene Layer
@interface MainScene : CCLayer
{
@private
	Card *selectedCard;
	Card *neighbourCard;
	
	SymbolList *symbols;
	int selectedSymbolIndex;
	
	CGPoint whereTouch;
	CGPoint cardCenterLocation;
	float neighbourOffset;
	BOOL isTouching;
	BOOL isDrag;
}

+(id) scene;
-(void) initBackground;
-(BOOL) isTouchOnSprite:(CGPoint)touch;

@end
