//
//  RequestAPI.h
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 21/03/22.
//

@interface RequestAPI : NSObject
- (void) requestGenres: (void (^)(NSMutableArray *))completion;
- (void) requestNowPlaying: (void (^)(NSMutableArray *))completion arrayGenres:(NSMutableArray *)arrayGenres;
- (void) requestPopular: (void (^)(NSMutableArray *))completion arrayGenres:(NSMutableArray *)arrayGenres;
- (NSString*) genreIdToName: (NSMutableArray *)id arrayGenres:(NSMutableArray *)arrayGenres;
@end

