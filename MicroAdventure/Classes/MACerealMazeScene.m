//
//  MACerealMazeScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 23.06.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MACerealMazeScene.h"
#import "GunCase.h"

@interface MACerealMazeScene ()
@property (strong, nonatomic) GCSprite *bg, *marker;
@property (strong, nonatomic) GCAnimation *animation;
@end

@implementation MACerealMazeScene

- (id)init
{
    self = [super init];
    if (self) {
        self.bg = [GCSprite spriteWithImage: [NSImage imageNamed: @"puzzle_maze"]];
		self.marker = [GCSprite spriteWithImage: [NSImage imageNamed: @"puzzle_maze_marker"]];
		
		GCVector *startLocation = [GCVector vectorWithX: 0 y: -512];
		
		self.animation =
			[GCLinearAnimation animationFrom: startLocation
										  to: [GCVector zero]
									duration: 0.5];
    }
    return self;
}

- (void) renderIndividually
{
	[self.bg drawAtX: 0
				   y: 0];
}

- (void) update
{
	[self.animation advance: self];
}

@end
