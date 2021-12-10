//
//  AgeCheckViewController.m
//  elections
//
//  Created by Bogdan Kalchev on 9.12.21.
//

#import "AgeCheckViewController.h"
#import "LanguageManager.h"

@interface AgeCheckViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ageCheckLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageCheckYesButton;
@property (weak, nonatomic) IBOutlet UIButton *ageCheckNoButton;
@end

@implementation AgeCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ageCheckLabel setText: [LanguageManager.sharedLanguageManager stringForKey:@"Имате ли навършени 18 години?"]];
    [self.ageCheckYesButton setTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Да"] forState:normal];
    [self.ageCheckNoButton setTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Не"] forState:normal];
    // Do any additional setup after loading the view.
}

- (IBAction)onAgeCheckYesButtonClick:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:self completion:nil];
}
- (IBAction)onAgeCheckNoButtonClick:(id)sender {

}
@end
