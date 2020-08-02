<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/20 0020
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!doctype html>
<html lang="en">
<head>
    <base href="<%=basePath%>"/>
    <meta charset="UTF-8">
    <title>企业资产管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">

    <script src="${pageContext.request.contextPath}/js/jquery-3.5.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <script type="text/javascript">
        //如果该页面在iframe中出现，那么会自动调用最外层窗口刷新本链接
        if (window != top) {
            top.location.href = location.href;
        }
    </script>

</head>
<body class="login-bg">

<div class="login">
    <div class="message">xxxx管理系统-用户登录</div>
    <font id="error" size="10" class="text-align:center" color="red"></font>
    <div id="darkbannerwrap"></div>
    <form method="post" class="layui-form">
        <input placeholder="用户名" type="text" name="personName" id="pName"
               class="layui-input">
        <hr class="hr15">
        <input placeholder="密码" type="password" name="personPassword" id="pPassword"
               class="layui-input">
        <hr class="hr15">
        <input lay-submit lay-filter="login" style="width: 100%;"
               type="button" value="登录" onclick="login()"/>
        <hr class="hr20">
        <div class="layui-form-item">
            <div class="layui-form-item" pane="">

                <input type="checkbox" lay-filter="filter" id="memoryuser" lay-skin="primary" title="30天内自动登录">

            </div>
        </div>
    </form>
</div>

<script>

    $(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/pc/logout.do",
            type: "post",
            dataType: "json",
            success: function (info) {
                if (info.personName != "") {
                    $("#pName").val(info.personName);
                    $("#pPassword").val(info.personPassword);
                    $("#memoryuser").prop("checked", checked);
                }

            },
            error: function () {
                layer.msg('ajax请求失败', {icon: 2});
            }
        })
    })

    //进行登录处理
    function login() {
        //拿到30天自动登录复选框里面的值
        var checkState = $("#memoryuser").prop("checked");
        var isMemory = "NO";
        if (checkState) {
            isMemory = "YES";
        }

        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/pc/checkLogin.do?isMemory=" + isMemory,
            dataType: "text",
            data: $("form").serialize(),
            success: function (info) {
                alert(info)
                if (info == "success") {
                    //layer.msg("登录成功", {icon: 1});
                    window.location.href = "${pageContext.request.contextPath}/pc/success.do";
                } else {
                    layer.msg('账号或者密码错误！', {icon: 2});
                }
            },
            error: function () {
                layer.msg('ajax请求失败', {icon: 2});
            }
        })
    }
</script>


</body>
</html>
