//
//  ViewController.m
//  Card View
//
//  Created by Ferrakkem Bhuiyan on 2/5/17.
//  Copyright © 2017 Ferrakkem Bhuiyan. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+dynamicSizeMe.h"
#import "UIImage+ResizeImage.h"
#import "KIImagePager.h"

@interface ViewController ()<KIImagePagerDelegate, KIImagePagerDataSource>
{
    int buttonY;
    UIScrollView *scrollView;
    NSMutableArray *restaurantArrayAreaBais;
    IBOutlet KIImagePager *_imagePager;
    
    /*for top Pager*/
    
    NSMutableArray *sponsoredImage;
    NSMutableArray *sponsoredLable;
    UILabel *featuredLabel;
     NSArray *sponsoredRestaurant;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"title";
    
    self.navigationItem.title = @"title";
    
    [self createVerticalScroll];
}



#pragma mark :: Generate Scroll View
- (void)createVerticalScroll
{
    
    if (scrollView) {
        [scrollView removeFromSuperview];
    }
    buttonY = 0;
    // scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topLabelFrame.size.height + 10, screenWidth, screenHeight- (50))];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,60, screenWidth, screenHeight- (50))];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, buttonY);
    scrollView.backgroundColor =  UIColorFromRGB(0x1f1f1f);
    
    int listHieht = 130;
    
    int count = (int)[restaurantArrayAreaBais count];
    
    for (int i = 0; i < 5; i++)
    {
#pragma :: list view generate
        UIView *listView = [[UIView alloc] initWithFrame:CGRectMake(10, buttonY+20 , screenWidth-20, listHieht)];
        listView.backgroundColor =[UIColor clearColor];
        listView.layer.cornerRadius = 3;
        listView.layer.masksToBounds = YES;
        listView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        listView.layer.borderWidth = .30f;
        [scrollView addSubview:listView];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenWidth-20, listHieht)];
        button.tag = i;
        button.backgroundColor = [UIColor clearColor];
        [listView addSubview:button];
        
        /**/
        buttonY = buttonY + listView.frame.size.height;
        [button addTarget:self action:@selector(deatlshowRest:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *urlStr = [[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"image"];
        //NSLog(@"vertical urlStr  %@", urlStr);
        
#pragma :: UIImageView generate
        
        UIImageView *setImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth-20, listHieht)];//screenWidth-10, 120
        //[setImage setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"loadingHarriken.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        setImage.contentMode = UIViewContentModeScaleAspectFill;//UIViewContentModeScaleAspectFill
        [setImage setImage:[UIImage imageNamed:@"Food.jpg"]];
        //setImage.backgroundColor =[UIColor blackColor];
        setImage.alpha = 1.0f;
        [button addSubview:setImage];
        
        UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth-20, listHieht)];
        overlayView.backgroundColor = [UIColor blackColor];
        overlayView.layer.opacity = 0.20;
        overlayView.layer.cornerRadius = 3;
        overlayView.layer.masksToBounds = YES;
        [setImage addSubview:overlayView];
        
        [listView addSubview:button];
        
