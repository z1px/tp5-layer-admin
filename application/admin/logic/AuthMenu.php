<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/20
 * Time: 15:55
 */

namespace app\admin\logic;


use app\admin\model\AdminGroup;
use app\admin\model\Menu;
use think\Request;
use think\Url;

class AuthMenu {

    protected $menu;
    protected $admin;
    protected $adminGroup;
    protected $login;
    //返回结果
    protected $result;

    public function __construct(){

        $this->menu=new Menu();
        $this->result=[
            "code"=>1,
            "msg"=>"data normal",
            "data"=>[],
        ];
    }

    /**
     * 白名单权限，不需要验证权限
     */
    public function whiteAuth(){

        $where=["type"=>2];
        $list=$this->menu->field("id,title,module,controller,action")->where($where)->select();
        unset($where);

        $result=[];
        if(!empty($list)){
            foreach ($list as $key=>$value){
                $result[$value->id]=strtolower($value->module."/".$value->controller."/".$value->action);
            }
            unset($key,$value);
        }
        unset($list);
        $result=array_values($result);
        if(!in_array("admin/account/login",$result)) $result[]="admin/account/login";
        if(!in_array("admin/account/logout",$result)) $result[]="admin/account/logout";

        return $result;
    }


    /**
     * 获取后台菜单
     * @return array|false|\PDOStatement|string|\think\Collection
     */
    public function getMenu(){
        $this->login=new Login();
        $this->result=$this->login->login_check();
        if($this->result["code"]==0) return [];
        $admin=$this->result["data"];
        $this->result["data"]=[];

        $where=["status"=>1,"type"=>["in",[1,2]],"pid"=>0];
        $field="id,title,module,controller,action,icon,pid";
        $order="sort desc,id asc,pid asc";
        if($admin["id"]!=1){
            $this->adminGroup=new AdminGroup();
            $group=$this->adminGroup->field("id,name,menu_id,status")->find($admin["group_id"]);
            if(empty($group)){
                return [];
//                $where["type"]=2;
            }
            if($group->status!=1) return [];//用户组被禁用，菜单为空
            $group->menu_id=trim($group->menu_id,",");
            if(empty($group->menu_id)){
                return [];
//                $where["type"]=2;
            }else{
                $where["id"]=["in",$group->menu_id];
                $order="field(id,{$group->menu_id}) desc,".$order;
            }
        }
        $field=trim($field,",");
        $order=trim($order,",");

        $list=$this->menu->field($field)->where($where)->order($order)->select();
        if(empty($list)) return [];
        foreach ($list as $key=>$value){
            $where["pid"]=$value->id;
            $children=$this->menu->field($field)->where($where)->order($order)->select();
            $list[$key]=[
                "title"=>$value->title,
                'icon' => empty($value->icon)?"":$value->icon,
                'spread' => false,
            ];
            if(empty($children)){
                $list[$key]["href"]=Url::build(''.$value->module.'/'.$value->controller.'/'.$value->action.'');
            }else{
                foreach ($children as $k=>$val){
                    $children[$k]=[
                        'title' => $val->title,
                        'icon' => empty($val->icon)?"":$val->icon,
                        'href' => Url::build(''.$val->module.'/'.$val->controller.'/'.$val->action.''),
                    ];
                }
                unset($k,$val);
                $list[$key]["children"]=$children;
            }
            unset($children);
        }
        unset($key,$value,$where);
        return $list;
    }

    /**
     * 菜单验证权限
     */
    public function menuAuth(){

        $this->login=new Login();
        $this->result=$this->login->login_check();
        if($this->result["code"]==0) return [];
        $admin=$this->result["data"];
        $this->result["data"]=[];

        if($admin["id"]==1){
            $request=Request::instance();
            return [strtolower($request->module()."/".$request->controller()."/".$request->action())];
        }
        $where=["type"=>1];
        $field="id,title,module,controller,action";

        $this->adminGroup=new AdminGroup();
        $group=$this->adminGroup->field("id,name,menu_id,status")->find($admin["group_id"]);
        if(empty($group)) return [];
        if($group->status!=1) return [];//用户组被禁用
        $group->menu_id=trim($group->menu_id,",");
        if(empty($group->menu_id)) return [];
        $where["id"]=["in",$group->menu_id];

        $field=trim($field,",");

        $list=$this->menu->field($field)->where($where)->select();
        unset($where);
        if(empty($list)) return [];

        foreach ($list as $key=>$value){
            $list[$key]=strtolower($value->module.'/'.$value->controller.'/'.$value->action);
        }
        unset($key,$value);
        return $list;
    }


}