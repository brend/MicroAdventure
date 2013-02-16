//
//  MAMainScene.h
//  MicroAdventure
//
//  Created by Philipp Brendel on 02.09.12.
//  Copyright (c) 2012 Entenwolf Software. All rights reserved.
//

#import "GCScene.h"
#import "MASeito.h"

#define MATileSize  16.0

@interface MAMainScene : GCScene
@property (nonatomic, strong) MASeito *seito;
@end
