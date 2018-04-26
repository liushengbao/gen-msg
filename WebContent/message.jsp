<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>
<script language="javascript">
	/* 点击编辑消息界面   */
	function add_msg() {
		$("#msg_edit").load("add_message.jsp");
	}
	
	/* 添加分类  */
	function add_cat() {
		$("#msg_edit").load("add_cat.jsp");
	}
	
	/* 编辑消息  */
	function edit_msg($req_id) {
		$("#msg_edit").load("edit_message.jsp", {req_id:$req_id});
	}
	
	/** 显示消息 **/
	function show_msg($req_id) {
		$("#msg_edit").load("show_message.jsp", {req_id:$req_id});
	}
	
	/** 删除消息 **/
	function del_msg($req_id) {
		$.get("del_msg", {msg_id:$req_id}, function(data) {
			alert("删除成功!");
			window.location.href = window.location.href;
		});
	}
	
	/** 提交消息  **/
	function submit_msg() {
		var ok = validate();
		if (ok) {
			var data = $("#msg_form").serialize();
			alert(data);
			$.ajax({
				type : "POST",
				url : "update_msg",
				data : data,// 序列化表单值
				async : false,
				error : function(request) {
					alert("消息提交异常!");
				},
				success : function(data) {
					alert("消息提交成功!");
					window.location.href = window.location.href;
				}
			});
		}
	}
	
</script>

<body>
	<div class="container" style="width: 1200px; height: auto; margin-left: 0px; padding-top: 5px;">
		<div class="row">
			<div class="col" style="font-size: 16px">
				<p class="text-muted" style="display: inline;">消息号管理</p>
				<a href="javascript:;" onclick="add_cat()" style="margin-left: 5px">添加分类</a> 
				<a href="javascript:;" onclick="add_msg()" style="margin-left: 5px">添加消息号</a>
				<a href="javascript:;" onclick="" style="margin-left: 5px">添加结构体</a>
				<a href="javascript:;" onclick="" style="margin-left: 5px">添加广播</a>
			</div>
		</div>

		<div class="row" style="margin-top: 5px;">
			<div class="col">
				<p class="text-muted" style="display: inline;">消息号版本:</p>
				<select id="server_id" name="server_id" style="color: #000000; width: 200px;">
					<option value="main">main</option>
				</select>
				<button type="button" class="btn btn-secondary btn-sm">确定</button>
			</div>
		</div>

		<div class="row" style="margin-top: 5px;">
			<div class="col">
				<p class="text-muted" style="display: inline;">消息号搜索:</p>
				<input type="text" style="width: 200px;"> 
				<button type="button" class="btn btn-secondary btn-sm">搜索</button>
			</div>
		</div>

		<!-- 消息类目显示  -->
		<div style="float: left; width: 360px; height: 1000px;">
			<jsp:include page="message_left.jsp" flush="true" />
		</div>

		<!-- 消息编辑区域 -->
		<div id="msg_edit" class="msg_edit" style="float: left;"></div>

	</div>


</body>
</html>