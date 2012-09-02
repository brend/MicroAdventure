//
//  MAMainScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 02.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "MAMainScene.h"
#import "GCSpriteActor.h"

@interface MAMainScene ()
@property (nonatomic, strong) GCActor *bass;
@end

@implementation MAMainScene
- (id)init
{
    self = [super init];
    if (self) {
        self.bass = [[GCSpriteActor alloc] initWithSprite: [GCSprite spriteWithImage: [NSImage imageNamed: @"bass"]]];
    }
    return self;
}

- (void) render
{
	[self.bass render];
}

@end
