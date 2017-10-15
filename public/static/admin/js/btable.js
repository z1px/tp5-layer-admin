
var columns;//配置数据列
var title;//弹窗标题展示的字段
var area;//弹窗大小
var content_url;//表格内容请求接口
var edit_url;//添加数据请求接口
var switch_url;//状态切换请求接口

layui.use(['btable', 'form','laydate'], function () {
    var btable = layui.btable(),
        form = layui.form(),
        laydate = layui.laydate;

    btable.set({
        openWait: true,//开启等待框
        elem: '#content',
        url: content_url, //数据源地址
        type: 'POST', //读取方式
        pageSize: 20,//页大小
        params: {t: new Date().getTime()},//额外的请求参数
        columns: columns,
        even: true,//隔行变色
        field: 'id', //主键ID
        //skin: 'row',
        checkbox: false,//是否显示多选框
        paged: true, //是否显示分页
        singleSelect: false, //只允许选择一行，checkbox为true生效
        onSuccess: function ($elem) { //$elem当前窗口的jq对象

            $elem.children('tr').each(function () {
                $(this).children('td:last-child').children('input').each(function () {
                    var $that = $(this);
                    var action = $that.data('action');
                    var id = $that.data('id');
                    var url = $that.data('url');
                    $that.on('click', function () {
                        var name = $that.parent('td').siblings(title).text();
                        switch (action) {
                            case 'edit':
                                edit(url,"修改【<em>"+name+"</em>】信息",area);
                                break;
                            case 'del': //删除
                                //询问框
                                layerTips.confirm('确定要删除[ <span style="color:red;">' + name + '</span> ] ？', { icon: 3, title: '系统提示' }, function (index) {
                                    $.post(url,{},function (data) {
                                        if(data.code==1){
                                            $that.parent('td').parent('tr').remove();
                                        }
                                        layerTips.msg(data.msg);
                                    },"json");
                                });
                                break;
                            case 'switch_status': //修改状态
                                //询问框
                                layerTips.confirm('确定要'+$that.val()+'【 <span style="color:red;">' + name + '</span> 】 ？', { icon: 3, title: '系统提示' }, function (index) {
                                    $.post(switch_url,{id:id},function (data) {
                                        layerTips.msg(data.msg);
                                        if(data.code==1){
                                            //重新加载当前页
                                            var pageIndex=$(".layui-laypage-curr em").text()?$(".layui-laypage-curr em").text():1;
                                            var field={pageIndex:pageIndex};
                                            var form_field=$("form").serializeArray();
                                            if(form_field){
                                                $.each(form_field,function (i,v){
                                                    field[v.name]=v.value;
                                                })
                                            }
                                            btable.get(field);
                                            field=form_field=null;
                                        }
                                    },"json");
                                });
                                break;
                            case 'recharge':
//                                    layerTips.msg(action+":"+id);
                                edit(url,"SDK平台【 <span style='color:red;'>"+name+"</span>】额度充值",area);
                                break;
                        }
                    });
                });
            });

            $(window).on('resize', function (e) {
                var $that = $(this);
                $('#content').height($('#content').find("table").height());
            }).resize();
        }
    });
    btable.render();
    //监听搜索表单的提交事件
    form.on('submit(search)', function (data) {
        btable.get(data.field);
        return false;
    });
    //监听搜索表单的提交事件
    form.on('select', function(data){
        //重新加载当前页
        var field=[];
        var form_field=$("form").serializeArray();
        if(form_field){
            $.each(form_field,function (i,v){
                field[v.name]=v.value;
            })
        }
        btable.get(field);
        field=form_field=null;
        return false;
    });

    //监听指定开关
    form.on('switch(switchStatus)', function(data){
        var ind_load=layerTips.load(2);
        $.post(switch_url,{id:$(this).data("id"),status:data.elem.checked?1:2},function (result) {
            layerTips.close(ind_load);
            layerTips.msg(result.msg);
            if(result.code!=1){
                //重新加载当前页
                var pageIndex=$(".layui-laypage-curr em").text()?$(".layui-laypage-curr em").text():1;
                var field={pageIndex:pageIndex};
                var form_field=$("form").serializeArray();
                if(form_field){
                    $.each(form_field,function (i,v){
                        field[v.name]=v.value;
                    })
                }
                btable.get(field);
                field=form_field=null;
            }
        },"json");
    });

    $("#edit").click(function () {
        edit(edit_url,"添加新数据",area);
    });

    function edit(url,title,area,id) {
        var top_index=layerTips.open({
            type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            title: title,
            maxmin: true, //最大最小化
            shade: 0.3, //遮罩
            id : id?id:'', //用于控制弹层唯一标识
            area : area?area:"auto",//宽高
            content: url,
            cancel:function (index, layero) {
                layerTips.confirm('若数据未保存，关闭后数据会丢失，确定要关闭吗？',function(ind){
                    layerTips.close(ind);
                    layerTips.close(index);

                    //重新加载当前页
                    var pageIndex=$(".layui-laypage-curr em").text()?$(".layui-laypage-curr em").text():1;
                    var field={pageIndex:pageIndex};
                    var form_field=$("form").serializeArray();
                    if(form_field){
                        $.each(form_field,function (i,v){
                            field[v.name]=v.value;
                        })
                    }
                    btable.get(field);
                    field=form_field=null;
                });
                return false;
            },
            full:function (layero) {
                layero.find("iframe").height(layero.height()-layero.find(".layui-layer-title").height());
            },
            restore:function (layero) {
                layero.find("iframe").height(layero.height()-layero.find(".layui-layer-title").height());
            },
            resizing:function(layero){ //拉伸时修改高度
                layero.find("iframe").height(layero.height()-layero.find(".layui-layer-title").height()-1);
            }
        });

        var device = layui.device();//获取设备信息
        // 如果是手机浏览器，则最大化
        if(device.android||device.ios||device.weixin) layerTips.full(top_index);//弹出即最大化
    }

    var start = {
        format: 'YYYY-MM-DD hh:mm:ss', //日期格式
        istime: true, //是否开启时间选择
        min: "2017-07-01 00:00:00",
        // max: laydate.now(),
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };

    var end = {
        format: 'YYYY-MM-DD hh:mm:ss', //日期格式
        istime: true, //是否开启时间选择
        min: "2017-07-01 00:00:00",
        // max: laydate.now(),
        istoday: false,
        choose: function(datas){
            // start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    $("input[name=begin_time]").click(function () {
        start.elem = this;
        laydate(start);
    });

    $("input[name=end_time]").click(function () {
        end.elem = this;
        laydate(end);
    });

});