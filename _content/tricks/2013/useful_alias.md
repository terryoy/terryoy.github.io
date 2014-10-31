# Useful Aliases and Commands in Linux

- date: 2013-09-23
- tags: linux, shell
- category: tricks

----------------------------

Below is a list of some useful aliases, which you could add to your linux shell environment.

Copy and paste below content to your __*~/.bashrc*__.

<!--script src="https://gist.github.com/terryoy/6374725.js"></script-->

```bash
# open a browser and view raw html (e.g. "cat some.html | viewhtml")
alias viewhtml='firefox "data:text/html;charset=utf-8;base64,$(base64 -w 0 <&0)"'
 
# url encode / decode
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
  
# url shortener
alias shortenurl="python -c \"import sys, urllib as ul; print ul.urlopen('http://tinyurl.com/api-create.php?url=%s' % ul.quote_plus(sys.argv[1])).readline()\""

```

### # work with hex

```bash
# if you want to dump a file in hex
$ xxd -p file

# A Hex number convertor, convert decimal into hex(e.g. "hex 34" -> 22)
alias hex='printf "%x\n"'
```

### # mount a virtualbox disk on linux

```bash
# before you can mount anything, install virtualbox-fuse
$ sudo apt-get install virtualbox-fuse

# there are 'disk/' folder and 'space/' folder.
# 'vdfuse -r' is for read only,
$ vdfuse -raf $1 disk
$ mount disk/Partition1 space

```

### Set keyboard repeat rate and delay

```bash
#Set keyboard repeat rate and delay
# where 220 is the delay(ms) and 40 is repeat rate(cps)

# under X
$ xset r rate 220 40
# under command line(or put it in /etc/rc.local, ~/.bashrc, ~/.bash_profile, etc.)
$ sudo kbdrate -r 40 -d 220

```


