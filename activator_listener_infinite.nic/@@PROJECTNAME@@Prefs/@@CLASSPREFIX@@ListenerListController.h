#import "Preferences/PSListController.h"
#import "Preferences/PSSpecifier.h"
#import "Preferences/PSTableCellType.h"
#import <Cephei/HBPreferences.h>
#import <objc/runtime.h>

@interface @@CLASSPREFIX@@ListenerListController : PSListController {
	HBPreferences *prefs;
	int listenerNumber;
}

@end
