<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<title>添加申请</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="css/font.css">
<link rel="stylesheet" href="css/xadmin.css">
<link rel="stylesheet" href="css/kkpager_orange.css">
<link rel="stylesheet" href="lib/layui/css/layui.css">
<script type="text/javascript"
	src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="js/xadmin.js"></script>
<script type="text/javascript" src="js/kkpager.min.js"></script>
<script src="<%=basePath%>resources/My97DatePicker/WdatePicker.js"></script>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript">
	$(document).ready(function() {
		$("#flip").click(function() {
			$("#panel").toggle();
			$("#panel2").toggle();
			var btn = "新建添加"
			if ($("#flip").text() == "新增分类") {
				$("#flip").text("已有分类选择");
			} else {
				$("#flip").text("新增分类");
			}

		});

		$("#flip2").click(function() {
			$("#panel3").toggle();
			$("#panel4").toggle();
			var btn = "新建添加"
			if ($("#flip2").text() == "新增分类") {
				$("#flip2").text("已有分类选择");
			} else {
				$("#flip2").text("新增分类");
			}

		});
		
		
		$("#flip3").click(function() {
			$("#panel5").toggle();
			$("#panel6").toggle();
			var btn = "新建添加"
			if ($("#flip3").text() == "新增分类") {
				$("#flip3").text("已有分类选择");
			} else {
				$("#flip3").text("新增分类");
			}

		});
	});
</script>
<style type="text/css">
#panel2 {
	display: none;
}

#panel4 {
	display: none;
}
#panel6 {
	display: none;
}
</style>
</head>

