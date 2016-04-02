//
//  MovieViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//
#import "AppDelegate.h"
#import "MovieViewController.h"
@import AVFoundation;
@import AVKit;
@import Foundation;

@interface MovieViewController ()

@end

AVPlayer *mplayer;
AVPlayerViewController *controller;

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // stop music
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(stopMusic)];
    // Do any additional setup after loading the view.
    
    NSURL *videoURL = [[NSBundle mainBundle]URLForResource: self.videoName withExtension:@"mp4"];
    NSLog(@"PlayingVideo: %@", self.videoName);
    // create an AVPlayer
    mplayer = [[AVPlayer alloc] init];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:videoURL];
    [mplayer replaceCurrentItemWithPlayerItem:item];
    // create a player view controller
    controller = [[AVPlayerViewController alloc]init];
    controller.player = mplayer;
    [self performSelector:@selector(playVideo) withObject:nil afterDelay:2.0];
    
    // show the view controller
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    controller.view.frame = self.view.frame;
    
    //
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[mplayer currentItem]];
}

- (void) playVideo {
    [mplayer play];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    NSLog(@"player item done");
    [self performSelector:@selector(buttonClicked:) withObject:nil afterDelay:2.0];
}

- (IBAction)buttonClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion: ^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
