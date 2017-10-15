<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/28
 * Time: 17:34
 */

namespace app\admin\controller;


use app\admin\service\Admin;
use app\admin\service\BehaviorLog;
use app\admin\service\LoginLog;

class Log extends Common {

    protected $loginLog;
    protected $behaviorLog;
    protected $admin;


    public function _empty(){
        parent::_empty();
    }


    protected function _before(){
        $this->loginLog=new LoginLog();
        $this->behaviorLog=new BehaviorLog();
        $this->admin=new Admin();
    }

    /**
     * 登录日志
     * @return mixed
     */
    public function getLogin(){

        if($this->request->isPost()){
            $this->result=$this->loginLog->getList($this->params);
            return $this->_result();
        }else{
            return $this->_fetch(["list_admin"=>$this->admin->getAll()]);
        }
    }

    /**
     * 行为日志
     * @return mixed
     */
    public function getBehavior(){

        if($this->request->isPost()){
            $this->result=$this->behaviorLog->getList($this->params);
            return $this->_result();
        }else{
            return $this->_fetch(["list_admin"=>$this->admin->getAll()]);
        }
    }

}