//
//  MAMainScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 02.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "MAMainScene.h"
#import "GCTiledMapParser.h"
#import "MASeito.h"

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

@end
