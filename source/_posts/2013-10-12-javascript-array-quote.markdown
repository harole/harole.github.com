---
layout: post
title: "javascript 数组引用和对象引用"
date: 2013-10-12 23:22
comments: true
categories: javascript
---

    var a = b = [1,2,3];
    a = [];// a 为空数组，b 仍是 [1,2,3]

    var a = b = [1,2,3];
    a.length = 0;// a，b 为空数组

    var a = b = [1,2,3];
    a.length = 2;// a，b 为 [1,2]

总结：换个角度来理解上面那个问题，a, b 都是数组对象 [1,2,3] 的引用，当a = [] 或是 b = [] 改变的只是变量 a，b 的引用对象而已。而是用 a.length = 0 或是 b.length = 0，改变的是数组对象 [1,2,3] 的长度，故有上述实例的结果。

思考：上述数组 a 和 b 保存的都只是数组 [1,2,3] 的引用，那么对与 Object 是否也是引用呢？猜想，引用规则对 Object 同样适用。
<!-- more -->
验证猜想：
    // a 为null，b 仍是 { one: 1, two: 2, three: 3 }
    var a = b = { one: 1, two: 2, three: 3 };
    a = null;

    // a，b 为{ one: 1, two: 2 }
    var a = b = { one: 1, two: 2, three: 3 };
    delete a.three;

    // a，b 为 {}
    var a = b = { one: 1, two: 2, three: 3 };
    for ( number in a ) {

        // 为什么这里使用 [] 的方式调用对象的属性？
        // 因为 for/in 语句，将字面量 one 等转换成字符串 "one" 等
        // 所以 a.number 会变成 a."one"等, 故无法访问
        // 而 a[number] 为 a["one"]，可以正常访问
        delete a[number];
    }

总结：javascript 中两个变量之间赋值传递一个对象或数组，传递的是这个对象或数组的引用。但是在实际中我们希望的是进行拷贝。那么如何实现对象或数组间的拷贝呢？请看《[javascript 对象与数组的浅拷贝和深拷贝](http://www.harole.com/blog/2013/10/26/javascript-shallow-deep-cope/)》
