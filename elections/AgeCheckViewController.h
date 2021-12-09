//
//  AgeCheckViewController.h
//  elections
//
//  Created by Bogdan Kalchev on 9.12.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AgeCheckViewControllerDelegate <NSObject>
-(void)didDismissViewController:(UIViewController*)presentingVc didManually:(BOOL)didManually;
@end

@interface AgeCheckViewController : UIViewController
@property (nonatomic, weak) id <AgeCheckViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
