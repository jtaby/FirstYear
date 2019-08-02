/**
 * This file is generated using the remodel generation script.
 * The name of the input file is Scene.value
 */

#if  ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "Scene.h"

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

@implementation Scene

- (instancetype)initWithSceneName:(SceneName)sceneName items:(NSArray<Item *> *)items activeItems:(NSArray<Item *> *)activeItems currentTime:(double)currentTime
{
  if ((self = [super init])) {
    _sceneName = sceneName;
    _items = [items copy];
    _activeItems = [activeItems copy];
    _currentTime = currentTime;
  }

  return self;
}

- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ - \n\t sceneName: %tu; \n\t items: %@; \n\t activeItems: %@; \n\t currentTime: %lf; \n", [super description], _sceneName, _items, _activeItems, _currentTime];
}

- (NSUInteger)hash
{
  NSUInteger subhashes[] = {_sceneName, [_items hash], [_activeItems hash], HashDouble(_currentTime)};
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

- (BOOL)isEqual:(Scene *)object
{
  if (self == object) {
    return YES;
  } else if (self == nil || object == nil || ![object isKindOfClass:[self class]]) {
    return NO;
  }
  return
    _sceneName == object->_sceneName &&
    CompareDoubles(_currentTime, object->_currentTime) &&
    (_items == object->_items ? YES : [_items isEqual:object->_items]) &&
    (_activeItems == object->_activeItems ? YES : [_activeItems isEqual:object->_activeItems]);
}

@end

