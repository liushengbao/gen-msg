<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.msg.mgr.CacheMgr"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
	
	/* 文档就绪行数  */
	$(document).ready(function() {
		var rc = 0;
		$("#add_req_btn").click(function() {
			rc++;
			var req_row = '<span style="margin-left:5px;">'+rc+'</span>' +
			'<span style="margin-left:5px;">类型:</span>' +
			'<select name="req_f_type_'+rc+'" id="req_f_type_'+rc+'" style="width:120px;">' +
			'<option value="base">base</option>' + 
			'<option value="array&lt;v&gt;">array&lt;v&gt;</option>' +
			'<option value="map&lt;int32,v&gt;">map&lt;int32,v&gt;</option>' +
			'<option value="map&lt;int64,v&gt;">map&lt;int64,v&gt;</option>' +
			'<option value="map&lt;string,v&gt;">map&lt;string,v&gt;</option>' +
			'</select>'+
			'<select name="req_f_value_'+rc+'" id="req_f_value_'+rc+'" style="width:100px;">' +
			'<c:forEach items="${CacheMgr.getInstance().getStructs()}" var="struct">' +
			'<option value="${struct}">${struct}</option>' +
			'</c:forEach>' +
			'</select>'+
			'<span style="margin-left:5px;">变量名:</span>' +
			'<input style="width:100px;" name="req_f_name_'+rc+'" type="text" value="" id="req_f_name_'+rc+'" />' +
			'<span style="margin-left:5px;">描述:</span>' +
			'<input id="req_f_desc_'+rc+'" name="req_f_desc_'+rc+'" type="text" value="" />' + 
			'<a href="javascript:;" style="margin-left:10px;" id="req_f_def_'+rc+'" onclick=>删除</a>' +
			'<br/>'
			;
			$(".req-body").append(req_row);
		});
		
		// 提交表单
		$("#submit_msg").click(function() {
			var data = $("form").serialize();
			$.ajax({
				type : "POST",
				url : "update_gb",
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
		});
	});
</script>

</head>

<body>

	<div style="margin-left: 20px; width: 700px;">
		<form class="form-group" name="msg_form" id="msg_form">
			<div class="row" style="margin-top: 10px">
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text">广播描述:</span>
						</div>
						<input type="text" id="msg_desc" name="msg_desc" class="form-control" aria-describedby="inputGroup-sizing-sm">
					</div>
				</div>
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<button class="btn btn-outline-secondary" type="button">结构体归类</button>
						</div>
						<select name="msg_cat" class="custom-select" id="inputGroupSelect03">
							<c:forEach items="${CacheMgr.getInstance().getMsgCats(3)}" var="cat">
								<option value="${cat.msg_cat_id}">${cat.msg_cat}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>

			<div class="row">
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">广播消息号:</span>
						</div>
						<input type="text" name="req_id" id="req_id">
					</div>
				</div>
			</div>

			<div class="row">
				<div style="width: 710px; margin-left: 10px;">
					<div class="form-group">
						<label for="exampleFormControlTextarea1">备注:</label>
						<textarea name="msg_note" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
					</div>
				</div>
			</div>
			<!-- 请求消息体动态编辑区域 -->
			<div class="row">
				<table class="table">
					<tbody class="req-body">
					</tbody>
				</table>
			</div>

			<div class="row">
				<div style="width: 710px; margin-left: 10px;">
					<div class="alert alert-secondary" role="alert">
						<label>请求-消息体</label>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-8">
					<input type="button" id="add_req_btn" value="↑添加-请求↑" class="btn btn-dark"> <input type="button" value="提交" class="btn btn-success" id="submit_msg">
				</div>
			</div>
		</form>
	</div>

</body>
</html>
