//
//  RamblerApplicationAssemblyTests.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 15/11/15.
//  Copyright © 2015 Egor Tolstoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>
#import "OCMock.h"

#import "RamblerApplicationAssembly_Testable.h"

#import "RamblerAppDelegate.h"
#import "RamblerBarProtocol.h"

@interface RamblerApplicationAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) RamblerApplicationAssembly *assembly;

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
    NSArray *expectedProtocols = @[
                                   @protocol(UIApplicationDelegate),
                                   @protocol(RamblerFooProtocol)
                                   ];
    RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
        [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
                                                          andProtocols:expectedProtocols];
    NSArray *dependencies = @[
                              RamblerSelector(injectedString),
                              RamblerSelector(injectedPropertyWithProtocols)
                              ];

    // when
    id result = [self.assembly appDelegate];

    // then
    [self verifyTargetDependency:result
                  withDescriptor:resultTypeDescriptor
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesAppDelegateWithDependenciesVersion2 {
    // given
    RamblerPrepareAssemblyTestClass([RamblerAppDelegate class]);
    
    // when
    id result = [self.assembly appDelegate];
    
    // then
    RamblerVerifySetter(result, injectedString);
    RamblerVerifySetter(result, injectedPropertyWithProtocols);
    OCMVerify([result setInjectedString:ROCMConfirmToClass([NSString class])]);
    OCMVerify([result setInjectedPropertyWithProtocols:ROCMConfirmToProtocols(@protocol(RamblerBarProtocol), @protocol(RamblerFooProtocol))]);
    RamblerVerifySetter(result, injectedString);
}

@end
