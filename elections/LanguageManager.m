//
//  LanguageManager.m
//  elections
//
//  Created by Bogdan Kalchev on 8.12.21.
//

#import "LanguageManager.h"

@interface LanguageManager ()

@property (strong, nonatomic) NSDictionary* currentLanguageDictionary;
@property (strong, nonatomic) NSDictionary* turkishLanguage;
@property (strong, nonatomic) NSDictionary* germanLanguage;
@property (strong, nonatomic) NSDictionary* bulgarianLanguage;
@property (strong, nonatomic) NSDictionary<NSString *, NSString *>* englishLanguage;
@property (assign) EnumLanguage currentLanguage;
@end

@implementation LanguageManager

static LanguageManager* sharedLanguageManager;

+ (instancetype)sharedLanguageManager {
    if (!sharedLanguageManager) {
        sharedLanguageManager = [[LanguageManager alloc] init];
    }
    return sharedLanguageManager;
}

- (instancetype)init {
  if (self = [super init]) {
      self.currentLanguage = EnumLanguageBulgarian;
      self.turkishLanguage = @{
          @"Не подкрепям никого": @"kimseyi desteklemiyorum",
          @"Отбелязахте": @"not ettin",
          @"Сигурни ли сте, че това е Вашият избор?": @"bunun senin seçimin olduğuna emin misin?",
          @"Да": @"Evet",
          @"Не": @"Numara",
          @"Гласувахте успешно!": @"Başarıyla oy verdiniz!",
          @"Благодарим Ви, че гласувахте!": @"oy verdiğiniz için teşekkürler!",
          @"Следващия": @"Sıradaki",
          @"Виж резултати": @"Sonuçları göster",
          @"Проверка": @"Kontrol etmek"
      };
      self.germanLanguage = @{
          @"Не подкрепям никого": @"Ich unterstuetze niemanden",
          @"Отбелязахте": @"Sie haben bemerkt",
          @"Сигурни ли сте, че това е Вашият избор?": @"Sind Sie sicher, dass dies Ihre Wahl ist?",
          @"Да": @"Ja",
          @"Не": @"Nein",
          @"Гласувахте успешно!": @"Sie waehlten erflorgreich!",
          @"Благодарим Ви, че гласувахте!": @"Danke fuer Ihre Stimme!",
          @"Следващия": @"Naechstes",
          @"Виж резултати": @"Ergebnisse ansehen",
          @"Проверка": @"Überprüfung"
      };
      self.bulgarianLanguage = @{
          @"Не подкрепям никого": @"Не подкрепям никого",
          @"Отбелязахте": @"Отбелязахте",
          @"Сигурни ли сте, че това е Вашият избор?": @"Сигурни ли сте, че това е Вашият избор?",
          @"Да": @"Да",
          @"Не": @"Не",
          @"Гласувахте успешно!": @"Гласувахте успешно!",
          @"Благодарим Ви, че гласувахте!": @"Благодарим Ви, че гласувахте!",
          @"Следващия": @"Следващия",
          @"Виж резултати": @"Виж резултати",
          @"Проверка": @"Проверка"
      };
      self.englishLanguage = @{
          @"Не подкрепям никого": @"I don't support anyone",
          @"Отбелязахте": @"You picked",
          @"Сигурни ли сте, че това е Вашият избор?": @"Are you sure that's Your choice?",
          @"Да": @"Yes",
          @"Не": @"No",
          @"Гласувахте успешно!": @"You voted successfully!",
          @"Благодарим Ви, че гласувахте!": @"Thank You for voting!",
          @"Следващия": @"Next",
          @"Виж резултати": @"Show results",
          @"Проверка": @"Attention"
      };
  }
  return self;
}

- (NSString *)stringForKey:(NSString *)key {
    if (self.currentLanguage == EnumLanguageBulgarian) {
        return key;
    }
    
    return self.currentLanguageDictionary[key];
}

- (void)changeToLanguage:(EnumLanguage)language
{
    switch (language) {
        case EnumLanguageGerman:
            [self setCurrentLanguageDictionary:_germanLanguage];
            break;
        case EnumLanguageEnglish:
            [self setCurrentLanguageDictionary:_englishLanguage];
            break;
        case EnumLanguageTurkish:
            [self setCurrentLanguageDictionary:_turkishLanguage];
            break;
        case EnumLanguageBulgarian:
            [self setCurrentLanguageDictionary:_bulgarianLanguage];
        default:
            break;
    }
}

@end
