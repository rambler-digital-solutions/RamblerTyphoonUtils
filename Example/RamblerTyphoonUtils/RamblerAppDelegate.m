//
//  RamblerAppDelegate.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 11/15/2015.
//  Copyright (c) 2015 Egor Tolstoy. All rights reserved.
//

#import "RamblerAppDelegate.h"

#import <RamblerTyphoonUtils/AssemblyCollector.h>

@implementation RamblerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"\n%@\n%@", self.injectedString, self.injectedPropertyWithProtocols);
    return YES;
}

- (NSArray *)initialAssemblies {
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    return [collector collectInitialAssemblyClasses];
}

#pragma mark - RamblerFooProtocol methods

- (NSString *)foo {
    return @"Foo";
}

@end
