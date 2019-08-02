//
//  ItemDisplayManager.m
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import "ItemDisplayManager.h"

#define SONGINTRO 1.5

@interface ItemDisplayManager ()

@property (nonatomic, strong) Scene *scene;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double pauseTime;
@property (nonatomic, assign) double accumulatedPauseTime;

@end

@implementation ItemDisplayManager

- (instancetype)initWithSceneName:(SceneName)sceneName {
    if (self = [super init]) {
        NSArray<Item *> *items = nil;
        
        if (sceneName == SceneNameWelcome) {
            items = @[
                      [[Item alloc] initWithTimeToShow:0.0 duration:0.5 messageType:MessageTypeString message:@"Hi"],
                      [[Item alloc] initWithTimeToShow:0.5 duration:1. messageType:MessageTypeString message:@"Hi Amadea."],
                      
                      // t=0.4
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:120. messageType:MessageTypeSong  message:@"CuzILoveYou"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.50 duration:8.0 messageType:MessageTypeString message:@"I'm\n"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 1.16 duration:8.0 messageType:MessageTypeString message:@"I'm cryin\n"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 2.33 duration:8.0 messageType:MessageTypeString message:@"I'm cryin\n'cause"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 3.00 duration:8.0 messageType:MessageTypeString message:@"I'm cryin\n'cause I"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 3.30 duration:8.0 messageType:MessageTypeString message:@"I'm cryin\n'cause I love"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 4.60 duration:3.9 messageType:MessageTypeString message:@"I'm cryin\n'cause I love you."],
                      
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 6.23 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 7.33 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 7.73 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 8.06 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 8.36 duration:8.0 messageType:MessageTypeCircle message:nil],
                      ];
        }
            
        self.scene = [[Scene alloc] initWithSceneName:sceneName items:items activeItems:nil currentTime:0];
        
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

- (void)pause {
    self.displayLink.paused = YES;
    self.pauseTime = CACurrentMediaTime();
//    NSLog(@"Pause");
}

- (void)resume {
    self.accumulatedPauseTime = CACurrentMediaTime() - self.pauseTime;
    self.displayLink.paused = NO;
//    NSLog(@"Resume");
}

- (void)tick:(CADisplayLink *)displayLink {
    double currentTime = CACurrentMediaTime() - self.startTime - self.accumulatedPauseTime;
    
//    NSLog(@"Time: %.3f", currentTime);
    
    if (currentTime > self.scene.items.lastObject.timeToShow + self.scene.items.lastObject.duration) {
        [self.delegate sceneDidFinish:self.scene];
        self.scene = nil;
        self.displayLink.paused = YES;
        return;
    }
    
    NSArray<Item *> *activeItems = [self itemsForTime:currentTime];
    
    Scene *newScene = [[Scene alloc] initWithSceneName:self.scene.sceneName
                                                 items:self.scene.items
                                           activeItems:activeItems
                                           currentTime:currentTime];
    
    [self updateFromScene:self.scene toScene:newScene];
    
    self.scene = newScene;
}

- (NSArray<Item *> *)itemsForTime:(double)time {
    NSMutableArray<Item *> *items = [NSMutableArray array];
    
    for(Item *item in self.scene.items) {
        if (time >= item.timeToShow &&
            time < item.timeToShow + item.duration) {
            [items addObject:item];
        }
    }
    
    return items;
}

- (void)updateFromScene:(Scene *)oldScene toScene:(Scene *)newScene {
    if (oldScene.activeItems != newScene.activeItems) {
        [self.delegate showItems:newScene.activeItems];
    }
}

@end
