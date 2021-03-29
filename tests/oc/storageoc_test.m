
#import <Foundation/Foundation.h>

#import "cpplib/djinni/objc/CppData.h"
#import "cpplib/djinni/objc/CppStorage.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CppStorage* s = [CppStorage create];
        if (s) {
            CppData* h = [CppData DataWithId:1 value:@"Hello"];
            CppData* w = [CppData DataWithId:2 value:@"World"];
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
