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
	/** 验证表单  **/
	function validate() {
		if (!isReqNumber($("#req_id").val())) {
			return false;
		}
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

	/** 是否为纯数字  **/
	function isReqNumber(value) {
		var reg = new RegExp("^[0-9]*$");
		if (!reg.test(value)) {
			alert("消息号必须存数字!");
			return false;
		}
		if (value > 9999999) {
			alert("消息号不能大于9999999")
			return false;
		}
		if (value < 1000000) {
			alert("消息号不能小于1000000")
			return false;
		}
		return true;
	}
	
	var last_edit_rc = 0;
	var is_edit_req = true;
	/* 编辑请求类型 */
	function focus_edit_req($rc) {
		last_edit_rc=$rc;
		is_edit_req = true;
	}
	/* 编辑请求类型 */
	function focus_edit_rsp($rc) {
		last_edit_rc=$rc;
		is_edit_req = false;
	}
	
	/** 提交模态框 **/
	$('#edit_f_ok').click(function() {
			var v1 = $('#edit_field_type').val();
			var v2 = $('#edit_field_key').val();
			var v3 = $('#edit_field_value').val();
			var v4 = $('#edit_field_name').val();
			var v5 = $('#edit_field_desc').val();
		if (is_edit_req) {
			if (v1 == "base") {
				$("#req_f_type_" + last_edit_rc).val(v3);
			} else if (v1 == "array") {
				$("#req_f_type_" + last_edit_rc).val(v1 + "<" +v3+ ">");
			} else if (v1 == "map") {
				$("#req_f_type_" + last_edit_rc).val(v1 + "<" +v2+","+v3+ ">");
			}
			$("#req_f_name_" + last_edit_rc).val(v4);
			$("#req_f_desc_" + last_edit_rc).val(v5);
		} else {
			if (v1 == "base") {
				$("#rsp_f_type_" + last_edit_rc).val(v3);
			} else if (v1 == "array") {
				$("#rsp_f_type_" + last_edit_rc).val(v1 + "<" +v3+ ">");
			} else if (v1 == "map") {
				$("#rsp_f_type_" + last_edit_rc).val(v1 + "<" +v2+","+v3+ ">");
			}
			$("#rsp_f_name_" + last_edit_rc).val(v4);
			$("#rsp_f_desc_" + last_edit_rc).val(v5);
		}
	});
	
	/** 模态框展开事件 **/
	$('#exampleModal').on('shown.bs.modal', function () {
		
	});
	
	
	/* 文档就绪行数  */
	$(document).ready(function() {
		// 添加请求字段
		var rc = 0;
		$("#add_req_btn").click(function() {
			rc++;
			$(".req-body").append('<label>类型:</label><input class="req_f_type" name="req_f_type_'+rc+'" type="text" value="" id="req_f_type_'+ rc + '" onfocus="focus_edit_req('+rc+')" data-toggle="modal" data-target="#exampleModal"/> <label>变量名:</label><input name="req_f_name_'+rc+'" type="text" value="" id="req_f_name_'+rc+'" /> <label>描述:</label><input id="req_f_desc_'+rc+'" name="req_f_desc_'+rc+'" type="text" value="" /> <br/>');
		});
		// 添加返回字段
		var rc2 = 0;
		$("#add_rsp_btn").click(function() {
			rc2++;
			$(".rsp-body").append('<label>类型:</label><input name="rsp_f_type_'+rc2+'" type="text" value="" id="rsp_f_type_'+ rc + '" class="rsp_f_type" onfocus="focus_edit_rsp('+rc+')" data-toggle="modal" data-target="#exampleModal"/> <label>变量名:</label><input name="rsp_f_name_'+rc2+'" type="text" value="" id="rsp_f_name_'+rc+'"/> <label>描述:</label><input id="rsp_f_desc_'+rc+'" name="rsp_f_desc_'+rc2+'" type="text" value="" /> <br/>');
		});

		/** 消息号输入框改变事件  **/
		$('#req_id').bind('input propertychange', function() {
			var data = $(this).val();
			var f = data.substr(0, 1);
			if (f == '1') {
				var rspId = data.replace(/1/, "5");
				$('#rsp_id').val(rspId);
			}
		});

		// 提交表单
		$("#submit_msg").click(function() {
			var ok = validate();
			if (ok) {
				var data = $("form").serialize();
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
					}
				});
			}
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
							<span class="input-group-text">消息描述:</span>
						</div>
						<input type="text" id="msg_desc" name="msg_desc" class="form-control" aria-describedby="inputGroup-sizing-sm">
					</div>
				</div>
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<button class="btn btn-outline-secondary" type="button">消息归类</button>
						</div>
						<select name="msg_cat" class="custom-select" id="inputGroupSelect03">
							<c:forEach items="${CacheMgr.getInstance().getMsgCats().values()}" var="cat">
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
							<span class="input-group-text" id="basic-addon1">请求-消息号:</span>
						</div>
						<input type="text" name="req_id" id="req_id" class="form-control" aria-describedby="basic-addon1">
					</div>
				</div>
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">返回-消息号:</span>
						</div>
						<input type="text" name="rsp_id" id="rsp_id" class="form-control" aria-describedby="basic-addon1" readonly>
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
					<input type="button" id="add_req_btn" value="↑添加-请求↑" class="btn btn-dark"> <input type="button" value="提交" class="btn btn-success" id="submit_msg"> <input type="button" id="add_rsp_btn" value="↓添加-返回↓" class="btn btn-dark">
				</div>
			</div>

			<div class="row" style="margin-top: 15px">
				<div style="width: 710px; margin-left: 10px;">
					<div class="alert alert-secondary" role="alert">
						<label>返回-消息体</label>
					</div>
				</div>
			</div>
			
			<!-- 返回消息内容动态编辑区域  -->
			<div class="row">
				<table class="table">
					<tbody class="rsp-body">

					</tbody>
				</table>
			</div>
		</form>
	</div>
	
	<!-- 编辑模态框 -->
	<div class="bd-example">
		<div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="exampleModalLabel">编辑</h4>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group">
								<label for="recipient-name" class="control-label" style="display: block;">类型:</label> 
								<select name="edit_field_type" class="custom-select" id="edit_field_type" style="width: 140px;">
									<option value="base">base</option>
									<option value="array">array&lt;V&gt;</option>
									<option value="map">map&lt;K,V&gt;</option>
								</select>
								<select name="edit_field_key" class="custom-select" id="edit_field_key" style="width: 140px;">
									<option value="int8">int8</option>
									<option value="int16">int16</option>
									<option value="int32">int32</option>
									<option value="int64">int64</option>
									<option value="string">string</option>
								</select> 
								<select name="edit_field_value" class="custom-select" id="edit_field_value" style="width: 140px;">
									<option value="int8">int8</option>
									<option value="int16">int16</option>
									<option value="int32">int32</option>
									<option value="int64">int64</option>
									<option value="string">string</option>
								</select>
							</div>
							<div class="form-group">
								<label for="recipient-name" class="control-label">变量名:</label> <input type="text" class="form-control" id="edit_field_name">
							</div>
							<div class="form-group">
								<label for="message-text" class="control-label">说明:</label> <input type="text" class="form-control" id="edit_field_desc">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" id="edit_f_ok">修改并关闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
