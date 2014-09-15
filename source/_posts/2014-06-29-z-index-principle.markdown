---
layout: post
title: "z-index浅析"
date: 2014-06-29 09:56
comments: true
categories: CSS
---

最近发现对 z-index 的理解不是很深刻，所以到 www.w3.org 上查看了相关内容，以下是个人在查看后对 z-index 的理解。

首先简单介绍一下关于页面上定位的元素，分为 x，y，z 轴的定位。在 position 后的 top 和 left 是对 y，x 轴的位置的定位。而子 z 轴上的定位由 z-index 来决定那个层在上面。

在 DOM 的根节点上默认有一个 root stacking context，当某个元素被设置 position（除了 static）都会生成一个 stacking context，每个 stacking context 中的元素 z-index 默认都是 0，宽度也会和浮动元素一样自适应宽度（不再想 block 元素一样占满正行）。设置 position 的元素，虽然默认值为 0，但是都会位于同一个 stacking context 其他元素之上。示例代码如下：
<!-- more -->
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Document</title>
      <style>
      #text1 {
        /*demo3*/
        /*position: absolute;
        z-index: 5;*/

        background-color: red;
      }
      #text2 {
        position: absolute;
        left: 5px;
        top: 5px;

        /* demo2
         * 让当前的 stacking context 位于
         * father stacking context 其他一般元素之上
         */
        /*z-index: -1;*/

        /*demo3*/
        /*z-index: 2;*/

        background-color: blue;
      }
      </style>
    </head>
    <body>
      <div id="text1">
        this is text1 content.
      </div>
      <!-- demo3 -->
      <!-- <div class="text1Father">
        <div id="text1">
          this is text1 content.
        </div>
      </div> -->
      <div id="text2">
        this is text2 content.
      </div>
    </body>
    </html>
因为 #text2 新生成了一个 stacking context，而新生成的 stacking context 的背景是透明的。所以这里需要给 #text2 设置一个背景颜色。demo1 如下：

![]({{ root_url }}/images/2014-06-29_11-31-31.png)

因为 #text1 和 #text2 同时是位于 root stacking root 下的，所以会想到这里给 #text1 设置一个"z-index: 1;"时 #text1 会位于 #text2 层之上。但是事实上是不会的，因为这里的 #text2 生成了一个 stacking context，新生成的 stacking context 总是位于 father stacking context 之上的。如果希望这个新生成的 stacking context 位于其他一般元素之下，可以给新生成的 stacking context 的 z-index 赋负值。demo2 如下：

![]({{ root_url }}/images/2014-06-29_11-32-43.png)

当然，也可以给 #text1 设置 position 非 static 值生成一个 stacking context 然后让其 z-index 大于，#text2 的 z-index 值。这里就会有疑问了，可以确定的是两个兄弟元素 #text1 和 #text2 生成的 stacking context 的 father stacking context 都是 root stacking context。但是如果两个元素不是兄弟元素呢？答案也是肯定的，只要两个 stacking context 的第一个祖先 stacking context 是同一个，那么他们就可以使用 z-index 进行判断哪个在上层。
