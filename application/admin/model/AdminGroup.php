<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/12
 * Time: 14:55
 */

namespace app\admin\model;


use think\Config;
use think\Model;

class AdminGroup extends Model {

    // 设置数据表（不含前缀）
    protected $name = 'admin_group';
    // 设置主键
    protected $pk = 'id';

    // 关闭自动写入create_time字段
//    protected $createTime = false;
    // 关闭自动写入update_time字段
//    protected $updateTime = false;

    //自动完成包含新增和更新操作
    protected $auto = [];
    //自动完成包含新增操作
    protected $insert = [];
    //自动完成包含更新操作
    protected $update = [];

    /**
     * 读取器
     * @param $username
     * @return mixed|string
     * 读取器方法的命名规范：get + 属性名的驼峰命名+ Attr
     */
    protected function getStatusNameAttr($value,$data) {
        if(!isset($data["status"])) return "未知状态";
        switch ($data["status"]){
            case 1:$value="正常";break;
            case 2:$value="禁用";break;
            default:$value="未知状态";
        }
        return $value;
    }


}