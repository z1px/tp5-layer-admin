<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/28
 * Time: 17:37
 */

namespace app\admin\service;


class BehaviorLog extends \app\admin\model\BehaviorLog {

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
        if(isset($row["keyword"])) $where["params|result"]=["like","%{$row["keyword"]}%"];
        if(isset($row["params"])) $where["params"]=["like","%{$row["params"]}%"];
        if(isset($row["result"])) $where["result"]=["like","%{$row["result"]}%"];
        if(isset($row["module"])) $where["module"]=$row["module"];
        if(isset($row["controller"])) $where["controller"]=$row["controller"];
        if(isset($row["action"])) $where["action"]=$row["action"];
        if(isset($row["type"])) $where["type"]=$row["type"];
        if(isset($row["admin_id"])) $where["admin_id"]=$row["admin_id"];
        if(isset($row["sort"])){
            if(!empty($row["sort"])){
                if($row["sort"]=="status_name") $row["sort"]="status";
                if(!isset($row["order"])) $row["order"]="desc";
                $order="{$row["sort"]} {$row["order"]}";
            }
        }
        $list=$this->field("id,id copy_id,admin_id,title,module,controller,action,url,type,params,result,ip,area,create_time")->where($where)->page($row["pageIndex"],$row["pageSize"])->order($order)->select();
        $this->result["rel"]=true;
        $this->result["count"]=$this->where($where)->Count();
        unset($row,$where);
        if(empty($list)){
            $list=[];
        }else{
            foreach ($list as $key=>$value){
                $list[$key]=$value->append(["username"])->toArray();
                $list[$key]["params"]=unserialize($list[$key]["params"]);
                $list[$key]["result"]=unserialize($list[$key]["result"]);
            }
            unset($key,$value);
        }
        $this->result["list"]=$list;
        unset($list);
        return $this->result;
    }

}