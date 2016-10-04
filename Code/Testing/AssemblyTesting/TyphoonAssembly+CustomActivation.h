//
//  TyphoonAssembly+CustomActivation.h
//  RamblerTyphoonUtils
//
//  Created by Vladimir Ignatov on 04/10/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Typhoon/Typhoon.h>

/** 
 Category with custom activators for TyphoonAssembly
 */
@interface TyphoonAssembly(CustomActivation)

/**
 Method activate assembly with all initial assemblies as collaborating
 */
- (instancetype)activateWithAllCollaboratingAssemblies;

@end
