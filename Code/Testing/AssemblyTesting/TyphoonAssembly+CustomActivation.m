//
//  TyphoonAssembly+CustomActivation.h
//  RamblerTyphoonUtils
//
//  Created by Vladimir Ignatov on 04/10/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#if __has_include(<Typhoon/Typhoon.h>)

#import "TyphoonAssembly+CustomActivation.h"

@implementation TyphoonAssembly(CustomActivation)

- (instancetype)rds_activateWithAllCollaboratingAssemblies {
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    NSArray *collaboratingAssemblies = [collector collectInitialAssembliesExceptOne:self];

    return [self activateWithCollaboratingAssemblies:collaboratingAssemblies];
}

@end

#endif
