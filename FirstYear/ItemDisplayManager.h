//
//  ItemDisplayManager.h
//  FirstYear
//
//  Created by Majd Taby on 8/2/19.
//  Copyright © 2019 Majd Taby. All rights reserved.
//

#import "Item.h"
#import "Scene.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ItemDisplayManagerDelegate <NSObject>

- (void)showItems:(NSArray<Item *> *)items;
- (void)sceneDidFinish:(Scene *)scene;

@end

@interface ItemDisplayManager : NSObject

@property (nonatomic, weak) id<ItemDisplayManagerDelegate>delegate;

- (instancetype)initWithSceneName:(SceneName)sceneName;
- (void)start;
- (void)pause;
- (void)resume;

@end

NS_ASSUME_NONNULL_END
