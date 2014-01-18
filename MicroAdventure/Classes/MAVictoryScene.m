//
//  MAVictoryScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 12.11.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MAVictoryScene.h"
#import "GunCase.h"

@interface MAVictoryScene ()
@property (nonatomic, strong) GCActor *seitoFace, *splash;
@end

@implementation MAVictoryScene

- (id)init
{
    self = [super init];
    if (self) {
        NSImage *seito = [NSImage imageNamed: @"seito"];
        NSImage *face = [[NSImage alloc] initWithSize: NSMakeSize(16, 16)];
        
        [face lockFocus];
        [seito drawInRect: NSMakeRect(1, 1, 14, 14)
         //        fromRect: NSMakeRect(0, 80, 14, 14)
                 fromRect: NSMakeRect(0, 34, 14, 14)
                operation: NSCompositeSourceOver
                 fraction: 1];
        [face unlockFocus];
        
        self.seitoFace = [[GCSpriteActor alloc] initWithSprite: [GCSprite spriteWithImage: face]];
        self.seitoFace.scale = NSMakeSize(4, 4);
        
        self.splash = [[GCSpriteActor alloc] initWithSprite: [GCSprite spriteWithImage: [NSImage imageNamed: @"splash_victory"]]];
        self.splash.position = [GCVector vectorWithX: 0 y: -96];
    }
    return self;
}

- (void) update
{
    GCVector *v = [GCVector vectorWithX: (float) rand() / RAND_MAX - 0.5f
                                      y: (float) rand() / RAND_MAX - 0.5f];
    
    self.seitoFace.position = [self.seitoFace.position add: v];
}

- (void) renderIndividually
{
    [self.seitoFace render];
    [self.splash render];
}

@end
