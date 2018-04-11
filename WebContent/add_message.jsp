<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
			rc++;
			$(".req-body").append('<label>类型:</label><input name="req_f_type_'+rc+'" type="text" value="" id="'+ rc + '"/> <label>变量名:</label><input name="req_f_name_'+rc+'" type="text" value="" /> <label>描述:</label><input name="req_f_desc_'+rc+'" type="text" value="" /> <br/>');
		});
		// 添加返回字段
		var rc2 = 0;
		$("#add_rsp_btn").click(function() {
			rc2++;
			$(".rsp-body").append('<label>类型:</label><input name="rsp_f_type_'+rc2+'" type="text" value="" id="'+ rc2 + '"/> <label>变量名:</label><input name="rsp_f_name_'+rc2+'" type="text" value="" /> <label>描述:</label><input name="rsp_f_desc_'+rc2+'" type="text" value="" /> <br/>');
		});
		
		/** 消息号输入框改变事件  **/
		$('#req_id').bind('input propertychange', function() {
			var data = $(this).val();
			var f = data.substr(0,1);
			if (f == '1') {
				var rspId = data.replace(/1/, "5");
				$('#rsp_id').val(rspId);
			}
		});
	    
		// 提交表单
		 $("#submit_msg").click(function(){
			 var ok = validate();
			 if (ok) {
				 var data = $("form").serialize();     
				 $.ajax({
		                type: "POST",
		                url:"update_msg",
		                data:data,// 序列化表单值
		                async: false,
		                error: function(request) {
		                    alert("Connection error");
		                },
		                success: function(data) {
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
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/gen_msg", "root", "123456");
		String sql = "select * from msg_info";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
	%>
	
	
	<div>
		<form class="form-group" name="msg_form" id="msg_form">
			<div class="row ">
				 <div style="display: inline;float: left;margin-left: 20px;">
					<a class="btn" href="#" role="button" href="">添加消息</a>
				</div>
				<div style="display: inline;float: left;">
					<a class="btn" href="#" role="button" href="">添加广播</a>
				</div>
				<div style="display: inline;float: left;">
					<a class="btn" href="#" role="button" href="">添加结构体</a>
				</div>
			</div>

			<div class="row" style="margin-top: 10px">
				<div style="width: 350px;margin-left: 10px;">
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text">消息描述:</span>
						</div>
						<input type="text" id="msg_desc" name="msg_desc" class="form-control" aria-describedby="inputGroup-sizing-sm">
					</div>
				</div>
				<div style="width: 250px;margin-left: 20px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<button class="btn btn-outline-secondary" type="button">消息类型</button>
						</div>
						<select name="msg_type" class="custom-select" id="inputGroupSelect03">
							<option selected></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select>
					</div>
				</div>
			</div>

			<div class="row">
				<div style="width: 350px;margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">请求-消息号:</span>
						</div>
						<input type="text" name="req_id" id= "req_id" class="form-control" aria-describedby="basic-addon1">
					</div>
				</div>
				<div style="width: 350px;margin-left: 10px;">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">返回-消息号:</span>
						</div>
						<input type="text" name="rsp_id" id="rsp_id" class="form-control" aria-describedby="basic-addon1" readonly>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-8">
					<div class="form-group">
						<label for="exampleFormControlTextarea1">备注:</label>
						<textarea name="bz" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
					</div>
				</div>
			</div>
			
			<div class="row">
				<table class="table">
					<tbody class="req-body">
					<%
						int rc = 1;
						while(rs.next()) {
					%>
						
					<%
						}
					%>
					
					</tbody>
				</table>
			</div>

			<div class="row">
				<div class="col-8">
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
				<div class="col-8">
					<div class="alert alert-secondary" role="alert">
						<label>返回-消息体</label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<table class="table">
					<tbody class="rsp-body">
					
					</tbody>
				</table>
			</div>

		</form>
	</div>


</body>
</html>
