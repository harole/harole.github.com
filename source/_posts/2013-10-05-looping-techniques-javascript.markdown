---
layout: post
title: "Javascript 循环（for，while）那些事儿！"
date: 2013-10-05 00:16
comments: true
categories: Javascript
---
1. for 类循环

    1. for-in 循环的一般形式

            // i 可以是数组的下标，也可以是对象的属性
            // arr 可以是数组，也可以是对象
        	for ( i in arr ) {

                // 如需匹配特定的值
                // 可以使用一个判断语句
                // definited 为匹配值的变量
                if ( arr[i] === definited ) {

                }
        	}
    总结：for-in 语句不仅可以对数组循环遍历，还可以对对象的属性循环遍历
    <!-- more -->

    2. for 循环一般形式
            for ( var i = 0; i < arr.length; i++ ) {

            }
    总结：每次都需要去查找数组的 length 属性，可以通过缓存 length 来稍微提升遍历的速度

    3. for 缓存数组的 length 属性
            for ( var i = 0, l = arr.length; i < l; i++ ) {

            }
    总结：如果遍历的是HTMLCollection，性能提升比较明显。因为每次访问HTMLCollection的属性，HTMLCollection都会内部匹配一次所有的节点。

    4. 遍历数组操作中，不判断下标，直接判断数组元素是否存在，再对元素进行操作。
            var currentItem;
            for ( var i = 0; items[i]; i++ ) {
                currentItem = items[i];
            }

            // 例如：遍历 DOM 子元素
            for ( node = parent.firstChild; node; node = node.nextSibling ) {
                if ( node.nodeType === 1 ) {
                    node.nodeIndex = ++count;
                }
            }

    5. 在迭代中，要尽可能少遍历，如果知道从 position 开始。
            var currentItem;
            for ( var i = position || 0, l = items.length; i < l; i++ ) {
                currentItem = items[i];
            }

    6. 倒序遍历可以减少几个字符。
            for ( var i = items.length, currentItem; i; ) {
                currentItem = items[--i];  // 合并了 i 自减和 i 取值的操作
            }

2. while 循环


    1. 通过 while 检测下标遍历。
            var l = arr.length, currentItem;
            while ( --l ) {
                currentItem = arr[l];
            }

    2. while 检测元素
            var findType, i = 0;
            while ( findType == arr[i++] ) {
                // 一些操作
            }