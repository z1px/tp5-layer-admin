<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/20
 * Time: 9:22
 */

namespace app\admin\logic;


use app\admin\model\Admin;
use app\admin\model\LoginLog;
use think\Config;
use think\Cookie;
use think\Loader;

class Login {

    protected $admin;
    //返回结果
    protected $result;

    public function __construct(){

        $this->admin=new Admin();
        $this->result=[
            "code"=>1,
            "msg"=>"data normal",
            "data"=>[],
        ];
    }


    /**
     * 登录验证
     * @param $row
     * @return array
     */
    public function login($row){
        $validate = Loader::validate('Login');
        if(!$validate->check($row)){
            $this->result["code"]=0;
            $this->result["msg"]=$validate->getError();
            unset($validate);
            return $this->result;
        }
        if(!isset($row["rememberMe"])) $row["rememberMe"]=false;
        $where=[];
        if(preg_phone($row["username"])){
            $where["mobile"]=$row["username"];
        }elseif(preg_email($row["username"])){
            $where["email"]=$row["username"];
        }else{
            $where["username"]=$row["username"];
        }
        $data=$this->admin->field("id,group_id,username,password,true_name,mobile,email,status")->where($where)->find();
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="账号不存在";
            return $this->result;
        }
        if($data->password!=auth_code($row["password"],"ENCODE",Config::get('login_key'))){
            $this->result["code"]=0;
            $this->result["msg"]="账号或者密码错误！";
            return $this->result;
        }
        if($data->status!=1){
            $this->result["code"]=0;
            $this->result["msg"]="账号已被禁用";
            return $this->result;
        }
        $data->last_login_time=time();
        $data->login_key=md5(md5($data->id).$data->last_login_time);
        $res=$data->save();
        if(empty($res)){
            $this->result["code"]=0;
            $this->result["msg"]="登陆失败";
            return $this->result;
        }
        unset($res);
        Cookie::set("luck",md5(time()));
        if($row["rememberMe"]){
            Cookie::forever("login_id",$data->id);
            Cookie::forever("login_name",$data->username);
            Cookie::forever("login_key",$data->login_key);
        }else{
            Cookie::set("login_id",$data->id);
            Cookie::set("login_name",$data->username);
            Cookie::set("login_key",$data->login_key);
        }
        $this->result["msg"]="登陆成功";

        //登录日志
        $loginLog = new LoginLog();
        $loginLog->admin_id=$data->id;
        $loginLog->account=serialize($data->visible(['id','group_id','username','true_name','mobile','email'])->toArray());
        $loginLog->save();

        unset($data);

        return $this->result;
    }

    public function logout(){
        if(!Cookie::has("login_key")||!Cookie::has("login_id")||!Cookie::has("login_name")){
            Cookie::delete("luck");
            Cookie::delete("login_id");
            Cookie::delete("login_name");
            Cookie::delete("login_key");
            $this->result["code"]=0;
            $this->result["msg"]="未登录！";
            return $this->result;
        }
        Cookie::delete("luck");
        Cookie::delete("login_id");
        Cookie::delete("login_name");
        Cookie::delete("login_key");
        $this->result["msg"]="注销成功";
        return $this->result;
    }

    /**
     * 锁屏
     * @param $row
     * @return array
     */
    public function lock($row){

        Cookie::delete("luck");

        $this->result["msg"]="锁屏成功";
        return $this->result;
    }

    /**
     * 解锁锁屏
     * @param $row
     * @return array
     */
    public function unLock($row){

        if(!isset($row["password"])){
            $this->result["code"]=0;
            $this->result["msg"]="请输入解锁密码！";
            return $this->result;
        }
        if(empty($row["password"])){
            $this->result["code"]=0;
            $this->result["msg"]="请输入解锁密码！";
            return $this->result;
        }
        $this->result=$this->login_check($row["password"]);
        if($this->result["code"]==1) Cookie::set("luck",md5(time()));

        return $this->result;
    }

    /**
     * 登录验证
     * @param bool $password
     * @return array
     */
    public function login_check($password=false){
        if(!Cookie::has("login_key")||!Cookie::has("login_id")||!Cookie::has("login_name")){
            $this->result["code"]=0;
            $this->result["msg"]="请先登陆";
            return $this->result;
        }
        if(empty(Cookie::get("login_key"))||empty(Cookie::get("login_id"))||empty(Cookie::get("login_name"))){
            $this->result["code"]=0;
            $this->result["msg"]="请先登陆";
            return $this->result;
        }
        $data=$this->admin->field("id,group_id,username,true_name,mobile,email,password,status,last_login_time")->where(["login_key"=>Cookie::get("login_key")])->find();
        if(empty($data)){
            $this->result["code"]=0;
            $this->result["msg"]="登陆已过期，请重新登陆";
            return $this->result;
        }
        if($data->status!=1){
            $this->result["code"]=0;
            $this->result["msg"]="账号已被禁用";
            return $this->result;
        }
        if(!empty($password)){
            if($data->password!=auth_code($password,"ENCODE",Config::get('login_key'))){
                $this->result["code"]=0;
                $this->result["msg"]="密码错误！";
                return $this->result;
            }
        }
        if($data->id!=Cookie::get("login_id")){
            $this->result["code"]=0;
            $this->result["msg"]="登陆已过期，请重新登陆";
            return $this->result;
        }
        $this->result["msg"]="已登陆";
        $this->result["data"]=$data->hidden(['password'])->append(["group"])->toArray();
        unset($data);
        return $this->result;
    }

}