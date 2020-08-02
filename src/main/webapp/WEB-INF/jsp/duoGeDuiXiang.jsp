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
        var dept={"id":1,"dName":"李佳阳"};
        var depts=[{"id":1,"dName":"李佳阳"},{"id":2,"dName":"李佳阳2"}];
        $.ajax({
            url:"${pageContext.request.contextPath}/tc/duoGeDuiXiang.do",
            type:"post",
            //contentType: "text/plain;charset=ISO-8859-1",
            //contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            dataType:"text",
            contentType:"application/json",     //需用post请求，不然后天拿不到
            data:JSON.stringify(depts),     //js中 把一个或多个对象转化成一个json字符串
            success:function (info) {
                alert(info);
            },
            error:function () {
                alert("ajax响应失败");
            }

        })
    })
</script>
