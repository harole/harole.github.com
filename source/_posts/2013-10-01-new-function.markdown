---
layout: post
title: "Function()构造函数，即用 new Function() 方式构造函数"
date: 2013-10-01 14:38
comments: true
categories: javascript
---
一. 下面是使用Functin()构造函数来创建一个函数的例子：
	var f = new Function( "x", "y", "return x + y;" );
这行代码创建了一个新函数，这个函数和下面的定义基本相等
	function f( x, y ){
		return x + y;
	}
Function构造函数期待任意数目的 **字符串** 参数，其中最后一个参数（它可以包含任意多条 javascript 语句）是函数的函数体，其他均是函数的参数。如果需要定义一个没有参数的函数体，只需向构造函数传入一个字符串参数，也就是函数体。
<!-- more -->
二. 关于Function()构造函数需要理解以下几点：

    * Function()构造函数润允许javascript代码被动态地创建而且在运行时编译。
      全局的eval()函数也是这种方式。

    * Function()构造函数解析函数体，并且每次被调用时都创建一个新的函数对象。

    	缺点：如果构造函数的调用出现在一个循环中，或者出现在一个经常被调用的函数中，
    		  那么过程的效率将会很低。

    	优点：如果构造函数的调用出现在一个循环或是函数中的直接量中的函数直接量或者
    		  嵌套的函数，并不会每次遇到的时候都编译。

    * Function()构造函数，他所创建的函数并不适用词法作用域，而是当作顶层的函数一样编译。
      如下面代码所示:
      var y = "global";
	function a(){
    	
		var y = "local1";
    	function constructFunction() {
    		var y = "local";
    		return new Function("return y;");
    	}
		
		// 这里 constructFunction()()
		// 第一个 '()' 是执行 constructFunction 函数
		// 第二个 '()' 是执行constructFunction 函数返回的 'new Function()' 函数。
    	alert(constructFunction()()); // 显示global
    }