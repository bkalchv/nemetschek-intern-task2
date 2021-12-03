//
//  TableViewController.m
//  elections
//
//  Created by Bogdan Kalchev on 2.12.21.
//

#import "TableViewController.h"
#import "Party.h"

@interface TableViewController()
@property (strong, nonatomic) NSArray<Party*>* tableData;
@property Boolean appearedOnce;
@property NSMutableDictionary<NSString *, NSNumber *>* votesDictionary;
@property NSIndexPath* lastSelected;
@end

@implementation TableViewController

- (NSInteger)totalVotes {
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
    
    self.appearedOnce = false;
    
    self.votesDictionary = [[NSMutableDictionary alloc] init];
    
    for (size_t idx = 0; idx < self.tableData.count; ++idx) {
        NSString* currentPartyName = self.tableData[idx].name;
        self.votesDictionary[currentPartyName] = @0;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString* simpleTableIdentifier = @"partyCandidateID";
     
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    Party* currentParty = self.tableData[indexPath.row];
    if (currentParty.isChecked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSString* probableImageFilename = [NSString stringWithFormat: @"%ld", (long) currentParty.numberOfAppearance];
    //bool imageExists = [UIImage imageNamed: probableImageFilename] != nil;
    cell.imageView.image = [UIImage imageNamed: probableImageFilename];
      
    cell.textLabel.text = [NSString stringWithFormat: @"%ld. %@", (long)[self.tableData objectAtIndex:indexPath.row].numberOfAppearance, [self.tableData objectAtIndex:indexPath.row].name];

    return cell;
}

- (void)viewDidAppear:(BOOL)animated {
    if (!self.appearedOnce) {
        UIAlertController* alertAgeCheck = [UIAlertController alertControllerWithTitle:@"Проверка:" message:@"Имате ли навършени 18 години?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertController* alertUnderaged = [UIAlertController alertControllerWithTitle:@"Суек, марш!" message:@"Не си пълнолетен, за да гласуваш!" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertUnderaged addAction: [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                [self presentViewController: alertUnderaged animated:YES completion:nil];
        }]];
        
        [alertUnderaged addAction: [UIAlertAction actionWithTitle:@"Not Ok" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                [self presentViewController: alertUnderaged animated:YES completion:nil];
        }]];
        
        [alertAgeCheck addAction: [UIAlertAction actionWithTitle:@"Да" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {}]];
        
        [alertAgeCheck addAction: [UIAlertAction actionWithTitle:@"Не" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                [self presentViewController: alertUnderaged animated:YES completion:nil];
                                                    //boring exit(0);
                                                }]];
        
        [self presentViewController:alertAgeCheck animated:YES completion:nil];
    }
    
    self.appearedOnce = true;
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
}

- (void) decrementVotesCount:(Party*)party {
    NSInteger decrVote = self.votesDictionary[party.name].integerValue - 1;
    NSNumber* decrementedVotesCount;
    decrementedVotesCount = (decrVote > 0) ? [NSNumber numberWithInteger:decrVote] : @0;
    [party setVotes:decrementedVotesCount];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Party* selectedPartyObject = [self.tableData objectAtIndex:indexPath.row];
    
    if (indexPath == self.lastSelected || self.lastSelected == nil) {
        if (selectedPartyObject.isChecked) {
            [self deselectParty: indexPath];
            [self decrementVotesCount:selectedPartyObject];
        } else {
            [self selectParty: indexPath];
            [self incrementVotesCount:selectedPartyObject];
        }
    } else {
        [self deselectParty: self.lastSelected];
        self.lastSelected = indexPath;
        [self incrementVotesCount: selectedPartyObject];
    }
    
    self.votesDictionary[selectedPartyObject.name] = selectedPartyObject.votes;
    [NSUserDefaults.standardUserDefaults setValuesForKeysWithDictionary: self.votesDictionary];
    [tableView reloadData];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}


@end

