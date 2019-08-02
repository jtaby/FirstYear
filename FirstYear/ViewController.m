//
//  ViewController.m
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import "ViewController.h"
#import "ItemDisplayManager.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <ItemDisplayManagerDelegate>

@property (nonatomic, strong) ItemDisplayManager *displayManager;
@property (nonatomic, strong) UIView *activeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayManager = [[ItemDisplayManager alloc] initWithSceneName:SceneNameWelcome];
    self.displayManager.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.displayManager start];
}

- (void)showItem:(Item *)item {
    UIView *viewToShow = nil;
    
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
    }
    
    [self showView:viewToShow forItem:item];
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
    label.textColor = [UIColor whiteColor];
    return label;
}

- (UIView *)videoPlayerForItem:(Item *)item {
    return nil;
}

- (void)showView:(UIView *)view forItem:(Item *)item {
    [self.activeView removeFromSuperview];
    
    [self.view addSubview:view];
    self.activeView = view;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              ]];
    
    self.view.backgroundColor = item.colors.firstObject;
}

@end
