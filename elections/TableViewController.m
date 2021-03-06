//
//  TableViewController.m
//  elections
//
//  Created by Bogdan Kalchev on 2.12.21.
//
#define ROW_HEIGHT 125.f
#define SCROLL_AND_HIGHLIGHT_ITN_CHANCE 25.f
#define VOTE_ITN_CHANCE 10.f

#import "TableViewController.h"
#import "Party.h"
#import "PartyTableViewCell.h"
#import "LanguageManager.h"
#import "AgeCheckViewController.h"

#import <AudioToolbox/AudioServices.h>

@interface TableViewController()
@property (strong, nonatomic) NSArray<Party*>* tableData;
@property BOOL ageCheckVCAppearedOnce;
@property BOOL resultsHidden;
@property BOOL ageCheckDismissedManually;
@property NSMutableDictionary<NSString *, NSNumber *>* votesDictionary;
@property NSIndexPath* lastSelected;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *navBarNextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarLanguageButton;
@end

@implementation TableViewController

- (NSInteger)calculateTotalVotes {
    NSInteger votesInTotal = 0;
    for (Party* party in self.tableData) {
        votesInTotal += [party.votes integerValue];
    }
    return votesInTotal;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = @[
    [[Party alloc] initWithName: @"ВМРО" numberOfAppearance: 1],
    [[Party alloc] initWithName: @"Ние Гражданите" numberOfAppearance: 2],
    [[Party alloc] initWithName: @"Български национален съюз - БНД" numberOfAppearance: 3],
    [[Party alloc] initWithName: @"БСП за България" numberOfAppearance: 4],
    [[Party alloc] initWithName: @"Възраждане" numberOfAppearance: 5],
    [[Party alloc] initWithName: @"АБВ" numberOfAppearance: 6],
    [[Party alloc] initWithName: @"Атака" numberOfAppearance: 7],
    [[Party alloc] initWithName: @"Консервативно обединение на десницата" numberOfAppearance: 8],
    [[Party alloc] initWithName: @"ДПС" numberOfAppearance: 9],
    [[Party alloc] initWithName: @"Българска прогресивна линия" numberOfAppearance: 10],
    [[Party alloc] initWithName: @"Демократична България" numberOfAppearance: 11],
    [[Party alloc] initWithName: @"Възраждане на Отечеството" numberOfAppearance: 12],
    [[Party alloc] initWithName: @"Движение Заедно за промяната" numberOfAppearance: 13],
    [[Party alloc] initWithName: @"Българско национално обединение - БНО" numberOfAppearance: 14],
    [[Party alloc] initWithName: @"Партия Нация" numberOfAppearance: 15],
    [[Party alloc] initWithName: @"МИР" numberOfAppearance: 16],
    [[Party alloc] initWithName: @"Граждани от Протеста" numberOfAppearance: 17],
    [[Party alloc] initWithName: @"Изправи се! Мутри вън!" numberOfAppearance: 18],
    [[Party alloc] initWithName: @"Глас Народен" numberOfAppearance: 19],
    [[Party alloc] initWithName: @"Движение на непартийните кандидати" numberOfAppearance: 20],
    [[Party alloc] initWithName: @"Републиканци за България" numberOfAppearance: 21],
    [[Party alloc] initWithName: @"Партия Правото" numberOfAppearance: 22],
    [[Party alloc] initWithName: @"Благоденствие-Обединение-Градивност" numberOfAppearance: 23],
    [[Party alloc] initWithName: @"Патриотична коалиция - ВОЛЯ и НФСБ" numberOfAppearance: 24],
    [[Party alloc] initWithName: @"Партия на Зелените" numberOfAppearance: 25],
    [[Party alloc] initWithName: @"Общество за Нова България" numberOfAppearance: 26],
    [[Party alloc] initWithName: @"Български съюз за директна демокрация" numberOfAppearance: 27],
    [[Party alloc] initWithName: @"ГЕРБ-СДС"  numberOfAppearance: 28],
    [[Party alloc] initWithName: @"Има такъв народ"  numberOfAppearance: 29],
    [[Party alloc] initWithName: @"Пряка демокрация" numberOfAppearance: 30],
    [[Party alloc] initWithName: @"Не подкрепям никого" numberOfAppearance: 31]];
    
    self.ageCheckVCAppearedOnce = NO;
    
    self.votesDictionary = [[NSMutableDictionary alloc] init];
    
    for (size_t idx = 0; idx < self.tableData.count; ++idx) {
        NSString* currentPartyName = self.tableData[idx].name;
        self.votesDictionary[currentPartyName] = @0;
    }
    
    self.resultsHidden = YES;
    
    self.navigationItem.leftBarButtonItem = nil;
    
    self.ageCheckDismissedManually = false;
}

