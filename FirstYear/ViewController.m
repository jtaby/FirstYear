//
//  ViewController.m
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import "ViewController.h"
#import "ItemDisplayManager.h"
#import "UIColor+hex.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <ItemDisplayManagerDelegate>

@property (nonatomic, strong) ItemDisplayManager *displayManager;
@property (nonatomic, strong) NSMutableDictionary<Item *, id> *activeViews;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) AVPlayer *audioPlayer;
@property (nonatomic, strong) NSArray<NSArray<id> *> *colors;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.colors = @[
                        @[(id)[UIColor colorWithHEX:@"#E94057"].CGColor,(id)[UIColor colorWithHEX:@"#F27121"].CGColor],
                        @[(id)[UIColor colorWithHEX:@"#8A2387"].CGColor,(id)[UIColor colorWithHEX:@"#E94057"].CGColor],
                        @[(id)[UIColor colorWithHEX:@"#FDC830"].CGColor,(id)[UIColor colorWithHEX:@"#F37335"].CGColor],
                        @[(id)[UIColor colorWithHEX:@"#ED213A"].CGColor,(id)[UIColor colorWithHEX:@"#93291E"].CGColor],
                        @[(id)[UIColor colorWithHEX:@"#E94057"].CGColor,(id)[UIColor colorWithHEX:@"#F27121"].CGColor],
                        @[(id)[UIColor colorWithHEX:@"#E94057"].CGColor,(id)[UIColor colorWithHEX:@"#F27121"].CGColor],
                        ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayManager = [[ItemDisplayManager alloc] initWithSceneName:SceneNameWelcome];
    self.displayManager.delegate = self;
    
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.gradientLayer.frame = self.view.layer.bounds;
    self.gradientLayer.startPoint = CGPointZero;
    self.gradientLayer.endPoint = CGPointMake(0., 1.);
    [self.view.layer addSublayer:self.gradientLayer];
    
    
    __block int i = -1;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3. repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSArray *colors = self.colors[++i % self.colors.count];
        [CATransaction begin];
        [CATransaction setAnimationDuration:3.];
        self.gradientLayer.colors = colors;
        [CATransaction commit];
    }];
    
    [timer fire];
    
    self.activeViews = [NSMutableDictionary dictionary];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.displayManager start];
}

- (void)showItems:(NSArray<Item *> *)items {
    NSDictionary *existingItems = [self.activeViews copy];
    
    for (Item *existingItem in existingItems) {
        if (![items containsObject:existingItem]) {
            if (existingItem.messageType == MessageTypeString ||
                existingItem.messageType == MessageTypeImage) {
//                NSLog(@"Removing %@", existingItem);
                [self.activeViews[existingItem] removeFromSuperview];
            }
            else if (existingItem.messageType == MessageTypeSong) {

            }
            self.activeViews[existingItem] = nil;
        }
    }
    
    [items enumerateObjectsUsingBlock:^(Item * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.activeViews objectForKey:obj] == nil) {
            [self showItem:obj];
        }
    }];
}

- (void)showItem:(Item *)item {
    UIView *viewToShow = nil;
    UIView *circle = nil;
    AVPlayerItem *playerItem = nil;
    AVPlayer *audioPlayer = nil;
    
    switch(item.messageType) {
        case MessageTypeImage:
            viewToShow = [self imageViewForItem:item];
            break;
        case MessageTypeString:
            viewToShow = [self labelForItem:item];
            break;
        case MessageTypeVideo:
            viewToShow = [self videoPlayerForItem:item];
            break;
        case MessageTypeSong:
            self.audioPlayer = [[AVPlayer alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"CuzILoveYou" withExtension:@"mp3"]];
            [self.audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
            audioPlayer = self.audioPlayer;
            [self.displayManager pause];
            break;
        case MessageTypeCircle:
            circle = [self circleForItem:item];
            break;
        default:break;
    }
    
    if (viewToShow) {
        [self showView:viewToShow forItem:item];
    }
    else if (circle) {
        [self animateCircle:circle forItem:item];
    }
    else if  (audioPlayer) {
        self.activeViews[item] = audioPlayer;
        [self.displayManager pause];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (self.audioPlayer.status == AVPlayerStatusReadyToPlay) {
        [NSTimer scheduledTimerWithTimeInterval:.15 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self.audioPlayer play];
            [self.displayManager resume];
        }];
    }
}

- (void)sceneDidFinish:(Scene *)scene {
    
}

- (UIImageView *)imageViewForItem:(Item *)item {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item.message]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    return imageView;
}

- (UILabel *)labelForItem:(Item *)item {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = item.message;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    return label;
}

- (UIView *)videoPlayerForItem:(Item *)item {
    return nil;
}

- (UIView *)circleForItem:(Item *)item {
    UIView *circle = [[UIView alloc] initWithFrame:CGRectZero];
    circle.layer.cornerRadius = 400;
    circle.alpha = 0.7;
    circle.backgroundColor = [UIColor whiteColor];
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [circle.widthAnchor constraintEqualToConstant:800],
                                              [circle.heightAnchor constraintEqualToAnchor:circle.widthAnchor],
                                              ]];
    
    circle.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    return circle;
}

- (void)showView:(UIView *)view forItem:(Item *)item {
    [self.view addSubview:view];
    
    self.activeViews[item] = view;
    
    //    NSLog(@"Showing %@", item);
    
    [NSLayoutConstraint activateConstraints:@[
                                              [view.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
                                              [view.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
                                              [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              ]];
}

- (void)animateCircle:(UIView *)view forItem:(Item *)item {
    [self.view addSubview:view];
    
    self.activeViews[item] = view;
    
    int lowerBound = 50;
    int upperBound = self.view.frame.size.width - 50;
    int x = lowerBound + arc4random_uniform(upperBound - lowerBound + 1);
    x -= upperBound / 2.;
    
    lowerBound = 50;
    upperBound = self.view.frame.size.width - 50;
    int y = lowerBound + arc4random_uniform(upperBound - lowerBound + 1);
    y -= upperBound / 2.;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:x],
                                              [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:y],
                                              ]];
 
    [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:1. initialSpringVelocity:1. options:0 animations:^{
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {

    }];
    
    [UIView animateWithDuration:0.6 delay:0.1 options:0 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

@end
