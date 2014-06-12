---
layout: post
title: "两个块级元素 display:inline-block，其中一个没有内容导致两元素不在一条直线上"
date: 2013-04-10 21:58
comments: true
categories: 
---	
一. div.left 和 div.right 均有内容。
	<!doctype html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>inline-cblock</title>
        <style type="text/css">
        .box {
            width: 400px;
            height: 100px;
            margin: 50px auto;
            background: black;
            /* S-- 用于清除排版时 left 和 right 之间的间隙 */
            letter-spacing: -3px;
            font-size: 0;       
            /* E-- 用于清除排版时 left 和 right 之间的间隙 */
        }
        .box .left {
            display: inline-block;
            width: 200px;
            height: 100px;
            font-size: 50px;
            background: yellow;
        }
        .box .right {
            display: inline-block;
            width: 200px;
            height: 100px;  
            font-size: 50px;   
            background: blue;       
        }
        </style>
    </head>
    <body>
        <div class="box">
            <div class="left">Left</div>
            <div class="right">Right</div>
        </div>  
    </body>
    </html>
预期效果：
![all have content]({{ root_url }}/images/inline-block-01.png)

二. 仅把 div.left 中的内容去掉，效果：
![all have content]({{ root_url }}/images/inline-block-02.png)
<!-- more -->
三. 仅把 div.right 中的内容去掉
![all have content]({{ root_url }}/images/inline-block-03.png)

问题“二”和“三”解决办法：
>方案一：
	.box .left {
        verical-align: top;
    }
    .box .right {
        verical-align: top;
    } 
>方案二：
	.box .left {
        verical-align: middle;
    }
    .box .right {
        verical-align: middle;
    } 
>方案三:
	.box .left {
        verical-align: top;
    }
或者    
    .box .right {
        verical-align: top;
    }
>    

总结（对方案的理解）：
>对于方案一和方案二的解决，可能会好奇如果都 vertical-align：baseline; 能否解决，答案是否定的。

>vertical-align 默认是 baseline，当 left 和 right 其中之一缺少内容，缺少内容的那个 div 
的 baseline 在容器本身的底部，另外一个有内容的 div 和缺少内容的 div 的 baseline 对齐导致了有内容的 div 掉了下来。

>问题一：对于上面的“有内容的 div 和缺少内容的 div 的 baseline 对齐导致了有内容的 div 掉了下来”会有个疑问，即“为什么是有内容的 div 和没有内容 div 的对齐，而不是没有内容的和有内容的 div 对齐呢？”

>其实也可以看做是没有内容的 div 和有内容的 div 对齐，因为浏览器的默认是向下排版的所以向下溢出了，而没有向上溢出。

>问题二：对于方案一和方案二都可以理解了，那为什么方案三也可以呢？

>当缺少内容的 div 设置了 “verti-align: top;”， 有内容的 div 和它对齐（也可以看做它和有内容的 div 对齐，原因看问题一的解答），就达到期望的显示了。

>当有内容的 div 设置了 “verti-align: top;” ，当然就回到 div.box 的顶部了，至于没有内容的 div 为什么没有和有内容的 div 对齐呢？原因和问题一的解答是一样的，没有内容的 div 尝试对齐，但是它不能向上溢出。

关于 vertical-align 相关信息可以参考链接：<http://www.jb51.net/css/10337.html>