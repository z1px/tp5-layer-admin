<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 13:48
 */

namespace app\admin\validate;


use think\Validate;

class GroupAdd extends Validate {

    // 验证规则
    protected $rule = [
        'name'=>'require|length:2,30|unique:admin_group,name',
        'status'=>'in:1,2',
    ];

    // 错误提示
    protected $message = [

    ];

}