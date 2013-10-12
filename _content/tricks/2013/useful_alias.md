# Useful Aliases

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

