//
//  MADesireState.h
//  MicroAdventure
//
//  Created by Philipp Brendel on 13.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MADesire;

@interface MADesireState : NSObject

- (void) applyToDesire: (MADesire *) desire
                 scene: (id) scene;

@end
