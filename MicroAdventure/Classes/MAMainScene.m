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
#import "MAVictoryScene.h"
#import "MADialogScene.h"

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
		
		// Center the scene
		self.position = [GCVector vectorWithX: (float)self.map.width * MATileSize / -2.0
											y: (float)self.map.height * MATileSize / -2.0];
    }
    return self;
}

- (void) renderIndividually
{
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
    // DEBUG
    if ([self.keyboard keyPressed: GCKeyboardKeyEnter])
        [self presentDialogScene];
    
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
    
    // Update desires
    BOOL allDesiresFulfilled = YES;
    
    for (MADesire *d in self.desires) {
        [d update];
        
        allDesiresFulfilled &= d.fulfilled;
    }
    
    // Display victory scene if all desired fulfilled
    if (allDesiresFulfilled) {
        [self presentVictoryScene];
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
#pragma mark Presenting Other Scenes
- (void) presentCerealMaze
{
	MACerealMazeScene *maze = [[MACerealMazeScene alloc] init];
    
    maze.delegate = self;
	
	[[GCDirector sharedDirector] pushScene: maze];
}

- (void) presentVictoryScene
{
    MAVictoryScene *v = [[MAVictoryScene alloc] init];
    
    [[GCDirector sharedDirector] pushScene: v];
}

- (void) presentDialogScene
{
    MADialogScene *dialog = [[MADialogScene alloc] init];
    
    [[GCDirector sharedDirector] pushScene: dialog];
}

@end
