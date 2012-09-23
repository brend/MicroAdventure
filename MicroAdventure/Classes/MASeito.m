//
//  MASeito.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 22.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "MASeito.h"
#import "GCSprite.h"

@interface MASeito ()
@property (nonatomic, copy) NSArray *sprites;
@end

@implementation MASeito

- (id)init
{
    self = [super init];
    if (self) {
        [self loadSprites];
    }
    return self;
}

- (void) loadSprites
{
    NSImage *image = [NSImage imageNamed: @"seito"];
    NSArray *sheet = [GCSprite spritesWithSheet: image
                                          width: 3 * 16
                                         height: 4 * 24
                                        columns: 3
                                           rows: 4];
    
    self.sprites = sheet;
}

- (void) render
{
    static float index = 0;
    
    [[self.sprites objectAtIndex: ((NSInteger) index) % self.sprites.count] drawAtX: 0 y: 0];
    
    index += 0.1;
}

@end
