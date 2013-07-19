//
//  MAMainScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 02.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "MAMainScene.h"
#import "GCTiledMapParser.h"
#import "GCKeyboardKeys.h"

#import "MACerealDesire.h"
#import "MABowlDesire.h"

#import "GCDirector.h"
#import "MACerealMazeScene.h"

@interface MAMainScene ()
@property (nonatomic, strong) GCMap *map;
@property (nonatomic, copy) NSArray *desires;
@end

@implementation MAMainScene
- (id)init
{
    self = [super init];
    if (self) {
        [self loadSeito];
        [self loadMap];
        [self loadDesires];
    }
    return self;
}

- (void) render
{
	[super render];
	[self.map render];
    for (MADesire *d in self.desires) {
        [d render];
    }
}

- (void) loadMap
{
    NSURL *mapURL = [[NSBundle mainBundle] URLForResource: @"home" withExtension: @"tmx"];
    GCTiledMapParser *p = [[GCTiledMapParser alloc] initWithURL: mapURL];
    
    if ([p parse]) {
        self.map = p.map;
		
		GCMapLayer *seitoLayer = [self.map layerNamed: @"Seito"];
		
		[seitoLayer addComponent: self.seito];
		
    } else {
        NSLog(@"Parsing failed for %@", mapURL);
    }
}

- (void) loadSeito
{
    self.seito = [[MASeito alloc] init];
}

- (void) loadDesires
{
    NSArray *someDesires = [NSArray arrayWithObjects:
                            [[MACerealDesire alloc] init],
                            [[MABowlDesire alloc] init],
                            nil];
    NSMutableArray *a = [NSMutableArray array];
    
    for (NSInteger i = 0; i < someDesires.count; ++i) {
        MADesire *d = [someDesires objectAtIndex: i];
  
        d.scene = self;
        d.position = [GCVector vectorWithX: (self.map.width + 1) * MATileSize
                                         y: (self.map.height - i * 1.5 * 2) * MATileSize];
        
        [a addObject: d];
    }
    
    self.desires = a;
}

- (void) update
{
	if (!self.seito.isMoving) {
        
        GCVector *offset = nil;
        
        if ([self.keyboard keyPressed: GCKeyboardKeyLeft]) {
            offset = [GCVector vectorWithX: -MATileSize y: 0];
        }
        
        if ([self.keyboard keyPressed: GCKeyboardKeyRight]) {
            offset = [GCVector vectorWithX: MATileSize y: 0];
        }
        
        if ([self.keyboard keyPressed: GCKeyboardKeyDown]) {
            offset = [GCVector vectorWithX: 0 y: -MATileSize];
        }
        
        if ([self.keyboard keyPressed: GCKeyboardKeyUp]) {
            offset = [GCVector vectorWithX: 0 y: MATileSize];
        }
        
        if (offset && [self tileIsWalkable: [self.seito.position add: offset]]) {
            [self.seito move: offset];
        }
    }
    
    [self.seito update];
    
    for (MADesire *d in self.desires) {
        [d update];
    }
}

- (BOOL) tileIsWalkable: (GCVector *) position
{
    NSInteger x = roundtol(position.x / MATileSize), y = roundtol(position.y / MATileSize);
    GCMapLayer *unwalkableLayer = [self.map layerNamed: @"Unwalkable"];
    GCMapTile *tile = [unwalkableLayer tileAtX: x y: y];
    
    return tile.isEmpty;
}

#pragma mark -
#pragma mark Desire Interaction
- (void) presentCerealMaze
{
	MACerealMazeScene *maze = [[MACerealMazeScene alloc] init];
	
	[[GCDirector sharedDirector] pushScene: maze];
}

@end
