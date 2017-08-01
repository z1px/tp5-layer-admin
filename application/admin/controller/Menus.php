<?php
/**
 * Created by PhpStorm.
 * User: 乐
 * Date: 2017/7/9
 * Time: 21:41
 */

namespace app\admin\controller;


use app\admin\service\Menu;
use think\Url;

class Menus extends Common {

    protected $menu;


    public function _empty(){
        parent::_empty();
    }


    protected function _before(){
        $this->menu=new Menu();
    }


    /**
     * 菜单列表
     * @return mixed
     */
    public function getList(){

        if($this->request->isPost()){
            $this->result=$this->menu->getList($this->params);
            return $this->_result();
        }else{
            return $this->_fetch();
        }
    }


    /**
     * 添加菜单
     */
    public function add(){
        if($this->request->isPost()){
            $this->result=$this->menu->add($this->params);
            if(isset($this->result["data"]["id"])){
                $url=Url::build("admin/Menu/edit",["id"=>$this->result["data"]["id"]]);
            }else{
                $url=null;
            }
            return $this->_result($url);
        }else{
            if(!isset($this->params["pid"])) $this->params["pid"]="";
            return $this->_fetch(["menu"=>$this->menu->getMenuList(),"pid"=>$this->params["pid"]]);
        }
    }

    /**
     * 修改菜单
     */
    public function edit(){
        if(!isset($this->params["id"])){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_jump();
        }

        if($this->request->isPost()){
            $this->result=$this->menu->edit($this->params);
            if(isset($this->result["data"]["id"])){
                $url=Url::build("admin/Menu/edit",["id"=>$this->result["data"]["id"]]);
            }else{
                $url=null;
            }
            $this->result["data"]["params"]=array_filter($this->params,function ($val){if($val===''||$val===null) return false;else return true;});
            return $this->_result($url);
        }else{
            $this->result=$this->menu->getById($this->params["id"]);
            if($this->result["code"]==0) return $this->_jump();
            return $this->_fetch(["data"=>$this->result["data"],"menu"=>$this->menu->getMenuList()]);
        }
    }

    /**
     * 修改菜单状态
     */
    public function editStatus(){
        $this->result=$this->menu->editStatus($this->params);
        return $this->_result();
    }

    /**
     * 删除菜单
     */
    public function del(){
        if(!isset($this->params["id"])){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_result();
        }

        $this->result=$this->menu->del($this->params["id"]);
        return $this->_result();
    }

    /**
     * 用户组菜单授权列表
     * @return mixed
     */
    public function menuTree(){
        $group_id=isset($this->params["group_id"])?$this->params["group_id"]:"";
        $this->result=$this->menu->menuTree($group_id);
        unset($group_id);
        return $this->_result();
    }

    /**
     * 所有菜单列表
     * @return mixed
     */
    public function getAll(){

        if($this->request->isPost()){
            $this->result=$this->menu->getAll();
            return $this->_result();
        }else{
            return $this->_fetch();
        }
    }


    /**
     * 修改菜单父ID
     * @return mixed
     */
    public function editMenuPid(){
        if(!isset($this->params["id"])||!array_key_exists("pid",$this->params)){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_result();
        }

        $this->result=$this->menu->editMenuPid($this->params["id"],$this->params["pid"]);
        return $this->_result();
    }


    /**
     * 修改菜单名称
     * @return mixed
     */
    public function editMenuTitle(){
        if(!isset($this->params["id"])||!isset($this->params["title"])){
            $this->result["code"]=0;
            $this->result["msg"]="参数错误";
            return $this->_result();
        }

        $this->result=$this->menu->editMenuTitle($this->params["id"],$this->params["title"]);
        return $this->_result();
    }

}