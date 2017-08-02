<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 11:33
 */

namespace app\admin\service;


use think\Cookie;
use think\Loader;
use think\Url;

class Admin extends \app\admin\model\Admin {

    //返回结果
    protected $result=[
        "code"=>1,
        "msg"=>"data normal",
        "data"=>[],
    ];

    public function editMyInfo($row){
        $row=params_format($row,["password"]);
        $row["id"]=Cookie::get("login_id");
        $validate = Loader::validate('AdminEdit');
        if(!$validate->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
            return $this->result;
        }
        if(preg_phone($row["username"])){
            $this->result["code"]=0;
            $this->result["msg"]="用户名不能是手机号";
            return $this->result;
        }
        if(preg_email($row["username"])){
            $this->result["code"]=0;
            $this->result["msg"]="用户名不能是邮箱号";
            return $this->result;
        }
        $id=$row["id"];
        unset($row["id"]);
        $data=$this->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="数据不存在，修改失败";
            return $this->result;
        }
        $res=$data->allowField(true)->save($row);
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="修改失败";
        }else{
            $this->result=$this->getById($id);
            $this->result["msg"]="修改成功";
        }
        return $this->result;
    }


    public function add($row){
        $row=params_format($row,["password"]);
        $validate = Loader::validate('AdminAdd');
        if(!$validate->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
            return $this->result;
        }
        if(preg_phone($row["username"])){
            $this->result["code"]=0;
            $this->result["msg"]="用户名不能是手机号";
            return $this->result;
        }
        if(preg_email($row["username"])){
            $this->result["code"]=0;
            $this->result["msg"]="用户名不能是邮箱号";
            return $this->result;
        }
        $this->allowField(true)->isUpdate(false)->save($row);
        if(empty($this->id)){
            $this->result["code"]=0;
            $this->result["msg"]="新增失败";
        }else{
            $this->result=$this->getById($this->id);
            $this->result["msg"]="新增成功";
        }
        return $this->result;
    }

    public function edit($row){
        $row=params_format($row,["password"]);
        $validate = Loader::validate('AdminEdit');
        if(!$validate->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
            return $this->result;
        }
        if(preg_phone($row["username"])){
            $this->result["code"]=0;
            $this->result["msg"]="用户名不能是手机号";
            return $this->result;
        }
        if(preg_email($row["username"])){
            $this->result["code"]=0;
            $this->result["msg"]="用户名不能是邮箱号";
            return $this->result;
        }
        $id=$row["id"];
        unset($row["id"]);
        $data=$this->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="数据不存在，修改失败";
            return $this->result;
        }
        if($id==1) unset($row["group_id"]);
        $res=$data->allowField(true)->save($row);
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="修改失败";
        }else{
            $this->result=$this->getById($id);
            $this->result["msg"]="修改成功";
        }
        return $this->result;
    }

    public function getById($id){
        $data=$this->field("id,group_id,username,true_name,mobile,email,status,create_time,last_login_time")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="用户不存在";
        }else{
            $data->url_edit=Url::build('admin/Account/edit',['id'=>$data->id]);
            $data->url_del=Url::build('admin/Account/del',['id'=>$data->id]);
            $this->result["data"]=$data->append(["group","status_name"])->toArray();
        }
        unset($data);
        return $this->result;
    }

    public function del($id){
        $data=$this->field("id,group_id,username,true_name,mobile,email,status")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="用户不存在";
            return $this->result;
        }
        if($id==1){
            $this->result["code"]=0;
            $this->result["msg"]="系统账号不可删除";
            return $this->result;
        }
        $res=$data->delete();
        unset($data);
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="删除失败";
        }else{
            $this->result["msg"]="删除成功";
        }
        unset($data);
        return $this->result;
    }

    public function editStatus($row){

        $validate = Loader::validate('EditStatus');
        if(!$validate->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
            return $this->result;
        }
        $id=$row["id"];
        unset($row["id"]);
        $data=$this->field("id,status")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="数据不存在，修改失败";
            return $this->result;
        }
        $res=$data->allowField(["status"])->save($row);
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="修改失败";
        }else{
            $this->result=$this->getById($id);
            $this->result["msg"]="修改成功";
        }
        return $this->result;
    }

    public function getList($row){

        if(!isset($row["pageIndex"])) $row["pageIndex"]=1;
        if(!isset($row["pageSize"])) $row["pageSize"]=10;
        $where=[];
        $order="id desc";
        if(isset($row["keyword"])) $where["username|true_name|mobile|email"]=["like","%{$row["keyword"]}%"];
        if(isset($row["status"])) $where["status"]=$row["status"];
        if(isset($row["sort"])){
            if(!empty($row["sort"])){
                if($row["sort"]=="status_name") $row["sort"]="status";
                if(!isset($row["order"])) $row["order"]="desc";
                $order="{$row["sort"]} {$row["order"]}";
            }
        }
        $list=$this->field("id,id copy_id,group_id,username,true_name,mobile,email,status,create_time,last_login_time,ip,area")->where($where)->page($row["pageIndex"],$row["pageSize"])->order($order)->select();
        $this->result["rel"]=true;
        $this->result["count"]=$this->where($where)->Count();
        unset($row,$where);
        if(empty($list)){
            $list=[];
        }else{
            foreach ($list as $key=>$value){
                $value->last_login_time=date("Y-m-d H:i:s",$value->last_login_time);
                $list[$key]=$value->append(["group","status_name"])->toArray();
                $list[$key]["url_edit"]=Url::build('admin/Account/edit',['id'=>$value->id]);
                $list[$key]["url_del"]=Url::build('admin/Account/del',['id'=>$value->id]);
            }
            unset($key,$value);
        }
        $this->result["list"]=$list;
        unset($list);
        return $this->result;
    }

}