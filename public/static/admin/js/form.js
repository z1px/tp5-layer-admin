
var add_url;
var edit_url;
var recharge_url;

layui.use(['form','laydate'], function() {
    var form = layui.form(),
        laydate = layui.laydate;

    //自定义验证规则
    form.verify({
        username: [/^[A-Za-z0-9\-\_]{2,20}$/, '用户名只能是2-20位的字母、数字和下划线_及破折号-'],
        phone:function (value) {
            if(value){
                if(!/^1[34578][0-9]{9}$/.test(value)){
                    return '手机号格式不正确';
                }
            }
        },
        email:function (value) {
            if(value){
                if(!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value)){
                    return '邮箱号格式不正确';
                }
            }
        },
        password: function (value) {
            var pwd=$("input[name=password]").val();
            if(!$("input[name=id]").val()||($("input[name=id]").length>0&&pwd)){
                if(!/^[\S]{6,12}$/.test(value)){
                    return '密码必须6到12位，且不能出现空格';
                }
            }

        },
        check_password: function(value) {
            var pwd=$("input[name=password]").val();
            if(value!=pwd){
                return '两次密码不一致';
            }
        }
    });

    //监听提交（修改个人信息）
    form.on('submit(form_edit_info)', function(data) {
        data.form.submit();
        return false;
    });

    //监听提交（添加）
    form.on('submit(form_add)', function(data) {
        var ind_load=layerTips.load(2);
        $.post(add_url,data.field,function (result) {
            layerTips.close(ind_load);
            if(result.code==1){
                layerTips.confirm(result.msg,{btn: ['继续添加','重新编辑'],btnAlign:'c',closeBtn:0},function(ind){
                    layerTips.close(ind);
                    location.reload();
                },function (ind) {
                    layerTips.close(ind);
                    location.href=result.data.url_edit;
                });
            }else {
                layerTips.msg(result.msg);
            }
        },"json");
        return false;
    });

    //监听提交（修改）
    form.on('submit(form_edit)', function(data) {
//            data.form.submit();
        var ind_load=layerTips.load(2);
        $.post(edit_url,data.field,function (result) {
            layerTips.close(ind_load);
            if(result.code==1){

            }
            layerTips.msg(result.msg);
        },"json");
        return false;
    });

    //监听提交（充值）
    form.on('submit(form_recharge)', function(data) {
        var ind_load=layerTips.load(2);
        $.post(recharge_url,data.field,function (result) {
            layerTips.close(ind_load);
            if(result.code==1){
                layerTips.confirm(result.msg,{btn: ['继续充值'],btnAlign:'c',closeBtn:1},function(ind){
                    layerTips.close(ind);
                    location.reload();
                });
            }else {
                layerTips.msg(result.msg);
            }
        },"json");
        return false;
    });

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