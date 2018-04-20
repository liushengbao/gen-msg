<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.msg.mgr.MsgMgr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
	div.msg_left a {
		font-family:sans-serif;
		font-size:14px;
		color:#1E90FF;
	}
	div.msg_left p {
		font-family:sans-serif;
		font-size:13px;
		display: inline;
		color:#87CEEB;
	}
</style>
</head>

<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>
<script type="text/javascript">
	/* 文档就绪行数  */
	$(document).ready(function() {
		$(".msg_show").click(function() {
			var a_id=$(this).attr("id");
			var arr = a_id.split('_');
            var t = "#group_msg_"+arr[1];
            $(t).toggle();
            var h = "#h_"+arr[1];
            $(h).show();
            $(this).hide();
		});	
		$(".msg_hide").click(function() {
			var a_id=$(this).attr("id");
			var arr = a_id.split('_');
            var t = "#group_msg_"+arr[1];
            $(t).toggle();
            var h = "#a_"+arr[1];
            $(h).show();
            $(this).hide();
		});		
	});
</script>
<body>
	<div style="overflow: scroll;" class="msg_left">
		<table>
			<!-- 标头内容 -->
			<thead>
				<tr>
					<td style="width: 31px; padding: 5px 0px 3px 0;"></td>
					<td style="padding: 5px 0px 3px 0;"><p style="color:#696969;font-size:16px">分类名称</p></td>
				</tr>
			</thead>

			<!--显示分类数据-->
			<c:forEach items="${MsgMgr.getInstance().getCatItems()}" var="cat">
				<tbody id="group_${cat.msg_cat_id}">
					<tr>
						<td style="width: 31px; padding: 1px 0px 1px 0;"><a href="javascript:;" id="a_${cat.msg_cat_id}" class="msg_show">[+]</a><a href="javascript:;" id="h_${cat.msg_cat_id}" class="msg_hide" style="display: none;">[ - ]</a></td>
						<td style="width: 287px; padding: 1px 2px 1px 0;"><a href="javascript:;">${cat.msg_cat}</a>--<p>${cat.firstMsgName}</p>&nbsp<a href="">删除</a></td>
					</tr>
				</tbody>
			
				<tbody id="group_msg_${cat.msg_cat_id}" style="display: none;">
					<c:forEach items="${cat.items}" var="msg">
						<tr>
							<td style="padding:1px 0px 1px 0;">&nbsp;</td>
							<td colspan="2" style="padding:1px 0px 1px 0;">
				                <div>
				                    <a style="width:240px;width:220px;display:block;float:left;" id="" href="javascript:;" onclick="edit_msg(${msg.msg_id})">${msg.req_id}--${msg.msg_desc}</a>
				                </div>
	            			</td>
						</tr>
					</c:forEach>
				</tbody>	
		 </c:forEach>
		
		</table>

	</div>

</body>
</html>