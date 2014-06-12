---
layout: post
title: "javascript 闭包原理的深入理解"
date: 2013-10-25 15:36
comments: true
categories: javascript
---
在 《[javascript 简单闭包](http://www.harole.com/blog/2013/10/25/javascript-simple-closures/)》 一文中提到，闭包包含返回的函数和该函数的定义环境，本文将从函数定义环境和函数执行周期的角度来理解闭包，如有不恰之处，欢迎提出，讨论！先来看一个示例及其结果：
    //示例一：
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

总结：我们可以发现，示例一中，returnFunVar1 和 returnFunVar2 操作的 funVar 不是同一个变量，var returnFunVar1 = fun();  事实上 fun() 的局部变量随着 fun 执行的结束，即 funVar 也释放了。<!-- more -->而在javascript 简单闭包中，我们知道函数的执行它定义的位置有关，而与执行环境无关。所以，当执行 returnFunvar() 时，就是执行 fun 函数中 inFun 指向的那个匿名函数，而不是 inFun 函数。因为 fun 函数已经执行结束，inFun 已经被释放。当那个匿名函数执行时，发现自己需要 funVar 这个变量。于是为 funVar 在内存上添加一快空间，此时的 funVar 不在是 fun 中的那个 funVar 了（因为已经释放了），我们给它命名为 funVar1。当该匿名函数执行结束后，同样释放局部变量，但是 funVar1 不属于它的局部变量，所以没有释放（可能带来内存泄露）。同理，var returnFunVar2 = fun(); 中的 funVar 为 funVar2，故有示例一展示的结果。

    //示例二：
    var fun = function () {
        funVar = 0;
        var inFun = function () {
             funVar++;
             return funVar;
        }
        return inFun;
    }
    var returnFunVar1 = fun();
    var returnFunVar2 = fun();
    console.log(returnFunVar1());    // 输出 1
    console.log(returnFunVar2());    // 输出 2
    console.log(returnFunVar1());    // 输出 3
    console.log(returnFunVar1());    // 输出 4
    console.log(returnFunVar2());    // 输出 5

    // 示例三
    var global = 0;
    var fun = function () {
        var inFun = function () {
             global++;
             return global;
        }
        return inFun;
    }
    var returnFunVar1 = fun();
    var returnFunVar2 = fun();
    console.log(returnFunVar1());    // 输出 1
    console.log(returnFunVar2());    // 输出 2
    console.log(returnFunVar1());    // 输出 3
    console.log(returnFunVar1());    // 输出 4
    console.log(returnFunVar2());    // 输出 5



示例二和示例三，不管是隐式还是显式声明的全局变量，因为不会释放变量，所以在闭包中都是指向内存的同一个区域（即指向同一个变量）。故有示例二和示例三的输出结果。