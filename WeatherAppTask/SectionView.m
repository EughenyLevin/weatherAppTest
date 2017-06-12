//
//  SectionView.m
//  WeatherAppTask
//
//  Created by Evgheny on 11.06.17.
//  Copyright © 2017 Eugheny Levin. All rights reserved.
//

#import "SectionView.h"

@interface SectionView ()

@property (assign,nonatomic) CGRect colorRect;
@property (assign,nonatomic) CGRect paperRect;

@end

@implementation SectionView


-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:self.titleLabel];
        
        _lightColor = [UIColor colorWithRed:190.0f/255.0f green:40.0f/255.0f blue:30.0f/255.0f alpha:1.0];
        _darkColor  = [UIColor colorWithRed:46.0/255.0 green:45/255.0 blue:21.0/255.0 alpha:1.0];
        
        
        return self;
    }
    else return nil;
}

-(void)drawRect:(CGRect)rect{
    
    CGFloat margin = 6.0;
    
    self.colorRect = CGRectMake(margin, margin, self.bounds.size.width- margin*2, self.bounds.size.height - self.bounds.size.height/3);
    self.titleLabel.frame = self.colorRect;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *shadowColor =[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.6];
    
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
    CGContextSetFillColorWithColor(ctx, self.lightColor.CGColor);
    CGContextFillRect(ctx, self.colorRect);
    
}
@end
