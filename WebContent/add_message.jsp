<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<script src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>

<body>
	<div class="container">
		<form class="form-group">
			<div class="row ">
				<div class="col-1">
					<a class="btn btn-secondary" href="#" role="button" href="">添加消息</a>
				</div>
				<div class="col-1">
					<a class="btn btn-secondary" href="#" role="button" href="">添加广播</a>
				</div>
				<div class="col-1">
					<a class="btn btn-secondary" href="#" role="button" href="">添加结构体</a>
				</div>
			</div>

			<div class="row" style="margin-top: 10px">
				<div class="col-3">
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text">消息描述:</span>
						</div>
						<input type="text" class="form-control" aria-describedby="inputGroup-sizing-sm">
					</div>
				</div>
				<div class="col-4">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<button class="btn btn-outline-secondary" type="button">消息类型</button>
						</div>
						<select class="custom-select" id="inputGroupSelect03">
							<option selected>请选择消息类型...</option>
							<option value="1">One</option>
							<option value="2">Two</option>
							<option value="3">Three</option>
						</select>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-4">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">请求-消息号:</span>
						</div>
						<input type="text" class="form-control" aria-describedby="basic-addon1">
					</div>
				</div>
				<div class="col-4">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">返回-消息号:</span>
						</div>
						<input type="text" class="form-control" aria-describedby="basic-addon1">
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-8">
					<div class="form-group">
						<label for="exampleFormControlTextarea1">备注:</label>
						<textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
					</div>
				</div>
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
					<input type="button" value="↑添加-请求↑" class="btn btn-dark" onclick="document.body.insertAdjacentHTML('beforeEnd','<input type=text> ')">
					<input type="button" value="提交" class="btn btn-success"> 
					<input type="button" value="↓添加-返回↓" class="btn btn-dark" onclick="">
				</div>
			</div>
			
			<div class="row" style="margin-top: 15px">
				<div class="col-8">
					<div class="alert alert-secondary" role="alert">
						<label>返回-消息体</label>
					</div>
				</div>
			</div>

		</form>



	</div>


</body>

</html>
