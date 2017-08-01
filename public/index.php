<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// [ 应用入口文件 ]

// 检测PHP环境
if(version_compare(PHP_VERSION,'5.4.0','<'))  die('require PHP > 5.4.0 !');

define('DS',DIRECTORY_SEPARATOR);
// 站点目录
define('SITE_DIR',dirname(__DIR__).DS);
// ThinkPHP定义
define('THINK_PATH',SITE_DIR.'thinkphp'.DS);
// 定义应用目录
define('APP_PATH',SITE_DIR.'application'.DS);
// 系统运行时目录
define('RUNTIME_PATH',SITE_DIR.'runtime'.DS);

// 加载框架引导文件
require THINK_PATH.'start.php';

