//
//  KinectViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import "KinectViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface KinectViewController ()

@end

@implementation KinectViewController
AVAudioPlayer *marioPlayer;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self playMusic:@"mario"];
    [self setBackgroundImage];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(buttonClicked:) withObject:self.dummyButton afterDelay:7];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setBackgroundImage {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"KinectBG.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}


- (IBAction)buttonClicked:(id)sender {
    [self performSegueWithIdentifier:@"Restart" sender:sender];
    [marioPlayer stop];
}


- (void)playMusic: (NSString*) fileName {
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    
    marioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [marioPlayer setNumberOfLoops:0];
    
    [marioPlayer prepareToPlay];
    [marioPlayer play];
}
@end
