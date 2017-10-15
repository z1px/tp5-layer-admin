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
use think\Request;

class Admin extends Model {

    // 设置数据表（不含前缀）
//    protected $name = 'admin';
    // 设置当前模型对应的完整数据表名称
    protected $table = 'tp5_admin';
    // 设置主键
    protected $pk = 'id';
    // 类型转换
    protected $type = [
        'create_time'  =>  'timestamp:Y-m-d H:i:s',
        'update_time'  =>  'timestamp:Y-m-d H:i:s',
    ];

    // 关闭自动写入create_time字段
//    protected $createTime = false;
    // 关闭自动写入update_time字段
//    protected $updateTime = false;

    //自动完成包含新增和更新操作
    protected $auto = [];
    //自动完成包含新增操作
    protected $insert = [];
    //自动完成包含更新操作
    protected $update = ["ip","area"];

    //返回结果
    protected $result=[
        "code"=>1,
        "msg"=>"data normal",
        "data"=>[],
    ];

    //状态
    public $list_status=[
        1=>"正常",
        2=>"禁用",
    ];

    /**
     * 修改器
     * @param $value
     * @return int
     * 修改器方法的命名规范：set + 属性名的驼峰命名+ Attr
     */
    protected function setPasswordAttr($value){
        if(empty($value)) return null;
        return auth_code($value,"ENCODE",Config::get('login_key'));
    }

    /**
     * 修改器
     * @param $value
     * @return int
     * 修改器方法的命名规范：set + 属性名的驼峰命名+ Attr
     */
    protected function setIpAttr($value){
        if(!empty($value)) return $value;
        return Request::instance()->ip();
    }

    protected function setAreaAttr($value){
        if(!empty($value)) return $value;
        $ip=Request::instance()->ip();
        return get_ip_area($ip);
    }

    /**
     * 读取器
     * @param $username
     * @return mixed|string
     * 读取器方法的命名规范：get + 属性名的驼峰命名+ Attr
     */
    protected function getGroupAttr($value,$data) {
        if(!isset($data["group_id"])) return "未分组";
        if($data["group_id"]===0) return "系统管理员";
        if(empty($data["group_id"])) return "未分组";
        $adminGroup=new AdminGroup();
        return $adminGroup->where(['id'=>$data["group_id"]])->value("name");
    }
    protected function getStatusNameAttr($value,$data) {
        if(!isset($data["status"])) return "未知状态";
        return isset($this->list_status[$data["status"]])?$this->list_status[$data["status"]]:"未知状态";
    }

}