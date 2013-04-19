#import "CalloutMapAnnotation.h"

@interface CalloutMapAnnotation()


@end

@implementation CalloutMapAnnotation

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;


- (id)initWithLatitude:(CLLocationDegrees)latitude
andLongitude:(CLLocationDegrees)longitude title:(NSString *)title subTitle:(NSString *)subtitle{
	if (self = [super init]) {
		self.latitude = latitude;
		self.longitude = longitude;
        _title=title;
        _subtitle=subtitle;
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
}

@end
