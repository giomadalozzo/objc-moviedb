//
//  ViewController.m
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 21/03/22.
//

#import "ViewController.h"
#import "UIKit/UIKit.h"
#import "MovieViewCell.h"
#import "RequestAPI.h"
#import "Genres.h"
#import "Film.h"
#import "DetailsTableView.h"

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (strong, atomic) NSMutableArray <Film*>* popularArray;
@property (strong, atomic) NSMutableArray <Film*>* nowPlayingArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.spinner startAnimating];
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.popularArray = [[NSMutableArray <Film*> alloc] init];
    self.nowPlayingArray = [[NSMutableArray <Film*> alloc] init];
    
    RequestAPI *request = [[RequestAPI alloc] init];
    [request requestGenres: ^(NSMutableArray *arrayGenres){
        
        [request requestPopular:^(NSMutableArray <Film*>* popularArray) {
            NSLog(@"end popular");
            self.popularArray = popularArray;
        } arrayGenres:arrayGenres];
        
        [request requestNowPlaying:^(NSMutableArray <Film*>* nowPlayingArray) {
            NSLog(@"end np");
            self.nowPlayingArray = nowPlayingArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                self.tableView.hidden = NO;
            });
        } arrayGenres:arrayGenres];
        
    }];
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    if([self.popularArray count] != 0 && [self.nowPlayingArray count] != 0){
        if(indexPath.section == 0){
            cell.titleLabel.text = self.popularArray[indexPath.row].title;
            cell.aboutLabel.text = self.popularArray[indexPath.row].overview;
            cell.starsLabel.text = [NSString stringWithFormat:@"%@", self.popularArray[indexPath.row].voteAverage];
            cell.posterImage.image = self.popularArray[indexPath.row].image;
        }else{
            cell.titleLabel.text = self.nowPlayingArray[indexPath.row].title;
            cell.aboutLabel.text = self.nowPlayingArray[indexPath.row].overview;
            cell.starsLabel.text = [NSString stringWithFormat:@"%@", self.nowPlayingArray[indexPath.row].voteAverage];
            cell.posterImage.image = self.nowPlayingArray[indexPath.row].image;
        }
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 2;
    }else{
        return [self.nowPlayingArray count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Popular Movies";
    }else{
        return @"Now Playing";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header setBackgroundColor: [UIColor whiteColor]];
    [header.textLabel setTextColor:[UIColor blackColor]];
    [header.textLabel setFont:[UIFont fontWithName:@"System Bold" size:17]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsTableView* detailsVC = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if(indexPath != nil){
        NSInteger row = [indexPath row];
        NSInteger section = [indexPath section];
        if(section==0){
            detailsVC.movie = [[Film alloc] init];
            detailsVC.movie = self.popularArray[row];
        }else{
            detailsVC.movie = [[Film alloc] init];
            detailsVC.movie = self.nowPlayingArray[row];
        }
    }
}


@end
