<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 11:33
 */

namespace app\admin\service;


use think\Loader;
use think\Url;

class Menu extends \app\admin\model\Menu {

    //返回结果
    protected $result=[
        "code"=>1,
        "msg"=>"data normal",
        "data"=>[],
    ];


    public function add($row){

        $validate = Loader::validate('MenuAdd');
        if(!$validate->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
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

        $validate = Loader::validate('MenuEdit');
        if(!$validate->check($row)){
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

    public function getById($id){
        $data=$this->field("id,title,module,controller,action,icon,sort,type,status,pid")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="菜单不存在";
        }else{
            $data->url_edit=Url::build('admin/Menus/edit',['id'=>$data->id]);
            $data->url_del=Url::build('admin/Menus/del',['id'=>$data->id]);
            $this->result["data"]=$data->append(["type_name","status_name","ptitle"])->toArray();
        }
        unset($data);
        return $this->result;
    }

    public function del($id){
        $data=$this->field("id,title,module,controller,action,icon,sort,type,status,pid")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="菜单不存在";
            return $this->result;
        }
        $check=$this->where(["pid"=>$id])->count();
        if($check>0){
            $this->result["code"]=0;
            $this->result["msg"]="子菜单存在，禁止删除";
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
        if(isset($row["status"])) $where["status"]=$row["status"];
        if(isset($row["type"])) $where["type"]=$row["type"];
        if(isset($row["sort"])){
            if(!empty($row["sort"])){
                if($row["sort"]=="status_name") $row["sort"]="status";
                if($row["sort"]=="type_name") $row["sort"]="type";
                if(!isset($row["order"])) $row["order"]="desc";
                $order="{$row["sort"]} {$row["order"]}";
            }
        }
        $list=$this->field("id,id copy_id,title,module,controller,action,icon,sort,type,status,pid")->where($where)->page($row["pageIndex"],$row["pageSize"])->order($order)->select();
        $this->result["rel"]=true;
        $this->result["count"]=$this->where($where)->Count();
        unset($row,$where);
        if(empty($list)){
            $list=[];
        }else{
            foreach ($list as $key=>$value){
                $value->url=Url::build("{$value["module"]}/{$value["controller"]}/{$value["action"]}");
                $list[$key]=$value->append(["type_name","status_name","ptitle"])->toArray();
                $list[$key]["url_edit"]=Url::build('admin/Menus/edit',['id'=>$value->id]);
                $list[$key]["url_del"]=Url::build('admin/Menus/del',['id'=>$value->id]);
            }
            unset($key,$value);
        }
        $this->result["list"]=$list;
        unset($list);
        return $this->result;
    }

    /**
     * 菜单增加修改时选择上级菜单
     * @param int $status 菜单状态，0-全部，1-展示，2-不展示
     */
    public function getMenuList($status=0,$pid=0,$prefix=""){
        $where=[/*"type"=>1,*/"pid"=>$pid];
        if(in_array($status,[1,2])) $where["status"]=$status;
        $list=$this->field("id,title,module,controller,action,icon,sort,type,status,pid")->where($where)->order("sort desc,id asc")->select();
        $result=[];
        if(!empty($list)){
            foreach ($list as $key=>$value){
                $value->title=$prefix.$value->title;
                if(!empty($value->pid)) $value->url=Url::build("{$value["module"]}/{$value["controller"]}/{$value["action"]}");
                $result[]=$value->append(["type_name","status_name","ptitle"])->toArray();
                if(empty($value->pid)) {
                    $temp=self::getMenuList($status,$value->id,"|---");
                    if(!empty($temp)) $result=array_merge($result,$temp);
                    unset($temp);
                }
            }
        }
        return $result;
    }


    /**
     * 用户组菜单授权列表
     */
    public function menuTree($group_id=""){
        $list=$this->where(["type"=>1])->order("sort desc,id asc")->column("id,title,pid","id");
        if(!empty($list)){
            if(!empty($group_id)){
                $adminGroup=new AdminGroup();
                $menu_ids=$adminGroup->where(["id"=>$group_id])->value("menu_id");
                $menu_ids=explode(",",$menu_ids);
                unset($adminGroup);
            }else{
                $menu_ids=[];
            }
            unset($group_id);
            foreach ($list as $key=>$value){
                if(empty($value["pid"])){
                    $list[$key]["open"]=true;
                }else{
                    if(!isset($list[$key]["open"])) $list[$key]["open"]=false;
                    $list[$value["pid"]]["open"]=true;
                }
                if(in_array($value["id"],$menu_ids)){
                    $list[$key]["checked"]=true;
                }else{
                    $list[$key]["checked"]=false;
                }
            }
            unset($key,$value);
        }
        return array_values($list);
    }


    /**
     * 所有菜单列表
     */
    public function getAll(){
        $list=$this->order("sort desc,id asc")->column("id,title,pid","id");
        if(!empty($list)){
            foreach ($list as $key=>$value){
                if(empty($value["pid"])){
                    $list[$key]["open"]=true;
                }else{
                    if(!isset($list[$key]["open"])) $list[$key]["open"]=false;
                    $list[$value["pid"]]["open"]=true;
                }
            }
            unset($key,$value);
        }
        return array_values($list);
    }


    /**
     * 修改菜单父ID
     * @param $id
     * @param $pid
     * @return array
     */
    public function editMenuPid($id,$pid){

        if(empty($id)||!is_numeric($id)){
            $this->result["code"]=0;
            $this->result["msg"]="ID必须为大于0的整数";
            return $this->result;
        }
        if(empty($pid)) $pid=0;
        if(!is_numeric($pid)){
            $this->result["code"]=0;
            $this->result["msg"]="PID必须为整数";
            return $this->result;
        }

        $data=$this->field("id,pid")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="数据不存在，修改失败";
            return $this->result;
        }
        if($data->pid==$pid){
            $this->result["code"]=0;
            $this->result["msg"]="没有数据要被改变，修改失败";
            return $this->result;
        }
        $data->pid=$pid;
        $res=$data->save();
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="移动失败";
        }else{
            $this->result["msg"]="移动成功";
        }
        return $this->result;
    }


    /**
     * 修改菜单名称
     * @param $id
     * @param $pid
     * @return array
     */
    public function editMenuTitle($id,$title){

        if(empty($id)||!is_numeric($id)){
            $this->result["code"]=0;
            $this->result["msg"]="ID必须为大于0的整数";
            return $this->result;
        }
        if(empty($title)){
            $this->result["code"]=0;
            $this->result["msg"]="标题不能为空";
            return $this->result;
        }

        $data=$this->field("id,title")->find($id);
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="数据不存在，修改失败";
            return $this->result;
        }
        $data->title=$title;
        $res=$data->save();
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="修改成功";
        }else{
            $this->result["msg"]="修改成功";
        }
        return $this->result;
    }

}