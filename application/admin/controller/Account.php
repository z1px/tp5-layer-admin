<?php
/**
 * Created by PhpStorm.
 * User: 乐
 * Date: 2017/7/9
 * Time: 21:41
 */

namespace app\admin\controller;


use app\admin\logic\Login;
use app\admin\service\Admin;
use app\admin\service\AdminGroup;
use think\Url;

class Account extends Common {

    protected $admin;
    protected $adminGroup;
    protected $login;


    public function _empty(){
        parent::_empty();
    }


    protected function _before(){
        $this->admin=new Admin();
        $this->login=new Login();
    }


    /**
     * 登陆
     * @return mixed
     */
    public function login(){

        if($this->request->isPost()){
            $this->result=$this->login->login($this->params);
            return $this->_result();
        }else{
            return $this->_fetch();
        }

    }

    /**
     * 注销
     * @return mixed
     */
    public function logout(){

        $this->result=$this->login->logout();
        return $this->_jump(Url::build("admin/Account/login"));

    }

    /**
     * 锁屏
     * @return mixed
     */
    public function lock(){
        $this->result=$this->login->lock($this->params);
        return $this->_result();
    }

    /**
     * 解锁
     * @return mixed
     */
    public function unLock(){
        $this->result=$this->login->unLock($this->params);
        return $this->_result();
    }

    public function setting(){
        return $this->_fetch();
    }

    /**
     * 修改管理员信息
     */
    public function myinfo(){

        if($this->request->isPost()){
            $this->result=$this->admin->editMyInfo($this->params);

            return $this->_jump(Url::build("admin/Account/myinfo"));
        }else{
            $this->result=$this->login->login_check();
            if($this->result["code"]==0) return $this->_jump();
            return $this->_fetch(["data"=>$this->result["data"]]);
        }
    }

    /**
     * 管理员列表
     * @return mixed
     */
    public function getList(){

        if($this->request->isPost()){
            $this->result=$this->admin->getList($this->params);
            return $this->_result();
        }else{
            return $this->_fetch();
        }
    }


    /**
     * 添加管理员
     */
    public function add(){
        if($this->request->isPost()){
            $this->result=$this->admin->add($this->params);
            if(isset($this->result["data"]["id"])){
                $url=Url::build("admin/Account/edit",["id"=>$this->result["data"]["id"]]);
            }else{
                $url=null;
            }
            return $this->_result($url);
        }else{
            $this->adminGroup=new AdminGroup();
            return $this->_fetch(["group"=>$this->adminGroup->getAll()]);
        }
    }

    /**
     * 修改管理员信息
     */
    public function edit(){
        if(!isset($this->params["id"])){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_jump();
        }

        if($this->request->isPost()){
            $this->result=$this->admin->edit($this->params);
            if(isset($this->result["data"]["id"])){
                $url=Url::build("admin/Account/edit",["id"=>$this->result["data"]["id"]]);
            }else{
                $url=null;
            }
            return $this->_result($url);
        }else{
            $this->result=$this->admin->getById($this->params["id"]);
            if($this->result["code"]==0) return $this->_jump();
            $this->adminGroup=new AdminGroup();
            return $this->_fetch(["data"=>$this->result["data"],"group"=>$this->adminGroup->getAll()]);
        }
    }

    /**
     * 修改管理员账号状态
     */
    public function editStatus(){
        $this->result=$this->admin->editStatus($this->params);
        return $this->_result();
    }

    /**
     * 删除管理员
     */
    public function del(){
        if(!isset($this->params["id"])){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_jump();
        }

        $this->result=$this->admin->del($this->params["id"]);
        return $this->_jump();
    }

}