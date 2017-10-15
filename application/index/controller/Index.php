<?php
namespace app\index\controller;


use Redis;

class Index
{

    public function index(){

        $redis=new Redis();
        $redis->connect("127.0.0.1");

//        $redis -> lPush('favorite_fruit','cherry');
//        $redis -> lPush('favorite_fruit','banana');
//        $redis -> lPush('favorite_fruit','apple');
//        $redis -> lPush('favorite_fruit','peach');
//        $redis -> lPush('favorite_fruit','pineapple');
//        $redis -> lPush('favorite_fruit','grape');

//        dump($redis->lLen("favorite_fruit"));
//        dump($redis->lRange("favorite_fruit",1,3));

//        dump($redis->get("test"));
//        $keys=["test"];
//        for ($i=0;$i<=10;$i++){
//            $redis->set("test{$i}",$i."=".date("Y-m-d H:i:s"));
//            $keys[]="test{$i}";
//        }
//        dump($redis->set("test",date("Y-m-d H:i:s")));
//        $redis->mset(["test11"=>1111,"test12"=>2222]);
//        $keys[]="test11";
//        $keys[]="test12";
////        dump($redis->del("test"));
//        dump($redis->mget($keys));

        $redis -> hset('zhlinfo', 'name', 'zhl');
        $redis -> hset('zhlinfo', 'age', 26);
        $redis -> hset('zhlinfo', 'address', 'China Beijing');
//
//        dump($redis -> hGetAll('zhlinfo'));
//
//        $redis->sAdd('key1' , 'set1');
//        $redis->sAdd('key1' , 'set2');
//        $redis->sAdd('key1' , 'set3');
//
//        dump($redis->sMembers("key1"));

//        $redis->zAdd('key', 1, 'val1');
//        $redis->zAdd('key', 0, 'val0');
//        $redis->zAdd('key', 5, 'val5');
//        $redis->zAdd('key', 0, 'val8');
//        $redis->zAdd('key', 2, 'val2');
//        $redis->zAdd('key', 10, 'val10');

//        dump($redis->zRange("key",0,7));

//        dump($redis->keys("*"));
//        $redis -> lPush('key111',date("Y-m-d H:i:s"));
//        $redis -> rPush('key111',"r_".date("Y-m-d H:i:s"));
//        dump($redis->lLen("key111"));
//        dump($redis->lRange("key111",0,100));

    }

//    public function index()
//    {
//        return '<style type="text/css">*{ padding: 0; margin: 0; } .think_default_text{ padding: 4px 48px;} a{color:#2E5CD5;cursor: pointer;text-decoration: none} a:hover{text-decoration:underline; } body{ background: #fff; font-family: "Century Gothic","Microsoft yahei"; color: #333;font-size:18px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.6em; font-size: 42px }</style><div style="padding: 24px 48px;"> <h1>:)</h1><p> ThinkPHP V5<br/><span style="font-size:30px">十年磨一剑 - 为API开发设计的高性能框架</span></p><span style="font-size:22px;">[ V5.0 版本由 <a href="http://www.qiniu.com" target="qiniu">七牛云</a> 独家赞助发布 ]</span></div><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_bd568ce7058a1091"></thinkad>';
//    }
}
