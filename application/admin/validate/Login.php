<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 13:48
 */

namespace app\admin\validate;


use think\Validate;

class Login extends Validate {

    // 验证规则
    protected $rule = [
        'username'=>'require',
        'password'=>'require',
        'captcha|验证码'=>'require|captcha'
    ];

    // 错误提示
    protected $message = [
        "username.require"=>"请输入账号",
        "password.require"=>"请输入密码",
    ];

}