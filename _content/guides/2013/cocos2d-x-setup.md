# Cocos2d-x-2.2.0 Setup Guide (for Android and iOS)

- date: 2013-11-27 9:00
- tags: linux, game, mobile
- category: guides

----------------------------

This guide describes the steps to setup a development environment for Cocos2d-x the cross-platform game development framework, on Linux and Mac OSX.


## 1. Download packages

In this guide, we'll use cocos2d-x-2.x as example, and we'll setup for Android and iOS app development. So, the following packages will be needed:

    Cocos2d-x(latest of v2.x): http://www.cocos2d-x.org/download
    Android Development Tools(ADT bundle): http://developer.android.com/sdk/index.html
    Android NDK(legacy-toolchains package is not neccessary): http://developer.android.com/tools/sdk/ndk/index.html

Unzip the three packages to a folder. For example, after I extract the files, the paths looks like:

    ~/develop/android/adt-bundle-linux-x86-20131030/eclipse
    ~/develop/android/adt-bundle-linux-x86-20131030/sdk
    ~/develop/android/adt-bundle-linux-x86-20131030/android-ndk-r9b
    ~/develop/cocos2dx/cocos2d-x-2.2.0/

Next go to Eclipe(for Android) or Xcode(for iOS) for next step.

## 2. Android Setup

Check device accessible
------------------

You better make sure you can access your android tablet before building it on the device. The method to check is a "adb devices" command(don't forget to turn on the debug mode on the tablet first):

    $ cd $ANDROID_SDK_HOME/platform-tools
    $ ./adb devices
    * daemon not running. starting it now on port 5037 *
    * daemon started successfully *
    List of devices attached 
    ????????????	no permissions
    
If you see the device listed without a valid name, and marked with "no permissions", the reason is often that you started ADB Server not as root. Try to fix that is to restart the adb daemon in root access:

    # be sure to close ADT first, because sometimes it make adb started in user even with sudo
    $ sudo ./adb kill-server
    $ sudo ./adb start-server
    # check adb server running user
    $ ps -ef | grep adb
    root     15657     1  0 09:59 pts/0    00:00:00 adb -P 5037 fork-server server
    # check device list
    $ ./adb devices
    List of devices attached 
    20080411	device
    # try if you can connect to the device and run with shell
    $ ./adb shell

If all successful, open Eclipse IDE and we'll build the project.

Importing The Library and The Projects
--------------------

We'll import twice: one for the **cocos2d-x library**, one for the **sample projects**.

![alt](/images/2013/cocos_import.png "Import existing projects")


The search path for cocos2d-x library is "***$COCOS2DX_ROOT/cocos2dx***"

![alt](/images/2013/cocos_import_lib.png "Import cocos2d-x lib")

The search path for sample projects is "***$COCOS2DX_ROOT/samples/Cpp/***"(because we're going to use C++ for cocos2d-x development).

![alt](/images/2013/cocos_import_tests.png "Import sample projects")

After that we'll see the projects in the workspace:

![alt](/images/2013/cocos_import_success.png "Imported projects")


Setting Environment Variables
--------------------







