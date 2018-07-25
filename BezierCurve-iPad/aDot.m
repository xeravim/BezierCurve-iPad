//
//  aDot.m
//  BezierCurve-iPad
//
//  Created by Alvin Resmana on 11/1/16.
//  Copyright © 2016 Xeravim. All rights reserved.
//

#import "aDot.h"

@implementation aDot

- (void)touchesMoved:(NSSet *)set withEvent:(UIEvent *)event {
  CGPoint p1 = [[set anyObject] locationInView:self.superview];
  //NSLog(@"x1 = %f y1 = %f",p1.x, p1.y);
  [_delegate updatePoint:p1 :self.tag];
  self.center = p1;
}

@end
