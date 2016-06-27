# A Guide of Common Git Tasks

- date: 2014-10-22 20:57
- tags: linux, programming
- category: guides
------------------------------

### 1. Initialize a Git project

Usually, starting a git project include's the following steps:

 * initialize local repository
 * add a remote repository from server
 * set up-stream and push to remote repository

```bash
# initialize a repository
$ git init

# set a new remote
$ git remote add origin https://github.com/user/repo.git

# verify new remote
$ git remote -v

# (you might need to pull origin/master first if it's not empty)
$ git pull origin master

# push to remote repository
$ git push --set-upstream origin master

```


### 2. Correct mistakes on the repository

Usually there are some mistakes we will commit to git repository, so here are a few tips to correct the mistakes:

 * Change file name/path
 * Unstage files
 * Remove sensitive data, or binary data in the history 

```bash

# change or delete files in the current version
# -- you should not simple use the common shell command "mv" and "rm", 
# -- because that will lose the tracking. You should use with git instead
$ git rm <somefile>
$ git mv <somefile> <otherfile>


# Unstage files
# -- usually when you execute "git status", it will prompt you how to unstage files (e.g. '(use "git reset HEAD <file>..." to unstage)')
$ git reset HEAD <file>...
# -- (or, in some cases)
$ git rm --cached <file>

# Remove sensitive data
# -- This one is more difficult. 
# check this link: https://help.github.com/articles/remove-sensitive-data/

```

### 3. Using Proxy to work with server

You can use openssh to create an ssh tunnel with a remote server, and then communicate with git server with this tunnel proxy.

```bash

# Socks
ssh -D <local_proxy_port> <remote_user>@<remote_server> -p <remote_ssh_port>
# HTTPS for one site:
ssh -L <local_proxy_port>:<destination_host>:<destination_port> <ssh_user>@<ssh_server> -p <ssh_port>

```

Using git with proxies:

```bash

# proxy for https
export https_proxy=<http_proxy_host>:<http_proxy_port>
# socks4 proxy for http
export http_proxy=socks://<socks4_proxy_host>:<socks4_proxy_port>
# socks5 proxy for https
export https_proxy=socks5://<socks5_proxy_host>:<socks5_proxy_port>

```

\* If in some blocked environment that can only access HTTP/HTTPS, you can consider changing your ssh service port to 80/443.

### 4. Create a private Git repo on your SSH server

(reference: http://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server)

```bash

# create a git user for remote access(optional)
$ sudo adduser git
$ cd /home/git/ && mkdir .ssh && chmod 700 .ssh
$ touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
$ cat /tmp/id_rsa.someone.pub >> .ssh/authorized_keys

# create a server repo with 
$ mkdir -p /opt/git/somerepo.git
$ cd /opt/git/somerepo.git
$ git init --bare

# create a local git repo(on your PC) and push to server repo
$ cd myproject
$ git init
$ git add . && git commit -m "initial commit"
$ git remote add origin git@gitserver:/opt/git/somerepo.git
$ git push origin master

```

### 5. Tagging

```bash
# list your tags
$ git tag
# search for tags
$ git tag -l "v1.8.*"

# create a tag with annotation
$ git tag -a v1.0.1 -m "a new tag for v1.0.1"
# create a tag for a previous commit(for example, 902acd...)
$ git tag -a v1.0.0 902acd

# show tag info
$ git show v1.0.1

# push a tag to remote server
$ git push origin v1.0.1
# or push tags
$ git push origin --tags 

# You can also checkout the tags like the same way you checkout branches
$ git checkout -b version2 v2.0.0

# delete a tag
$ git tag -d "v1.0.1a"

```

### 6. Amend Logs

```bash
# amend log for the last commit
$ git commit --amend

```

### 7. Working with drafts (stashing)



```bash
# Save current uncommitted change to stash
$ git stash

# List existing stash
$ git stash list

# recover last stash
$ git stash apply

# recover previous stashes
$ git stash apply stash@{1}

# Delete stashes
$ git stash drop stash@{0}

```

Reference for git stash: [https://git-scm.com/docs/git-stash](https://git-scm.com/docs/git-stash)



