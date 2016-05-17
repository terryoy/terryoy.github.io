# Linux Study Journal - (2) Desktop Environment

- date: 2016-05-15 21:04
- tags: linux, study
- categories: linux-study-journal
-----------------------------

### Part 2. Setup a minimal desktop environment

#### 2.1 Xorg and Openbox

To use a desktop environment, **Xorg** is the package you won't miss(for more information you can also check the [x.org](htts://www.x.org/) and [freedesktop.org](https://www.freedesktop.org/) web-sites. I choose **Openbox** as the window manager, which is one of the most lightweight window manager. It is the best showcase of minimalism, yet the functions shall be simple enough for customization. The window manager is not a desktop environment, it is just simply a manager to windows, their styles and behaviors. A complete desktop environment is not necessary, or maybe it's the chance that I could design my own.

```bash
$ sudo apt-get install xorg
# now you can enter the GUI environment by command "startx", but you still need a window manager to do further things
$ sudo apt-get install openbox obconf openbox-themes
# the above packages and their dependencies will allow you to build and configure an Openbox system, along with choices of themes.
```
What's interesting about "startx" is that, if you try it after you install xorg and before any Window Manager, you'll get a graphical shell environment with mouse available. The font is definitly different from what you had in the normal console. It is I think the essential GUI environment possible. And if you press Ctrl+D to exit the session, you get back to your original console environment, so the **xorg-session** is exited.

After installing the openbox package, it's not yet completed. You also need to add the a ```~/.xinitrc``` configuration so that it calls the openbox when you execute "startx".

```bash
$ echo "exec openbox-session" > ~/.xinitrc
$ startx
```

Now you can see GUI environment by Openbox. Right click on the desktop and you get a start menu, you can start a terminal emulator or configure the openbox using *Obconf*.

Next we try to do more about the customization.

#### 2.2 Openbox Configuration (menu.xml and rc.xml)

Openbox has two main configuration files:

	* rc.xml, which sets keybindings, desktop names and window behavior
	* menu.xml, which contains the instructions for the right-click menu.




