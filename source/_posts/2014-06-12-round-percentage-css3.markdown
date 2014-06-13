---
layout: post
title: "CSS3实现圆环百分比（动画）"
date: 2014-06-12 19:19
comments: true
categories: CSS3
---

> 文章内容分为三个部分，实现方案、逻辑整理和代码实现。

一. 实现方案

    <!-- 外圆 -->
    <div id="roundBox">

        <!-- 遮挡外圆左半部分，为动画准备 -->
        <div class="roundLeft"></div>

        <!-- 遮挡外圆右半部分，为动画准备 -->
        <div class="roundRight"></div>

        <!-- 内圆 遮挡 roundLeft 和 roundRight -->
        <div class="roundInner"></div>
    </div>

二. 逻辑整理
![CSS3实现圆环百分比逻辑图]({{ root_url }}/images/2014-06-12-logic.jpg)

三. 代码实现

该代码基于Jquery，仅支持chrome。[demo点击这里](http://jsfiddle.net/harole/5VRW5/embedded/result/)，[完整代码点击这里](http://jsfiddle.net/harole/5VRW5/)。