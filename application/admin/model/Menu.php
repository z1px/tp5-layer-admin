<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/12
 * Time: 14:55
 */

namespace app\admin\model;


use think\Model;

class Menu extends Model {

    // 设置数据表（不含前缀）
    protected $name = 'tp5_menu';
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
    protected function getTypeNameAttr($value,$data) {
        if(!isset($data["type"])) return "未知权限类型";
        switch ($data["type"]){
            case 1:$value="权限控制";break;
            case 2:$value="权限白名单";break;
            case 3:$value="权限黑名单";break;
            default:$value="未知权限类型";
        }
        return $value;
    }
    protected function getStatusNameAttr($value,$data) {
        if(!isset($data["status"])) return "未知状态";
        switch ($data["status"]){
            case 1:$value="菜单展示";break;
            case 2:$value="菜单隐藏";break;
            default:$value="未知状态";
        }
        return $value;
    }
    protected function getPtitleAttr($value,$data) {
        if(!isset($data["pid"])) return "未知";
        if(empty($data["pid"])) return "|-- 顶级菜单";
        $menu=$this->field("title,pid")->find($data["pid"]);
        if(empty($menu)) return "上级菜单不存在";
        $value=(empty($menu->pid)?"|-- --":"|-- -- --")." {$menu->title}";
        unset($menu);
        return $value;
    }

}