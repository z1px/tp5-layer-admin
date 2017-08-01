<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 13:48
 */

namespace app\admin\validate;


use think\Validate;

class AdminAdd extends Validate {

    // 验证规则
    protected $rule = [
        'username'=>'require|length:2,20|alphaDash|unique:admin,username',
        'mobile'=>'regex:^1[34578][0-9]{9}$|unique:admin,mobile',
        'email'=>'email|unique:admin,email',
        'password'=>'require|length:6,12',
        'status'=>'in:1,2',
    ];

    // 错误提示
    protected $message = [

    ];

}