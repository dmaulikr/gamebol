//
//  ShoeOnViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import "ShoeOnViewController.h"
#import "MovieViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ShoeOnViewController ()

@end

@implementation ShoeOnViewController

AVAudioPlayer *xplayer;
AVAudioPlayer *dplayer;
bool shouldPushToNextScreen;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImage];
    [self playMusic:@"wear_shoe"];
    shouldPushToNextScreen = false;
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    if(shouldPushToNextScreen) {
        [self buttonClickedNext: self.dummyButton];
    }
    shouldPushToNextScreen = !shouldPushToNextScreen;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PlayMovie"])
    {
        MovieViewController *destViewController = segue.destinationViewController;
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
    [self performSelector:@selector(transition:) withObject:sender afterDelay:1.5];
}


- (void) transition: (id)sender {
    [self performSegueWithIdentifier:@"PlayMovie" sender:sender];
}

- (IBAction)buttonClickedNext:(id)sender {
    [self performSegueWithIdentifier:@"Kinect" sender:sender];
}

- (void) setButtonCenter {
    CGRect bounds = self.readyButton.superview.bounds;
    CGRect currentBound = self.readyButton.bounds;
    self.readyButton.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetHeight(currentBound));
}

- (void)playMusic: (NSString*) fileName {
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
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
