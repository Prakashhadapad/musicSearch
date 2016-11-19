//
//  MSLyricsDetailsViewController.m
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/19/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import "MSLyricsDetailsViewController.h"
#import "MSWebServiceManager.h"
#import "MSSearchLyrics.h"
#import "MSConstants.h"

@interface MSLyricsDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UITextView *lyricsTextView;
@property (weak, nonatomic) IBOutlet UILabel *trackNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *articsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLbl;

@end

@implementation MSLyricsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateView];
    [self displayMusicLyrics];
}


- (void)displayMusicLyrics {
    
    __weak typeof(self) weakSelf = self;
    MSSearchLyrics *searchLyrics = [[MSSearchLyrics alloc] init];
    [searchLyrics getLyricsFor:self.itemSelected.artistName withTrackName:self.itemSelected.trackNames withSuccessCallBack:^( id response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.lyricsTextView.text = response;
            });
        
    } withFailureCallBack:^(NSError *error) {
    }];
}

- (void) updateView {
    
    self.trackNameLbl.text = self.itemSelected.trackNames;
    self.articsNameLbl.text = self.itemSelected.artistName;
    self.albumNameLbl.text = self.itemSelected.albumName;
    MSWebServiceManager *serviceManager = [[MSWebServiceManager alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [serviceManager downloadImage:self.itemSelected.albumLargeImageUrl withSuccessCallBack:^(NSURL *tempurl) {
        weakSelf.albumImageView.image = [UIImage imageWithData:
                                    [NSData dataWithContentsOfURL:tempurl]];
    } andFailureCallBack:^(NSError *error) {
        NSLog(@"error in downloading album large image");
    }];
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

@end
