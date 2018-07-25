//
//  ViewController.h
//  BezierCurve-iPad
//
//  Created by Alvin Resmana on 11/1/16.
//  Copyright © 2016 Xeravim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aDot.h"
@interface ViewController : UIViewController<updatePointDelegate>

@property (weak, nonatomic) IBOutlet UIView *dotLayer;

@end

