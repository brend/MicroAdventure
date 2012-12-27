//
//  MASeito.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 22.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "MASeito.h"
#import "GunCase.h"

@interface MASeito ()
@property (nonatomic, copy) NSArray *sprites;
@property (nonatomic) GCAnimation *movement;
@property (nonatomic) float animationProgress;
@property (nonatomic, copy) NSArray *animationCells;
@end

@implementation MASeito

- (id)init
{
    self = [super init];
    if (self) {
        self.position = [GCVector vectorWithX: 2 * 16 y: 2 * 16];
        self.drawingOffset = [GCVector vectorWithX: 0 y: 24];
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
    self.animationCells = sheet;
}

- (void) render
{
    self.sprite = [self.animationCells objectAtIndex: ((NSInteger) self.animationProgress) % self.animationCells.count];

    if (self.movement) {        
        self.animationProgress += 0.1;
    }
    
    [super render];
}

- (void) move: (GCVector *) offset
{
    if (self.movement)
        return;
    
    // Create movement animation
    GCVector *target = [self.position add: offset];
    GCLinearAnimation *a = [GCLinearAnimation animationFrom: self.position to: target duration: 0.15];
    
    self.movement = a;
    
    // Get movement animation cells
    NSRange cellRange = NSMakeRange(0, 0);
    
    
    if (offset.y > 0) {
        cellRange = NSMakeRange(0, 3);
    }
    if (offset.x > 0) {
        cellRange = NSMakeRange(3, 3);
    }
    if (offset.y < 0) {
        cellRange = NSMakeRange(6, 3);
    }
    if (offset.x < 0) {
        cellRange = NSMakeRange(9, 3);
    }

    self.animationCells = [self.sprites subarrayWithRange: cellRange];
}

- (BOOL) isMoving
{
    return self.movement != nil;
}

- (void) update
{
    [super update];
    [self.movement advance: self];
    if (self.movement.isFinished)
        self.movement = nil;
}

@end
