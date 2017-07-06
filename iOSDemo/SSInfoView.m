//
//  SSInfoView.m
//  iOSDemo
//
//  Created by sujeking on 2017/7/6.
//  Copyright © 2017年 szw. All rights reserved.
//

#import "SSInfoView.h"

@interface SSInfoView()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation SSInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
}

- (void)setupSubViews {
    self.numberLabel.font = [UIFont fontWithName:@"DINEngschrift" size:130];
    self.numberLabel.textColor = [UIColor whiteColor];
    
}

- (void)setNumberStr:(NSString *)numberStr {
    _numberStr = numberStr;
    self.numberLabel.text = numberStr;
}


@end
