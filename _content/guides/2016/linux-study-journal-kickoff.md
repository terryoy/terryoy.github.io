# Linux Study Journal - (1) Kick Off

- date: 2016-05-15 21:04
- tags: linux, study
- categories: linux-study-journal
-----------------------------

### 0. How this series begin?

I have an used Japanese IBM G40 PC, which has Pentium 4 (2.5GHz) processor, 512MB RAM and a 140GB hard disk (I believe the hardware spec has been changed by the used PC seller). Since the power consumption and the speed are not suitable for very modern applications, I decided to use it as an experiment machine for the minimal linux workspace. This series of blog posts will be the progress showing how I work on this machine to make it very friendly and efficient for daily used.

### 1. System Setup

I started to boot with the Ubuntu 16.04 LTS server image(flashed on a USB stick), the booting is a bit strange than previous versions, it shows a "boot:" prompt which need you to tells what to boot, but it's not difficult to find out how to boot into the installation mode.

The reason using Ubuntu latest version is because I want to keep up with the development of the software packages, debian is in a very stable status, while the Ubuntu packages are active enough to try out new things. I format the whole disk and install Ubuntu only on the disk. This is the starting point.

#### 1.1 Problem 1: hibernation on lid close

I'm so exciting at the moment when I finish all the installation and reboot, because I finally get this project started! But the first problem come very quickly - **when I try to lower the lid, the screen just go dark, and when I reopen it, the going hibernate process sticks in every few seconds**. I think there is some problem with the led sensor, because it automatically goes into hibernate a few seconds later when I activate again. So I think it is related to the power options in system settings.

This problem leads me to know about the **"systemd"** program. Searching solutions on the internet, I find out the settings in systemd will handle the power related key event. It sets how system react when user press Power key, Hibernate Key, Lid close/open, etc.

```bash
$ sudo vi /etc/systemd/logind.conf
(
-change 
#HandleLidSwitch=suspend
-to
HandleLidSwitch=ignore
)

$ sudo service systemd-logind restart

```

This helps me to get over the hibernation problem at once. **Systemd** is a Linux system and service manager. There is similar programs like ubuntu's "upstart", or Mac OS's "launchd". You can search for more info about it.

There are two other power related packages ```acpi``` and ```acpid```. The Ubuntu document recommends that you can remove the packages if you do not have a laptop. 

#### 1.2 Problem 2: Japanese keyboard layout
 
Although I set some Japanese keyboard layout in the installation, but it doesn't match all the keys with my Japanese IBM G40 keyboard. Apparently I need to switch the keyboard layout and do a few tests. The configuration program I used here is ```dpkg-reconfigure```, which allows you to configure a package again after they're installed. The package will be "keyboard-configuration".

```bash
# choose a different keyboard mapping
$ sudo dpkg-reconfigure keyboard-configuration
```

The above one already solved the problem. I changed the keyboard model to IBM ThinkPad T60/R60/T61/R61, then it says the layout of this keyboard varies in different country, so I'm able to choose the "Japanese" as the country of the origin layout. 

Some threads mentioned about the ```console-setup``` as I found out it is mainly for the encoding and the font set in the console, it might be related to the problem but not at this point. I may referred back if I try to work with Chinese character in the console.

```bash
# This change some console character set options
$ sudo dpkg-reconfigure console-setup
```
A little more on dpkg-reconfigure, if you use ```man dpkg-recongure``` to check its manual, you will find another related command called ```debconf-show```. It shows you all the current configurations of the package. So before you go with "dpkg-reconfigure", you can check the configuration first.

```bash
$ sudo debconf-show keyboard-configuration
```
It shows how many configuration items of the package and their values. Check out the man page for "keyboard-configuration", "console-setup", "dpkg-reconfigure" and "debconf-show" to explore more.

### 2. Setup a minimal desktop environment






