<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/20 0020
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath }/js/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
</head>



姓名<input type="text" value="" name="userName1">
<input type="button" value="查询" onclick="selectByName()">

<body onload="load(1)">
&nbsp;&nbsp;<button type='button' onclick='addPage(this)' class="btn-sm btn-success">添 加</button>
&nbsp;&nbsp;<button type='button' onclick='deleteAll()' class="btn-sm btn-success">批量删除</button>

<table class="table">
    <thead>
    <td><input type="checkbox" name="checkAll" onclick="checkAll()">选择全部</td>
    <th>编号</th>
    <th>姓名</th>
    <th>角色</th>
    <th>操作</th>
    </thead>
    <tbody id="tb">

    </tbody>
</table>

<div style="margin: 0 auto">
    <button type="button" class="btn btn-success btn-sm" onclick="firstPage()">首页</button>
    <button type="button" class="btn btn-success btn-sm" onclick="prePage()">上一页</button>&nbsp;&nbsp;
    <span id="currentPage"></span>/
    <span id="totalPage"></span>&nbsp;&nbsp;
    <button type="button" class="btn btn-success btn-sm" onclick="nextPage()">下一页</button>
    <button type="button" class="btn btn-success btn-sm" onclick="lastPage()">尾页</button>
</div>

<div class="modal fade" id="one" style="top:200px">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--头部-->
            <div class="modal-header" style="background-color: green; height: 20px;">
            </div>
            <div class="modal-body">
                <table class="table" border="0">
                    <tr>
                        <td>编号</td>
                        <td><input type="text" id="uId" readonly></td>
                    </tr>
                    <tr>
                        <td>姓名</td>
                        <td><input type="text" id="userName"></td>
                    </tr>

                    <tr>
                        <td>角色</td>
                        <td>
                            <select name="" id="roleM">

                            </select>
                        </td>
                    </tr>


                    <tr>
                        <td><span style="color:red" id="info">222</span></td>
                        <td colspan="2">
                            <button id="modalButton1" type="button" class="btn btn-success btn-sm" onclick="save()">
                                点击修改
                            </button>
                            <button id="modalButton2" type="button" class="btn btn-success btn-sm" onclick="add()">
                                点击添加
                            </button>
                        </td>

                    </tr>
                </table>
            </div>

        </div>
    </div>
</div>


</body>
</html>
<script>
    var pPage;
    var nPage;
    var fPage;
    var lPage;
    var currP;
    var totalP;
    var count;
    var numPerPage;
    var userName2;

    function selectByName() {
        userName2 = $("input[name='userName1']").val();
        alert(userName2)
        load(1);

    }

    function prePage() {
        load(pPage);
    }

    function nextPage() {
        load(nPage);
    }

    function firstPage() {
        load(fPage);
    }

    function lastPage() {
        load(lPage);
    }

    function load(pa) {
        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath }/user/listAjax.do",
            type: "get",     //请求方式
            data: {
                "page": pa,
                "userName":userName2
            },
            dataType: "json",       //返回的数据类型 对象用json；字符串和数字用text
            success: function (data) {
                console.log(data.list)

                nPage = data.nextPage;
                pPage = data.prePage;
                fPage = data.firstPage;
                lPage = data.totalPageNum;
                currP = data.currentPage;
                totalP = data.totalPageNum;
                count = data.count;
                numPerPage = data.numPerPage;
                $("#currentPage").html(currP);
                $("#totalPage").html(totalP);

                var html = "";
                for (var i = 0; i < data.list.length; i++) {
                    html += "<tr>" +
                        "<td><input type='checkbox' name='checkDel' value='" + data.list[i].uId + "'></td>" +
                        "<td>" + data.list[i].uId + "</td>" +
                        "<td>" + data.list[i].userName + "</td>" +
                        "<td>" + data.list[i].role.rName + "</td>" +
                        "<td><button type='button' onclick='updatePage(this)'>修改</button>&nbsp;&nbsp;" +
                        "<button type='button' onclick='delete1(this)'>删除</button></td>" +
                        "<td style='visibility: hidden'>" + data.list[i].rId + "</td>" +
                        "</tr>"
                }
                //把拼接信息显示在id为tb的标签里
                $("#tb").html(html);
                //拿到角色信息，放到角色select标签
                var roles = data.rolesList;
                var rol = "";
                for (var i = 0; i < roles.length; i++) {
                    rol += "<option value='" + roles[i].rId + "'>" + roles[i].rName + "</option>";
                }
                $("#roleM").html(rol);
            },
            error: function (data) {
                //响应失败需要做的事情
            }
        })
    }

    /*打开修改模态框*/
    function updatePage(obj) {
        $("#modalButton1").show();
        $("#modalButton2").hide();
        /*先拿到修改的数据*/
        var uId = $(obj).parent().parent().find('td').eq(1).text()
        var userName = $(obj).parent().parent().find('td').eq(2).text()
        var rId = $(obj).parent().parent().find('td').eq(5).text()

        //显示模态框
        $("#one").modal("show");

        //把拿到后的数据显示在模态框中
        $("#uId").val(uId);
        $("#userName").val(userName);
        $("#roleM").find("option[value='" + rId + "']").prop("selected", true);

    }

    //保存
    function save() {

        //拿到修改后的数据
        var uId = $("#uId").val();
        var userName = $("#userName").val();
        var rId = $("#roleM").val();

        //构建js对象
        var params = {
            "uId": uId,
            "userName": userName,
            "rId": rId,
        };


        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath}/user/updateAjax.do",
            type: "get",
            data: params,
            dataType: "json",
            success: function (data) {
                alert(data.info)
                load(currP)
            }
        })

        //隐藏模态框
        $("#one").removeClass();
        $("#one").attr("class", " modal fade ");

    }

    function addPage(obj) {
        cleanModal();
        $("#modalButton1").hide(); //隐藏
        $("#modalButton2").show(); //显示
        $("#one").modal("show");
    }

    function add() {
        //拿到添加后的数据
        var userName = $("#userName").val();
        var rId = $("#roleM").val();


        //构建js对象
        var params = {
            "userName": userName,
            "rId": rId
        };

        //隐藏模态框
        $("#one").removeClass();
        $("#one").attr("class", " modal fade ");

        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath}/user/addAjax.do",
            type: "get",
            data: params,
            dataType: "json",
            success: function (data) {
                alert(data.info)
                location.href = "${pageContext.request.contextPath }/user/listAjaxPage.do"

            }
        })

    }

    function delete1(obj) {
        var id = $(obj).parent().parent().find('td').eq(1).text()

        var params = {
            "id": id
        };

        if (confirm("确定要删除吗？")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/user/deleteAjax.do",
                type: "get",
                data: params,
                dataType: "json",
                success: function (data) {
                    alert(data.info);
                    if (count % numPerPage == 1) {
                        load(currP - 1);
                    } else {
                        load(currP);
                    }
                }
            })
        }
    }

    function cleanModal() {
        $("#uId").val("")
        $("#userName").val("");
        $("#roleM option").prop("selected", false);
    }

    function checkAll() {
        var seleProp = $("input[name='checkAll']").prop("checked");
        $("input[name='checkDel']").prop("checked", seleProp);
    }

    function deleteAll() {
        var allId = "";
        $("input[name='checkDel']:checked").each(function () {
            allId += $(this).val() + ",";
        })

        $.ajax({
            url: "${pageContext.request.contextPath }/user/delAllAjaxPage.do",
            type: "get",
            data: {
                "allId": allId
            },
            dataType: "json",
            success: function (data) {
                alert(data.info);
                load(1);
            }
        })
    }
</script>
