//
//  ItemDisplayManager.m
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import "ItemDisplayManager.h"

#define ICRIED                1.50 + 1.0
#define CRYHAPPY ICRIED     + 3.60 + 1.0
#define CRYSAD CRYHAPPY     + 3.15 + 1.0
#define BUTTODAY CRYSAD     + 3.15 + 1.0
#define SONGINTRO BUTTODAY  + 2.10 + 1.0
#define WEARENOW SONGINTRO  + 7.60 + 3.0
#define HIGHUPS WEARENOW  + 7.60 + 3.0
#define LOWLOWS HIGHUPS  + 7.60 + 3.0
#define JOYORSORROW LOWLOWS  + 7.60 + 3.0
#define SHOULDER JOYORSORROW  + 7.60 + 3.0
#define YOUTOO1 SHOULDER  + 7.60 + 3.0

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
                      
                      [[Item alloc] initWithTimeToShow:0.0 duration:0.5 messageType:MessageTypeString message:@"Dear\n"],
                      [[Item alloc] initWithTimeToShow:0.5 duration:1.0 messageType:MessageTypeString message:@"Dear\nAmadea,"],
                      
                      [[Item alloc] initWithTimeToShow:ICRIED + 0.05 duration:0.5 messageType:MessageTypeString message:@"I've\n\n"],
                      [[Item alloc] initWithTimeToShow:ICRIED + 0.10 duration:0.8 messageType:MessageTypeString message:@"I've cried\n\n"],
                      [[Item alloc] initWithTimeToShow:ICRIED + 0.85 duration:0.5 messageType:MessageTypeString message:@"I've cried\na\n"],
                      [[Item alloc] initWithTimeToShow:ICRIED + 0.88 duration:0.5 messageType:MessageTypeString message:@"I've cried\na few\n"],
                      [[Item alloc] initWithTimeToShow:ICRIED + 0.93 duration:0.5 messageType:MessageTypeString message:@"I've cried\na few times\n"],
                      [[Item alloc] initWithTimeToShow:ICRIED + 1.47 duration:0.5 messageType:MessageTypeString message:@"I've cried\na few times\nin"],
                      [[Item alloc] initWithTimeToShow:ICRIED + 1.43 duration:0.5 messageType:MessageTypeString message:@"I've cried\na few times\nin our"],
                      [[Item alloc] initWithTimeToShow:ICRIED + 1.60 duration:2.0 messageType:MessageTypeString message:@"I've cried\na few times\nin our relationship."],
                      
                      [[Item alloc] initWithTimeToShow:CRYHAPPY + 0.00 duration:2.0 messageType:MessageTypeString message:@"I've\n"],
                      [[Item alloc] initWithTimeToShow:CRYHAPPY + 0.10 duration:2.0 messageType:MessageTypeString message:@"I've cried\n"],
                      [[Item alloc] initWithTimeToShow:CRYHAPPY + 1.00 duration:2.0 messageType:MessageTypeString message:@"I've cried\nfrom"],
                      [[Item alloc] initWithTimeToShow:CRYHAPPY + 1.15 duration:2.0 messageType:MessageTypeString message:@"I've cried\nfrom happiness."],
                      
                      [[Item alloc] initWithTimeToShow:CRYSAD + 0.00 duration:2.0 messageType:MessageTypeString message:@"and\n"],
                      [[Item alloc] initWithTimeToShow:CRYSAD + 0.10 duration:2.0 messageType:MessageTypeString message:@"and I've\n"],
                      [[Item alloc] initWithTimeToShow:CRYSAD + 0.30 duration:2.0 messageType:MessageTypeString message:@"and I've cried\n"],
                      [[Item alloc] initWithTimeToShow:CRYSAD + 1.00 duration:2.0 messageType:MessageTypeString message:@"and I've cried\nfrom"],
                      [[Item alloc] initWithTimeToShow:CRYSAD + 1.15 duration:2.0 messageType:MessageTypeString message:@"and I've cried\nfrom sadness."],
                      
                      [[Item alloc] initWithTimeToShow:BUTTODAY + 0.00 duration:0.8 messageType:MessageTypeString message:@"But"],
                      [[Item alloc] initWithTimeToShow:BUTTODAY + 0.10 duration:2.0 messageType:MessageTypeString message:@"But today,"],
                      
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:120. messageType:MessageTypeSong  message:@"CuzILoveYou"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.50 duration:2.0 messageType:MessageTypeString message:@"I'm\n"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 1.16 duration:2.0 messageType:MessageTypeString message:@"I'm cryin\n"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 2.33 duration:2.0 messageType:MessageTypeString message:@"I'm cryin\n'cause"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 3.00 duration:2.0 messageType:MessageTypeString message:@"I'm cryin\n'cause I"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 3.30 duration:2.0 messageType:MessageTypeString message:@"I'm cryin\n'cause I love"],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 4.60 duration:3.0 messageType:MessageTypeString message:@"I'm cryin\n'cause I love you."],
                      
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 6.23 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 7.33 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 7.73 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 8.06 duration:8.0 messageType:MessageTypeCircle message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 8.36 duration:8.0 messageType:MessageTypeCircle message:nil],
                      
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 6.23 duration:8.0 messageType:MessageTypeHeavyBuzz message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 7.33 duration:8.0 messageType:MessageTypeHeavyBuzz message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 7.73 duration:8.0 messageType:MessageTypeHeavyBuzz message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 8.06 duration:8.0 messageType:MessageTypeHeavyBuzz message:nil],
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 8.36 duration:8.0 messageType:MessageTypeHeavyBuzz message:nil],
                      
                      [[Item alloc] initWithTimeToShow:WEARENOW + 0.00 duration:1.0 messageType:MessageTypeString message:@"We are now\n"],
                      [[Item alloc] initWithTimeToShow:WEARENOW + 1.00 duration:2.0 messageType:MessageTypeString message:@"We are now\none year in."],

                      [[Item alloc] initWithTimeToShow:HIGHUPS + 0.00 duration:3.0 messageType:MessageTypeString message:@"It has had\n"],
                      [[Item alloc] initWithTimeToShow:HIGHUPS + 1.00 duration:3.0 messageType:MessageTypeString message:@"It has had\nits high ups,"],

                      [[Item alloc] initWithTimeToShow:LOWLOWS + 0.00 duration:3.0 messageType:MessageTypeString message:@"and it had its\n"],
                      [[Item alloc] initWithTimeToShow:LOWLOWS + 1.00 duration:3.0 messageType:MessageTypeString message:@"and it had its\nlow lows."],

                      [[Item alloc] initWithTimeToShow:JOYORSORROW + 0.00 duration:3.0 messageType:MessageTypeString message:@"But\n"],
                      [[Item alloc] initWithTimeToShow:JOYORSORROW + 0.00 duration:3.0 messageType:MessageTypeString message:@"But whether\n"],
                      [[Item alloc] initWithTimeToShow:JOYORSORROW + 0.00 duration:3.0 messageType:MessageTypeString message:@"But whether in\n"],
                      [[Item alloc] initWithTimeToShow:JOYORSORROW + 0.00 duration:3.0 messageType:MessageTypeString message:@"But whether in\njoy"],
                      [[Item alloc] initWithTimeToShow:JOYORSORROW + 0.00 duration:3.0 messageType:MessageTypeString message:@"But whether in\njoy or"],
                      [[Item alloc] initWithTimeToShow:JOYORSORROW + 0.00 duration:3.0 messageType:MessageTypeString message:@"But whether in\njoy or in"],
                      [[Item alloc] initWithTimeToShow:JOYORSORROW + 0.00 duration:3.0 messageType:MessageTypeString message:@"But whether in\njoy or in sorrow,"],

                      [[Item alloc] initWithTimeToShow:SHOULDER + 0.00 duration:3.0 messageType:MessageTypeString message:@"I've had a shoulder\n"],
                      [[Item alloc] initWithTimeToShow:SHOULDER + 0.00 duration:3.0 messageType:MessageTypeString message:@"I've had a shoulder to cry on,"],

                      [[Item alloc] initWithTimeToShow:YOUTOO1 + 0.00 duration:3.0 messageType:MessageTypeString message:@"And I hope you've had one too."],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"In need or in love, I've had a hand to hold,"],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"And I hope you had one too."],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"We've talked about our days,"],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"And we've talked about our problems."],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"We've been busy,"],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"we've been free."],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"We've seen the world change,"],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"And we've seen each other grow."],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"We're just getting started,"],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"But baby, with you,"],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"It doesn't matter where the journey takes us,"],
//
//                      [[Item alloc] initWithTimeToShow:SONGINTRO + 0.00 duration:3.0 messageType:MessageTypeString message:@"As long as I'm there with you."],
//
                      [[Item alloc] initWithTimeToShow:SONGINTRO + 120.00 duration:3.0 messageType:MessageTypeString message:@"Here's to a hundred more years together."],
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
    NSLog(@"Resume after %.3f pause", self.accumulatedPauseTime);
}

- (void)tick:(CADisplayLink *)displayLink {
    double currentTime = CACurrentMediaTime() + 4.6 - self.startTime - self.accumulatedPauseTime;
    
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
