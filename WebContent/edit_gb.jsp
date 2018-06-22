<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.msg.mgr.MsgMgr"%>
<%@ page import="com.msg.mgr.CacheMgr"%>
<%@ page import="com.msg.vo.MsgItem"%>

<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>
	<%  
		String reqId = request.getParameter("req_id");//用request得到
		MsgItem msgItem = MsgMgr.getInstance().getMsgItem(Integer.valueOf(reqId));
	%>
	<c:set var="msgItem" value="<%=msgItem%>" />
	<c:set var="req_size" value = "<%=msgItem.getReqFields().size()%>" />
	
<script type="text/javascript">
	/** 验证表单  **/
	function validate() {
		if (isNullStr($("#msg_desc").val())) {
			alert("消息描述不能为空!");
			return false;
		}
		return true;
	}

	function isNullStr(a) {
		if (a == null || a == "") {
			return true;
		}
		return false;
	}

	/** 提交模态框 **/
	$('#edit_f_ok').click(function() {
		var v1 = $('#edit_field_type').val();
		var v2 = $('#edit_field_key').val();
		var v3 = $('#edit_field_value').val();
		var v4 = $('#edit_field_name').val();
		var v5 = $('#edit_field_desc').val();
			if (v1 == "base") {
				$("#req_f_type_show_" + last_edit_rc).val(v3);
			} else if (v1 == "array") {
				$("#req_f_type_show_" + last_edit_rc).val(v1 + "<" +v3+ ">");
			} else if (v1 == "map") {
				$("#req_f_type_show_" + last_edit_rc).val(v1 + "<" +v2+","+v3+ ">");
			}
			$("#req_f_name_" + last_edit_rc).val(v4);
			$("#req_f_desc_" + last_edit_rc).val(v5);
			$("#req_f_type_" + last_edit_rc).val(v1);
			$("#req_f_key_" + last_edit_rc).val(v2);
			$("#req_f_value_" + last_edit_rc).val(v3);
	
	});

	/* 文档就绪行数  */
	$(document).ready(function() {
		// 添加请求字段
		var rc = ${req_size};
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
			'<input style="width:100px;" name="req_f_name_'+rc+'" type="text" value="" id="req_f_name_'+rc+'" class="req_f_name"/>' +
			'<span style="margin-left:5px;">描述:</span>' +
			'<input id="req_f_desc_'+rc+'" name="req_f_desc_'+rc+'" type="text" value="" />' + 
			'<a href="javascript:;" style="margin-left:10px;" id="req_f_def_'+rc+'" onclick=>删除</a>' +
			'<br/>'
			;
			$(".req-body").append(req_row);
		});
	

		// 提交表单
		$("#submit_msg").click(function() {
			var ok = validate();
			if (ok) {
				var data = $("form").serialize();
				$.ajax({
					type : "POST",
					url : "update_gb",
					data : data,// 序列化表单值
					async : false,
					error : function(request) {
						alert("Connection error");
					},
					success : function(data) {
						alert("消息提交成功!");
					}
				});
			}
		});				
	});
</script>
<style>
.msg_body input {
	margin-left: 5px;
	width:150px;
}
.msg_body span {
	margin-left: 5px;
}
</style>
</head>

<body>
	
	
	<div style="margin-left: 20px; width: 700px;">
		<form class="form-group" name="msg_form" id="msg_form">
			<input type="hidden" name="msg_id" value="${msgItem.msg_id}">
			<div class="row" style="margin-top: 10px">
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text">广播描述:</span>
							<input style="" type="text" id="msg_desc" name="msg_desc" value="${msgItem.msg_desc}">
						</div>
					</div>
				</div>
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<button class="btn btn-outline-secondary" type="button">消息归类</button>
						</div>
						<select name="msg_cat" class="custom-select" id="inputGroupSelect03">
							<c:if test="${msgItem != null}">
								<option selected="${msgItem.msg_cat}" value="${msgItem.msg_cat}">${msgItem.msg_cat_name}</option>
							</c:if>
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
						<c:if test="${msgItem != null}">
							<input type="text" name="req_id" id="req_id" class="form-control" aria-describedby="basic-addon1" value="${msgItem.req_id}">
						</c:if>
					</div>
				</div>
			</div>

			<div class="row">
				<div style="width: 710px; margin-left: 10px;">
					<div class="form-group">
						<label for="exampleFormControlTextarea1">备注:</label>
						<c:if test="${msgItem != null}">
							<textarea name="msg_note" class="form-control" id="exampleFormControlTextarea1" rows="3" value="${msgItem.msg_note}"></textarea>
						</c:if>
					</div>
				</div>
			</div>
			<!-- 请求消息体动态编辑区域 -->
			<div class="msg_body">
				<table class="table">
					<tbody class="req-body">
						<c:if test="${msgItem != null}">
							<c:forEach items="${msgItem.reqFields}" var="field">
							<span>${field.id}</span>
							<span>类型:</span>
							<select name="req_f_type_${field.id}" id="req_f_type_${field.id}" style="width:120px;">
								<option value= "${field.ft}" selected>${field.ft}</option>
								<option value="base">base</option>  
								<option value="array&lt;v&gt;">array&lt;v&gt;</option> 
								<option value="map&lt;int32,v&gt;">map&lt;int32,v&gt;</option> 
								<option value="map&lt;int64,v&gt;">map&lt;int64,v&gt;</option> 
								<option value="map&lt;string,v&gt;">map&lt;string,v&gt;</option> 
							</select>
							
							<select name="req_f_value_${field.id}" id="req_f_value_${field.id}" style="width:100px;"> 
							<option value= "${field.fv}" selected>${field.fv}</option>
							<c:forEach items="${CacheMgr.getInstance().getStructs()}" var="struct"> 
							<option value="${struct}">${struct}</option> 
							</c:forEach> 
							</select>
							<span>变量名:</span>
							<input name="req_f_name_${field.id}" type="text" value="${field.fn}" style="width:100px;"/> 
							<span>描述:</span>
							<input name="req_f_desc_${field.id}" type="text" value="${field.desc}" />
							<a href="javascript:;" style="margin-left:10px;" id="req_f_del_${field.id}">删除</a>
							<br/>
							</c:forEach>
						</c:if>
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
