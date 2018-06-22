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
	
	/* 添加结构体    */
	function add_struct() {
		$("#msg_edit").load("add_struct.jsp");
	}
	
	/* 添加结构体    */
	function add_gb() {
		$("#msg_edit").load("add_gb.jsp");
	}
	
	/* 编辑消息  */
	function edit_msg($req_id) {
		$("#msg_edit").load("edit_message.jsp", {req_id:$req_id});
	}
	
	/* 编辑结构体  */
	function edit_struct($req_id) {
		$("#msg_edit").load("edit_struct.jsp", {req_id:$req_id});
	}
	
	/* 编辑广播  */
	function edit_gb($req_id) {
		$("#msg_edit").load("edit_gb.jsp", {req_id:$req_id});
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
	
	/** 删除分类 **/
	function del_cat($cat) {
		$.get("del_cat", {cat_id:$cat}, function(data) {
			alert("删除类别成功!");
			window.location.href = window.location.href;
		});
	}
	
</script>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow: hidden;
	height: 100%;
}

html {
	height: 100%;
}

table {
	width:100%;
	height: 100%;
}

#msg_nav p {
	font-size: 15px;
	display: inline;
}
#msg_nav a {
	font-size: 15px;
	text-decoration: none;
	color: #3366cc;
}
#msg_nav a:link {
	text-decoration: none;
	color: #3366cc;
}

#msg_nav a:active {
	font-size: 15px;
	text-decoration: none;
	color: #3366cc;
}

#msg_nav a:hover {
	font-size: 15px;
	text-decoration: none;
	color: #3366cc;
}

p {
	font-size: 13px;
	display: inline;
	color: #3366cc;
}
</style>

<body>
	<!-- 消息导航 -->
	<div id="msg_nav" style="margin-top: 2px;">
		<p class="text-muted" style="display: inline;">消息号管理</p>
		<a href="javascript:;" onclick="add_cat()" style="margin-left: 5px">添加分类</a> 
		<a href="javascript:;" onclick="add_msg()" style="margin-left: 5px">添加消息号</a>
		<a href="javascript:;" onclick="add_struct()" style="margin-left: 5px">添加结构体</a>
		<a href="javascript:;" onclick="add_gb()" style="margin-left: 5px">添加广播</a>
		<a href="javascript:;" onclick="" style="margin-left: 5px">提交协议</a>
	</div>
	
	<table>
		<tr>
			<td>
				
			</td>
		<tr>
		<tr>
			<!-- 左侧消息栏 -->
			<td style="height: 100%;width: 360px;">
				<div style="float: left; width: 360px; height: 100%;">
					<jsp:include page="message_left.jsp" flush="true" />
				</div>
			</td>
			<!-- 消息显示,消息编辑区域  -->
			<td>
				<div id="msg_edit" class="msg_edit" style="float: left;height: 100%;margin-top: 5px;"></div>
			</td>
		</tr>
	</table>

</body>
</html>