//
//  MABowlDesire.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 20.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MABowlDesire.h"

#import "GunCase.h"

@implementation MABowlDesire

- (id)init
{
    self = [super init];
    if (self) {
        self.unfulfilledIcon = [self createIconWithImageNamed: @"bowl_unfulfilled"];
        self.fulfilledIcon = [self createIconWithImageNamed: @"bowl_fulfilled"];
        self.icon = self.unfulfilledIcon;
        
        [self addComponent: self.icon];
    }
    return self;
}

- (BOOL) conditionsMet
{
    return [[self.scene keyboard] keyPressed: 8];
}

@end
