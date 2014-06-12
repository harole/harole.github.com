---
layout: post
title: "像 html 模块化一样，模块化 javascript 事件处理程序，使之可维护！"
date: 2013-04-10 12:49
comments: true
categories: javascript
---
一. 常用的事件处理程序

	funciton handleClick( event ) {

		var popWindow = document.getElementById("popWindow");

		popWindow.style.left = event.clientX + "px";
		popWindow.style.top = event.clientY + "px"; 

		popWindow.className = "visible";

	}
	addListener(element, "click", handleClcik);	

上述程序功能：监听 "element" 元素的 click 事件，当触发 click 事件时，显示一个窗口到当前鼠标位置。

缺点：事件处理程序包含了应用逻辑，即应用逻辑只和 click 事件相关。但是 mousehover，mouseup 等其他事件也要实现同样的功能。会有如下实现：
<!-- more -->

	// mousehover
	funciton handleMouseHover( event ) {

		var popWindow = document.getElementById("popWindow");

		popWindow.style.left = event.clientX + "px";
		popWindow.style.top = event.clientY + "px"; 

		popWindow.className = "visible";

	}
	addListener(element, "mousehover", handleMouseHover);		

	// mouseup
	funciton handleMouseUp( event ) {

		var popWindow = document.getElementById("popWindow");

		popWindow.style.left = event.clientX + "px";
		popWindow.style.top = event.clientY + "px"; 

		popWindow.className = "visible";

	}
	addListener(element, "mousehover", handleMouseUp);		

	// 其他事件
	......

很明显上面的代码被复制了多，于是我们又有了如下代码：

	// eventHandle
	funciton eventHandle( event ) {

		var popWindow = document.getElementById("popWindow");

		popWindow.style.left = event.clientX + "px";
		popWindow.style.top = event.clientY + "px"; 

		popWindow.className = "visible";

	}
	addListener(element, "click", eventHandle);	
	addListener(element, "mousehover", eventHandle);		
	addListener(element, "mousehover", eventHandle);	

	// 其他监听事件
	......

恩恩，经过两次改进，我们将应用逻辑从事件处理程序中隔离了。但是，问题并没有解决，因为你监听的事件 
"click", "mousehover", "mouseup"等的处理程序大部分情况下是不一样的。于是有了如下方案：

二. 隔离应用逻辑

	var app =  {

		showPopWindow: function (event) {

			var popWindow = document.getElementById("popWindow");

			popWindow.style.left = event.clientX + "px";
			popWindow.style.top = event.clientY + "px";			

		},

		handleClick: function (event) {

			this.showPopWindow( event );
			
			// click 的其他代码
			......
		},

		handleMouseHover: function (event) {

			this.showPopWindow( event );

			// mousehover 的其他代码
			......

		}

		// 其他事件处理函数
		......		
	};

	addListener(element, "click", function (event) {
		app.handleClick(event);
	});

	addListener(element, "mousehover", function (event) {
		app.handleMouseHover(event);
	});
	
	// 其他事件的监听
	......

隔离应用逻辑后，代码还存在一个问题，即 event 对象被无节制的分发（event 由 addListener 传入了 app.handleClick 或 app.handleMouseHover，再传入app.showPopWindow）。

三. 不要分发事件对象

应用逻辑 showPopWindow 不应该依赖于 event 对象来完成功能。如果想要测试这个方法，必须重新创建一个 event 对象，否则在函数内无法找到 event.clientX 和 event.clientY，就无法测试。所以做了如下改进：

	var app =  {

		showPopWindow: function ( x, y ) {

			var popWindow = document.getElementById("popWindow");

			popWindow.style.left = x + "px";
			popWindow.style.top = y + "px";			

		},

		handleClick: function ( event ) {

			this.showPopWindow( event.clientX, event.clientY );
			
			// click 的其他代码
			......
		},

		handleMouseHover: function ( event ) {

			this.showPopWindow( event.clientX, event.clientY );

			// mousehover 的其他代码
			......

		}

		// 其他事件处理函数
		......		
	};

	addListener(element, "click", function (event) {
		app.handleClick(event);
	});

	addListener(element, "mousehover", function (event) {
		app.handleMouseHover(event);
	});
	
	// 其他事件的监听
	......

	// 当我们想测试的时候，就不在需要重新创建一个event对象了，只需要向下面一样即可
	app.showPopWindow( "20", "20" );

当处理事件时，最好让事件处理程序成为唯一一个接触到 event 对象的函数（即 handleClick 和 handleMouseHover 等）。
事件处理程序应当在进入应用逻辑 showPopWindow 之前对 event 对象执行必要的操作包括阻止默认行为和事件冒泡。最终形成如下代码：

	var app =  {

		showPopWindow: function ( x, y ) {

			var popWindow = document.getElementById("popWindow");

			popWindow.style.left = x + "px";
			popWindow.style.top = y + "px";			

		},

		handleClick: function ( event ) {
			// 阻止默认行为
			event.preventDefault();

			// click 的其他代码
			...... 

			this.showPopWindow( event.clientX, event.clientY );						
		},

		handleMouseHover: function ( event ) {
			// 阻止默认行为
			event.preventDefault();

			// mousehover 的其他代码
			......

			this.showPopWindow( event.clientX, event.clientY );

		}

		// 其他事件处理函数
		......		
	};

	addListener(element, "click", function (event) {
		app.handleClick(event);
	});

	addListener(element, "mousehover", function (event) {
		app.handleMouseHover(event);
	});
	
	// 其他事件的监听
	......