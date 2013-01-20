//
//  MACerealDesire.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 20.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MACerealDesire.h"

#import "GunCase.h"

@implementation MACerealDesire

- (id)init
{
    self = [super init];
    if (self) {
        self.unfulfilledIcon = [self createIconWithImageNamed: @"cereal_unfulfilled"];
        self.fulfilledIcon = [self createIconWithImageNamed: @"cereal_fulfilled"];
        self.icon = self.unfulfilledIcon;
        
        [self addComponent: self.icon];
    }
    return self;
}

- (BOOL) conditionsMet
{
    return [[self.scene keyboard] keyPressed: 7];
}

@end
