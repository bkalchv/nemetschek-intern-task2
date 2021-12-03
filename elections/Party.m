//
//  Party.m
//  elections
//
//  Created by Bogdan Kalchev on 2.12.21.
//

#import "Party.h"

@implementation Party
//- (instancetype)init {
//    self = [self initWithName:@"" numberOfAppearance: 0];
//    return self;
//}
- (instancetype)initWithName:(NSString *)name
          numberOfAppearance:(NSInteger)numberOfAppearance {
    self = [super init];
    if (self) {
        self.name = name;
        self.numberOfAppearance = numberOfAppearance;
        self.isChecked = false;
        self.votes = @0;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    return [object isKindOfClass:[Party class]] && [self.name isEqual:[object name]];
}

- (NSUInteger)hash {
    return [self.name hash];
}

@end
