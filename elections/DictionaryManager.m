//
//  DictinaryManager.m
//  elections
//
//  Created by Bogdan Kalchev on 8.12.21.
//

#import "DictinaryManager.h"

@implementation DictionaryManager

@synthesize languageChoice;

+ (id) DictionaryManager {
    static DictionaryManager* dictionaryManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dictionaryManager = [[self alloc] init];
    });
}

@end
