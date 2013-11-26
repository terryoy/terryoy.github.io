This web site is powered by the amazing static content generator [liquidluck](http://liquidluck.readthedocs.org/en/latest/)

In convention, all the posts are written down and organized under the below path:

    _content/   - for root level html pages
    _content/<year>/    - for posts

To generate site content and preview locally, use the follow commands:

```shell
cd _liquidluck
liquidluck build -v
liquidluck server
```

Template for a Markdown post:

```markdown
# Post Title

- date: 2013-01-01 21:30
- tags: linux, tutorial
- category: tricks

-----------------------------

Post body...

```
