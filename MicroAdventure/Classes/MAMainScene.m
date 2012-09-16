//
//  MAMainScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 02.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "MAMainScene.h"
#import "GCTiledMapParser.h"

@interface MAMainScene ()
@property (nonatomic, strong) GCMap *map;
@end

@implementation MAMainScene
- (id)init
{
    self = [super init];
    if (self) {
        [self loadMap];
    }
    return self;
}

- (void) render
{
	[self.map render];
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

@end
