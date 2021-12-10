//
//  AgeCheckViewController.m
//  elections
//
//  Created by Bogdan Kalchev on 9.12.21.
//

#import "AgeCheckViewController.h"
#import "LanguageManager.h"

@interface AgeCheckViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ageCheckLanguageButton;
@property (weak, nonatomic) IBOutlet UILabel *ageCheckLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageCheckYesButton;
@property (weak, nonatomic) IBOutlet UIButton *ageCheckNoButton;
@end

@implementation AgeCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) localize {
    [self.ageCheckLabel setText: [LanguageManager.sharedLanguageManager stringForKey:@"Имате ли навършени 18 години?"]];
    [self.ageCheckYesButton setTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Да"] forState:normal];
    [self.ageCheckNoButton setTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Не"] forState:normal];
}

-(void) viewWillAppear:(BOOL)animated {
    [self localize];
}

- (void)showLanguageActionSheetController{
    UIAlertController* languageActionSheet = [UIAlertController alertControllerWithTitle:[LanguageManager.sharedLanguageManager stringForKey:@"Избери език"] message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Български" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageBulgarian];
        [self localize];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Türk" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageTurkish];
        [self localize];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"English" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageEnglish];
        [self localize];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Deutsch" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageGerman];
        [self localize];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: languageActionSheet animated:YES completion:^(void) {
    }];
}

- (void)showUnderAgedAlert {
    UIAlertController* alertUnderaged = [UIAlertController alertControllerWithTitle:[LanguageManager.sharedLanguageManager stringForKey:@"Суек, марш!"] message:[LanguageManager.sharedLanguageManager stringForKey:@"Не си пълнолетен, за да гласуваш!"] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertUnderaged addAction: [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                            [self presentViewController: alertUnderaged animated:YES completion:nil];
    }]];
    
    [alertUnderaged addAction: [UIAlertAction actionWithTitle:@"Not Ok" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                            [self presentViewController: alertUnderaged animated:YES completion:nil];
    }]];
    
    [self presentViewController: alertUnderaged animated:YES completion:nil];
}

- (IBAction)onLanguageBtnClick:(id)sender {
    [self showLanguageActionSheetController];
}

- (IBAction)onAgeCheckYesButtonClick:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:self completion:nil];
}
- (IBAction)onAgeCheckNoButtonClick:(id)sender {
    [self showUnderAgedAlert];
}
@end
