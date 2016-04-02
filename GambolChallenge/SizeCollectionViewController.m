//
//  SizeCollectionViewController.m
//  GambolChallenge
//
//  Created by Sovanlandy Pheng on 3/26/16.
//  Copyright © 2016 Sovanlandy Pheng. All rights reserved.
//

#import "SizeCollectionViewController.h"
#import "SizeCollectionViewCell.h"
#import "ShoeOnViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SizeCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *sizes;
@end

@implementation SizeCollectionViewController
AVAudioPlayer *vplayer;
AVAudioPlayer *cplayer;
static NSString * const reuseIdentifier = @"SizeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    [self playMusic:@"choose_size"];
    [self setBackgroundImage];
    _sizes = [@[@"36", @"39", @"42", @"37", @"40", @"43", @"38", @"41", @"44"] mutableCopy];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ReadyToGo"])
    {
        ShoeOnViewController *destViewController = segue.destinationViewController;
        destViewController.videoName = self.videoName;
    }
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        return [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sizeHeader" forIndexPath:indexPath];
    }else if (kind == UICollectionElementKindSectionFooter){
        return [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sizeFooter" forIndexPath:indexPath];
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _sizes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SizeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImage *image;
    long row = [indexPath row];
    
    // normal state
    NSString *name = [NSString stringWithFormat:@"btnSize_normal.png"];
    image = [UIImage imageNamed: name];
    [cell.sizeButton setBackgroundImage: image forState:UIControlStateNormal];
    [cell.sizeButton setTitle: _sizes[row] forState:UIControlStateNormal];
    cell.sizeButton.titleLabel.font = [UIFont fontWithName:@"Marker Felt" size:24];
    [cell.sizeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // selected state
    NSString *nameOver = [NSString stringWithFormat:@"btnSize_over.png"];
    UIImage *imageOver = [UIImage imageNamed: nameOver];
    [cell.sizeButton setBackgroundImage: imageOver forState:UIControlStateSelected];
    [cell.sizeButton setBackgroundImage: imageOver forState:UIControlStateHighlighted];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void) setBackgroundImage {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg_selectshoes.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (IBAction)buttonClicked:(id)sender {
    [self playClick:@"click"];
    [vplayer stop];
    [self performSegueWithIdentifier:@"ReadyToGo" sender:sender];
}

- (void)playMusic: (NSString*) fileName {
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    
    vplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [vplayer setNumberOfLoops:0];
    
    [vplayer prepareToPlay];
    [vplayer play];
}

- (void)playClick: (NSString*) fileName {
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    
    cplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [cplayer setNumberOfLoops:0];
    
    [cplayer prepareToPlay];
    [cplayer play];
}
@end
