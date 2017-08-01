<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件


//json提交
function curl_post_json($url,$data,$headers=false){

    if(!function_exists('curl_init')){
//        throw new Exception('Do not support CURL function.');
        die();
    }

    $data=is_array($data)?json_encode($data):$data;
    $header=array(
        'Content-Type:application/json;charset=utf-8',
        'Content-Length:'.strlen($data),
    );
    if(!empty($headers)&&is_array($headers)){
        foreach($headers as $key=>$value){
            $header[]=$key.":".$value;
        }
    }
    $timeout=20;

    $ch=curl_init();
    curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false);//禁止cURL验证证书
    if(isset($_SERVER["HTTP_HOST"])) curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,$_SERVER["HTTP_HOST"]);//1.检查服务器SSL证书中是否存在一个公用名。公用名通常就是申请SSL证书的域名或子域名。2.检查公用名是否存在，并且是否与提供的主机名匹配。
    curl_setopt($ch,CURLOPT_URL,$url);//抓取指定网页
    curl_setopt($ch,CURLOPT_POST,true);//post提交方式
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);//要求结果为字符串且输出到屏幕上，如果把这行注释掉的话就会直接输出
    curl_setopt($ch,CURLOPT_NOBODY,false);//不显示body
    curl_setopt($ch,CURLOPT_HEADER,false);//设置header
    curl_setopt($ch,CURLOPT_HTTPHEADER,$header);//请求头设置
    curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,$timeout);//超时设置
    curl_setopt($ch,CURLOPT_FOLLOWLOCATION,false);//根据服务器返回 HTTP 头中的"Location:"重定向
    curl_setopt($ch,CURLOPT_MAXREDIRS,3);//最大重定向次数
    curl_setopt($ch,CURLOPT_POSTFIELDS,$data);//提交数据
    $response=curl_exec($ch);//运行curl
    /*if(curl_errno($ch)){
        //error
        return curl_error($ch);
    }*/
    //$httpCode=curl_getinfo($ch,CURLINFO_HTTP_CODE);//状态码
    curl_close($ch);
//    $result=json_decode($response,true);
    unset($url,$data,$headers,$header,$timeout);
    return $response;
}

//post提交不取返回结果
function sock_post($url,$query,$header=false){
    $info = parse_url($url);
    if(is_array($query)) $query=http_build_query($query);
    $port=isset($info["port"])?$info["port"]:80;
    $fp = @fsockopen($info["host"],$port, $errno, $errstr, 1);
//    if(empty($fp)) return "Failed to open socket to localhost";
    if(empty($fp)) return false;
    fputs($fp,"POST ".$info['path']."?".$query." HTTP/1.0\r\n");
    fputs($fp,"Host: ".$info['host']."\r\n");
    fputs($fp,"Referer: http://".$info['host'].$info['path']."\r\n");
    fputs($fp,"Content-type: application/x-www-form-urlencoded\r\n");
    fputs($fp,"Content-Length: ".strlen(trim($query))."\r\n");
    if(!empty($header)&&is_array($header)){
        foreach($header as $key=>$value){
            fputs($fp,$key.":".$value."\r\n");
        }
    }
    fputs($fp,"\r\n");
    fputs($fp,trim($query));
//    while (!feof($fp)){
//        $line = fread($fp,4096);
//        return $line;
//    }
    fclose($fp);
    unset($url,$query,$port);
    return true;
}


/**
 * 签名生成
 * @param $data
 * @param $key
 * @return string
 */
function get_sign($data,$key){
    if(!empty($data)&&is_array($data)){
        ksort($data);//按照主键升序排序
    }
    $data_sign=http_build_query($data);
    $sign=md5($data_sign.$key);
    unset($data,$key,$data_sign);
    return $sign;
}
