//
//  VotedSuccessfullyViewController.m
//  elections
//
//  Created by Bogdan Kalchev on 7.12.21.
//

#import "VotedSuccessfullyViewController.h"
#import "LanguageManager.h"

@interface VotedSuccessfullyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *showResultsButton;
@property (weak, nonatomic) IBOutlet UILabel *votedSuccessfullyLabel;
@property (weak, nonatomic) IBOutlet UILabel *thankYouLabel;
- (IBAction)onNextButtonClick:(id)sender;
- (IBAction)onShowResultsButtonClick:(id)sender;
@end

@implementation VotedSuccessfullyViewController

- (void)viewDidLoad {
    [self.nextButton setTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Следващия"] forState:normal];
    [self.showResultsButton setTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Виж резултати"] forState:normal];
    [self.votedSuccessfullyLabel setText: [LanguageManager.sharedLanguageManager stringForKey:@"Гласувахте успешно!"]];
    [self.thankYouLabel setText: [LanguageManager.sharedLanguageManager stringForKey:@"Благодарим Ви, че гласувахте!"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onShowResultsButtonClick:(id)sender {
    [self.delegate makeResultsVisible];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNextButtonClick:(id)sender {
    [self.delegate refreshScreen];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
