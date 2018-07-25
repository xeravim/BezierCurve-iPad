//
//  ViewController.m
//  BezierCurve-iPad
//
//  Created by Alvin Resmana on 11/1/16.
//  Copyright © 2016 Xeravim. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
@interface ViewController (){
  NSMutableArray *arrayOfDots;
  int index;
  int counter;
  CAShapeLayer *shapeLayer ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Bezier Curve";
  arrayOfDots = [[NSMutableArray alloc]initWithCapacity:4];
  UITapGestureRecognizer *tapListener =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(handleTap:)];
  [self.view addGestureRecognizer:tapListener];
  // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)infoPressed:(id)sender {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Multimedia Systems Homework"
                                                  message:@"M10509809 : Alvin Resmana"
                                                 delegate:self
                                        cancelButtonTitle:@"Ok"
                                        otherButtonTitles:nil];
  [alert show];
}


//The event handling method
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
  CGPoint location = [recognizer locationInView:self.view];
  [self drawDot:location.x :location.y :location];
  
}

- (void)drawDot :(double)x :(double)y :(CGPoint)point{
  if (arrayOfDots.count < 4) {
  
    aDot *dot = [[aDot alloc] initWithFrame:CGRectMake(x, y, 40, 40)];
    dot.tag = index;
    index = index+1;
    dot.delegate = self;
    [dot setCenter:point];
    dot.userInteractionEnabled = YES;
    dot.image = [UIImage imageNamed:[NSString stringWithFormat:@"dot%d.png",index]];
    
    [self.view addSubview:dot];
    
    [arrayOfDots addObject:[NSValue valueWithCGPoint:point]];
    if (arrayOfDots.count==4) {
      CGPoint dot1 = [arrayOfDots[0] CGPointValue];
      CGPoint dot2 = [arrayOfDots[1] CGPointValue];
      CGPoint dot3 = [arrayOfDots[2] CGPointValue];
      CGPoint dot4 = [arrayOfDots[3] CGPointValue];
      [self recursive_bezier:dot1.x :dot1.y
                            :dot2.x :dot2.y
                            :dot3.x :dot3.y
                            :dot4.x :dot4.y
                            :0];

    }
  }
  else {}
  
}

- (CGPoint)dotPoint :(aDot*)dot{
  return CGPointMake(dot.frame.origin.x, dot.frame.origin.y);
}

- (void)recursive_bezier :(double)x1 :(double)y1
                         :(double)x2 :(double)y2
                         :(double)x3 :(double)y3
                         :(double)x4 :(double)y4
                         :(int)count
{

  // Calculate all the mid-points of the line segments
  //----------------------
  double x12   = (x1 + x2) / 2;
  double y12   = (y1 + y2) / 2;
  double x23   = (x2 + x3) / 2;
  double y23   = (y2 + y3) / 2;
  double x34   = (x3 + x4) / 2;
  double y34   = (y3 + y4) / 2;
  double x123  = (x12 + x23) / 2;
  double y123  = (y12 + y23) / 2;
  double x234  = (x23 + x34) / 2;
  double y234  = (y23 + y34) / 2;
  double x1234 = (x123 + x234) / 2;
  double y1234 = (y123 + y234) / 2;
  
  
  if(count>=5)
  {
    //    // Draw and stop
    //    //----------------------
    [self drawLine:x1 :y1 :x4 :y4];
    
  }
  else
  {
    // Continue subdivision
    //----------------------

    [self recursive_bezier:x1 :y1 :x12 :y12 :x123 :y123 :x1234 :y1234 :count+1];
    [self recursive_bezier:x1234 :y1234 :x234 :y234 :x34 :y34 :x4 :y4 :count+1];
    
    
  }
}

- (void)drawLine :(double)x1 :(double)y1
                 :(double)x4 :(double)y4{
 
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(x1, y1)];
  
  [path addLineToPoint:CGPointMake(x4, y4)];
  
  shapeLayer= [CAShapeLayer layer];
  shapeLayer.path = [path CGPath];
  shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
  shapeLayer.lineWidth = 2.0;
  shapeLayer.fillColor = [[UIColor clearColor] CGColor];
  
  [self.dotLayer.layer addSublayer:shapeLayer];

}

- (void)updatePoint:(CGPoint)point :(NSInteger)dotIndex{
  [arrayOfDots replaceObjectAtIndex:dotIndex withObject:[NSValue valueWithCGPoint:point]];
  
  CGPoint dot1 = [arrayOfDots[0] CGPointValue];
  CGPoint dot2 = [arrayOfDots[1] CGPointValue];
  CGPoint dot3 = [arrayOfDots[2] CGPointValue];
  CGPoint dot4 = [arrayOfDots[3] CGPointValue];
  self.dotLayer.layer.sublayers = nil;
  [self recursive_bezier:dot1.x :dot1.y
                        :dot2.x :dot2.y
                        :dot3.x :dot3.y
                        :dot4.x :dot4.y
                        :0];
  
}


@end
