<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/20
 * Time: 15:53
 */

$start_time = microtime(true);
echo date("Y-m-d H:i:s");
$i=0;
do{
    index();
    $i++;
}while($i<=1000000);
echo date("Y-m-d H:i:s");
$end_time = microtime(true);
echo '循环执行时间为：'.($end_time-$start_time).' s';

function index(){
    $url="http://localhost:6364/submit/login";
    $data=[
        "platform_id"=>rand(1,99999999),
        "game_id"=>1,
        "app_id"=>11111111,
        "tname"=>111,
        "token"=>md5("111"),
    ];
    $header=[
        "sign"=>"sign111",
        "ddd-fff"=>"ddddddd",
        "gggg_eeee"=>"dddddddddddd4444",
        "gggg-eeeedddddd"=>"eeedd2342",
    ];
    var_export($url);
    var_export($data);
    var_export($header);
    $result=curl_request($url,$data,$header,"get");
    var_export($result);
//    $result=curl_request($url,$data,$header,"post");
//    var_export($result);
//    $result=curl_request($url,$data,$header,"json");
//    var_export($result);
}


/**
 * curl请求
 * @param $url 请求地址
 * @param $data 提交数据
 * @param bool $headers 请求头设置
 * @param bool $method 提交方式【get|post|json】
 * @return mixed
 */
function curl_request($url,$data,$headers=[],$method="json"){

    if(!function_exists('curl_init')){
//        throw new Exception('Do not support CURL function.');
        return false;
    }

    $header=[];
    switch ($method){
        case "json":
            $data=is_array($data)?json_encode($data):$data;
            $header[]="Content-Type:application/json;charset=utf-8";
            $header[]="Content-Length:".strlen($data);
            $post=true;
            break;
        case "get";
            if(is_array($data)) $data=http_build_query($data);
            $post=false;
            if(!empty($data)) $url.=(strstr($url,"?")?"&":"?").$data;
            break;
        case "post";
            if(is_array($data)) $data=http_build_query($data);
            $post=true;
            break;
        default :
            if(is_array($data)) $data=http_build_query($data);
            $post=false;
    }
    if(!empty($headers)&&is_array($headers)){
        foreach($headers as $key=>$value){
            $header[]=$key.":".$value;
        }
    }
    $user_agent=isset($_SERVER["HTTP_USER_AGENT"])?$_SERVER["HTTP_USER_AGENT"]:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36";
    $timeout=20;

    $ch = curl_init();//初始化curl
    curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false); //禁止cURL验证证书
    if(isset($_SERVER["HTTP_HOST"])) curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,$_SERVER["HTTP_HOST"]);//1.检查服务器SSL证书中是否存在一个公用名。公用名通常就是申请SSL证书的域名或子域名。2.检查公用名是否存在，并且是否与提供的主机名匹配。
    curl_setopt($ch,CURLOPT_URL,$url);//抓取指定网页
    if($post) curl_setopt($ch,CURLOPT_POST,$post);//post提交方式
    curl_setopt($ch,CURLOPT_USERAGENT,$user_agent);//用户代理 User Agent
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);//要求结果为字符串且输出到屏幕上，如果把这行注释掉的话就会直接输出
    curl_setopt($ch,CURLOPT_NOBODY,false);//不显示body
    curl_setopt($ch,CURLOPT_HEADER,false);//设置header
    curl_setopt($ch,CURLOPT_HTTPHEADER,$header);//请求头设置
    curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,$timeout);//超时设置
    curl_setopt($ch,CURLOPT_FOLLOWLOCATION,true);//根据服务器返回 HTTP 头中的"Location:"重定向
    curl_setopt($ch,CURLOPT_MAXREDIRS,3);//最大重定向次数
    if($post) curl_setopt($ch,CURLOPT_POSTFIELDS,$data);//提交数据
    if (function_exists('curl_file_create')){
        curl_setopt($ch,CURLOPT_SAFE_UPLOAD,true);
    }else {
        if (defined('CURLOPT_SAFE_UPLOAD')){
            curl_setopt($ch,CURLOPT_SAFE_UPLOAD,false);
        }
    }
    $response = curl_exec($ch);//运行curl
    /*if(curl_errno($ch)){
        //error
        return curl_error($ch);
    }*/
    //$httpCode=curl_getinfo($ch,CURLINFO_HTTP_CODE);//状态码
    curl_close($ch);
    $result=json_decode($response,true)?json_decode($response,true):$response;
    unset($url,$data,$headers,$header,$timeout,$user_agent,$post,$method,$response);
    return $result;
}