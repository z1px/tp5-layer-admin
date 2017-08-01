<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 13:48
 */

namespace app\admin\validate;


use think\Validate;

class EditStatus extends Validate {

    // 验证规则
    protected $rule = [
        'id'=>'require|integer',
        'status'=>'require|in:1,2',
    ];

    // 错误提示
    protected $message = [

    ];

}