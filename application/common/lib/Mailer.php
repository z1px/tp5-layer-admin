<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/9/26
 * Time: 17:14
 */

namespace app\common\lib;

use PHPMailer\PHPMailer\PHPMailer;
use think\Config;
use think\Lang;
use think\Request;

class Mailer {

    private $config=[
        'mail_SMTPDebug' =>0,//关闭Debug
        'mail_Host' =>'smtp.ym.163.com',//服务器地址
        'mail_SMTPAuth' =>true,//开启SMTP验证
        'mail_Username' =>'xxx@xxx.com',//SMTP 用户名（你要使用的邮件发送账号）
        'mail_Password' =>'xxx',//SMTP 密码
        'mail_SMTPSecure' =>'tls',//开启TLS 可选
        'mail_Port' =>'25',//端口
        'mail_From' =>'xxx@xxx.com',//发件人地址
        'mail_FromName' =>'xxx网',//发件人姓名
        'mail_ReplyTo' =>'xxx@xxx.com',//回复地址
        'mail_ReplyToName' =>'xxx网',//回复人姓名
        'mail_WordWrap' =>50,//设置每行字符长度
        'mail_isHTML' =>true,//设置邮件格式为HTML
        'mail_CharSet' =>'utf-8',//设置邮件编码
    ];

    protected $result;

    public function __get($name){
        if(isset($this->config[$name])) {
            return $this->config[$name];
        }
        return null;
    }

    public function __set($name,$value){
        if(isset($this->config[$name])) {
            $this->config[$name]    =   $value;
        }
    }

    public function __isset($name){
        return isset($this->config[$name]);
    }

    public function __construct($config=[]) {

        if(!empty($config)&&is_array($config)) {
            $this->config = array_merge($this->config,$config);
        }

        $this->result=[
            "code"=>1,
            "msg"=>'data normal',
            "data"=>[]
        ];

    }


    /**
     * 发送邮件
     * @param $address 收件人地址，如果需要设置收件人名称，写成一维数组形式，主键email,name
     * @param $subject 邮箱标题
     * @param $body 邮箱内容
     * @param array $cc 抄送，二维数组形式，主键email,name
     * @param array $bcc 秘密抄送，二维数组形式，主键email,name
     * @param array $attach 附件，二维数组形式，主键file,name
     * @return array
     * @throws \PHPMailer\PHPMailer\Exception
     */
    public function sendEmail($email,$subject,$body,$cc=[],$bcc=[],$attach=[]){

        if(empty($email)){
            $this->result["status"]=0;
            $this->result["msg"]="收件邮箱不能为空";
            return false;
        }
        $address=[];
        if(is_array($email)){
            $address=$email;
        }else{
            $address["email"]=$email;
        }
        unset($email);

        if(empty($subject)){
            $this->result["status"]=0;
            $this->result["msg"]="邮箱标题不能为空";
            return false;
        }
        if(empty($body)){
            $this->result["status"]=0;
            $this->result["msg"]="邮箱内容不能为空";
            return false;
        }


        $mail = new PHPMailer(true);
        // 服务器设置
        $mail->SMTPDebug = $this->mail_SMTPDebug;// 开启Debug
        $mail->isSMTP();// 使用SMTP
        $mail->Host = $this->mail_Host;// 服务器地址
        $mail->SMTPAuth = $this->mail_SMTPAuth;// 开启SMTP验证
        $mail->Username = $this->mail_Username;// SMTP 用户名（你要使用的邮件发送账号）
        $mail->Password = $this->mail_Password;// SMTP 密码
        $mail->SMTPSecure = $this->mail_SMTPSecure;// 开启TLS 可选
        $mail->Port = $this->mail_Port;// 端口

        // 收件人
        $mail->setFrom($this->mail_From,$this->mail_FromName);// 发件人地址/发件人姓名
        if(empty($address["name"]))
            $mail->addAddress($address["email"]);// 添加一个收件人,可以只传邮箱地址
        else
            $mail->addAddress($address["email"],$address["name"]);// 添加一个收件人
        $mail->addReplyTo($this->mail_ReplyTo,$this->mail_ReplyToName);// 回复地址
        if(!empty($cc)){
            foreach($cc as $key=>$value){
                $CC_NAME="";
                if(is_array($value)){
                    if(empty($value["email"])) continue;
                    $CC=$value["email"];
                    if(!empty($value["name"])) $CC_NAME=$value["name"];
                }else{
                    $CC=$value;
                }
                $mail->addCC($CC,$CC_NAME);//设置抄送，多个抄送，调用多次
                unset($key,$value,$CC,$CC_NAME);
            }
        }
        if(!empty($bcc)){
            foreach($bcc as $key=>$value){
                $BCC_NAME="";
                if(is_array($value)){
                    if(empty($value["email"])) continue;
                    $BCC=$value["email"];
                    if(!empty($value["name"])) $BCC_NAME=$value["name"];
                }else{
                    $BCC=$value;
                }
                $mail->addBCC($BCC,$BCC_NAME);//设置秘密抄送，多个秘密抄送，调用多次
                unset($key,$value,$BCC,$BCC_NAME);
            }
        }
        if(!empty($attach)){
            foreach($attach as $key=>$value){
                if(empty($value["file"])) continue;
                $attachment=$value["file"];
                if(!empty($value["name"])) $attachment.=",".$value["name"];
                $mail->addAttachment($attachment);//添加附件，可以设定名字
                unset($key,$value,$attach);
            }
        }

        // 内容
        $mail->WordWrap = $this->mail_WordWrap;// 设置每行字符长度
        $mail->isHTML($this->mail_isHTML);// 设置邮件格式为HTML
        $mail->CharSet = $this->mail_CharSet;//设置邮件编码
        $mail->Subject =$subject;//邮件主题
        $mail->Body = $body;//邮件内容
        $mail->AltBody = strip_tags($body);//邮件正文不支持HTML的备用显示

        unset($address,$subject,$body,$attach,$cc,$bcc);

        $res=$mail->send();
        if($res){
            $this->result["msg"]="邮件发送成功";
            return true;
        }else{
            $this->result["status"]=0;
            $this->result["msg"]=$mail->ErrorInfo;
//            $this->result["msg"]="邮件发送失败";
            return false;
        }
    }


    public function getResult(){
        return $this->result;
    }


}