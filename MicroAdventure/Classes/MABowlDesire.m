//
//  MABowlDesire.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 20.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MABowlDesire.h"

#import "GunCase.h"
#import "MAMainScene.h"

@interface MABowlDesire ()
@property (nonatomic, strong) NSArray *cupboardAccessPositions;
@end

@implementation MABowlDesire

- (id)init
{
    self = [super init];
    
    if (self) {
        self.unfulfilledIcon = [self createIconWithImageNamed: @"bowl_unfulfilled"];
        self.fulfilledIcon = [self createIconWithImageNamed: @"bowl_fulfilled"];
        self.icon = self.unfulfilledIcon;
        
        [self addComponent: self.icon];
        
        self.cupboardAccessPositions = [NSArray arrayWithObjects:
                                        [GCVector vectorWithX: 9 * MATileSize y: 8 * MATileSize],
                                        [GCVector vectorWithX: 10 * MATileSize y: 8 * MATileSize],
                                        nil];
    }
    
    return self;
}

- (BOOL) conditionsMet
{
    static unichar key_x = 7;
    
    BOOL met = [[self.scene keyboard] keyPressed: key_x]
        && [self.cupboardAccessPositions containsObject: [self.scene seito].position.round];
    
    return met;
}

@end
