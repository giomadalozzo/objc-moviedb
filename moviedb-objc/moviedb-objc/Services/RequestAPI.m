//
//  RequestAPI.m
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 21/03/22.
//

#import <Foundation/Foundation.h>
#import "RequestAPI.h"
#import "Genres.h"

@implementation RequestAPI{

}
- (void) requestGenres {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/genre/movie/list?api_key=1b312813cf6df1bf51d1ada49057b17d&language=en-US"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data!=nil){
            NSError *e;
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&e];
            
            if (!json) {
                NSLog(@"Error parsing JSON: %@", e);
            } else {
                NSMutableArray *genresArray = [[NSMutableArray alloc] init];
                
                NSMutableDictionary *genres = [json valueForKey:@"genres"];
                for(id key in genres){
                     NSNumber *genreId = [genres valueForKey:@"id"];
                     NSString *genre = [genres valueForKey:@"name"];
                    Genres *auxGenre = [[Genres alloc] init];
                    auxGenre.id = genreId;
                    auxGenre.genre = genre;
                    [genresArray addObject:auxGenre];
                }
                NSLog(@"%@", genresArray);
            }
            
        }else{
            NSLog(@"Error, data is nil!");
        }
    }];
    
    [dataTask resume];
}


@end

