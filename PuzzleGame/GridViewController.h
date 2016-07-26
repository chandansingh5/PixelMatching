//
//  ViewController.h
//  PuzzleGame
//
//  Created by IPHONE-17  on 2/12/14.
//  Copyright (c) 2014 IPHONE-17 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface GridViewController : UIViewController<UIGestureRecognizerDelegate ,UIAlertViewDelegate>
{
    UIImageView  * uiImageView;
    IBOutlet UIButton *gDecrementButton;
    IBOutlet UIButton *gIncrementButton;
    IBOutlet UIButton *rowButton;
    IBOutlet UIButton *gapButton;
    IBOutlet UIButton *rDecrementButton;
    IBOutlet UIButton *rIncrementButton;
}
@property (nonatomic,assign)NSInteger gridmatrowcount;
@property (nonatomic,assign)NSInteger ansmatrowcount;
@property (weak, nonatomic) IBOutlet UIButton *xChangeButton;
@property (nonatomic) NSInteger chnagingProperty;
-(void)xDrowSubViewOnView;
- (IBAction)rDecrementButton:(id)sender;
- (IBAction)rIncrementButton:(id)sender;
- (IBAction)gIncrementButton:(id)sender;
- (IBAction)gDecrementButton:(id)sender;
- (IBAction)changematrix:(id)sender;
- (IBAction)toggleMode:(id)sender;
-(void) xDrowImageViewOnScrollview:(int)count1 width:(CGFloat)xwidth;
@property (strong, nonatomic) IBOutlet UIScrollView *uiScrollView;
@end
