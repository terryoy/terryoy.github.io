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

```
