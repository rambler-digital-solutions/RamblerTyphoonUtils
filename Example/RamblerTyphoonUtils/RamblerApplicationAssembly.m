//
//  RamblerApplicationAssembly.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 15/11/15.
//  Copyright © 2015 Egor Tolstoy. All rights reserved.
//

#import "RamblerApplicationAssembly.h"

#import "RamblerAppDelegate.h"

@implementation RamblerApplicationAssembly

- (RamblerAppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[RamblerAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(injectedString)
                                                    with:@"Hello, Rambler&Co!"];
                              [definition injectProperty:@selector(injectedProtocolString)
                                                    with:@"Hello, Rambler&Co!"];
                          }];
}

@end