- (NSInteger)getNumberOfAppearanceByPartyName:(NSString*) partyName {
    NSInteger result = -1;
    for (Party* party in self.tableData) {
        if ([party.name isEqualToString: partyName]) result = party.numberOfAppearance;
    }
    return result;
}

- (BOOL)shouldAddRandomVoteForeITN {
    int voteForITNChance = 0 + arc4random() % 100;
    return voteForITNChance <= VOTE_ITN_CHANCE;
}

- (BOOL)shouldScrollToAndHighlightITN {
    int scrollToAndHighlightITNChance = 0 + arc4random() % 100;
    return scrollToAndHighlightITNChance <= SCROLL_AND_HIGHLIGHT_ITN_CHANCE;
}

- (float) calculateVotesShareOfParty:(Party*)party {
    float partyVotes = [party.votes floatValue];
    return (partyVotes / [self calculateTotalVotes]);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString* simpleTableIdentifier = @"partyCandidateID";
     
    PartyTableViewCell* cell = (PartyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    Party* currentParty = self.tableData[indexPath.row];
    
    float currentPartyVotesShare = [self calculateVotesShareOfParty:currentParty];
    
    if (currentParty.isChecked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSString* imageFilename = [NSString stringWithFormat: @"%ld", (long) currentParty.numberOfAppearance];
    
    cell.partyImage.image = [UIImage imageNamed: imageFilename];
    if (indexPath.row == [tableView numberOfRowsInSection: indexPath.section] - 1) {
        cell.partyContent.text = [NSString stringWithFormat: @"%li. %@", (long) [self.tableData objectAtIndex:indexPath.row].numberOfAppearance, [LanguageManager.sharedLanguageManager stringForKey:@"Не подкрепям никого"]];
    } else {
        cell.partyContent.text = [NSString stringWithFormat: @"%li. %@", (long) [self.tableData objectAtIndex:indexPath.row].numberOfAppearance, [self.tableData objectAtIndex:indexPath.row].name];
    }
   
    cell.progressBarVoteResult.progress = currentPartyVotesShare;
    cell.percentageLabel.text = @"";
    
    if (self.resultsHidden) {
        cell.progressBarVoteResult.hidden = YES;
        cell.percentageLabel.hidden = YES;
    } else {
        cell.progressBarVoteResult.hidden = NO;
        if (currentPartyVotesShare >= 0.1) {
            cell.percentageLabel.text = [NSString stringWithFormat: @"%.2f%%", (double) currentPartyVotesShare * 100];
            cell.percentageLabel.hidden = NO;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (void)showAgeCheckerViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AgeCheckViewController* ageCheckVC = [storyboard instantiateViewControllerWithIdentifier:@"AgeCheckViewController"];
    ageCheckVC.presentationController.delegate = self;
    [self presentViewController:ageCheckVC animated:YES completion:nil];
    self.ageCheckVCAppearedOnce = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.ageCheckVCAppearedOnce) {
        [self showAgeCheckerViewController];
    }
}

- (void) selectParty:(NSIndexPath*)indexPath {
    Party* partyObjectAtIndexPath = [self.tableData objectAtIndex:indexPath.row];
    partyObjectAtIndexPath.isChecked = true;
}

- (void) deselectParty:(NSIndexPath*)indexPath {
    Party* partyObjectAtIndexPath = [self.tableData objectAtIndex:indexPath.row];
    partyObjectAtIndexPath.isChecked = false;
}

- (void) incrementVotesCount:(Party*)party {
    NSInteger incrVote = self.votesDictionary[party.name].integerValue + 1;
    NSNumber* incrementedVotesCount = [NSNumber numberWithInteger:incrVote];
    [party setVotes:incrementedVotesCount];
    self.votesDictionary[party.name] = party.votes;
}

- (void) highlightCellAtPath:(NSIndexPath*)indexPath {
    
            
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^void() {
//                        self.view.userInteractionEnabled = NO;
//                        [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.lightGrayColor;}
//                     completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.15
//                              delay:0.15
//                            options:UIViewAnimationOptionAllowUserInteraction
//                         animations:^void() {
//                            [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.whiteColor;}
//                         completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.15
//                                  delay:0.3                                        options:UIViewAnimationOptionAllowUserInteraction
//                             animations:^void() {
//                            [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.lightGrayColor;}
//                             completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.15
//                                        delay:0.45
//                                        options:UIViewAnimationOptionAllowUserInteraction
//                                    animations:^void() {
//                                        [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.whiteColor;}
//                                    completion:^(BOOL finished) {
//                                        self.view.userInteractionEnabled = YES;
//                    }];
//            }];
//        }];
//    }];
            
            [UIView animateKeyframesWithDuration:2.0 delay:0.0 options:UIViewKeyframeAnimationOptionAutoreverse animations:^{
            self.view.userInteractionEnabled = NO;
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.15
                                          delay:0.0
                                        options:UIViewAnimationOptionAllowUserInteraction
                                     animations:^void() {
                                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                                        [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.lightGrayColor;}
                                     completion:^(BOOL finished) {

                    }];
                });
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .75f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.15
                                          delay:0.0
                                        options:UIViewAnimationOptionAllowUserInteraction
                                     animations:^void() {
                                        [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.whiteColor;}
                                     completion:^(BOOL finished) {

                    }];
                });
            }];
            [UIView addKeyframeWithRelativeStartTime:1.0 relativeDuration:0.5 animations:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.15
                                          delay:0.0                                        options:UIViewAnimationOptionAllowUserInteraction
                                     animations:^void() {
                                        [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.lightGrayColor;}
                                     completion:^(BOOL finished) {

                    }];
                });
            }];
            [UIView addKeyframeWithRelativeStartTime:1.5 relativeDuration:0.5 animations:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.25f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.15
                                          delay:0.0
                                        options:UIViewAnimationOptionAllowUserInteraction
                                     animations:^void() {
                                        [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColor.whiteColor;}
                                     completion:^(BOOL finished) {
                                        self.view.userInteractionEnabled = YES;
                    }];
                });
            }];
        } completion:nil];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Party* selectedPartyObject = [self.tableData objectAtIndex:indexPath.row];
        
    NSInteger numberOfAttendanceITN = [self getNumberOfAppearanceByPartyName:@"Има такъв народ"];
    Party* partyITN = self.tableData[numberOfAttendanceITN - 1];
    
    UIAlertController* alertVoteCheck = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat: @"%@: %i. %@", [LanguageManager.sharedLanguageManager stringForKey:@"Отбелязахте"], selectedPartyObject.numberOfAppearance, selectedPartyObject.name] message: [LanguageManager.sharedLanguageManager stringForKey:@"Сигурни ли сте, че това е Вашият избор?"] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVoteCheck addAction: [UIAlertAction actionWithTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Да"] style:UIAlertActionStyleDefault handler:^ (UIAlertAction* action) {
        if ([self shouldAddRandomVoteForeITN]) {
            [self incrementVotesCount: partyITN];
        } else {
            [self incrementVotesCount:selectedPartyObject];
        }
        
        [self deselectParty: indexPath];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        VotedSuccessfullyViewController* votedSuccessfullyVC = [storyboard instantiateViewControllerWithIdentifier:@"VotedSuccesfullyViewController"];
        votedSuccessfullyVC.delegate = self;
        [self presentViewController:votedSuccessfullyVC animated:YES completion:nil];
    }]];
    
    [alertVoteCheck addAction: [UIAlertAction actionWithTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Не"] style:UIAlertActionStyleDestructive handler:^ (UIAlertAction* action) {
        [self deselectParty: indexPath];
        [tableView reloadData];
    }]];
    
    if ([self shouldScrollToAndHighlightITN]) {
        [self deselectParty: indexPath];
        [self.tableView reloadData];
        NSIndexPath* indexPathOfITN = [NSIndexPath indexPathForRow: (partyITN.numberOfAppearance - 1) inSection:0];
        [self.tableView scrollToRowAtIndexPath: indexPathOfITN atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self highlightCellAtPath: indexPathOfITN];
        // handles single selection
    } else {
        [self presentViewController: alertVoteCheck animated:YES completion:nil];
        if (indexPath == self.lastSelected || self.lastSelected == nil) {
            if (!selectedPartyObject.isChecked){
               [self selectParty: indexPath];
                self.lastSelected = indexPath;
           }
         } else {
             
            [self deselectParty: self.lastSelected];
            self.lastSelected = indexPath;
            [self selectParty: indexPath];
         }
    }
    
    [NSUserDefaults.standardUserDefaults setValuesForKeysWithDictionary: self.votesDictionary];
    [tableView reloadData];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (void)refreshScreen {
    [self deselectParty: self.lastSelected];
    self.ageCheckVCAppearedOnce = NO;
    NSIndexPath* indexPathTop = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPathTop atScrollPosition: UITableViewScrollPositionTop animated:NO];
    self.resultsHidden = YES;
    self.navigationItem.leftBarButtonItem = nil;
    [self.tableView reloadData];
}

