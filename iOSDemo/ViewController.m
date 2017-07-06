//
//  ViewController.m
//  iOSDemo
//
//  Created by sujeking on 2017/7/6.
//  Copyright © 2017年 szw. All rights reserved.
//

#import "ViewController.h"
#import "SSInfoView.h"

#define kWidth  CGRectGetWidth([[UIScreen mainScreen] bounds])

@interface ViewController ()

@property (assign, nonatomic) CGFloat endPoint;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftModelX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightModelX;
@property (weak, nonatomic) IBOutlet UILabel *leftModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightModelLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scv;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// MARK: - Init

- (void)setupUI {
    self.endPoint = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 4;
    self.rightModelX.constant = -self.endPoint;
    
    [self setLabelFrontStatus:self.rightModelLabel];
    [self setLabelBehindStatus:self.leftModelLabel];
    
    
    
    
    
    UIPanGestureRecognizer *left = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(swipeLeftAction:)];
    [self.bgView addGestureRecognizer:left];
    [self.scv setContentSize:(CGSize){2 * kWidth, 0}];
    
    SSInfoView *v1 = [[UINib nibWithNibName:@"SSInfoView" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    v1.frame = (CGRect){0,0,kWidth,CGRectGetHeight(self.scv.bounds)};
    
    SSInfoView *v2 = [[UINib nibWithNibName:@"SSInfoView" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    v2.frame = (CGRect){kWidth,0,kWidth,CGRectGetHeight(self.scv.bounds)};
    
    v1.numberStr = @"40.0";
    v2.numberStr = @"36.0";
    
    [self.scv addSubview:v1];
    [self.scv addSubview:v2];
    
    [self.scv setContentOffset:(CGPoint){kWidth,0} animated:NO];
}

- (void)injected{
    
    NSArray *array = [UIFont familyNames];
    for (NSString * familyname in array) {
        NSLog(@"Family:%@",familyname);
        NSArray *fontnames = [UIFont fontNamesForFamilyName:familyname];
        for (NSString *name in fontnames) {
            NSLog(@"Font Name:%@",name);
        }  
    }
    
}


// MARK: - Action

- (void)swipeLeftAction:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            //
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat x = [sender translationInView:self.bgView].x * 0.5;
            self.leftModelX.constant += x;
            self.rightModelX.constant += x;
            CGFloat leftFontSize = self.leftModelLabel.font.pointSize;
            CGFloat rightFontSize = self.rightModelLabel.font.pointSize;
            
            self.leftModelLabel.font = [UIFont systemFontOfSize:leftFontSize + 10 * (x / self.endPoint)];
            self.rightModelLabel.font = [UIFont systemFontOfSize:rightFontSize + 10 * (x / -self.endPoint)];
            
            
            self.leftModelLabel.textColor = [UIColor colorWithWhite:1.000 alpha:(x / self.endPoint) + 1];
            self.rightModelLabel.textColor = [UIColor colorWithWhite:1.000 alpha:(x / -self.endPoint) + 1];
            
            if (self.leftModelX.constant >= self.endPoint) {
                self.leftModelX.constant = self.endPoint;
                [self setLabelFrontStatus:self.leftModelLabel];
            }
            
            if (self.leftModelX.constant <= -30){
                self.leftModelX.constant = -30;
                [self setLabelBehindStatus:self.leftModelLabel];
            }
            
            
            if (self.rightModelX.constant <=  -self.endPoint) {
                self.rightModelX.constant = -self.endPoint;
                [self setLabelFrontStatus:self.rightModelLabel];
            }
            
            if (self.rightModelX.constant >= 30) {
                self.rightModelX.constant = 30;
                [self setLabelBehindStatus:self.rightModelLabel];
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGFloat x = [sender translationInView:self.bgView].x;
            if (x < 0) {
                if (self.leftModelX.constant > self.endPoint / 2) {
                    self.leftModelX.constant = self.endPoint;
                    self.rightModelX.constant = 30;
                    
                    [self setLabelFrontStatus:self.leftModelLabel];
                    [self setLabelBehindStatus:self.rightModelLabel];
                    
                    [self.scv setContentOffset:(CGPoint){0,0} animated:YES];
                    
                } else {
                    self.leftModelX.constant = -30;
                    self.rightModelX.constant = -self.endPoint;
                    
                    [self setLabelFrontStatus:self.rightModelLabel];
                    [self setLabelBehindStatus:self.leftModelLabel];
                    [self.scv setContentOffset:(CGPoint){kWidth,0} animated:YES];
                }
            } else {
                if (self.rightModelX.constant < -self.endPoint / 2) {
                    self.leftModelX.constant = -30;
                    self.rightModelX.constant = -self.endPoint;
                    
                    [self setLabelFrontStatus:self.rightModelLabel];
                    [self setLabelBehindStatus:self.leftModelLabel];
                    [self.scv setContentOffset:(CGPoint){kWidth,0} animated:YES];
                    
                } else {
                    self.rightModelX.constant = 30;
                    self.leftModelX.constant = self.endPoint;
                    
                    [self setLabelFrontStatus:self.leftModelLabel];
                    [self setLabelBehindStatus:self.rightModelLabel];
                    [self.scv setContentOffset:(CGPoint){0,0} animated:YES];
                }
            }
        }
        default:
            break;
    }
}

- (void)setLabelFrontStatus:(UILabel *)label {
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor whiteColor];
    
}

- (void)setLabelBehindStatus:(UILabel *)label {
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor colorWithWhite:1.000 alpha:0.600];
}




@end
