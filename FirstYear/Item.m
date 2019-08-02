/**
 * This file is generated using the remodel generation script.
 * The name of the input file is Item.value
 */

#if  ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "Item.h"

static BOOL CompareDoubles(double givenDouble, double doubleToCompare) {
  return fabs(givenDouble - doubleToCompare) < DBL_EPSILON * fabs(givenDouble + doubleToCompare) || fabs(givenDouble - doubleToCompare) < DBL_MIN;
}

static NSUInteger HashDouble(double givenDouble) {
  union {
    double key;
    uint64_t bits;
  } u;
  u.key = givenDouble;
  NSUInteger p = u.bits;
  p = (~p) + (p << 18);
  p ^= (p >> 31);
  p *=  21;
  p ^= (p >> 11);
  p += (p << 6);
  p ^= (p >> 22);
  return (NSUInteger) p;
}

@implementation Item

- (instancetype)initWithTimeToShow:(double)timeToShow duration:(double)duration messageType:(MessageType)messageType message:(NSString *)message
{
  if ((self = [super init])) {
    _timeToShow = timeToShow;
    _duration = duration;
    _messageType = messageType;
    _message = [message copy];
  }

  return self;
}

- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ - \n\t timeToShow: %lf; \n\t duration: %lf; \n\t messageType: %tu; \n\t message: %@; \n", [super description], _timeToShow, _duration, _messageType, _message];
}

- (NSUInteger)hash
{
  NSUInteger subhashes[] = {HashDouble(_timeToShow), HashDouble(_duration), _messageType, [_message hash]};
  NSUInteger result = subhashes[0];
  for (int ii = 1; ii < 4; ++ii) {
    unsigned long long base = (((unsigned long long)result) << 32 | subhashes[ii]);
    base = (~base) + (base << 18);
    base ^= (base >> 31);
    base *=  21;
    base ^= (base >> 11);
    base += (base << 6);
    base ^= (base >> 22);
    result = base;
  }
  return result;
}

- (BOOL)isEqual:(Item *)object
{
  if (self == object) {
    return YES;
  } else if (self == nil || object == nil || ![object isKindOfClass:[self class]]) {
    return NO;
  }
  return
    _messageType == object->_messageType &&
    CompareDoubles(_timeToShow, object->_timeToShow) &&
    CompareDoubles(_duration, object->_duration) &&
    (_message == object->_message ? YES : [_message isEqual:object->_message]);
}

@end

