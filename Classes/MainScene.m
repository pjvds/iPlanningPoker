//
//  MainSceneLayer.m
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/14/10.
//  Copyright Born2code.net 2010. All rights reserved.
//

// Import the interfaces
#import "MainScene.h"
#import "CCTouchDispatcher.h"
#import "Card.h"

// MainScene implementation
@implementation MainScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScene *layer = [MainScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA4444];
		
		[self initBackground];
		
		symbols = [[SymbolList alloc] init];
		
		selectedCard = [Card cardWithSymbols:symbols];
		selectedCard.position = cardCenterLocation;
		
		selectedSymbolIndex = 0;
		[selectedCard setSymbol: selectedSymbolIndex];
		[self addChild: selectedCard];
		
		neighbourCard = [Card cardWithSymbols:symbols];
		neighbourCard.position = cardCenterLocation;
		neighbourCard.visible = NO;
		[self addChild: neighbourCard];
		
		[self schedule:@selector(nextFrame:)];
		
		// register to receive targeted touch events
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
											  priority:0
											  swallowsTouches:YES];
	}
	return self;
}

- (void) initBackground{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	CCSprite* bg = [CCSprite spriteWithFile:@"Background.png"];
	bg.position = ccp(winSize.width / 2, winSize.height / 2);
	
	[self addChild: bg];
}

- (void) nextFrame:(ccTime)dt {	
	if(selectedCard.position.x == cardCenterLocation.x) {
		neighbourCard.visible = NO;
		return;
	}
	
	neighbourCard.visible = YES;
	
	if(selectedCard.position.x < cardCenterLocation.x) {
		neighbourCard.position = ccp(selectedCard.position.x + selectedCard.contentSize.width, neighbourCard.position.y);
		int neighbourSymbolIndex = selectedSymbolIndex + 1;
		if(neighbourSymbolIndex > [symbols maxIndex]) neighbourSymbolIndex = [symbols minIndex];
		neighbourSymbolIndex = neighbourSymbolIndex % [symbols size];
		[neighbourCard setSymbol: neighbourSymbolIndex];
	}
	else {
		neighbourCard.position = ccp(selectedCard.position.x - selectedCard.contentSize.width, neighbourCard.position.y);
		int neighbourSymbolIndex = selectedSymbolIndex - 1;
		if(neighbourSymbolIndex < 0) neighbourSymbolIndex = [symbols maxIndex];
		
		neighbourSymbolIndex = neighbourSymbolIndex % [symbols size];
		[neighbourCard setSymbol: neighbourSymbolIndex];
	}
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	if(isTouching) return NO;
    
	[selectedCard stopAllActions];
	
    CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	if([self isTouchOnSprite:touchPoint]){
		whereTouch=ccpSub(selectedCard.position, touchPoint);
		return YES;
	}
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	if(isDrag){
		CGPoint newPosition = ccp(touchPoint.x + whereTouch.x, selectedCard.position.y);
		selectedCard.position= newPosition;
	} else {
		if(whereTouch.x != touchPoint.x && whereTouch.y != touchPoint.y){
			isDrag = YES;
		}
	}

}

-(BOOL) isTouchOnSprite:(CGPoint)touch{
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {	
	
	if(isDrag){
		if(selectedCard.position.x < -32 || selectedCard.position.x > 32){
			int indexOfNeighbourSymbol = [neighbourCard getSymbol];
			selectedSymbolIndex = indexOfNeighbourSymbol;
		
			Card *temp = selectedCard;
			selectedCard = neighbourCard;
			neighbourCard = temp;
		}

		[selectedCard stopAllActions];
		[selectedCard runAction: [CCMoveTo actionWithDuration:0.1 position:cardCenterLocation]];
	}
	else {
		float d = 0.25f;
		id firstAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
		id secondAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
		[self runAction: [CCSequence actions:
						  firstAction,
						  //[ImageSwapAction actionWithCard: selectedCard],
						  secondAction,
						  nil]];
	}

		
	isTouching=NO;
	isDrag=NO;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[selectedCard release];
	[neighbourCard release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
