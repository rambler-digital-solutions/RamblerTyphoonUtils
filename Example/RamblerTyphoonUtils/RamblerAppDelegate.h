//
//  RamblerAppDelegate.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 11/15/2015.
//  Copyright (c) 2015 Egor Tolstoy. All rights reserved.
//

@import UIKit;

#import "RamblerFooProtocol.h"

@interface RamblerAppDelegate : UIResponder <UIApplicationDelegate, RamblerFooProtocol>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *injectedString;

@end
