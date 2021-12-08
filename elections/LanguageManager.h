//
//  LanguageManager.h
//  elections
//
//  Created by Bogdan Kalchev on 8.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    EnumLanguageEnglish,
    EnumLanguageBulgarian,
    EnumLanguageTurkish,
    EnumLanguageGerman,
} EnumLanguage;

@interface LanguageManager : NSObject

+ (instancetype)sharedLanguageManager;
- (NSString *)stringForKey:(NSString *)key;
- (void)changeToLanguage:(EnumLanguage)language;

@end

NS_ASSUME_NONNULL_END
