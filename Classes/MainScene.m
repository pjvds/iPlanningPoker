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

CCSprite *background;
CCSprite *cardBackground;
CCSprite *cardNeighbour;

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
		background.position = ccp(0,0);
		[self addChild: background];
		
		cardBackground = [CCSprite spriteWithFile:@"CardBackground.png"];
		cardCenterLocation = ccp(cardBackground.contentSize.width / 2,cardBackground.contentSize.height / 2);
		cardBackground.position = cardCenterLocation;
		[self addChild: cardBackground];
		
		cardNeighbour = [CCSprite spriteWithFile:@"CardBackground.png"];
		cardNeighbour.position = cardCenterLocation;
		cardNeighbour.visible = NO;
		[self addChild: cardNeighbour];
		
		[self schedule:@selector(nextFrame:)];
		
		// register to receive targeted touch events
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
											  priority:0
											  swallowsTouches:YES];
	}
	return self;
}

- (void) nextFrame:(ccTime)dt {
	if(cardBackground.position.x == cardCenterLocation.x) {
		cardNeighbour.visible = NO;
		return;
	}
	
	cardNeighbour.visible = YES;
	
	if(cardBackground.position.x < cardCenterLocation.x) {
		cardNeighbour.position = ccp(cardBackground.position.x + cardBackground.contentSize.width, cardNeighbour.position.y);
	}
	else {
		cardNeighbour.position = ccp(cardBackground.position.x - cardBackground.contentSize.width, cardNeighbour.position.y);		
	}
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	if([self isTouchOnSprite:touchPoint]){
		isDrag=YES;
		whereTouch=ccpSub(cardBackground.position, touchPoint);
		return YES;
	}
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	cardBackground.position= ccp(touchPoint.x + whereTouch.x, cardBackground.position.y);
}

-(BOOL) isTouchOnSprite:(CGPoint)touch{
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	isDrag=NO;
	
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:cardCenterLocation];
	
	[cardBackground stopAllActions];
	[cardBackground runAction: [CCMoveTo actionWithDuration:0.2 position:convertedLocation]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[background release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
