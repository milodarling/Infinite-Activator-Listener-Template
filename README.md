# Infinite-Activator-Listener-Template
An NIC template for Activator plugins that allows for infinite listeners!

To use this template, you'll need to get [Cephei](https://hbang.github.io/libcephei/) headers and [Activator headers](https://github.com/rpetrich/libactivator).

**NOTE:** This template using HBPreferences to manage preferences. To use HBPreferences, you'll need to set up [Cephei](https://hbang.github.io/libcephei/).

This template basically uses preferences to keep track of the number of listeners that the user wants. All of the preferences for each listener are set with the keys being "listener<number>-<key>". For example, the name of the first listener would have the key "listener1-name", so you can easilsy load preferences based on which listener is called using the function in the main tweak file and `[NSString stringWithFormat:@"listener%d-preference"];` and then act accordingly.

To build this, run `$THEOS/bin/nicify.pl /path/to/activator_listener_infinite.nic` or you can use my pre-compiled version.