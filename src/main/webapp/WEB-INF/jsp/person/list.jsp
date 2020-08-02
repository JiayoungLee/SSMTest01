<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/30 0030
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/pc/logout">退出登录</a>
<h1>登录成功</h1>

<shiro:hasRole name="user">
    <a href="${pageContext.request.contextPath}/pc/user.do">用户</a>
</shiro:hasRole>

<shiro:lacksRole name="admin">
    <h1>如果你不具有admin权限，您将会看到此条信息</h1>
</shiro:lacksRole>

<shiro:hasRole name="admin">
    <a href="${pageContext.request.contextPath}/pc/admin.do">管理员</a>
</shiro:hasRole>
</body>
</html>
