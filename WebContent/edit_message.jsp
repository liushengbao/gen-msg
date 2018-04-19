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

	/* 文档就绪行数  */
	$(document).ready(function() {
		// 添加请求字段
		var rc = 0;
		$("#add_req_btn").click(function() {
			 $("input.req_f_type").each(function(){
				 var id=$(this).attr("id");
				 if (rc < id) {
					 rc = id;
				 }
			 });
			rc++;
			$(".req-body").append('<label>类型:</label><input name="req_f_type_'+rc+'" type="text" value="" id="'+ rc + '" class="req_f_type"/> <label>变量名:</label><input name="req_f_name_'+rc+'" type="text" value="" /> <label>描述:</label><input name="req_f_desc_'+rc+'" type="text" value="" /> <br/>');					
		});
	
		// 添加返回字段
		var rc2 = 0;
		$("#add_rsp_btn").click(function() {
			$("input.rsp_f_type").each(function(){
				 var id=$(this).attr("id");
				 if (rc2 < id) {
					 rc2 = id;
				 }
			 });
			rc2++;
			$(".rsp-body").append('<label>类型:</label><input name="rsp_f_type_'+rc2+'" type="text" value="" id="'+ rc2 + '" class="rsp_f_type"/> <label>变量名:</label><input name="rsp_f_name_'+rc2+'" type="text" value="" /> <label>描述:</label><input name="rsp_f_desc_'+rc2+'" type="text" value="" /> <br/>');
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
</head>

<body>
	<%  
	
		String reqId = request.getParameter("req_id");//用request得到
		MsgItem msgItem = MsgMgr.getInstance().getMsgItem(Integer.valueOf(reqId));
	%>
	
	<c:set var="msgItem" value="<%=msgItem%>" />
	
	<div style="margin-left: 20px; width: 700px;">
		<form class="form-group" name="msg_form" id="msg_form">
			<input type="hidden" name="msg_id" value="${msgItem.msg_id}">
			<div class="row" style="margin-top: 10px">
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text">消息描述:</span>
						</div>
						
						<c:if test="${msgItem != null}">
							<input type="text" id="msg_desc" name="msg_desc" class="form-control" aria-describedby="inputGroup-sizing-sm" value="${msgItem.msg_desc}">
						</c:if>
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
						<c:if test="${msgItem != null}">
							<input type="text" name="req_id" id="req_id" class="form-control" aria-describedby="basic-addon1" value="${msgItem.req_id}">
						</c:if>
					</div>
				</div>
				<div style="width: 350px; margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">返回-消息号:</span>
						</div>
						<c:if test="${msgItem != null}">
							<input type="text" name="rsp_id" id="rsp_id" class="form-control" aria-describedby="basic-addon1" readonly value="${msgItem.rsp_id}">
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
			<div class="row">
				<table class="table">
					<tbody class="req-body">
						<c:if test="${msgItem != null}">
							<c:forEach items="${msgItem.reqFields}" var="field">
								<label>类型:</label><input name="req_f_type_${field.id}" type="text" value="${field.ft}" id="${field.id}" class="req_f_type"/> <label>变量名:</label><input name="req_f_name_${field.id}" type="text" value="${field.fn}" /> <label>描述:</label><input name="req_f_desc_${field.id}" type="text" value="${field.desc}" /> <br/>
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
						<c:if test="${msgItem != null}">
							<c:forEach items="${msgItem.reqFields}" var="field">
								<label>类型:</label><input name="rsp_f_type_${field.id}" type="text" value="${field.ft}" id="${field.id}" class="req_f_type"/> <label>变量名:</label><input name="rsp_f_name_${field.id}" type="text" value="${field.fn}" /> <label>描述:</label><input name="rsp_f_desc_${field.id}" type="text" value="${field.desc}" /> <br/>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>

		</form>
	</div>


</body>
</html>
