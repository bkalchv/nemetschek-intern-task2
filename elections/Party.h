//
//  Party.h
//  elections
//
//  Created by Bogdan Kalchev on 2.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Party : NSObject
@property (nonatomic, strong) NSString* name;
@property (readonly) int numberOfAppearance;
@property Boolean isChecked;
@property NSNumber* votes;
- (instancetype)initWithName:(NSString *) name
          numberOfAppearance:(int) numberOfAppearance;


@end

NS_ASSUME_NONNULL_END
