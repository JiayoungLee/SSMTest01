<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/27 0027
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>demo1</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.0.min.js"></script>
</head>
<body>
<h1>demo1</h1>

<%--<form>--%>
<%--<input type="text" name="id">--%>
<%--<input type="text" name="dName">--%>
<%--<input type="button" onclick="">--%>
<%--</form>--%>
</body>
</html>
<script>
    $(function () {
        var stu = ["小李", "小王", "小张"];
        $.ajax({
            url: "${pageContext.request.contextPath}/tc/arrayTest.do",
            type: "post",
            //contentType: "text/plain;charset=ISO-8859-1",
            //contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            traditional: true,      //用于传过去的对象为数组
            dataType: "text",       //后端返回来的数据类型
            data: {stu: stu},
            success: function (info) {
                alert(info);
            },
            error: function () {
                alert("ajax响应失败");
            }

        })
    })
</script>
