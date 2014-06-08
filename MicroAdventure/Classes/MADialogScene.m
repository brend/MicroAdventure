//
//  MADialogScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 19.01.14.
//  Copyright (c) 2014 Entenwolf Software. All rights reserved.
//

#import "MADialogScene.h"
#import "GunCase.h"

@interface MADialogScene ()
@property NSInteger currentPage;
@property GCActor *seitoFace;
@property GCMap *map;
@end

@implementation MADialogScene

- (id)init
{
    self = [super init];
    if (self) {
        [self loadResources];
        [self loadMap];
    }
    return self;
}

- (void) loadResources
{
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
}

- (void) loadMap
{
    NSURL *mapURL = [[NSBundle mainBundle] URLForResource: @"dialog" withExtension: @"tmx"];
    GCTiledMapParser *p = [[GCTiledMapParser alloc] initWithURL: mapURL];
    
    if ([p parse]) {
        self.map = p.map;
    } else {
        NSLog(@"Parsing failed for %@", mapURL);
    }
}

- (void) renderIndividually
{
    [self.seitoFace render];
}

@end
