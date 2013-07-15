//
//  MACerealDesire.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 20.01.13.
//  Copyright (c) 2013 Entenwolf Software. All rights reserved.
//

#import "MACerealDesire.h"

#import "GunCase.h"
#import "MAMainScene.h"

@interface MACerealDesire ()
@property BOOL cerealMazePresented;
@property (strong, nonatomic) NSArray *cerealAccessPositions;
@end

@implementation MACerealDesire

- (id)init
{
    self = [super init];
    if (self) {
        self.unfulfilledIcon = [self createIconWithImageNamed: @"cereal_unfulfilled"];
        self.fulfilledIcon = [self createIconWithImageNamed: @"cereal_fulfilled"];
        self.icon = self.unfulfilledIcon;
        
        [self addComponent: self.icon];
		
		self.cerealAccessPositions = [NSArray arrayWithObjects:
                                        [GCVector vectorWithX: 4 * MATileSize y: 6 * MATileSize],
                                        [GCVector vectorWithX: 5 * MATileSize y: 6 * MATileSize],
                                        nil];
    }
    return self;
}

- (BOOL) conditionsMet
{
	static unichar key_x = 7;
    
	if ([[self.scene keyboard] keyPressed: key_x]
        && [self.cerealAccessPositions containsObject: [self.scene seito].position.round]
		&& !self.cerealMazePresented)
	{
		self.cerealMazePresented = YES;
		[self.scene presentCerealMaze];
	}
	
    return self.puzzleSolved;
}

@end
