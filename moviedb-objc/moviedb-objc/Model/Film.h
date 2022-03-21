//
//  Film.h
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 21/03/22.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Film : NSObject

@property NSNumber* id;
@property NSString* title;
@property UIImage* image;
@property NSString* overview;
@property NSNumber* voteAverage;
@property NSString* genres;
@property(readonly, copy) NSString *description;

@end

