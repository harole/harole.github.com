---
layout: post
title: "正则表达式（RegExp）方法，test() 和 exec() 区别。"
date: 2013-10-07 19:10
comments: true
categories: RegExp
---
#### test() 方法。

>1. 语法：RegExpObject.test(string)；
>2. 作用：用来检测字符串是否匹配某个模式（该模式由 RegExpObject 设置）；
>3. 返回值：当 string 含有与 RegExpObject匹配的文本，则返回 true，否则返回 false。

实例：

	var str = "this is harole's blog.";
	var pattern = new RegExp( "harole" );
	var result = pattern.test( "sam harole freestyle" );
	alert( "this is harole's blog : " + result );
<!-- more -->
#### exec() 方法。
	1. 语法：RegExpObject.test(string)；
	2. 作用：用来获取字符串匹配某个模式（该模式由 RegExpObject 设置）的内容；
	3. 返回值：如果存在满足 RegExpObject，则把匹配到的结果依次存入一个数组中，并返回数组；如果没有找到匹配的字符串，则返回 null。
#### match() 方法。
	1. 语法：RegExpObject.test(string)；
	2. 作用：用来检测字符串是否匹配某个模式（该模式由 RegExpObject 设置）；
	3. 返回值：当 string 含有与 RegExpObject匹配的文本，则返回 true，否则返回 false。

总结：1. test() 和 exec() 比较：

未完成，请耐心等待。。。