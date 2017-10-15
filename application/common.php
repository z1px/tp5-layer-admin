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


/**
 * 检测手机格式
 * @param $phone
 * @return bool
 */
function check_phone($phone) {
    preg_match('/^1[34578][0-9]{9}$/', $phone, $matches);
    if (empty($matches))
        return false;
    else
        return true;
}

/**
 * 检测邮箱格式
 * @param $email
 * @return bool
 */
function check_email($email) {
    preg_match('/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i', $email, $matches);
    if (empty($matches))
        return false;
    else
        return true;
}

/**
 * 检验身份证号码格式
 * @param $id
 * @return bool
 */
function check_idcard($id){
    $id = strtoupper($id);
    $regx = "/(^\d{15}$)|(^\d{17}([0-9]|X)$)/";
    $arr_split = array();
    if(!preg_match($regx, $id)){
        return false;
    }
    if(15==strlen($id)){ //检查15位
        $regx = "/^(\d{6})+(\d{2})+(\d{2})+(\d{2})+(\d{3})$/";
        @preg_match($regx, $id, $arr_split);
        //检查生日日期是否正确
        $dtm_birth = "19".$arr_split[2] . '/' . $arr_split[3]. '/' .$arr_split[4];
        if(!strtotime($dtm_birth)){
            return false;
        } else {
            return true;
        }
    }else{    //检查18位
        $regx = "/^(\d{6})+(\d{4})+(\d{2})+(\d{2})+(\d{3})([0-9]|X)$/";
        @preg_match($regx, $id, $arr_split);
        $dtm_birth = $arr_split[2] . '/' . $arr_split[3]. '/' .$arr_split[4];
        if(!strtotime($dtm_birth)){ //检查生日日期是否正确
            return false;
        }else{
            //检验18位身份证的校验码是否正确。
            //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
            $arr_int = array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
            $arr_ch = array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
            $sign = 0;
            for ( $i = 0; $i < 17; $i++ ){
                $b = (int) $id{$i};
                $w = $arr_int[$i];
                $sign += $b * $w;
            }
            $n = $sign % 11;
            $val_num = $arr_ch[$n];
            if ($val_num != substr($id,17, 1)) {
                return false;
            }else{//phpfensi.com
                return true;
            }
        }
    }

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
    curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,$_SERVER["HTTP_HOST"]);//1.检查服务器SSL证书中是否存在一个公用名。公用名通常就是申请SSL证书的域名或子域名。2.检查公用名是否存在，并且是否与提供的主机名匹配。
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


/**
 * post提交不取返回结果
 * @param $url
 * @param $query
 * @param bool $header
 * @return bool
 */
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
    $data_sign=empty($data)?"":http_build_query($data);
    $sign=md5($data_sign.$key);
    unset($data,$key,$data_sign);
    return $sign;
}


/**
 * 通过新浪接口获取IP城市
 * @param $ip
 * @return bool|string
 */
function get_ip_area($ip){
    if(empty($ip)) return false;
    $url='http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip='.$ip;
    $ch=curl_init($url);
    curl_setopt($ch,CURLOPT_ENCODING,'utf8');
    curl_setopt($ch,CURLOPT_TIMEOUT,10);
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);//获取数据返回
    $location=curl_exec($ch);
    curl_close($ch);
    $location=json_decode($location,true);
    $result="";
    if(!empty($location["province"])) $result.=" ".$location["province"];
    if(!empty($location["city"])) $result.=" ".$location["city"];
    if(!empty($location["district"])) $result.=" ".$location["district"];
    if(!empty($location["isp"])) $result.=" ".$location["isp"];
    return trim($result);
}


/*
 * authcode加密函数
 * 函数authcode($string, $operation, $key, $expiry)中的$string：字符串，明文或密文；$operation：DECODE表示解密，其它表示加密；$key：密匙；$expiry：密文有效期。
 *
 * 使用方法
 * $str = 'abcdef';
 * $key = 'www.helloweba.com';
 * echo authcode($str,'ENCODE',$key,0); //加密
 * $str = '56f4yER1DI2WTzWMqsfPpS9hwyoJnFP2MpC8SOhRrxO7BOk';
 * echo authcode($str,'DECODE',$key,0); //解密
 */

