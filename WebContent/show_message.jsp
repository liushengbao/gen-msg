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

</script>
<style type="text/css">
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	width: 100%;
	border-collapse: collapse;
}
#customers tr {
	border:1px solid #DDD;height:24px;line-height:24px;
}
#customers td {
	font-size: 1em;
}
</style>
</head>

<body>
	<%  
		
		String msgId = request.getParameter("req_id");//用request得到
		MsgItem msgItem = MsgMgr.getInstance().getMsgItem(Integer.valueOf(msgId));
	%>
	
	<c:set var="msgItem" value="<%=msgItem%>" />
	
	<div style="margin-left: 20px; width: 500px;">
	<c:if test="${msgItem != null}">
		<table id="customers">
		    <tbody>
			    <tr style="border:1px solid #DDD;height:24px;line-height:24px;">
			        <td colspan="4" style="color:#777;padding:2px;">消息号详情：</td>
			    </tr>
		 	</tbody>
			<tbody>
				<tr>
					<td>消息描述:${msgItem.msg_desc}</td>
					<td>消息归类:${msgItem.msg_cat_name}</td>
				</tr>
			</tbody>
			<tbody>
				<tr>
					<td>请求消息号:${msgItem.req_id}</td>
					<td>返回::${msgItem.rsp_id}</td>
				</tr>
		    </tbody>
		    <tbody>
				  <tr style="background-color:#F1F1F1;">
        			<td colspan="4" style="padding-left:8px;">备注</td>
    			  </tr>
    			  <tr>
					<td>:<c:if test="${msgItem.msg_note != null}">${msgItem.msg_note}</c:if></td>
				  </tr>
		    </tbody>
		    <tbody>
		     <tr style="border:1px solid #DDD;height:24px;line-height:24px;background-color:#F1F1F1;">
			        <td colspan="4" style="color:#777;padding:2px;">请求消息体：</td>
			 </tr>
	     	<c:forEach items="${msgItem.reqFields}" var="field">
	     		
	     		<tr>
					<td><label>类型:</label>${field.ft}</td>
					<td><label>变量名:</label>${field.fn}</td>
					<td><label>描述:</label>${field.desc}</td>
				</tr>
			</c:forEach>
		    </tbody>
		    
		    <tbody>
		    <tr style="border:1px solid #DDD;height:24px;line-height:24px;background-color:#F1F1F1;">
			        <td colspan="4" style="color:#777;padding:2px;">返回消息体：</td>
			 </tr>
	     	<c:forEach items="${msgItem.rspFields}" var="field">
	     		<tr>
					<td><label>类型:</label>${field.ft}</td>
					<td><label>变量名:</label>${field.fn}</td>
					<td><label>描述:</label>${field.desc}</td>
				</tr>
			</c:forEach>
		    </tbody>
		   
		</table>
	</c:if>
	</div>

</body>
</html>
