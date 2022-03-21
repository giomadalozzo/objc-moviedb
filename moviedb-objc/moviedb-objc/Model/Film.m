//
//  Film.m
//  moviedb-objc
//
//  Created by Giovanni Madalozzo on 21/03/22.
//

#import "Film.h"

@implementation Film

- (NSString *)description {
     NSString *descriptionString = [NSString stringWithFormat:@"ID: %@, Title: %@, Overview: %@, Vote: %@ \n", self.id, self.title, self.overview, self.voteAverage];
     return descriptionString;
}

@end
