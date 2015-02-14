#import <libactivator/libactivator.h>
#import <Cephei/HBPreferences.h>

@interface @@CLASSPREFIX@@Listener : NSObject <LAListener> {
	HBPreferences *prefs;
    NSInteger listenerCount;
}
@end

static NSString *const bundleIdentifier = @"@@PACKAGENAME@@";
@@CLASSPREFIX@@Listener *listener;

static inline int @@CLASSPREFIX@@ListenerNubmer(NSString *listenerName) {
    int en;
    en = [[listenerName substringFromIndex:[bundleIdentifier length]] intValue];
    return en;
}

@implementation @@CLASSPREFIX@@Listener

-(id)init {
    if (self=[super init]) {
        listenerCount = 0;
        prefs = [[HBPreferences alloc] initWithIdentifier:bundleIdentifier];
    	[prefs registerDefaults:@{
        	@"listenerCount": @1,
    	}];
        [self updateListeners];
    }
    return self;
}
//trigger listener
-(void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
    int en = @@CLASSPREFIX@@ListenerNubmer(listenerName);
    NSLog(@"%d", en);
    //do stuff
}
//group
- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
    return @"@@FULLPROJECTNAME@@";
}
//title
- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
    int en = @@CLASSPREFIX@@ListenerNubmer(listenerName);
    NSLog(@"%d", en);
    return [NSString stringWithFormat:@"Listener %d", en];
}
//description
- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
    int en = @@CLASSPREFIX@@ListenerNubmer(listenerName);
    return [prefs objectForKey:[bundleIdentifier stringByAppendingFormat:@"%d-name", en]] ?: @"Description";
}
//compatibility with modes
- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
    return [NSArray arrayWithObjects:@"springboard", @"lockscreen", @"application", nil];
}
//duplicate assignment
- (NSArray *)activator:(LAActivator *)activator requiresExclusiveAssignmentGroupsForListenerName:(NSString *)listenerName {
    return [NSArray arrayWithObjects:nil]; //compatibility
}
//icon
- (NSData *)activator:(LAActivator *)activator requiresSmallIconDataForListenerName:(NSString *)listenerName scale:(CGFloat *)scale {
    //icon
    return nil;
}

-(void)updateListeners {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    if (listenerCount) {
        for (int i=1; i<=listenerCount; i++) {
            [[LAActivator sharedInstance] unregisterListenerWithName:[bundleIdentifier stringByAppendingFormat:@"%d", i]];
        }
    }
    [self loadPrefs]; //gets new count value
    for (int i=1; i<=listenerCount; i++) {
        [[LAActivator sharedInstance] registerListener:self forName:[bundleIdentifier stringByAppendingFormat:@"%d", i]];
    }
    [pool drain];
}

-(void)loadPrefs {
    listenerCount = [prefs integerForKey:@"listenerCount"];
}

@end

static void loadPreferences() {
    [listener loadPrefs];
}

static void updateListeners() {
    [listener updateListeners];
}

%ctor {
    listener = [[@@CLASSPREFIX@@Listener alloc] init];
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadPreferences,
                                    CFSTR("@@PACKAGENAME@@/prefsChanged"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)updateListeners,
                                    CFSTR("@@PACKAGENAME@@/updateListeners"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}