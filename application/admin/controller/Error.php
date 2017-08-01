<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/8/3
 * Time: 20:21
 */

namespace app\sdk\controller;


use think\exception\HttpException;

class Error {

    public function _empty(){
        // 抛出HTTP异常 并发送404状态码
        throw new HttpException(404,'controller not exists');
    }

}