#import "PSSpecifier.h"
#import "PSViewController.h"

@interface PSListController : PSViewController {
    UITableView* _table;
	NSMutableDictionary* _cells;
	BOOL _cachesCells;
	NSArray* _specifiers;
	NSMutableArray* _controllers;
	NSMutableDictionary* _specifiersByID;
	BOOL _keyboardWasVisible;
	BOOL _showingSetupController;
	BOOL _selectingRow;
	NSString* _specifierID;
	PSSpecifier* _specifier;
	NSMutableArray* _groups;
	NSMutableArray* _bundleControllers;
	BOOL _bundlesLoaded;
	CGRect _cellRect;
}
@property(retain) NSArray* specifiers;
@property(retain) NSString* specifierID;
@property(readonly, retain) PSSpecifier* specifier;

// iOS 7
- (UITableView *)table;

+(BOOL)displaysButtonBar;
-(id)readPreferenceValue:(PSSpecifier *)specifier;
-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier;
-(void)setCachesCells:(BOOL)cachesCells;
// inherited: -(id)description;
-(NSBundle*)bundle;
-(NSMutableArray *)loadSpecifiersFromPlistName:(NSString*)plistName target:(id)target;
//-(void)_addIdentifierForSpecifier:(id)specifier;
//-(void)_removeIdentifierForSpecifier:(id)specifier;
//-(void)_setSpecifiers:(id)specifiers;
-(void)reloadSpecifierAtIndex:(int)index animated:(BOOL)animated;
-(void)reloadSpecifierAtIndex:(int)index;
-(void)reloadSpecifier:(PSSpecifier*)specifier animated:(BOOL)animated;
-(void)reloadSpecifier:(PSSpecifier*)specifier;
-(void)reloadSpecifierID:(NSString*)specifierID animated:(BOOL)animated;
-(void)reloadSpecifierID:(NSString*)specifierID;
-(int)indexOfSpecifierID:(NSString*)specifierID;
-(int)indexOfSpecifier:(NSString*)specifier;
-(BOOL)containsSpecifier:(NSString*)specifier;
-(int)indexOfGroup:(int)group;
-(int)numberOfGroups;
-(PSSpecifier*)specifierAtIndex:(int)index;
-(BOOL)getGroup:(int*)group row:(int*)row ofSpecifierID:(NSString*)specifierID;
-(BOOL)getGroup:(int*)group row:(int*)row ofSpecifier:(PSSpecifier*)specifier;
//-(BOOL)_getGroup:(int*)group row:(int*)row ofSpecifierAtIndex:(int)index groups:(id)groups;
-(BOOL)getGroup:(int*)group row:(int*)row ofSpecifierAtIndex:(int)index;
-(int)rowsForGroup:(int)group;
-(NSArray*)specifiersInGroup:(int)group;
-(void)insertSpecifier:(PSSpecifier*)specifier atIndex:(int)index animated:(BOOL)animated;
-(void)insertSpecifier:(PSSpecifier*)specifier afterSpecifier:(PSSpecifier*)specifier2 animated:(BOOL)animated;
-(void)insertSpecifier:(PSSpecifier*)specifier afterSpecifierID:(NSString*)specifierID animated:(BOOL)animated;
-(void)insertSpecifier:(PSSpecifier*)specifier atEndOfGroup:(int)group animated:(BOOL)animated;
-(void)insertSpecifier:(PSSpecifier*)specifier atIndex:(int)index;
-(void)insertSpecifier:(PSSpecifier*)specifier afterSpecifier:(PSSpecifier*)specifier2;
-(void)insertSpecifier:(PSSpecifier*)specifier afterSpecifierID:(NSString*)specifierID;
-(void)insertSpecifier:(PSSpecifier*)specifier atEndOfGroup:(int)group;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers atIndex:(int)index animated:(BOOL)animated;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers afterSpecifier:(PSSpecifier*)specifier animated:(BOOL)animated;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers afterSpecifierID:(NSString*)specifierID animated:(BOOL)animated;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers atEndOfGroup:(int)group animated:(BOOL)animated;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers atIndex:(int)index;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers afterSpecifier:(PSSpecifier*)specifier;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers afterSpecifierID:(NSString*)specifierID;
-(void)insertContiguousSpecifiers:(NSArray*)specifiers atEndOfGroup:(int)group;
-(void)addSpecifier:(PSSpecifier*)specifier;
-(void)addSpecifier:(PSSpecifier*)specifier animated:(BOOL)animated;
-(void)addSpecifiersFromArray:(NSArray*)array;
-(void)addSpecifiersFromArray:(NSArray*)array animated:(BOOL)animated;
-(void)removeSpecifier:(PSSpecifier*)specifier animated:(BOOL)animated;
-(void)removeSpecifierID:(NSString*)specifierID animated:(BOOL)animated;
-(void)removeSpecifierAtIndex:(int)index animated:(BOOL)animated;
-(void)removeSpecifier:(PSSpecifier*)specifier;
-(void)removeSpecifierID:(NSString*)specifierID;
-(void)removeSpecifierAtIndex:(int)index;
-(void)removeLastSpecifier;
-(void)removeLastSpecifierAnimated:(BOOL)animated;
//-(BOOL)_canRemoveSpecifiers:(id)specifiers;
-(void)removeContiguousSpecifiers:(NSArray*)specifiers animated:(BOOL)animated;
-(void)removeContiguousSpecifiers:(NSArray*)specifiers;
-(void)replaceContiguousSpecifiers:(NSArray*)specifiers withSpecifiers:(NSArray*)specifiers2;
-(void)replaceContiguousSpecifiers:(NSArray*)specifiers withSpecifiers:(NSArray*)specifiers2 animated:(BOOL)animated;
//-(void)_loadBundleControllers;
//-(void)_unloadBundleControllers;
// inherited: -(void)suspend;
// inherited: -(void)dealloc;
// inherited: -(id)initForContentSize:(CGSize)contentSize;
// inherited: -(id)navigationTitle;
//-(id)_createGroupIndices:(id)indices;
//-(void)createGroupIndices;
//-(void)loseFocus;
-(void)reload;
-(void)reloadSpecifiers;
// inherited: -(void)viewDidBecomeVisible;
// inherited: -(void)viewWillRedisplay;
-(int)numberOfGroupsInPreferencesTable:(id)preferencesTable;
-(BOOL)preferencesTable:(id)table isLabelGroup:(int)group;
-(int)preferencesTable:(id)table numberOfRowsInGroup:(int)group;
-(id)lastController;
-(id)cachedCellForSpecifier:(id)specifier;
-(id)cachedCellForSpecifierID:(id)specifierID;
-(id)table:(id)table cellForRow:(int)row column:(id)column;
-(float)preferencesTable:(id)table heightForRow:(int)row inGroup:(int)group withProposedHeight:(float)proposedHeight;
-(id)preferencesTable:(id)table titleForGroup:(int)group;
-(id)preferencesTable:(id)table cellForGroup:(int)group;
-(id)preferencesTable:(id)table cellForRow:(int)row inGroup:(int)group;
// inherited: -(void)viewWillBecomeVisible:(void*)view;
-(void)_unselectTable;
-(void)selectRowWithoutNotification:(int)notification;
//-(void)showConfirmationSheetForSpecifier:(id)specifier;
//-(BOOL)performActionForSpecifier:(id)specifier;
//-(void)tableSelectionDidChange:(id)tableSelection;
//-(void)alertSheet:(id)sheet buttonClicked:(int)clicked;
//-(void)_insertControllerUnderSetupController:(id)controller;
-(PSSpecifier*)specifierForID:(NSString*)specifierID;
-(void)pushController:(id)controller animate:(BOOL)animate;
// inherited: -(void)pushController:(id)controller;
// inherited: -(void)handleURL:(id)url;
//-(void)_showKeyboard;
-(void)transitionViewDidComplete:(id)transitionView;
// inherited: -(id)view;
// inherited: -(BOOL)popController;
-(void)_clearParentControllerFromChildren;
-(void)_removeController;
// inherited: -(BOOL)popControllerWithAnimation:(BOOL)animation;
// inherited: -(void)navigationBarButtonClicked:(int)clicked;
-(void)reloadIconForSpecifierForBundle:(id)bundle;
-(void)showKeyboardWithKeyboardType:(int)keyboardType;
-(void)selectRowForSpecifier:(id)specifier;

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;

-(void)beginUpdates;
-(void)endUpdates;

- (void)updateSpecifiers:(id)arg1 withSpecifiers:(id)arg2;


- (int)numberOfSectionsInTableView:(id)arg1;

@end
