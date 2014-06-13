---
layout: post
title: "Javascript 简单闭包"
date: 2013-10-25 15:26
comments: true
categories: Javascript
---
通俗的讲，javascript 中每个函数都是一个闭包，但通常意义上是嵌套的函数能够体现出闭包的特性。例如：
    var fun = function () {
        var funVar = 0;
        var inFun = function () {
             funVar++;
             return funVar;
        }
        return inFun;
    }
    var returnFunVar = fun();
    console.log(returnFunVar());    // 输出 1
    console.log(returnFunVar());    // 输出 2
    console.log(returnFunVar());    // 输出 3

上面一段代码中，fun() 函数中有一个局部变量 funVar，初值为 0,，还有一个 inFun 函数。inFun 函数将其父作用域，即 fun 函数中的 funVar 变量加 1，并返回 funVar。fun 返回的是 inFun 函数，在外部通过变量 returnFunVar 调用获取 fun 的返回值（即 inFun 函数）。
<!-- more -->
按照通用命令式思维的理解，funVar 是 fun 函数内部的变量，它的生命周期就是 fun 函数的执行周期。当 fun 函数从调用栈中返回时，funVar 变量申请的空间也就释放了。问题是，在 fun 执行结束后，inFun 却引用了”已经释放了“的 funVar ，而且没有报错，每次调用还修改了 funVar。这是为什么呢？

这正是所谓闭包的特性，当一个函数返回它内部定义的一个函数时，就产生了闭包。**闭包不仅只是被返回的函数，还包括函数的定义环境。**大家可能对这里的“定义环境”感到疑惑，可以点击这《[javascript 闭包原理的深入理解](http://www.harole.com/blog/2013/10/25/javascript-understand-closures-deeply/)》。 fun 可以产生多个闭包，闭包和闭包之间互不影响，可以认为是工厂里的生产同种部件的不同车间。例如：
    var fun = function () {
        var funVar = 0;
        var inFun = function () {
             funVar++;
             return funVar;
        }
        return inFun;
    }
    var returnFunVar1 = fun();
    var returnFunVar2 = fun();
    console.log(returnFunVar1());    // 输出 1
    console.log(returnFunVar2());    // 输出 1
    console.log(returnFunVar1());    // 输出 2
    console.log(returnFunVar1());    // 输出 3
    console.log(returnFunVar2());    // 输出 2


