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

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray <Film*>* popularArray;
@property NSMutableArray <Film*>* nowPlayingArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    RequestAPI *request = [[RequestAPI alloc] init];
    [request requestGenres: ^(NSMutableArray *arrayGenres){
        
        [request requestPopular:^(NSMutableArray <Film*>* popularArray) {
            NSLog(@"%@", popularArray);
            self.popularArray = popularArray;
        } arrayGenres:arrayGenres];
        
        [request requestNowPlaying:^(NSMutableArray <Film*>* nowPlayingArray) {
            NSLog(@"%@", nowPlayingArray);
        } arrayGenres:arrayGenres];
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 2;
    }else{
        return 99;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


@end
