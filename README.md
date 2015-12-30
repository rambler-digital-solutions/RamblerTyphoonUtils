# RamblerTyphoonUtils

[Typhoon](https://github.com/appsquickly/Typhoon) is a great tool, and iOS team in Rambler&Co loves it a lot. Besides actual contributing, we've developed some useful tools which cannot be included in the main project.

1. `RamblerInitialAssemblyCollector` - this class can be used for activating assemblies on startup instead of plist integration.
2. `RamblerTyphoonAssemblyTests` - A base test class used for `TyphoonAssembly` testing.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#### AssemblyCollector

At first, make your assemblies conform the `RamblerInitialAssembly` protocol:

```objc
@interface ApplicationAssembly : TyphoonAssembly <RamblerInitialAssembly>

@end
```

Then, instead of adding this assembly in the `Info.plist` file, add the following code in the `AppDelegate`:

```objc
@implementation AppDelegate

- (NSArray *)initialAssemblies {
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    return [collector collectInitialAssemblyClasses];
}

@end
```

The `RamblerInitialAssemblyCollector` will find your assembly in the runtime and automatically activate it.

#### AssemblyTesting

Inherit your test from the `RamblerTyphoonAssemblyTests`:

```objc
@interface RamblerApplicationAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) RamblerApplicationAssembly *assembly;

@end
```

Write new tests: one per your assembly method:

```objc
- (void)testThatAssemblyCreatesAppDelegate {
    // given
    Class expectedClass = [RamblerAppDelegate class];
    NSArray *dependencies = @[
                              RamblerSelector(injectedString)
                              ];
    
    // when
    id result = [self.assembly appDelegate];
    
    // then
    [self verifyTargetDependency:result
                       withClass:expectedClass
                    dependencies:dependencies];
}
```

You are testing the following things:
- The target object is created
- The result is of the required class
- The result has all of the listed dependencies
- Dependencies are of the right classes

## Requirements

## Installation

RamblerTyphoonUtils is available through [CocoaPods](http://cocoapods.org). To use the `AssemblyCollector`:

```ruby
pod "RamblerTyphoonUtils/AssemblyCollector"
```

To use the `AssemblyTesting`:
```ruby
target 'ProjectNameTargetTests', :exclusive => true do
    pod "RamblerTyphoonUtils/AssemblyTesting"
end 
```

**Warning:** do not include `AssemblyTesting` subspec in the main target!

## Authors

- Egor Tolstoy, e.tolstoy@rambler-co.ru
- Irina Dyagileva, i.dyagileva@rambler-co.ru
- Andrey Rezanov, a.rezanov@rambler-co.ru
- Andrey Zarembo-Godzyatsky, a.zarembo-godzyatsky@rambler-co.ru

## License

RamblerTyphoonUtils is available under the MIT license. See the LICENSE file for more info.
