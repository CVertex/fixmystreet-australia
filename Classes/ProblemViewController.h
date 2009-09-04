//  ProblemViewController.h
//  FixMyStreet
//
//  Created by Jake MacMullin on 16/06/09.
//  
//  This is a common parent class for all the 'problem detail'
//  view controllers in this application. It contains the basic
//  functionality that all the 'problem detail' views have in
//  common. This includes setting and getting the 'problem'.
//  

#import <Foundation/Foundation.h>
#import "Problem.h"

@interface ProblemViewController : UIViewController {
	Problem *problem;
}

- (id) initWithProblem:(Problem *)aProblem;

@end
