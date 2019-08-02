/**
 * This file is generated using the remodel generation script.
 * The name of the input file is Item.value
 */

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface Item : NSObject <NSCopying>

@property (nonatomic, readonly, copy) NSString *message;
@property (nonatomic, readonly) MessageType messageType;
@property (nonatomic, readonly) double timeToShow;
@property (nonatomic, readonly) double duration;
@property (nonatomic, readonly, copy) NSArray<UIColor *> *colors;

- (instancetype)initWithMessage:(NSString *)message messageType:(MessageType)messageType timeToShow:(double)timeToShow duration:(double)duration colors:(NSArray<UIColor *> *)colors;

@end

