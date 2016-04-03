//
//  ShoeOnViewController.h
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoeOnViewController : UIViewController
@property(nonatomic, weak) IBOutlet UIButton *readyButton;
@property(nonatomic, retain) NSString * videoName;
@property(nonatomic, weak) IBOutlet UILabel *shoeDetailLabel;
@property(nonatomic, weak) NSString * shoeSize;
@end
