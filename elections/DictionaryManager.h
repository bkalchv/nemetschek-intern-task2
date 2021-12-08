//
//  DictionaryManager.h
//  elections
//
//  Created by Bogdan Kalchev on 8.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DictionaryManager : NSObject {
    NSString* languageChoice;
}
@property NSDictionary* turkish;
@property NSDictionary* german;
@property NSDictionary* bulgarian;

@end

NS_ASSUME_NONNULL_END
