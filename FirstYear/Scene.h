/**
 * This file is generated using the remodel generation script.
 * The name of the input file is Scene.value
 */

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "Item.h"

@interface Scene : NSObject <NSCopying>

@property (nonatomic, readonly) SceneName sceneName;
@property (nonatomic, readonly, copy) NSArray<Item *> *items;
@property (nonatomic, readonly, copy) Item *activeItem;
@property (nonatomic, readonly) double currentTime;

- (instancetype)initWithSceneName:(SceneName)sceneName items:(NSArray<Item *> *)items activeItem:(Item *)activeItem currentTime:(double)currentTime;

@end

