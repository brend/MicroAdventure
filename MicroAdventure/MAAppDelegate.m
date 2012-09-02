//
//  MAAppDelegate.m
//  MicroAdventure
//
//  Created by Philipp Brendel on 02.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "MAAppDelegate.h"
#import "GCDirector.h"
#import "MAMainScene.h"
#import "GCGameView.h"

@implementation MAAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[GCGameView class];
	GCDirector *d = [GCDirector sharedDirector];
	MAMainScene *s = [[MAMainScene alloc] init];
	
	[d pushScene: s];
}

@end
