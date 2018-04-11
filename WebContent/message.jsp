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
</script>

<body>
	<div class="container" style="width: 1200px; height: auto; margin-left: 0px; padding-top: 5px;">
		<div class="row">
			<div class="col" style="font-size: 16px">
				<p class="text-muted" style="display: inline;">消息号管理</p>
				<a href="javascript:;" onclick="add_msg()" style="margin-left: 5px">添加消息号</a>
			</div>
		</div>

		<div class="row">
			<div class="col">
				<p class="text-muted" style="display: inline;">消息号版本:</p>
				<select id="server_id" name="server_id" style="color: #000000; width: 210px;">
					<option value="test"></option>
				</select> <input type="submit" onclick="" value="确定" class="button">
			</div>
		</div>

		<div class="row">
			<div class="col">
				<p class="text-muted" style="display: inline;">消息号搜索:</p>
				<input type="text"> <input type="submit" onclick="" value="搜索" class="button">
			</div>
		</div>
		

		<div style="float: left; width: 360px;height: 1000px;">
			<jsp:include page="message_left.jsp" flush="true" />
		</div>

		<!-- 消息编辑区域 -->
		<div id="msg_edit" class="msg_edit"></div>


	</div>


</body>
</html>