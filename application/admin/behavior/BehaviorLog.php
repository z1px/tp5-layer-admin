<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/12
 * Time: 16:24
 */

namespace app\admin\behavior;


use app\admin\controller\Common;
use app\admin\model\Menu;
use think\Cookie;
use think\Request;

class BehaviorLog extends Common {

    public function run(&$params,$extra=[]){

        if(empty($this->request)) $this->request=Request::instance();

        if(!$this->request->isPost()&&!$this->request->isAjax()) return ;

        $allow_action=["add","edit","del","myinfo","editStatus"];
        if(!in_array($this->request->action(),$allow_action)) return ;

        $row=[
            "title"=>"",
            "module"=>$this->request->module(),
            "controller"=>$this->request->controller(),
            "action"=>$this->request->action(),
            "url"=>$this->request->url(true),
            "type"=>"",
            "params"=>serialize($this->params),
            "result"=>serialize($this->result),
            "admin_id"=>Cookie::get("login_id"),
        ];
        $menu=new Menu();
        $row["title"]=$menu->where(["module"=>$row["module"],"controller"=>$row["controller"],"action"=>$row["action"]])->value("title");
        if($this->request->isGet()){
            $row["type"][]="get";
        }elseif($this->request->isPost()){
            $row["type"][]="post";
        }elseif($this->request->isPut()){
            $row["type"][]="put";
        }elseif($this->request->isDelete()){
            $row["type"][]="delete";
        }elseif($this->request->isAjax()){
            $row["type"][]="ajax";
        }elseif($this->request->isPjax()){
            $row["type"][]="pjax";
        }elseif($this->request->isMobile()){
            $row["type"][]="mobile";
        }elseif($this->request->isHead()){
            $row["type"][]="head";
        }elseif($this->request->isPatch()){
            $row["type"][]="patch";
        }elseif($this->request->isOptions()){
            $row["type"][]="options";
        }elseif($this->request->isCli()){
            $row["type"][]="cli";
        }elseif($this->request->isCgi()){
            $row["type"][]="cgi";
        }
        $row["type"]=implode("|",$row["type"]);

        $behaviorLog=new \app\admin\model\BehaviorLog();
        $behaviorLog->save($row);
        unset($row);
    }

}