//
//  UILabel+dynamicSizeMe.h
//  RecipesDemo
//
//  Created by MFerrakkem Bhuiyan on 3/11/16.
//  Copyright © 2016 Ferrakkem Bhuiyan. All rights reserved.
//


#import "UILabel+dynamicSizeMe.h"

@implementation UILabel (dynamicSizeMe)

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    
    //UIFont *font = [UIFont fontWithName:@"SolaimanLipiNormal" size:14]; //Warning! It's an example, set the font, you need
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          self.font, NSFontAttributeName,
                                          nil];
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width, 9999); //FLT_MAX or 9999
    
    CGRect expectedLabelRect = [[self text] boundingRectWithSize:maximumLabelSize
                                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                      attributes:attributesDictionary
                                                         context:nil];
    CGSize *expectedLabelSize = &expectedLabelRect.size;
    
//    return expectedLabelSize->height;
    return expectedLabelSize->height + 10;
}

-(float)expectedWidth{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    
    //UIFont *font = [UIFont fontWithName:@"SolaimanLipiNormal" size:14]; //Warning! It's an example, set the font, you need
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          self.font, NSFontAttributeName,
                                          nil];
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width, 9999); //FLT_MAX or 9999
    
    CGRect expectedLabelRect = [[self text] boundingRectWithSize:maximumLabelSize
                                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                      attributes:attributesDictionary
                                                         context:nil];
    CGSize *expectedLabelSize = &expectedLabelRect.size;
    
    //    return expectedLabelSize->height;
    return expectedLabelSize->width + 10;
}

@end
