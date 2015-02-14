#include "@@CLASSPREFIX@@RootListController.h"

@implementation @@CLASSPREFIX@@RootListController

-(instancetype)init {
	if (self = [super init]) {
		prefs = [[HBPreferences alloc] initWithIdentifier:@"@@PACKAGENAME@@"];
	}
	return self;
}

- (NSArray *)specifiers {
	if (!_specifiers) {

		NSMutableArray *specifiers = [NSMutableArray new];
		PSSpecifier *spec;
		spec = [PSSpecifier groupSpecifierWithName:@"@@PROJECTNAME@@ First Page"];
		[specifiers addObject:spec];

        int count = [prefs integerForKey:@"listenerCount" default:1];
        for (int i=1; i<=count; i++) {
            spec = [PSSpecifier preferenceSpecifierNamed:[NSString stringWithFormat:@"Listener %d", i]
                                                  target:self
                                                     set:NULL
                                                     get:NULL
                                                  detail:objc_getClass("@@CLASSPREFIX@@ListenerListController")
                                                    cell:PSLinkCell
                                                    edit:Nil];
            [spec setProperty:@(i) forKey:@"listenerNumber"];
            //tint?
            //[spec setProperty:NSClassFromString(@"@@CLASSPREFIX@@TintedCell") forKey:@"cellClass"];
            [spec setProperty:NSStringFromSelector(@selector(removedSpecifier:)) forKey:PSDeletionActionKey];
            [specifiers addObject:spec];
        }

        spec = [PSSpecifier preferenceSpecifierNamed:@"Add listener..."
                                              target:self
                                                 set:NULL
                                                 get:NULL
                                              detail:Nil
                                                cell:PSButtonCell
                                                edit:Nil];
        spec->action = @selector(newListener);
        //tint?
        //[spec setProperty:NSClassFromString(@"@@CLASSPREFIX@@TintedCell") forKey:@"cellClass"];
        [specifiers addObject:spec];

		_specifiers = [specifiers copy];
	}

	return _specifiers;
}

-(void)newListener {
    int count = [prefs integerForKey:@"listenerCount" default:1];
    count++;
    PSSpecifier *spec = [PSSpecifier preferenceSpecifierNamed:[NSString stringWithFormat:@"Listener %d", count]
                                                  target:self
                                                     set:NULL
                                                     get:NULL
                                                  detail:objc_getClass("@@CLASSPREFIX@@ListenerListController")
                                                    cell:PSLinkCell
                                                    edit:Nil];
    [spec setProperty:@(count) forKey:@"listenerNumber"];
    //tint?
    //[spec setProperty:NSClassFromString(@"@@CLASSPREFIX@@TintedCell") forKey:@"cellClass"];
    [spec setProperty:NSStringFromSelector(@selector(removedSpecifier:)) forKey:PSDeletionActionKey];

    [prefs setInteger:count forKey:@"listenerCount"];

    [self insertSpecifier:spec atIndex:count animated:YES];

    [prefs synchronize];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("@@PACKAGENAME@@/updateListeners"), NULL, NULL, YES);
    //[self reloadSpecifiers];
}

-(void)removedSpecifier:(PSSpecifier *)specifier {
    int count = [prefs integerForKey:@"listenerCount" default:1];

    int index = [specifier.properties[@"subNumber"] intValue];
    for (int i=index; i<=count; i++) {

    	//preference shuffling. Add all of your keys here
        NSArray *keys = @[ @"-enabled" ];
        for (NSString *key in keys) {
            NSString *currentKey = [NSString stringWithFormat:@"listener%d%@", i+1, key];
            NSString *newKey = [NSString stringWithFormat:@"listener%d%@", i, key];
            id object = [prefs objectForKey:currentKey];
            [prefs setObject:object forKey:newKey];
        }
    }
    count--;
    [prefs setInteger:count forKey:@"listenerCount"];
    [prefs synchronize];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("@@PACKAGENAME@@/updateListeners"), NULL, NULL, YES);

    [self performSelector:@selector(reloadSpecifiers) withObject:nil afterDelay:0.3f];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"More"]) {
        return NO;
    }
    return YES;
}

@end
