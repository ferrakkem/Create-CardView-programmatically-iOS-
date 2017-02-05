//
//  UIImage+ResizeImage.h
//  HarrikeniOS
//
//  Created by Ferrakkem Bhuiyan on 3/9/16.
//  Copyright © 2016 Harriken. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)
+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;
@end
