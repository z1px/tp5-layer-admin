<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/14
 * Time: 11:33
 */

namespace app\admin\service;


use \app\admin\model\LoginLog as LoginLogModel;

class LoginLog extends LoginLogModel {


    public function getList($row){

        if(!isset($row["pageIndex"])) $row["pageIndex"]=1;
        if(!isset($row["pageSize"])) $row["pageSize"]=10;
        $where=[];
        $order="id desc";
        if(isset($row["keyword"])) $where["account"]=["like","%{$row["keyword"]}%"];
        array_map(function ($value) use (&$where,$row){
            if(isset($row[$value])) $where[$value]=$row[$value];
        },
            ["admin_id"]
        );
        if(isset($row["admin_id"])) $where["admin_id"]=$row["admin_id"];
        if(isset($row["sort"])){
            if(!empty($row["sort"])){
                if($row["sort"]=="status_name") $row["sort"]="status";
                $order="{$row["sort"]} {$row["order"]}";
            }
        }
        if(!isset($row["begin_time"])) $row["begin_time"]="";
        if(!isset($row["end_time"])) $row["end_time"]="";
        if(!empty($row["begin_time"])&&empty($row["end_time"])){
            $where["create_time"]=["egt",strtotime($row["begin_time"]." 00:00:00")];
        }elseif(empty($row["begin_time"])&&!empty($row["end_time"])){
            $where["create_time"]=["elt",strtotime($row["end_time"]." 23:59:59")];
        }elseif(!empty($row["begin_time"])&&!empty($row["end_time"])){
            $where["create_time"]=["between",[strtotime($row["begin_time"]." 00:00:00"),strtotime($row["end_time"]." 23:59:59")]];
        }

        $list=$this->field("id,id copy_id,admin_id,account,ip,area,create_time")->where($where)->page($row["pageIndex"],$row["pageSize"])->order($order)->select();
        $this->result["rel"]=true;
        $this->result["count"]=$this->where($where)->Count();
        unset($row,$where);
        if(empty($list)){
            $list=[];
        }else{
            foreach ($list as $key=>$value){
                if(!empty($value->account)) $value->account=json_decode($value->account,true);
                $value->username=isset($value->account["username"])?$value->account["username"]:"";
                if(!empty($value->account)) $value->account="<pre>".var_export($value->account,true)."</pre>";
                $list[$key]=$value->toArray();
            }
            unset($key,$value);
        }
        $this->result["list"]=$list;
        unset($list);
        return $this->result;
    }

}