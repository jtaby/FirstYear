/**
 * This file is generated using the remodel generation script.
 * The name of the input file is T.value
 */

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface T : NSObject <NSCopying>

@property (nonatomic, readonly) double showAt;
@property (nonatomic, readonly) double duration;
@property (nonatomic, readonly) MessageType messageType;
@property (nonatomic, readonly, copy) NSString *message;

+ (instancetype)time:(double)showAt message:(NSString *)message;
+ (instancetype)time:(double)showAt duration:(double)duration movie:(NSString *)name;
+ (instancetype)time:(double)showAt duration:(double)duration image:(NSString *)name;
+ (instancetype)time:(double)showAt duration:(double)duration message:(NSString *)message;

+ (instancetype)circleAtTime:(double)showAt;
+ (instancetype)buzzAtTime:(double)showAt;
+ (instancetype)songAtTime:(double)showAt name:(NSString *)name;
+ (instancetype)gap:(double)showAt;

- (instancetype)initWithShowAt:(double)showAt duration:(double)duration messageType:(MessageType)messageType message:(NSString *)message;

@end

