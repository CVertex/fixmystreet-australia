// DraggablePinView.m
// FixMyStreet
//
// Created by Jake MacMullin on 13/06/09.
//

#import "DraggablePinView.h"


@implementation DraggablePinView

// doing initialisation here rather than in 'initWithFrame' as
// this view is loaded from the .xib file so that 'init..' is
// not called.
- (id)initWithCoder:(NSCoder *)coder {
  if(self = [super initWithCoder:coder]) {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 120.0, 117.0)];
    [imageView setImage:[UIImage imageNamed:@"hovering_pin.png"]];
    [self addSubview:imageView];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self setBackgroundColor:[UIColor redColor]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint loc = [[touches anyObject] locationInView:self.superview];
	[self setFrame:CGRectMake(loc.x - self.frame.size.width/2, loc.y -  self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self setBackgroundColor:[UIColor blueColor]];
}

- (void)dealloc {
	[imageView release];
  [super dealloc];
}

@end
