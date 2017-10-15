<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 13:48
 */

namespace app\admin\validate;


use think\Validate;

class Group extends Validate {

    // 验证规则
    protected $rule = [
        'id'=>'require|integer',
        'name'=>'require|length:2,30|unique:admin_group,name',
        'status'=>'in:1,2',
    ];

    // 错误提示
    protected $message = [

    ];

    // 验证场景
    protected $scene = [
        'add'=>['name','status'],
        'edit'=>['id','name','status'],
        'edit_status'=>['id','status'],
    ];

}