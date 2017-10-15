<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/30
 * Time: 11:37
 */

namespace app\admin\controller;


class Upload extends Common {

    /**
     * 图片上传接口
     * @return mixed
     */
    public function img(){

        if(!isset($this->params["upload"])) $this->params["upload"]=current(array_keys($_FILES));

        $file=$this->request->file($this->params["upload"]);

        if(empty($file)){
            $this->result["msg"]="没有图片在上传";
            $this->result["data"]=$_FILES;
            return $this->_result();
        }

        $path='/uploads/images/'.date("Ymd");

        $info = $file->validate(['size'=>2097152,'ext'=>'jpg,jpeg,png,gif,bmp'])->rule('uniqid')->move(SITE_DIR."public".$path,'');
        if(empty($info)){
            $this->result["msg"]=$file->getError();
        }else{
            $this->result["code"]=0;
            $this->result["msg"]="图片上传成功";
            $this->result["data"]=[
                "src"=>str_replace("admin","www",$this->request->domain()).$path."/".$info->getFilename(),
                "title"=>$info->getFilename(),
            ];
        }
        unset($file,$info,$path);

        return $this->_result();

    }

    /**
     * 文件上传接口
     * @return mixed
     */
    public function file(){

        if(!isset($this->params["upload"])) $this->params["upload"]=current(array_keys($_FILES));

        $file=$this->request->file($this->params["upload"]);

        if(empty($file)){
            $this->result["msg"]="没有图片在上传";
            $this->result["data"]=$_FILES;
            return $this->_result();
        }

        $path='/uploads/file/'.date("Ymd");

        $info = $file->rule('uniqid')->move(SITE_DIR."public".$path,'');
        if(empty($info)){
            $this->result["msg"]=$file->getError();
        }else{
            $this->result["code"]=0;
            $this->result["msg"]="文件上传成功";
            $this->result["data"]=[
                "src"=>str_replace("admin","www",$this->request->domain()).$path."/".$info->getFilename(),
                "title"=>$info->getFilename(),
            ];
        }
        unset($file,$info,$path);

        return $this->_result();

    }

}