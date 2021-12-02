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
@property Boolean selectedParty;
@property NSInteger selectedRow;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = @[
    [[Party alloc] initWithName:@"ВМРО" numberOfAppearance: 1],
    [[Party alloc] initWithName:@"Ние Гражданите" numberOfAppearance: 2],
    [[Party alloc] initWithName:@"Български национален съюз - БНД" numberOfAppearance: 3],
    [[Party alloc] initWithName:@"БСП за България" numberOfAppearance: 4],
    [[Party alloc] initWithName:@"Възраждане" numberOfAppearance: 5],
    [[Party alloc] initWithName:@"АБВ" numberOfAppearance: 6],
    [[Party alloc] initWithName:@"Атака" numberOfAppearance: 7],
    [[Party alloc] initWithName:@"Консервативно обединение на десницата" numberOfAppearance: 8],
    [[Party alloc] initWithName:@"ДПС" numberOfAppearance: 9],
    [[Party alloc] initWithName:@"Българска прогресивна линия" numberOfAppearance: 10],
    [[Party alloc] initWithName:@"Демократична България" numberOfAppearance: 11],
    [[Party alloc] initWithName:@"Възраждане на Отечеството" numberOfAppearance: 12],
    [[Party alloc] initWithName:@"Движение Заедно за промяната" numberOfAppearance: 13],
    [[Party alloc] initWithName:@"Българско национално обединение - БНО" numberOfAppearance: 14],
    [[Party alloc] initWithName:@"Партия Нация" numberOfAppearance: 15],
    [[Party alloc] initWithName:@"МИР" numberOfAppearance: 16],
    [[Party alloc] initWithName:@"Граждани от Протеста" numberOfAppearance: 17],
    [[Party alloc] initWithName:@"Изправи се! Мутри вън!" numberOfAppearance: 18],
    [[Party alloc] initWithName:@"Глас Народен" numberOfAppearance: 19],
    [[Party alloc] initWithName:@"Движение на непартийните кандидати" numberOfAppearance: 20],
    [[Party alloc] initWithName:@"Републиканци за България" numberOfAppearance: 21],
    [[Party alloc] initWithName:@"Партия Правото" numberOfAppearance: 22],
    [[Party alloc] initWithName:@"Благоденствие-Обединение-Градивност" numberOfAppearance: 23],
    [[Party alloc] initWithName: @"Патриотична коалиция - ВОЛЯ и НФСБ" numberOfAppearance: 24],
    [[Party alloc] initWithName: @"Партия на Зелените" numberOfAppearance: 25],
    [[Party alloc] initWithName: @"Общество за Нова България" numberOfAppearance: 26],
    [[Party alloc] initWithName: @"Български съюз за директна демокрация" numberOfAppearance: 27],
    [[Party alloc] initWithName: @"ГЕРБ-СДС"  numberOfAppearance: 28],
    [[Party alloc] initWithName: @"Има такъв народ"  numberOfAppearance: 29],
    [[Party alloc] initWithName: @"Пряка демокрация" numberOfAppearance: 30],
    [[Party alloc] initWithName: @"Не подкрепям никого" numberOfAppearance: 31]];
    
    self.appearedOnce = false;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString* simpleTableIdentifier = @"partyCandidateID";
     
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    // how do you handle the "sROLL" - you dont for now
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

@end

