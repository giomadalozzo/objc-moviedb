//
//  MovieViewCell.h
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 24/03/22.
//


#import <UIKit/UIKit.h>

@interface MovieViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;

@end
