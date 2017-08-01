<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/6/30
 * Time: 16:11
 */

namespace app\common\command;


use think\Config;
use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\Log;

header("Content-type: text/html; charset=utf-8");

class Crond extends Command {

    protected function configure() {

        Config::set("log",array('type'=>'File','path'=>LOG_PATH."command".DS/*,'level'=>["log","error","notice","planTask","result"]*/));
        Log::record("Planning tasks","planTask");

        $this->setName('Cron')->setDescription("Planning tasks");
    }

    protected function execute(Input $input, Output $output) {
        $this->doCron();
        Log::record("Planned tasks have been performed","planTask");

        $output->writeln("Planned tasks have been performed");
    }

    protected function doCron() {
        // 记录开始运行的时间
        $GLOBALS['_beginTime'] = microtime(TRUE);

        /* 永不超时 */
        ini_set('max_execution_time', 0);
        $time   = time();
        $exe_method = [];
        $crond_list = Config::get('crond');   //获取第四步的文件配置，根据自己版本调整一下
        $sys_crond_timer = Config::get('sys_crond_timer');
        foreach ( $sys_crond_timer as $format ){
            $key = date($format, ceil($time));
            if(isset($crond_list[$key])){
                if ( is_array(@$crond_list[$key]) ){
                    $exe_method = array_merge($exe_method, $crond_list[$key]);
                }
            }
        }
        Log::record($exe_method,"planTask");
        if (!empty($exe_method)){
            foreach ($exe_method as $method){
                if(is_array($method)){
                    if(!isset($method["class"])||!isset($method["action"])){
                        //方法不存在的话就跳过不执行
                        array_push($method,["msg"=>"params not exists"]);
                        Log::record($method,"notice");
                        continue;
                    }
//                    if(!class_exists($method["class"])){
//                        array_push($method,["msg"=>"class ".$method["class"]." not exists"]);
//                        Log::record($method,"notice");
//                        continue;
//                    }
                    if(!method_exists($method["class"],$method["action"])){
                        array_push($method,["msg"=>"action ".$method["action"]." not exists"]);
                        Log::record($method,"notice");
                        continue;
                    }

                    echo "Execution crond --- {$method["class"]}()->{$method["action"]}()\n";
                    Log::record("Execution crond --- {$method["class"]}()->{$method["action"]}()","planTask");
                    $runtime_start = microtime(true);

                    $class=new $method["class"]();

                    $result=isset($method["params"])?$class->$method["action"]($method["params"]):$class->$method["action"]();
                    dump($result);
                    Log::record($result,"result");
                    unset($class,$result);

                    $runtime = microtime(true) - $runtime_start;

                    echo "{$method["class"]}()->{$method["action"]}(), execution time: {$runtime}\n\n";
                    Log::record("{$method["class"]}()->{$method["action"]}(), execution time: {$runtime}","planTask");
                }else{
                    if(!is_callable($method)){
                        //方法不存在的话就跳过不执行
                        Log::record($method." not exists","notice");
                        continue;
                    }

                    echo "Execution crond --- {$method}()\n";
                    Log::record("Execution crond --- {$method}()","planTask");
                    $runtime_start = microtime(true);

                    $result=call_user_func($method);
                    Log::record($result,"result");
                    dump($result);
                    unset($result);

                    $runtime = microtime(true) - $runtime_start;

                    echo "{$method}(), execution time: {$runtime}\n\n";
                    Log::record("{$method}(), execution time: {$runtime}","planTask");
                }
            }

            $time_total = microtime(true) - $GLOBALS['_beginTime'];
            echo "total:{$time_total}\n";
            Log::record("total:{$time_total}","planTask");
        }
    }

}