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
	/* 文档就绪行数  */
	$(document).ready(function() {
		// 提交表单
		 $("#submit_msg").click(function(){
			 var data = $("form").serialize();     
			 $.ajax({
	                type: "POST",
	                url:"add_cat",
	                data:data,// 序列化表单值
	                async: false,
	                error: function(request) {
	                    alert("Connection error");
	                },
	                success: function(data) {
	                    alert("类别提交成功!");
	                }
	         });
		});
	});
</script>
</head>

<body>
	<div style="width: 600px; margin-left: 20px;">
		<div class="row" style="padding-left: 5px;">
			<table class="table">
				<thead>
					<tr>
						<th>添加分类</th>
					</tr>
				</thead>
			</table>
		</div>

		<form class="form-group" name="cat_form" id="cat_form">
			<div class="row" style="padding-left: 5px;">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">分类名</span>
					</div>
					<input type="text" id="cat_name" name="cat_name" class="form-control" aria-describedby="basic-addon1">
				</div>
			</div>

			<div class="row" style="padding-left: 5px;">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<label class="input-group-text" for="inputGroupSelect01">分类类型</label>
					</div>
					<select class="custom-select" id="inputGroupSelect01" id="cat_type" name="cat_type">
						<option selected value="1">普通消息</option>
						<option value="2">结构体</option>
						<option value="3">广播</option>
					</select>
				</div>
			</div>

			<div class="row" style="padding-left: 5px;">
				<div style="margin: 0 auto; width: 200px;">
					<input type="button" id="submit_msg" value="提交" class="btn btn-outline-primary">
				</div>
			</div>
		</form>


	</div>

</body>
</html>