function authcode($string, $operation = 'DECODE', $key = '', $expiry = 0) {
    // 动态密匙长度，相同的明文会生成不同密文就是依靠动态密匙
    $ckey_length = 4;

    if ($operation == 'DECODE') {
        $string = str_replace(array("-", "_"), array("+", "/"), $string); //将密文中的’-‘和’_‘转换回来
    }

    // 密匙
    $key = md5($key?$key:Config::get('authcode_auth_key'));

    // 密匙a会参与加解密
    $keya = md5(substr($key, 0, 16));
    // 密匙b会用来做数据完整性验证
    $keyb = md5(substr($key, 16, 16));
    // 密匙c用于变化生成的密文
    $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length) :
        substr(md5(microtime()), -$ckey_length)) : '';
    // 参与运算的密匙
    $cryptkey = $keya . md5($keya . $keyc);
    $key_length = strlen($cryptkey);
    // 明文，前10位用来保存时间戳，解密时验证数据有效性，10到26位用来保存$keyb(密匙b)，
    //解密时会通过这个密匙验证数据完整性
    // 如果是解码的话，会从第$ckey_length位开始，因为密文前$ckey_length位保存 动态密匙，以保证解密正确
    $string = $operation == 'DECODE' ? base64_decode(substr($string, $ckey_length)) :
        sprintf('%010d', $expiry ? $expiry + time() : 0) . substr(md5($string . $keyb), 0, 16) . $string;
    $string_length = strlen($string);
    $result = '';
    $box = range(0, 255);
    $rndkey = array();
    // 产生密匙簿
    for ($i = 0; $i <= 255; $i++) {
        $rndkey[$i] = ord($cryptkey[$i % $key_length]);
    }
    // 用固定的算法，打乱密匙簿，增加随机性，好像很复杂，实际上对并不会增加密文的强度
    for ($j = $i = 0; $i < 256; $i++) {
        $j = ($j + $box[$i] + $rndkey[$i]) % 256;
        $tmp = $box[$i];
        $box[$i] = $box[$j];
        $box[$j] = $tmp;
    }
    // 核心加解密部分
    for ($a = $j = $i = 0; $i < $string_length; $i++) {
        $a = ($a + 1) % 256;
        $j = ($j + $box[$a]) % 256;
        $tmp = $box[$a];
        $box[$a] = $box[$j];
        $box[$j] = $tmp;
        // 从密匙簿得出密匙进行异或，再转成字符
        $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
    }
    if ($operation == 'DECODE') {
        // 验证数据有效性，请看未加密明文的格式
        if ((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) &&
            substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16)) {
            return substr($result, 26);
        } else {
            return '';
        }
    } else {
        // 把动态密匙保存在密文里，这也是为什么同样的明文，生产不同密文后能解密的原因
        // 因为加密后的密文可能是一些特殊字符，复制过程可能会丢失，所以用base64编码
        $result = $keyc . str_replace('=', '', base64_encode($result));
        $result = str_replace(array("+", "/"), array("-", "_"), $result); //将密文中的’+‘和’/‘转换掉，防止影响地址
        return $result;
    }
}

/**
 * 加密压缩函数
 * @param $str
 * @param bool $operation
 * @param bool $zip
 * @return bool|string
 */
function compression($str,$operation=true,$zip=true){

    $arr = ['0', '1', '2', '3', '4', '5', '6', '7', '8',
        '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
        'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y',
        'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
        'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
        'Z', '*', '!' ,'/', '+', '=','#'
    ];
    if($operation){
        if(is_array($str)) $str=json_encode($str);
        $str = base64_encode($str);
        $encode = function () use ($str,$arr){
            if ($str == null) return "";

            $rsstr = "x";
            $toarr = str_split($str);
            $arrlenght = count($arr);
            for ($i=0;$i<count($toarr);$i++) {
                $string = ord($toarr[$i]) + ord($arr[$i % $arrlenght]);
                $rsstr .= $string."_";
            }

            $rsstr = substr($rsstr,0,-1);
            $rsstr .= "y";
            return $rsstr;
        };
        $str=$encode();
        if($zip){
            try{
                $str = gzencode($str,9);
            }catch(\Exception $e){
                return "";
            }
        }
        unset($arr,$zip);
    }else{
        if(!function_exists("gzdecode")){// 兼容php5.4之前的版本
            function gzdecode($str){
                return gzinflate(substr($str,10,-8));
            }
        }
        if($zip){
            try{
                $str = gzdecode($str);
            }catch(\Exception $e){
                return "";
            }
        }
        $encode = function () use ($str,$arr){
            if ($str == '') return '';

            $first = substr($str,0,1);
            $end = substr($str,-1);

            if ($first == 'x' && $end == 'y') {
                $str = substr($str,1,-1);
                $toarr = explode("_",$str);
                $arrlenght = count($arr);
                $rsstr = '';
                for ($i=0;$i<count($toarr);$i++) {
                    $string = $toarr[$i] - ord($arr[$i % $arrlenght]);
                    $rsstr .= chr($string);
                }
                return $rsstr;
            } else {
                return "";
            }
        };
        $str = $encode();
        $str = base64_decode($str);
        unset($arr,$zip);
        if(!empty($str)) $str=json_decode($str,true)?json_decode($str,true):$str;
    }
    return $str;
}


