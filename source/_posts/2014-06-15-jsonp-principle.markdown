---
layout: post
title: "jsonp 跨域实现原理"
date: 2014-06-15 20:49
comments: true
categories: Javascript
---

通过script标签实现跨域请求，并带上回调函数作为参数，后台将json数据作为参数传给回调函数。需要配置环境：Apache + php

一. 前端
    function jsonp(url){
        var script = document.createElement('script');
        script.src = url;
        document.body.insertBefore(script, document.body.firstChild);

        // ie8 (包括ie8) 以下不支持 onload，所以这里增加了 onreadystatechange
        script.onload = script.onreadystatechange = function() {

            // 不同浏览器的 readyState 不一致
            if(!script.readyState || script.readyState == "loaded" || script.readyState == "complete"){

                // 释放内存，防止内存泄露
                document.body.removeChild(script);
                script.src = "";
                script = null;
            }
        }
    }
<!-- more -->
    jsonp("http://baidu.com/api/jsonp.php?callback=responseFunc");

    function responseFunc(response){
        // 对数据进行操作
        console.log(response.name)
    }

二. 后端
    <?php
        $data = array('name'=>'harole',"years"=>22);
        $callback = $_GET['callback'];
        echo $callback.'('.json_encode($data).')';
     ?>