<body>
	<div class="x-body">
		<font color="red">${ifo }</font>
		<form class="layui-form" method="post"
			action="propertyController/addProperty.do">
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"><span
					class="x-red">*</span>类型 </label>
				<div class="layui-input-inline">
					</label> <select name="bigtypeName" id="quiz3" lay-filter="myselect2">
						<option value="" selected="selected">请选择类型</option>
						<option value="固定资产">固定资产</option>
						<option value="非实物资产">非实物资产</option>
						<option value="低值易耗损品">低值易耗损品</option>
					</select>
				</div>
			</div>

			<div class="layui-form-item" id="panel">
				<label for="L_repass" class="layui-form-label"><span
					class="x-red">*</span>分类 </label>
				<div class="layui-input-inline">
					<select name="malltypeName" id="quiz4" lay-filter="myselect3">
						<option value="" selected="selected">----从已有分类选择----</option>
						<option value="固定资产">固定资产</option>
						<option value="非实物资产">非实物资产</option>
						<option value="低值易耗损品">低值易耗损品</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item" id="panel2">
				<label for="L_repass" class="layui-form-label"><span
					class="x-red">*</span>分类 </label>
				<div class="layui-input-inline">
					<input name="malltypeName2" type="text" id="L_repass"
						autocomplete="off" class="layui-input" placeholder="输入新的分类">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"> </label>
				<div class="layui-input-inline">
					<a class="layui-btn-warm" id="flip">新增分类</a>
				</div>
			</div>
			<div class="layui-form-item" id="panel3">
				<label for="L_repass" class="layui-form-label"><span
					class="x-red">*</span>名称 </label>
				<div class="layui-input-inline">
					<select name="propertyName" id="quiz1" lay-filter="myselect">
						<option value="" selected="selected">----从已有资产选择----</option>
					</select>
				</div>
			</div>

			<div class="layui-form-item" id="panel4">
				<label for="L_repass" class="layui-form-label"><span
					class="x-red">*</span>名称 </label>
				<div class="layui-input-inline">
					<input name="propertyName2" type="text" id="L_repass"
						autocomplete="off" class="layui-input" placeholder="输入新的资产">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"> </label>
				<div class="layui-input-inline">
					<a class="layui-btn-warm" id="flip2">新增资产</a>
				</div>
			</div>
			<div class="layui-form-item" id="panel5">
				<label for="L_repass" class="layui-form-label"> <span
					class="x-red">*</span>型号
				</label>
				<div class="layui-input-inline">
					<select name="type" id="quiz2">
						<option value="">----从已有型号选择----</option>
						<option value="杭州">杭州</option>
						<option value="宁波" disabled="">宁波</option>
						<option value="温州">温州</option>
						<option value="温州">台州</option>
						<option value="温州">绍兴</option>
					</select>
				</div>
			</div>

			<div class="layui-form-item" id="panel6">
				<label for="L_repass" class="layui-form-label"><span
					class="x-red">*</span>型号 </label>
				<div class="layui-input-inline">
					<input name="type2" type="text" id="L_repass"
						autocomplete="off" class="layui-input" placeholder="输入新的型号">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"> </label>
				<div class="layui-input-inline">
					<a class="layui-btn-warm" id="flip3">新增类型</a>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"> </label>
				<button class="layui-btn" type="submit">提交</button>
				<button class="layui-btn" type="button" onclick="returnUserApply()">重置</button>
			</div>
		</form>
	</div>
	<script>
		/* 	function addProperty() {
			 
				//提交信息……
				// 获得frame索引
				var index = parent.layer.getFrameIndex(window.name);
				//关闭当前frame
				parent.layer.close(index);
			});
			layer.msg("修改成功",{
		     		icon : 1,
		      		time: 500,
		      	},function () {
		            // 获得frame索引
		            var index = parent.layer.getFrameIndex(window.name);
		            //关闭当前frame
		            parent.location.reload();
		            parent.layer.close(index);
		        });

		}  */

		function returnUserApply() {
			window.location.href = "propertyController/addUIProperty.do";
		}
		/*一級 联动下拉框 */
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer, form = layui.form;
			form.on('select(myselect2)', function(data) {
				var bigtypeName = $("#quiz3").val();
				$.ajax({
					type : 'POST',
					url : 'propertyController/returnMalltypeName.ajax',
					data : {
						"bigtypeName" : bigtypeName
					},
					dataType : 'json',
					success : function(allproperty) {
						var str = "";
						$("#quiz4").empty();
						str += "<option>----从已有分类选择----</option>"
						$("#quiz4").html(str);

						for (var i = 0; i < allproperty.length; i++) {
							var property = allproperty[i];
							$("#quiz4").append(
									"<option value="+ property.malltypeName
									+">" + property.malltypeName
											+ "</option>");
							form.render('select');
							$("#quiz4").get(0).selectedIndex = 0;
						}
					},
					error : function(msg) {
						alert("无法连接服务器");
					}
				});
			});
		});
		/*二級 联动下拉框 */
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer, form = layui.form;
			form.on('select(myselect3)', function(data) {
				var malltypeName = $("#quiz4").val();
				$.ajax({
					type : 'POST',
					url : 'propertyController/returnPropertyName.ajax',
					data : {
						"malltypeName" : malltypeName
					},
					dataType : 'json',
					success : function(allproperty) {
						var str = "";
						$("#quiz1").empty();
						str += "<option>----从已有资产选择----</option>"
						$("#quiz1").html(str);

						for (var i = 0; i < allproperty.length; i++) {
							var property = allproperty[i];
							$("#quiz1").append(
									"<option >" + property.propertyName
											+ "</option>");
							form.render('select');
							$("#quiz1").get(0).selectedIndex = 0;
						}
					},
					error : function(msg) {
						alert("无法连接服务器");
					}
				});
			});

		});
		/*三級 联动下拉框 */
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer, form = layui.form;
			form.on('select(myselect)', function(data) {
				var propertyName = $("#quiz1").val();
				$.ajax({
					type : 'POST',
					url : 'applyController/returnType.do',
					data : {
						"propertyName" : propertyName
					},
					dataType : 'json',
					success : function(allproperty) {
						var str = "";
						$("#quiz2").empty();
						str += "<option>----从已有型号选择----</option>"
						$("#quiz2").html(str);

						for (var i = 0; i < allproperty.length; i++) {
							var property = allproperty[i];
							$("#quiz2").append(
									"<option >" + property.type + "</option>");
							form.render('select');
							$("#quiz2").get(0).selectedIndex = 0;
						}
					},
					error : function(msg) {
						alert("无法连接服务器");
					}
				});
			});

		});
	</script>
</body>

</html>