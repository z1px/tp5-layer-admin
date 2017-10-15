/**
 * Created by 乐 on 2017/7/11.
 */

layui.config({
    base: '/static/admin/layui/modules/',
    v: new Date().getTime()
});

layui.use(['layer'], function() {
    layerTips = parent.layer === undefined ? layui.layer : parent.layer; //获取父窗口的layer对象
});

// 一般显示打印信息
function openBox(id) {
    var html=$("#"+id).html();
    if(!html){
        layerTips.msg("没有任何信息");
        return false;
    }
    var style='';
    style+='<style type="text/css">';
    style+='#openBox{overflow-x: hidden;background: #009688;padding: 10px;word-wrap:break-word;word-break:break-all;color: white;line-height: 25px;}';
    style+='</style>';
    html+=style;
    style=null;
    layerTips.open({
        type: 1,
        shadeClose: true,//点击遮罩关闭
        title: false, //不显示标题
        id: "openBox", //用于控制弹层唯一标识
        area: "auto",
        content: html
    });
}

// 一般显示表格信息
function openTable(html) {
    if(!html){
        layerTips.msg("没有任何信息");
        return false;
    }
    var style='';
    style+='<style type="text/css">';
    style+='#openTable{overflow-x: hidden;}';
    style+='#openTable,#openTable table{background: #009688;}';
    style+='#openTable,#openTable table,#openTable table tr,#openTable table td,#openTable table td a{color: white;}';
    style+='#openTable table{margin: 0;}';
    style+='#openTable table tr:hover{background: #00b4a2;}';
    style+='td,td a{word-wrap:break-word;word-break:break-all;}';
    // style+='th{word-break: keep-all;white-space:nowrap;}';
    style+='</style>';
    html+=style;
    style=null;
    layerTips.open({
        type: 1,
        shadeClose: true,//点击遮罩关闭
        title: false, //不显示标题
        id: "openTable", //用于控制弹层唯一标识
        area: "auto",
        content: html
    });
}

//一般打开新的页面
function openUrl(url,title,area) {
    var top_index=layerTips.open({
        type: 2,
        title: title,
        maxmin: true, //最大最小化
        shadeClose: true,
        shade: 0.3,
        id: "openUrl", //用于控制弹层唯一标识
        area: area?area:"auto",
        content: url,
        resizing:function(layero){ //拉伸时修改高度
            layero.find("iframe").height(layero.height()-layero.find(".layui-layer-title").height()-1)
        }
    });
    var device = layui.device();//获取设备信息
    // 如果是手机浏览器，则最大化
    if(device.android||device.ios||device.weixin) layerTips.full(top_index);//弹出即最大化
}
