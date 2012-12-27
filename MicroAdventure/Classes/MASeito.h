//
//  MASeito.h
//  MicroAdventure
//
//  Created by Philipp Brendel on 22.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "GCSpriteActor.h"

@interface MASeito : GCSpriteActor

- (void) move: (GCVector *) offset;
@property (readonly) BOOL isMoving;

@end
