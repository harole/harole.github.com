---
layout: post
title: "Javascript 对象与数组的浅拷贝和深拷贝"
date: 2013-10-26 17:15
comments: true
categories: Javascript
---

一. 浅拷贝

对象浅拷贝的一般实现：
    // 赋值对象方法
    Object.prototype.clone = function () {
        var newObj = {};
        for (var i in this) {
            newObj[i] = this[i];
        }
        return newObj;
    }

    // 待赋值的对象
    var oldObj = {
        name : "harole",
        age  : "21"
    }

    // 复制对象
    var newObj = oldObj.clone();

    delete newObj.name;
    console.log(newObj.name);   // 输出 undefined
    console.log(oldObj.name);   // 输出 harole
<!-- more -->
类似对象浅拷贝，数组浅拷贝的一般实现：
    // 赋值对象方法
    Array.prototype.clone = function () {
        var newArray = [];
        for ( ; this[i]; ) {
            newArray[i] = this[i++];
        }
        return newArray;
    }

    // 待赋值的对象
    var oldArray = ['harole', '21'];

    // 复制对象
    var newArray = oldArray.clone();

    delete newArray[0];
    console.log(newArray[0]);   // 输出 undefined
    console.log(oldArray[0]);   // 输出 harole

很快你会发现，上面的代码只能复制基本类型的属性。对数组、对象和函数无法进行复制。例如：

    oldObj = {
        name: "harole",
        info: {
            age: 21,
            sex: 'man'
        }
    }

上面的浅拷贝无法实现复制，数组同理，也无法实现复制。于是产生的深拷贝！

二. 深拷贝

深拷贝只能对基本类型的属性复制，所以只需在 clone 函数中，进行拷贝之前加一条判断语句。如果是拷贝的是数组、对象，就跳到 clone 函数执行拷贝。

对象深拷贝：
    // 赋值对象方法
    Object.prototype.clone = function () {
        var newObj = {};
        for (var i in this) {
            // 在这加判断拷贝的数据类型
            if (typeof (this[i]) == 'object' ) {
                newObj[i] = this[i].clone();
            } else {
                newObj[i] = this[i];
            }

        }
        return newObj;
    }

    // 待赋值的对象
    var oldObj = {
        name: "harole",
        info: {
            age: 21,
            sex: 'man'
        }
    }

    // 复制对象
    var newObj = oldObj.clone();

    console.log(newObj.info.age);   // 输出 21

数组深拷贝：
    // 赋值对象方法
    Array.prototype.clone = function () {
        var newArray = [];

        for ( var i = 0, l = this.length; i < l; i++ ) {
            if (typeof (this[i]) == 'object' || typeof (this[i]) == 'array') {
                // 注意：若数组中有对象，则要依赖Object.prototype.clone
                newArray[i] = this[i].clone();
            } else {
                newArray[i] = this[i];
            }

        }
        return newArray;
    }

    // 待赋值的对象
    var oldArray = ['harole', { age: 21, sex: 'man' }];

    // 复制对象
    var newArray = oldArray.clone();

    console.log(newArray[1].age);   // 输出 undefined
三. 数组的一个方法：concat

concat 方法在 w3school 上定义：用于连接两个或多个数组（简单的数组拼接），接收参数为一个或多个数组，返回合并后的数组。
但是在这里，我们可以通过 concat 方法来实现数组的深拷贝。如下：

    var arr = [1, 2, [2, 3], 4];

    var arr1 = arr.concat();

    console.log(arr1); // 输出 [1, 2, [2, 3], 4]

    arr1.length = 0;

    console.log(arr1);

    console.log(arr1); // 输出 []

    console.log(arr);   // 输出 [1, 2, [2, 3], 4]