//
//  TableViewController.h
//  elections
//
//  Created by Bogdan Kalchev on 2.12.21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VotedSuccessfullyViewController.h"
#import "AgeCheckViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <VotedSuccessfullyViewControllerDelegate, UIAdaptivePresentationControllerDelegate>
@end

NS_ASSUME_NONNULL_END
