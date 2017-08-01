<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/19
 * Time: 8:35
 */

namespace app\admin\controller;


class Test {

    public function index(){
        $data=[
            "a"=>0,
            "b"=>"0",
            "c"=>"",
            "d"=>null,
            "e"=>false,
            "f"=>true,
            "g"=>"1",
            "h"=>1,
            "i"=>"  qq",
            "j"=>"qq  ",
            "k"=>"  qq  ",
            "l"=>"qq",
            "m"=>"qq",
            "n"=>"qq",
        ];
        dump($data);
        dump(params_format($data,["a","c"]));
        dump(params_format($data));
    }

}