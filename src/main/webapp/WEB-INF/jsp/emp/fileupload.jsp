<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/24 0024
  Time: 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath }/js/jquery-3.1.1.min.js"></script>
<html>
<head>
    <title>文件上传</title>
</head>

<body>
<h1>1、表单上传</h1>
<%-- enctype="multipart/form-data"  此属性为上传文件所需--%>
<form action="${pageContext.request.contextPath }/emp/fileUpload.do" method="post" enctype="multipart/form-data">
    <%-- multiple为可以多个文件上传 --%>
    <input type="file" name="file" multiple="multiple">
        <br>
        <span style="color:red">${info}</span>
        <br>
    <input type="submit" value="upload">
</form>


<h1>2、ajax上传</h1>

<form id="fileUploadAjax">
    <input type="file" name="file" multiple="multiple">
    <br>
    <input type="button" value="uploadByAjax" onclick="doUpload()">
</form>
</body>
</html>

<script>
    function doUpload() {
        var formData = new FormData(document.getElementById("fileUploadAjax"));
        $.ajax({
            url:'${pageContext.request.contextPath }/emp/fileUploadAjax.do',
            type:'POST',
            data:formData,
            contentType:false,  //contentType 主要设置你发送给服务器的格式，文件上传固定格式为false
            processData:false,  //processData默认情况下会将发送的数据序列化以适应默认的内容类型application/x-www-form-urlencoded
            success:function (data) {
                if(data){
                    alert("上传成功!")
                }else {
                    alert("上传失败!")
                }
            }
        })
    }
</script>
