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
@property (strong, nonatomic) GCSprite *bg;
@property (strong, nonatomic) GCActor *marker;
@property (strong, nonatomic) GCAnimation *animation;
@property (strong, nonatomic) GCStack *path, *backtrack;
@end

@implementation MACerealMazeScene

- (id)init
{
    self = [super init];
    if (self) {
        GCSprite *markerSprite = [GCSprite spriteWithImage: [NSImage imageNamed: @"puzzle_maze_marker"]];
        self.bg = [GCSprite spriteWithImage: [NSImage imageNamed: @"puzzle_maze"]];
        self.marker = [[GCSpriteActor alloc] initWithSprite: markerSprite];
		
		GCVector *startLocation = [GCVector vectorWithX: 0 y: -512];
		
		self.animation =
			[GCLinearAnimation animationFrom: startLocation
										  to: [GCVector zero]
									duration: 0.5];
        
        self.path = [[GCStack alloc] init];
        self.backtrack = [[GCStack alloc] init];
        
        [self loadPath];
    }
    return self;
}

- (void) renderIndividually
{
	[self.bg drawAtX: 0
				   y: 0];
    
    [self.marker render];
}

- (void) update
{
	[self.animation advance: self];
}

- (void) loadPath
{
    NSString *pathString =
        @"URUUULLDRRRUULLLLDDLLLURUU";
    
    [pathString enumerateSubstringsInRange: NSMakeRange(0, pathString.length)
                                   options: NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences
                                usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
                                            {
                                                [self.path push: substring];
                                            }];
    
    NSLog(@"Path = %@", [self.path.allObjects componentsJoinedByString: @""]);
}

@end
