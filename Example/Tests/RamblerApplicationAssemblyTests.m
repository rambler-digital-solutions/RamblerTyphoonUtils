//
//  RamblerApplicationAssemblyTests.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 15/11/15.
//  Copyright © 2015 Egor Tolstoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "RamblerApplicationAssembly_Testable.h"

#import "RamblerAppDelegate.h"

@interface RamblerApplicationAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) RamblerApplicationAssembly *assembly;

@end

@implementation RamblerApplicationAssemblyTests

#pragma mark - Lifecycle

- (void)setUp {
    [super setUp];
    
    self.assembly = [RamblerApplicationAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

#pragma mark - Tests

- (void)testThatAssemblyCreatesAppDelegateWithDependencies {
    // given
    Class expectedClass = [RamblerAppDelegate class];
    NSArray *expectedProtocols = @[ @protocol(UIApplicationDelegate), @protocol(RamblerFooProtocol) ];
    RamblerTyphoonAssemblyTestsTypeDescriptor *targetTypeDescriptor =
        [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
                                                          andProtocols:expectedProtocols];
//    NSArray *dependencies = @[ RamblerSelector(injectedString) ];

    // when
    id result = [self.assembly appDelegate];

    // then
    [self verifyTargetDependency:result
                  withDescriptor:targetTypeDescriptor];
}

@end
