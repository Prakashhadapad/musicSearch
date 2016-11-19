//
//  MSCustomTableViewCell.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *trackNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLbl;
@end
