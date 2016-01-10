//
//  RamblerBarFooObject.m
//  RamblerTyphoonUtils
//
//  Created by Aleksandr Sychev on 11.01.16.
//  Copyright © 2016 Egor Tolstoy. All rights reserved.
//

#import "RamblerBarFooObject.h"

@implementation RamblerBarFooObject

#pragma mark - RamblerBarProtocol methods

- (NSString *)bar {
    return @"Bar";
}

#pragma mark - RamblerFooProtocol methods

- (NSString *)foo {
    return @"Foo";
}

@end
