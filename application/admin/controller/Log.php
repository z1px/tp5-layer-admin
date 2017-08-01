<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/28
 * Time: 17:34
 */

namespace app\admin\controller;


use app\admin\service\BehaviorLog;
use app\admin\service\LoginLog;

class Log extends Common {

    /**
     * 登录日志
     * @return mixed
     */
    public function getLogin(){

        if($this->request->isPost()){

            $loginLog=new LoginLog();

            $this->result=$loginLog->getList($this->params);
            return $this->_result();
        }else{
            return $this->_fetch();
        }
    }

    /**
     * 行为日志
     * @return mixed
     */
    public function getBehavior(){

        if($this->request->isPost()){

            $behaviorLog=new BehaviorLog();

            $this->result=$behaviorLog->getList($this->params);
            return $this->_result();
        }else{
            return $this->_fetch();
        }
    }

}