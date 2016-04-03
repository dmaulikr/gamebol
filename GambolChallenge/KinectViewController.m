//
//  KinectViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import "KinectViewController.h"
#import <AVFoundation/AVFoundation.h>
@import AVFoundation;
@import AVKit;
@import Foundation;

@interface KinectViewController ()
@end

AVPlayer *movieplayer;
AVPlayerViewController *moviecontroller;

@implementation KinectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setBackgroundImage];
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(stopMusic)];
    [self addMoviePlayer];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void) addMoviePlayer {
    NSURL *videoURL = [[NSBundle mainBundle]URLForResource: self.videoName withExtension:@"mp4"];
    NSLog(@"PlayingVideo: %@", self.videoName);
    // create an AVPlayer
    movieplayer = [[AVPlayer alloc] init];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:videoURL];
    [movieplayer replaceCurrentItemWithPlayerItem:item];
    // create a player view controller
    moviecontroller = [[AVPlayerViewController alloc]init];
    moviecontroller.player = movieplayer;
    [self performSelector:@selector(playVideo) withObject:nil afterDelay:2.0];
    
    // show the view controller
    [self addChildViewController:moviecontroller];
    [self.view addSubview:moviecontroller.view];
    CGRect frame = self.view.frame;
    moviecontroller.view.frame = CGRectMake(0, 50, frame.size.width, frame.size.height-50);
    //
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[movieplayer currentItem]];
}

- (void) playVideo {
    [movieplayer play];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    NSLog(@"player item done");
    [self performSelector:@selector(performTransition) withObject:nil afterDelay:3.0];
}

- (void) performTransition {
    [moviecontroller.view removeFromSuperview];
    [self setBackgroundImage: [NSString stringWithFormat:@"Game-%@", self.videoName]];
    [self performSelector:@selector(goBackToEnterScreen:) withObject:nil afterDelay:7.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setBackgroundImage: (NSString*) imageName{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:imageName] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}


- (IBAction)goBackToEnterScreen:(id)sender {
    
    [self performSegueWithIdentifier:@"Restart" sender:sender];
}

@end
