<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/12
 * Time: 17:15
 */

namespace app\admin\controller;


use app\admin\logic\AuthMenu;

class Datas extends Common {

    public function _empty(){
        parent::_empty();
    }

    //获取主菜单
    public function ajaxMenu(){

        $authMenu=new AuthMenu();
        $this->result=$authMenu->getMenu();

        return $this->_result();
    }

}