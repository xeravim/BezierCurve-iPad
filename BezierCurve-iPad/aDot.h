//
//  aDot.h
//  BezierCurve-iPad
//
//  Created by Alvin Resmana on 11/1/16.
//  Copyright © 2016 Xeravim. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol updatePointDelegate <NSObject>
@optional
- (void)updatePoint :(CGPoint)point :(NSInteger)dotIndex;
@end
@interface aDot : UIImageView
@property (nonatomic, weak)id <updatePointDelegate> delegate;
@end
