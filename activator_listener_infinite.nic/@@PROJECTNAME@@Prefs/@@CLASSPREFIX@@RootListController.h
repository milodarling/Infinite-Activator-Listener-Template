#import "Preferences/PSListController.h"
#import "Preferences/PSEditableListController.h"
#import "Preferences/PSSpecifier.h"
#import "Preferences/PSTableCellType.h"
#import <Cephei/HBPreferences.h>
#import <objc/runtime.h>

extern NSString* PSDeletionActionKey;

@interface @@CLASSPREFIX@@RootListController : PSEditableListController <UITableViewDataSource> {
	HBPreferences *prefs;
}

@end
