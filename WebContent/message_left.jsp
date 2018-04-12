<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.msg.mgr.CacheMgr"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>

<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>
<script type="text/javascript">
	/* 文档就绪行数  */
	$(document).ready(function() {

		//添加分类	 
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
<body>
	<div style="overflow: scroll;">
		<table>
			<!-- 标头内容 -->
			<thead>
				<tr>
					<td style="width: 31px; padding: 5px 0px 3px 0;"></td>
					<td style="padding: 5px 0px 3px 0;">分类名称</td>
				</tr>
			</thead>

			<!--显示分类数据-->
			<tbody>
				<c:forEach items="${CacheMgr.getInstance().getMsgCats().values()}" var="cat">
					<tr>
						<td style="width: 31px; padding: 1px 0px 1px 0;"><a href="">[+]</a></td>
						<td style="width: 287px; padding: 1px 2px 1px 0;"><a href="">${cat.msg_cat}</a>&nbsp<a href="">删除</a></td>
					</tr>
				</c:forEach>
			</tbody>

		</table>

	</div>

</body>
</html>