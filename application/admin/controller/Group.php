<?php
/**
 * Created by PhpStorm.
 * User: 乐
 * Date: 2017/7/9
 * Time: 21:41
 */

namespace app\admin\controller;


use app\admin\service\AdminGroup;
use think\Url;

class Group extends Common {

    protected $adminGroup;


    public function _empty(){
        parent::_empty();
    }


    protected function _before(){
        $this->adminGroup=new AdminGroup();
    }


    /**
     * 用户组列表
     * @return mixed
     */
    public function getList(){

        if($this->request->isPost()){
            $this->result=$this->adminGroup->getList($this->params);
            return $this->_result();
        }else{
            return $this->_fetch();
        }
    }


    /**
     * 添加用户组
     */
    public function add(){
        if($this->request->isPost()){
            $this->result=$this->adminGroup->add($this->params);
            if(isset($this->result["data"]["id"])){
                $url=Url::build("admin/Group/edit",["id"=>$this->result["data"]["id"]]);
            }else{
                $url=null;
            }
            return $this->_result($url);
        }else{
            return $this->_fetch();
        }
    }

    /**
     * 修改用户组权限
     */
    public function edit(){
        if(!isset($this->params["id"])){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_jump();
        }

        if($this->request->isPost()){
            $this->result=$this->adminGroup->edit($this->params);
            if(isset($this->result["data"]["id"])){
                $url=Url::build("admin/Group/edit",["id"=>$this->result["data"]["id"]]);
            }else{
                $url=null;
            }
            return $this->_result($url);
        }else{
            $this->result=$this->adminGroup->getById($this->params["id"]);
            if($this->result["code"]==0) return $this->_jump();
            return $this->_fetch(["data"=>$this->result["data"]]);
        }
    }

    /**
     * 修改用户组状态
     */
    public function editStatus(){
        $this->result=$this->adminGroup->editStatus($this->params);
        return $this->_result();
    }

    /**
     * 删除用户组
     */
    public function del(){
        if(!isset($this->params["id"])){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_jump();
        }

        $this->result=$this->adminGroup->del($this->params["id"]);
        return $this->_jump();
    }


}