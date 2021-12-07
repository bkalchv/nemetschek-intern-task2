//
//  TableViewController.h
//  elections
//
//  Created by Bogdan Kalchev on 2.12.21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VotedSuccessfullyViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <VotedSuccessfullyViewControllerDelegate>
@end

NS_ASSUME_NONNULL_END
