<?php
/**
 * Created by PhpStorm.
 * User: 乐
 * Date: 2017/7/9
 * Time: 0:17
 */

namespace app\admin\controller;



use think\Cache;

class Index extends Common {

    public function _empty(){
        parent::_empty();
    }

    public function index(){

        return $this->fetch();

    }

    public function main(){

        return $this->fetch();

    }

    public function clearCached(){

        Cache::clear();//清空缓存

        return $this->_result($this->result);
    }

}