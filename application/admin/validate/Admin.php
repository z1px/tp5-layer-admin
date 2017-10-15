<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 13:48
 */

namespace app\admin\validate;


use think\Validate;

class Admin extends Validate {

    // 验证规则
    protected $rule = [
        'id'=>'require|integer',
        'username'=>'require|length:2,20|alphaDash|unique:admin,username',
        'mobile'=>'regex:^1[34578][0-9]{9}$|unique:admin,mobile',
        'email'=>'email|unique:admin,email',
        'img'=>'url',
        'password'=>'require|length:6,12',
        'status'=>'in:1,2',
    ];

    // 错误提示
    protected $message = [

    ];

    // 验证场景
    protected $scene = [
        'add'=>['username','mobile','email','password','url','status'],
        'edit'=>['id','username','mobile','email','url','password'=>'length:6,12','status'],
        'edit_status'=>['id','status'],
    ];

}