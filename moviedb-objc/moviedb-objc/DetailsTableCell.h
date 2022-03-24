//
//  DetailsTableCell.h
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 24/03/22.
//

#import <UIKit/UIKit.h>

@interface DetailsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@end
