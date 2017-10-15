<?php
/**
 * Created by PhpStorm.
 * User: 乐
 * Date: 2017/7/10
 * Time: 21:02
 */

namespace app\admin\controller;


use app\admin\logic\Login;
use think\Config;
use think\Controller;
use think\Cookie;
use think\exception\HttpException;
use think\Request;

class Common extends Controller {

    //返回结果
    protected $result=[
        "code"=>1,
        "msg"=>"data normal",
        "data"=>[],
    ];
    //请求参数
    protected $params;
    //请求信息
    protected $request;
    //当前用户信息
    public $account;

    public function _empty(){
        // 抛出HTTP异常 并发送404状态码
        throw new HttpException(404,'method not exists');
    }

    protected $beforeActionList = [
        '_verify',
        '_before',
    ];

    /**
     * 验证
     * @return array
     */
    protected function _verify(){

        if(empty($this->request)) $this->request=Request::instance();
        if(empty($this->params)) $this->params=params_format($this->request->param());

        if($this->request->isGet()){
            if(empty($this->account)){
                $login=new Login();
                $result=$login->login_check();
                $this->account=$result["data"];
                unset($result);
            }
        }
        $this->assign("account",$this->account);
        $this->assign("luck",Cookie::has("luck"));

    }

    protected function _before(){

    }

    /**
     * 返回json结果
     * @param int $code
     * @return mixed
     */
    protected function _result() {

        Config::set('default_return_type','json');

        unset($this->params,$this->request);

        return $this->result;
    }

    /**
     * 返回结果
     * @param int $code
     * @return mixed
     */
    protected function _fetch($fetch=[]) {

        Config::set('default_return_type','html');

        unset($this->params,$this->request,$this->result);

        return $this->fetch("",$fetch);
    }

    /**
     * 返回结果
     * @param int $code
     * @return mixed
     */
    protected function _jump($url=null) {

        Config::set('default_return_type','html');

        unset($this->params,$this->request);

        if($this->result["code"]==1){
            $this->success($this->result["msg"],$url,$this->result["data"]);
        }else{
            $this->error($this->result["msg"],$url,$this->result["data"]);
        }
    }

}