#pragma :: share button generate
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton setImage:[UIImage imageWithImage:[UIImage imageNamed:@"dShare"] convertToSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        shareButton.backgroundColor = [UIColor clearColor];
        shareButton.frame = CGRectMake(listView.bounds.size.width - 40,listView.bounds.size.height-125,30,30);
        //shareButton.tag = 2;
        [listView addSubview:shareButton];
        
#pragma :: call button Generate
        
        UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [callButton setImage:[UIImage imageWithImage:[UIImage imageNamed:@"dCall"] convertToSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
        [callButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        callButton.backgroundColor = [UIColor clearColor];
        callButton.frame = CGRectMake(listView.bounds.size.width - 40,listView.bounds.size.height-40,30,30);
        callButton.tag = i;
        //[callButton setTag:callButton.tag];
        [listView addSubview:callButton];
        
#pragma :: Restaurent name Generate
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, listView.bounds.size.height - 50 , screenWidth - 30, 18)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"SFUIText-Bold" size:15.0];
        label.text = [[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"name"];
        label.numberOfLines =0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentLeft;
        [listView addSubview:label];
        
#pragma :: Location name Generate
        UILabel *Loclabel = [[UILabel alloc] initWithFrame:CGRectMake(10, listView.bounds.size.height - 30 , screenWidth - 30, 16)];
        Loclabel.backgroundColor = [UIColor clearColor];
        Loclabel.font = [UIFont fontWithName:@"SFUIText-Bold" size:13.0];
        Loclabel.text = [[[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"locationname"] uppercaseString];
        Loclabel.numberOfLines =0;
        Loclabel.lineBreakMode = NSLineBreakByWordWrapping;
        Loclabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        Loclabel.textAlignment = NSTextAlignmentLeft;
        [listView addSubview:Loclabel];
        
#pragma ::Generate Title View for show distance, restaurant type and restaurant specialty
        UIView *titleLabelBG = [[UIView alloc] initWithFrame:CGRectMake(10, buttonY+15, screenWidth-20, 60)];
        titleLabelBG.backgroundColor = [UIColor whiteColor];
        titleLabelBG.layer.cornerRadius = 3;
        [scrollView addSubview:titleLabelBG];
        
        //[[[restListArray  objectAtIndex:indexPath.row] objectForKey:@"locationname"] uppercaseString]
        
#pragma :: distance label Generate
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 , listView.bounds.size.width - 20, 16)];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.font = [UIFont fontWithName:@"SFUIText-Regular" size:13.0];
        //distanceLabel.text =[NSString stringWithFormat:@"About on %@ km away",[[restaurantArrayAreaBais objectAtIndex:i] objectForKey:@"distance"]];
        distanceLabel.text =[NSString stringWithFormat:@"About on 50km away"];
        distanceLabel.numberOfLines = 0;
        distanceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        distanceLabel.textColor = [UIColor colorWithRed:0.949 green:0.388 blue:0.133 alpha:1];
        distanceLabel.textAlignment = NSTextAlignmentNatural;
        [titleLabelBG addSubview:distanceLabel];
        
        
#pragma :: Price  name Generate
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 21 , listView.bounds.size.width - 20, 16)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.font = [UIFont fontWithName:@"SFUIText-Regular" size:13.0];
        //NSString*price = [NSString stringWithFormat:@"%@ from $%@",[[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"pricename"],[[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"pricevalue"]];
        NSString *price = [NSString stringWithFormat:@"$15 from $25"];
        priceLabel.text =  price;
        priceLabel.numberOfLines = 0;
        priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        priceLabel.textColor = [UIColor colorWithRed:0.949 green:0.388 blue:0.133 alpha:1];
        priceLabel.textAlignment = NSTextAlignmentNatural;
        [titleLabelBG addSubview:priceLabel];
        
#pragma :: Restaurent type Generate
        
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 21 , listView.bounds.size.width - 20, 16)];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.font = [UIFont fontWithName:@"SFUIText-Regular" size:13.0];
        NSString *rTStringType = [[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"type"];
        //NSString *rTStringType = @"Pizza";
        if (rTStringType.length == 0) {
            [typeLabel setText:[rTStringType substringToIndex:[rTStringType length]]];
        }else{
            [typeLabel setText:[rTStringType substringToIndex:[rTStringType length] - 2]];
        }
        typeLabel.numberOfLines = 0;
        typeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        typeLabel.textColor = [UIColor grayColor];
        typeLabel.textAlignment = NSTextAlignmentNatural;
        [titleLabelBG addSubview:typeLabel];
        
        
#pragma :: Restaurent specialty Label Generate
        UILabel *specialtyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 37 , listView.bounds.size.width - 20, 16)];
        specialtyLabel.backgroundColor = [UIColor clearColor];
        specialtyLabel.font = [UIFont fontWithName:@"SFUIText-Regular" size:13.0];
       // NSString *rTStringSpecialty = [[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"specialty"];
        NSString *rTStringSpecialty = @"Pizza  ";
        if (rTStringSpecialty.length == 0) {
            [specialtyLabel setText:[rTStringSpecialty substringToIndex:[rTStringSpecialty length]]];
        }else{
            [specialtyLabel setText:[rTStringSpecialty substringToIndex:[rTStringSpecialty length] - 2]];
        }
        
        specialtyLabel.numberOfLines = 0;
        specialtyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        specialtyLabel.textColor = UIColorFromRGB(0x7ca034);
        specialtyLabel.textAlignment = NSTextAlignmentNatural;
        [titleLabelBG addSubview:specialtyLabel];
        
#pragma mark ::EBL  Bank Partner
        
        BOOL isEbl = [[[[restaurantArrayAreaBais objectAtIndex:i] valueForKey:@"partner"] valueForKey:@"ebl"] integerValue];
        
        //NSArray *temp = [[restListArray objectAtIndex:i] valueForKey:@"partner"];
        // NSLog(@"EBL   %@", temp);
        
        if (isEbl) {
            UIImageView *patnerImage = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabelBG.bounds.size.width - (60 + 16), 25, 60, 26)];
            [patnerImage setImage:[UIImage imageNamed:@"eblBankImage"] ];
            patnerImage.contentMode = UIViewContentModeScaleAspectFill;
            //setImage.backgroundColor =[UIColor blackColor];
            patnerImage.alpha = 1.0f;
            [titleLabelBG addSubview:patnerImage];
        }
        
        buttonY = buttonY + titleLabelBG.frame.size.height + 12;
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, buttonY+40);
    scrollView.backgroundColor = [UIColor lightGrayColor];//UIColorFromRGB(0x8eaedd);
    [self.view addSubview:scrollView];
}

#pragma mark ::: Share Action Handle
- (void) deatlshowRest:(UIButton*)btn
{
    NSLog(@"");
}

#pragma mark ::: Share Action Handle
-(void) shareButtonAction:(UIButton *)btn
{
    NSLog(@"Share ");
}

#pragma mark :: Call Action Handle
-(void)callButtonAction:(UIButton *)callBtn
{
    NSLog(@"Call ");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
