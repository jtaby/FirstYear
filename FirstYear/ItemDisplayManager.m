//
//  ItemDisplayManager.m
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import "ItemDisplayManager.h"
#import "T.h"

#define JUMPSTARTTIME 0.

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
        NSArray<NSArray<T *> *> *preprocessedItems = nil;
        
        if (sceneName == SceneNameWelcome) {
            preprocessedItems = @[
                                  @[
                                      [T time:2.0 message:@"Dear\n"],
                                      [T time:2.5 duration:1. message:@"Dear\nAmadea,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"I've\n\n"],
                                      [T time:0.10 message:@"I've cried\n\n"],
                                      [T time:0.85 message:@"I've cried\na\n"],
                                      [T time:0.88 message:@"I've cried\na few\n"],
                                      [T time:0.93 message:@"I've cried\na few times\n"],
                                      [T time:1.47 message:@"I've cried\na few times\nin"],
                                      [T time:1.50 message:@"I've cried\na few times\nin our"],
                                      [T time:1.60 duration:1. message:@"I've cried\na few times\nin our relationship."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"I've\n"],
                                      [T time:0.10 message:@"I've cried\n"],
                                      [T time:1.00 message:@"I've cried\nfrom"],
                                      [T time:1.15 duration:1. message:@"I've cried\nfrom happiness."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"and\n"],
                                      [T time:0.10 message:@"and I've\n"],
                                      [T time:0.30 message:@"and I've cried\n"],
                                      [T time:1.00 message:@"and I've cried\nfrom"],
                                      [T time:1.15 duration:1. message:@"and I've cried\nfrom sadness."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"But"],
                                      [T time:0.10 duration:1. message:@"But today,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T songAtTime:0.00 name:@"CuzILoveYou"],
                                      [T time:0.50 message:@"I'm\n"],
                                      [T time:1.16 message:@"I'm cryin\n"],
                                      [T time:2.33 message:@"I'm cryin\n'cause"],
                                      [T time:3.00 message:@"I'm cryin\n'cause I"],
                                      [T time:3.30 message:@"I'm cryin\n'cause I love"],
                                      [T time:4.60 duration:4. message:@"I'm cryin\n'cause I love you."],
                                      [T circleAtTime:6.23],
                                      [T circleAtTime:7.33],
                                      [T circleAtTime:7.73],
                                      [T circleAtTime:8.06],
                                      [T circleAtTime:8.36],
                                      [T circleAtTime:8.66],
                                      [T buzzAtTime:6.23],
                                      [T buzzAtTime:7.33],
                                      [T buzzAtTime:7.73],
                                      [T buzzAtTime:8.06],
                                      [T buzzAtTime:8.36],
                                      [T buzzAtTime:8.66],
                                      [T gap:3.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"We are now\n"],
                                      [T time:1.00 duration:1.5 message:@"We are now\none year in."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"It has had\n"],
                                      [T time:1.00 duration:1.5 message:@"It has had\nits high ups,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:11.0 movie:@"Coachella"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"and it had\n"],
                                      [T time:1.00 duration:1.5 message:@"and it had\nits low lows."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:6 movie:@"Dad"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"But\n"],
                                      [T time:0.10 message:@"But whether\n"],
                                      [T time:0.25 message:@"But whether in\n"],
                                      [T time:0.45 message:@"But whether in joy\n"],
                                      [T time:1.00 message:@"But whether in joy\nor"],
                                      [T time:1.10 message:@"But whether in joy\nor in"],
                                      [T time:1.40 duration:1 message:@"But whether in joy\nor in sorrow,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"I've had a shoulder\n"],
                                      [T time:0.00 duration:3 message:@"I've had a shoulder\nto cry on,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:3 message:@"And I hope you've had one too."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"In need,\n\n"],
                                      [T time:0.50 message:@"In need,\nor in love,\n"],
                                      [T time:2.50 duration:3. message:@"In need,\nor in love,\nI've had a hand to hold,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:3. message:@"And I hope you've had one too."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"We've\n"],
                                      [T time:0.10 message:@"We've talked\n"],
                                      [T time:0.50 message:@"We've talked\nabout"],
                                      [T time:0.75 message:@"We've talked\nabout our"],
                                      [T time:1.0 duration:2 message:@"We've talked\nabout our days,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"And\n"],
                                      [T time:0.10 message:@"And we've\n"],
                                      [T time:0.50 message:@"And we've talked\n"],
                                      [T time:1.00 message:@"And we've talked\nabout"],
                                      [T time:1.20 message:@"And we've talked\nabout our"],
                                      [T time:1.50 duration:2 message:@"And we've talked\nabout our problems."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:2 message:@"We've been busy,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:2 message:@"we've been free."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:3 message:@"We've learned a lot,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:3 message:@"And we've seen each other grow."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"But"],
                                      [T time:0.50 duration:3 message:@"But baby,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"We're\n"],
                                      [T time:0.15 message:@"We're just\n"],
                                      [T time:1.00 message:@"We're just\ngetting"],
                                      [T time:1.50 duration:3 message:@"We're just\ngetting started,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"It\n\n"],
                                      [T time:0.10 message:@"It doesn't\n\n"],
                                      [T time:0.25 message:@"It doesn't matter\n\n"],
                                      [T time:0.80 message:@"It doesn't matter\nwhere\n"],
                                      [T time:0.95 message:@"It doesn't matter\nwhere the\n"],
                                      [T time:1.15 message:@"It doesn't matter\nwhere the journey\n"],
                                      [T time:1.35 message:@"It doesn't matter\nwhere the journey\ntakes"],
                                      [T time:1.50 duration:3 message:@"It doesn't matter\nwhere the journey\ntakes us,"],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"As long as I'm there\n"],
                                      [T time:1.00 duration:4 message:@"As long as I'm there\nwith you."],
                                      [T gap:2.0]
                                      ],
                                  @[
                                      [T time:0.00 message:@"Anything,\n\n"],
                                      [T time:2.00 message:@"Anything,\nAnywhere,\n"],
                                      [T time:4.00 duration:2 message:@"Anything,\nAnywhere,\nAnytime."],
                                      [T gap:1.0]
                                      ],
                                  @[
                                      [T time:0.00 duration:4 image:@"Jewel.png"],
                                      [T gap:1.0]
                                      ]
                                  ];
        }
        
        double runningTime = 0;
        NSMutableArray<Item *> *items = [NSMutableArray array];
        
        for (NSArray<T *> *tList in preprocessedItems) {
            double startTimeForGroup  = runningTime;
            double groupDuration = 0.;
            
            double groupGap = 0;
            for (T *t in tList) {
                if (t.messageType == MessageTypeGap) {
                    groupGap += t.showAt;
                }
            }
            
            for (T *t in tList) {
                if (t.messageType != MessageTypeGap) {
                    double timeToShow = startTimeForGroup + t.showAt;
                    double duration = 0;
                    
                    if (t.duration > 0.) {
                        duration = t.duration;
                    }
                    else if (t == tList.lastObject) {
                        duration = 1.;
                    }
                    else {
                        duration = tList[[tList indexOfObject:t] + 1].showAt - t.showAt;
                    }
                    
                    if (t.messageType == MessageTypeString ||
                        t.messageType == MessageTypeVideo) {
                        groupDuration = t.showAt + duration;
                    }
                    
                    MessageType messageType = t.messageType;
                    NSString *message = t.message;
                    Item *item = [[Item alloc] initWithTimeToShow:timeToShow duration:duration messageType:messageType message:message];
                    [items addObject:item];
                }
            }
            
            runningTime += groupDuration + groupGap;
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
    NSLog(@"Resume after %.3f pause", self.accumulatedPauseTime);
}

- (void)tick:(CADisplayLink *)displayLink {
    double currentTime = CACurrentMediaTime() + JUMPSTARTTIME - self.startTime - self.accumulatedPauseTime;
    
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
