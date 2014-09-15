---
layout: post
title: "求两个数组的交集"
date: 2014-09-02 23:00
comments: true
categories: Javascript 算法
---
拿到这样一个问题，首先想到我们需要做的是：用最快的算法取出两个数组中的相同的元素。

上面一句明显是废话，要取出相同的元素，我们必须判断 arr1[i] == arr2[j]

大脑给的第一反应就是：
    var arr1 = [1,3,4,5,6];
    var arr2 = [2,4,6,8,9];
    var r = [];
    for (var i = 0, len1 = arr1.length; i < len1; i++) {
        for (var j = 0, len2 = arr2.length; j < len2; j++) {
            if (arr1[i] === arr2[j]) {
               r.push(arr1[i]);
            }
        }
    }
<!-- more -->
可以很容易的看出上述解决方案，算法复杂度是n平方的。使数组 arr1 中的每个元素和 arr2 数组中每个元素进行了一次判断，真的有必要每个元素都需要判断一次吗？如果数组均为乱序的，这无法必要。但是如果数组为有序的呢？我们知道两个数组的状态：

>1. arr1[i] === arr2[j]
2. arr1[i] < arr2[j]
3. arr1[i] > arr2[j]


当数组为上述状态1时，可获得交集元素；
当数组为上述状态2时，因为数组是顺序的（这里默认从小到大），只需 arr1 对应的序号加 1；
当数组为上述状态3时，同状态2，但这里只需 arr2 对应的序号加 1；
当数组的任意一个数组的计数器达到数组长度时，结束循环。综合上述，可得：
    var arr1 = [1,3,4,5,6];
    var arr2 = [2,4,6,8,9];
    var r = [];
    var len1 = arr1.length;
    var len2 = arr2.length;
    var i = 0;
    var j = 0;

    while(i<len1&&j<len2) {
        if (arr1[i] === arr2[j]) {
            r.push(arr1[i]);
            i++;
            j++;
        } else if(arr1[i] < arr2[j]) {
            i++;
        } else {
            j++;
        }
    }
可以看出，如果两个数组均为有序数组时，复杂度为2n。
