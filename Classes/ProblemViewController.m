//  ProblemViewController.m
//  FixMyStreet
//
//  Created by Jake MacMullin on 16/06/09.
//

#import "ProblemViewController.h"


@implementation ProblemViewController

- (id) initWithProblem:(Problem *)aProblem {
    if (self = [super init]) {
		problem = [aProblem retain];
	}
	return self;
}

@end
