---
layout: post
title: "jQuery中解决名字（jQuery）和 $ 与其他类库冲突方法---noConflict()解析"
date: 2013-10-11 02:42
comments: true
categories: jQuery javascript
---
###jQuery 中 noConflict() 方法如下：


	// jQuery 开头定义变量部分：
	var ....,

		_$ = window.$,

		_jQuery = window.jQuer,

		....;

	noConflict: function( deep ) {
		if ( window.$ === jQuery ) {
			window.$ = _$;
		}

		if ( deep && window.jQuery === jQuery ) {
			window.jQuery = _jQuery;
		}
<!-- more -->
		return jQuery;
	}
	...

	// jQuery 函数底部
	if ( typeof module === "object" && module && typeof module.exports === "object" ) {
		// 在执行节点的加载器中，公开 jQuery 作为 module.exports,
		// 因为 module 模式：不能创建全局变量，用户将会储存它作为局部变量
		// 全局变量不能被 Node module 解析。
		// 所以将 jQuery 赋给 module.exports
		module.exports = jQuery;
	} else {
		// 不是 module 模式，就把 jQuery 赋给全局
		window.jQuery = window.$ = jQuery;
		
		// Register as a named AMD module, since jQuery can be concatenated with other
		// files that may use define, but not via a proper concatenation script that
		// understands anonymous AMD modules. A named AMD is safest and most robust
		// way to register. Lowercase jquery is used because AMD module names are
		// derived from file names, and jQuery is normally delivered in a lowercase
		// file name. Do this after creating the global so that if an AMD module wants
		// to call noConflict to hide this version of jQuery, it will work.
		if ( typeof define === "function" && define.amd ) {
			define( "jquery", [], function () { return jQuery; } );
		}
	}

总结：在一般的浏览器中，我们看到的是 window.jQuery = window.$ = jQuery，jQuery是全局变量；当我们调用 noConflict 时，window.$ = window.$ 和 window.jQuery = window.jQuery，覆盖了window.jQuery = window.$ = jQuery，使得 jQuery 变成了局部变量，因此不会和其他类库使用的 $ 和 jQuery 这两个变量冲突；
