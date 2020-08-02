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

<body onload="load(1)">
&nbsp;&nbsp;<button type='button' onclick='addPage(this)' class="btn-sm btn-success">添 加</button>
&nbsp;&nbsp;<button type='button' onclick='delAll()' class="btn-sm btn-success">批量删除</button>
<table class="table">
    <thead>
    <th><input type="checkbox" id="selAll" onclick="selectAll()">选中全部</th>
    <th>编号</th>
    <th>姓名</th>
    <th>性别</th>
    <th>职位</th>
    <th>部门</th>
    <th>修改时间</th>
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
                        <td><input type="text" id="id" readonly></td>
                    </tr>
                    <tr>
                        <td>姓名</td>
                        <td><input type="text" id="empName"></td>
                    </tr>

                    <tr>
                        <td>性别</td>
                        <td>
                            <input type="radio" name="sex" value="男">男
                            <input type="radio" name="sex" value="女">女

                        </td>
                    </tr>
                    <tr>
                        <td>职位</td>
                        <td>
                            <select id="job">
                                <option value="">请选择职位</option>
                                <option value="总经理">总经理</option>
                                <option value="部门经理">部门经理</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>修改时间</td>
                        <td><input type="date" id="time"></td>
                    </tr>
                    <tr>
                        <td>部门</td>
                        <td>
                            <select id="deptSelect">

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
    var departments;

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

    function load(p) {
        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath }/emp/listAjax.do",
            type: "get",     //请求方式
            data: {"page": p},
            dataType: "json",       //返回的数据类型 对象用json；字符串和数字用text
            success: function (data) {
                console.log(data.list)
                nPage = data.nextPage;
                pPage = data.prePage;
                fPage = data.firstPage;
                lPage = data.totalPageNum;
                currP = data.currentPage;
                totalP = data.totalPageNum;
                $("#currentPage").html(currP);
                $("#totalPage").html(totalP);

                var html = "";
                for (var i = 0; i < data.list.length; i++) {
                    html += "<tr>" +
                        "<td><input type='checkbox' name='delAll' value='"+data.list[i].id+"'></td>" +
                        "<td>" + data.list[i].id + "</td>" +
                        "<td>" + data.list[i].empName + "</td>" +
                        "<td>" + data.list[i].sex + "</td>" +
                        "<td>" + data.list[i].job + "</td>" +
                        "<td>" + data.list[i].dept.dName + "</td>" +
                        "<td>" + data.list[i].updateTime + "</td>" +
                        "<td><button type='button' onclick='updatePage(this)'>修改</button>&nbsp;&nbsp;" +
                        "<button type='button' onclick='delete1(this)'>删除</button></td>" +
                        "<td style='visibility: hidden'>" + data.list[i].dId + "</td>" +
                        "</tr>"
                }
                //把拼接信息显示在id为tb的标签里
                $("#tb").html(html)

                //获得部门信息
                departments = data.dept;

                var op = "";
                for (var i = 0; i < departments.length; i++) {
                    op += "<option value='" + departments[i].id + "'>" + departments[i].dName + "</option>"

                }
                $("#deptSelect").html(op);
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
        var id = $(obj).parent().parent().find('td').eq(1).text()
        var empName = $(obj).parent().parent().find('td').eq(2).text()
        var sex = $(obj).parent().parent().find('td').eq(3).text()
        //var job = $(obj).parent().parent().find('td').eq(3).text()
        //var dept = $(obj).parent().parent().find('td').eq(4).text()
        var time = $(obj).parent().parent().find('td').eq(6).text()
        var dIdM = $(obj).parent().parent().find('td').eq(8).text()

        $("#deptSelect option").prop("selected", false);
        // $("#deptSelect option").val(1).prop("selected", false);
        // $("#deptSelect option").val(2).prop("selected", false);
        //显示模态框
        $("#one").modal("show");

        //把拿到后的数据显示在模态框中
        $("#id").val(id);
        $("#empName").val(empName);
        $("input[value='" + sex + "']").prop("checked", true);
        $("#deptSelect").find("option[value='" + dIdM + "']").prop("selected", true)
        $("#time").val(time);
        $("#dId").val(dIdM);

    }

    //修改后保存
    function save() {

        //拿到修改后的数据
        var id = $("#id").val();
        var empName = $("#empName").val();
        var sex = $("input[name='sex']:checked").val();
        var job = $("#job").val();
        var dept = $("#deptSelect").val();
        var time = $("#time").val();

        //构建js对象
        var params = {
            "id": id,
            "empName": empName,
            "sex": sex,
            "job": job,
            "dId": dept,
            "updateTime": time
        };

        //显示模态框
        $("#one").removeClass();
        $("#one").attr("class", " modal fade ");

        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath}/emp/updateAjax.do",
            type: "get",
            data: params,
            dataType: "json",
            success: function (data) {
                alert(data.info)
                load(currP);
            }
        })
    }

    //添加页面
    function addPage(obj) {
        $("#modalButton1").hide(); //隐藏
        $("#modalButton2").show(); //显示
        $("#one").modal("show");
        cleanModal();
    }

    //添加
    function add() {
        //拿到添加后的数据
        var empName = $("#empName").val();
        var sex = $("input[name='sex']:checked").val();
        var job = $("#job").val();
        var dept = $("#deptSelect").val();
        var time = $("#time").val();

        //构建js对象
        var params = {
            "empName": empName,
            "sex": sex,
            "job": job,
            "dId": dept,
            "updateTime": time
        };

        //显示模态框
        $("#one").removeClass();
        $("#one").attr("class", "modal fade");


        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath}/emp/addAjax.do",
            type: "post",
            data: params,
            // contentType: "text/plain;charset=ISO-8859-1",
            dataType: "json",
            success: function (data) {
                alert(data.info)
                location.href = "${pageContext.request.contextPath }/emp/listAjaxPage.do"

            }
        })

    }

    //删除
    function delete1(obj) {
        var id = $(obj).parent().parent().find('td').eq(1).text()

        var params = {
            "id": id
        };

        if (confirm("确定要删除吗？")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/emp/deleteAjax.do",
                type: "get",
                data: params,
                dataType: "json",
                success: function (data) {
                    alert(data.info)
                    location.href = "${pageContext.request.contextPath }/emp/listAjaxPage.do"
                }
            })
        }
    }

    //清楚模态框的数据
    function cleanModal() {
        var id = $("#id").val("");
        var empName = $("#empName").val("");
        var sex = $("input[name='sex']").prop("checked", false);
        var job = $("#job").find("option").prop("selected", false);
        var dept = $("#deptSelect option").prop("selected", false);
        var time = $("#time").val("");
    }

    function selectAll() {
        var isClick = $("#selAll").prop("checked");
        $("input[name='delAll']").prop("checked", isClick);
    }

    function delAll() {
        if (confirm("确认要删除所选中的吗？")) {
            var ids = "";
            $("input[name='delAll']").each(function () {
                ids += $(this).val() + ",";
            })

            $.ajax({
                url:"${pageContext.request.contextPath }/emp/delAllAjaxPage.do",
                type:"get",
                data:{
                    "ids":ids
                },
                dataType:"json",
                success:function (data) {
                    alert(data.info);
                    load(1);
                }
            })

        }

    }
</script>
