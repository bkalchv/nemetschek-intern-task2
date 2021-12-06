//
//  PartyTableViewCell.h
//  elections
//
//  Created by Bogdan Kalchev on 6.12.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PartyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *partyImage;
@property (weak, nonatomic) IBOutlet UILabel *partyContent;

@end

NS_ASSUME_NONNULL_END
