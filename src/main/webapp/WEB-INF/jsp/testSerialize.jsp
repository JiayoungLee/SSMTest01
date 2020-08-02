<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/27 0027
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TestSerialize</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<div>
    <form>
        id <input type="text" name="personId">
        <br>
        empName <input type="text" name="personName">
        <br>
        sex <input type="text" name="personPassword">
        <br>

        <br>
        <input type="button" onclick="add()" value="提交">
    </form>

</div>
</body>
</html>
<script>
    function add() {
        alert($("form").serialize());
        $.ajax({
            url: "${pageContext.request.contextPath}/tc/serialize.do",
            type: "post",
            dataType: "text",
            data: $("form").serialize(),
            success: function (info) {
                alert(info);
            },
            error: function () {
                alert("表单序列化失败");
            }
        })
    }
</script>
