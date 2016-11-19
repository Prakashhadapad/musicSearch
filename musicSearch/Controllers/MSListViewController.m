//
//  MSListViewController.m
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import "MSListViewController.h"
#import "MSCustomTableViewCell.h"
#import "MSSearchResult.h"
#import "MSStatusCode.h"
#import "MSWebServiceManager.h"
#import "MSConstants.h"
#import "MSitemDetails.h"
#import "MSLyricsDetailsViewController.h"

@interface MSListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *musicResultListview;
@property (weak, nonatomic) IBOutlet UISearchBar *musicSearchBar;
@property (strong,nonatomic) MSSearchResult *musicResultList;
@property (assign,nonatomic) NSInteger selectedItemIndex;

@end

@implementation MSListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.musicResultList = [[MSSearchResult alloc] init];
    self.musicResultListview.estimatedRowHeight = 100;
    self.musicResultListview.rowHeight = UITableViewAutomaticDimension;
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


- (void)updateMusicSearchTableWithResult:(MSStatusCode *)status {
    
    if(status.statusCode == successCode) {
        
        [self.musicResultListview reloadData];
        [self.musicResultListview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:status.statusMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           
                                       }];
        
        [alert addAction: cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}


#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
   
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
 
   [self.musicResultList retrieveMusicSearchForKey:searchBar.text andCompletionBlock:^(MSStatusCode *status) {
       
       dispatch_async(dispatch_get_main_queue(), ^{
           [self updateMusicSearchTableWithResult:status];
       });
   }];
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.musicResultList.resultArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MSCustomTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    MSitemDetails *searchItem = [[MSitemDetails alloc] init];
    searchItem = [self.musicResultList.resultArray objectAtIndex:indexPath.row];
    customCell.artistNameLbl.text = searchItem.artistName;
    customCell.trackNameLbl.text = searchItem.trackNames;
    customCell.albumNameLbl.text = searchItem.albumName;
       
    NSLog(@"ArticsNameLbl %@",customCell.artistNameLbl.text);
    
    [self.musicResultList getImageForUrl:searchItem.albumImageUrl andCompletionBlock:^(UIImage *iconImage) {
        
        if (iconImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                customCell.albumImageView.image = iconImage;
            });
            
        }
    }];
   
    return customCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_musicSearchBar resignFirstResponder];
    
    self.selectedItemIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"displayLyrics" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MSLyricsDetailsViewController *detailController = segue.destinationViewController;
    detailController.itemSelected = [self.musicResultList.resultArray objectAtIndex:self.selectedItemIndex];
    
}



@end
