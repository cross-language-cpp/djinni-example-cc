
#import <Foundation/Foundation.h>

#import "cpplib/djinni/objc/Logger.h"
#import "cpplib/djinni/objc/Data.h"
#import "cpplib/djinni/objc/Storage.h"

@interface LogStub : NSObject <Logger>

@end


@implementation LogStub

- (BOOL)write:(int64_t)action
        id:(int64_t)id {
    // TODO, once the action if fixed, make a real stub

    //NSLog(@"Here with id: %lli", id);
    return YES;
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LogStub* l = [[LogStub alloc] init];;
        Storage* s = [Storage create: l];
        if (s) {
            Data* h = [Data DataWithId:1 value:@"Hello"];
            Data* w = [Data DataWithId:2 value:@"World"];
            if (![s add: h]) {
                [NSException raise:@"LogicalError" format:@"Can't add element"];
            }
            if ([s add: h]) {
                [NSException raise:@"LogicalError" format:@"Can add element twice"];
            }
            if (![s add: w]) {
                [NSException raise:@"LogicalError" format:@"Can't add second"];
            }
        } else {
            [NSException raise:@"LogicalError" format:@"Can create storage"];
        }
    }
    return 0;
}
