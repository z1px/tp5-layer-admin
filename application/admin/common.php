<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/7/12
 * Time: 15:18
 */

/**
 * 处理
 * @param $data 待处理一维数组
 * @param array $filter 列表中键值如果为空则删除，否则返回null
 * @return array
 */
function params_format($data,$filter=[]){
    if(!empty($data)&&is_array($data)){
        foreach ($data as $key=>$value){
            if(is_array($value)) continue;
            $value=trim($value);
            if($value==""){
                if(in_array($key,$filter)){
                    unset($data[$key]);
                }else{
                    $data[$key]=null;
                }
            }else{
                $data[$key]=$value;
            }
        }
    }
    return $data;
}

/**
 * 数据库密码加密
 * @param $string
 * @param string $operation
 * @param string $key
 * @param int $expiry
 * @return string
 */
function auth_code($string, $operation = 'ENCODE', $key = '', $expiry = 0) {
    $ckey_length = 0;
    $key = md5($key ? $key : '9e13yK8RN2M0lKP8CLRLhGs468d1WMaSlbDeCcI');
    $keyb = md5(substr($key, 16, 16));
    $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length): substr(md5(microtime()), -$ckey_length)) : '';
    $string = $operation == 'DECODE' ? base64_decode(substr($string, $ckey_length)) : sprintf('%010d', $expiry ? $expiry + time() : 0).substr(md5($string.$keyb), 0, 16).$string;
    $string_length = strlen($string);
    $result = '';
    for($a = $j = $i = 0; $i < $string_length; $i++) {
        $a = ($a + 1) % 256;
        $j = $j % 256;
        $result .= chr(ord($string[$i]));
    }
    if($operation == 'DECODE') {
        if((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26).$keyb), 0, 16)) {
            return substr($result, 26);
        } else {
            return '';
        }
    } else {
        return $keyc.str_replace('=', '', base64_encode($result));
    }
}
