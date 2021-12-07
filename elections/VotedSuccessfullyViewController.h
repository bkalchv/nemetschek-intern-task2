//
//  VotedSuccessfullyViewController.h
//  elections
//
//  Created by Bogdan Kalchev on 7.12.21.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VotedSuccessfullyViewControllerDelegate <NSObject>
- (void) shouldRefreshScreen;
@end

@interface VotedSuccessfullyViewController : ViewController
@property (nonatomic, weak) id <VotedSuccessfullyViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
