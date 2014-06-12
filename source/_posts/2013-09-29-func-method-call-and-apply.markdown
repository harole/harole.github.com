---
layout: post
title: "函数方法call()和apply()的使用和区别"
date: 2013-09-29 22:40
comments: true
categories: javascript
---
**call()** 方法和 **apply()** 方法的第一个参数都是要调用的函数对象，在函数体内这一参数是关键字 **this** 的值。call()剩余的参数是传递给要调用的函数的值。
	var O = {};

	function f( a, b ) {
		console.log(a);
		console.log(b);
	}	
	
	// call()方法的使用，当前 **this** 指向的是对象O
	f.call( O, 1, 2 );

	// call()方法的实现与下面代码实现相似，可以通过下面的代码来理解call()的使用。	
	O.m = f;
	O.m();
	delete O.m;

	// apply()方法和call()方法相似，区别在于apply传递给函数的参数是由数组指定的：
	f.apply( O, [1,2] );