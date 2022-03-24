//
//  RequestAPI.m
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 21/03/22.
//

#import <Foundation/Foundation.h>
#import "RequestAPI.h"
#import "Genres.h"
#import "Film.h"
#import "UIKit/UIKit.h"

@implementation RequestAPI{
    
}
- (void) requestGenres: (void (^)(NSMutableArray *))completion {
    
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
                    NSNumber *genreId = [key valueForKey:@"id"];
                    NSString *genre = [key valueForKey:@"name"];
                    Genres *auxGenre = [[Genres alloc] init];
                    auxGenre.id = genreId;
                    auxGenre.genre = genre;
                    [genresArray addObject:auxGenre];
                }
                
                completion(genresArray);
            }
            
            
        }else{
            NSLog(@"Error, data is nil!");
        }
    }];
    
    [dataTask resume];
}

- (void) requestNowPlaying: (void (^)(NSMutableArray *))completion arrayGenres:(NSMutableArray *)arrayGenres {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=1b312813cf6df1bf51d1ada49057b17d&language=en-US&page=1"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data!=nil){
            NSError *e;
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&e];
            
            if (!json) {
                NSLog(@"Error parsing JSON: %@", e);
            } else {
                NSMutableArray *nowPlayingArray = [[NSMutableArray alloc] init];
                
                NSMutableDictionary *nowPlaying = [json valueForKey:@"results"];
                for(id key in nowPlaying){
                    NSNumber *nowPlayingId = [key valueForKey:@"id"];
                    NSString *title = [key valueForKey:@"title"];
                    NSString *posterPath = [key valueForKey:@"poster_path"];
                    NSString *overview = [key valueForKey:@"overview"];
                    NSNumber *voteAverage = [key valueForKey:@"vote_average"];
                    NSMutableArray *genres_aux = [key valueForKey:@"genre_ids"];
                    NSString *urlPoster = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@", posterPath];
                    NSURL *url = [NSURL URLWithString:urlPoster];
                    NSData *data = [NSData dataWithContentsOfURL: url];
                    UIImage *image = [UIImage imageWithData:data];
                    
                    Film *auxFilm = [[Film alloc] init];
                    auxFilm.id = nowPlayingId;
                    auxFilm.title = title;
                    auxFilm.image = image;
                    auxFilm.overview = overview;
                    auxFilm.voteAverage = voteAverage;
                    
                    NSString *genres = [self genreIdToName: genres_aux arrayGenres: arrayGenres];
                    auxFilm.genres = genres;
                    
                    [nowPlayingArray addObject:auxFilm];
                    
                }
                
                completion(nowPlayingArray);
            }
            
            
        }else{
            NSLog(@"Error, data is nil!");
        }
    }];
    
    [dataTask resume];
    
}

- (void) requestPopular: (void (^)(NSMutableArray *))completion arrayGenres:(NSMutableArray *)arrayGenres {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=1b312813cf6df1bf51d1ada49057b17d&language=en-US&page=1"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data!=nil){
            NSError *e;
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&e];
            
            if (!json) {
                NSLog(@"Error parsing JSON: %@", e);
            } else {
                NSMutableArray *popularArray = [[NSMutableArray alloc] init];
                
                NSMutableDictionary *popularMovies = [json valueForKey:@"results"];
                for(id key in popularMovies){
                    NSNumber *popularMoviesId = [key valueForKey:@"id"];
                    NSString *title = [key valueForKey:@"title"];
                    NSString *posterPath = [key valueForKey:@"poster_path"];
                    NSString *overview = [key valueForKey:@"overview"];
                    NSNumber *voteAverage = [key valueForKey:@"vote_average"];
                    NSMutableArray *genres_aux = [key valueForKey:@"genre_ids"];
                    NSString *urlPoster = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@", posterPath];
                    NSURL *url = [NSURL URLWithString:urlPoster];
                    NSData *data = [NSData dataWithContentsOfURL: url];
                    UIImage *image = [UIImage imageWithData:data];
                    
                    Film *auxFilm = [[Film alloc] init];
                    auxFilm.id = popularMoviesId;
                    auxFilm.title = title;
                    auxFilm.image = image;
                    auxFilm.overview = overview;
                    auxFilm.voteAverage = voteAverage;
                    
                    NSString *genres = [self genreIdToName: genres_aux arrayGenres: arrayGenres];
                    auxFilm.genres = genres;
                    
                    [popularArray addObject:auxFilm];
                    
                }
                
                completion(popularArray);
            }
            
            
        }else{
            NSLog(@"Error, data is nil!");
        }
    }];
    
    [dataTask resume];
}

- (NSString*) genreIdToName: (NSMutableArray *)id arrayGenres:(NSMutableArray<Genres*> *)arrayGenres {
    NSMutableString *genresString = [NSMutableString stringWithString:@""];
    for(int i=0;i<[id count];i++){
        for(int j=0; j<[arrayGenres count];j++){
            if(arrayGenres[j].id==id[i]){
                genresString.string = [NSString stringWithFormat: @"%@%@%s", genresString, arrayGenres[j].genre, ", "];
            }
        }
    }
    NSMutableString *result = [NSMutableString stringWithString:[genresString substringToIndex:[genresString length]-2]];
    result = [NSMutableString stringWithString:[NSString stringWithFormat: @"%@%s", result, "."]];
    return result;
}
@end

