//
//  MainSceneLayer.m
//  iPlanningPoker
//
//  Created by Pieter Joost van de Sande on 11/14/10.
//  Copyright Born2code.net 2010. All rights reserved.
//

// Import the interfaces
#import "MainScene.h"

CCSprite *background;
CCSprite *cardBackground;

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
		cardBackground.position = ccp(cardBackground.contentSize.width / 2,cardBackground.contentSize.height / 2);
		[self addChild: cardBackground];
	}
	return self;
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
