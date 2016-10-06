//
//  TyphoonAssembly+CustomActivation.h
//  RamblerTyphoonUtils
//
//  Created by Vladimir Ignatov on 04/10/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#if __has_include(<Typhoon/Typhoon.h>)

#import <Typhoon/Typhoon.h>

/** 
 Category with custom activators for TyphoonAssembly
 */
@interface TyphoonAssembly(CustomActivation)

/**
 Method activate assembly with all initial assemblies as collaborating
 */
- (instancetype)rds_activateWithAllCollaboratingAssemblies;

@end

#endif
