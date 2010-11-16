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

CCSprite *background;
Card *selectedCard;
Card *neighbourCard;

CGPoint whereTouch;
CGPoint cardCenterLocation;
float neighbourOffset;
BOOL isDrag;

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
		
		background = [CCSprite spriteWithFile:@"Background.png"];
		background.position = ccp(background.contentSize.width / 2,background.contentSize.height / 2);
		[self addChild: background];
		
		selectedCard = [Card node];
		//cardCenterLocation = ccp(selectedCard.contentSize.width / 2,selectedCard.contentSize.height / 2);
		selectedCard.position = cardCenterLocation;
		[self addChild: selectedCard];
		
		neighbourCard = [Card node];
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

- (void) nextFrame:(ccTime)dt {
	if(selectedCard.position.x == cardCenterLocation.x) {
		neighbourCard.visible = NO;
		return;
	}
	
	neighbourCard.visible = YES;
	
	if(selectedCard.position.x < cardCenterLocation.x) {
		neighbourCard.position = ccp(selectedCard.position.x + selectedCard.contentSize.width, neighbourCard.position.y);
	}
	else {
		neighbourCard.position = ccp(selectedCard.position.x - selectedCard.contentSize.width, neighbourCard.position.y);		
	}
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	// Do not allow a second touch.
    if(isDrag) return NO;
    
	[selectedCard stopAllActions];
	
    CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	if([self isTouchOnSprite:touchPoint]){
		isDrag=YES;
		whereTouch=ccpSub(selectedCard.position, touchPoint);
		return YES;
	}
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	CGPoint newPosition = ccp(touchPoint.x + whereTouch.x, selectedCard.position.y);
	selectedCard.position= newPosition;
	
	NSLog([NSString stringWithFormat:@"X=%f", newPosition.x]);
}

-(BOOL) isTouchOnSprite:(CGPoint)touch{
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	isDrag=NO;
	
	//CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:cardCenterLocation];
	
	[selectedCard stopAllActions];
	[selectedCard runAction: [CCMoveTo actionWithDuration:0.2 position:cardCenterLocation]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[background release];
	[selectedCard release];
	[neighbourCard release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
