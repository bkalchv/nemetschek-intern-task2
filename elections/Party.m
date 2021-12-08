//
//  Party.m
//  elections
//
//  Created by Bogdan Kalchev on 2.12.21.
//

#import "Party.h"
@interface Party ()
@property (assign) int numberOfAppearance;
@end
@implementation Party
//- (instancetype)init {
//    self = [self initWithName:@"" numberOfAppearance: 0];
//    return self;
//}
- (instancetype)initWithName:(NSString *)name
          numberOfAppearance:(int)numberOfAppearance {
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
    Party *rhs = (Party *)object;
    if (![rhs isKindOfClass:Party.class])
    {
        return NO;
    }
    
    return [self.name isEqualToString:rhs.name]
            && self.numberOfAppearance == rhs.numberOfAppearance;
}

- (NSUInteger)hash {
    return [self.name hash];
}

@end
