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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [self.delegate didDismissViewController:self didManually:YES];
}

- (IBAction)onAgeCheckYesButtonClick:(id)sender {
    [self.delegate didDismissViewController:self didManually:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
