//
//  RamblerTyphoonAssemblyTests.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>

#define RamblerSelector(x) NSStringFromSelector(@selector(x))

@class RamblerTyphoonAssemblyTestsTypeDescriptor;

/**
 The base class for all of the TyphoonAssembly tests
 */
@interface RamblerTyphoonAssemblyTests : XCTestCase

/**
 Method for testing an object, created via TyphoonAssembly

 @param targetObject          Created object
 @param targetTypeDescriptor  The target type descriptor
 */
- (void)verifyTargetDependency:(id)targetObject
                withDescriptor:(RamblerTyphoonAssemblyTestsTypeDescriptor *)targetTypeDescriptor;

/**
 Method for testing an object, created via TyphoonAssembly, and all of its dependencies

 @param targetDependency     Created object
 @param targetTypeDescriptor The target type descriptor
 @param dependencies         NSArray with dependencies names
 */
- (void)verifyTargetDependency:(id)targetObject
                withDescriptor:(RamblerTyphoonAssemblyTestsTypeDescriptor *)targetTypeDescriptor
                  dependencies:(NSArray *)dependencies;


#pragma mark - Obsolete methods

/**
 Method for testing an object, created via TyphoonAssembly
 
 @param targetDependency Created object
 @param targetClass      The target class
 */
- (void)verifyTargetDependency:(id)targetDependency
                     withClass:(Class)targetClass __attribute__((deprecated));

/**
 Method for testing an object, created via TyphoonAssembly, and all of its dependencies
 
 @param targetDependency Created object
 @param targetClass      The target class
 @param dependencies     NSArray with dependencies names
 */
- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
                  dependencies:(NSArray *)dependencies __attribute__((deprecated));

@end
