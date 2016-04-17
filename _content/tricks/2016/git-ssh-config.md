# Config your git repository to use SSH Key

- date: 2016-04-17 16:11
- tags: shell, virtualbox
- category: tricks

----------------------------

It is very time-consuming typing user and password every time when you do git pull/push to sync your code. Using the rsa ssh key for the authentication will save you a lot of time.

### 1. Generate SSH Key

Just use the method I mentioned before in [this article](/2014/01/ssh-key-based-auth-server.html#toc_1), you will get a public/private key pair. Upload the public key to your github or other git hosting service.

### 2. Config your local SSH

Create or open the file `~/.ssh/config` for ssh key config. The content will be similar as below:

```
Host dev
 HostName dev.local
 IdentityFile ~/.ssh/dev_rsa
Host github.com
 HostName github.com
 IdentityFile ~/.ssh/github_rsa
```

You can use a "host" alias for ssh connect instead of the full host name, this would be convenient if you might switch server host.


### 3. Choose the correct git url

Usually public git hosting services use HTTPS or GIT protocol, and your private repository can use SSH protocol like in [this article](/2014/10/common-git-commands.html#toc_3).


    * Git URL: git@bitbucket.org:<accountname>/<reponame>.git  
    * Use with alias: git@bitbucket:<accountname>/<reponame>.git


