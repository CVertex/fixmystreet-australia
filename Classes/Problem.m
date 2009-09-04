// Problem.m
// FixMyStreet
//
// Created by Jake MacMullin on 9/06/09.

#import "Problem.h"


@implementation Problem

@synthesize name;
@synthesize coordinate;
@synthesize photo;
@synthesize personName;
@synthesize personEmailAddress;
@synthesize personPhoneNumber;
@synthesize subtitle;

- (id)initWithName:(NSString *)aName {
  if(self = [super init]) {
		name = aName;
	}
	return self;
}

- (id)initWithName:(NSString *)aName coordinate:(CLLocationCoordinate2D)aCoordinate {
	if(self = [self initWithName:aName]) {
		coordinate = aCoordinate;
	}
	return self;
}

- (NSString *)title {
	NSString *title = [NSString stringWithFormat:@"Here lies %@", name];
	return title;
}

@end
