#import "@@CLASSPREFIX@@ListenerListController.h"

@implementation @@CLASSPREFIX@@ListenerListController

-(instancetype)init {
  if (self = [super init]) {
    prefs = [[HBPreferences alloc] initWithIdentifier:@"@@PACKAGENAME@@"];
  }
  return self;
}

-(void)setSpecifier:(PSSpecifier *)specifier {
    listenerNumber = [specifier.properties[@"listenerNumber"] intValue];
    [super setSpecifier:specifier];
    
}

-(id)specifiers {
    if (_specifiers == nil) {
        
        NSMutableArray *specifiers = [NSMutableArray new];
        PSSpecifier *spec;
        NSString *listenerPrefix = [NSString stringWithFormat:@"listener%d", listenerNumber];
        
        spec = [PSSpecifier preferenceSpecifierNamed:@"Enabled"
                                              target:self
                                                 set:@selector(setPreferenceValue:specifier:)
                                                 get:@selector(readPreferenceValue:)
                                              detail:Nil
                                                cell:PSSwitchCell
                                                edit:Nil];
        [spec setProperty:[NSString stringWithFormat:@"%@-enabled", listenerPrefix] forKey:@"key"];
        [spec setProperty:@YES forKey:@"default"];
        [spec setProperty:@"@@PACKAGENAME@@/prefsChanged" forKey:@"PostNotification"];
        [specifiers addObject:spec];
        
        [specifiers addObject:[PSSpecifier emptyGroupSpecifier]];
        
        spec = [PSSpecifier preferenceSpecifierNamed:@"Activation Method"
                                              target:self
                                                 set:NULL
                                                 get:NULL
                                              detail:Nil
                                                cell:PSLinkCell
                                                edit:Nil];
        [spec setProperty:@YES forKey:@"isContoller"];
        [spec setProperty:[NSString stringWithFormat:@"@@PACKAGENAME@@.%@", listenerPrefix] forKey:@"activatorListener"];
        [spec setProperty:@"/System/Library/PreferenceBundles/LibActivator.bundle" forKey:@"lazy-bundle"];
        spec->action = @selector(lazyLoadBundle:);
        [specifiers addObject:spec];

        
        _specifiers = [specifiers copy];
    }

    return _specifiers;
}

-(void)loadView {
    [super loadView];
    self.navigationItem.title = [NSString stringWithFormat:@"Listener %d", listenerNumber];
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
  [prefs setObject:value forKey:[specifier propertyForKey:@"key"]];
  [prefs synchronize];
  CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("@@PACKAGENAME@@/prefsChanged"), NULL, NULL, YES);
}

-(id)readPreferenceValue:(PSSpecifier *)specifier
{
    return [prefs objectForKey:[specifier propertyForKey:@"key"] default:[specifier propertyForKey:@"default"]];
}

@end