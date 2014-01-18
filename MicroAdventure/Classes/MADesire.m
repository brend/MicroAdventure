//
//  MADesire.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 01.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MADesire.h"
#import "GunCase.h"
#import "MAUnfulfilledDesireState.h"


@interface MADesire ()
@property (nonatomic) BOOL animationActive;
@property (nonatomic) float animationProgress;
@end

@implementation MADesire

- (id)init
{
    self = [super init];
    if (self) {
        // Set initial state
        self.state = [[MAUnfulfilledDesireState alloc] init];
        
        // Add frame sprite to components
        GCSpriteActor *f = [[GCSpriteActor alloc] init];
        NSImage *fi = [NSImage imageNamed: @"frame"];
        
        f.sprite = [GCSprite spriteWithImage: fi];
        
        [self addComponent: f];
    }
    return self;
}

- (void) update
{
    [self.state applyToDesire: self scene: self.scene];
    
    if (self.animationActive) {
        if (self.animationProgress > M_PI) {
            self.icon.rotation = 0;
            self.animationActive = NO;
        } else {
            self.animationProgress += M_PI / 50;
            self.icon.rotation = 8 * sinf(5 * self.animationProgress);
        }
    }
}

@synthesize state;

- (void) fulfill
{
    // Swap the grayscale picture with the colored one
    [self removeComponentAtIndex: 1];
    [self insertComponent: self.fulfilledIcon atIndex: 1];
    
    self.icon = self.fulfilledIcon;
    
    // Start animation
    self.animationActive = YES;
    
    self.fulfilled = YES;
}

- (BOOL) conditionsMet
{
    @throw [NSException exceptionWithName: @"NotImplemented" reason: @"To be implemented by subclass" userInfo: nil];
}

- (GCActor *) createIconWithImageNamed: (NSString *) name
{
    GCSpriteActor *a = [[GCSpriteActor alloc] init];
    NSImage *i = [NSImage imageNamed: name];
    
    a.sprite = [GCSprite spriteWithImage: i];
    
    return a;
}

@end
