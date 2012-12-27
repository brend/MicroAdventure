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
#import "MASeito.h"

#define MATileSize  16.0

@interface MAMainScene ()
@property (nonatomic, strong) GCMap *map;
@property (nonatomic, strong) MASeito *seito;
@end

@implementation MAMainScene
- (id)init
{
    self = [super init];
    if (self) {
        [self loadMap];
        [self loadSeito];
    }
    return self;
}

- (void) render
{
	[self.map render];
    [self.seito render];
}

- (void) loadMap
{
    NSURL *mapURL = [[NSBundle mainBundle] URLForResource: @"home" withExtension: @"tmx"];
    GCTiledMapParser *p = [[GCTiledMapParser alloc] initWithURL: mapURL];
    
    if ([p parse]) {
        self.map = p.map;
    } else {
        NSLog(@"Parsing failed for %@", mapURL);
    }
}

- (void) loadSeito
{
    self.seito = [[MASeito alloc] init];
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
}

- (BOOL) tileIsWalkable: (GCVector *) position
{
    NSInteger x = roundtol(position.x / MATileSize), y = roundtol(position.y / MATileSize);
    GCMapLayer *unwalkableLayer = [self.map layerNamed: @"Unwalkable"];
    GCMapTile *tile = [unwalkableLayer tileAtX: x y: y];
    
    return tile.isEmpty;
}

@end
