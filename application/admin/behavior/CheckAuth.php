<?php
/**
 * Created by PhpStorm.
 * User: 乐
 * Date: 2017/7/9
 * Time: 0:21
 */

namespace app\admin\behavior;


use app\admin\controller\Common;
use app\admin\logic\AuthMenu;
use app\admin\logic\Login;
use think\Request;
use think\Url;

class CheckAuth extends Common {


    //权限检查
    public function run(){

        $request=Request::instance();

        if(strtolower($request->controller())==="demo") return true;//demo示例不需要权限验证

        $authMenu=new AuthMenu();

        $whiteAuth=$authMenu->whiteAuth();//白名单菜单，不管是否登录都可以
        if(in_array(strtolower($request->module()."/".$request->controller()."/".$request->action()),$whiteAuth)) return true;
        unset($whiteAuth);

        $this->CheckLogin();//登录状态检查

        $menuAuth=$authMenu->menuAuth();//后台菜单权限菜单
        if(in_array(strtolower($request->module()."/".$request->controller()."/".$request->action()),$menuAuth)){
            unset($menuAuth);
            return true;
        }else{
            unset($menuAuth);
            $this->result["code"]=0;
            $this->result["msg"]="无权限操作";
            $this->result["data"]="auth";
            return $this->_jump();
        }
    }

    public function CheckLogin(){

        $login=new Login();
        $this->result=$login->login_check();

        if($this->result["code"]!==1){
            return $this->_jump(Url::build("admin/Account/login"));
        }

    }

}