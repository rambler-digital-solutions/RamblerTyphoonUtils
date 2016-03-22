//
//  RamblerInitialAssemblyCollector.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RamblerInitialAssemblyCollector.h"
#import "RamblerInitialAssembly.h"
#import <objc/runtime.h>

@implementation RamblerInitialAssemblyCollector

- (NSArray *)collectInitialAssemblyClasses {
    NSMutableSet *resultClasses = [NSMutableSet set];
    
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class nextClass = classes[i];
            if (class_conformsToProtocol(nextClass, @protocol(RamblerInitialAssembly))) {
                [resultClasses addObject:nextClass];
            }
        }
        free(classes);
    }
    return [resultClasses allObjects];
}

- (NSArray *)collectInitialAssembliesExceptOne:(id)excludedAssembly {
    NSArray<Class> *initialAssemblyClasses = [self collectInitialAssemblyClasses];
    NSMutableArray *initialAssemblies = [@[] mutableCopy];
    [initialAssemblyClasses enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != [excludedAssembly class]) {
            [initialAssemblies addObject:[obj new]];
        }
    }];
    return [initialAssemblies copy];
}

@end
