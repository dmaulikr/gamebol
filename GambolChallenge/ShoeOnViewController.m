//
//  ShoeOnViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import "ShoeOnViewController.h"
#import "KinectViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ShoeOnViewController ()

@end

@implementation ShoeOnViewController

AVAudioPlayer *xplayer;
AVAudioPlayer *dplayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImage];
    [self playMusic:@"wear_shoe"];
    self.shoeDetailLabel.text = [NSString stringWithFormat:@"%@ - %@", self.videoName, self.shoeSize];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Kinect"])
    {
        KinectViewController *destViewController = segue.destinationViewController;
        destViewController.videoName = self.videoName;
    }
}

- (void) setBackgroundImage {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg_3.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (IBAction)buttonClicked:(id)sender {
    [self playClick:@"click"];
    [self performSelector:@selector(goToKinect:) withObject:sender afterDelay:1.5];
}

- (void)goToKinect:(id)sender {
    [self performSegueWithIdentifier:@"Kinect" sender:sender];
}

- (void) setButtonCenter {
    CGRect bounds = self.readyButton.superview.bounds;
    CGRect currentBound = self.readyButton.bounds;
    self.readyButton.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetHeight(currentBound));
}

- (void)playMusic: (NSString*) fileName {
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    
    xplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [xplayer setNumberOfLoops:0];
    
    [xplayer prepareToPlay];
    [xplayer play];
}

- (void)playClick: (NSString*) fileName {
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    
    dplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [dplayer setNumberOfLoops:0];
    
    [dplayer prepareToPlay];
    [dplayer play];
}

@end
