//
//  ViewController.h
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MessageTypeString,
    MessageTypeImage,
    MessageTypeVideo,
    MessageTypeSong,
    MessageTypeLightBuzz,
    MessageTypeMediumBuzz,
    MessageTypeHeavyBuzz,
    MessageTypeCircle,
    MessageTypeGap,
} MessageType;

typedef enum : NSUInteger {
    SceneNameWelcome,
} SceneName;

@interface ViewController : UIViewController


@end

