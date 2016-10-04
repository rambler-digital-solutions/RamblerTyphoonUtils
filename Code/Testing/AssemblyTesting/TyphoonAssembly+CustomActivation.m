//
//  TyphoonAssembly+CustomActivation.h
//  RamblerTyphoonUtils
//
//  Created by Vladimir Ignatov on 04/10/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "TyphoonAssembly+CustomActivation.h"

@implementation TyphoonAssembly(CustomActivation)

- (instancetype)activateWithAllCollaboratingAssemblies {
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    NSArray *collaboratingAssemblies = [collector collectInitialAssembliesExceptOne:self];

    return [self activateWithCollaboratingAssemblies:collaboratingAssemblies];
}

@end
