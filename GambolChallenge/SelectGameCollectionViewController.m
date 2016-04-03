//
//  SeleceGameCollectionViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import "SelectGameCollectionViewController.h"
#import "ShoeCollectionViewCell.h"
#import "SizeCollectionViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SelectGameCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *shoes;
@end

AVAudioPlayer *zplayer;
AVAudioPlayer *bplayer;

@implementation SelectGameCollectionViewController

static NSString * const reuseIdentifier = @"ShoeCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackgroundImage];
    _shoes = [@[@"Ezy", @"Zah", @"Zapp", @"Zeek"] mutableCopy];
    [self performSelector:@selector(playMusic:) withObject:@"choose_style"];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _shoes.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionViewHeader" forIndexPath:indexPath];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"SelectSize"])
     {
         SizeCollectionViewController *destViewController = segue.destinationViewController;
         destViewController.videoName = _shoes[[sender tag]];
     }
 }


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShoeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImage *image;
    long row = [indexPath row];
    
    // normal state
    NSString *name = [NSString stringWithFormat:@"%@_normal.png", _shoes[row]];
    image = [UIImage imageNamed: name];
    [cell.shoeButton setBackgroundImage: image forState:UIControlStateNormal];
    [cell.shoeButton setTag:row];
    // selected state
    NSString *nameOver = [NSString stringWithFormat:@"%@_over.png", _shoes[row]];
    UIImage *imageOver = [UIImage imageNamed: nameOver];
    [cell.shoeButton setBackgroundImage: imageOver forState:UIControlStateHighlighted];
    return cell;
}


#pragma mark <UICollectionViewDelegate>


- (void) setBackgroundImage {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg_selectshoes.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (IBAction)buttonClicked:(id)sender {
    [self playClick:@"click"];
    
    [self performSegueWithIdentifier:@"SelectSize" sender:sender];
}

- (void)playMusic: (NSString*) fileName {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    if([zplayer isPlaying]) return;
    zplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [zplayer setNumberOfLoops:0];
    [zplayer prepareToPlay];
    [zplayer play];
}

- (void)playClick: (NSString*) fileName {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    if([bplayer isPlaying]) return;
    bplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [bplayer setNumberOfLoops:0];
    [bplayer prepareToPlay];
    [bplayer play];
}

@end
