---
layout: post
title: "Liquid Exception: incompatible encoding regexp match (ASCII-8BIT regexp with UTF-8 string)"
date: 2013-09-26 15:05
comments: true
categories: octopress
---

很久没有写文章，准备些文章时，突然发现 octopress 出问题了（呜呜~，都怪写文章太少了）。rake generate 	总是报错"Liquid Exception: incompatible encoding regexp match (ASCII-8BIT regexp with UTF-8 string)"，折腾了一上午，生不如死，总在 google 或 stackoverflow 。上看，还是英文查询！后来才发现我错了，中文搜索一下就出来了。真是不该不相信国人哈！
<!-- more -->
有两种方法：
> <1>直接将[github上插件中](https://github.com/ctdk/octopress-category-list)的 category_list.rb 替换 plugins 中的 category_list.rb
> <2>在安装目录下修改 lib/jekyll/converters/markdown.rb，在将最后一个 html 改成 html = html.force_encoding('utf-8')


第一种方法,确实可以成功；第二种，我实践了，但是没有成功，可能是问题有些差异。以上两种方法，分别来自 [http://ayang1588.github.io/blog/2013/04/01/buildblog/](http://ayang1588.github.io/blog/2013/04/01/buildblog/) 和 [http://blog.t-xx.me/blog/2013/08/25/octopress-utf-8-ascii-8bit-conflict-error/](http://blog.t-xx.me/blog/2013/08/25/octopress-utf-8-ascii-8bit-conflict-error/)