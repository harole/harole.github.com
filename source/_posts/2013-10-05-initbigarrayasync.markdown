---
layout: post
title: "Javascript 异步初始化大数组"
date: 2013-10-05 17:26
comments: true
categories: Javascript
---
		// 任何情况下，创建一个定时器造成UI线程暂停，如同它从一个任务切换到下一个任务
		// THRESHOLD 用于防止 javascript 运行超时，DELAY 用来设置函数调用等待时间
		// 为什么 DELAY 设置为15呢？因为 windows 系统上定时器分辨率为 15 毫秒

		var THRESHOLD = 150, DELAY = 15;

		function initBigArrayAsync(max, cb) {
		    var r = [], i = 0;

		    function init(startTime) {
		        while (i < max) {

		        	// 判断语句，函数执行的当前时间和开始执行时间差
		        	// 与限定值（THRESHOLD，该值一般比超时时间小）比较
		        	// 当小于 THRESHOLD，可进行正常赋值
		            if (new Date - startTime < THRESHOLD) {
		                r[i++] = i;
		            } else {
<!-- more -->
		            	// 当不小于 THRESHOLD 时，继续执行函数可能会超时
		            	// 所以用一个很小的等待时间 DELAY，来从新调用 init() 进行赋值
		                setTimeout(function() {
		                    init(new Date);
		                }, DELAY);
		                return;
		            }
		        }

		        cb(r);
		    }

		    init(new Date);
		}

		// 该函数用于检测，是否成功给大数组赋值
		initBigArrayAsync(1000000, function(arr) {
		    console.log(arr.length);
		    console.log(arr[1000000 - 1]);
		});