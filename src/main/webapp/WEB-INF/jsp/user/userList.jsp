<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/20 0020
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath }/js/jquery-3.1.1.min.js"></script>
<html>
<head>
    <title>用户列表</title>

    <script type="text/javascript">
        function isDelete(id) {
            //给出弹框
            if (confirm("确认要删除吗？！")) {
                location.href = "${pageContext.request.contextPath }/user/delete.do?id="+ id;
            }
        }
    </script>
</head>
<form action="${pageContext.request.contextPath }/user/list.do" method="get">
    姓名<input type="text" value="${userInfo.userName}" name="userName">
    <input type="submit" value="查询">
</form>
<body>
<a href="${pageContext.request.contextPath }/user/add.do" class="btn-success btn-sm">添加员工</a>
    <table class="table">
        <thead>
        <th>编号</th>
        <th>姓名</th>
        <th>角色</th>
        <th>操作</th>
        </thead>
        <tbody>
            <c:forEach items="${data.list}" var="x">
                <tr>
                    <td>${x.uId}</td>
                    <td>${x.userName}</td>
                    <td>${x.role.rName}</td>


                    <td>
                        <a href="${pageContext.request.contextPath }/user/update.do?id=${x.uId}" class="btn-success btn-sm">修改</a>
                        <a href="javascript:void(0)" onclick="isDelete(${x.uId })" class="btn-warning btn-sm">删除</a>

                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath }/user/list.do?page=${data.indexPage}&userName=${userInfo.userName}" class="btn-success btn-sm">首页</a> &nbsp;&nbsp;
    <a href="${pageContext.request.contextPath }/user/list.do?page=${data.prePage}&userName=${userInfo.userName}" class="btn-success btn-sm">上一页</a> &nbsp;&nbsp;
    <c:forEach items="${data.navigatepageNums}" var="navi">
        <a href="${pageContext.request.contextPath }/user/list.do?page=${navi}&userName=${userInfo.userName}" class="btn-success btn-sm">${navi}</a> &nbsp;&nbsp;
    </c:forEach>
    <a href="${pageContext.request.contextPath }/user/list.do?page=${data.nextPage}&userName=${userInfo.userName}" class="btn-success btn-sm">下一页</a>&nbsp;&nbsp;
    <a href="${pageContext.request.contextPath }/user/list.do?page=${data.endPage}&userName=${userInfo.userName}" class="btn-success btn-sm">尾页</a>

</body>
</html>
