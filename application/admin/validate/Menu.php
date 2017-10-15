<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 13:48
 */

namespace app\admin\validate;


use think\Validate;

class Menu extends Validate {

    // 验证规则
    protected $rule = [
        'id'=>'require|integer',
        'title'=>'require|unique:menu,title',
        'module'=>'require|length:2,30|alphaDash',
        'controller'=>'require|length:2,50|alphaDash',
        'action'=>'require|length:2,50|alphaDash',
        'sort'=>'integer|between:1,99',
        'type'=>'require|in:1,2,3,4',
        'status'=>'require|in:1,2',
        'pid'=>'integer|min:0',
    ];

    // 错误提示
    protected $message = [

    ];

    // 验证场景
    protected $scene = [
        'add'=>['title','module','controller','action','sort','type','status','pid'],
        'edit'=>['id','title','module','controller','action','sort','type','status','pid'],
        'edit_status'=>['id','status'],
    ];

}