//
//  MADesire.h
//  MicroAdventure
//
//  Created by Philipp Brendel on 01.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "GCCompositeActor.h"

@class MADesireState;

@interface MADesire : GCCompositeActor

@property (nonatomic, strong) MADesireState *state;
@property (nonatomic, strong) id scene;

- (void) fulfill;
@property (nonatomic) BOOL fulfilled;

@property (nonatomic, strong) GCActor *icon, *fulfilledIcon, *unfulfilledIcon;

- (BOOL) conditionsMet;

- (GCActor *) createIconWithImageNamed: (NSString *) name;

@end
