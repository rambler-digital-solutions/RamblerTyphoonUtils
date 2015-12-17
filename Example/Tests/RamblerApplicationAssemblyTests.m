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

- (void)setUp {
    [super setUp];
    
    self.assembly = [RamblerApplicationAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesAppDelegateConformingToProtocol {
    // given
    Class expectedClass = [RamblerAppDelegate class];
    NSArray *dependencies = @[ RamblerSelector(injectedString) ];
    NSArray *protocols = @[ RamblerProtocol(UIApplicationDelegate) ];

    // when
    id result = [self.assembly appDelegate];

    // then
    [self verifyTargetDependency:result
                       withClass:expectedClass
           conformingToProtocols:protocols
                    dependencies:dependencies];
}

@end
