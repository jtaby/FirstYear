//
//  ItemDisplayManager.m
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import "ItemDisplayManager.h"

@interface ItemDisplayManager ()

@property (nonatomic, strong) Scene *scene;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) double startTime;

@end

@implementation ItemDisplayManager

- (instancetype)initWithSceneName:(SceneName)sceneName {
    if (self = [super init]) {
        NSArray<Item *> *items = nil;
        
        if (sceneName == SceneNameWelcome) {
            items = @[
                      [[Item alloc] initWithMessage:@"One" messageType:MessageTypeString timeToShow:0.5 duration:0.5 colors:@[[UIColor redColor]]],
                      [[Item alloc] initWithMessage:@"Two" messageType:MessageTypeString timeToShow:1. duration:0.5 colors:@[[UIColor blueColor]]],
                      [[Item alloc] initWithMessage:@"Three" messageType:MessageTypeString timeToShow:1.5 duration:0.5 colors:@[[UIColor redColor]]],
                      [[Item alloc] initWithMessage:@"Four" messageType:MessageTypeString timeToShow:2. duration:0.5 colors:@[[UIColor redColor]]],
                      ];
        }
            
        self.scene = [[Scene alloc] initWithSceneName:sceneName items:items activeItem:nil currentTime:0];
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink.paused = YES;
    }
    
    return self;
}

- (void)start {
    self.displayLink.paused = NO;
    self.startTime = CACurrentMediaTime();
    
}

- (void)tick:(CADisplayLink *)displayLink {
    double currentTime = CACurrentMediaTime() - self.startTime;
    
    if (currentTime > self.scene.items.lastObject.timeToShow + self.scene.items.lastObject.duration) {
        [self.delegate sceneDidFinish:self.scene];
        self.scene = nil;
        self.displayLink.paused = YES;
    }
    
    Item *activeItem = [self itemForTime:currentTime];
    
    Scene *newScene = [[Scene alloc] initWithSceneName:self.scene.sceneName
                                                 items:self.scene.items
                                            activeItem:activeItem
                                           currentTime:currentTime];
    
    [self updateFromScene:self.scene toScene:newScene];
    
    self.scene = newScene;
}

- (Item *)itemForTime:(double)time {
    Item *activeItem = nil;
    
    for(Item *item in self.scene.items) {
        if (time >= item.timeToShow &&
            time < item.timeToShow + item.duration) {
            activeItem = item;
            break;
        }
    }
    
    return activeItem;
}

- (void)updateFromScene:(Scene *)oldScene toScene:(Scene *)newScene {
    if (oldScene.activeItem != newScene.activeItem) {
        [self.delegate showItem:newScene.activeItem];
    }
}

@end
