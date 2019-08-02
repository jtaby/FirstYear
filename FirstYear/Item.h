/**
 * This file is generated using the remodel generation script.
 * The name of the input file is Item.value
 */

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface Item : NSObject <NSCopying>

@property (nonatomic, readonly) double timeToShow;
@property (nonatomic, readonly) double duration;
@property (nonatomic, readonly) MessageType messageType;
@property (nonatomic, readonly, copy) NSString *message;

- (instancetype)initWithTimeToShow:(double)timeToShow duration:(double)duration messageType:(MessageType)messageType message:(NSString *)message;

@end

