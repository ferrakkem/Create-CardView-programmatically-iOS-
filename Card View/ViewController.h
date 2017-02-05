//
//  ViewController.h
//  Card View
//
//  Created by Ferrakkem Bhuiyan on 2/5/17.
//  Copyright © 2017 Ferrakkem Bhuiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define screenWidth                     [UIScreen mainScreen].bounds.size.width
#define screenHeight                    [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController : UIViewController


@end

