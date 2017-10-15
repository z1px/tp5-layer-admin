
var area;//弹窗大小
var content_url;//表格内容请求接口
var tree_url;//菜单树请求接口
var edit_url;//添加数据请求接口
var del_url;//删除请求接口
var switch_url;//状态切换请求接口

layui.use(['paging', 'form'], function() {
    var paging = layui.paging(),
        form = layui.form();

    paging.init({
        openWait: true,
        url: content_url, //地址
        elem: '#content', //内容容器
        params: {},//发送到服务端的参数
        type: 'POST',
        tempElem: '#tpl', //模块容器
        pageConfig: { //分页参数配置
            elem: '#paged', //分页容器
            pageSize: 20 //分页大小
        },
        success: function() { //渲染成功的回调
            //alert('渲染成功');
        },
        fail: function(msg) { //获取数据失败的回调
            //alert('获取数据失败')
        },
        complate: function() { //完成的回调
            //alert('处理完成');
            form.render('checkbox');

            //绑定所有编辑按钮事件
            $('#content').children('tr').each(function() {
                var $that = $(this);
                $that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
                    edit($(this).data('url'),"修改【 <span style='color:red;'>"+$(this).data('name')+"</span>】信息",area,$.md5($(this).data('url')));
                });
                $that.children('td:last-child').children('a[data-opt=del]').on('click', function() {
                    var id=$(this).data('id');
                    if(id<=2) return false;
                    layerTips.confirm('确定要删除【 <span style="color:red;">' + $(this).data('name') + '</span> 】 ？', { icon: 3, title: '系统提示' }, function (index) {
                        $.post(del_url,{id:id},function (data) {
                            if(data.code==1){
                                $that.parent('td').parent('tr').remove();
                            }
                            layerTips.msg(data.msg);
                        },"json");
                    });
                });

            });

        },
    });

    //监听搜索表单的提交事件
    form.on('submit(search)', function (data) {
        paging.get(data.field);
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
        paging.get(field);
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
                paging.get(field);
                field=form_field=null;
            }
        },"json");
    });

    $("#edit").on('click', function() {
        //本表单通过ajax加载 --以模板的形式，当然你也可以直接写在页面上读取
        edit(edit_url,"添加新数据",area,$.md5(edit_url));
    });

    $('#menuTree').on('click', function() {
        edit(tree_url,"菜单树",area,$.md5(tree_url));
    });

    function edit(url,title,area,id) {
        var top_index=layerTips.open({
            type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            title: title,
            maxmin : true, //最大最小化
            shade: 0.3, //遮罩
            id : id?id:'', //用于控制弹层唯一标识
            area : area?area:"auto",//宽高
            content: url,
//                btn: ['提交', '重置'], //可以无限个按钮
//                btnAlign: 'c',
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
                    paging.get(field);
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

});