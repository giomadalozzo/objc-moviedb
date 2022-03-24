//
//  DetailsTableView.m
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 24/03/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetailsTableView.h"
#import "DetailsTableCell.h"
#import "Film.h"

@interface DetailsTableView ()
<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewDetails;

@end

@implementation DetailsTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewDetails.delegate = self;
    self.tableViewDetails.dataSource = self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DetailsTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"mainDetails"];
    
    cell.titleLabel.text = self.movie.title;
    cell.posterImage.image = self.movie.image;
//    cell.genresLabel.text = self.movie.genres;
    cell.overviewLabel.text = self.movie.overview;
    cell.starsLabel.text = [NSString stringWithFormat:@"%@",self.movie.voteAverage];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
@end
