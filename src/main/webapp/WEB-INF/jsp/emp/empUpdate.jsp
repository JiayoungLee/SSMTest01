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
    <title>修改员工</title>
</head>
<form action="${pageContext.request.contextPath }/emp/update.do" method="post">
    <input type="hidden" name="id" value="${employer.id}">
    <table class="table">
        <tr>

            <td>姓名</td>&nbsp;&nbsp;
            <td><input type="text" name="empName" value="${employer.empName}"></td>
        </tr>
        <tr>
            <td>性别</td>&nbsp;&nbsp;
            <td><input type="text" name="sex" value="${employer.sex}"></td>
        </tr>
        <tr>
            <td>职位</td>&nbsp;&nbsp;
            <td><input type="text" name="job" value="${employer.job}"></td>
        </tr>
        <tr>
            <td>部门</td>&nbsp;&nbsp;
            <td>
                <select name="dId">
                    <c:forEach items="${deparments }" var="department">
                        <c:if test="${employer.dept.id eq department.id }">
                            <option value="${department.id }" selected="selected">${department.dName }</option>
                        </c:if>
                        <option value="${department.id }">${department.dName }</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="修改"></td>
        </tr>
    </table>


</form>

</body>
</html>