- (void)makeResultsVisible {
    self.resultsHidden = NO;
    self.ageCheckVCAppearedOnce = YES;
    [self.navBarNextButton setTitle: [LanguageManager.sharedLanguageManager stringForKey: @"Следващия"]];
    self.navigationItem.leftBarButtonItem = self.navBarNextButton;
    self.tableView.allowsSelection = NO;
    [self.tableView reloadData];
}

- (IBAction)onNavBarNextButtonClick:(id)sender {
    self.tableView.allowsSelection = YES;
    [self refreshScreen];
    [self showAgeCheckerViewController];
}

-(void) localizeNavBarNextButton {
    [self.navBarNextButton setTitle: [LanguageManager.sharedLanguageManager stringForKey:@"Следващия"]];
}

- (void)showLanguageActionSheetController{
    UIAlertController* languageActionSheet = [UIAlertController alertControllerWithTitle:[LanguageManager.sharedLanguageManager stringForKey:@"Избери език"] message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Български" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageBulgarian];
        [self localizeNavBarNextButton];
        [self.tableView reloadData];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Türk" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageTurkish];
        [self localizeNavBarNextButton];
        [self.tableView reloadData];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"English" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageEnglish];
        [self localizeNavBarNextButton];
        [self.tableView reloadData];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Deutsch" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [LanguageManager.sharedLanguageManager changeToLanguage:EnumLanguageGerman];
        [self localizeNavBarNextButton];
        [self.tableView reloadData];
    }]];
    
    [languageActionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: languageActionSheet animated:YES completion:^(void) {
    }];
}

- (IBAction)onNavBarLanguageButtonClick:(id)sender {
    [self showLanguageActionSheetController];
}

- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController {
    exit(0);
}

@end

