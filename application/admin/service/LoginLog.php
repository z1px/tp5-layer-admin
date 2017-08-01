<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 11:33
 */

namespace app\admin\service;


use think\Url;

class LoginLog extends \app\admin\model\LoginLog {

    //返回结果
    protected $result=[
        "code"=>1,
        "msg"=>"data normal",
        "data"=>[],
    ];


    public function getList($row){

        if(!isset($row["pageIndex"])) $row["pageIndex"]=1;
        if(!isset($row["pageSize"])) $row["pageSize"]=10;
        $where=[];
        $order="id desc";
        if(isset($row["keyword"])) $where["account"]=["like","%{$row["keyword"]}%"];
        if(isset($row["admin_id"])) $where["admin_id"]=$row["admin_id"];
        if(isset($row["sort"])){
            if(!empty($row["sort"])){
                if($row["sort"]=="status_name") $row["sort"]="status";
                if(!isset($row["order"])) $row["order"]="desc";
                $order="{$row["sort"]} {$row["order"]}";
            }
        }
        $list=$this->field("id,id copy_id,admin_id,account,ip,area,create_time")->where($where)->page($row["pageIndex"],$row["pageSize"])->order($order)->select();
        $this->result["rel"]=true;
        $this->result["count"]=$this->where($where)->Count();
        unset($row,$where);
        if(empty($list)){
            $list=[];
        }else{
            foreach ($list as $key=>$value){
                $value->account=unserialize($value->account);
                $value->username=$value->account["username"];
                $list[$key]=$value->toArray();
            }
            unset($key,$value);
        }
        $this->result["list"]=$list;
        unset($list);
        return $this->result;
    }

}