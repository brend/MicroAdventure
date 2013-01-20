//
//  MAUnfulfilledDesireState.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 13.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MAUnfulfilledDesireState.h"

#import "MADesire.h"
#import "MAFullfilledDesireState.h"

@implementation MAUnfulfilledDesireState

- (void) applyToDesire:(MADesire *)desire scene:(id)scene
{
    if (desire.conditionsMet) {
        [desire fulfill];
        desire.state = [[MAFullfilledDesireState alloc] init];
    }
}

@end
