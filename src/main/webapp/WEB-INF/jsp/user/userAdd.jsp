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
    <title>添加员工</title>
</head>
<form action="${pageContext.request.contextPath }/user/add.do" method="post">
    <table class="table">
        <tr>

            <td>姓名</td>&nbsp;&nbsp;
            <td><input type="text" name="userName" value=""></td>
        </tr>

        <tr>
            <td>部门</td>&nbsp;&nbsp;
            <td>
                <select name="rId">
                    <c:forEach items="${roles }" var="role">
                        <option value="${role.rId }">${role.rName }</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="添加用户"></td>
        </tr>
    </table>


</form>

</body>
</html>
