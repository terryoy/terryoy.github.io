# Put Linux into Old PC - (2) Desktop Environment

- date: 2016-05-18 9:47
- tags: linux, study
- categories: guides 
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

If you see an error says cannot get access to ~/.Xauthority, it's possibly you ran it in root user. It doesn't need to be root user, and you should chown the file to yourself.

Next we try to do more about the customization.

#### 2.2 Openbox Configuration (menu.xml and rc.xml)

Openbox has two main configuration files:

	* rc.xml, which sets keybindings, desktop names and window behavior
	* menu.xml, which contains the instructions for the right-click menu.


Reference: [https://urukrama.wordpress.com/openbox-guide/](https://urukrama.wordpress.com/openbox-guide/)


#### 2.3 A simple web browser that do the trick

After searching the apt-cache library for web browser, I discover there is a simple browser called ```surf```, which uses WebKit/Gtk to render. I think this tool is well enough for browsing modern web sites, and also friendly to command line. So I pick it for the initial choice of a browser for me to search information online on this computer.

```bash
$ sudo apt-get install surf
```
**Surf** has no tab support, no menu no any distractions. If you want to navigate to urls, hit **Ctrl-g** to enter a new URL.

Reference for "surf": [http://surf.suckless.org/](http://surf.suckless.org/)

Next I also give a try to Chromium, the open source version of Chrome. It seems this more sophisticated version of webkit browser also works fine under linux. The performance on loading static web site is quick. So I decided to use Chromium as my default currently.

But now we have a problem here, what if I want to change the default browser in OpenBox? Debian provides a program call **update-alternatives** so that you could set default program for specific purpose.

```bash
# list current default program settings
$ update-alternatives --get-selections

# update a default program
$ sudo update-alternatives --config x-www-browser

```

It will prompt you an option list of possible programs, so that you can easily decide which program to use.


