//
//  MACerealMazeScene.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 23.06.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MACerealMazeScene.h"
#import "GunCase.h"

@interface MACerealMazeScene ()
@property (strong, nonatomic) GCSprite *bg;
@property (strong, nonatomic) GCActor *marker;
@property (strong, nonatomic) GCAnimation *animation, *markerAnimation;
@property (strong, nonatomic) GCStack *path, *backtrack;
@property (nonatomic) NSPoint markerGridPosition;
@end

@implementation MACerealMazeScene

- (id)init
{
    self = [super init];
    if (self) {
        GCSprite *markerSprite = [GCSprite spriteWithImage: [NSImage imageNamed: @"puzzle_maze_marker"]];
        self.bg = [GCSprite spriteWithImage: [NSImage imageNamed: @"puzzle_maze"]];
        self.marker = [[GCSpriteActor alloc] initWithSprite: markerSprite];
		
		GCVector *startLocation = [GCVector vectorWithX: 0 y: -512];
		
		self.animation =
			[GCLinearAnimation animationFrom: startLocation
										  to: [GCVector zero]
									duration: 0.5];
        
        self.path = [[GCStack alloc] init];
        self.backtrack = [[GCStack alloc] init];
        
        // self.marker.position = [GCVector vectorWithX: 8 y: 8];
        self.markerGridPosition = NSMakePoint(5, 0);
        
        [self loadPath];
    }
    return self;
}

- (void) setMarkerGridPosition:(NSPoint)p
{
    _markerGridPosition = p;
    
    // Begin marker movement animation
    GCVector *t = [GCVector vectorWithX: ((p.x - 3) * 16) - 8 y: ((p.y - 4) * 16) - 8];
    
    self.markerAnimation = [GCLinearAnimation animationFrom: self.marker.position to: t duration: 0.2];
}

- (void) renderIndividually
{
	[self.bg drawAtX: 0
				   y: 0];
    
    [self.marker render];
}

- (void) update
{
	[self.animation advance: self];
    
    if (self.markerAnimation) {
        [self.markerAnimation advance: self.marker];
        
        if (self.markerAnimation.isFinished)
            self.markerAnimation = nil;
    } else {
        NSPoint offset = NSZeroPoint;
        
        // Process keyboard input
        if ([self.keyboard keyPressed: GCKeyboardKeyLeft] && (int)self.markerGridPosition.x > 0) {
            offset = NSMakePoint(-1, 0);
        }
        if ([self.keyboard keyPressed: GCKeyboardKeyRight] && (int)self.markerGridPosition.x < 7) {
            offset = NSMakePoint(1, 0);
        }
        if ([self.keyboard keyPressed: GCKeyboardKeyDown] && (int)self.markerGridPosition.y > 0) {
            offset = NSMakePoint(0, -1);
        }
        if ([self.keyboard keyPressed: GCKeyboardKeyUp] && (int)self.markerGridPosition.y < 6) {
            offset = NSMakePoint(0, 1);
        }
        
        if ([[self offsetToToken: offset] isEqualToString: self.path.peek]) {
            NSString *token = [self.path pop];
            
            self.markerGridPosition = NSMakePoint(self.markerGridPosition.x + offset.x,
                                                  self.markerGridPosition.y + offset.y);
            
            [self.backtrack push: [self invertToken: token]];
        } else if ([[self offsetToToken: offset] isEqualToString: self.backtrack.peek]) {
            NSString *token = [self.backtrack pop];
            
            self.markerGridPosition = NSMakePoint(self.markerGridPosition.x + offset.x,
                                                  self.markerGridPosition.y + offset.y);
            
            [self.path push: [self invertToken: token]];
        }
    }
}

- (NSString *) offsetToToken: (NSPoint) o
{
    int x = (int) o.x, y = (int) o.y;
    
    if (x == 0 && y == 0)
        return @"/";
    
    if (x == 1)
        return @"R";
    if (x == -1)
        return @"L";
    if (y == 1)
        return @"U";
    return @"D";
}

- (NSString *) invertToken: (NSString *) t
{
    if ([t isEqualToString: @"U"])
        return @"D";
    if ([t isEqualToString: @"D"])
        return @"U";
    if ([t isEqualToString: @"L"])
        return @"R";
    if ([t isEqualToString: @"R"])
        return @"L";
    return @"/";
}

- (void) loadPath
{
    NSString *pathString =
        @"URUUULLDRRRUULLLLDDLLLURUU";
    
    [pathString enumerateSubstringsInRange: NSMakeRange(0, pathString.length)
                                   options: NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences
                                usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
                                            {
                                                [self.path push: substring];
                                            }];
    
    NSLog(@"Path = %@", [self.path.allObjects componentsJoinedByString: @""]);
}

@end
