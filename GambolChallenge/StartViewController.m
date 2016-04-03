//
//  ViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import "StartViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface StartViewController ()

@end

AVAudioPlayer *wplayer;
AVAudioPlayer *entryPlayer;

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImage];
    self.mybutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(playEntryMusic) withObject:nil afterDelay:2.0];
}

- (void) viewWillAppear:(BOOL)animated {
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(playMusic)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setBackgroundImage {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg_enter.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void) playEntryMusic {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"enter_gambol" ofType:@"wav"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
        entryPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [    entryPlayer setNumberOfLoops:0];
    
    [entryPlayer prepareToPlay];
    [entryPlayer play];
}

- (void)playMusic: (NSString*) fileName fileType: (NSString*)fileType {
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    wplayer = nil;
    wplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [wplayer setNumberOfLoops:0];
    
    [wplayer prepareToPlay];
    [wplayer play];
}

- (IBAction)buttonClicked:(id)sender {
    double delayInSeconds = 2.0;
    
    [self playMusic:@"click" fileType:@"mp3"];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wplayer stop];
        [self performSegueWithIdentifier:@"SelectGame" sender:sender];
    });
}
- (void) centerButton {
    CGRect bounds = self.mybutton.superview.bounds;
    self.mybutton.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
}

@end
