<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 11:33
 */

namespace app\admin\service;


use \app\admin\model\AdminGroup as AdminGroupModel;
use think\Loader;
use think\Url;

class AdminGroup extends AdminGroupModel {


    public function add($row){

        $validate = Loader::validate('Group');
        if(!$validate->scene("add")->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
            return $this->result;
        }
        if(array_key_exists("menu_id",$row)){
            if(is_array($row["menu_id"])){
                $row["menu_id"]=implode(",",$row["menu_id"]);
            }else{
                $row["menu_id"]=trim($row["menu_id"],",");
            }
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

        $validate = Loader::validate('Group');
        if(!$validate->scene("edit")->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
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
        if(array_key_exists("menu_id",$row)){
            if(is_array($row["menu_id"])){
                $row["menu_id"]=implode(",",$row["menu_id"]);
            }else{
                $row["menu_id"]=trim($row["menu_id"],",");
            }
        }
        $res=$data->allowField(true)->save($row);
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="修改失败";
        }else{
//            $this->result=$this->getById($id);
            $this->result["msg"]="修改成功";
        }
        return $this->result;
    }

    public function editStatus($row){

        $validate = Loader::validate('Group');
        if(!$validate->scene("edit_status")->check($row)){
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
        $res=$data->allowField(["status","update_time"])->save($row);
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
        $data=$this->field("id,name,menu_id,status,create_time,update_time")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="用户组不存在";
        }else{
            $data->url_edit=Url::build('admin/Group/edit',['id'=>$data->id]);
            $data->url_del=Url::build('admin/Group/del',['id'=>$data->id]);
            $this->result["data"]=$data->append(["status_name"])->toArray();
        }
        unset($data);
        return $this->result;
    }

    public function del($id){
        $data=$this->field("id,name,menu_id,status,create_time,update_time")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="用户组不存在";
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

    public function getList($row){

        if(!isset($row["pageIndex"])) $row["pageIndex"]=1;
        if(!isset($row["pageSize"])) $row["pageSize"]=10;
        $where=[];
        $order="id desc";
        if(isset($row["keyword"])) $where["name"]=["like","%{$row["keyword"]}%"];
        array_map(function ($value) use (&$where,$row){
            if(isset($row[$value])) $where[$value]=$row[$value];
        },
            ["name","status"]
        );
        if(isset($row["sort"])){
            if(!empty($row["sort"])){
                if($row["sort"]=="status_name") $row["sort"]="status";
                $order="{$row["sort"]} {$row["order"]}";
            }
        }
        $list=$this->field("id,id copy_id,name,menu_id,status,create_time,update_time")->where($where)->page($row["pageIndex"],$row["pageSize"])->order($order)->select();
        $this->result["rel"]=true;
        $this->result["count"]=$this->where($where)->Count();
        unset($row,$where);
        if(empty($list)){
            $list=[];
        }else{
            foreach ($list as $key=>$value){
                $list[$key]=$value->append(["status_name"])->toArray();
                $list[$key]["url_edit"]=Url::build('admin/Group/edit',['id'=>$value->id]);
                $list[$key]["url_del"]=Url::build('admin/Group/del',['id'=>$value->id]);
            }
            unset($key,$value);
        }
        $this->result["list"]=$list;
        unset($list);
        return $this->result;
    }


    public function getAll(){
        $list=$this->order("id asc")->column("id,name,status","id");
        return array_values($list);
    }

}